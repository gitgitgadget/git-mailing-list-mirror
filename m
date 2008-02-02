From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] [git-gui] i18n: Fix a bunch of still untranslated strings.
Date: Sat, 2 Feb 2008 10:20:17 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200802021020.18017.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 02 10:22:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLEZp-0000VK-SZ
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 10:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486AbYBBJVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 04:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753267AbYBBJVs
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 04:21:48 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:49250 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492AbYBBJVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 04:21:45 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m129LTVK013401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 2 Feb 2008 10:21:29 +0100
Received: from [192.168.2.102] (p549028DC.dip0.t-ipconnect.de [84.144.40.220])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m129LRAj011230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 2 Feb 2008 10:21:29 +0100
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72236>


I'm unsure about the hunk in lib/index.tcl, though - this
might have to be rewritten. All others are rather trivial.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
 lib/checkout_op.tcl |    6 ++--
 lib/commit.tcl      |   16 +++++-----
 lib/index.tcl       |    2 +-
 lib/merge.tcl       |    5 +--
 po/git-gui.pot      |   82 ++++++++++++++++++++++++++++++++++++--------------
 5 files changed, 73 insertions(+), 38 deletions(-)

diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
index f243966..6e14117 100644
--- a/lib/checkout_op.tcl
+++ b/lib/checkout_op.tcl
@@ -280,7 +280,7 @@ The rescan will be automatically started now.
 	} elseif {[is_config_true gui.trustmtime]} {
 		_readtree $this
 	} else {
-		ui_status {Refreshing file status...}
+		ui_status [mc "Refreshing file status..."]
 		set fd [git_read update-index \
 			-q \
 			--unmerged \
@@ -320,7 +320,7 @@ method _readtree {} {
 	set readtree_d {}
 	$::main_status start \
 		[mc "Updating working directory to '%s'..." [_name $this]] \
-		{files checked out}
+		[mc "files checked out"]
 
 	set fd [git_read --stderr read-tree \
 		-m \
@@ -447,7 +447,7 @@ If you wanted to be on a branch, create one now starting from 'This Detached Che
 	} else {
 		repository_state commit_type HEAD MERGE_HEAD
 		set PARENT $HEAD
-		ui_status "Checked out '$name'."
+		ui_status [mc "Checked out '%s'." $name]
 	}
 	delete_this
 }
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 947b201..40a7103 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -218,7 +218,7 @@ A good commit message has the following format:
 		return
 	}
 
-	ui_status {Calling pre-commit hook...}
+	ui_status [mc "Calling pre-commit hook..."]
 	set pch_error {}
 	fconfigure $fd_ph -blocking 0 -translation binary -eofchar {}
 	fileevent $fd_ph readable \
@@ -233,7 +233,7 @@ proc commit_prehook_wait {fd_ph curHEAD msg_p} {
 	if {[eof $fd_ph]} {
 		if {[catch {close $fd_ph}]} {
 			catch {file delete $msg_p}
-			ui_status {Commit declined by pre-commit hook.}
+			ui_status [mc "Commit declined by pre-commit hook."]
 			hook_failed_popup pre-commit $pch_error
 			unlock_index
 		} else {
@@ -256,7 +256,7 @@ proc commit_commitmsg {curHEAD msg_p} {
 		return
 	}
 
-	ui_status {Calling commit-msg hook...}
+	ui_status [mc "Calling commit-msg hook..."]
 	set pch_error {}
 	fconfigure $fd_ph -blocking 0 -translation binary -eofchar {}
 	fileevent $fd_ph readable \
@@ -271,7 +271,7 @@ proc commit_commitmsg_wait {fd_ph curHEAD msg_p} {
 	if {[eof $fd_ph]} {
 		if {[catch {close $fd_ph}]} {
 			catch {file delete $msg_p}
-			ui_status {Commit declined by commit-msg hook.}
+			ui_status [mc "Commit declined by commit-msg hook."]
 			hook_failed_popup commit-msg $pch_error
 			unlock_index
 		} else {
@@ -284,7 +284,7 @@ proc commit_commitmsg_wait {fd_ph curHEAD msg_p} {
 }
 
 proc commit_writetree {curHEAD msg_p} {
-	ui_status {Committing changes...}
+	ui_status [mc "Committing changes..."]
 	set fd_wt [git_read write-tree]
 	fileevent $fd_wt readable \
 		[list commit_committree $fd_wt $curHEAD $msg_p]
@@ -301,7 +301,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
 	if {[catch {close $fd_wt} err]} {
 		catch {file delete $msg_p}
 		error_popup [strcat [mc "write-tree failed:"] "\n\n$err"]
-		ui_status {Commit failed.}
+		ui_status [mc "Commit failed."]
 		unlock_index
 		return
 	}
@@ -345,7 +345,7 @@ A rescan will be automatically started now.
 	if {[catch {set cmt_id [eval git $cmd]} err]} {
 		catch {file delete $msg_p}
 		error_popup [strcat [mc "commit-tree failed:"] "\n\n$err"]
-		ui_status {Commit failed.}
+		ui_status [mc "Commit failed."]
 		unlock_index
 		return
 	}
@@ -365,7 +365,7 @@ A rescan will be automatically started now.
 		} err]} {
 		catch {file delete $msg_p}
 		error_popup [strcat [mc "update-ref failed:"] "\n\n$err"]
-		ui_status {Commit failed.}
+		ui_status [mc "Commit failed."]
 		unlock_index
 		return
 	}
diff --git a/lib/index.tcl b/lib/index.tcl
index 30a244c..3c1fce7 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -310,7 +310,7 @@ proc add_helper {txt paths} {
 		update_index \
 			$txt \
 			$pathList \
-			[concat $after {ui_status {Ready to commit.}}]
+			[concat $after {ui_status [mc "Ready to commit."]}]
 	}
 }
 
diff --git a/lib/merge.tcl b/lib/merge.tcl
index 63e1427..cc26b07 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -116,8 +116,7 @@ method _start {} {
 	lappend cmd HEAD
 	lappend cmd $name
 
-	set msg [mc "Merging %s and %s" $current_branch $stitle]
-	ui_status "$msg..."
+	ui_status [mc "Merging %s and %s..." $current_branch $stitle]
 	set cons [console::new [mc "Merge"] "merge $stitle"]
 	console::exec $cons $cmd [cb _finish $cons]
 
@@ -236,7 +235,7 @@ Continue with resetting the current changes?"]
 		set fd [git_read --stderr read-tree --reset -u -v HEAD]
 		fconfigure $fd -blocking 0 -translation binary
 		fileevent $fd readable [namespace code [list _reset_wait $fd]]
-		$::main_status start [mc "Aborting"] {files reset}
+		$::main_status start [mc "Aborting"] [mc "files reset"]
 	} else {
 		unlock_index
 	}
diff --git a/po/git-gui.pot b/po/git-gui.pot
index dfa48ae..3f139da 100644
--- a/po/git-gui.pot
+++ b/po/git-gui.pot
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2007-11-24 10:36+0100\n"
+"POT-Creation-Date: 2008-02-02 10:14+0100\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
@@ -386,31 +386,31 @@ msgstr ""
 msgid "File:"
 msgstr ""
 
-#: git-gui.sh:2545
-msgid "Refresh"
+#: git-gui.sh:2573
+msgid "Apply/Reverse Hunk"
 msgstr ""
 
-#: git-gui.sh:2566
-msgid "Apply/Reverse Hunk"
+#: git-gui.sh:2579
+msgid "Show Less Context"
 msgstr ""
 
-#: git-gui.sh:2572
-msgid "Decrease Font Size"
+#: git-gui.sh:2586
+msgid "Show More Context"
 msgstr ""
 
-#: git-gui.sh:2576
-msgid "Increase Font Size"
+#: git-gui.sh:2594
+msgid "Refresh"
 msgstr ""
 
-#: git-gui.sh:2581
-msgid "Show Less Context"
+#: git-gui.sh:2615
+msgid "Decrease Font Size"
 msgstr ""
 
-#: git-gui.sh:2588
-msgid "Show More Context"
+#: git-gui.sh:2619
+msgid "Increase Font Size"
 msgstr ""
 
-#: git-gui.sh:2602
+#: git-gui.sh:2630
 msgid "Unstage Hunk From Commit"
 msgstr ""
 
@@ -766,6 +766,10 @@ msgstr ""
 msgid "Updating working directory to '%s'..."
 msgstr ""
 
+#: lib/checkout_op.tcl:323
+msgid "files checked out"
+msgstr ""
+
 #: lib/checkout_op.tcl:353
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
@@ -1182,11 +1186,40 @@ msgid ""
 "- Remaining lines: Describe why this change is good.\n"
 msgstr ""
 
-#: lib/commit.tcl:257
+#: lib/commit.tcl:207
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr ""
+
+#: lib/commit.tcl:221
+msgid "Calling pre-commit hook..."
+msgstr ""
+
+#: lib/commit.tcl:236
+msgid "Commit declined by pre-commit hook."
+msgstr ""
+
+#: lib/commit.tcl:259
+msgid "Calling commit-msg hook..."
+msgstr ""
+
+#: lib/commit.tcl:274
+msgid "Commit declined by commit-msg hook."
+msgstr ""
+
+#: lib/commit.tcl:287
+msgid "Committing changes..."
+msgstr ""
+
+#: lib/commit.tcl:303
 msgid "write-tree failed:"
 msgstr ""
 
-#: lib/commit.tcl:275
+#: lib/commit.tcl:304 lib/commit.tcl:348 lib/commit.tcl:368
+msgid "Commit failed."
+msgstr ""
+
+#: lib/commit.tcl:321
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr ""
@@ -1204,12 +1237,7 @@ msgstr ""
 msgid "No changes to commit."
 msgstr ""
 
-#: lib/commit.tcl:303
-#, tcl-format
-msgid "warning: Tcl does not support encoding '%s'."
-msgstr ""
-
-#: lib/commit.tcl:317
+#: lib/commit.tcl:347
 msgid "commit-tree failed:"
 msgstr ""
 
@@ -1373,6 +1401,10 @@ msgstr ""
 msgid "Unstaging %s from commit"
 msgstr ""
 
+#: lib/index.tcl:313
+msgid "Ready to commit."
+msgstr ""
+
 #: lib/index.tcl:326
 #, tcl-format
 msgid "Adding %s"
@@ -1491,7 +1523,11 @@ msgstr ""
 msgid "Aborting"
 msgstr ""
 
-#: lib/merge.tcl:266
+#: lib/merge.tcl:238
+msgid "files reset"
+msgstr ""
+
+#: lib/merge.tcl:265
 msgid "Abort failed."
 msgstr ""
 
-- 
1.5.4.rc4
