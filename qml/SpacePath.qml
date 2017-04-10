﻿import QtQuick 2.0
import QtCanvas3D 1.1
import QtQuick.Controls 1.4

import "SpacePath.js" as GLcode
//import "square.js" as GLcode

Item {
    id: windowContainer
    width: 1400
    height: 900
    visible: true

    MouseArea {
        id: mouseListener
        anchors.fill: parent
        property int lpx: 0
        property int lpy: 0
        property int mousex: 1
        property int mousey: 1
//        onClicked: {
//            console.log("clicked ==> " + mouseListener.mouseX + " ,  " + mouseListener.mouseY)
//        }
        onMouseXChanged: {
            if(mouseListener.pressed) {
//                console.log("clicked x ==> " + mouseListener.mouseX + " ,  " + mouseListener.mouseY + "  --> " + mouseListener.mousex++);
                mouseDraged();
                lpx = mouseListener.mouseX
            }
        }
        onMouseYChanged: {
            if(mouseListener.pressed) {
//                console.log("clicked y ==> " + mouseListener.mouseX + " ,  " + mouseListener.mouseY + "  --> " + mouseListener.mousey++);
                mouseDraged();
                lpy = mouseListener.mouseY;
            }
        }

//        onPressAndHold: {
//            console.log("pressed and hold ==> " + mouseListener.mouseX + " ,  " + mouseListener.mouseY)
//        }
        /** onPressed and onReleased 实现拖拽操作 */
        onPressed: {
//            console.log("pressed  ==> " + mouseListener.mouseX + " ,  " + mouseListener.mouseY)
            lpx = mouseListener.mouseX;
            lpy = mouseListener.mouseY;
        }

        onWheel: {
            canvas3d.cdis -= 0.3 * wheel.angleDelta.y / 120
        }

        onDoubleClicked: {

        }
    }

    function mouseDraged() {
        var uoffset = (mouseListener.mouseY - mouseListener.lpy) / windowContainer.height;
        var voffset = (mouseListener.mouseX - mouseListener.lpx) / windowContainer.width;
        var u = canvas3d.ctheta;
        var v = canvas3d.cbeta;
//            console.log("released ==> " + uoffset + " ,  " + voffset);
        u += uoffset;
        v -= voffset;
        if( u < 0.001 ) {
            u = 0.001;
        } else if ( u > 0.999) {
            u = 0.999;
        }


        v = (v * 100) % 100 / 100;
//            console.log("released ==> " + u + " ,  " + v);
//        cameraThetaContainer.sliderValue = u;
//        cameraBetaContainer.sliderValue  = v;
        canvas3d.ctheta = u;
        canvas3d.cbeta  = v;
        rotateCamera();
    }

    Label {
        z: 1
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 80
        width: 30
        height: 20
        text: "FPS: " + canvas3d.fps
        font.pointSize: 20
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: textureSource
        z: 1
        color: "#F9F9F9"
        width: 220
        height: parent.height
        border.color: "blue"
        border.width: 1
        layer.enabled: true
        layer.smooth: true

        /*
        Label {
            id: xPosLabel
            anchors.leftMargin: 5
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 5
            height: 20
            text: "X POSITION:"
        }
        Rectangle {
            border.color: "black"
            anchors.top: parent.top
            anchors.leftMargin: 5
            anchors.left: xPosLabel.right
            width: 50
            height: 20
            TextInput {
                id: xPosInput
                font.pointSize: 16
                anchors.fill: parent
                text: canvas3d.xPos
                validator: DoubleValidator{bottom: -300; top: 300;}
            }
        }
        Label {
            id: yPosLabel
            anchors.leftMargin: 5
            anchors.left: parent.left
            anchors.top: xPosLabel.bottom
            anchors.topMargin: 5
            height: 20
            text: "Y POSITION:"
        }
        Rectangle {
            border.color: "black"
            anchors.left: yPosLabel.right
            anchors.leftMargin: 5
            anchors.top: xPosLabel.bottom
            width: 50
            height: 20
            TextInput {
                id: yPosInput
                font.pointSize: 16
                anchors.fill: parent
                text: canvas3d.yPos
                validator: DoubleValidator{bottom: -300; top: 300;}
            }
        }
        Label {
            id: zPosLabel
            anchors.leftMargin: 5
            anchors.left: parent.left
            anchors.top: yPosLabel.bottom
            anchors.topMargin: 5
            height: 20
            text: "Z POSITION:"
        }
        Rectangle {
            border.color: "black"
            anchors.left: zPosLabel.right
            anchors.leftMargin: 5
            anchors.top: yPosLabel.bottom
            width: 50
            height: 20
            TextInput {
                id: zPosInput
                font.pointSize: 16
                anchors.fill: parent
                text: canvas3d.zPos
                validator: DoubleValidator{bottom: -300; top: 300;}
            }
        }

        Label {
            id: xRotLabel
            anchors.leftMargin: 5
            anchors.left: parent.left
            anchors.top: zPosLabel.bottom
            anchors.topMargin: 5
            height: 20
            text: "X ROTATION:"
        }
        Rectangle {
            border.color: "black"
            anchors.top: zPosLabel.bottom
            anchors.leftMargin: 5
            anchors.left: xRotLabel.right
            width: 50
            height: 20
            TextInput {
                id: xRotInput
                font.pointSize: 16
                anchors.fill: parent
                text: canvas3d.xRotAnim
                validator: DoubleValidator{bottom: -360; top: 360;}
            }
        }
        Label {
            id: yRotLabel
            anchors.leftMargin: 5
            anchors.left: parent.left
            anchors.top: xRotLabel.bottom
            anchors.topMargin: 5
            height: 20
            text: "Y ROTATION:"
        }
        Rectangle {
            border.color: "black"
            anchors.left: yRotLabel.right
            anchors.leftMargin: 5
            anchors.top: xRotLabel.bottom
            width: 50
            height: 20
            TextInput {
                id: yRotInput
                font.pointSize: 16
                anchors.fill: parent
                text: canvas3d.yRotAnim
                validator: DoubleValidator{bottom: -360; top: 360;}
            }
        }
        Label {
            id: zRotLabel
            anchors.leftMargin: 5
            anchors.left: parent.left
            anchors.top: yRotLabel.bottom
            anchors.topMargin: 5
            height: 20
            text: "Z ROTATION:"
        }
        Rectangle {
            border.color: "black"
            anchors.left: zRotLabel.right
            anchors.leftMargin: 5
            anchors.top: yRotLabel.bottom
            width: 50
            height: 20
            TextInput {
                id: zRotInput
                font.pointSize: 16
                anchors.fill: parent
                text: canvas3d.zRotAnim
                validator: DoubleValidator{bottom: -360; top: 360;}
            }
        }
        */

        /** xyz controls camera's position **/
        MySlider {
            id: xCameraContainer
            labelText: "X CAMARA POSITION: "
            height: 50
            width: parent.width
            visible: false
            anchors.left: parent.left
            anchors.top: parent.top
            sliderMaxValue: 30.0
            sliderMinValue: -30.0
            sliderValue: canvas3d.cx
            sliderWidth: parent.width
            onSliderValueChanged: {
                if( pressed )
                    canvas3d.cx = sliderValue.toFixed(2)
            }
        }

        MySlider {
            id: yCameraContainer
            labelText: "Y CAMARA POSITION: "
            height: 50
            width: parent.width
            visible: false
            anchors.left: parent.left
            anchors.top: xCameraContainer.bottom
            sliderMaxValue: 30.0
            sliderMinValue: -30.0
            sliderValue: canvas3d.cy
            sliderWidth: parent.width
            onSliderValueChanged: {
                if( pressed )
                    canvas3d.cy = sliderValue.toFixed(2)
            }
        }

        MySlider {
            id: zCameraContainer
            labelText: "Z CAMARA POSITION: "
            height: 50
            width: parent.width
            visible: false
            anchors.left: parent.left
            anchors.top: yCameraContainer.bottom
            sliderMaxValue: 30.0
            sliderMinValue: -30.0
            sliderValue: canvas3d.cz
            sliderWidth: parent.width
            onSliderValueChanged: {
                if( pressed )
                    canvas3d.cz = sliderValue.toFixed(2)
            }
        }

        /** theta beta radius controls camera's position**/
        MySlider {
            id: cameraThetaContainer
            labelText: "CAMARA THETA: "
            height: 50
            width: parent.width
//            visible: false
            anchors.left: parent.left
            anchors.top: parent.top
            sliderMaxValue: 0.999
            sliderMinValue: 0.001
            sliderValue: canvas3d.ctheta
            sliderWidth: parent.width
            onSliderValueChanged: {
                if( pressed )
                    canvas3d.ctheta = sliderValue
                rotateCamera()
            }
        }

        MySlider {
            id: cameraBetaContainer
            labelText: "CAMARA BETA: "
            height: 50
            width: parent.width
//            visible: false
            anchors.left: parent.left
            anchors.top: cameraThetaContainer.bottom
            sliderMaxValue: 0.999
            sliderMinValue: -0.999
            sliderValue: canvas3d.cbeta
            sliderWidth: parent.width
            onSliderValueChanged: {
                if( pressed )
                    canvas3d.cbeta = sliderValue
                rotateCamera()
            }
        }

        MySlider {
            id: cameraDisContainer
            labelText: "DISTANCE: "
            height: 50
            width: parent.width
            anchors.left: parent.left
            anchors.top: cameraBetaContainer.bottom
//            anchors.top: parent.top
            sliderMaxValue: 30.0
            sliderMinValue: 0.0
            sliderValue: canvas3d.cdis
            sliderWidth: parent.width
            onSliderValueChanged: {
                if( pressed )
                    canvas3d.cdis = sliderValue
                rotateCamera()
            }
        }

        MySlider {
            id: ballRadiusContainer
            labelText: "BALL RADIUS: "
            height: 50
            width: parent.width
            anchors.left: parent.left
            anchors.top: cameraDisContainer.bottom
//            anchors.top: parent.top
            sliderMaxValue: 10.0
            sliderMinValue: 2.0
            sliderValue: canvas3d.radius
            sliderWidth: parent.width
            onSliderValueChanged: {
                if( pressed )
                    canvas3d.radius = sliderValue
//                console.log(canvas3d.radius)
            }
        }



        MySlider {
            id: lineWidthContainer
            labelText: "LINE WIDTH: "
            height: 50
            width: parent.width
            anchors.left: parent.left
            anchors.top: ballRadiusContainer.bottom
            sliderMaxValue: 10.0
            sliderMinValue: 1.0
            sliderValue: canvas3d.line_width
            sliderWidth: parent.width
            onSliderValueChanged: {
                if( pressed )
                    canvas3d.line_width = sliderValue
            }
        }

        MySlider {
            id: pointSizeContainer
            labelText: "POINT SIZE: "
            height: 50
            width: parent.width
            anchors.left: parent.left
            anchors.top: lineWidthContainer.bottom
            sliderMaxValue: 1.0
            sliderMinValue: 0.05
            sliderValue: canvas3d.point_size
            sliderWidth: parent.width
            onSliderValueChanged: {
                if( pressed )
                    canvas3d.point_size = sliderValue
            }
        }

        MySlider {
            id: pathSizeContainer
            labelText: "PATH WIDTH SIZE: "
            height: 50
            width: parent.width
            anchors.left: parent.left
            anchors.top: pointSizeContainer.bottom
            sliderMaxValue: 1.0
            sliderMinValue: 0.1
            sliderValue: canvas3d.path_size
            sliderWidth: parent.width
            onSliderValueChanged: {
                if( pressed )
                    canvas3d.path_size = sliderValue
            }
        }

        Rectangle {
            id: modeSelection
            anchors.top: pathSizeContainer.bottom
            anchors.left: parent.left
            height: 25
            RadioButton {
                id: lineDrawMode
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 5
                text: "line"
                checked: false
                width: 20
                height: 20
                onClicked: {
                    selectRB(lineDrawMode);
                }
            }
            RadioButton {
                id: surfaceDrawMode
                anchors.top: parent.top
                anchors.left: lineDrawMode.right
                anchors.leftMargin: 30
                text: "surface"
                checked: false
                width: 20
                height: 20
                onClicked: {
                    selectRB(surfaceDrawMode);
                }
            }
            RadioButton {
                id: lessLineDrawMode
                anchors.top: parent.top
                anchors.left: surfaceDrawMode.right
                anchors.leftMargin: 46
                text: "lessLine"
                checked: false
                width: 20
                height: 20
                onClicked: {
                    selectRB(lessLineDrawMode);
                }
            }

        }

        MySlider {
            id: pitchContainer
            labelText: "PITCH: "
            height: 50
            width: parent.width
            anchors.left: parent.left
            anchors.top: modeSelection.bottom
            sliderMaxValue: 180
            sliderMinValue: -180
            sliderValue: canvas3d.pitch
            sliderWidth: parent.width
            onSliderValueChanged: {
                if( pressed )
                    canvas3d.pitch = sliderValue
            }
        }

        MySlider {
            id: headingContainer
            labelText: "HEADING: "
            height: 50
            width: parent.width
            anchors.top: pitchContainer.bottom
            anchors.left: parent.left
            sliderMaxValue: 360
            sliderMinValue: 0
            sliderValue: canvas3d.heading
            sliderWidth: parent.width
//            inputText: canvas3d.heading
            onSliderValueChanged: {
                if( pressed )
                    canvas3d.heading = sliderValue
            }
        }

        MySlider {
            id: vectorContainer
            labelText: "VECTOR LENGTH: "
            height: 50
            width: parent.width
            anchors.top: headingContainer.bottom
            anchors.left: parent.left
            sliderMaxValue: 20
            sliderMinValue: 0.5
            sliderValue: canvas3d.vector_length
            sliderWidth: parent.width
//            inputText: canvas3d.heading
            onSliderValueChanged: {
                if( pressed )
                    canvas3d.vector_length = sliderValue
            }
        }

        Rectangle {
            id: checkBoxContainer
            width: parent.width
            height: 25
            anchors.left: parent.left
            anchors.top: vectorContainer.bottom
            color: "transparent"

            CheckBox {
                id: drawPathBox
                height: parent.height
                text: "drawPath"
                anchors.left: parent.left
                checked: true
                onCheckedChanged: {
                    if(checked) {
                        canvas3d.enable_path = true;
                    } else {
                        canvas3d.enable_path = false;
                    }
                }
            }
            CheckBox {
                id: cubeBox
                height: parent.height
                text: "drawCube"
                anchors.left: drawPathBox.right
                checked: true
                onCheckedChanged: {
                    if(checked) {
                        canvas3d.enable_cube = true;
                    } else {
                        canvas3d.enable_cube = false;
                    }
                }
            }
            CheckBox {
                id: axisBox
                height: parent.height
                text: "angle-axis"
                checked: true
                anchors.left: cubeBox.right
                onCheckedChanged: {
                    if(checked) {
                        cameraBetaContainer.visible = true;
                        cameraDisContainer.visible  = true;
                        cameraThetaContainer.visible= true;

                        xCameraContainer.visible    = false;
                        yCameraContainer.visible    = false;
                        zCameraContainer.visible    = false;
                        
                    } else {
                        cameraBetaContainer.visible = false;
                        cameraDisContainer.visible  = false;
                        cameraThetaContainer.visible= false;

                        xCameraContainer.visible    = true;
                        yCameraContainer.visible    = true;
                        zCameraContainer.visible    = true;
                    }
                }
            }
        }

        Button {
            id: setButton
            width: 50
            height: 20
            text: "set"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -50
            anchors.top: checkBoxContainer.bottom
            onClicked: {
//                canvas3d.xRotAnim = parseFloat(xRotInput.text)
//                canvas3d.yRotAnim = parseFloat(yRotInput.text)
//                canvas3d.zRotAnim = parseFloat(zRotInput.text)

//                canvas3d.xPos = parseFloat(xPosInput.text)
//                canvas3d.yPos = parseFloat(yPosInput.text)
//                canvas3d.zPos = parseFloat(zPosInput.text)

//                canvas3d.cx = parseFloat(xCameraContainer.text)
//                canvas3d.cy = parseFloat(yCameraContainer.text)
//                canvas3d.cz = parseFloat(zCameraContainer.text)

                if( axisBox.checked ) {
                    canvas3d.ctheta = parseFloat(cameraThetaContainer.text)
                    canvas3d.cbeta  = parseFloat(cameraBetaContainer.text)
                    canvas3d.cdis   = parseFloat(cameraDisContainer.text)
//                    console.log( "checked " );
                } else {
                    canvas3d.cx = parseFloat(xCameraContainer.text)
                    canvas3d.cy = parseFloat(yCameraContainer.text)
                    canvas3d.cz = parseFloat(zCameraContainer.text)
                }

                canvas3d.pitch = parseFloat(pitchContainer.text)
                canvas3d.heading = parseFloat(headingContainer.text)
                canvas3d.cdis = parseFloat(cameraDisContainer.text)
                canvas3d.radius = parseFloat(ballRadiusContainer.text)
                canvas3d.line_width = parseFloat(lineWidthContainer.text)
                canvas3d.point_size = parseFloat(pointSizeContainer.text)
                canvas3d.vector_length = parseFloat(vectorContainer.text)

            }
        }

        Button {
            id: resetButton
            width: 70
            height: 20
            text: "reset"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 20
            anchors.top: checkBoxContainer.bottom
            onClicked: {
                canvas3d.ctheta = 0.65
                canvas3d.cbeta  = 0.5

                rotateCamera();
//                canvas3d.pitchOffset = canvas3d.pitch
                canvas3d.headingOffset = canvas3d.heading
                var angle = GLcode.calcAngle(canvas3d.pitch, 0);
                var u = angle[0], v = angle[1];
                GLcode.resetPath(u, v, canvas3d.vector_length);
            }
        }
    }
    function selectRB(rb) {
        lineDrawMode.checked = false;
        surfaceDrawMode.checked = false;
        lessLineDrawMode.checked = false;
        rb.checked = true;
//        console.log(rb.text);
        canvas3d.drawMode = rb.text;
    }

    function rotateCamera() {
        var pos = GLcode.calcVertex(1-canvas3d.ctheta, canvas3d.cbeta, canvas3d.cdis)
        canvas3d.cx = pos[0]
        canvas3d.cy = pos[1]
        canvas3d.cz = pos[2]

    }

    Canvas3D {
        id: canvas3d
        anchors.fill: parent
        focus: true
        property double xRotAnim: 0
        property double yRotAnim: 0
        property double zRotAnim: 0
        property double xPos: 0
        property double yPos: 0
        property double zPos: 0
        // camera position
        // distance between camera's position and origin position
        property double cdis: 15
        property double ctheta: 0.5
        property double cbeta: 0.0
        property double cx: 15
        property double cy: 0.0
        property double cz: 0.0
//        property int gap: 10
        /* 只需要航向角和俯仰角即可确定传感器方向向量(默认向量长度为球体半径, 4) */
        property double heading: 0
        property double pitch: 0
        property double roll: 0
        property double headingOffset: 0
//        property double pitchOffset: 0
        property double radius: 4
        property double vector_length: 4
        property bool enable_path: true
        property bool enable_cube: true
        property double line_width: 1.0
        property double point_size: 0.15
        property double path_size:  0.35
        property string drawMode: "line"
        property var args: {
                    "heading" : heading, "pitch": pitch, "roll": roll,
                    "headingOffset": headingOffset, "radius": radius,
                    "vector_length": vector_length, "enable_path": enable_path,
                    "enable_cube": enable_cube, "line_width": line_width,
                    "point_size": point_size, "path_size": path_size
        }
        property bool isRunning: true
        // 渲染节点就绪时，进行初始化时触发
        onInitializeGL: {
//            selectRB(lessLineDrawMode)
            selectRB(lineDrawMode);
            GLcode.initializeGL(canvas3d);
        }

        // 当 canvas3d 准备好绘制下一帧时触发
        onPaintGL: {
            GLcode.paintGL(canvas3d)
        }

        onResizeGL: {
            GLcode.resizeGL(canvas3d)
        }
    }

}
