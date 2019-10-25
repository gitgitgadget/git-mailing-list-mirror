Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC62A1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 01:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbfJYBdC (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 21:33:02 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:33647 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389032AbfJYBdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 21:33:01 -0400
Received: from localhost.localdomain (unknown [1.186.12.46])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D865E100003
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 01:32:58 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Subject: [PATCH 1/1] git-gui: remove unused global declarations
Date:   Fri, 25 Oct 2019 07:02:55 +0530
Message-Id: <20191025013255.7367-2-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025013255.7367-1-me@yadavpratyush.com>
References: <20191025013255.7367-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A lot of places have unused global variables declared. Remove them.

The instances were found using a script, but I checked each change
manually just to be sure. And in the unlikely case something _does_ go
wrong, it would just probably be caught as an "undeclared variable"
error. FWIW, quick testing shows the commonly used features like commit,
push, branch work fine.

While cleaning up, I also moved the remaining declarations around to
avoid a bunch of short lines with only one or two declarations each.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 git-gui.sh                | 12 ++++--------
 lib/about.tcl             |  2 +-
 lib/blame.tcl             |  3 +--
 lib/branch_checkout.tcl   |  2 +-
 lib/branch_create.tcl     |  1 -
 lib/branch_delete.tcl     |  2 +-
 lib/browser.tcl           |  2 +-
 lib/checkout_op.tcl       |  4 +---
 lib/choose_font.tcl       |  2 +-
 lib/choose_repository.tcl |  6 +++---
 lib/class.tcl             |  1 -
 lib/commit.tcl            | 10 +++-------
 lib/console.tcl           |  2 +-
 lib/database.tcl          |  2 +-
 lib/diff.tcl              | 21 +++++++--------------
 lib/error.tcl             |  2 +-
 lib/index.tcl             |  9 ++++-----
 lib/line.tcl              |  2 +-
 lib/merge.tcl             |  5 ++---
 lib/mergetool.tcl         | 10 +++++-----
 lib/remote_add.tcl        |  5 ++---
 lib/search.tcl            |  4 ++--
 lib/sshkey.tcl            |  2 +-
 lib/tools_dlg.tcl         |  6 +++---
 24 files changed, 47 insertions(+), 70 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 0d21f56..c5d7af6 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -501,7 +501,6 @@ proc is_shellscript {filename} {
 # contain a command with arguments. On windows we must check for shell
 # scripts specifically otherwise just call the filter command.
 proc open_cmd_pipe {cmd path} {
-	global env
 	if {![file executable [shellpath]]} {
 		set exe [auto_execok [lindex $cmd 0]]
 		if {[is_shellscript [lindex $exe 0]]} {
@@ -1396,7 +1395,6 @@ proc unlock_index {} {
 ## status
 
 proc repository_state {ctvar hdvar mhvar} {
-	global current_branch
 	upvar $ctvar ct $hdvar hd $mhvar mh
 
 	set mh [list]
@@ -1450,8 +1448,7 @@ proc force_amend {} {
 }
 
 proc rescan {after {honor_trustmtime 1}} {
-	global HEAD PARENT MERGE_HEAD commit_type
-	global ui_index ui_workdir ui_comm
+	global HEAD PARENT MERGE_HEAD commit_type ui_comm
 	global rescan_active file_states
 	global repo_config
 
@@ -1741,7 +1738,6 @@ proc read_ls_others {fd after} {
 
 proc rescan_done {fd buf after} {
 	global rescan_active current_diff_path
-	global file_states repo_config
 	upvar $buf to_clear
 
 	if {![eof $fd]} return
@@ -2370,7 +2366,7 @@ proc do_commit {} {
 }
 
 proc next_diff {{after {}}} {
-	global next_diff_p next_diff_w next_diff_i
+	global next_diff_p next_diff_w
 	show_diff $next_diff_p $next_diff_w {} {} $after
 }
 
@@ -2411,7 +2407,7 @@ proc find_file_from {flist idx delta path mmask} {
 
 proc find_next_diff {w path {lno {}} {mmask {}}} {
 	global next_diff_p next_diff_w next_diff_i
-	global file_lists ui_index ui_workdir
+	global file_lists ui_index
 
 	set flist $file_lists($w)
 	if {$lno eq {}} {
@@ -2495,7 +2491,7 @@ proc force_first_diff {after} {
 }
 
 proc toggle_or_diff {mode w args} {
-	global file_states file_lists current_diff_path ui_index ui_workdir
+	global file_states file_lists ui_index ui_workdir
 	global last_clicked selected_paths file_lists_last_clicked
 
 	if {$mode eq "click"} {
diff --git a/lib/about.tcl b/lib/about.tcl
index cfa50fc..d519890 100644
--- a/lib/about.tcl
+++ b/lib/about.tcl
@@ -4,7 +4,7 @@
 proc do_about {} {
 	global appvers copyright oguilib
 	global tcl_patchLevel tk_patchLevel
-	global ui_comm_spell NS use_ttk
+	global ui_comm_spell NS
 
 	set w .about_dialog
 	Dialog $w
diff --git a/lib/blame.tcl b/lib/blame.tcl
index a1aeb8b..919affb 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -62,7 +62,7 @@ field tooltip_timer     {} ; # Current timer event for our tooltip
 field tooltip_commit    {} ; # Commit(s) in tooltip
 
 constructor new {i_commit i_path i_jump} {
-	global cursor_ptr M1B M1T have_tk85 use_ttk NS
+	global cursor_ptr have_tk85 NS
 	variable active_color
 	variable group_colors
 
@@ -921,7 +921,6 @@ method _load_new_commit {new_commit new_path jump} {
 }
 
 method _showcommit {cur_w lno} {
-	global repo_config
 	variable active_color
 
 	if {$highlight_commit ne {}} {
diff --git a/lib/branch_checkout.tcl b/lib/branch_checkout.tcl
index d06037d..f5d2a0a 100644
--- a/lib/branch_checkout.tcl
+++ b/lib/branch_checkout.tcl
@@ -10,7 +10,7 @@ field opt_fetch     1; # refetch tracking branch if used?
 field opt_detach    0; # force a detached head case?
 
 constructor dialog {} {
-	global use_ttk NS
+	global NS
 	make_dialog top w
 	wm withdraw $w
 	wm title $top [mc "%s (%s): Checkout Branch" [appname] [reponame]]
diff --git a/lib/branch_create.tcl b/lib/branch_create.tcl
index ba367d5..446248d 100644
--- a/lib/branch_create.tcl
+++ b/lib/branch_create.tcl
@@ -115,7 +115,6 @@ constructor dialog {} {
 
 method _create {} {
 	global repo_config
-	global M1B
 
 	set spec [$w_rev get_tracking_branch]
 	switch -- $name_type {
diff --git a/lib/branch_delete.tcl b/lib/branch_delete.tcl
index a505163..2bf52db 100644
--- a/lib/branch_delete.tcl
+++ b/lib/branch_delete.tcl
@@ -9,7 +9,7 @@ field w_check         ; # revision picker for merge test
 field w_delete        ; # delete button
 
 constructor dialog {} {
-	global current_branch use_ttk NS
+	global current_branch NS
 
 	make_dialog top w
 	wm withdraw $w
diff --git a/lib/browser.tcl b/lib/browser.tcl
index a982983..ff7e772 100644
--- a/lib/browser.tcl
+++ b/lib/browser.tcl
@@ -269,7 +269,7 @@ field w              ; # widget path
 field w_rev          ; # mega-widget to pick the initial revision
 
 constructor dialog {} {
-	global use_ttk NS
+	global NS
 	make_dialog top w
 	wm withdraw $top
 	wm title $top [mc "%s (%s): Browse Branch Files" [appname] [reponame]]
diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
index a522829..0fabc7d 100644
--- a/lib/checkout_op.tcl
+++ b/lib/checkout_op.tcl
@@ -389,9 +389,7 @@ $err
 }
 
 method _after_readtree {} {
-	global commit_type HEAD MERGE_HEAD PARENT
-	global current_branch is_detached
-	global ui_comm
+	global HEAD current_branch is_detached
 
 	set name [_name $this]
 	set log "checkout: moving"
diff --git a/lib/choose_font.tcl b/lib/choose_font.tcl
index ebe50bd..bd2fe91 100644
--- a/lib/choose_font.tcl
+++ b/lib/choose_font.tcl
@@ -17,7 +17,7 @@ variable all_families [list]  ; # All fonts known to Tk
 
 constructor pick {path title a_family a_size} {
 	variable all_families
-	global use_ttk NS
+	global NS
 
 	set v_family $a_family
 	set v_size $a_size
diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 80f5a59..4450b6f 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -23,7 +23,7 @@ field readtree_err        ; # Error output from read-tree (if any)
 field sorted_recent       ; # recent repositories (sorted)
 
 constructor pick {} {
-	global M1T M1B use_ttk NS
+	global M1T M1B NS
 
 	if {[set maxrecent [get_config gui.maxrecentrepo]] eq {}} {
 		set maxrecent 10
@@ -403,7 +403,7 @@ proc _objdir {path} {
 ## Create New Repository
 
 method _do_new {} {
-	global use_ttk NS
+	global NS
 	$w_next conf \
 		-state disabled \
 		-command [cb _do_new2] \
@@ -487,7 +487,7 @@ proc _new_ok {p} {
 ## Clone Existing Repository
 
 method _do_clone {} {
-	global use_ttk NS
+	global NS
 	$w_next conf \
 		-state disabled \
 		-command [cb _do_clone2] \
diff --git a/lib/class.tcl b/lib/class.tcl
index f08506f..0b1e671 100644
--- a/lib/class.tcl
+++ b/lib/class.tcl
@@ -136,7 +136,6 @@ proc delete_this {{t {}}} {
 
 proc make_dialog {t w args} {
 	upvar $t top $w pfx this this
-	global use_ttk
 	uplevel [linsert $args 0 make_toplevel $t $w]
 	catch {wm attributes $top -type dialog}
 	pave_toplevel $pfx
diff --git a/lib/commit.tcl b/lib/commit.tcl
index b516aa2..55ee24a 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -3,7 +3,6 @@
 
 proc load_last_commit {} {
 	global HEAD PARENT MERGE_HEAD commit_type ui_comm commit_author
-	global repo_config
 
 	if {[llength $PARENT] == 0} {
 		error_popup [mc "There is nothing to amend.
@@ -142,7 +141,7 @@ proc setup_commit_encoding {msg_wt {quiet 0}} {
 }
 
 proc commit_tree {} {
-	global HEAD commit_type file_states ui_comm repo_config
+	global HEAD commit_type file_states ui_comm
 	global pch_error
 
 	if {[committer_ident] eq {}} return
@@ -269,7 +268,7 @@ proc commit_prehook_wait {fd_ph curHEAD msg_p} {
 }
 
 proc commit_commitmsg {curHEAD msg_p} {
-	global is_detached repo_config
+	global is_detached
 	global pch_error
 
 	if {$is_detached
@@ -332,11 +331,8 @@ proc commit_writetree {curHEAD msg_p} {
 
 proc commit_committree {fd_wt curHEAD msg_p} {
 	global HEAD PARENT MERGE_HEAD commit_type commit_author
-	global current_branch
 	global ui_comm commit_type_is_amend
-	global file_states selected_paths rescan_active
-	global repo_config
-	global env
+	global file_states selected_paths
 
 	gets $fd_wt tree_id
 	if {[catch {close $fd_wt} err]} {
diff --git a/lib/console.tcl b/lib/console.tcl
index 1f3248f..f9f2231 100644
--- a/lib/console.tcl
+++ b/lib/console.tcl
@@ -27,7 +27,7 @@ constructor embed {path title} {
 }
 
 method _init {} {
-	global M1B use_ttk NS
+	global M1B NS
 
 	if {$is_toplevel} {
 		make_dialog top w -autodelete 0
diff --git a/lib/database.tcl b/lib/database.tcl
index 8578308..cb01ead 100644
--- a/lib/database.tcl
+++ b/lib/database.tcl
@@ -2,7 +2,7 @@
 # Copyright (C) 2006, 2007 Shawn Pearce
 
 proc do_stats {} {
-	global use_ttk NS
+	global NS
 	set fd [git_read count-objects -v]
 	while {[gets $fd line] > 0} {
 		if {[regexp {^([^:]+): (\d+)$} $line _ name value]} {
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 871ad48..6f66936 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -63,7 +63,7 @@ proc force_diff_encoding {enc} {
 }
 
 proc handle_empty_diff {} {
-	global current_diff_path file_states file_lists
+	global current_diff_path file_states
 	global diff_empty_count
 
 	set path $current_diff_path
@@ -88,10 +88,8 @@ A rescan will be automatically started to find other files which may have the sa
 }
 
 proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
-	global file_states file_lists
-	global is_3way_diff is_conflict_diff diff_active repo_config
-	global ui_diff ui_index ui_workdir
-	global current_diff_path current_diff_side current_diff_header
+	global file_states file_lists is_conflict_diff diff_active
+	global current_diff_path current_diff_side
 	global current_diff_queue
 
 	if {$diff_active || ![lock_index read]} return
@@ -133,8 +131,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
 }
 
 proc show_unmerged_diff {cont_info} {
-	global current_diff_path current_diff_side
-	global merge_stages ui_diff is_conflict_diff
+	global current_diff_path merge_stages is_conflict_diff
 	global current_diff_queue
 
 	if {$merge_stages(2) eq {}} {
@@ -179,10 +176,7 @@ proc advance_diff_queue {cont_info} {
 }
 
 proc show_other_diff {path w m cont_info} {
-	global file_states file_lists
-	global is_3way_diff diff_active repo_config
-	global ui_diff ui_index ui_workdir
-	global current_diff_path current_diff_side current_diff_header
+	global diff_active ui_diff
 
 	# - Git won't give us the diff, there's nothing to compare to!
 	#
@@ -271,9 +265,8 @@ proc show_other_diff {path w m cont_info} {
 }
 
 proc start_show_diff {cont_info {add_opts {}}} {
-	global file_states file_lists
+	global file_states ui_index ui_workdir
 	global is_3way_diff is_submodule_diff diff_active repo_config
-	global ui_diff ui_index ui_workdir
 	global current_diff_path current_diff_side current_diff_header
 
 	set path $current_diff_path
@@ -879,7 +872,7 @@ proc apply_or_revert_range_or_line {x y revert} {
 # stack/deque for simplicity, so multiple undos are not possible. Maybe this
 # can be added if the need for something like this is felt in the future.
 proc undo_last_revert {} {
-	global last_revert current_diff_path current_diff_header
+	global last_revert
 	global last_revert_enc
 
 	if {$last_revert eq {}} return
diff --git a/lib/error.tcl b/lib/error.tcl
index 8968a57..990c5cd 100644
--- a/lib/error.tcl
+++ b/lib/error.tcl
@@ -71,7 +71,7 @@ proc ask_popup {msg} {
 }
 
 proc hook_failed_popup {hook msg {is_fatal 1}} {
-	global use_ttk NS
+	global NS
 	set w .hookfail
 	Dialog $w
 	wm withdraw $w
diff --git a/lib/index.tcl b/lib/index.tcl
index e07b7a3..416aeb6 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -8,7 +8,7 @@ proc _delete_indexlock {} {
 }
 
 proc _close_updateindex {fd after} {
-	global use_ttk NS
+	global NS
 	fconfigure $fd -blocking 1
 	if {[catch {close $fd} err]} {
 		set w .indexfried
@@ -87,7 +87,7 @@ proc update_indexinfo {msg pathList after} {
 
 proc write_update_indexinfo {fd pathList totalCnt batch after} {
 	global update_index_cp
-	global file_states current_diff_path
+	global file_states
 
 	if {$update_index_cp >= $totalCnt} {
 		_close_updateindex $fd $after
@@ -153,7 +153,7 @@ proc update_index {msg pathList after} {
 
 proc write_update_index {fd pathList totalCnt batch after} {
 	global update_index_cp
-	global file_states current_diff_path
+	global file_states
 
 	if {$update_index_cp >= $totalCnt} {
 		_close_updateindex $fd $after
@@ -229,8 +229,7 @@ proc checkout_index {msg pathList after} {
 }
 
 proc write_checkout_index {fd pathList totalCnt batch after} {
-	global update_index_cp
-	global file_states current_diff_path
+	global update_index_cp file_states
 
 	if {$update_index_cp >= $totalCnt} {
 		_close_updateindex $fd $after
diff --git a/lib/line.tcl b/lib/line.tcl
index a026de9..5c80fec 100644
--- a/lib/line.tcl
+++ b/lib/line.tcl
@@ -9,7 +9,7 @@ field ctext
 field linenum   {}
 
 constructor new {i_w i_text args} {
-	global use_ttk NS
+	global NS
 	set w      $i_w
 	set ctext  $i_text
 
diff --git a/lib/merge.tcl b/lib/merge.tcl
index 9f253db..6967eca 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -144,8 +144,7 @@ method _finish {cons ok} {
 }
 
 constructor dialog {} {
-	global current_branch
-	global M1B use_ttk NS
+	global current_branch M1B NS
 
 	if {![_can_merge $this]} {
 		delete_this
@@ -212,7 +211,7 @@ method _cancel {} {
 namespace eval merge {
 
 proc reset_hard {} {
-	global HEAD commit_type file_states
+	global HEAD commit_type
 
 	if {[string match amend* $commit_type]} {
 		info_popup [mc "Cannot abort while amending.
diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
index 120bc40..44a019b 100644
--- a/lib/mergetool.tcl
+++ b/lib/mergetool.tcl
@@ -52,7 +52,7 @@ proc do_merge_stage_workdir {path} {
 }
 
 proc merge_add_resolution {path} {
-	global current_diff_path ui_workdir
+	global ui_workdir
 
 	set after [next_diff_after_action $ui_workdir $path {} {^_?U}]
 
@@ -110,7 +110,7 @@ proc read_merge_stages {fd cont} {
 		set fcols [split $p "\t"]
 		set cols  [split [lindex $fcols 0] " "]
 		set stage [lindex $cols 2]
-		
+
 		set merge_stages($stage) [lrange $cols 0 1]
 	}
 
@@ -304,7 +304,7 @@ proc merge_tool_get_stages {target stages} {
 }
 
 proc merge_tool_start {cmdline target backup stages} {
-	global merge_stages mtool_target mtool_tmpfiles mtool_fd mtool_mtime
+	global mtool_target mtool_tmpfiles mtool_fd mtool_mtime
 
 	if {[info exists mtool_fd]} {
 		if {[ask_popup [mc "Merge tool is already running, terminate it?"]] eq {yes}} {
@@ -358,7 +358,7 @@ proc merge_tool_start {cmdline target backup stages} {
 }
 
 proc read_mtool_output {fd} {
-	global mtool_fd mtool_tmpfiles
+	global mtool_fd
 
 	read $fd
 	if {[eof $fd]} {
@@ -370,7 +370,7 @@ proc read_mtool_output {fd} {
 }
 
 proc merge_tool_finish {fd} {
-	global mtool_tmpfiles mtool_target mtool_mtime
+	global mtool_tmpfiles mtool_target
 
 	set backup [lindex $mtool_tmpfiles end]
 	set failed 0
diff --git a/lib/remote_add.tcl b/lib/remote_add.tcl
index 480a6b3..56c193f 100644
--- a/lib/remote_add.tcl
+++ b/lib/remote_add.tcl
@@ -13,7 +13,7 @@ field location     {}; # location of the remote the user has chosen
 field opt_action fetch; # action to do after registering the remote locally
 
 constructor dialog {} {
-	global repo_config use_ttk NS
+	global NS
 
 	make_dialog top w
 	wm withdraw $top
@@ -88,8 +88,7 @@ constructor dialog {} {
 }
 
 method _add {} {
-	global repo_config env
-	global M1B
+	global env
 
 	if {$name eq {}} {
 		tk_messageBox \
diff --git a/lib/search.tcl b/lib/search.tcl
index ef1e555..d04b9c3 100644
--- a/lib/search.tcl
+++ b/lib/search.tcl
@@ -21,7 +21,7 @@ field smarktop
 field smarkbot
 
 constructor new {i_w i_text args} {
-	global use_ttk NS
+	global NS
 	set w      $i_w
 	set ctext  $i_text
 
@@ -68,7 +68,7 @@ constructor new {i_w i_text args} {
 	bind $w.ent <Shift-Return> [cb find_prev]
 	bind $w.ent <Key-Up>   [cb _prev_search]
 	bind $w.ent <Key-Down> [cb _next_search]
-	
+
 	bind $w <Destroy> [list delete_this $this]
 	return $this
 }
diff --git a/lib/sshkey.tcl b/lib/sshkey.tcl
index 589ff8f..94de6aa 100644
--- a/lib/sshkey.tcl
+++ b/lib/sshkey.tcl
@@ -18,7 +18,7 @@ proc find_ssh_key {} {
 }
 
 proc do_ssh_key {} {
-	global sshkey_title have_tk85 sshkey_fd use_ttk NS
+	global sshkey_title have_tk85 use_ttk NS
 
 	set w .sshkey_dialog
 	if {[winfo exists $w]} {
diff --git a/lib/tools_dlg.tcl b/lib/tools_dlg.tcl
index c05413c..0e373c6 100644
--- a/lib/tools_dlg.tcl
+++ b/lib/tools_dlg.tcl
@@ -16,7 +16,7 @@ field ask_branch    0; # ask for a revision
 field ask_args      0; # ask for additional args
 
 constructor dialog {} {
-	global repo_config use_ttk NS
+	global NS
 
 	make_dialog top w
 	wm title $top [mc "%s (%s): Add Tool" [appname] [reponame]]
@@ -179,7 +179,7 @@ field w              ; # widget path
 field w_names        ; # name list
 
 constructor dialog {} {
-	global repo_config global_config system_config use_ttk NS
+	global global_config system_config NS
 
 	load_config 1
 
@@ -272,7 +272,7 @@ field is_ok         0; # ok to start
 field argstr       {}; # arguments
 
 constructor dialog {fullname} {
-	global M1B use_ttk NS
+	global M1B NS
 
 	set title [get_config "guitool.$fullname.title"]
 	if {$title eq {}} {
-- 
2.21.0

