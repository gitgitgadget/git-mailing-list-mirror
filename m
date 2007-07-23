From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] Mark many more strings for i18n.
Date: Mon, 23 Jul 2007 21:37:47 +0200
Message-ID: <200707232137.48298.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 21:40:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID3lZ-0004bW-AP
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 21:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765374AbXGWTkP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 15:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763191AbXGWTkO
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 15:40:14 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:37369 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111AbXGWTkG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 15:40:06 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6NJbbAE028088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 23 Jul 2007 21:37:37 +0200
Received: from [192.168.2.102] (p5490052D.dip0.t-ipconnect.de [84.144.5.45])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6NJbXxv005675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2007 21:37:34 +0200
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53466>


Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
Has already been applied to the "mob" branch of git-gui-i18n.git. Now we 
surpass the 250 messages - the translation is actually getting interesting 
by now.

Note that many strings with variables in them had to be rewritten because
the variable evaluation has to come after the passing through [mc], not before.

Also, the structure of most of the error message is 
"Some verbose text: \n\n git's error message" and the only i18n'able part of this is the 
part before the colon. In this patch I propose to translate the first part *including* 
the colon. Alternatively, the structure could be changed into 
[append [mc "Some verbose text."] " " [mc "Git error message was:"] "\n\n$err"]
and only the very first part is changed but the rest is unchanged for all error messages.

 git-gui.sh                   |   28 +++++++++---------
 lib/blame.tcl                |   10 +++---
 lib/branch_checkout.tcl      |   14 ++++----
 lib/branch_create.tcl        |   36 ++++++++++++------------
 lib/branch_delete.tcl        |   20 ++++++-------
 lib/branch_rename.tcl        |   22 +++++++-------
 lib/browser.tcl              |   20 ++++++------
 lib/checkout_op.tcl          |   46 +++++++++++++++---------------
 lib/choose_rev.tcl           |   16 +++++-----
 lib/commit.tcl               |   52 +++++++++++++++++-----------------
 lib/console.tcl              |   14 ++++----
 lib/database.tcl             |   26 ++++++++--------
 lib/diff.tcl                 |   12 ++++----
 lib/error.tcl                |    8 ++--
 lib/index.tcl                |    8 ++--
 lib/merge.tcl                |   64 ++++++++++++++++++++++-------------------
 lib/option.tcl               |   46 +++++++++++++++---------------
 lib/remote.tcl               |    4 +-
 lib/remote_branch_delete.tcl |   42 +++++++++++++--------------
 lib/shortcut.tcl             |   12 ++++----
 lib/status_bar.tcl           |    2 +-
 lib/transport.tcl            |   30 ++++++++++----------
 22 files changed, 266 insertions(+), 266 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 52170ee..fa510b9 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -528,7 +528,7 @@ proc tk_optionMenu {w varName args} {
 set _git  [_which git]
 if {$_git eq {}} {
 	catch {wm withdraw .}
-	error_popup "Cannot find git in PATH."
+	error_popup [mc "Cannot find git in PATH."]
 	exit 1
 }
 
@@ -547,7 +547,7 @@ $err
 }
 if {![regsub {^git version } $_git_version {} _git_version]} {
 	catch {wm withdraw .}
-	error_popup "Cannot parse Git version string:\n\n$_git_version"
+	error_popup [append [mc "Cannot parse Git version string:"] "\n\n$_git_version"]
 	exit 1
 }
 
@@ -686,7 +686,7 @@ if {[catch {
 		set _prefix [git rev-parse --show-prefix]
 	} err]} {
 	catch {wm withdraw .}
-	error_popup "Cannot find the git directory:\n\n$err"
+	error_popup [append [mc "Cannot find the git directory:"] "\n\n$err"]
 	exit 1
 }
 if {![file isdirectory $_gitdir] && [is_Cygwin]} {
@@ -694,18 +694,18 @@ if {![file isdirectory $_gitdir] && [is_Cygwin]} {
 }
 if {![file isdirectory $_gitdir]} {
 	catch {wm withdraw .}
-	error_popup "Git directory not found:\n\n$_gitdir"
+	error_popup [append [mc "Git directory not found:"] "\n\n$_gitdir"]
 	exit 1
 }
 if {![is_enabled bare]} {
 	if {[lindex [file split $_gitdir] end] ne {.git}} {
 		catch {wm withdraw .}
-		error_popup "Cannot use funny .git directory:\n\n$_gitdir"
+		error_popup [append [mc "Cannot use funny .git directory:"] "\n\n$_gitdir"]
 		exit 1
 	}
 	if {[catch {cd [file dirname $_gitdir]} err]} {
 		catch {wm withdraw .}
-		error_popup "No working directory [file dirname $_gitdir]:\n\n$err"
+		error_popup [append [mc "No working directory"] " [file dirname $_gitdir]:\n\n$err"]
 		exit 1
 	}
 }
@@ -850,7 +850,7 @@ proc rescan {after {honor_trustmtime 1}} {
 		rescan_stage2 {} $after
 	} else {
 		set rescan_active 1
-		ui_status {Refreshing file status...}
+		ui_status [mc "Refreshing file status..."]
 		set fd_rf [git_read update-index \
 			-q \
 			--unmerged \
@@ -883,7 +883,7 @@ proc rescan_stage2 {fd after} {
 	set buf_rlo {}
 
 	set rescan_active 3
-	ui_status {Scanning for modified files ...}
+	ui_status [mc "Scanning for modified files ..."]
 	set fd_di [git_read diff-index --cached -z [PARENT]]
 	set fd_df [git_read diff-files -z]
 	set fd_lo [eval git_read ls-files --others -z $ls_others]
@@ -1049,7 +1049,7 @@ proc ui_status {msg} {
 }
 
 proc ui_ready {{test {}}} {
-	$::main_status show {Ready.} $test
+	$::main_status show [mc "Ready."] $test
 }
 
 proc escape_path {path} {
@@ -1400,7 +1400,7 @@ proc incr_font_size {font {amt 1}} {
 ##
 ## ui commands
 
-set starting_gitk_msg {Starting gitk... please wait...}
+set starting_gitk_msg [mc "Starting gitk... please wait..."]
 
 proc do_gitk {revs} {
 	# -- Always start gitk through whatever we were loaded with.  This
@@ -1409,7 +1409,7 @@ proc do_gitk {revs} {
 	set exe [file join [file dirname $::_git] gitk]
 	set cmd [list [info nameofexecutable] $exe]
 	if {! [file exists $exe]} {
-		error_popup "Unable to start gitk:\n\n$exe does not exist"
+		error_popup [mc "Unable to start gitk:\n\n%s does not exist" $exe]
 	} else {
 		eval exec $cmd $revs &
 		ui_status $::starting_gitk_msg
@@ -1626,7 +1626,7 @@ proc apply_config {} {
 				font configure $font $cn $cv
 			}
 			} err]} {
-			error_popup "Invalid font specified in gui.$name:\n\n$err"
+			error_popup [mc "Invalid font specified in gui.%s:\n\n%s" $name $err]
 		}
 		foreach {cn cv} [font configure $font] {
 			font configure ${font}bold $cn $cv
@@ -1913,7 +1913,7 @@ if {[is_MacOSX]} {
 		set miga_fd [open "|$cmd" r]
 		fconfigure $miga_fd -blocking 0
 		fileevent $miga_fd readable [list miga_done $miga_fd]
-		ui_status {Running miga...}
+		ui_status [mc "Running miga..."]
 	}
 	proc miga_done {fd} {
 		read $fd 512
@@ -2469,7 +2469,7 @@ unset ui_diff_applyhunk
 #
 set main_status [::status_bar::new .status]
 pack .status -anchor w -side bottom -fill x
-$main_status show {Initializing...}
+$main_status show [mc "Initializing..."]
 
 # -- Load geometry
 #
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 9607284..b5fdad5 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -74,11 +74,11 @@ constructor new {i_commit i_path} {
 	set path   $i_path
 
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): File Viewer"
+	wm title $top [append "[appname] ([reponame]): " [mc "File Viewer"]]
 
 	frame $w.header -background gold
 	label $w.header.commit_l \
-		-text {Commit:} \
+		-text [mc "Commit:"] \
 		-background gold \
 		-anchor w \
 		-justify left
@@ -101,7 +101,7 @@ constructor new {i_commit i_path} {
 		-anchor w \
 		-justify left
 	label $w.header.path_l \
-		-text {File:} \
+		-text [mc "File:"] \
 		-background gold \
 		-anchor w \
 		-justify left
@@ -246,7 +246,7 @@ constructor new {i_commit i_path} {
 
 	menu $w.ctxm -tearoff 0
 	$w.ctxm add command \
-		-label "Copy Commit" \
+		-label [mc "Copy Commit"] \
 		-command [cb _copycommit]
 
 	foreach i $w_columns {
@@ -366,7 +366,7 @@ method _load {jump} {
 	set amov_data [list [list]]
 	set asim_data [list [list]]
 
-	$status show "Reading $commit:[escape_path $path]..."
+	$status show [mc "Reading %s..." "$commit:[escape_path $path]"]
 	$w_path conf -text [escape_path $path]
 	if {$commit eq {}} {
 		set fd [open $path r]
diff --git a/lib/branch_checkout.tcl b/lib/branch_checkout.tcl
index 72c45b4..c727437 100644
--- a/lib/branch_checkout.tcl
+++ b/lib/branch_checkout.tcl
@@ -11,20 +11,20 @@ field opt_detach    0; # force a detached head case?
 
 constructor dialog {} {
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Checkout Branch"
+    wm title $top [append "[appname] ([reponame]): " [mc "Checkout Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text {Checkout Branch} -font font_uibold
+	label $w.header -text [mc "Checkout Branch"] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.create -text Checkout \
+	button $w.buttons.create -text [mc Checkout] \
 		-default active \
 		-command [cb _checkout]
 	pack $w.buttons.create -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
@@ -33,15 +33,15 @@ constructor dialog {} {
 	$w_rev bind_listbox <Double-Button-1> [cb _checkout]
 	pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5
 
-	labelframe $w.options -text {Options}
+	labelframe $w.options -text [mc Options]
 
 	checkbutton $w.options.fetch \
-		-text {Fetch Tracking Branch} \
+		-text [mc "Fetch Tracking Branch"] \
 		-variable @opt_fetch
 	pack $w.options.fetch -anchor nw
 
 	checkbutton $w.options.detach \
-		-text {Detach From Local Branch} \
+		-text [mc "Detach From Local Branch"] \
 		-variable @opt_detach
 	pack $w.options.detach -anchor nw
 
diff --git a/lib/branch_create.tcl b/lib/branch_create.tcl
index def615d..acfe411 100644
--- a/lib/branch_create.tcl
+++ b/lib/branch_create.tcl
@@ -19,28 +19,28 @@ constructor dialog {} {
 	global repo_config
 
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Create Branch"
+	wm title $top [append "[appname] ([reponame]): " [mc "Create Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text {Create New Branch} -font font_uibold
+	label $w.header -text [mc "Create New Branch"] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.create -text Create \
+	button $w.buttons.create -text [mc Create] \
 		-default active \
 		-command [cb _create]
 	pack $w.buttons.create -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.desc -text {Branch Name}
+	labelframe $w.desc -text [mc "Branch Name"]
 	radiobutton $w.desc.name_r \
 		-anchor w \
-		-text {Name:} \
+		-text [mc "Name:"] \
 		-value user \
 		-variable @name_type
 	set w_name $w.desc.name_t
@@ -55,7 +55,7 @@ constructor dialog {} {
 
 	radiobutton $w.desc.match_r \
 		-anchor w \
-		-text {Match Tracking Branch Name} \
+		-text [mc "Match Tracking Branch Name"] \
 		-value match \
 		-variable @name_type
 	grid $w.desc.match_r -sticky we -padx {0 5} -columnspan 2
@@ -66,35 +66,35 @@ constructor dialog {} {
 	set w_rev [::choose_rev::new $w.rev {Starting Revision}]
 	pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5
 
-	labelframe $w.options -text {Options}
+	labelframe $w.options -text [mc Options]
 
 	frame $w.options.merge
-	label $w.options.merge.l -text {Update Existing Branch:}
+	label $w.options.merge.l -text [mc "Update Existing Branch:"]
 	pack $w.options.merge.l -side left
 	radiobutton $w.options.merge.no \
-		-text No \
+		-text [mc No] \
 		-value none \
 		-variable @opt_merge
 	pack $w.options.merge.no -side left
 	radiobutton $w.options.merge.ff \
-		-text {Fast Forward Only} \
+		-text [mc "Fast Forward Only"] \
 		-value ff \
 		-variable @opt_merge
 	pack $w.options.merge.ff -side left
 	radiobutton $w.options.merge.reset \
-		-text {Reset} \
+		-text [mc Reset] \
 		-value reset \
 		-variable @opt_merge
 	pack $w.options.merge.reset -side left
 	pack $w.options.merge -anchor nw
 
 	checkbutton $w.options.fetch \
-		-text {Fetch Tracking Branch} \
+		-text [mc "Fetch Tracking Branch"] \
 		-variable @opt_fetch
 	pack $w.options.fetch -anchor nw
 
 	checkbutton $w.options.checkout \
-		-text {Checkout After Creation} \
+		-text [mc "Checkout After Creation"] \
 		-variable @opt_checkout
 	pack $w.options.checkout -anchor nw
 	pack $w.options -anchor nw -fill x -pady 5 -padx 5
@@ -128,7 +128,7 @@ method _create {} {
 				-type ok \
 				-title [wm title $w] \
 				-parent $w \
-				-message "Please select a tracking branch."
+				-message [mc "Please select a tracking branch."]
 			return
 		}
 		if {![regsub ^refs/heads/ [lindex $spec 2] {} newbranch]} {
@@ -137,7 +137,7 @@ method _create {} {
 				-type ok \
 				-title [wm title $w] \
 				-parent $w \
-				-message "Tracking branch [$w get] is not a branch in the remote repository."
+				-message [mc "Tracking branch %s is not a branch in the remote repository." [$w get]]
 			return
 		}
 	}
@@ -150,7 +150,7 @@ method _create {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Please supply a branch name."
+			-message [mc "Please supply a branch name."]
 		focus $w_name
 		return
 	}
@@ -161,7 +161,7 @@ method _create {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "'$newbranch' is not an acceptable branch name."
+			-message [mc "'%s' is not an acceptable branch name." $newbranch]
 		focus $w_name
 		return
 	}
diff --git a/lib/branch_delete.tcl b/lib/branch_delete.tcl
index c7573c6..7ac5f8a 100644
--- a/lib/branch_delete.tcl
+++ b/lib/branch_delete.tcl
@@ -12,29 +12,29 @@ constructor dialog {} {
 	global current_branch
 
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Delete Branch"
+	wm title $top [append "[appname] ([reponame]): " [mc "Delete Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text {Delete Local Branch} -font font_uibold
+	label $w.header -text [mc "Delete Local Branch"] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
 	set w_delete $w.buttons.delete
 	button $w_delete \
-		-text Delete \
+		-text [mc Delete] \
 		-default active \
 		-state disabled \
 		-command [cb _delete]
 	pack $w_delete -side right
 	button $w.buttons.cancel \
-		-text {Cancel} \
+		-text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.list -text {Local Branches}
+	labelframe $w.list -text [mc "Local Branches"]
 	set w_heads $w.list.l
 	listbox $w_heads \
 		-height 10 \
@@ -49,9 +49,9 @@ constructor dialog {} {
 
 	set w_check [choose_rev::new \
 		$w.check \
-		{Delete Only If Merged Into} \
+		[mc "Delete Only If Merged Into"] \
 		]
-	$w_check none {Always (Do not perform merge test.)}
+	$w_check none [mc "Always (Do not perform merge test.)"]
 	pack $w.check -anchor nw -fill x -pady 5 -padx 5
 
 	foreach h [load_all_heads] {
@@ -112,9 +112,7 @@ method _delete {} {
 	}
 	if {$to_delete eq {}} return
 	if {$check_cmt eq {}} {
-		set msg {Recovering deleted branches is difficult.
-
-Delete the selected branches?}
+		set msg [mc "Recovering deleted branches is difficult. \n\n Delete the selected branches?"]
 		if {[tk_messageBox \
 			-icon warning \
 			-type yesno \
@@ -140,7 +138,7 @@ Delete the selected branches?}
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Failed to delete branches:\n$failed"
+			-message [mc "Failed to delete branches:\n%s" $failed]
 	}
 
 	destroy $w
diff --git a/lib/branch_rename.tcl b/lib/branch_rename.tcl
index 1cadc31..e8592af 100644
--- a/lib/branch_rename.tcl
+++ b/lib/branch_rename.tcl
@@ -11,7 +11,7 @@ constructor dialog {} {
 	global current_branch
 
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Rename Branch"
+	wm title $top [append "[appname] ([reponame]): " [mc "Rename Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
@@ -19,24 +19,24 @@ constructor dialog {} {
 	set oldname $current_branch
 	set newname [get_config gui.newbranchtemplate]
 
-	label $w.header -text {Rename Branch} -font font_uibold
+	label $w.header -text [mc "Rename Branch"] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.rename -text Rename \
+	button $w.buttons.rename -text [mc Rename] \
 		-default active \
 		-command [cb _rename]
 	pack $w.buttons.rename -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
 	frame $w.rename
-	label $w.rename.oldname_l -text {Branch:}
+	label $w.rename.oldname_l -text [mc "Branch:"]
 	eval tk_optionMenu $w.rename.oldname_m @oldname [load_all_heads]
 
-	label $w.rename.newname_l -text {New Name:}
+	label $w.rename.newname_l -text [mc "New Name:"]
 	entry $w.rename.newname_t \
 		-borderwidth 1 \
 		-relief sunken \
@@ -72,7 +72,7 @@ method _rename {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Please select a branch to rename."
+			-message [mc "Please select a branch to rename."]
 		focus $w.rename.oldname_m
 		return
 	}
@@ -83,7 +83,7 @@ method _rename {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Please supply a branch name."
+			-message [mc "Please supply a branch name."]
 		focus $w.rename.newname_t
 		return
 	}
@@ -93,7 +93,7 @@ method _rename {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Branch '$newname' already exists."
+			-message [mc "Branch '%s' already exists." $newname]
 		focus $w.rename.newname_t
 		return
 	}
@@ -103,7 +103,7 @@ method _rename {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "We do not like '$newname' as a branch name."
+			-message [mc "We do not like '%s' as a branch name." $newname]
 		focus $w.rename.newname_t
 		return
 	}
@@ -114,7 +114,7 @@ method _rename {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Failed to rename '$oldname'.\n\n$err"
+			-message [mc "Failed to rename '%s'.\n\n%s" $oldname $err]
 		return
 	}
 
diff --git a/lib/browser.tcl b/lib/browser.tcl
index b684c67..9435e67 100644
--- a/lib/browser.tcl
+++ b/lib/browser.tcl
@@ -7,7 +7,7 @@ field w
 field browser_commit
 field browser_path
 field browser_files  {}
-field browser_status {Starting...}
+field browser_status [mc "Starting..."]
 field browser_stack  {}
 field browser_busy   1
 
@@ -16,7 +16,7 @@ field ls_buf     {}; # Buffered record output from ls-tree
 constructor new {commit {path {}}} {
 	global cursor_ptr M1B
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): File Browser"
+	wm title $top [append "[appname] ([reponame]): " [mc "File Browser"]]
 
 	set browser_commit $commit
 	set browser_path $browser_commit:$path
@@ -117,7 +117,7 @@ method _parent {} {
 		} else {
 			regsub {/[^/]+$} $browser_path {} browser_path
 		}
-		set browser_status "Loading $browser_path..."
+		set browser_status [mc "Loading %s..." $browser_path]
 		_ls $this [lindex $parent 0] [lindex $parent 1]
 	}
 }
@@ -134,7 +134,7 @@ method _enter {} {
 		tree {
 			set name [lindex $info 2]
 			set escn [escape_path $name]
-			set browser_status "Loading $escn..."
+			set browser_status [mc "Loading %s..." $escn]
 			append browser_path $escn
 			_ls $this [lindex $info 1] $name
 		}
@@ -178,7 +178,7 @@ method _ls {tree_id {name {}}} {
 			-align center -padx 5 -pady 1 \
 			-name icon0 \
 			-image file_uplevel
-		$w insert end {[Up To Parent]}
+		$w insert end [mc "[Up To Parent]"]
 		lappend browser_files parent
 	}
 	lappend browser_stack [list $tree_id $name]
@@ -230,7 +230,7 @@ method _read {fd} {
 
 	if {[eof $fd]} {
 		close $fd
-		set browser_status Ready.
+		set browser_status [mc "Ready."]
 		set browser_busy 0
 		set ls_buf {}
 		if {$n > 0} {
@@ -251,22 +251,22 @@ field w_rev          ; # mega-widget to pick the initial revision
 
 constructor dialog {} {
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Browse Branch Files"
+	wm title $top [append "[appname] ([reponame]): " [mc "Browse Branch Files"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
 	label $w.header \
-		-text {Browse Branch Files} \
+		-text [mc "Browse Branch Files"] \
 		-font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.browse -text Browse \
+	button $w.buttons.browse -text [mc Browse] \
 		-default active \
 		-command [cb _open]
 	pack $w.buttons.browse -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
index 0571115..4b29634 100644
--- a/lib/checkout_op.tcl
+++ b/lib/checkout_op.tcl
@@ -137,7 +137,7 @@ method _finish_fetch {ok} {
 		destroy $w
 		set w {}
 	} else {
-		button $w.close -text Close -command [list destroy $w]
+		button $w.close -text [mc Close] -command [list destroy $w]
 		pack $w.close -side bottom -anchor e -padx 10 -pady 10
 	}
 
@@ -166,7 +166,7 @@ method _update_ref {} {
 		# Assume it does not exist, and that is what the error was.
 		#
 		if {!$create} {
-			_error $this "Branch '$newbranch' does not exist."
+			_error $this [mc "Branch '%s' does not exist." $newbranch]
 			return 0
 		}
 
@@ -176,7 +176,7 @@ method _update_ref {} {
 		# We were told to create it, but not do a merge.
 		# Bad.  Name shouldn't have existed.
 		#
-		_error $this "Branch '$newbranch' already exists."
+		_error $this [mc "Branch '%s' already exists." $newbranch]
 		return 0
 	} elseif {!$create && $merge_type eq {none}} {
 		# We aren't creating, it exists and we don't merge.
@@ -202,7 +202,7 @@ method _update_ref {} {
 					#
 					set new $cur
 				} else {
-					_error $this "Branch '$newbranch' already exists.\n\nIt cannot fast-forward to $new_expr.\nA merge is required."
+					_error $this [mc "Branch '%s' already exists.\n\nIt cannot fast-forward to %s.\nA merge is required." $newbranch $new_expr]
 					return 0
 				}
 			}
@@ -216,7 +216,7 @@ method _update_ref {} {
 				}
 			}
 			default {
-				_error $this "Merge strategy '$merge_type' not supported."
+				_error $this [mc "Merge strategy '%s' not supported." $merge_type]
 				return 0
 			}
 			}
@@ -235,7 +235,7 @@ method _update_ref {} {
 		if {[catch {
 				git update-ref -m $reflog_msg $ref $new $cur
 			} err]} {
-			_error $this "Failed to update '$newbranch'.\n\n$err"
+			_error $this [mc "Failed to update '%s'.\n\n%s" $newbranch $err]
 			return 0
 		}
 	}
@@ -247,7 +247,7 @@ method _checkout {} {
 	if {[lock_index checkout_op]} {
 		after idle [cb _start_checkout]
 	} else {
-		_error $this "Index is already locked."
+		_error $this [mc "Index is already locked."]
 		delete_this
 	}
 }
@@ -262,12 +262,12 @@ method _start_checkout {} {
 		&& $curType eq {normal}
 		&& $curHEAD eq $HEAD} {
 	} elseif {$commit_type ne $curType || $HEAD ne $curHEAD} {
-		info_popup {Last scanned state does not match repository state.
+		info_popup [mc "Last scanned state does not match repository state.
 
 Another Git program has modified this repository since the last scan.  A rescan must be performed before the current branch can be changed.
 
 The rescan will be automatically started now.
-}
+"]
 		unlock_index
 		rescan ui_ready
 		delete_this
@@ -349,12 +349,12 @@ method _readtree_wait {fd} {
 	if {[catch {close $fd}]} {
 		set err $readtree_d
 		regsub {^fatal: } $err {} err
-		$::main_status stop "Aborted checkout of '[_name $this]' (file level merging is required)."
-		warn_popup "File level merge required.
+		$::main_status stop [mc "Aborted checkout of '%s' (file level merging is required)." [_name $this]]
+		warn_popup [append [mc "File level merge required."] "
 
 $err
 
-Staying on branch '$current_branch'."
+" [mc "Staying on branch '%s'." $current_branch]]
 		unlock_index
 		delete_this
 		return
@@ -423,9 +423,9 @@ method _after_readtree {} {
 	}
 
 	if {$is_detached} {
-		info_popup "You are no longer on a local branch.
+		info_popup [mc "You are no longer on a local branch.
 
-If you wanted to be on a branch, create one now starting from 'This Detached Checkout'."
+If you wanted to be on a branch, create one now starting from 'This Detached Checkout'."]
 	}
 
 	# -- Update our repository state.  If we were previously in
@@ -472,7 +472,7 @@ method _confirm_reset {cur} {
 	pack [label $w.msg1 \
 		-anchor w \
 		-justify left \
-		-text "Resetting '$name' to $new_expr will lose the following commits:" \
+		-text [mc "Resetting '%s' to '%s' will lose the following commits:" $name $new_expr]\
 		] -anchor w
 
 	set list $w.list.l
@@ -494,21 +494,21 @@ method _confirm_reset {cur} {
 	pack [label $w.msg2 \
 		-anchor w \
 		-justify left \
-		-text {Recovering lost commits may not be easy.} \
+		-text [mc "Recovering lost commits may not be easy."] \
 		]
 	pack [label $w.msg3 \
 		-anchor w \
 		-justify left \
-		-text "Reset '$name'?" \
+		-text [mc "Reset '%s'?" $name] \
 		]
 
 	frame $w.buttons
 	button $w.buttons.visualize \
-		-text Visualize \
+		-text [mc Visualize] \
 		-command $gitk
 	pack $w.buttons.visualize -side left
 	button $w.buttons.reset \
-		-text Reset \
+		-text [mc Reset] \
 		-command "
 			set @reset_ok 1
 			destroy $w
@@ -516,7 +516,7 @@ method _confirm_reset {cur} {
 	pack $w.buttons.reset -side right
 	button $w.buttons.cancel \
 		-default active \
-		-text Cancel \
+		-text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
@@ -572,13 +572,13 @@ method _toplevel {title} {
 }
 
 method _fatal {err} {
-	error_popup "Failed to set current branch.
+	error_popup [append [mc "Failed to set current branch.
 
 This working directory is only partially switched.  We successfully updated your files, but failed to update an internal Git file.
 
-This should not have occurred.  [appname] will now close and give up.
+This should not have occurred.  %s will now close and give up." [appname]] "
 
-$err"
+$err"]
 	exit 1
 }
 
diff --git a/lib/choose_rev.tcl b/lib/choose_rev.tcl
index 6c4c318..1e82990 100644
--- a/lib/choose_rev.tcl
+++ b/lib/choose_rev.tcl
@@ -32,14 +32,14 @@ constructor new {path {title {}}} {
 	if {$is_detached} {
 		radiobutton $w.detachedhead_r \
 			-anchor w \
-			-text {This Detached Checkout} \
+			-text [mc "This Detached Checkout"] \
 			-value HEAD \
 			-variable @revtype
 		grid $w.detachedhead_r -sticky we -padx {0 5} -columnspan 2
 	}
 
 	radiobutton $w.expr_r \
-		-text {Revision Expression:} \
+		-text [mc "Revision Expression:"] \
 		-value expr \
 		-variable @revtype
 	entry $w.expr_t \
@@ -53,17 +53,17 @@ constructor new {path {title {}}} {
 
 	frame $w.types
 	radiobutton $w.types.head_r \
-		-text {Local Branch} \
+		-text [mc "Local Branch"] \
 		-value head \
 		-variable @revtype
 	pack $w.types.head_r -side left
 	radiobutton $w.types.trck_r \
-		-text {Tracking Branch} \
+		-text [mc "Tracking Branch"] \
 		-value trck \
 		-variable @revtype
 	pack $w.types.trck_r -side left
 	radiobutton $w.types.tag_r \
-		-text {Tag} \
+		-text [mc "Tag"] \
 		-value tag \
 		-variable @revtype
 	pack $w.types.tag_r -side left
@@ -224,7 +224,7 @@ method commit_or_die {} {
 		}
 
 		set top [winfo toplevel $w]
-		set msg "Invalid revision: [get $this]\n\n$err"
+		set msg [mc "Invalid revision: %s\n\n%s" [get $this] $err]
 		tk_messageBox \
 			-icon error \
 			-type ok \
@@ -245,7 +245,7 @@ method _expr {} {
 		if {$i ne {}} {
 			return [lindex $cur_specs $i 1]
 		} else {
-			error "No revision selected."
+			error [mc "No revision selected."]
 		}
 	}
 
@@ -253,7 +253,7 @@ method _expr {} {
 		if {$c_expr ne {}} {
 			return $c_expr
 		} else {
-			error "Revision expression is empty."
+			error [mc "Revision expression is empty."]
 		}
 	}
 	HEAD { return HEAD                     }
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 6b86f98..f60b11e 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -6,19 +6,19 @@ proc load_last_commit {} {
 	global repo_config
 
 	if {[llength $PARENT] == 0} {
-		error_popup {There is nothing to amend.
+		error_popup [mc "There is nothing to amend.
 
 You are about to create the initial commit.  There is no commit before this to amend.
-}
+"]
 		return
 	}
 
 	repository_state curType curHEAD curMERGE_HEAD
 	if {$curType eq {merge}} {
-		error_popup {Cannot amend while merging.
+		error_popup [mc "Cannot amend while merging.
 
 You are currently in the middle of a merge that has not been fully completed.  You cannot amend the prior commit unless you first abort the current merge activity.
-}
+"]
 		return
 	}
 
@@ -46,7 +46,7 @@ You are currently in the middle of a merge that has not been fully completed.  Y
 			}
 			set msg [string trim $msg]
 		} err]} {
-		error_popup "Error loading commit data for amend:\n\n$err"
+ 	    error_popup [append [mc "Error loading commit data for amend:"] "\n\n$err"]
 		return
 	}
 
@@ -73,12 +73,12 @@ proc committer_ident {} {
 
 	if {$GIT_COMMITTER_IDENT eq {}} {
 		if {[catch {set me [git var GIT_COMMITTER_IDENT]} err]} {
-			error_popup "Unable to obtain your identity:\n\n$err"
+			error_popup [append [mc "Unable to obtain your identity:"] "\n\n$err"]
 			return {}
 		}
 		if {![regexp {^(.*) [0-9]+ [-+0-9]+$} \
 			$me me GIT_COMMITTER_IDENT]} {
-			error_popup "Invalid GIT_COMMITTER_IDENT:\n\n$me"
+			error_popup [append [mc "Invalid GIT_COMMITTER_IDENT:"] "\n\n$me"]
 			return {}
 		}
 	}
@@ -130,12 +130,12 @@ proc commit_tree {} {
 		&& $curType eq {normal}
 		&& $curHEAD eq $HEAD} {
 	} elseif {$commit_type ne $curType || $HEAD ne $curHEAD} {
-		info_popup {Last scanned state does not match repository state.
+		info_popup [mc "Last scanned state does not match repository state.
 
 Another Git program has modified this repository since the last scan.  A rescan must be performed before another commit can be created.
 
 The rescan will be automatically started now.
-}
+"]
 		unlock_index
 		rescan ui_ready
 		return
@@ -151,26 +151,26 @@ The rescan will be automatically started now.
 		D? -
 		M? {set files_ready 1}
 		U? {
-			error_popup "Unmerged files cannot be committed.
+			error_popup [mc "Unmerged files cannot be committed.
 
-File [short_path $path] has merge conflicts.  You must resolve them and add the file before committing.
-"
+File %s has merge conflicts.  You must resolve them and add the file before committing.
+" [short_path $path]]
 			unlock_index
 			return
 		}
 		default {
-			error_popup "Unknown file state [lindex $s 0] detected.
+			error_popup [mc "Unknown file state %s detected.
 
-File [short_path $path] cannot be committed by this program.
-"
+File %s cannot be committed by this program.
+" [lindex $s 0] [short_path $path]]
 		}
 		}
 	}
 	if {!$files_ready && ![string match *merge $curType]} {
-		info_popup {No changes to commit.
+		info_popup [mc "No changes to commit.
 
 You must add at least 1 file before you can commit.
-}
+"]
 		unlock_index
 		return
 	}
@@ -180,14 +180,14 @@ You must add at least 1 file before you can commit.
 	set msg [string trim [$ui_comm get 1.0 end]]
 	regsub -all -line {[ \t\r]+$} $msg {} msg
 	if {$msg eq {}} {
-		error_popup {Please supply a commit message.
+		error_popup [mc "Please supply a commit message.
 
 A good commit message has the following format:
 
 - First line: Describe in one sentance what you did.
 - Second line: Blank
 - Remaining lines: Describe why this change is good.
-}
+"]
 		unlock_index
 		return
 	}
@@ -254,7 +254,7 @@ proc commit_committree {fd_wt curHEAD msg} {
 
 	gets $fd_wt tree_id
 	if {$tree_id eq {} || [catch {close $fd_wt} err]} {
-		error_popup "write-tree failed:\n\n$err"
+		error_popup [append [mc "write-tree failed:"] "\n\n$err"]
 		ui_status {Commit failed.}
 		unlock_index
 		return
@@ -276,14 +276,14 @@ proc commit_committree {fd_wt curHEAD msg} {
 		}
 
 		if {$tree_id eq $old_tree} {
-			info_popup {No changes to commit.
+			info_popup [mc "No changes to commit.
 
 No files were modified by this commit and it was not a merge commit.
 
 A rescan will be automatically started now.
-}
+"]
 			unlock_index
-			rescan {ui_status {No changes to commit.}}
+			rescan {ui_status [mc "No changes to commit."]}
 			return
 		}
 	}
@@ -314,7 +314,7 @@ A rescan will be automatically started now.
 	}
 	lappend cmd <$msg_p
 	if {[catch {set cmt_id [eval git $cmd]} err]} {
-		error_popup "commit-tree failed:\n\n$err"
+		error_popup [append [mc "commit-tree failed:"] "\n\n$err"]
 		ui_status {Commit failed.}
 		unlock_index
 		return
@@ -336,7 +336,7 @@ A rescan will be automatically started now.
 	if {[catch {
 			git update-ref -m $reflogm HEAD $cmt_id $curHEAD
 		} err]} {
-		error_popup "update-ref failed:\n\n$err"
+		error_popup [append [mc "update-ref failed:"] "\n\n$err"]
 		ui_status {Commit failed.}
 		unlock_index
 		return
@@ -427,5 +427,5 @@ A rescan will be automatically started now.
 	display_all_files
 	unlock_index
 	reshow_diff
-	ui_status "Created commit [string range $cmt_id 0 7]: $subject"
+	ui_status [mc "Created commit %s: %s" [string range $cmt_id 0 7] $subject]
 }
diff --git a/lib/console.tcl b/lib/console.tcl
index 6f718fb..e5f9ba4 100644
--- a/lib/console.tcl
+++ b/lib/console.tcl
@@ -52,7 +52,7 @@ method _init {} {
 		-state disabled \
 		-xscrollcommand [list $w.m.sbx set] \
 		-yscrollcommand [list $w.m.sby set]
-	label $w.m.s -text {Working... please wait...} \
+	label $w.m.s -text [mc "Working... please wait..."] \
 		-anchor w \
 		-justify left \
 		-font font_uibold
@@ -66,11 +66,11 @@ method _init {} {
 	pack $w.m -side top -fill both -expand 1 -padx 5 -pady 10
 
 	menu $w.ctxm -tearoff 0
-	$w.ctxm add command -label "Copy" \
+	$w.ctxm add command -label [mc "Copy"] \
 		-command "tk_textCopy $w.m.t"
-	$w.ctxm add command -label "Select All" \
+	$w.ctxm add command -label [mc "Select All"] \
 		-command "focus $w.m.t;$w.m.t tag add sel 0.0 end"
-	$w.ctxm add command -label "Copy All" \
+	$w.ctxm add command -label [mc "Copy All"] \
 		-command "
 			$w.m.t tag add sel 0.0 end
 			tk_textCopy $w.m.t
@@ -78,7 +78,7 @@ method _init {} {
 		"
 
 	if {$is_toplevel} {
-		button $w.ok -text {Close} \
+		button $w.ok -text [mc "Close"] \
 			-state disabled \
 			-command [list destroy $w]
 		pack $w.ok -side bottom -anchor e -pady 10 -padx 10
@@ -181,7 +181,7 @@ method insert {txt} {
 method done {ok} {
 	if {$ok} {
 		if {[winfo exists $w.m.s]} {
-			$w.m.s conf -background green -text {Success}
+			$w.m.s conf -background green -text [mc "Success"]
 			if {$is_toplevel} {
 				$w.ok conf -state normal
 				focus $w.ok
@@ -191,7 +191,7 @@ method done {ok} {
 		if {![winfo exists $w.m.s]} {
 			_init $this
 		}
-		$w.m.s conf -background red -text {Error: Command Failed}
+		$w.m.s conf -background red -text [mc "Error: Command Failed"]
 		if {$is_toplevel} {
 			$w.ok conf -state normal
 			focus $w.ok
diff --git a/lib/database.tcl b/lib/database.tcl
index 0657cc2..8dda9af 100644
--- a/lib/database.tcl
+++ b/lib/database.tcl
@@ -24,14 +24,14 @@ proc do_stats {} {
 	toplevel $w
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
 
-	label $w.header -text {Database Statistics}
+	label $w.header -text [mc "Database Statistics"]
 	pack $w.header -side top -fill x
 
 	frame $w.buttons -border 1
-	button $w.buttons.close -text Close \
+	button $w.buttons.close -text [mc Close] \
 		-default active \
 		-command [list destroy $w]
-	button $w.buttons.gc -text {Compress Database} \
+	button $w.buttons.gc -text [mc "Compress Database"] \
 		-default normal \
 		-command "destroy $w;do_gc"
 	pack $w.buttons.close -side right
@@ -40,13 +40,13 @@ proc do_stats {} {
 
 	frame $w.stat -borderwidth 1 -relief solid
 	foreach s {
-		{count           {Number of loose objects}}
-		{size            {Disk space used by loose objects} { KiB}}
-		{in-pack         {Number of packed objects}}
-		{packs           {Number of packs}}
-		{size-pack       {Disk space used by packed objects} { KiB}}
-		{prune-packable  {Packed objects waiting for pruning}}
-		{garbage         {Garbage files}}
+		{count           [mc "Number of loose objects"]}
+		{size            [mc "Disk space used by loose objects"] { KiB}}
+		{in-pack         [mc "Number of packed objects"]}
+		{packs           [mc "Number of packs"]}
+		{size-pack       [mc "Disk space used by packed objects"] { KiB}}
+		{prune-packable  [mc "Packed objects waiting for pruning"]}
+		{garbage         [mc "Garbage files"]}
 		} {
 		set name [lindex $s 0]
 		set label [lindex $s 1]
@@ -64,12 +64,12 @@ proc do_stats {} {
 	bind $w <Visibility> "grab $w; focus $w.buttons.close"
 	bind $w <Key-Escape> [list destroy $w]
 	bind $w <Key-Return> [list destroy $w]
-	wm title $w "[appname] ([reponame]): Database Statistics"
+	wm title $w [append "[appname] ([reponame]): " [mc "Database Statistics"]]
 	tkwait window $w
 }
 
 proc do_gc {} {
-	set w [console::new {gc} {Compressing the object database}]
+	set w [console::new {gc} [mc "Compressing the object database"]]
 	console::chain $w {
 		{exec git pack-refs --prune}
 		{exec git reflog expire --all}
@@ -80,7 +80,7 @@ proc do_gc {} {
 
 proc do_fsck_objects {} {
 	set w [console::new {fsck-objects} \
-		{Verifying the object database with fsck-objects}]
+		[mc "Verifying the object database with fsck-objects"]]
 	set cmd [list git fsck-objects]
 	lappend cmd --full
 	lappend cmd --cache
diff --git a/lib/diff.tcl b/lib/diff.tcl
index e09e125..d937e46 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -39,13 +39,13 @@ proc handle_empty_diff {} {
 	set s $file_states($path)
 	if {[lindex $s 0] ne {_M}} return
 
-	info_popup "No differences detected.
+	info_popup [mc "No differences detected.
 
-[short_path $path] has no changes.
+%s has no changes.
 
 The modification date of this file was updated by another application, but the content within the file was not changed.
 
-A rescan will be automatically started to find other files which may have the same state."
+A rescan will be automatically started to find other files which may have the same state." [short_path $path]]
 
 	clear_diff
 	display_file $path __
@@ -94,7 +94,7 @@ proc show_diff {path w {lno {}}} {
 			set diff_active 0
 			unlock_index
 			ui_status "Unable to display [escape_path $path]"
-			error_popup "Error loading file:\n\n$err"
+ 		    error_popup [append [mc "Error loading file:"] "\n\n$err"]
 			return
 		}
 		$ui_diff conf -state normal
@@ -159,7 +159,7 @@ proc show_diff {path w {lno {}}} {
 		set diff_active 0
 		unlock_index
 		ui_status "Unable to display [escape_path $path]"
-		error_popup "Error loading diff:\n\n$err"
+		error_popup [append [mc "Error loading diff:"] "\n\n$err"]
 		return
 	}
 
@@ -307,7 +307,7 @@ proc apply_hunk {x y} {
 		puts -nonewline $p $current_diff_header
 		puts -nonewline $p [$ui_diff get $s_lno $e_lno]
 		close $p} err]} {
-		error_popup "Failed to $mode selected hunk.\n\n$err"
+		error_popup [append [mc "Failed to %s selected hunk." $mode] "\n\n$err"]
 		unlock_index
 		return
 	}
diff --git a/lib/error.tcl b/lib/error.tcl
index 16a2218..13565b7 100644
--- a/lib/error.tcl
+++ b/lib/error.tcl
@@ -9,7 +9,7 @@ proc error_popup {msg} {
 	set cmd [list tk_messageBox \
 		-icon error \
 		-type ok \
-		-title "$title: error" \
+		-title [append "$title: " [mc "error"]] \
 		-message $msg]
 	if {[winfo ismapped .]} {
 		lappend cmd -parent .
@@ -25,7 +25,7 @@ proc warn_popup {msg} {
 	set cmd [list tk_messageBox \
 		-icon warning \
 		-type ok \
-		-title "$title: warning" \
+		-title [append "$title: " [mc "warning"]] \
 		-message $msg]
 	if {[winfo ismapped .]} {
 		lappend cmd -parent .
@@ -78,7 +78,7 @@ proc hook_failed_popup {hook msg} {
 		-font font_diff \
 		-yscrollcommand [list $w.m.sby set]
 	label $w.m.l2 \
-		-text {You must correct the above errors before committing.} \
+		-text [mc "You must correct the above errors before committing."] \
 		-anchor w \
 		-justify left \
 		-font font_uibold
@@ -99,6 +99,6 @@ proc hook_failed_popup {hook msg} {
 
 	bind $w <Visibility> "grab $w; focus $w"
 	bind $w <Key-Return> "destroy $w"
-	wm title $w "[appname] ([reponame]): error"
+	wm title $w [append "[appname] ([reponame]): " [mc "error"]]
 	tkwait window $w
 }
diff --git a/lib/index.tcl b/lib/index.tcl
index 3ea72e1..9080ac6 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -358,13 +358,13 @@ proc revert_helper {txt paths} {
 	set reply [tk_dialog \
 		.confirm_revert \
 		"[appname] ([reponame])" \
-		"Revert changes in $s?
+		[mc "Revert changes in %s?
 
-Any unadded changes will be permanently lost by the revert." \
+Any unadded changes will be permanently lost by the revert." $s] \
 		question \
 		1 \
-		{Do Nothing} \
-		{Revert Changes} \
+		[mc "Do Nothing"] \
+		[mc "Revert Changes"] \
 		]
 	if {$reply == 1} {
 		checkout_index \
diff --git a/lib/merge.tcl b/lib/merge.tcl
index e5a7525..40e82a9 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -11,10 +11,10 @@ method _can_merge {} {
 	global HEAD commit_type file_states
 
 	if {[string match amend* $commit_type]} {
-		info_popup {Cannot merge while amending.
+		info_popup [mc "Cannot merge while amending.
 
 You must finish amending this commit before starting any type of merge.
-}
+"]
 		return 0
 	}
 
@@ -25,12 +25,12 @@ You must finish amending this commit before starting any type of merge.
 	#
 	repository_state curType curHEAD curMERGE_HEAD
 	if {$commit_type ne $curType || $HEAD ne $curHEAD} {
-		info_popup {Last scanned state does not match repository state.
+		info_popup [mc "Last scanned state does not match repository state.
 
 Another Git program has modified this repository since the last scan.  A rescan must be performed before a merge can be performed.
 
 The rescan will be automatically started now.
-}
+"]
 		unlock_index
 		rescan ui_ready
 		return 0
@@ -42,22 +42,22 @@ The rescan will be automatically started now.
 			continue; # and pray it works!
 		}
 		U? {
-			error_popup "You are in the middle of a conflicted merge.
+			error_popup [mc "You are in the middle of a conflicted merge.
 
-File [short_path $path] has merge conflicts.
+File %s has merge conflicts.
 
 You must resolve them, add the file, and commit to complete the current merge.  Only then can you begin another merge.
-"
+" [short_path $path]]
 			unlock_index
 			return 0
 		}
 		?? {
-			error_popup "You are in the middle of a change.
+			error_popup [mc "You are in the middle of a change.
 
-File [short_path $path] is modified.
+File %s is modified.
 
 You should complete the current commit before starting a merge.  Doing so will help you abort a failed merge, should the need arise.
-"
+" [short_path $path]]
 			unlock_index
 			return 0
 		}
@@ -91,9 +91,9 @@ method _start {} {
 	}
 
 	set cmd [list git merge $name]
-	set msg "Merging $current_branch and $name"
+	set msg [mc "Merging %s and %s" $current_branch $name]
 	ui_status "$msg..."
-	set cons [console::new "Merge" $cmd]
+	set cons [console::new [mc "Merge"] $cmd]
 	console::exec $cons $cmd [cb _finish $cons]
 
 	wm protocol $w WM_DELETE_WINDOW {}
@@ -103,9 +103,9 @@ method _start {} {
 method _finish {cons ok} {
 	console::done $cons $ok
 	if {$ok} {
-		set msg {Merge completed successfully.}
+		set msg [mc "Merge completed successfully."]
 	} else {
-		set msg {Merge failed.  Conflict resolution is required.}
+		set msg [mc "Merge failed.  Conflict resolution is required."]
 	}
 	unlock_index
 	rescan [list ui_status $msg]
@@ -154,7 +154,7 @@ constructor dialog {} {
 	set list [lsort -unique $list]
 
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Merge"
+	wm title $top [append "[appname] ([reponame]): " [mc "Merge"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
@@ -163,22 +163,22 @@ constructor dialog {} {
 	set _start [cb _start]
 
 	label $w.header \
-		-text "Merge Into $current_branch" \
+		-text [mc "Merge Into %s" $current_branch] \
 		-font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.visualize -text Visualize -command $_visualize
+	button $w.buttons.visualize -text [mc Visualize] -command $_visualize
 	pack $w.buttons.visualize -side left
-	button $w.buttons.create -text Merge -command $_start
+	button $w.buttons.create -text [mc Merge] -command $_start
 	pack $w.buttons.create -side right
 	button $w.buttons.cancel \
-		-text {Cancel} \
+		-text [mc "Cancel"] \
 		-command [cb _cancel]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.source -text {Source Branches}
+	labelframe $w.source -text [mc "Source Branches"]
 	set w_list $w.source.l
 	listbox $w_list \
 		-height 10 \
@@ -237,30 +237,34 @@ proc reset_hard {} {
 	global HEAD commit_type file_states
 
 	if {[string match amend* $commit_type]} {
-		info_popup {Cannot abort while amending.
+		info_popup [mc "Cannot abort while amending.
 
 You must finish amending this commit.
-}
+"]
 		return
 	}
 
 	if {![lock_index abort]} return
 
 	if {[string match *merge* $commit_type]} {
-		set op merge
+		set op_question [mc "Abort merge?
+
+Aborting the current merge will cause *ALL* uncommitted changes to be lost.
+
+Continue with aborting the current merge?"]
 	} else {
-		set op commit
-	}
+		set op_question [mc "Abort commit?
 
-	if {[ask_popup "Abort $op?
+Aborting the current commit will cause *ALL* uncommitted changes to be lost.
 
-Aborting the current $op will cause *ALL* uncommitted changes to be lost.
+Continue with aborting the current commit?"]
+	}
 
-Continue with aborting the current $op?"] eq {yes}} {
+	if {[ask_popup $op_question] eq {yes}} {
 		set fd [git_read read-tree --reset -u HEAD]
 		fconfigure $fd -blocking 0 -translation binary
 		fileevent $fd readable [namespace code [list _reset_wait $fd]]
-		ui_status {Aborting... please wait...}
+		ui_status [mc "Aborting... please wait..."]
 	} else {
 		unlock_index
 	}
@@ -283,7 +287,7 @@ proc _reset_wait {fd} {
 		catch {file delete [gitdir MERGE_MSG]}
 		catch {file delete [gitdir GITGUI_MSG]}
 
-		rescan {ui_status {Abort completed.  Ready.}}
+		rescan {ui_status [mc "Abort completed.  Ready."]}
 	}
 }
 
diff --git a/lib/option.tcl b/lib/option.tcl
index aa9f783..6c4d7ae 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -62,7 +62,7 @@ proc do_about {} {
 	toplevel $w
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
 
-	label $w.header -text "About [appname]" \
+	label $w.header -text [mc "About %s" [appname]] \
 		-font font_uibold
 	pack $w.header -side top -fill x
 
@@ -74,8 +74,8 @@ proc do_about {} {
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
 	label $w.desc \
-		-text "git-gui - a graphical user interface for Git.
-$copyright" \
+		-text [append [mc "git-gui - a graphical user interface for Git."] "
+$copyright"] \
 		-padx 5 -pady 5 \
 		-justify left \
 		-anchor w \
@@ -157,44 +157,44 @@ proc do_options {} {
 	toplevel $w
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
 
-	label $w.header -text "Options" \
+	label $w.header -text [mc "Options"] \
 		-font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.restore -text {Restore Defaults} \
+	button $w.buttons.restore -text [mc "Restore Defaults"] \
 		-default normal \
 		-command do_restore_defaults
 	pack $w.buttons.restore -side left
-	button $w.buttons.save -text Save \
+	button $w.buttons.save -text [mc Save] \
 		-default active \
 		-command [list do_save_config $w]
 	pack $w.buttons.save -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc "Cancel"] \
 		-default normal \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.repo -text "[reponame] Repository"
-	labelframe $w.global -text {Global (All Repositories)}
+	labelframe $w.repo -text [mc "%s Repository" [reponame]]
+	labelframe $w.global -text [mc "Global (All Repositories)"]
 	pack $w.repo -side left -fill both -expand 1 -pady 5 -padx 5
 	pack $w.global -side right -fill both -expand 1 -pady 5 -padx 5
 
 	set optid 0
 	foreach option {
-		{t user.name {User Name}}
-		{t user.email {Email Address}}
-
-		{b merge.summary {Summarize Merge Commits}}
-		{i-1..5 merge.verbosity {Merge Verbosity}}
-		{b merge.diffstat {Show Diffstat After Merge}}
-
-		{b gui.trustmtime  {Trust File Modification Timestamps}}
-		{b gui.pruneduringfetch {Prune Tracking Branches During Fetch}}
-		{b gui.matchtrackingbranch {Match Tracking Branches}}
-		{i-0..99 gui.diffcontext {Number of Diff Context Lines}}
-		{t gui.newbranchtemplate {New Branch Name Template}}
+		{t user.name [mc "User Name"]}
+		{t user.email [mc "Email Address"]}
+
+		{b merge.summary [mc "Summarize Merge Commits"]}
+		{i-1..5 merge.verbosity [mc "Merge Verbosity"]}
+		{b merge.diffstat [mc "Show Diffstat After Merge"]}
+
+		{b gui.trustmtime  [mc "Trust File Modification Timestamps"]}
+		{b gui.pruneduringfetch [mc "Prune Tracking Branches During Fetch"]}
+		{b gui.matchtrackingbranch [mc "Match Tracking Branches"]}
+		{i-0..99 gui.diffcontext [mc "Number of Diff Context Lines"]}
+		{t gui.newbranchtemplate [mc "New Branch Name Template"]}
 		} {
 		set type [lindex $option 0]
 		set name [lindex $option 1]
@@ -272,7 +272,7 @@ proc do_options {} {
 	bind $w <Visibility> "grab $w; focus $w.buttons.save"
 	bind $w <Key-Escape> "destroy $w"
 	bind $w <Key-Return> [list do_save_config $w]
-	wm title $w "[appname] ([reponame]): Options"
+	wm title $w [append "[appname] ([reponame]): " [mc "Options"]]
 	tkwait window $w
 }
 
@@ -303,7 +303,7 @@ proc do_restore_defaults {} {
 
 proc do_save_config {w} {
 	if {[catch {save_config} err]} {
-		error_popup "Failed to completely save options:\n\n$err"
+		error_popup [append [mc "Failed to completely save options:"] "\n\n$err"]
 	}
 	reshow_diff
 	destroy $w
diff --git a/lib/remote.tcl b/lib/remote.tcl
index e235ca8..c47ae50 100644
--- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -163,7 +163,7 @@ proc populate_fetch_menu {} {
 	}
 	foreach r $prune_list {
 		$m add command \
-			-label "Prune from $r..." \
+			-label [mc "Prune from %s..." $r] \
 			-command [list prune_from $r]
 	}
 }
@@ -197,7 +197,7 @@ proc populate_push_menu {} {
 				$m add separator
 			}
 			$m add command \
-				-label "Push to $r..." \
+				-label [mc "Push to %s..." $r] \
 				-command [list push_to $r]
 			incr fast_count
 		}
diff --git a/lib/remote_branch_delete.tcl b/lib/remote_branch_delete.tcl
index c88a360..06b5eab 100644
--- a/lib/remote_branch_delete.tcl
+++ b/lib/remote_branch_delete.tcl
@@ -26,28 +26,28 @@ constructor dialog {} {
 	global all_remotes M1B
 
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Delete Remote Branch"
+	wm title $top [append "[appname] ([reponame]): " [mc "Delete Remote Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text {Delete Remote Branch} -font font_uibold
+	label $w.header -text [mc "Delete Remote Branch"] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.delete -text Delete \
+	button $w.buttons.delete -text [mc Delete] \
 		-default active \
 		-command [cb _delete]
 	pack $w.buttons.delete -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc "Cancel"] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.dest -text {From Repository}
+	labelframe $w.dest -text [mc "From Repository"]
 	if {$all_remotes ne {}} {
 		radiobutton $w.dest.remote_r \
-			-text {Remote:} \
+			-text [mc "Remote:"] \
 			-value remote \
 			-variable @urltype
 		eval tk_optionMenu $w.dest.remote_m @remote $all_remotes
@@ -63,7 +63,7 @@ constructor dialog {} {
 		set urltype url
 	}
 	radiobutton $w.dest.url_r \
-		-text {Arbitrary URL:} \
+		-text [mc "Arbitrary URL:"] \
 		-value url \
 		-variable @urltype
 	entry $w.dest.url_t \
@@ -81,7 +81,7 @@ constructor dialog {} {
 	grid columnconfigure $w.dest 1 -weight 1
 	pack $w.dest -anchor nw -fill x -pady 5 -padx 5
 
-	labelframe $w.heads -text {Branches}
+	labelframe $w.heads -text [mc "Branches"]
 	listbox $w.heads.l \
 		-height 10 \
 		-width 70 \
@@ -96,7 +96,7 @@ constructor dialog {} {
 		-anchor w \
 		-justify left
 	button $w.heads.footer.rescan \
-		-text {Rescan} \
+		-text [mc "Rescan"] \
 		-command [cb _rescan]
 	pack $w.heads.footer.status -side left -fill x
 	pack $w.heads.footer.rescan -side right
@@ -106,9 +106,9 @@ constructor dialog {} {
 	pack $w.heads.l -side left -fill both -expand 1
 	pack $w.heads -fill both -expand 1 -pady 5 -padx 5
 
-	labelframe $w.validate -text {Delete Only If}
+	labelframe $w.validate -text [mc "Delete Only If"]
 	radiobutton $w.validate.head_r \
-		-text {Merged Into:} \
+		-text [mc "Merged Into:"] \
 		-value head \
 		-variable @checktype
 	set head_m [tk_optionMenu $w.validate.head_m @check_head {}]
@@ -116,7 +116,7 @@ constructor dialog {} {
 	trace add variable @check_head write [cb _write_check_head]
 	grid $w.validate.head_r $w.validate.head_m -sticky w
 	radiobutton $w.validate.always_r \
-		-text {Always (Do not perform merge checks)} \
+		-text [mc "Always (Do not perform merge checks)"] \
 		-value always \
 		-variable @checktype
 	grid $w.validate.always_r -columnspan 2 -sticky w
@@ -149,7 +149,7 @@ method _delete {} {
 				-type ok \
 				-title [wm title $w] \
 				-parent $w \
-				-message "A branch is required for 'Merged Into'."
+				-message [mc "A branch is required for 'Merged Into'."]
 			return
 		}
 		set crev $full_cache("$cache\nrefs/heads/$check_head")
@@ -186,9 +186,7 @@ method _delete {} {
  - [join $not_merged "\n - "]"
 
 		if {$need_fetch} {
-			append msg "
-
-One or more of the merge tests failed because you have not fetched the necessary commits.  Try fetching from $uri first."
+			append msg "\n\n" [mc "One or more of the merge tests failed because you have not fetched the necessary commits.  Try fetching from %s first." $uri]
 		}
 
 		tk_messageBox \
@@ -206,7 +204,7 @@ One or more of the merge tests failed because you have not fetched the necessary
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Please select one or more branches to delete."
+			-message [mc "Please select one or more branches to delete."]
 		return
 	}
 
@@ -215,9 +213,9 @@ One or more of the merge tests failed because you have not fetched the necessary
 		-type yesno \
 		-title [wm title $w] \
 		-parent $w \
-		-message {Recovering deleted branches is difficult.
+		-message [mc "Recovering deleted branches is difficult.
 
-Delete the selected branches?}] ne yes} {
+Delete the selected branches?"]] ne yes} {
 		return
 	}
 
@@ -225,7 +223,7 @@ Delete the selected branches?}] ne yes} {
 
 	set cons [console::new \
 		"push $uri" \
-		"Deleting branches from $uri"]
+		[mc "Deleting branches from %s" $uri]]
 	console::exec $cons $push_cmd
 }
 
@@ -285,12 +283,12 @@ method _load {cache uri} {
 		$w.heads.l conf -state disabled
 		set head_list [list]
 		set full_list [list]
-		set status {No repository selected.}
+		set status [mc "No repository selected."]
 		return
 	}
 
 	if {[catch {set x $cached($cache)}]} {
-		set status "Scanning $uri..."
+		set status [mc "Scanning %s..." $uri]
 		$w.heads.l conf -state disabled
 		set head_list [list]
 		set full_list [list]
diff --git a/lib/shortcut.tcl b/lib/shortcut.tcl
index c36be2f..d0e63a3 100644
--- a/lib/shortcut.tcl
+++ b/lib/shortcut.tcl
@@ -6,7 +6,7 @@ proc do_windows_shortcut {} {
 
 	set fn [tk_getSaveFile \
 		-parent . \
-		-title "[appname] ([reponame]): Create Desktop Icon" \
+		-title [append "[appname] ([reponame]): " [mc "Create Desktop Icon"]] \
 		-initialfile "Git [reponame].bat"]
 	if {$fn != {}} {
 		if {[file extension $fn] ne {.bat}} {
@@ -23,7 +23,7 @@ proc do_windows_shortcut {} {
 				puts $fd " \"[file normalize $argv0]\""
 				close $fd
 			} err]} {
-			error_popup "Cannot write script:\n\n$err"
+			error_popup [append [mc "Cannot write script:"] "\n\n$err"]
 		}
 	}
 }
@@ -42,7 +42,7 @@ proc do_cygwin_shortcut {} {
 	}
 	set fn [tk_getSaveFile \
 		-parent . \
-		-title "[appname] ([reponame]): Create Desktop Icon" \
+		-title [append "[appname] ([reponame]): " [mc "Create Desktop Icon"]] \
 		-initialdir $desktop \
 		-initialfile "Git [reponame].bat"]
 	if {$fn != {}} {
@@ -71,7 +71,7 @@ proc do_cygwin_shortcut {} {
 				puts $fd " &\""
 				close $fd
 			} err]} {
-			error_popup "Cannot write script:\n\n$err"
+			error_popup [append [mc "Cannot write script:"] "\n\n$err"]
 		}
 	}
 }
@@ -81,7 +81,7 @@ proc do_macosx_app {} {
 
 	set fn [tk_getSaveFile \
 		-parent . \
-		-title "[appname] ([reponame]): Create Desktop Icon" \
+		-title [append "[appname] ([reponame]): " [mc "Create Desktop Icon"]] \
 		-initialdir [file join $env(HOME) Desktop] \
 		-initialfile "Git [reponame].app"]
 	if {$fn != {}} {
@@ -146,7 +146,7 @@ proc do_macosx_app {} {
 
 				file attributes $exe -permissions u+x,g+x,o+x
 			} err]} {
-			error_popup "Cannot write icon:\n\n$err"
+			error_popup [append [mc "Cannot write icon:"] "\n\n$err"]
 		}
 	}
 }
diff --git a/lib/status_bar.tcl b/lib/status_bar.tcl
index 72a8fe1..769ef81 100644
--- a/lib/status_bar.tcl
+++ b/lib/status_bar.tcl
@@ -55,7 +55,7 @@ method update {have total} {
 		set pdone [expr {100 * $have / $total}]
 	}
 
-	set status [format "%s ... %i of %i %s (%2i%%)" \
+	set status [mc "%s ... %i of %i %s (%2i%%)" \
 		$prefix $have $total $units $pdone]
 	$w_c coords bar 0 0 $pdone 20
 }
diff --git a/lib/transport.tcl b/lib/transport.tcl
index 3a22bd4..1c7baef 100644
--- a/lib/transport.tcl
+++ b/lib/transport.tcl
@@ -4,7 +4,7 @@
 proc fetch_from {remote} {
 	set w [console::new \
 		"fetch $remote" \
-		"Fetching new changes from $remote"]
+		[mc "Fetching new changes from %s" $remote]]
 	set cmds [list]
 	lappend cmds [list exec git fetch $remote]
 	if {[is_config_true gui.pruneduringfetch]} {
@@ -16,14 +16,14 @@ proc fetch_from {remote} {
 proc prune_from {remote} {
 	set w [console::new \
 		"remote prune $remote" \
-		"Pruning tracking branches deleted from $remote"]
+		[mc "Pruning tracking branches deleted from %s" $remote]]
 	console::exec $w [list git remote prune $remote]
 }
 
 proc push_to {remote} {
 	set w [console::new \
 		"push $remote" \
-		"Pushing changes to $remote"]
+		[mc "Pushing changes to %s" $remote]]
 	set cmd [list git push]
 	lappend cmd -v
 	lappend cmd $remote
@@ -65,7 +65,7 @@ proc start_push_anywhere_action {w} {
 
 	set cons [console::new \
 		"push $r_url" \
-		"Pushing $cnt $unit to $r_url"]
+		[mc "Pushing %s %s to %s" $cnt $unit $r_url]]
 	console::exec $cons $cmd
 	destroy $w
 }
@@ -81,21 +81,21 @@ proc do_push_anywhere {} {
 	toplevel $w
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
 
-	label $w.header -text {Push Branches} -font font_uibold
+	label $w.header -text [mc "Push Branches"] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.create -text Push \
+	button $w.buttons.create -text [mc Push] \
 		-default active \
 		-command [list start_push_anywhere_action $w]
 	pack $w.buttons.create -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc "Cancel"] \
 		-default normal \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.source -text {Source Branches}
+	labelframe $w.source -text [mc "Source Branches"]
 	listbox $w.source.l \
 		-height 10 \
 		-width 70 \
@@ -112,10 +112,10 @@ proc do_push_anywhere {} {
 	pack $w.source.l -side left -fill both -expand 1
 	pack $w.source -fill both -expand 1 -pady 5 -padx 5
 
-	labelframe $w.dest -text {Destination Repository}
+	labelframe $w.dest -text [mc "Destination Repository"]
 	if {$all_remotes ne {}} {
 		radiobutton $w.dest.remote_r \
-			-text {Remote:} \
+			-text [mc "Remote:"] \
 			-value remote \
 			-variable push_urltype
 		eval tk_optionMenu $w.dest.remote_m push_remote $all_remotes
@@ -130,7 +130,7 @@ proc do_push_anywhere {} {
 		set push_urltype url
 	}
 	radiobutton $w.dest.url_r \
-		-text {Arbitrary URL:} \
+		-text [mc "Arbitrary URL:"] \
 		-value url \
 		-variable push_urltype
 	entry $w.dest.url_t \
@@ -150,13 +150,13 @@ proc do_push_anywhere {} {
 	grid columnconfigure $w.dest 1 -weight 1
 	pack $w.dest -anchor nw -fill x -pady 5 -padx 5
 
-	labelframe $w.options -text {Transfer Options}
+	labelframe $w.options -text [mc "Transfer Options"]
 	checkbutton $w.options.thin \
-		-text {Use thin pack (for slow network connections)} \
+		-text [mc "Use thin pack (for slow network connections)"] \
 		-variable push_thin
 	grid $w.options.thin -columnspan 2 -sticky w
 	checkbutton $w.options.tags \
-		-text {Include tags} \
+		-text [mc "Include tags"] \
 		-variable push_tags
 	grid $w.options.tags -columnspan 2 -sticky w
 	grid columnconfigure $w.options 1 -weight 1
@@ -169,6 +169,6 @@ proc do_push_anywhere {} {
 	bind $w <Visibility> "grab $w; focus $w.buttons.create"
 	bind $w <Key-Escape> "destroy $w"
 	bind $w <Key-Return> [list start_push_anywhere_action $w]
-	wm title $w "[appname] ([reponame]): Push"
+	wm title $w [append "[appname] ([reponame]): " [mc "Push"]]
 	tkwait window $w
 }
-- 
1.5.2.3
