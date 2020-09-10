Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9BDC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 08:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FA22076D
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 08:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGe1rnX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgIJI3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbgIJI15 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 04:27:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B043C061756
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 01:27:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v15so3854058pgh.6
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 01:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GpMBZW4bENy3AuKNKeHlHuG146+H9eR0CEkePAGSwfw=;
        b=vGe1rnX1MkHj0yCyoqG1fU5bB0dErjvOMuBKhXiUCFIq28lm3NMCJZAiVo9FncGiaL
         eb7o/eMcKHQ1vXKMS/HSmUddlig/CNNtPl1nncty82/8q/JXPiZpxTuvfaLttHNn9d1X
         gAK9K32vOQMGf9pROTc4WmmzN0oLeT8oNJE2a4K9MCoSddSl05AoCnzi0V8lFEDgRaeJ
         KpQfMvrAAXPgg9KYFMctSHp5+pvM3s/J62CHzQ4+/p7+AZWRMaoDQVorOx4sifHGYNXO
         QuGPmyY+xZYcOV/IAexWgzkKmk/DEyL8R7Pf4rcNc7IXUiJtV8jHi5FTRciPrVKcmEjv
         safw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpMBZW4bENy3AuKNKeHlHuG146+H9eR0CEkePAGSwfw=;
        b=MU2TbOCypYzZKrtL/CTTEHPVzbUKYy4sa/LvgnOdmGc2Uk/c/JTGUh71VKKuWrwhXJ
         +knbUd305OPWXeepYYMW5xnbpLgr9lwyI8sKyrM9WUTBahhQrPEuTobBRi0TBn4RTmOG
         JgtSJr/xyS1tJQSR/xatVqSBbSGJvm8N3ld/e3SsjTF5UeFjE1QU+dQDFWBcMbADk9FG
         +4HEhC5ei4DEX0p9vqt8XRfGws8dwuKBa+ilzF3JKZFunpo+znE0ZHhrKig/wh/7qSmF
         hWz+Wp0wLP+OOkHtHxmoIzd6JCQ1XFP/p7101TCp5FGm7EWUH1k0j+dGWDzYNKrwzc97
         bZBA==
X-Gm-Message-State: AOAM530VR7Ja4X17Wie4+uLH0dB+bTR1nAZ5UImmV0ZsjkyXdNPRMyg6
        TTOoxNtFm6yPMyMB7msuTTnGZ+ZNjpM=
X-Google-Smtp-Source: ABdhPJy9K3Zc/GOMBLs1cRqT8AIBScUBZEp3B/pMeTxP/ZOaU1sbLZrZu04QMjf82ziy3ME2cuq2rA==
X-Received: by 2002:a63:1644:: with SMTP id 4mr3668623pgw.232.1599726474021;
        Thu, 10 Sep 2020 01:27:54 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id p11sm1345155pjz.44.2020.09.10.01.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:27:53 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 2/2] gitk: manually fix whitespace errors
Date:   Thu, 10 Sep 2020 01:27:42 -0700
Message-Id: <1b577821168c824f81bb0229efeea2e28536254c.1599726439.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1599726439.git.liu.denton@gmail.com>
References: <cover.1599726439.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit mechanically converted four-space indents into tabs,
introducing many whitespace errors. Manually fix these whitespace
errors. This was done by finding offending lines using a Python
script[0] and manually correcting them by comparing to the original
version.

If the lines were originally aligned with the line above, keep the
alignment. Otherwise, if it's a line continuation, default to two
tabs.

This patch should be empty with `--ignore-all-space`.

[0]:
	import sys

	tab_level = 0
	for lineno, line in enumerate(sys.stdin, 1):
	    line = line.rstrip()
	    if not line:
		continue
	    tab_stripped = line.lstrip('\t')
	    new_tab_level = len(line) - len(tab_stripped)
	    if new_tab_level - tab_level > 1:
		print('more than one tab:', lineno)
		continue
	    tab_level = new_tab_level
	    space_stripped = tab_stripped.lstrip(' ')
	    if len(tab_stripped) > len(space_stripped):
		print('tabs and spaces mixed:', lineno)
		continue

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 gitk | 274 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 137 insertions(+), 137 deletions(-)

diff --git a/gitk b/gitk
index 7efb106e52..60c1e45325 100755
--- a/gitk
+++ b/gitk
@@ -11,7 +11,7 @@ package require Tk
 
 proc hasworktree {} {
 	return [expr {[exec git rev-parse --is-bare-repository] == "false" &&
-				  [exec git rev-parse --is-inside-git-dir] == "false"}]
+		      [exec git rev-parse --is-inside-git-dir] == "false"}]
 }
 
 proc reponame {} {
@@ -391,10 +391,10 @@ proc start_rev_list {view} {
 			global nr_unmerged
 			if {$nr_unmerged == 0} {
 				error_popup [mc "No files selected: --merge specified but\
-							 no files are unmerged."]
+					     no files are unmerged."]
 			} else {
 				error_popup [mc "No files selected: --merge specified but\
-							 no unmerged files are within file limit."]
+					     no unmerged files are within file limit."]
 			}
 			return 0
 		}
@@ -413,7 +413,7 @@ proc start_rev_list {view} {
 
 	if {[catch {
 		set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
-						--parents --boundary $args "--" $files] r]
+				--parents --boundary $args "--" $files] r]
 	} err]} {
 		error_popup "[mc "Error executing git log:"] $err"
 		return 0
@@ -561,7 +561,7 @@ proc updatecommits {} {
 	}
 	if {[catch {
 		set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
-						--parents --boundary $args "--" $vfilelimit($view)] r]
+				--parents --boundary $args "--" $vfilelimit($view)] r]
 	} err]} {
 		error_popup "[mc "Error executing git log:"] $err"
 		return
@@ -834,7 +834,7 @@ proc renumbervarc {a v} {
 		set id [lindex $varcstart($v) $a]
 		if {[llength $children($v,$id)] > 1} {
 			set children($v,$id) [lsort -command [list vtokcmp $v] \
-									  $children($v,$id)]
+					$children($v,$id)]
 		}
 		set oldtok [lindex $varctok($v) $a]
 		if {!$vdatemode($v)} {
@@ -900,7 +900,7 @@ proc renumbervarc {a v} {
 				set b [lindex $vleftptr($v) $c]
 			}
 			while {$b != 0 && \
-					  [string compare $tok [lindex $varctok($v) $b]] >= 0} {
+					[string compare $tok [lindex $varctok($v) $b]] >= 0} {
 				set c $b
 				set b [lindex $vleftptr($v) $c]
 			}
@@ -921,7 +921,7 @@ proc renumbervarc {a v} {
 	foreach id [array names sortkids] {
 		if {[llength $children($v,$id)] > 1} {
 			set children($v,$id) [lsort -command [list vtokcmp $v] \
-									  $children($v,$id)]
+					$children($v,$id)]
 		}
 	}
 	set t2 [clock clicks -milliseconds]
@@ -941,8 +941,8 @@ proc fix_reversal {p a v} {
 	}
 	# seeds always need to be renumbered
 	if {[lindex $vupptr($v) $pa] == 0 ||
-		[string compare [lindex $varctok($v) $a] \
-			 [lindex $varctok($v) $pa]] > 0} {
+			[string compare [lindex $varctok($v) $a] \
+			[lindex $varctok($v) $pa]] > 0} {
 		renumbervarc $pa $v
 	}
 }
@@ -1090,7 +1090,7 @@ proc vtokcmp {v a b} {
 	global varctok varcid
 
 	return [string compare [lindex $varctok($v) $varcid($v,$a)] \
-				[lindex $varctok($v) $varcid($v,$b)]]
+			[lindex $varctok($v) $varcid($v,$b)]]
 }
 
 # This assumes that if lim is not given, the caller has checked that
@@ -1237,7 +1237,7 @@ proc comes_before {a b} {
 	}
 	if {$varcid($v,$a) != $varcid($v,$b)} {
 		return [expr {[string compare [lindex $varctok($v) $varcid($v,$a)] \
-						   [lindex $varctok($v) $varcid($v,$b)]] < 0}]
+				[lindex $varctok($v) $varcid($v,$b)]] < 0}]
 	}
 	return [expr {[rowofcommit $a] < [rowofcommit $b]}]
 }
@@ -1369,7 +1369,7 @@ proc rewrite_commit {v id rwid} {
 		# add $ch to $rwid's children and sort the list if necessary
 		if {[llength [lappend children($v,$rwid) $ch]] > 1} {
 			set children($v,$rwid) [lsort -command [list vtokcmp $v] \
-										$children($v,$rwid)]
+					$children($v,$rwid)]
 		}
 		# fix the graph after joining $id to $rwid
 		set a $varcid($v,$ch)
@@ -1445,7 +1445,7 @@ proc getcommitlines {fd inst view updating}  {
 			}
 			if {[string range $err 0 4] == "usage"} {
 				set err "Gitk: error reading commits$fv:\
-						bad arguments to git log."
+					bad arguments to git log."
 				if {$viewname($view) eq [mc "Command line"]} {
 					append err \
 						"  (Note: arguments to gitk are passed to git log\
@@ -1529,7 +1529,7 @@ proc getcommitlines {fd inst view updating}  {
 			# parent as a substitute parent for $id's children.
 			if {![catch {
 				set rwid [exec git rev-list --first-parent --max-count=1 \
-							  $id -- $vfilelimit($view)]
+						$id -- $vfilelimit($view)]
 			}]} {
 				if {$rwid ne {} && [info exists varcid($view,$rwid)]} {
 					# use $rwid in place of $id
@@ -1582,7 +1582,7 @@ proc getcommitlines {fd inst view updating}  {
 				if {[llength [lappend children($vp) $id]] > 1 &&
 					[vtokcmp $view [lindex $children($vp) end-1] $id] > 0} {
 					set children($vp) [lsort -command [list vtokcmp $view] \
-										   $children($vp)]
+							$children($vp)]
 					unset -nocomplain ordertok
 				}
 				if {[info exists varcid($view,$p)]} {
@@ -1730,7 +1730,7 @@ proc parsecommit {id contents listed} {
 		set comment [string range $comment 0 $i-1]
 	}
 	set commitinfo($id) [list $headline $auname $audate \
-							 $comname $comdate $comment $hasnote $diff]
+			$comname $comdate $comment $hasnote $diff]
 }
 
 proc getcommit {id} {
@@ -2053,8 +2053,8 @@ proc makedroplist {w varname args} {
 			if {$cx > $width} {set width $cx}
 		}
 		set gm [ttk::combobox $w -width $width -state readonly\
-					-textvariable $varname -values $args \
-					-exportselection false]
+				-textvariable $varname -values $args \
+				-exportselection false]
 		bind $gm <<ComboboxSelected>> [list $gm selection clear]
 	} else {
 		set gm [eval [linsert $args 0 tk_optionMenu $w $varname]]
@@ -2320,10 +2320,10 @@ proc makewindow {} {
 		-side left -fill y
 	set gdttype [mc "containing:"]
 	set gm [makedroplist .tf.lbar.gdttype gdttype \
-				[mc "containing:"] \
-				[mc "touching paths:"] \
-				[mc "adding/removing string:"] \
-				[mc "changing lines matching:"]]
+			[mc "containing:"] \
+			[mc "touching paths:"] \
+			[mc "adding/removing string:"] \
+			[mc "changing lines matching:"]]
 	trace add variable gdttype write gdttype_change
 	pack .tf.lbar.gdttype -side left -fill y
 
@@ -2334,7 +2334,7 @@ proc makewindow {} {
 	trace add variable findstring write find_change
 	set findtype [mc "Exact"]
 	set findtypemenu [makedroplist .tf.lbar.findtype \
-						  findtype [mc "Exact"] [mc "IgnCase"] [mc "Regexp"]]
+			findtype [mc "Exact"] [mc "IgnCase"] [mc "Regexp"]]
 	trace add variable findtype write findcom_change
 	set findloc [mc "All fields"]
 	makedroplist .tf.lbar.findloc findloc [mc "All fields"] [mc "Headline"] \
@@ -3112,7 +3112,7 @@ proc keys {} {
 [mc "<%s-minus> Decrease font size" $M1T]
 [mc "<F5>				Update"]
 " \
-			-justify left -bg $bgcolor -border 2 -relief groove
+		-justify left -bg $bgcolor -border 2 -relief groove
 	pack $w.m -side top -fill both -padx 2 -pady 2
 	${NS}::button $w.ok -text [mc "Close"] -command "destroy $w" -default active
 	bind $w <Key-Escape> [list destroy $w]
@@ -3352,59 +3352,59 @@ image create bitmap tri-rt -background black -foreground blue -data {
 	#define tri-rt_width 13
 	#define tri-rt_height 13
 	static unsigned char tri-rt_bits[] = {
-	   0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x30, 0x00, 0x70, 0x00, 0xf0, 0x00,
-	   0xf0, 0x01, 0xf0, 0x00, 0x70, 0x00, 0x30, 0x00, 0x10, 0x00, 0x00, 0x00,
-	   0x00, 0x00};
+		0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x30, 0x00, 0x70, 0x00, 0xf0, 0x00,
+		0xf0, 0x01, 0xf0, 0x00, 0x70, 0x00, 0x30, 0x00, 0x10, 0x00, 0x00, 0x00,
+		0x00, 0x00};
 } -maskdata {
 	#define tri-rt-mask_width 13
 	#define tri-rt-mask_height 13
 	static unsigned char tri-rt-mask_bits[] = {
-	   0x08, 0x00, 0x18, 0x00, 0x38, 0x00, 0x78, 0x00, 0xf8, 0x00, 0xf8, 0x01,
-	   0xf8, 0x03, 0xf8, 0x01, 0xf8, 0x00, 0x78, 0x00, 0x38, 0x00, 0x18, 0x00,
-	   0x08, 0x00};
+		0x08, 0x00, 0x18, 0x00, 0x38, 0x00, 0x78, 0x00, 0xf8, 0x00, 0xf8, 0x01,
+		0xf8, 0x03, 0xf8, 0x01, 0xf8, 0x00, 0x78, 0x00, 0x38, 0x00, 0x18, 0x00,
+		0x08, 0x00};
 }
 image create bitmap tri-dn -background black -foreground blue -data {
 	#define tri-dn_width 13
 	#define tri-dn_height 13
 	static unsigned char tri-dn_bits[] = {
-	   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0x07, 0xf8, 0x03,
-	   0xf0, 0x01, 0xe0, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	   0x00, 0x00};
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0x07, 0xf8, 0x03,
+		0xf0, 0x01, 0xe0, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00};
 } -maskdata {
 	#define tri-dn-mask_width 13
 	#define tri-dn-mask_height 13
 	static unsigned char tri-dn-mask_bits[] = {
-	   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x1f, 0xfe, 0x0f, 0xfc, 0x07,
-	   0xf8, 0x03, 0xf0, 0x01, 0xe0, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00,
-	   0x00, 0x00};
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x1f, 0xfe, 0x0f, 0xfc, 0x07,
+		0xf8, 0x03, 0xf0, 0x01, 0xe0, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00};
 }
 
 image create bitmap reficon-T -background black -foreground yellow -data {
 	#define tagicon_width 13
 	#define tagicon_height 9
 	static unsigned char tagicon_bits[] = {
-	   0x00, 0x00, 0x00, 0x00, 0xf0, 0x07, 0xf8, 0x07,
-	   0xfc, 0x07, 0xf8, 0x07, 0xf0, 0x07, 0x00, 0x00, 0x00, 0x00};
+		0x00, 0x00, 0x00, 0x00, 0xf0, 0x07, 0xf8, 0x07,
+		0xfc, 0x07, 0xf8, 0x07, 0xf0, 0x07, 0x00, 0x00, 0x00, 0x00};
 } -maskdata {
 	#define tagicon-mask_width 13
 	#define tagicon-mask_height 9
 	static unsigned char tagicon-mask_bits[] = {
-	   0x00, 0x00, 0xf0, 0x0f, 0xf8, 0x0f, 0xfc, 0x0f,
-	   0xfe, 0x0f, 0xfc, 0x0f, 0xf8, 0x0f, 0xf0, 0x0f, 0x00, 0x00};
+		0x00, 0x00, 0xf0, 0x0f, 0xf8, 0x0f, 0xfc, 0x0f,
+		0xfe, 0x0f, 0xfc, 0x0f, 0xf8, 0x0f, 0xf0, 0x0f, 0x00, 0x00};
 }
 set rectdata {
 	#define headicon_width 13
 	#define headicon_height 9
 	static unsigned char headicon_bits[] = {
-	   0x00, 0x00, 0x00, 0x00, 0xf8, 0x07, 0xf8, 0x07,
-	   0xf8, 0x07, 0xf8, 0x07, 0xf8, 0x07, 0x00, 0x00, 0x00, 0x00};
+		0x00, 0x00, 0x00, 0x00, 0xf8, 0x07, 0xf8, 0x07,
+		0xf8, 0x07, 0xf8, 0x07, 0xf8, 0x07, 0x00, 0x00, 0x00, 0x00};
 }
 set rectmask {
 	#define headicon-mask_width 13
 	#define headicon-mask_height 9
 	static unsigned char headicon-mask_bits[] = {
-	   0x00, 0x00, 0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f,
-	   0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f, 0x00, 0x00};
+		0x00, 0x00, 0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f,
+		0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f, 0x00, 0x00};
 }
 image create bitmap reficon-H -background black -foreground "#00ff00" \
 	-data $rectdata -maskdata $rectmask
@@ -3622,7 +3622,7 @@ proc external_diff_get_one_file {diffid filename diffdir} {
 	}
 	set difffile [file join $diffdir "\[$diffid\] [file tail $filename]"]
 	return [save_file_from_commit $diffid:$filename $difffile \
-			   "revision $diffid"]
+			"revision $diffid"]
 }
 
 proc external_diff {} {
@@ -3953,7 +3953,7 @@ proc read_line_source {fd inst} {
 			selectline [rowofcommit $id] 1 [list $fname $lnum] 1
 		} else {
 			error_popup [mc "That line comes from commit %s, \
-							 which is not in this view" [shortids $id]]
+					 which is not in this view" [shortids $id]]
 		}
 	} else {
 		puts "oops couldn't parse git blame output"
@@ -4590,8 +4590,8 @@ proc bolden {id font} {
 	if {[info exists currentid] && $id eq $currentid} {
 		$canv delete secsel
 		set t [eval $canv create rect [$canv bbox $linehtag($id)] \
-				   -outline {{}} -tags secsel \
-				   -fill [$canv cget -selectbackground]]
+				-outline {{}} -tags secsel \
+				-fill [$canv cget -selectbackground]]
 		$canv lower $t
 	}
 	if {[info exists markedid] && $id eq $markedid} {
@@ -4608,8 +4608,8 @@ proc bolden_name {id font} {
 	if {[info exists currentid] && $id eq $currentid} {
 		$canv2 delete secsel
 		set t [eval $canv2 create rect [$canv2 bbox $linentag($id)] \
-				   -outline {{}} -tags secsel \
-				   -fill [$canv2 cget -selectbackground]]
+				-outline {{}} -tags secsel \
+				-fill [$canv2 cget -selectbackground]]
 		$canv2 lower $t
 	}
 }
@@ -4767,7 +4767,7 @@ proc findcom_change args {
 		set findpattern $findstring
 	} else {
 		set e [string map {"*" "\\*" "?" "\\?" "\[" "\\\[" "\\" "\\\\"} \
-				   $findstring]
+				$findstring]
 		set findpattern "*$e*"
 	}
 }
@@ -5057,7 +5057,7 @@ proc askrelhighlight {row id} {
 			set isbold 1
 		}
 	} elseif {$highlight_related eq [mc "Ancestor"] ||
-			  $highlight_related eq [mc "Not ancestor"]} {
+		  $highlight_related eq [mc "Not ancestor"]} {
 		if {![info exists ancestor($id)]} {
 			is_ancestor $id
 		}
@@ -5162,7 +5162,7 @@ proc idcol {idlist id {i 0}} {
 	} else {
 		if {$t > [ordertoken [lindex $idlist $i]]} {
 			while {[incr i] < [llength $idlist] &&
-				   $t >= [ordertoken [lindex $idlist $i]]} {}
+			       $t >= [ordertoken [lindex $idlist $i]]} {}
 		}
 	}
 	return $i
@@ -5243,7 +5243,7 @@ proc get_viewmainhead {view} {
 
 	catch {
 		set rfd [open [concat | git rev-list -1 $mainheadid \
-						   -- $vfilelimit($view)] r]
+				-- $vfilelimit($view)] r]
 		set j [reg_instance $rfd]
 		lappend viewinstances($view) $j
 		fconfigure $rfd -blocking 0
@@ -5838,15 +5838,15 @@ proc rowranges {id} {
 			# see if the line extends the whole way from prevrow to row
 			if {$row > $prevrow + $uparrowlen + $downarrowlen &&
 				[lsearch -exact [lindex $rowidlist \
-							[expr {int(($row + $prevrow) / 2)}]] $id] < 0} {
+						[expr {int(($row + $prevrow) / 2)}]] $id] < 0} {
 				# it doesn't, see where it ends
 				set r [expr {$prevrow + $downarrowlen}]
 				if {[lsearch -exact [lindex $rowidlist $r] $id] < 0} {
 					while {[incr r -1] > $prevrow &&
-						   [lsearch -exact [lindex $rowidlist $r] $id] < 0} {}
+					       [lsearch -exact [lindex $rowidlist $r] $id] < 0} {}
 				} else {
 					while {[incr r] <= $row &&
-						   [lsearch -exact [lindex $rowidlist $r] $id] >= 0} {}
+					       [lsearch -exact [lindex $rowidlist $r] $id] >= 0} {}
 					incr r -1
 				}
 				lappend ret $r
@@ -5854,10 +5854,10 @@ proc rowranges {id} {
 				set r [expr {$row - $uparrowlen}]
 				if {[lsearch -exact [lindex $rowidlist $r] $id] < 0} {
 					while {[incr r] < $row &&
-						   [lsearch -exact [lindex $rowidlist $r] $id] < 0} {}
+					       [lsearch -exact [lindex $rowidlist $r] $id] < 0} {}
 				} else {
 					while {[incr r -1] >= $prevrow &&
-						   [lsearch -exact [lindex $rowidlist $r] $id] >= 0} {}
+					       [lsearch -exact [lindex $rowidlist $r] $id] >= 0} {}
 					incr r
 				}
 				lappend ret $r
@@ -6000,7 +6000,7 @@ proc drawlineseg {id row endrow arrowlow} {
 		if {!$joinhigh} {
 			assigncolor $id
 			set t [$canv create line $coords -width [linewidth $id] \
-					   -fill $colormap($id) -tags lines.$id -arrow $arrow]
+					-fill $colormap($id) -tags lines.$id -arrow $arrow]
 			$canv lower $t
 			bindline $t $id
 			set lines [linsert $lines $i [list $row $le $t]]
@@ -6097,7 +6097,7 @@ proc drawparentlinks {id row} {
 			lappend coords $x2 $y2
 		}
 		set t [$canv create line $coords -width [linewidth $p] \
-				   -fill $colormap($p) -tags lines.$p]
+				-fill $colormap($p) -tags lines.$p]
 		$canv lower $t
 		bindline $t $p
 	}
@@ -6139,22 +6139,22 @@ proc drawcmittext {id row col} {
 	set orad [expr {$linespc / 3}]
 	if {$listed <= 2} {
 		set t [$canv create oval [expr {$x - $orad}] [expr {$y - $orad}] \
-				   [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
-				   -fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
+				[expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
+				-fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
 	} elseif {$listed == 3} {
 		# triangle pointing left for left-side commits
 		set t [$canv create polygon \
-				   [expr {$x - $orad}] $y \
-				   [expr {$x + $orad - 1}] [expr {$y - $orad}] \
-				   [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
-				   -fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
+				[expr {$x - $orad}] $y \
+				[expr {$x + $orad - 1}] [expr {$y - $orad}] \
+				[expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
+				-fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
 	} else {
 		# triangle pointing right for right-side commits
 		set t [$canv create polygon \
-				   [expr {$x + $orad - 1}] $y \
-				   [expr {$x - $orad}] [expr {$y - $orad}] \
-				   [expr {$x - $orad}] [expr {$y + $orad - 1}] \
-				   -fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
+				[expr {$x + $orad - 1}] $y \
+				[expr {$x - $orad}] [expr {$y - $orad}] \
+				[expr {$x - $orad}] [expr {$y + $orad - 1}] \
+				-fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
 	}
 	set circleitem($row) $t
 	$canv raise $t
@@ -6196,12 +6196,12 @@ proc drawcmittext {id row col} {
 		}
 	}
 	set linehtag($id) [$canv create text $xt $y -anchor w -fill $fgcolor \
-						   -text $headline -font $font -tags text]
+			-text $headline -font $font -tags text]
 	$canv bind $linehtag($id) $ctxbut "rowmenu %X %Y $id"
 	set linentag($id) [$canv2 create text 3 $y -anchor w -fill $fgcolor \
-						   -text $name -font $nfont -tags text]
+			-text $name -font $nfont -tags text]
 	set linedtag($id) [$canv3 create text 3 $y -anchor w -fill $fgcolor \
-						   -text $date -font mainfont -tags text]
+			-text $date -font mainfont -tags text]
 	if {$selectedline == $row} {
 		make_secsel $id
 	}
@@ -6618,7 +6618,7 @@ proc drawtags {id x xt y1} {
 		set xt [expr {$xt + $wid + $extra}]
 	}
 	set t [$canv create line $x $y1 [lindex $xvals end] $y1 \
-			   -width $lthickness -fill $reflinecolor -tags tag.$id]
+			-width $lthickness -fill $reflinecolor -tags tag.$id]
 	$canv lower $t
 	foreach tag $marks x $xvals wid $wvals {
 		set tag_quoted [string map {% %%} $tag]
@@ -6628,9 +6628,9 @@ proc drawtags {id x xt y1} {
 		if {[incr ntags -1] >= 0} {
 			# draw a tag
 			set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
-					   $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
-					   -width 1 -outline $tagoutlinecolor -fill $tagbgcolor \
-					   -tags tag.$id]
+					$xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
+					-width 1 -outline $tagoutlinecolor -fill $tagbgcolor \
+					-tags tag.$id]
 			if {$singletag} {
 				set tagclick [list showtags $id 1]
 			} else {
@@ -6661,7 +6661,7 @@ proc drawtags {id x xt y1} {
 			}
 		}
 		set t [$canv create text $xl $y1 -anchor w -text $tag -fill $headfgcolor \
-				   -font $font -tags [list tag.$id text]]
+				-font $font -tags [list tag.$id text]]
 		if {$ntags >= 0} {
 			$canv bind $t <1> $tagclick
 		} elseif {$nheads >= 0} {
@@ -6676,8 +6676,8 @@ proc drawnotesign {xt y} {
 
 	set orad [expr {$linespc / 3}]
 	set t [$canv create rectangle [expr {$xt - $orad}] [expr {$y - $orad}] \
-			   [expr {$xt + $orad - 1}] [expr {$y + $orad - 1}] \
-			   -fill yellow -outline $fgcolor -width 1 -tags circle]
+			[expr {$xt + $orad - 1}] [expr {$y + $orad - 1}] \
+			-fill yellow -outline $fgcolor -width 1 -tags circle]
 	set xt [expr {$xt + $orad * 3}]
 	return $xt
 }
@@ -6971,8 +6971,8 @@ proc markmatches {canv l str tag matches font row} {
 		set xoff [font measure $font [string range $str 0 [expr {$start-1}]]]
 		set xlen [font measure $font [string range $str 0 [expr {$end}]]]
 		set t [$canv create rect [expr {$x0+$xoff}] $y0 \
-				   [expr {$x0+$xlen+2}] $y1 \
-				   -outline {} -tags [list match$l matches] -fill yellow]
+				[expr {$x0+$xlen+2}] $y1 \
+				-outline {} -tags [list match$l matches] -fill yellow]
 		$canv lower $t
 		if {$row == $selectedline} {
 			$canv raise $t secsel
@@ -7040,7 +7040,7 @@ proc appendwithlinks {text tags} {
 		incr linknum
 	}
 	set wlinks [regexp -indices -all -inline -line \
-					{https?://[^[:space:]]+} $text]
+			{https?://[^[:space:]]+} $text]
 	foreach l $wlinks {
 		set s2 [lindex $l 0]
 		set e2 [lindex $l 1]
@@ -7058,7 +7058,7 @@ proc setlink {id lk} {
 	global linkfgcolor
 
 	if {[string range $id 0 1] eq "-g"} {
-	  set id [string range $id 2 end]
+		set id [string range $id 2 end]
 	}
 
 	set known 0
@@ -7277,15 +7277,15 @@ proc make_secsel {id} {
 	if {![info exists linehtag($id)]} return
 	$canv delete secsel
 	set t [eval $canv create rect [$canv bbox $linehtag($id)] -outline {{}} \
-			   -tags secsel -fill [$canv cget -selectbackground]]
+			-tags secsel -fill [$canv cget -selectbackground]]
 	$canv lower $t
 	$canv2 delete secsel
 	set t [eval $canv2 create rect [$canv2 bbox $linentag($id)] -outline {{}} \
-			   -tags secsel -fill [$canv2 cget -selectbackground]]
+			-tags secsel -fill [$canv2 cget -selectbackground]]
 	$canv2 lower $t
 	$canv3 delete secsel
 	set t [eval $canv3 create rect [$canv3 bbox $linedtag($id)] -outline {{}} \
-			   -tags secsel -fill [$canv3 cget -selectbackground]]
+			-tags secsel -fill [$canv3 cget -selectbackground]]
 	$canv3 lower $t
 }
 
@@ -7295,7 +7295,7 @@ proc make_idmark {id} {
 	if {![info exists linehtag($id)]} return
 	$canv delete markid
 	set t [eval $canv create rect [$canv bbox $linehtag($id)] \
-			   -tags markid -outline $fgcolor]
+			-tags markid -outline $fgcolor]
 	$canv raise $t
 }
 
@@ -7751,7 +7751,7 @@ proc getblobline {bf id} {
 		if {$jump_to_here ne {} &&
 			[lindex $jump_to_here 0] eq [lindex $ctext_file_names 0]} {
 			set lnum [expr {[lindex $jump_to_here 1] +
-							[lindex [split $commentend .] 0]}]
+					[lindex [split $commentend .] 0]}]
 			mark_ctext_line $lnum
 		}
 		$ctext config -state disabled
@@ -7905,7 +7905,7 @@ proc gettreediffs {ids} {
 
 	set cmd [diffcmd $ids {--no-commit-id}]
 	if {$limitdiffs && $vfilelimit($curview) ne {}} {
-			set cmd [concat $cmd -- $vfilelimit($curview)]
+		set cmd [concat $cmd -- $vfilelimit($curview)]
 	}
 	if {[catch {set gdtf [open $cmd r]}]} return
 
@@ -8058,7 +8058,7 @@ proc maybe_scroll_ctext {ateof} {
 	if {![info exists target_scrollpos]} return
 	if {!$ateof} {
 		set nlines [expr {[winfo height $ctext]
-						  / [font metrics textfont -linespace]}]
+				/ [font metrics textfont -linespace]}]
 		if {[$ctext compare "$target_scrollpos + $nlines lines" <= end]} return
 	}
 	$ctext yview $target_scrollpos
@@ -8179,8 +8179,8 @@ proc parseblobdiffline {ids line} {
 			set l [string length $line]
 			set i [expr {$l / 2}]
 			if {!(($l & 1) && [string index $line $i] eq " " &&
-				  [string range $line 2 [expr {$i - 1}]] eq \
-					  [string range $line [expr {$i + 3}] end])} {
+					[string range $line 2 [expr {$i - 1}]] eq \
+					[string range $line [expr {$i + 3}] end])} {
 				return
 			}
 			# unescape if quoted and chop off the a/ from the front
@@ -8252,7 +8252,7 @@ proc parseblobdiffline {ids line} {
 				setinlist difffilestart $i $curdiffstart
 			}
 		} elseif {![string compare -length 10 $line "rename to "] ||
-				  ![string compare -length 8 $line "copy to "]} {
+			  ![string compare -length 8 $line "copy to "]} {
 			set fname [string range $line [expr 4 + [string first " to " $line] ] end]
 			if {[string index $fname 0] eq "\""} {
 				set fname [lindex $fname 0]
@@ -8269,7 +8269,7 @@ proc parseblobdiffline {ids line} {
 
 	} else {
 		set line [string map {\x1A ^Z} \
-					  [encoding convertfrom $diffencoding $line]]
+				[encoding convertfrom $diffencoding $line]]
 		# parse the prefix - one ' ', '-' or '+' for each parent
 		set prefix [string range $line 0 [expr {$diffnparents - 1}]]
 		set tag [expr {$diffnparents > 1? "m": "d"}]
@@ -8429,7 +8429,7 @@ proc settabs {{firstab {}}} {
 	set w [font measure textfont "0"]
 	if {$firsttabstop != 0} {
 		$ctext conf -tabs [list [expr {($firsttabstop + $tabstop) * $w}] \
-							   [expr {($firsttabstop + 2 * $tabstop) * $w}]]
+				[expr {($firsttabstop + 2 * $tabstop) * $w}]]
 	} elseif {$have_tk85 || $tabstop != 8} {
 		$ctext conf -tabs [expr {$tabstop * $w}]
 	} else {
@@ -8655,8 +8655,8 @@ proc fontflags {f {isbold 0}} {
 	global fontattr
 
 	return [list -family $fontattr($f,family) -size $fontattr($f,size) \
-				-weight [expr {$isbold? "bold": $fontattr($f,weight)}] \
-				-slant $fontattr($f,slant)]
+			-weight [expr {$isbold? "bold": $fontattr($f,weight)}] \
+			-slant $fontattr($f,slant)]
 }
 
 proc fontname {f} {
@@ -8821,11 +8821,11 @@ proc linehover {} {
 	set x1 [expr {$x + [font measure mainfont $text] + 2 * $lthickness}]
 	set y1 [expr {$y + $linespc + 2 * $lthickness}]
 	set t [$canv create rectangle $x0 $y0 $x1 $y1 \
-			   -fill $linehoverbgcolor -outline $linehoveroutlinecolor \
-			   -width 1 -tags hover]
+			-fill $linehoverbgcolor -outline $linehoveroutlinecolor \
+			-width 1 -tags hover]
 	$canv raise $t
 	set t [$canv create text $x $y -anchor nw -text $text -tags hover \
-			   -font mainfont -fill $linehoverfgcolor]
+			-font mainfont -fill $linehoverfgcolor]
 	$canv raise $t
 }
 
@@ -9281,7 +9281,7 @@ proc mkpatchrev {} {
 	set newid [$patchtop.tosha1 get]
 	set newhead [$patchtop.tohead get]
 	foreach e [list fromsha1 fromhead tosha1 tohead] \
-			v [list $newid $newhead $oldid $oldhead] {
+		v [list $newid $newhead $oldid $oldhead] {
 		$patchtop.$e conf -state normal
 		$patchtop.$e delete 0 end
 		$patchtop.$e insert 0 $v
@@ -9666,7 +9666,7 @@ proc exec_citool {tool_args {baseid {}}} {
 		set author [lindex $commitinfo($baseid) 1]
 		set date [lindex $commitinfo($baseid) 2]
 		if {[regexp {^\s*(\S.*\S|\S)\s*<(.*)>\s*$} \
-					$author author name email]
+				$author author name email]
 			&& $date ne {}} {
 			set env(GIT_AUTHOR_NAME) $name
 			set env(GIT_AUTHOR_EMAIL) $email
@@ -9689,8 +9689,8 @@ proc cherrypick {} {
 	set dheads [descheads $rowmenuid]
 	if {$dheads ne {} && [lsearch -exact $dheads $oldhead] >= 0} {
 		set ok [confirm_popup [mc "Commit %s is already\
-				included in branch %s -- really re-apply it?" \
-								   [string range $rowmenuid 0 7] $mainhead]]
+			included in branch %s -- really re-apply it?" \
+				[string range $rowmenuid 0 7] $mainhead]]
 		if {!$ok} return
 	}
 	nowbusy cherrypick [mc "Cherry-picking"]
@@ -9700,14 +9700,14 @@ proc cherrypick {} {
 	if {[catch {exec sh -c "git cherry-pick -r $rowmenuid 2>&1"} err]} {
 		notbusy cherrypick
 		if {[regexp -line \
-				 {Entry '(.*)' (would be overwritten by merge|not uptodate)} \
-				 $err msg fname]} {
+				{Entry '(.*)' (would be overwritten by merge|not uptodate)} \
+				$err msg fname]} {
 			error_popup [mc "Cherry-pick failed because of local changes\
-						to file '%s'.\nPlease commit, reset or stash\
-						your changes and try again." $fname]
+					to file '%s'.\nPlease commit, reset or stash\
+					your changes and try again." $fname]
 		} elseif {[regexp -line \
-					   {^(CONFLICT \(.*\):|Automatic cherry-pick failed|error: could not apply)} \
-					   $err]} {
+				{^(CONFLICT \(.*\):|Automatic cherry-pick failed|error: could not apply)} \
+				$err]} {
 			if {[confirm_popup [mc "Cherry-pick failed because of merge\
 						conflict.\nDo you wish to run git citool to\
 						resolve it?"]]} {
@@ -9752,9 +9752,9 @@ proc revert {} {
 	set dheads [descheads $rowmenuid]
 	if { $dheads eq {} || [lsearch -exact $dheads $oldhead] == -1 } {
 	   set ok [confirm_popup [mc "Commit %s is not\
-		   included in branch %s -- really revert it?" \
-					  [string range $rowmenuid 0 7] $mainhead]]
-	   if {!$ok} return
+		included in branch %s -- really revert it?" \
+			[string range $rowmenuid 0 7] $mainhead]]
+		if {!$ok} return
 	}
 	nowbusy revert [mc "Reverting"]
 	update
@@ -9988,7 +9988,7 @@ proc rmbranch {} {
 	if {[llength $dheads] == 1 && $idheads($dheads) eq $head} {
 		# the stuff on this branch isn't on any other branch
 		if {![confirm_popup [mc "The commits on branch %s aren't on any other\
-						branch.\nReally delete branch %s?" $head $head]]} return
+				branch.\nReally delete branch %s?" $head $head]]} return
 	}
 	nowbusy rmbranch
 	update
@@ -10134,10 +10134,10 @@ proc refill_reflist {} {
 		if {$i < [llength $reflist]} {
 			if {$j < [llength $refs]} {
 				set cmp [string compare [lindex $reflist $i 0] \
-							 [lindex $refs $j 0]]
+						[lindex $refs $j 0]]
 				if {$cmp == 0} {
 					set cmp [string compare [lindex $reflist $i 1] \
-								 [lindex $refs $j 1]]
+							[lindex $refs $j 1]]
 				}
 			} else {
 				set cmp -1
@@ -10198,7 +10198,7 @@ proc getallcommits {} {
 		set ids "--all"
 	} else {
 		set refs [concat [array names idheads] [array names idtags] \
-					  [array names idotherrefs]]
+				[array names idotherrefs]]
 		set ids {}
 		set tagobjs {}
 		foreach name [array names tagobjid] {
@@ -10557,7 +10557,7 @@ proc dropcache {err} {
 
 	#puts "dropping cache ($err)"
 	foreach v {arcnos arcout arcids arcstart arcend growing \
-				   arctags archeads allparents allchildren} {
+				arctags archeads allparents allchildren} {
 		global $v
 		unset -nocomplain $v
 	}
@@ -11263,7 +11263,7 @@ proc rereadrefs {} {
 	global idtags idheads idotherrefs mainheadid
 
 	set refids [concat [array names idtags] \
-					[array names idheads] [array names idotherrefs]]
+			[array names idheads] [array names idotherrefs]]
 	foreach id $refids {
 		if {![info exists ref($id)]} {
 			set ref($id) [listrefs $id]
@@ -11273,7 +11273,7 @@ proc rereadrefs {} {
 	readrefs
 	changedrefs
 	set refids [lsort -unique [concat $refids [array names idtags] \
-						[array names idheads] [array names idotherrefs]]]
+			[array names idheads] [array names idotherrefs]]]
 	foreach id $refids {
 		set v [listrefs $id]
 		if {![info exists ref($id)] || $ref($id) != $v} {
@@ -11544,7 +11544,7 @@ proc prefspage_general {notebook} {
 	${NS}::label $page.maxwidthl -text [mc "Maximum graph width (lines)"]
 	spinbox $page.maxwidth -from 0 -to 100 -width 4 -textvariable maxwidth
 	grid $page.spacer $page.maxwidthl $page.maxwidth -sticky w
-										 #xgettext:no-tcl-format
+			#xgettext:no-tcl-format
 	${NS}::label $page.maxpctl -text [mc "Maximum graph width (% of pane)"]
 	spinbox $page.maxpct -from 1 -to 100 -width 4 -textvariable maxgraphpct
 	grid x $page.maxpctl $page.maxpct -sticky w
@@ -11614,7 +11614,7 @@ proc prefspage_colors {notebook} {
 	grid $page.cdisp - -sticky w -pady 10
 	label $page.ui -padx 40 -relief sunk -background $uicolor
 	${NS}::button $page.uibut -text [mc "Interface"] \
-	   -command [list choosecolor uicolor {} $page.ui [mc "interface"] setui]
+		-command [list choosecolor uicolor {} $page.ui [mc "interface"] setui]
 	grid x $page.uibut $page.ui -sticky w
 	label $page.bg -padx 40 -relief sunk -background $bgcolor
 	${NS}::button $page.bgbut -text [mc "Background"] \
@@ -11627,24 +11627,24 @@ proc prefspage_colors {notebook} {
 	label $page.diffold -padx 40 -relief sunk -background [lindex $diffcolors 0]
 	${NS}::button $page.diffoldbut -text [mc "Diff: old lines"] \
 		-command [list choosecolor diffcolors 0 $page.diffold [mc "diff old lines"] \
-					  [list $ctext tag conf d0 -foreground]]
+				[list $ctext tag conf d0 -foreground]]
 	grid x $page.diffoldbut $page.diffold -sticky w
 	label $page.diffnew -padx 40 -relief sunk -background [lindex $diffcolors 1]
 	${NS}::button $page.diffnewbut -text [mc "Diff: new lines"] \
 		-command [list choosecolor diffcolors 1 $page.diffnew [mc "diff new lines"] \
-					  [list $ctext tag conf dresult -foreground]]
+				[list $ctext tag conf dresult -foreground]]
 	grid x $page.diffnewbut $page.diffnew -sticky w
 	label $page.hunksep -padx 40 -relief sunk -background [lindex $diffcolors 2]
 	${NS}::button $page.hunksepbut -text [mc "Diff: hunk header"] \
 		-command [list choosecolor diffcolors 2 $page.hunksep \
-					  [mc "diff hunk header"] \
-					  [list $ctext tag conf hunksep -foreground]]
+				[mc "diff hunk header"] \
+				[list $ctext tag conf hunksep -foreground]]
 	grid x $page.hunksepbut $page.hunksep -sticky w
 	label $page.markbgsep -padx 40 -relief sunk -background $markbgcolor
 	${NS}::button $page.markbgbut -text [mc "Marked line bg"] \
 		-command [list choosecolor markbgcolor {} $page.markbgsep \
-					  [mc "marked line background"] \
-					  [list $ctext tag conf omark -background]]
+				[mc "marked line background"] \
+				[list $ctext tag conf omark -background]]
 	grid x $page.markbgbut $page.markbgsep -sticky w
 	label $page.selbgsep -padx 40 -relief sunk -background $selectbgcolor
 	${NS}::button $page.selbgbut -text [mc "Select bg"] \
@@ -11678,7 +11678,7 @@ proc doprefs {} {
 		return
 	}
 	foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-				   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+			limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
 		set oldprefs($v) [set $v]
 	}
 	ttk_toplevel $top
@@ -11700,7 +11700,7 @@ proc doprefs {} {
 			$notebook add $page -text $title
 		} else {
 			set btn [${NS}::button $notebook.b_[string map {. X} $page] \
-						 -text $title -command [list raise $page]]
+					-text $title -command [list raise $page]]
 			$page configure -text $title
 			grid $btn -row 0 -column [incr col] -sticky w
 			grid $page -row 1 -column 0 -sticky news -columnspan 100
@@ -11743,7 +11743,7 @@ proc choosecolor {v vi w x cmd} {
 	global $v
 
 	set c [tk_chooseColor -initialcolor [lindex [set $v] $vi] \
-			   -title [mc "Gitk: choose color for %s" $x]]
+			-title [mc "Gitk: choose color for %s" $x]]
 	if {$c eq {}} return
 	$w conf -background $c
 	lset $v $vi $c
@@ -11804,7 +11804,7 @@ proc prefscan {} {
 	global oldprefs prefstop
 
 	foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-				   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+			limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
 		global $v
 		set $v $oldprefs($v)
 	}
@@ -12257,7 +12257,7 @@ namespace import ::msgcat::mc
 # First check that Tcl/Tk is recent enough
 if {[catch {package require Tk 8.4} err]} {
 	show_error {} . [mc "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
-						 Gitk requires at least Tcl/Tk 8.4."]
+			    Gitk requires at least Tcl/Tk 8.4."]
 	exit 1
 }
 
@@ -12521,7 +12521,7 @@ if {$i >= [llength $argv] && $revtreeargs ne {}} {
 		foreach arg $revtreeargs {
 			if {[file exists $arg]} {
 				show_error {} . [mc "Ambiguous argument '%s': both revision\
-								 and filename" $arg]
+						 and filename" $arg]
 				exit 1
 			}
 		}
-- 
2.28.0.618.gf4bc123cb7

