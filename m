Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13D7C43141
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 02:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB352075A
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 02:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQu4F+s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfLAC2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 21:28:42 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:36592 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfLAC2l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 21:28:41 -0500
Received: by mail-wm1-f50.google.com with SMTP id p17so13144821wma.1
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 18:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kSnwKgwM40skziS1ZVq65cexIk5tHL7vDFGoIpiNm6c=;
        b=DQu4F+s1F1oXbNFdCPkaOTuetluXPZjSsakTn/MO9khvIFVCwo3ecYY8QO3TnbrSyQ
         7r0m+y8pTSbMJidCeeY21TewVEKwtJbWiUuXwh1nIT8UYBElqe6j6dk7/s77VKqqjFuB
         XPVcgx8AD9XVuvelBvSdSP/qs07oVoO2ANtDdPOWZ1fTiw/KWwxzLDuHHg+RLDT1nWt4
         eWl1OfH249jjw+QS86mX1DVeiboGTm5OS4bLzAsj6JZXFg3zgJVRH3oQVMQpTr783JvL
         uWWXUEpmSFEuSUAzkLfKGgjBRgAVAQxWkmhsls5BlnJi9VsHtlmcWQ01ge+S8+Z9slmC
         qlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kSnwKgwM40skziS1ZVq65cexIk5tHL7vDFGoIpiNm6c=;
        b=Wlvvf2rx/OlZlK8osR+DTDXND19QuhEth4LD2aG6AYrCqFTbI1+3KtXwTZ6aG/OZm0
         uV0TvaxYC+2OwmTRAQHLuW3LpiZav9hBSttNfDMcaPd/8hfJ7e6bW0HFav5V6Y/uDWwv
         Cn2348rNB+BDy0fbmreBx/cmsJVAlbAeNjl7Vxb/wXaX1sKORyhnya29swxL9k1DMH64
         tHzWePBPTAvw18zC2VQl+PdrTEceIV+cZ1//t6wtHUyhslh45KYQHfX7Zcqvv1nHpHpk
         Zz/X/d7Fqo8pVu3JoRvyYNuObddAVw4va4Zm1XFa7ZqMMp+o8KoQAQ7GTmq9ES+T7hTu
         Mg3Q==
X-Gm-Message-State: APjAAAXSFtKC9Rd06oFN6MJOA5uzRlyaSDfSePCaf88boskXREiP3Fg0
        e3x/WX8JEDQetOJ2zsyEiK76fRfD
X-Google-Smtp-Source: APXvYqx/qUcbTb4VgQcjFf/b1gDfDv1D0gFnn7aPIPV1wB2OWHsmR1LrTqmetDwmY3IQZXK+i93HEA==
X-Received: by 2002:a1c:152:: with SMTP id 79mr20869814wmb.70.1575167316066;
        Sat, 30 Nov 2019 18:28:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm35312821wrb.67.2019.11.30.18.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Nov 2019 18:28:35 -0800 (PST)
Message-Id: <8fe9dfc30771574344c1a2fc5cd8f21f1a617388.1575167313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v7.git.1575167313.gitgitgadget@gmail.com>
References: <pull.436.v6.git.1574929833.gitgitgadget@gmail.com>
        <pull.436.v7.git.1575167313.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Dec 2019 02:28:32 +0000
Subject: [PATCH v7 2/3] git-gui: update status bar to track operations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Gilbert <JonathanG@iQmetrix.com>

Update the status bar to track updates as individual "operations" that
can overlap. Update all call sites to interact with the new status bar
mechanism. Update initialization to explicitly clear status text,
since otherwise it may persist across future operations.

Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
---
 git-gui.sh                |  27 +++--
 lib/blame.tcl             |  24 ++--
 lib/checkout_op.tcl       |  15 +--
 lib/choose_repository.tcl | 120 +++++++++++++-------
 lib/index.tcl             |  31 +++--
 lib/merge.tcl             |  14 ++-
 lib/status_bar.tcl        | 231 +++++++++++++++++++++++++++++++++-----
 7 files changed, 354 insertions(+), 108 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 0d21f5688b..e317f528af 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1797,10 +1797,10 @@ proc ui_status {msg} {
 	}
 }
 
-proc ui_ready {{test {}}} {
+proc ui_ready {} {
 	global main_status
 	if {[info exists main_status]} {
-		$main_status show [mc "Ready."] $test
+		$main_status show [mc "Ready."]
 	}
 }
 
@@ -2150,8 +2150,6 @@ proc incr_font_size {font {amt 1}} {
 ##
 ## ui commands
 
-set starting_gitk_msg [mc "Starting gitk... please wait..."]
-
 proc do_gitk {revs {is_submodule false}} {
 	global current_diff_path file_states current_diff_side ui_index
 	global _gitdir _gitworktree
@@ -2206,10 +2204,11 @@ proc do_gitk {revs {is_submodule false}} {
 		set env(GIT_WORK_TREE) $_gitworktree
 		cd $pwd
 
-		ui_status $::starting_gitk_msg
-		after 10000 {
-			ui_ready $starting_gitk_msg
-		}
+		set status_operation [$::main_status \
+			start \
+			[mc "Starting %s... please wait..." "gitk"]]
+
+		after 3500 [list $status_operation stop]
 	}
 }
 
@@ -2240,10 +2239,11 @@ proc do_git_gui {} {
 		set env(GIT_WORK_TREE) $_gitworktree
 		cd $pwd
 
-		ui_status $::starting_gitk_msg
-		after 10000 {
-			ui_ready $starting_gitk_msg
-		}
+		set status_operation [$::main_status \
+			start \
+			[mc "Starting %s... please wait..." "git-gui"]]
+
+		after 3500 [list $status_operation stop]
 	}
 }
 
@@ -4159,6 +4159,9 @@ if {$picked && [is_config_true gui.autoexplore]} {
 	do_explore
 }
 
+# Clear "Initializing..." status
+after 500 {$main_status show ""}
+
 # Local variables:
 # mode: tcl
 # indent-tabs-mode: t
diff --git a/lib/blame.tcl b/lib/blame.tcl
index a1aeb8b96e..62ec083667 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -24,6 +24,7 @@ field w_cviewer  ; # pane showing commit message
 field finder     ; # find mini-dialog frame
 field gotoline   ; # line goto mini-dialog frame
 field status     ; # status mega-widget instance
+field status_operation ; # operation displayed by status mega-widget
 field old_height ; # last known height of $w.file_pane
 
 
@@ -274,6 +275,7 @@ constructor new {i_commit i_path i_jump} {
 	pack $w_cviewer -expand 1 -fill both
 
 	set status [::status_bar::new $w.status]
+	set status_operation {}
 
 	menu $w.ctxm -tearoff 0
 	$w.ctxm add command \
@@ -602,16 +604,23 @@ method _exec_blame {cur_w cur_d options cur_s} {
 	} else {
 		lappend options $commit
 	}
+
+	# We may recurse in from another call to _exec_blame and already have
+	# a status operation.
+	if {$status_operation == {}} {
+		set status_operation [$status start \
+			$cur_s \
+			[mc "lines annotated"]]
+	} else {
+		$status_operation restart $cur_s
+	}
+
 	lappend options -- $path
 	set fd [eval git_read --nice blame $options]
 	fconfigure $fd -blocking 0 -translation lf -encoding utf-8
 	fileevent $fd readable [cb _read_blame $fd $cur_w $cur_d]
 	set current_fd $fd
 	set blame_lines 0
-
-	$status start \
-		$cur_s \
-		[mc "lines annotated"]
 }
 
 method _read_blame {fd cur_w cur_d} {
@@ -806,10 +815,11 @@ method _read_blame {fd cur_w cur_d} {
 				[mc "Loading original location annotations..."]
 		} else {
 			set current_fd {}
-			$status stop [mc "Annotation complete."]
+			$status_operation stop [mc "Annotation complete."]
+			set status_operation {}
 		}
 	} else {
-		$status update $blame_lines $total_lines
+		$status_operation update $blame_lines $total_lines
 	}
 } ifdeleted { catch {close $fd} }
 
@@ -1124,7 +1134,7 @@ method _blameparent {} {
 			set diffcmd [list diff-tree --unified=0 $cparent $cmit -- $new_path]
 		}
 		if {[catch {set fd [eval git_read $diffcmd]} err]} {
-			$status stop [mc "Unable to display parent"]
+			$status_operation stop [mc "Unable to display parent"]
 			error_popup [strcat [mc "Error loading diff:"] "\n\n$err"]
 			return
 		}
diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
index a5228297db..21ea768d80 100644
--- a/lib/checkout_op.tcl
+++ b/lib/checkout_op.tcl
@@ -341,9 +341,9 @@ method _readtree {} {
 	global HEAD
 
 	set readtree_d {}
-	$::main_status start \
+	set status_bar_operation [$::main_status start \
 		[mc "Updating working directory to '%s'..." [_name $this]] \
-		[mc "files checked out"]
+		[mc "files checked out"]]
 
 	set fd [git_read --stderr read-tree \
 		-m \
@@ -354,26 +354,27 @@ method _readtree {} {
 		$new_hash \
 		]
 	fconfigure $fd -blocking 0 -translation binary
-	fileevent $fd readable [cb _readtree_wait $fd]
+	fileevent $fd readable [cb _readtree_wait $fd $status_bar_operation]
 }
 
-method _readtree_wait {fd} {
+method _readtree_wait {fd status_bar_operation} {
 	global current_branch
 
 	set buf [read $fd]
-	$::main_status update_meter $buf
+	$status_bar_operation update_meter $buf
 	append readtree_d $buf
 
 	fconfigure $fd -blocking 1
 	if {![eof $fd]} {
 		fconfigure $fd -blocking 0
+		$status_bar_operation stop
 		return
 	}
 
 	if {[catch {close $fd}]} {
 		set err $readtree_d
 		regsub {^fatal: } $err {} err
-		$::main_status stop [mc "Aborted checkout of '%s' (file level merging is required)." [_name $this]]
+		$status_bar_operation stop [mc "Aborted checkout of '%s' (file level merging is required)." [_name $this]]
 		warn_popup [strcat [mc "File level merge required."] "
 
 $err
@@ -384,7 +385,7 @@ $err
 		return
 	}
 
-	$::main_status stop
+	$status_bar_operation stop
 	_after_readtree $this
 }
 
diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 80f5a59bbb..e54f3e66d8 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -9,6 +9,18 @@ field w_body      ; # Widget holding the center content
 field w_next      ; # Next button
 field w_quit      ; # Quit button
 field o_cons      ; # Console object (if active)
+
+# Status mega-widget instance during _do_clone2 (used by _copy_files and
+# _link_files). Widget is destroyed before _do_clone2 calls
+# _do_clone_checkout
+field o_status
+
+# Operation displayed by status mega-widget during _do_clone_checkout =>
+# _readtree_wait => _postcheckout_wait => _do_clone_submodules =>
+# _do_validate_submodule_cloning. The status mega-widget is a different
+# instance than that stored in $o_status in earlier operations.
+field o_status_op
+
 field w_types     ; # List of type buttons in clone
 field w_recentlist ; # Listbox containing recent repositories
 field w_localpath  ; # Entry widget bound to local_path
@@ -659,12 +671,12 @@ method _do_clone2 {} {
 
 	switch -exact -- $clone_type {
 	hardlink {
-		set o_cons [status_bar::two_line $w_body]
+		set o_status [status_bar::two_line $w_body]
 		pack $w_body -fill x -padx 10 -pady 10
 
-		$o_cons start \
+		set status_op [$o_status start \
 			[mc "Counting objects"] \
-			[mc "buckets"]
+			[mc "buckets"]]
 		update
 
 		if {[file exists [file join $objdir info alternates]]} {
@@ -689,6 +701,7 @@ method _do_clone2 {} {
 			} err]} {
 				catch {cd $pwd}
 				_clone_failed $this [mc "Unable to copy objects/info/alternates: %s" $err]
+				$status_op stop
 				return
 			}
 		}
@@ -700,7 +713,7 @@ method _do_clone2 {} {
 			-directory [file join $objdir] ??]
 		set bcnt [expr {[llength $buckets] + 2}]
 		set bcur 1
-		$o_cons update $bcur $bcnt
+		$status_op update $bcur $bcnt
 		update
 
 		file mkdir [file join .git objects pack]
@@ -708,7 +721,7 @@ method _do_clone2 {} {
 			-directory [file join $objdir pack] *] {
 			lappend tolink [file join pack $i]
 		}
-		$o_cons update [incr bcur] $bcnt
+		$status_op update [incr bcur] $bcnt
 		update
 
 		foreach i $buckets {
@@ -717,10 +730,10 @@ method _do_clone2 {} {
 				-directory [file join $objdir $i] *] {
 				lappend tolink [file join $i $j]
 			}
-			$o_cons update [incr bcur] $bcnt
+			$status_op update [incr bcur] $bcnt
 			update
 		}
-		$o_cons stop
+		$status_op stop
 
 		if {$tolink eq {}} {
 			info_popup [strcat \
@@ -747,6 +760,8 @@ method _do_clone2 {} {
 		if {!$i} return
 
 		destroy $w_body
+
+		set o_status {}
 	}
 	full {
 		set o_cons [console::embed \
@@ -781,9 +796,9 @@ method _do_clone2 {} {
 }
 
 method _copy_files {objdir tocopy} {
-	$o_cons start \
+	set status_op [$o_status start \
 		[mc "Copying objects"] \
-		[mc "KiB"]
+		[mc "KiB"]]
 	set tot 0
 	set cmp 0
 	foreach p $tocopy {
@@ -798,7 +813,7 @@ method _copy_files {objdir tocopy} {
 
 				while {![eof $f_in]} {
 					incr cmp [fcopy $f_in $f_cp -size 16384]
-					$o_cons update \
+					$status_op update \
 						[expr {$cmp / 1024}] \
 						[expr {$tot / 1024}]
 					update
@@ -808,17 +823,19 @@ method _copy_files {objdir tocopy} {
 				close $f_cp
 			} err]} {
 			_clone_failed $this [mc "Unable to copy object: %s" $err]
+			$status_op stop
 			return 0
 		}
 	}
+	$status_op stop
 	return 1
 }
 
 method _link_files {objdir tolink} {
 	set total [llength $tolink]
-	$o_cons start \
+	set status_op [$o_status start \
 		[mc "Linking objects"] \
-		[mc "objects"]
+		[mc "objects"]]
 	for {set i 0} {$i < $total} {} {
 		set p [lindex $tolink $i]
 		if {[catch {
@@ -827,15 +844,17 @@ method _link_files {objdir tolink} {
 					[file join $objdir $p]
 			} err]} {
 			_clone_failed $this [mc "Unable to hardlink object: %s" $err]
+			$status_op stop
 			return 0
 		}
 
 		incr i
 		if {$i % 5 == 0} {
-			$o_cons update $i $total
+			$status_op update $i $total
 			update
 		}
 	}
+	$status_op stop
 	return 1
 }
 
@@ -958,11 +977,26 @@ method _do_clone_checkout {HEAD} {
 		return
 	}
 
-	set o_cons [status_bar::two_line $w_body]
+	set status [status_bar::two_line $w_body]
 	pack $w_body -fill x -padx 10 -pady 10
-	$o_cons start \
+
+	# We start the status operation here.
+	#
+	# This function calls _readtree_wait as a callback.
+	#
+	# _readtree_wait in turn either calls _do_clone_submodules directly,
+	# or calls _postcheckout_wait as a callback which then calls
+	# _do_clone_submodules.
+	#
+	# _do_clone_submodules calls _do_validate_submodule_cloning.
+	#
+	# _do_validate_submodule_cloning stops the status operation.
+	#
+	# There are no other calls into this chain from other code.
+
+	set o_status_op [$status start \
 		[mc "Creating working directory"] \
-		[mc "files"]
+		[mc "files"]]
 
 	set readtree_err {}
 	set fd [git_read --stderr read-tree \
@@ -976,33 +1010,9 @@ method _do_clone_checkout {HEAD} {
 	fileevent $fd readable [cb _readtree_wait $fd]
 }
 
-method _do_validate_submodule_cloning {ok} {
-	if {$ok} {
-		$o_cons done $ok
-		set done 1
-	} else {
-		_clone_failed $this [mc "Cannot clone submodules."]
-	}
-}
-
-method _do_clone_submodules {} {
-	if {$recursive eq {true}} {
-		destroy $w_body
-		set o_cons [console::embed \
-			$w_body \
-			[mc "Cloning submodules"]]
-		pack $w_body -fill both -expand 1 -padx 10
-		$o_cons exec \
-			[list git submodule update --init --recursive] \
-			[cb _do_validate_submodule_cloning]
-	} else {
-		set done 1
-	}
-}
-
 method _readtree_wait {fd} {
 	set buf [read $fd]
-	$o_cons update_meter $buf
+	$o_status_op update_meter $buf
 	append readtree_err $buf
 
 	fconfigure $fd -blocking 1
@@ -1050,6 +1060,34 @@ method _postcheckout_wait {fd_ph} {
 	fconfigure $fd_ph -blocking 0
 }
 
+method _do_clone_submodules {} {
+	if {$recursive eq {true}} {
+		$o_status_op stop
+		set o_status_op {}
+
+		destroy $w_body
+
+		set o_cons [console::embed \
+			$w_body \
+			[mc "Cloning submodules"]]
+		pack $w_body -fill both -expand 1 -padx 10
+		$o_cons exec \
+			[list git submodule update --init --recursive] \
+			[cb _do_validate_submodule_cloning]
+	} else {
+		set done 1
+	}
+}
+
+method _do_validate_submodule_cloning {ok} {
+	if {$ok} {
+		$o_cons done $ok
+		set done 1
+	} else {
+		_clone_failed $this [mc "Cannot clone submodules."]
+	}
+}
+
 ######################################################################
 ##
 ## Open Existing Repository
diff --git a/lib/index.tcl b/lib/index.tcl
index 28d4d2a54e..62f4773ef4 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -45,13 +45,13 @@ proc _close_updateindex {fd after} {
 		wm deiconify $w
 		tkwait window $w
 
-		$::main_status stop
+		$::main_status stop_all
 		unlock_index
 		rescan $after 0
 		return
 	}
 
-	$::main_status stop
+	$::main_status stop_all
 	unlock_index
 	uplevel #0 $after
 }
@@ -67,7 +67,7 @@ proc update_indexinfo {msg path_list after} {
 	set batch [expr {int($total_cnt * .01) + 1}]
 	if {$batch > 25} {set batch 25}
 
-	$::main_status start $msg [mc "files"]
+	set status_bar_operation [$::main_status start $msg [mc "files"]]
 	set fd [git_write update-index -z --index-info]
 	fconfigure $fd \
 		-blocking 0 \
@@ -81,15 +81,18 @@ proc update_indexinfo {msg path_list after} {
 		$path_list \
 		$total_cnt \
 		$batch \
+		$status_bar_operation \
 		$after \
 		]
 }
 
-proc write_update_indexinfo {fd path_list total_cnt batch after} {
+proc write_update_indexinfo {fd path_list total_cnt batch status_bar_operation \
+	after} {
 	global update_index_cp
 	global file_states current_diff_path
 
 	if {$update_index_cp >= $total_cnt} {
+		$status_bar_operation stop
 		_close_updateindex $fd $after
 		return
 	}
@@ -119,7 +122,7 @@ proc write_update_indexinfo {fd path_list total_cnt batch after} {
 		display_file $path $new
 	}
 
-	$::main_status update $update_index_cp $total_cnt
+	$status_bar_operation update $update_index_cp $total_cnt
 }
 
 proc update_index {msg path_list after} {
@@ -133,7 +136,7 @@ proc update_index {msg path_list after} {
 	set batch [expr {int($total_cnt * .01) + 1}]
 	if {$batch > 25} {set batch 25}
 
-	$::main_status start $msg [mc "files"]
+	set status_bar_operation [$::main_status start $msg [mc "files"]]
 	set fd [git_write update-index --add --remove -z --stdin]
 	fconfigure $fd \
 		-blocking 0 \
@@ -147,15 +150,18 @@ proc update_index {msg path_list after} {
 		$path_list \
 		$total_cnt \
 		$batch \
+		$status_bar_operation \
 		$after \
 		]
 }
 
-proc write_update_index {fd path_list total_cnt batch after} {
+proc write_update_index {fd path_list total_cnt batch status_bar_operation \
+	after} {
 	global update_index_cp
 	global file_states current_diff_path
 
 	if {$update_index_cp >= $total_cnt} {
+		$status_bar_operation stop
 		_close_updateindex $fd $after
 		return
 	}
@@ -190,7 +196,7 @@ proc write_update_index {fd path_list total_cnt batch after} {
 		display_file $path $new
 	}
 
-	$::main_status update $update_index_cp $total_cnt
+	$status_bar_operation update $update_index_cp $total_cnt
 }
 
 proc checkout_index {msg path_list after} {
@@ -204,7 +210,7 @@ proc checkout_index {msg path_list after} {
 	set batch [expr {int($total_cnt * .01) + 1}]
 	if {$batch > 25} {set batch 25}
 
-	$::main_status start $msg [mc "files"]
+	set status_bar_operation [$::main_status start $msg [mc "files"]]
 	set fd [git_write checkout-index \
 		--index \
 		--quiet \
@@ -224,15 +230,18 @@ proc checkout_index {msg path_list after} {
 		$path_list \
 		$total_cnt \
 		$batch \
+		$status_bar_operation \
 		$after \
 		]
 }
 
-proc write_checkout_index {fd path_list total_cnt batch after} {
+proc write_checkout_index {fd path_list total_cnt batch status_bar_operation \
+	after} {
 	global update_index_cp
 	global file_states current_diff_path
 
 	if {$update_index_cp >= $total_cnt} {
+		$status_bar_operation stop
 		_close_updateindex $fd $after
 		return
 	}
@@ -253,7 +262,7 @@ proc write_checkout_index {fd path_list total_cnt batch after} {
 		}
 	}
 
-	$::main_status update $update_index_cp $total_cnt
+	$status_bar_operation update $update_index_cp $total_cnt
 }
 
 proc unstage_helper {txt paths} {
diff --git a/lib/merge.tcl b/lib/merge.tcl
index 9f253db5b3..8df8ffae55 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -241,23 +241,27 @@ Continue with resetting the current changes?"]
 	if {[ask_popup $op_question] eq {yes}} {
 		set fd [git_read --stderr read-tree --reset -u -v HEAD]
 		fconfigure $fd -blocking 0 -translation binary
-		fileevent $fd readable [namespace code [list _reset_wait $fd]]
-		$::main_status start [mc "Aborting"] [mc "files reset"]
+		set status_bar_operation [$::main_status \
+			start \
+			[mc "Aborting"] \
+			[mc "files reset"]
+		fileevent $fd readable [namespace code [list \
+			_reset_wait $fd $status_bar_operation]]
 	} else {
 		unlock_index
 	}
 }
 
-proc _reset_wait {fd} {
+proc _reset_wait {fd status_bar_operation} {
 	global ui_comm
 
-	$::main_status update_meter [read $fd]
+	$status_bar_operation update_meter [read $fd]
 
 	fconfigure $fd -blocking 1
 	if {[eof $fd]} {
 		set fail [catch {close $fd} err]
-		$::main_status stop
 		unlock_index
+		$status_bar_operation stop
 
 		$ui_comm delete 0.0 end
 		$ui_comm edit modified false
diff --git a/lib/status_bar.tcl b/lib/status_bar.tcl
index 02111a1742..d32b14142f 100644
--- a/lib/status_bar.tcl
+++ b/lib/status_bar.tcl
@@ -1,16 +1,42 @@
 # git-gui status bar mega-widget
 # Copyright (C) 2007 Shawn Pearce
 
+# The status_bar class manages the entire status bar. It is possible for
+# multiple overlapping asynchronous operations to want to display status
+# simultaneously. Each one receives a status_bar_operation when it calls the
+# start method, and the status bar combines all active operations into the
+# line of text it displays. Most of the time, there will be at most one
+# ongoing operation.
+#
+# Note that the entire status bar can be either in single-line or two-line
+# mode, depending on the constructor. Multiple active operations are only
+# supported for single-line status bars.
+
 class status_bar {
 
+field allow_multiple ; # configured at construction
+
 field w         ; # our own window path
 field w_l       ; # text widget we draw messages into
 field w_c       ; # canvas we draw a progress bar into
 field c_pack    ; # script to pack the canvas with
-field status  {}; # single line of text we show
-field prefix  {}; # text we format into status
-field units   {}; # unit of progress
-field meter   {}; # current core git progress meter (if active)
+
+field baseline_text   ; # text to show if there are no operations
+field status_bar_text ; # combined text for all operations
+
+field operations ; # list of current ongoing operations
+
+# The status bar can display a progress bar, updated when consumers call the
+# update method on their status_bar_operation. When there are multiple
+# operations, the status bar shows the combined status of all operations.
+#
+# When an overlapping operation completes, the progress bar is going to
+# abruptly have one fewer operation in the calculation, causing a discontinuity.
+# Therefore, whenever an operation completes, if it is not the last operation,
+# this counter is increased, and the progress bar is calculated as though there
+# were still another operation at 100%. When the last operation completes, this
+# is reset to 0.
+field completed_operation_count
 
 constructor new {path} {
 	global use_ttk NS
@@ -18,12 +44,19 @@ constructor new {path} {
 	set w_l $w.l
 	set w_c $w.c
 
+	# Standard single-line status bar: Permit overlapping operations
+	set allow_multiple 1
+
+	set baseline_text ""
+	set operations [list]
+	set completed_operation_count 0
+
 	${NS}::frame $w
 	if {!$use_ttk} {
 		$w configure -borderwidth 1 -relief sunken
 	}
 	${NS}::label $w_l \
-		-textvariable @status \
+		-textvariable @status_bar_text \
 		-anchor w \
 		-justify left
 	pack $w_l -side left
@@ -44,9 +77,16 @@ constructor two_line {path} {
 	set w_l $w.l
 	set w_c $w.c
 
+	# Two-line status bar: Only one ongoing operation permitted.
+	set allow_multiple 0
+
+	set baseline_text ""
+	set operations [list]
+	set completed_operation_count 0
+
 	${NS}::frame $w
 	${NS}::label $w_l \
-		-textvariable @status \
+		-textvariable @status_bar_text \
 		-anchor w \
 		-justify left
 	pack $w_l -anchor w -fill x
@@ -56,7 +96,7 @@ constructor two_line {path} {
 	return $this
 }
 
-method start {msg uds} {
+method ensure_canvas {} {
 	if {[winfo exists $w_c]} {
 		$w_c coords bar 0 0 0 20
 	} else {
@@ -68,31 +108,170 @@ method start {msg uds} {
 		$w_c create rectangle 0 0 0 20 -tags bar -fill navy
 		eval $c_pack
 	}
+}
+
+method show {msg} {
+	$this ensure_canvas
+	set baseline_text $msg
+	$this refresh
+}
+
+method start {msg {uds {}}} {
+	set baseline_text ""
+
+	if {!$allow_multiple && [llength $operations]} {
+		return [lindex $operations 0]
+	}
+
+	$this ensure_canvas
+
+	set operation [status_bar_operation::new $this $msg $uds]
+
+	lappend operations $operation
+
+	$this refresh
+
+	return $operation
+}
+
+method refresh {} {
+	set new_text ""
+
+	set total [expr $completed_operation_count * 100]
+	set have $total
+
+	foreach operation $operations {
+		if {$new_text != ""} {
+			append new_text " / "
+		}
+
+		append new_text [$operation get_status]
+
+		set total [expr $total + 100]
+		set have [expr $have + [$operation get_progress]]
+	}
+
+	if {$new_text == ""} {
+		set new_text $baseline_text
+	}
+
+	set status_bar_text $new_text
+
+	if {[winfo exists $w_c]} {
+		set pixel_width 0
+		if {$have > 0} {
+			set pixel_width [expr {[winfo width $w_c] * $have / $total}]
+		}
+
+		$w_c coords bar 0 0 $pixel_width 20
+	}
+}
+
+method stop {operation stop_msg} {
+	set idx [lsearch $operations $operation]
+
+	if {$idx >= 0} {
+		set operations [lreplace $operations $idx $idx]
+		set completed_operation_count [expr \
+			$completed_operation_count + 1]
+
+		if {[llength $operations] == 0} {
+			set completed_operation_count 0
+
+			destroy $w_c
+			if {$stop_msg ne {}} {
+				set baseline_text $stop_msg
+			}
+		}
+
+		$this refresh
+	}
+}
+
+method stop_all {{stop_msg {}}} {
+	# This makes the operation's call to stop a no-op.
+	set operations_copy $operations
+	set operations [list]
+
+	foreach operation $operations_copy {
+		$operation stop
+	}
+
+	if {$stop_msg ne {}} {
+		set baseline_text $stop_msg
+	}
+
+	$this refresh
+}
+
+method _delete {current} {
+	if {$current eq $w} {
+		delete_this
+	}
+}
+
+}
+
+# The status_bar_operation class tracks a single consumer's ongoing status bar
+# activity, with the context that there are a few situations where multiple
+# overlapping asynchronous operations might want to display status information
+# simultaneously. Instances of status_bar_operation are created by calling
+# start on the status_bar, and when the caller is done with its stauts bar
+# operation, it calls stop on the operation.
+
+class status_bar_operation {
+
+field status_bar; # reference back to the status_bar that owns this object
+
+field is_active;
+
+field status   {}; # single line of text we show
+field progress {}; # current progress (0 to 100)
+field prefix   {}; # text we format into status
+field units    {}; # unit of progress
+field meter    {}; # current core git progress meter (if active)
+
+constructor new {owner msg uds} {
+	set status_bar $owner
 
 	set status $msg
+	set progress 0
 	set prefix $msg
 	set units  $uds
 	set meter  {}
+
+	set is_active 1
+
+	return $this
 }
 
+method get_is_active {} { return $is_active }
+method get_status {} { return $status }
+method get_progress {} { return $progress }
+
 method update {have total} {
-	set pdone 0
-	set cdone 0
+	if {!$is_active} { return }
+
+	set progress 0
+
 	if {$total > 0} {
-		set pdone [expr {100 * $have / $total}]
-		set cdone [expr {[winfo width $w_c] * $have / $total}]
+		set progress [expr {100 * $have / $total}]
 	}
 
 	set prec [string length [format %i $total]]
+
 	set status [mc "%s ... %*i of %*i %s (%3i%%)" \
 		$prefix \
 		$prec $have \
 		$prec $total \
-		$units $pdone]
-	$w_c coords bar 0 0 $cdone 20
+		$units $progress]
+
+	$status_bar refresh
 }
 
 method update_meter {buf} {
+	if {!$is_active} { return }
+
 	append meter $buf
 	set r [string last "\r" $meter]
 	if {$r == -1} {
@@ -109,23 +288,25 @@ method update_meter {buf} {
 	}
 }
 
-method stop {{msg {}}} {
-	destroy $w_c
-	if {$msg ne {}} {
-		set status $msg
+method stop {{stop_msg {}}} {
+	if {$is_active} {
+		set is_active 0
+		$status_bar stop $this $stop_msg
 	}
 }
 
-method show {msg {test {}}} {
-	if {$test eq {} || $status eq $test} {
-		set status $msg
-	}
+method restart {msg} {
+	if {!$is_active} { return }
+
+	set status $msg
+	set prefix $msg
+	set meter {}
+	$status_bar refresh
 }
 
-method _delete {current} {
-	if {$current eq $w} {
-		delete_this
-	}
+method _delete {} {
+	stop
+	delete_this
 }
 
 }
-- 
gitgitgadget

