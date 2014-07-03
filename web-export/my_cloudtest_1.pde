import processing.opengl.*;

float xstart, xnoise, ystart, ynoise, zstart, znoise;
int cubeSize = 100;
int w = 400;
int l = 300;
int xpos = (w - cubeSize)/2;
int ypos = (l - cubeSize)/2;
int zpos = 50; //positive: close, negative: far
float zoomNoiseSeed;
float maxRot = PI/300;
float maxTrans = 10;

void setup() {
  size(w, l, P3D);
  background(0);
  noStroke();

  xstart = random(10);
  ystart = random(10);
  zstart = random(10);

  zoomNoiseSeed = random(10);
}

float getZoom(float zn) {
  return (noise(zn)*3*cubeSize) - (2*cubeSize);
}

void draw() {
  background(0);
  xstart += 0.01;
  ystart += 0.01;
  zstart += 0.01;

  xnoise = xstart;
  ynoise = ystart;
  znoise = zstart;


  zoomNoiseSeed += 0.02;
  translate(0, 0, getZoom(zoomNoiseSeed));
  randomRotate(zoomNoiseSeed);
  randomTranslate(zoomNoiseSeed);

  for (int z=zpos; z<=zpos + cubeSize; z+= 5) {
    znoise += 0.1;
    ynoise = ystart;
    for (int y=ypos; y<=ypos + cubeSize; y+= 5) {
      ynoise += 0.1;
      xnoise = xstart;
      for (int x=xpos; x<=xpos + cubeSize; x+=5) {
        xnoise += 0.1;
        drawPoint(x, y, z, noise(xnoise, ynoise, znoise));
      }
    }
  }
}

void randomRotate(float n){
  float p = random(3);
  float r = noise(n)*maxRot;
  if(p > 2){
    rotateX(r);
  } else if(p>1){
    rotateY(r);
  }else {
    rotateZ(r);
  }
}

void randomTranslate(float n){
    float p = random(3);
  float r = noise(n)*maxTrans;
  if(p > 2){
    translate(r, 0, 0);
  } else if(p>1){
    translate(0, r, 0);
  }else {
    translate(0, 0, r);
  }
}

void drawPoint(float x, float y, float z, float n) {
  pushMatrix();
  translate(x, y, z);
  float sphereSize = 5*n;
  float alph = 150*n*n*n;
  fill(150, alph);
  box(sphereSize);
  popMatrix();
}

void keyPressed(){
  if(key == ENTER){
    saveFrame("ShakeCube###.jpg");
  }
}

