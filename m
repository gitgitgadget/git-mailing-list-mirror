From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 4/5] git-gui: fix incorrect use of Tcl append command
Date: Sun,  8 May 2016 10:52:57 +0000
Message-ID: <1462704778-4722-4-git-send-email-vascomalmeida@sapo.pt>
References: <1462704778-4722-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 12:54:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azMM1-0006aR-2Y
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 12:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbcEHKyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 06:54:22 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:56707 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750841AbcEHKyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 06:54:16 -0400
Received: (qmail 21218 invoked from network); 8 May 2016 10:54:12 -0000
Received: (qmail 14701 invoked from network); 8 May 2016 10:54:12 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 May 2016 10:54:11 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1462704778-4722-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293964>

Fix wrong use of append command in strings marked for translation.
According to Tcl/Tk Documentation [1],
	append varName ?value value value ...?
appends all value arguments to the current value of variable varName.
This means that
	append "[appname] ([reponame]): " [mc "File Viewer"]
is setting a variable named "[appname] ([reponame]): " to the output of
[mc "File Viewer"], rather than returning the concatenation of both
expressions as one might expect.

The format for some strings enables, for instance, a French translator
to translate like "%s (%s) : Create Branch" (space before colon).
Conversely, strings already translated will be marked as fuzzy and the
translator must update them herself.

For some cases, use alternative way for concatenation instead of using
strcat procedure defined in git-gui.sh.

Reference: 31bb1d1 ("git-gui: Paper bag fix missing translated strings",
2007-09-14) fixes the same issue slightly differently.

[1] http://www.tcl.tk/man/tcl/TclCmd/append.htm

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 lib/blame.tcl                |  2 +-
 lib/branch_checkout.tcl      |  2 +-
 lib/branch_create.tcl        |  2 +-
 lib/branch_delete.tcl        |  2 +-
 lib/branch_rename.tcl        |  2 +-
 lib/browser.tcl              |  4 ++--
 lib/database.tcl             |  2 +-
 lib/diff.tcl                 | 11 +++++------
 lib/error.tcl                |  4 ++--
 lib/merge.tcl                |  2 +-
 lib/remote_add.tcl           |  2 +-
 lib/remote_branch_delete.tcl |  2 +-
 lib/shortcut.tcl             |  6 +++---
 lib/tools_dlg.tcl            |  6 +++---
 lib/transport.tcl            |  2 +-
 15 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index b1d15f4..a1aeb8b 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -70,7 +70,7 @@ constructor new {i_commit i_path i_jump} {
 	set path   $i_path
 
 	make_toplevel top w
-	wm title $top [append "[appname] ([reponame]): " [mc "File Viewer"]]
+	wm title $top [mc "%s (%s): File Viewer" [appname] [reponame]]
 
 	set font_w [font measure font_diff "0"]
 
diff --git a/lib/branch_checkout.tcl b/lib/branch_checkout.tcl
index 2e459a8..d06037d 100644
--- a/lib/branch_checkout.tcl
+++ b/lib/branch_checkout.tcl
@@ -13,7 +13,7 @@ constructor dialog {} {
 	global use_ttk NS
 	make_dialog top w
 	wm withdraw $w
-	wm title $top [append "[appname] ([reponame]): " [mc "Checkout Branch"]]
+	wm title $top [mc "%s (%s): Checkout Branch" [appname] [reponame]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
diff --git a/lib/branch_create.tcl b/lib/branch_create.tcl
index 4bb9077..ba367d5 100644
--- a/lib/branch_create.tcl
+++ b/lib/branch_create.tcl
@@ -20,7 +20,7 @@ constructor dialog {} {
 
 	make_dialog top w
 	wm withdraw $w
-	wm title $top [append "[appname] ([reponame]): " [mc "Create Branch"]]
+	wm title $top [mc "%s (%s): Create Branch" [appname] [reponame]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
diff --git a/lib/branch_delete.tcl b/lib/branch_delete.tcl
index 9aef0c9..a505163 100644
--- a/lib/branch_delete.tcl
+++ b/lib/branch_delete.tcl
@@ -13,7 +13,7 @@ constructor dialog {} {
 
 	make_dialog top w
 	wm withdraw $w
-	wm title $top [append "[appname] ([reponame]): " [mc "Delete Branch"]]
+	wm title $top [mc "%s (%s): Delete Branch" [appname] [reponame]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
diff --git a/lib/branch_rename.tcl b/lib/branch_rename.tcl
index 6e510ec..3a2d79a 100644
--- a/lib/branch_rename.tcl
+++ b/lib/branch_rename.tcl
@@ -12,7 +12,7 @@ constructor dialog {} {
 
 	make_dialog top w
 	wm withdraw $w
-	wm title $top [append "[appname] ([reponame]): " [mc "Rename Branch"]]
+	wm title $top [mc "%s (%s): Rename Branch" [appname] [reponame]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
diff --git a/lib/browser.tcl b/lib/browser.tcl
index 0328338..1580493 100644
--- a/lib/browser.tcl
+++ b/lib/browser.tcl
@@ -24,7 +24,7 @@ constructor new {commit {path {}}} {
 	global cursor_ptr M1B use_ttk NS
 	make_dialog top w
 	wm withdraw $top
-	wm title $top [append "[appname] ([reponame]): " [mc "File Browser"]]
+	wm title $top [mc "%s (%s): File Browser" [appname] [reponame]]
 
 	if {$path ne {}} {
 		if {[string index $path end] ne {/}} {
@@ -272,7 +272,7 @@ constructor dialog {} {
 	global use_ttk NS
 	make_dialog top w
 	wm withdraw $top
-	wm title $top [append "[appname] ([reponame]): " [mc "Browse Branch Files"]]
+	wm title $top [mc "%s (%s): Browse Branch Files" [appname] [reponame]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 		wm transient $top .
diff --git a/lib/database.tcl b/lib/database.tcl
index 8bd4b8e..8578308 100644
--- a/lib/database.tcl
+++ b/lib/database.tcl
@@ -63,7 +63,7 @@ proc do_stats {} {
 	bind $w <Visibility> "grab $w; focus $w.buttons.close"
 	bind $w <Key-Escape> [list destroy $w]
 	bind $w <Key-Return> [list destroy $w]
-	wm title $w [append "[appname] ([reponame]): " [mc "Database Statistics"]]
+	wm title $w [mc "%s (%s): Database Statistics" [appname] [reponame]]
 	wm deiconify $w
 	tkwait window $w
 }
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 0d56986..1228ce2 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -220,10 +220,9 @@ proc show_other_diff {path w m cont_info} {
 		}
 		$ui_diff conf -state normal
 		if {$type eq {submodule}} {
-			$ui_diff insert end [append \
-				"* " \
-				[mc "Git Repository (subproject)"] \
-				"\n"] d_info
+			$ui_diff insert end \
+				"* [mc "Git Repository (subproject)"]\n" \
+				d_info
 		} elseif {![catch {set type [exec file $path]}]} {
 			set n [string length $path]
 			if {[string equal -length $n $path $type]} {
@@ -608,7 +607,7 @@ proc apply_hunk {x y} {
 		puts -nonewline $p $current_diff_header
 		puts -nonewline $p [$ui_diff get $s_lno $e_lno]
 		close $p} err]} {
-		error_popup [append $failed_msg "\n\n$err"]
+		error_popup "$failed_msg\n\n$err"
 		unlock_index
 		return
 	}
@@ -826,7 +825,7 @@ proc apply_range_or_line {x y} {
 		puts -nonewline $p $current_diff_header
 		puts -nonewline $p $wholepatch
 		close $p} err]} {
-		error_popup [append $failed_msg "\n\n$err"]
+		error_popup "$failed_msg\n\n$err"
 	}
 
 	unlock_index
diff --git a/lib/error.tcl b/lib/error.tcl
index 9b7d229..71dc860 100644
--- a/lib/error.tcl
+++ b/lib/error.tcl
@@ -17,7 +17,7 @@ proc error_popup {msg} {
 	set cmd [list tk_messageBox \
 		-icon error \
 		-type ok \
-		-title [append "$title: " [mc "error"]] \
+		-title [mc "%s: error" $title] \
 		-message $msg]
 	if {[winfo ismapped [_error_parent]]} {
 		lappend cmd -parent [_error_parent]
@@ -33,7 +33,7 @@ proc warn_popup {msg} {
 	set cmd [list tk_messageBox \
 		-icon warning \
 		-type ok \
-		-title [append "$title: " [mc "warning"]] \
+		-title [mc "%s: warning" $title] \
 		-message $msg]
 	if {[winfo ismapped [_error_parent]]} {
 		lappend cmd -parent [_error_parent]
diff --git a/lib/merge.tcl b/lib/merge.tcl
index 460d32f..b2de109 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -149,7 +149,7 @@ constructor dialog {} {
 	}
 
 	make_dialog top w
-	wm title $top [append "[appname] ([reponame]): " [mc "Merge"]]
+	wm title $top [mc "%s (%s): Merge" [appname] [reponame]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
diff --git a/lib/remote_add.tcl b/lib/remote_add.tcl
index 50029d0..480a6b3 100644
--- a/lib/remote_add.tcl
+++ b/lib/remote_add.tcl
@@ -17,7 +17,7 @@ constructor dialog {} {
 
 	make_dialog top w
 	wm withdraw $top
-	wm title $top [append "[appname] ([reponame]): " [mc "Add Remote"]]
+	wm title $top [mc "%s (%s): Add Remote" [appname] [reponame]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
diff --git a/lib/remote_branch_delete.tcl b/lib/remote_branch_delete.tcl
index fcc06d0..5ba9fca 100644
--- a/lib/remote_branch_delete.tcl
+++ b/lib/remote_branch_delete.tcl
@@ -26,7 +26,7 @@ constructor dialog {} {
 	global all_remotes M1B use_ttk NS
 
 	make_dialog top w
-	wm title $top [append "[appname] ([reponame]): " [mc "Delete Branch Remotely"]]
+	wm title $top [mc "%s (%s): Delete Branch Remotely" [appname] [reponame]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
diff --git a/lib/shortcut.tcl b/lib/shortcut.tcl
index 78878ef..135086b 100644
--- a/lib/shortcut.tcl
+++ b/lib/shortcut.tcl
@@ -5,7 +5,7 @@ proc do_windows_shortcut {} {
 	global _gitworktree
 	set fn [tk_getSaveFile \
 		-parent . \
-		-title [append "[appname] ([reponame]): " [mc "Create Desktop Icon"]] \
+		-title [mc "%s (%s): Create Desktop Icon" [appname] [reponame]] \
 		-initialfile "Git [reponame].lnk"]
 	if {$fn != {}} {
 		if {[file extension $fn] ne {.lnk}} {
@@ -37,7 +37,7 @@ proc do_cygwin_shortcut {} {
 	}
 	set fn [tk_getSaveFile \
 		-parent . \
-		-title [append "[appname] ([reponame]): " [mc "Create Desktop Icon"]] \
+		-title [mc "%s (%s): Create Desktop Icon" [appname] [reponame]] \
 		-initialdir $desktop \
 		-initialfile "Git [reponame].lnk"]
 	if {$fn != {}} {
@@ -69,7 +69,7 @@ proc do_macosx_app {} {
 
 	set fn [tk_getSaveFile \
 		-parent . \
-		-title [append "[appname] ([reponame]): " [mc "Create Desktop Icon"]] \
+		-title [mc "%s (%s): Create Desktop Icon" [appname] [reponame]] \
 		-initialdir [file join $env(HOME) Desktop] \
 		-initialfile "Git [reponame].app"]
 	if {$fn != {}} {
diff --git a/lib/tools_dlg.tcl b/lib/tools_dlg.tcl
index 7eeda9d..c05413c 100644
--- a/lib/tools_dlg.tcl
+++ b/lib/tools_dlg.tcl
@@ -19,7 +19,7 @@ constructor dialog {} {
 	global repo_config use_ttk NS
 
 	make_dialog top w
-	wm title $top [append "[appname] ([reponame]): " [mc "Add Tool"]]
+	wm title $top [mc "%s (%s): Add Tool" [appname] [reponame]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 		wm transient $top .
@@ -184,7 +184,7 @@ constructor dialog {} {
 	load_config 1
 
 	make_dialog top w
-	wm title $top [append "[appname] ([reponame]): " [mc "Remove Tool"]]
+	wm title $top [mc "%s (%s): Remove Tool" [appname] [reponame]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 		wm transient $top .
@@ -280,7 +280,7 @@ constructor dialog {fullname} {
 	}
 
 	make_dialog top w -autodelete 0
-	wm title $top [append "[appname] ([reponame]): " $title]
+	wm title $top "[mc "%s (%s):" [appname] [reponame]] $title"
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 		wm transient $top .
diff --git a/lib/transport.tcl b/lib/transport.tcl
index e5d211e..a1a424a 100644
--- a/lib/transport.tcl
+++ b/lib/transport.tcl
@@ -226,7 +226,7 @@ proc do_push_anywhere {} {
 	bind $w <Visibility> "grab $w; focus $w.buttons.create"
 	bind $w <Key-Escape> "destroy $w"
 	bind $w <Key-Return> [list start_push_anywhere_action $w]
-	wm title $w [append "[appname] ([reponame]): " [mc "Push"]]
+	wm title $w [mc "%s (%s): Push" [appname] [reponame]]
 	wm deiconify $w
 	tkwait window $w
 }
-- 
2.7.3
