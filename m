Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_BLACK
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D14A920986
	for <e@80x24.org>; Mon,  3 Oct 2016 10:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbcJCKYB (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 06:24:01 -0400
Received: from know-smtprelay-omc-2.server.virginmedia.net ([80.0.253.66]:57258
        "EHLO know-smtprelay-omc-2.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752088AbcJCKX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 06:23:59 -0400
Received: from red.patthoyts.tk ([82.37.62.216])
        by know-smtprelay-2-imp with bizsmtp
        id qyPw1t0094fw4HN01yPwhv; Mon, 03 Oct 2016 11:23:56 +0100
X-Originating-IP: [82.37.62.216]
X-Spam: 0
X-Authority: v=2.1 cv=XKnNMlVE c=1 sm=1 tr=0 a=y+L2qvWGb0b1Khfuzk0aNQ==:117
 a=y+L2qvWGb0b1Khfuzk0aNQ==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=xqWC_Br6kY4A:10 a=1oJP67jkp3AA:10 a=ZZnuYtJkoWoA:10
 a=CH0kA5CcgfcA:10 a=7vUEEOO_AAAA:8 a=Rf460ibiAAAA:8 a=BotQevD6EoBLrk4-OCYA:9
 a=lpFN9VXSQOqDfEBK:21 a=qU7mjC5p6l3tWST5:21 a=qh6gD-897udMqpAA:21
 a=rYX3hUVbOoYA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
 a=X_Y1BvaDLgsXqAkisrwy:22 a=-X4ai1wA6IXBCEr1GZS2:22
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2001:470:1f1d:26c::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by red.patthoyts.tk (Postfix) with ESMTPS id 0461819602E4;
        Mon,  3 Oct 2016 11:23:56 +0100 (BST)
From:   Pat Thoyts <patthoyts@users.sourceforge.net>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/5] git-gui: fix incorrect use of Tcl append command
References: <1462704778-4722-1-git-send-email-vascomalmeida@sapo.pt>
        <1462704778-4722-4-git-send-email-vascomalmeida@sapo.pt>
X-Face:  .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
Reply-to: patthoyts@users.sourceforge.net
X-Url:  http://www.patthoyts.tk/
Date:   Mon, 03 Oct 2016 11:23:55 +0100
In-Reply-To: <1462704778-4722-4-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Sun, 8 May 2016 10:52:57 +0000")
Message-ID: <87a8elwx1g.fsf@red.patthoyts.tk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

>Fix wrong use of append command in strings marked for translation.
>According to Tcl/Tk Documentation [1],
>	append varName ?value value value ...?
>appends all value arguments to the current value of variable varName.
>This means that
>	append "[appname] ([reponame]): " [mc "File Viewer"]
>is setting a variable named "[appname] ([reponame]): " to the output of
>[mc "File Viewer"], rather than returning the concatenation of both
>expressions as one might expect.
>
>The format for some strings enables, for instance, a French translator
>to translate like "%s (%s) : Create Branch" (space before colon).
>Conversely, strings already translated will be marked as fuzzy and the
>translator must update them herself.
>
>For some cases, use alternative way for concatenation instead of using
>strcat procedure defined in git-gui.sh.
>
>Reference: 31bb1d1 ("git-gui: Paper bag fix missing translated strings",
>2007-09-14) fixes the same issue slightly differently.
>
>[1] http://www.tcl.tk/man/tcl/TclCmd/append.htm
>
>Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
>---
> lib/blame.tcl                |  2 +-
> lib/branch_checkout.tcl      |  2 +-
> lib/branch_create.tcl        |  2 +-
> lib/branch_delete.tcl        |  2 +-
> lib/branch_rename.tcl        |  2 +-
> lib/browser.tcl              |  4 ++--
> lib/database.tcl             |  2 +-
> lib/diff.tcl                 | 11 +++++------
> lib/error.tcl                |  4 ++--
> lib/merge.tcl                |  2 +-
> lib/remote_add.tcl           |  2 +-
> lib/remote_branch_delete.tcl |  2 +-
> lib/shortcut.tcl             |  6 +++---
> lib/tools_dlg.tcl            |  6 +++---
> lib/transport.tcl            |  2 +-
> 15 files changed, 25 insertions(+), 26 deletions(-)
>
>diff --git a/lib/blame.tcl b/lib/blame.tcl
>index b1d15f4..a1aeb8b 100644
>--- a/lib/blame.tcl
>+++ b/lib/blame.tcl
>@@ -70,7 +70,7 @@ constructor new {i_commit i_path i_jump} {
> 	set path   $i_path
> 
> 	make_toplevel top w
>-	wm title $top [append "[appname] ([reponame]): " [mc "File Viewer"]]
>+	wm title $top [mc "%s (%s): File Viewer" [appname] [reponame]]
> 
> 	set font_w [font measure font_diff "0"]
> 
>diff --git a/lib/branch_checkout.tcl b/lib/branch_checkout.tcl
>index 2e459a8..d06037d 100644
>--- a/lib/branch_checkout.tcl
>+++ b/lib/branch_checkout.tcl
>@@ -13,7 +13,7 @@ constructor dialog {} {
> 	global use_ttk NS
> 	make_dialog top w
> 	wm withdraw $w
>-	wm title $top [append "[appname] ([reponame]): " [mc "Checkout Branch"]]
>+	wm title $top [mc "%s (%s): Checkout Branch" [appname] [reponame]]
> 	if {$top ne {.}} {
> 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
> 	}
>diff --git a/lib/branch_create.tcl b/lib/branch_create.tcl
>index 4bb9077..ba367d5 100644
>--- a/lib/branch_create.tcl
>+++ b/lib/branch_create.tcl
>@@ -20,7 +20,7 @@ constructor dialog {} {
> 
> 	make_dialog top w
> 	wm withdraw $w
>-	wm title $top [append "[appname] ([reponame]): " [mc "Create Branch"]]
>+	wm title $top [mc "%s (%s): Create Branch" [appname] [reponame]]
> 	if {$top ne {.}} {
> 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
> 	}
>diff --git a/lib/branch_delete.tcl b/lib/branch_delete.tcl
>index 9aef0c9..a505163 100644
>--- a/lib/branch_delete.tcl
>+++ b/lib/branch_delete.tcl
>@@ -13,7 +13,7 @@ constructor dialog {} {
> 
> 	make_dialog top w
> 	wm withdraw $w
>-	wm title $top [append "[appname] ([reponame]): " [mc "Delete Branch"]]
>+	wm title $top [mc "%s (%s): Delete Branch" [appname] [reponame]]
> 	if {$top ne {.}} {
> 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
> 	}
>diff --git a/lib/branch_rename.tcl b/lib/branch_rename.tcl
>index 6e510ec..3a2d79a 100644
>--- a/lib/branch_rename.tcl
>+++ b/lib/branch_rename.tcl
>@@ -12,7 +12,7 @@ constructor dialog {} {
> 
> 	make_dialog top w
> 	wm withdraw $w
>-	wm title $top [append "[appname] ([reponame]): " [mc "Rename Branch"]]
>+	wm title $top [mc "%s (%s): Rename Branch" [appname] [reponame]]
> 	if {$top ne {.}} {
> 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
> 	}
>diff --git a/lib/browser.tcl b/lib/browser.tcl
>index 0328338..1580493 100644
>--- a/lib/browser.tcl
>+++ b/lib/browser.tcl
>@@ -24,7 +24,7 @@ constructor new {commit {path {}}} {
> 	global cursor_ptr M1B use_ttk NS
> 	make_dialog top w
> 	wm withdraw $top
>-	wm title $top [append "[appname] ([reponame]): " [mc "File Browser"]]
>+	wm title $top [mc "%s (%s): File Browser" [appname] [reponame]]
> 
> 	if {$path ne {}} {
> 		if {[string index $path end] ne {/}} {
>@@ -272,7 +272,7 @@ constructor dialog {} {
> 	global use_ttk NS
> 	make_dialog top w
> 	wm withdraw $top
>-	wm title $top [append "[appname] ([reponame]): " [mc "Browse Branch Files"]]
>+	wm title $top [mc "%s (%s): Browse Branch Files" [appname] [reponame]]
> 	if {$top ne {.}} {
> 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
> 		wm transient $top .
>diff --git a/lib/database.tcl b/lib/database.tcl
>index 8bd4b8e..8578308 100644
>--- a/lib/database.tcl
>+++ b/lib/database.tcl
>@@ -63,7 +63,7 @@ proc do_stats {} {
> 	bind $w <Visibility> "grab $w; focus $w.buttons.close"
> 	bind $w <Key-Escape> [list destroy $w]
> 	bind $w <Key-Return> [list destroy $w]
>-	wm title $w [append "[appname] ([reponame]): " [mc "Database Statistics"]]
>+	wm title $w [mc "%s (%s): Database Statistics" [appname] [reponame]]
> 	wm deiconify $w
> 	tkwait window $w
> }
>diff --git a/lib/diff.tcl b/lib/diff.tcl
>index 0d56986..1228ce2 100644
>--- a/lib/diff.tcl
>+++ b/lib/diff.tcl
>@@ -220,10 +220,9 @@ proc show_other_diff {path w m cont_info} {
> 		}
> 		$ui_diff conf -state normal
> 		if {$type eq {submodule}} {
>-			$ui_diff insert end [append \
>-				"* " \
>-				[mc "Git Repository (subproject)"] \
>-				"\n"] d_info
>+			$ui_diff insert end \
>+				"* [mc "Git Repository (subproject)"]\n" \
>+				d_info
> 		} elseif {![catch {set type [exec file $path]}]} {
> 			set n [string length $path]
> 			if {[string equal -length $n $path $type]} {
>@@ -608,7 +607,7 @@ proc apply_hunk {x y} {
> 		puts -nonewline $p $current_diff_header
> 		puts -nonewline $p [$ui_diff get $s_lno $e_lno]
> 		close $p} err]} {
>-		error_popup [append $failed_msg "\n\n$err"]
>+		error_popup "$failed_msg\n\n$err"
> 		unlock_index
> 		return
> 	}
>@@ -826,7 +825,7 @@ proc apply_range_or_line {x y} {
> 		puts -nonewline $p $current_diff_header
> 		puts -nonewline $p $wholepatch
> 		close $p} err]} {
>-		error_popup [append $failed_msg "\n\n$err"]
>+		error_popup "$failed_msg\n\n$err"
> 	}
> 
> 	unlock_index
>diff --git a/lib/error.tcl b/lib/error.tcl
>index 9b7d229..71dc860 100644
>--- a/lib/error.tcl
>+++ b/lib/error.tcl
>@@ -17,7 +17,7 @@ proc error_popup {msg} {
> 	set cmd [list tk_messageBox \
> 		-icon error \
> 		-type ok \
>-		-title [append "$title: " [mc "error"]] \
>+		-title [mc "%s: error" $title] \
> 		-message $msg]
> 	if {[winfo ismapped [_error_parent]]} {
> 		lappend cmd -parent [_error_parent]
>@@ -33,7 +33,7 @@ proc warn_popup {msg} {
> 	set cmd [list tk_messageBox \
> 		-icon warning \
> 		-type ok \
>-		-title [append "$title: " [mc "warning"]] \
>+		-title [mc "%s: warning" $title] \
> 		-message $msg]
> 	if {[winfo ismapped [_error_parent]]} {
> 		lappend cmd -parent [_error_parent]
>diff --git a/lib/merge.tcl b/lib/merge.tcl
>index 460d32f..b2de109 100644
>--- a/lib/merge.tcl
>+++ b/lib/merge.tcl
>@@ -149,7 +149,7 @@ constructor dialog {} {
> 	}
> 
> 	make_dialog top w
>-	wm title $top [append "[appname] ([reponame]): " [mc "Merge"]]
>+	wm title $top [mc "%s (%s): Merge" [appname] [reponame]]
> 	if {$top ne {.}} {
> 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
> 	}
>diff --git a/lib/remote_add.tcl b/lib/remote_add.tcl
>index 50029d0..480a6b3 100644
>--- a/lib/remote_add.tcl
>+++ b/lib/remote_add.tcl
>@@ -17,7 +17,7 @@ constructor dialog {} {
> 
> 	make_dialog top w
> 	wm withdraw $top
>-	wm title $top [append "[appname] ([reponame]): " [mc "Add Remote"]]
>+	wm title $top [mc "%s (%s): Add Remote" [appname] [reponame]]
> 	if {$top ne {.}} {
> 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
> 	}
>diff --git a/lib/remote_branch_delete.tcl b/lib/remote_branch_delete.tcl
>index fcc06d0..5ba9fca 100644
>--- a/lib/remote_branch_delete.tcl
>+++ b/lib/remote_branch_delete.tcl
>@@ -26,7 +26,7 @@ constructor dialog {} {
> 	global all_remotes M1B use_ttk NS
> 
> 	make_dialog top w
>-	wm title $top [append "[appname] ([reponame]): " [mc "Delete Branch Remotely"]]
>+	wm title $top [mc "%s (%s): Delete Branch Remotely" [appname] [reponame]]
> 	if {$top ne {.}} {
> 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
> 	}
>diff --git a/lib/shortcut.tcl b/lib/shortcut.tcl
>index 78878ef..135086b 100644
>--- a/lib/shortcut.tcl
>+++ b/lib/shortcut.tcl
>@@ -5,7 +5,7 @@ proc do_windows_shortcut {} {
> 	global _gitworktree
> 	set fn [tk_getSaveFile \
> 		-parent . \
>-		-title [append "[appname] ([reponame]): " [mc "Create Desktop Icon"]] \
>+		-title [mc "%s (%s): Create Desktop Icon" [appname] [reponame]] \
> 		-initialfile "Git [reponame].lnk"]
> 	if {$fn != {}} {
> 		if {[file extension $fn] ne {.lnk}} {
>@@ -37,7 +37,7 @@ proc do_cygwin_shortcut {} {
> 	}
> 	set fn [tk_getSaveFile \
> 		-parent . \
>-		-title [append "[appname] ([reponame]): " [mc "Create Desktop Icon"]] \
>+		-title [mc "%s (%s): Create Desktop Icon" [appname] [reponame]] \
> 		-initialdir $desktop \
> 		-initialfile "Git [reponame].lnk"]
> 	if {$fn != {}} {
>@@ -69,7 +69,7 @@ proc do_macosx_app {} {
> 
> 	set fn [tk_getSaveFile \
> 		-parent . \
>-		-title [append "[appname] ([reponame]): " [mc "Create Desktop Icon"]] \
>+		-title [mc "%s (%s): Create Desktop Icon" [appname] [reponame]] \
> 		-initialdir [file join $env(HOME) Desktop] \
> 		-initialfile "Git [reponame].app"]
> 	if {$fn != {}} {
>diff --git a/lib/tools_dlg.tcl b/lib/tools_dlg.tcl
>index 7eeda9d..c05413c 100644
>--- a/lib/tools_dlg.tcl
>+++ b/lib/tools_dlg.tcl
>@@ -19,7 +19,7 @@ constructor dialog {} {
> 	global repo_config use_ttk NS
> 
> 	make_dialog top w
>-	wm title $top [append "[appname] ([reponame]): " [mc "Add Tool"]]
>+	wm title $top [mc "%s (%s): Add Tool" [appname] [reponame]]
> 	if {$top ne {.}} {
> 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
> 		wm transient $top .
>@@ -184,7 +184,7 @@ constructor dialog {} {
> 	load_config 1
> 
> 	make_dialog top w
>-	wm title $top [append "[appname] ([reponame]): " [mc "Remove Tool"]]
>+	wm title $top [mc "%s (%s): Remove Tool" [appname] [reponame]]
> 	if {$top ne {.}} {
> 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
> 		wm transient $top .
>@@ -280,7 +280,7 @@ constructor dialog {fullname} {
> 	}
> 
> 	make_dialog top w -autodelete 0
>-	wm title $top [append "[appname] ([reponame]): " $title]
>+	wm title $top "[mc "%s (%s):" [appname] [reponame]] $title"
> 	if {$top ne {.}} {
> 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
> 		wm transient $top .
>diff --git a/lib/transport.tcl b/lib/transport.tcl
>index e5d211e..a1a424a 100644
>--- a/lib/transport.tcl
>+++ b/lib/transport.tcl
>@@ -226,7 +226,7 @@ proc do_push_anywhere {} {
> 	bind $w <Visibility> "grab $w; focus $w.buttons.create"
> 	bind $w <Key-Escape> "destroy $w"
> 	bind $w <Key-Return> [list start_push_anywhere_action $w]
>-	wm title $w [append "[appname] ([reponame]): " [mc "Push"]]
>+	wm title $w [mc "%s (%s): Push" [appname] [reponame]]
> 	wm deiconify $w
> 	tkwait window $w
> }

Well spotted!

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
