From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH 5/5] Improve look-and-feel of GUI tools.
Date: Mon, 26 Mar 2007 11:39:44 +0400
Message-ID: <20070326073944.GI44578@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 09:39:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVjo4-0005if-3b
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 09:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933647AbXCZHjx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 26 Mar 2007 03:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933651AbXCZHjx
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 03:39:53 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:58588 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933647AbXCZHjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 03:39:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Message-ID:MIME-Version:Content-Type:Content-Disposition:Content-Transfer-Encoding:Sender:X-Spam-Status:Subject;
	b=gfPm5j+2WMzh1nzEX41fhbgaeagyNRjFMRw1TInniLXJVewBBFN+NqqQMfTNEb7nu3XrCYPVZFitoNFC8k6T9EXDfjUOKW9NFY6ZD+ksIKHOHMY6mCMp8ninxUeL9GRNWJx6HYIlEjqIXAq+nn0g2E6728jfm+A2d4BALzC/XaI=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HVjnx-000BdV-7p for git@vger.kernel.org; Mon, 26 Mar 2007 11:39:50 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43125>

Made the default buttons on the dialog active and focused upon the
dialog appearence.

Bound 'Escape' and 'Return' keys to the dialog dismissal where it
was appropriate: mainly for dialogs with only one button and no
editable fields, but on console output dialogs as well.

Unified the look of the gitk's "About gitk" and "Key bindings"
dialogs.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 git-gui/git-gui.sh |   19 +++++++++++++++----
 gitk               |   23 +++++++++++++++--------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index f10cfa7..5b53891 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2694,10 +2694,12 @@ proc do_push_anywhere {} {
 	frame $w.buttons
 	button $w.buttons.create -text Push \
 		-font font_ui \
+		-default active \
 		-command [list start_push_anywhere_action $w]
 	pack $w.buttons.create -side right
 	button $w.buttons.cancel -text {Cancel} \
 		-font font_ui \
+		-default normal \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
@@ -2789,7 +2791,7 @@ proc do_push_anywhere {} {
 	set push_thin 0
 	set push_tags 0
=20
-	bind $w <Visibility> "grab $w"
+	bind $w <Visibility> "grab $w; focus $w.buttons.create"
 	bind $w <Key-Escape> "destroy $w"
 	wm title $w "[appname] ([reponame]): Push"
 	tkwait window $w
@@ -4111,6 +4113,7 @@ proc console_done {args} {
 		if {[winfo exists $w]} {
 			$w.m.s conf -background green -text {Success}
 			$w.ok conf -state normal
+			focus $w.ok
 		}
 	} else {
 		if {![winfo exists $w]} {
@@ -4118,6 +4121,7 @@ proc console_done {args} {
 		}
 		$w.m.s conf -background red -text {Error: Command Failed}
 		$w.ok conf -state normal
+		focus $w.ok
 	}
=20
 	array unset console_cr $w
@@ -4185,9 +4189,11 @@ proc do_stats {} {
 	frame $w.buttons -border 1
 	button $w.buttons.close -text Close \
 		-font font_ui \
+		-default active \
 		-command [list destroy $w]
 	button $w.buttons.gc -text {Compress Database} \
 		-font font_ui \
+		-default normal \
 		-command "destroy $w;do_gc"
 	pack $w.buttons.close -side right
 	pack $w.buttons.gc -side left
@@ -4216,7 +4222,7 @@ proc do_stats {} {
 	}
 	pack $w.stat -pady 10 -padx 10
=20
-	bind $w <Visibility> "grab $w; focus $w"
+	bind $w <Visibility> "grab $w; focus $w.buttons.close"
 	bind $w <Key-Escape> [list destroy $w]
 	bind $w <Key-Return> [list destroy $w]
 	wm title $w "[appname] ([reponame]): Database Statistics"
@@ -4513,6 +4519,7 @@ proc do_about {} {
 	frame $w.buttons
 	button $w.buttons.close -text {Close} \
 		-font font_ui \
+		-default active \
 		-command [list destroy $w]
 	pack $w.buttons.close -side right
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
@@ -4558,8 +4565,9 @@ $copyright" \
 		clipboard append -format STRING -type STRING -- \[$w.vers cget -text=
\]
 	"
=20
-	bind $w <Visibility> "grab $w; focus $w"
+	bind $w <Visibility> "grab $w; focus $w.buttons.close"
 	bind $w <Key-Escape> "destroy $w"
+	bind $w <Key-Return> "destroy $w"
 	bind_button3 $w.vers "tk_popup $w.ctxm %X %Y; grab $w; focus $w"
 	wm title $w "About [appname]"
 	tkwait window $w
@@ -4596,14 +4604,17 @@ proc do_options {} {
 	frame $w.buttons
 	button $w.buttons.restore -text {Restore Defaults} \
 		-font font_ui \
+		-default normal \
 		-command do_restore_defaults
 	pack $w.buttons.restore -side left
 	button $w.buttons.save -text Save \
 		-font font_ui \
+		-default active \
 		-command [list do_save_config $w]
 	pack $w.buttons.save -side right
 	button $w.buttons.cancel -text {Cancel} \
 		-font font_ui \
+		-default normal \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
@@ -4707,7 +4718,7 @@ proc do_options {} {
 		pack $w.global.$name -side top -anchor w -fill x
 	}
=20
-	bind $w <Visibility> "grab $w; focus $w"
+	bind $w <Visibility> "grab $w; focus $w.buttons.save"
 	bind $w <Key-Escape> "destroy $w"
 	wm title $w "[appname] ([reponame]): Options"
 	tkwait window $w
diff --git a/gitk b/gitk
index f54ff27..0173660 100755
--- a/gitk
+++ b/gitk
@@ -938,12 +938,15 @@ Gitk - a commit viewer for git
 Copyright =A9 2005-2006 Paul Mackerras
=20
 Use and redistribute under the terms of the GNU General Public License=
} \
-	    -justify center -aspect 400
-    pack $w.m -side top -fill x -padx 20 -pady 20
+	    -justify center -aspect 400 -border 2 -bg white -relief groove
+    pack $w.m -side top -fill x -padx 2 -pady 2
     $w.m configure -font $uifont
-    button $w.ok -text Close -command "destroy $w"
+    button $w.ok -text Close -command "destroy $w" -default active
     pack $w.ok -side bottom
     $w.ok configure -font $uifont
+    bind $w <Visibility> "focus $w.ok"
+    bind $w <Key-Escape> "destroy $w"
+    bind $w <Key-Return> "destroy $w"
 }
=20
 proc keys {} {
@@ -994,12 +997,15 @@ f		Scroll diff view to next file
 <Ctrl-minus>	Decrease font size
 <F5>		Update
 } \
-	    -justify left -bg white -border 2 -relief sunken
-    pack $w.m -side top -fill both
+	    -justify left -bg white -border 2 -relief groove
+    pack $w.m -side top -fill both -padx 2 -pady 2
     $w.m configure -font $uifont
-    button $w.ok -text Close -command "destroy $w"
+    button $w.ok -text Close -command "destroy $w" -default active
     pack $w.ok -side bottom
     $w.ok configure -font $uifont
+    bind $w <Visibility> "focus $w.ok"
+    bind $w <Key-Escape> "destroy $w"
+    bind $w <Key-Return> "destroy $w"
 }
=20
 # Procedures for manipulating the file list window at the
@@ -5892,14 +5898,15 @@ proc doprefs {} {
     grid x $top.hunksepbut $top.hunksep -sticky w
=20
     frame $top.buts
-    button $top.buts.ok -text "OK" -command prefsok
+    button $top.buts.ok -text "OK" -command prefsok -default active
     $top.buts.ok configure -font $uifont
-    button $top.buts.can -text "Cancel" -command prefscan
+    button $top.buts.can -text "Cancel" -command prefscan -default nor=
mal
     $top.buts.can configure -font $uifont
     grid $top.buts.ok $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - - -pady 10 -sticky ew
+    bind $top <Visibility> "focus $top.buts.ok"
 }
=20
 proc choosecolor {v vi w x cmd} {
--=20
1.5.0.3-dirty
