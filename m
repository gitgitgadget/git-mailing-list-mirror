Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99FFC33C9C
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32FC20823
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9Y+MRZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfKXUiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 15:38:05 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33953 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfKXUiF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 15:38:05 -0500
Received: by mail-wr1-f54.google.com with SMTP id t2so15093691wrr.1
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 12:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VZd/4jNNW6VNL/97yQRyCymZWUFZkEX8GQVoFf5sNCU=;
        b=T9Y+MRZxyxDiZBwLpcnmXtE0GMyeISsZOPQVxx5ASJs2ScqfXBvijDRkKIBjjoxTU3
         WFpCoddBYDno7K5aL6qs+51G7zBc+BE/1JYl+pTTvoXBxxpv6Tx2yS1nGhbOzzISwqcS
         zqn/CSG+6UNj4gq4T4vNinuIYshU8mgp1gH6yvE8zCNz2LR8cHgd0YyPs1epFkZ60ukR
         dXDOs2Wwc51RfDCxIK9blqWKwHKVMKLzyOPJEsqfH19cyqQhMWD3NU5XjuWtEU5QRYr8
         Khy0u1uAe4YftHwWKJR1aOXPsUQXwJ+px8nhyjowjzL8aQcKmN/YGxspVpwgkTKMtFoZ
         Bejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VZd/4jNNW6VNL/97yQRyCymZWUFZkEX8GQVoFf5sNCU=;
        b=cM+9RkoSUYlDVRMP/BEatxLo1OOTXUE6wgEKCy8r9W3Z65ooe9f5IFjGZYyynJ6tBl
         5AgGVXj/F2zgGr2yl3a16Pfow10fv7R2JbDhN6l2elwzhk7dYJqMgQvKlgKrEKSm2fmz
         pdGqDdaxvgjjUOnkbG+q1JOC/vGQlYMWNM5gzOAaQikeogUgu5tni+tUKSTkGdtom26Z
         1IuBSwwZ1Wm4bYWss7Df/bd7wEApgOswuDVqKmlq+JVYjdRSrbYaAnYaJJXIUlL9/8a7
         +2s+ZyT/vD2FUaXnjFlQYia6VLK9650rj5liFwHK6hljCvQaRhJSXw7ZQ8MhM1CVL/+8
         YeHw==
X-Gm-Message-State: APjAAAVWCKitOifU5x7Wlh9aAsPVt3y+sJLUeaIidY5FCf2MAsTmACVC
        faoYbAxPfxHb4S/bWkp/HWmPlPRi
X-Google-Smtp-Source: APXvYqwyb3W6IBsOrkT2csMorf6YjpTKddaW0NHO5ppv+3hfIhRGDUiM17rHPdwzAa7pvcTzlzu5NQ==
X-Received: by 2002:adf:f489:: with SMTP id l9mr26857733wro.337.1574627879176;
        Sun, 24 Nov 2019 12:37:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10sm5939371wmd.26.2019.11.24.12.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 12:37:58 -0800 (PST)
Message-Id: <aa05a78d285dd9c5f4897b03467f1d43d7a5ad83.1574627876.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
References: <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
        <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Nov 2019 20:37:54 +0000
Subject: [PATCH v5 2/3] git-gui: update status bar to track operations
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
 git-gui.sh          |   7 +-
 lib/blame.tcl       |  22 +++--
 lib/checkout_op.tcl |  15 +--
 lib/index.tcl       |  31 +++---
 lib/merge.tcl       |  14 ++-
 lib/status_bar.tcl  | 228 +++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 260 insertions(+), 57 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 0d21f5688b..db02e399e7 100755
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
index a1aeb8b96e..888f98bab2 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -24,6 +24,7 @@ field w_cviewer  ; # pane showing commit message
 field finder     ; # find mini-dialog frame
 field gotoline   ; # line goto mini-dialog frame
 field status     ; # status mega-widget instance
+field status_operation ; # status operation
 field old_height ; # last known height of $w.file_pane
 
 
@@ -274,6 +275,7 @@ constructor new {i_commit i_path i_jump} {
 	pack $w_cviewer -expand 1 -fill both
 
 	set status [::status_bar::new $w.status]
+	set status_operation {}
 
 	menu $w.ctxm -tearoff 0
 	$w.ctxm add command \
@@ -602,16 +604,21 @@ method _exec_blame {cur_w cur_d options cur_s} {
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
@@ -806,10 +813,11 @@ method _read_blame {fd cur_w cur_d} {
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
 
@@ -1124,7 +1132,7 @@ method _blameparent {} {
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
index 02111a1742..c4bff98856 100644
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
@@ -44,9 +77,15 @@ constructor two_line {path} {
 	set w_l $w.l
 	set w_c $w.c
 
+	# Two-line status bar: Only one ongoing operation permitted.
+	set allow_multiple 0
+
+	set baseline_text ""
+	set operations [list]
+
 	${NS}::frame $w
 	${NS}::label $w_l \
-		-textvariable @status \
+		-textvariable @status_bar_text \
 		-anchor w \
 		-justify left
 	pack $w_l -anchor w -fill x
@@ -56,7 +95,7 @@ constructor two_line {path} {
 	return $this
 }
 
-method start {msg uds} {
+method ensure_canvas {} {
 	if {[winfo exists $w_c]} {
 		$w_c coords bar 0 0 0 20
 	} else {
@@ -68,31 +107,170 @@ method start {msg uds} {
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
+method start {msg uds} {
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
@@ -109,23 +287,23 @@ method update_meter {buf} {
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
+method show {msg} {
+	if {!$is_active} { return }
+
+	set status $msg
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

