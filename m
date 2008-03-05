From: "Philipp A. Hartmann" <ph@sorgh.de>
Subject: [PATCH] git-gui: if a background colour is set, set foreground colour as well
Date: Wed,  5 Mar 2008 17:54:22 +0100
Message-ID: <1204736062-11659-1-git-send-email-ph@sorgh.de>
Cc: git@vger.kernel.org, "Philipp A. Hartmann" <ph@sorgh.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 18:20:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWxGa-0004G8-Kn
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 18:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303AbYCERSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 12:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756299AbYCERSS
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 12:18:18 -0500
Received: from mail.sorgh.de ([88.198.99.83]:3245 "EHLO smtp.sorgh.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681AbYCERSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 12:18:16 -0500
X-Greylist: delayed 1535 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Mar 2008 12:18:16 EST
Received: from localhost (unknown [77.183.56.53])
	by smtp.sorgh.de (Postfix) with ESMTP id 45CA620053;
	Wed,  5 Mar 2008 17:52:37 +0100 (CET)
X-Mailer: git-send-email 1.5.4.3.447.gc95b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76245>

In several places, only the background colour is set to an explicit
value, sometimes even "white".  This does not work well with dark
colour themes.

This patch tries to set the foreground colour to "black" in those
situations, where an explicit background colour is set without defining
any foreground colour.

Signed-off-by: Philipp A. Hartmann <ph@sorgh.de>
---

   Many GUI applications have "problems" with dark desktop themes,
   because frequently only the background _or_ the foreground colours
   are set to fixed values.  This results in barely readable parts of
   the user interface when using bright-on-dark colour schemes.

   The effects within git-gui can be seen e.g. on the following
   screenshots (with and without this patch):

     http://sorgh.de/tmp/git-gui/master.png
     http://sorgh.de/tmp/git-gui/fg-colour-fix.png

   This patch is against f15b75855fe15ac54adc4908f65e8a7572d47c9f
   from git://repo.or.cz/git-gui.git - I could of course provide
   one against git.git itself, if required.

   Thanks for your time!

 git-gui.sh          |   19 +++++++++++++------
 lib/blame.tcl       |   25 ++++++++++++++++++++-----
 lib/browser.tcl     |    3 ++-
 lib/choose_font.tcl |    2 ++
 lib/console.tcl     |   10 +++++++---
 lib/error.tcl       |    4 +++-
 6 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 238a239..8741443 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2289,8 +2289,9 @@ pack .vpane -anchor n -side top -fill both -expand 1
 #
 frame .vpane.files.index -height 100 -width 200
 label .vpane.files.index.title -text [mc "Staged Changes (Will Commit)"] \
-	-background lightgreen
-text $ui_index -background white -borderwidth 0 \
+	-background lightgreen -foreground black
+text $ui_index -background white -foreground black \
+	-borderwidth 0 \
 	-width 20 -height 10 \
 	-wrap none \
 	-cursor $cursor_ptr \
@@ -2308,8 +2309,9 @@ pack $ui_index -side left -fill both -expand 1
 #
 frame .vpane.files.workdir -height 100 -width 200
 label .vpane.files.workdir.title -text [mc "Unstaged Changes"] \
-	-background lightsalmon
-text $ui_workdir -background white -borderwidth 0 \
+	-background lightsalmon -foreground black
+text $ui_workdir -background white -foreground black \
+	-borderwidth 0 \
 	-width 20 -height 10 \
 	-wrap none \
 	-cursor $cursor_ptr \
@@ -2416,7 +2418,8 @@ pack $ui_coml -side left -fill x
 pack .vpane.lower.commarea.buffer.header.amend -side right
 pack .vpane.lower.commarea.buffer.header.new -side right
 
-text $ui_comm -background white -borderwidth 1 \
+text $ui_comm -background white -foreground black \
+	-borderwidth 1 \
 	-undo true \
 	-maxundo 20 \
 	-autoseparators true \
@@ -2493,15 +2496,18 @@ trace add variable current_diff_path write trace_current_diff_path
 frame .vpane.lower.diff.header -background gold
 label .vpane.lower.diff.header.status \
 	-background gold \
+	-foreground black \
 	-width $max_status_desc \
 	-anchor w \
 	-justify left
 label .vpane.lower.diff.header.file \
 	-background gold \
+	-foreground black \
 	-anchor w \
 	-justify left
 label .vpane.lower.diff.header.path \
 	-background gold \
+	-foreground black \
 	-anchor w \
 	-justify left
 pack .vpane.lower.diff.header.status -side left
@@ -2525,7 +2531,8 @@ bind_button3 .vpane.lower.diff.header.path "tk_popup $ctxm %X %Y"
 #
 frame .vpane.lower.diff.body
 set ui_diff .vpane.lower.diff.body.t
-text $ui_diff -background white -borderwidth 0 \
+text $ui_diff -background white -foreground black \
+	-borderwidth 0 \
 	-width 80 -height 15 -wrap none \
 	-font font_diff \
 	-xscrollcommand {.vpane.lower.diff.body.sbx set} \
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 00ecf21..92fac1b 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -80,6 +80,7 @@ constructor new {i_commit i_path} {
 	label $w.header.commit_l \
 		-text [mc "Commit:"] \
 		-background gold \
+		-foreground black \
 		-anchor w \
 		-justify left
 	set w_back $w.header.commit_b
@@ -89,6 +90,7 @@ constructor new {i_commit i_path} {
 		-relief flat \
 		-state disabled \
 		-background gold \
+		-foreground black \
 		-activebackground gold
 	bind $w_back <Button-1> "
 		if {\[$w_back cget -state\] eq {normal}} {
@@ -98,16 +100,19 @@ constructor new {i_commit i_path} {
 	label $w.header.commit \
 		-textvariable @commit \
 		-background gold \
+		-foreground black \
 		-anchor w \
 		-justify left
 	label $w.header.path_l \
 		-text [mc "File:"] \
 		-background gold \
+		-foreground black \
 		-anchor w \
 		-justify left
 	set w_path $w.header.path
 	label $w_path \
 		-background gold \
+		-foreground black \
 		-anchor w \
 		-justify left
 	pack $w.header.commit_l -side left
@@ -135,7 +140,9 @@ constructor new {i_commit i_path} {
 		-takefocus 0 \
 		-highlightthickness 0 \
 		-padx 0 -pady 0 \
-		-background white -borderwidth 0 \
+		-background white \
+		-foreground black \
+		-borderwidth 0 \
 		-state disabled \
 		-wrap none \
 		-height 40 \
@@ -148,7 +155,9 @@ constructor new {i_commit i_path} {
 		-takefocus 0 \
 		-highlightthickness 0 \
 		-padx 0 -pady 0 \
-		-background white -borderwidth 0 \
+		-background white \
+		-foreground black \
+		-borderwidth 0 \
 		-state disabled \
 		-wrap none \
 		-height 40 \
@@ -166,7 +175,9 @@ constructor new {i_commit i_path} {
 		-takefocus 0 \
 		-highlightthickness 0 \
 		-padx 0 -pady 0 \
-		-background white -borderwidth 0 \
+		-background white \
+		-foreground black \
+		-borderwidth 0 \
 		-state disabled \
 		-wrap none \
 		-height 40 \
@@ -184,7 +195,9 @@ constructor new {i_commit i_path} {
 		-takefocus 0 \
 		-highlightthickness 0 \
 		-padx 0 -pady 0 \
-		-background white -borderwidth 0 \
+		-background white \
+		-foreground black \
+		-borderwidth 0 \
 		-state disabled \
 		-wrap none \
 		-height 40 \
@@ -213,7 +226,9 @@ constructor new {i_commit i_path} {
 
 	set w_cviewer $w.file_pane.cm.t
 	text $w_cviewer \
-		-background white -borderwidth 0 \
+		-background white \
+		-foreground black \
+		-borderwidth 0 \
 		-state disabled \
 		-wrap none \
 		-height 10 \
diff --git a/lib/browser.tcl b/lib/browser.tcl
index 53d5a62..ab470d1 100644
--- a/lib/browser.tcl
+++ b/lib/browser.tcl
@@ -39,7 +39,8 @@ constructor new {commit {path {}}} {
 
 	frame $w.list
 	set w_list $w.list.l
-	text $w_list -background white -borderwidth 0 \
+	text $w_list -background white -foreground black \
+		-borderwidth 0 \
 		-cursor $cursor_ptr \
 		-state disabled \
 		-wrap none \
diff --git a/lib/choose_font.tcl b/lib/choose_font.tcl
index 0c4051b..56443b0 100644
--- a/lib/choose_font.tcl
+++ b/lib/choose_font.tcl
@@ -55,6 +55,7 @@ constructor pick {path title a_family a_size} {
 	set w_family $w.inner.family.v
 	text $w_family \
 		-background white \
+		-foreground black \
 		-borderwidth 1 \
 		-relief sunken \
 		-cursor $::cursor_ptr \
@@ -92,6 +93,7 @@ constructor pick {path title a_family a_size} {
 	set w_example $w.example.t
 	text $w_example \
 		-background white \
+		-foreground black \
 		-borderwidth 1 \
 		-relief sunken \
 		-height 3 \
diff --git a/lib/console.tcl b/lib/console.tcl
index 5597188..c112464 100644
--- a/lib/console.tcl
+++ b/lib/console.tcl
@@ -46,7 +46,9 @@ method _init {} {
 		-justify left \
 		-font font_uibold
 	text $w_t \
-		-background white -borderwidth 1 \
+		-background white \
+		-foreground black \
+		-borderwidth 1 \
 		-relief sunken \
 		-width 80 -height 10 \
 		-wrap none \
@@ -180,7 +182,8 @@ method done {ok} {
 	if {$ok} {
 		if {[winfo exists $w.m.s]} {
 			bind $w.m.s <Destroy> [list delete_this $this]
-			$w.m.s conf -background green -text [mc "Success"]
+			$w.m.s conf -background green -foreground black \
+				-text [mc "Success"]
 			if {$is_toplevel} {
 				$w.ok conf -state normal
 				focus $w.ok
@@ -193,7 +196,8 @@ method done {ok} {
 			_init $this
 		}
 		bind $w.m.s <Destroy> [list delete_this $this]
-		$w.m.s conf -background red -text [mc "Error: Command Failed"]
+		$w.m.s conf -background red -foreground black \
+			-text [mc "Error: Command Failed"]
 		if {$is_toplevel} {
 			$w.ok conf -state normal
 			focus $w.ok
diff --git a/lib/error.tcl b/lib/error.tcl
index 8c27678..7565015 100644
--- a/lib/error.tcl
+++ b/lib/error.tcl
@@ -80,7 +80,9 @@ proc hook_failed_popup {hook msg {is_fatal 1}} {
 		-justify left \
 		-font font_uibold
 	text $w.m.t \
-		-background white -borderwidth 1 \
+		-background white \
+		-foreground black \
+		-borderwidth 1 \
 		-relief sunken \
 		-width 80 -height 10 \
 		-font font_diff \
-- 
1.5.4.3.447.gc95b3

