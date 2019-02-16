Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621B01F453
	for <e@80x24.org>; Sat, 16 Feb 2019 03:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfBPDOw (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 22:14:52 -0500
Received: from [193.29.56.124] ([193.29.56.124]:36920 "EHLO iodev.co.uk"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfBPDOu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 22:14:50 -0500
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     git@vger.kernel.org
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        Ismael Luceno <ismael@iodev.co.uk>
Subject: [PATCH] git-gui: Implement color configuration
Date:   Sat, 16 Feb 2019 04:14:43 +0100
Message-Id: <20190216031443.9000-1-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 git-gui.sh     | 33 ++++++++++++++++++++++-----------
 lib/option.tcl | 16 ++++++++++++++++
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index e00d9a345294..3d7a2217f00c 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -903,6 +903,8 @@ set font_descs {
 }
 set default_config(gui.stageuntracked) ask
 set default_config(gui.displayuntracked) true
+set default_config(gui.foreground) black
+set default_config(gui.background) white
 
 ######################################################################
 ##
@@ -2004,7 +2006,7 @@ static unsigned char mask_bits[] = {
    0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f};
 }
 
-image create bitmap file_plain -background white -foreground black -data {
+image create bitmap file_plain -background [get_config gui.background] -foreground black -data {
 #define plain_width 14
 #define plain_height 15
 static unsigned char plain_bits[] = {
@@ -2013,7 +2015,7 @@ static unsigned char plain_bits[] = {
    0x02, 0x10, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
-image create bitmap file_mod -background white -foreground blue -data {
+image create bitmap file_mod -background [get_config gui.background] -foreground blue -data {
 #define mod_width 14
 #define mod_height 15
 static unsigned char mod_bits[] = {
@@ -2022,7 +2024,7 @@ static unsigned char mod_bits[] = {
    0xfa, 0x17, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
-image create bitmap file_fulltick -background white -foreground "#007000" -data {
+image create bitmap file_fulltick -background [get_config gui.background] -foreground "#007000" -data {
 #define file_fulltick_width 14
 #define file_fulltick_height 15
 static unsigned char file_fulltick_bits[] = {
@@ -2031,7 +2033,7 @@ static unsigned char file_fulltick_bits[] = {
    0x62, 0x10, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
-image create bitmap file_question -background white -foreground black -data {
+image create bitmap file_question -background [get_config gui.background] -foreground black -data {
 #define file_question_width 14
 #define file_question_height 15
 static unsigned char file_question_bits[] = {
@@ -2040,7 +2042,7 @@ static unsigned char file_question_bits[] = {
    0x62, 0x10, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
-image create bitmap file_removed -background white -foreground red -data {
+image create bitmap file_removed -background [get_config gui.background] -foreground red -data {
 #define file_removed_width 14
 #define file_removed_height 15
 static unsigned char file_removed_bits[] = {
@@ -2049,7 +2051,7 @@ static unsigned char file_removed_bits[] = {
    0x1a, 0x16, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
-image create bitmap file_merge -background white -foreground blue -data {
+image create bitmap file_merge -background [get_config gui.background] -foreground blue -data {
 #define file_merge_width 14
 #define file_merge_height 15
 static unsigned char file_merge_bits[] = {
@@ -2058,7 +2060,7 @@ static unsigned char file_merge_bits[] = {
    0xfa, 0x17, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
-image create bitmap file_statechange -background white -foreground green -data {
+image create bitmap file_statechange -background [get_config gui.background] -foreground green -data {
 #define file_statechange_width 14
 #define file_statechange_height 15
 static unsigned char file_statechange_bits[] = {
@@ -3187,7 +3189,9 @@ pack .vpane -anchor n -side top -fill both -expand 1
 textframe .vpane.files.workdir -height 100 -width 200
 tlabel .vpane.files.workdir.title -text [mc "Unstaged Changes"] \
 	-background lightsalmon -foreground black
-ttext $ui_workdir -background white -foreground black \
+ttext $ui_workdir \
+	-background [get_config gui.background] \
+	-foreground [get_config gui.foreground] \
 	-borderwidth 0 \
 	-width 20 -height 10 \
 	-wrap none \
@@ -3209,7 +3213,9 @@ textframe .vpane.files.index -height 100 -width 200
 tlabel .vpane.files.index.title \
 	-text [mc "Staged Changes (Will Commit)"] \
 	-background lightgreen -foreground black
-ttext $ui_index -background white -foreground black \
+ttext $ui_index \
+	-background [get_config gui.background] \
+	-foreground [get_config gui.foreground] \
 	-borderwidth 0 \
 	-width 20 -height 10 \
 	-wrap none \
@@ -3353,7 +3359,10 @@ if {![is_enabled nocommit]} {
 }
 
 textframe .vpane.lower.commarea.buffer.frame
-ttext $ui_comm -background white -foreground black \
+ttext $ui_comm \
+	-background [get_config gui.background] \
+	-foreground [get_config gui.foreground] \
+	-insertbackground [get_config gui.foreground] \
 	-borderwidth 1 \
 	-undo true \
 	-maxundo 20 \
@@ -3470,7 +3479,9 @@ bind_button3 .vpane.lower.diff.header.path "tk_popup $ctxm %X %Y"
 #
 textframe .vpane.lower.diff.body
 set ui_diff .vpane.lower.diff.body.t
-ttext $ui_diff -background white -foreground black \
+ttext $ui_diff \
+	-background [get_config gui.background] \
+	-foreground [get_config gui.foreground] \
 	-borderwidth 0 \
 	-width 80 -height 5 -wrap none \
 	-font font_diff \
diff --git a/lib/option.tcl b/lib/option.tcl
index e43971bfa3e0..fd7ac1c4f3d9 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -88,6 +88,14 @@ proc save_config {} {
 	}
 }
 
+proc choose_color {title varname} {
+	upvar 1 $varname var
+	set color [tk_chooseColor -title $title -initialcolor $var]
+	if {$color ne ""} {
+		set var $color
+	}
+}
+
 proc do_options {} {
 	global repo_config global_config font_descs
 	global repo_config_new global_config_new
@@ -162,6 +170,8 @@ proc do_options {} {
 		{s gui.stageuntracked {mc "Staging of untracked files"} {list "yes" "no" "ask"}}
 		{b gui.displayuntracked {mc "Show untracked files"}}
 		{i-1..99 gui.tabsize {mc "Tab spacing"}}
+		{C gui.foreground {mc "Foreground Color"}}
+		{C gui.background {mc "Background Color"}}
 		} {
 		set type [lindex $option 0]
 		set name [lindex $option 1]
@@ -192,6 +202,7 @@ proc do_options {} {
 				pack $w.$f.$optid -side top -anchor w -fill x
 			}
 			c -
+			C -
 			t {
 				${NS}::frame $w.$f.$optid
 				${NS}::label $w.$f.$optid.l -text [mc "%s:" $text]
@@ -211,6 +222,11 @@ proc do_options {} {
 						-command [list popup_btn_menu \
 							$w.$f.$optid.m $w.$f.$optid.b]
 					pack $w.$f.$optid.b -side left -anchor w
+				} elseif {$type eq {C}} {
+					${NS}::button $w.$f.$optid.b \
+						-text [mc "Change"] \
+						-command [list choose_color $text ${f}_config_new($name)]
+					pack $w.$f.$optid.b -side left -anchor w
 				}
 				pack $w.$f.$optid -side top -anchor w -fill x
 			}
-- 
2.20.1

