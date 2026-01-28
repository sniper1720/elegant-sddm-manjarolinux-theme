import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

import "Components"

Rectangle {
    id: root
    width: 640
    height: 480

    property color primaryColor: "#35bfa4"
    property color panelColor: "#800C0C0C"
    property color textColor: "white"
    property color errorColor: "red"
    property color successColor: "steelblue"

    property real baseFontSize: loginPanel.height / 22.5

    Repeater {
        model: screenModel
        Item {
            property variant geometry: screenModel.geometry(index)
            x: geometry.x; y: geometry.y; width: geometry.width; height:geometry.height
            
            Image {
                id: bg
                anchors.fill: parent
                source: Qt.resolvedUrl(config.background)
                fillMode: Image.PreserveAspectCrop
                onStatusChanged: {
                    if (status == Image.Error && source != Qt.resolvedUrl(config.defaultBackground)) {
                        source = Qt.resolvedUrl(config.defaultBackground)
                    }
                }
            }
            
            MultiEffect {
                anchors.fill: bg
                source: bg
                blurEnabled: true
                blurMax: 64
                blur: config.BlurStrength !== undefined ? config.BlurStrength : 1.0
            }
        }
    }

    property string layout: config.layout || "Side"

    Item {
        id: mainContainer
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height
        
        Image {
            id: manjarologo
            width: height * 3
            height: parent.height / 6
            anchors.centerIn: parent
            
            // Side Layout (Default/V1)
            property real sideDiffY: -4 * height / 2
            property real sideDiffX: +5.5 * height / 2
            
            // Center Layout (V2)
            property real centerDiffY: -3.5 * height / 2
            property real centerDiffX: -0.12 * height / 2
            
            anchors.verticalCenterOffset: root.layout === "Side" ? sideDiffY : centerDiffY
            anchors.horizontalCenterOffset: root.layout === "Side" ? sideDiffX : centerDiffX
            
            fillMode: Image.PreserveAspectFit
            source: "Assets/manjarolinux.svg"
        }

        LoginPanel {
            id: loginPanel
            anchors.centerIn: parent
            height: parent.height / 10 * 3
            width: height * 1.8
            
            // Side Layout (Default/V1) - Aligned under Logo
            property real sideDiffY: 0
            property real sideDiffX: +3.1 * height / 2 
            
            // Center Layout (V2)
            property real centerDiffY: 0
            property real centerDiffX: 0
            
            anchors.verticalCenterOffset: root.layout === "Side" ? sideDiffY : centerDiffY
            anchors.horizontalCenterOffset: root.layout === "Side" ? sideDiffX : centerDiffX
            
            primaryColor: root.primaryColor
            textColor: root.textColor
            errorColor: root.errorColor
            successColor: root.successColor
        }
    }
}
