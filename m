Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A1FC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 12:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF4B61040
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 12:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbhJKMUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 08:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236521AbhJKMUL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 08:20:11 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5FAC061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 05:18:11 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so21365688otb.10
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 05:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEQTyl+Fh0Hv2WXNrAcPKctvsoQGxcX5hUnI/YyJK+o=;
        b=LR6BLXfVM3kGbni2WeCpMg0hgo+k4QZezhXJkqQ9aalBLT91u/TL31DTKj2aUqGGxz
         EBIQTFL4WaV82XSEEzhCl56om/NcvuQ+qCkCpprS7jewJ3CzfQ1//GvB+nSPCZBHUbTl
         qVzSK58eCdPVEcNkxb7sX9mkUTacVsIQWmzGYHmOoWDK3VOCDZ4+/563rn/GKqm9Zx2X
         m5e5v+DTjQUvOQppzPel6WmFNXpth2Tf3/WJEKCjP6Fze4nUoMziQL0zoG+lpuXUem35
         g8elAhi0ItwQgYfccLm3eftVHtMHDPHG0jUkjPi6g6kmA/+ZX7VH96CMt8f53zA/2G/k
         Ry/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEQTyl+Fh0Hv2WXNrAcPKctvsoQGxcX5hUnI/YyJK+o=;
        b=NIKviy3S3hOrEQK/S+53m2tQbh/7CM4pT/Qn41veZdxVsrAmm0Mfg8EphYfyJmxmvg
         wmZPfYIG3wfiDcVyZcDJ/QZi8/5iSY5gqmi38adMJX0uCV04LT4Hg1d/d7SHDS8Ibgd4
         DhSsqx9QcJMflVRcKJfv2kRGqlNKGOWv8PXq94xuCtzRaSLwe6RBl4zjSgVb8WJUnkoW
         mPZHjx/cB89M7UEPAcIIZbXHKE2Ye/oc1k2Sc84fkIjwXQZ1pBXvU6c80V5PUzuxg7it
         16UWQzTyqdQMzcNLirA7Km0D/xqq/7uRzjIzCmi8/gNaFK2akgG3KwlGBjFaJTbRB3uY
         c09A==
X-Gm-Message-State: AOAM530MSvGvoGsudrjCUVNoHefGreEpc4iQcSCiDSJA27+nh6j2PPLz
        UIo57CKXJ2jIC5qvnlq4+PInryDIkiTBog==
X-Google-Smtp-Source: ABdhPJxEiNU+l+2jeXNIP6pKhYi3xYrvq06r4hTU3nEPhlmooOEwUn8rBzVvBD0esqg6lxXqpxyGyQ==
X-Received: by 2002:a05:6830:1de8:: with SMTP id b8mr12605683otj.260.1633954690806;
        Mon, 11 Oct 2021 05:18:10 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id u21sm467892oiv.25.2021.10.11.05.18.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Oct 2021 05:18:10 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     angavrilov@gmail.com, me@yadavpratyush.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH 2/4] rename all *_sha1 variables and make null_oid hash aware
Date:   Mon, 11 Oct 2021 05:17:55 -0700
Message-Id: <20211011121757.627-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.1081.g099423f5b7
In-Reply-To: <20211011121757.627-1-carenas@gmail.com>
References: <20211011121757.627-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this change, creating a branch in an SHA-256 repository would
fail because the null_sha1 used was of the wrong size.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 git-gui.sh          | 26 +++++++++++++++-----------
 lib/blame.tcl       | 10 +++++-----
 lib/checkout_op.tcl |  4 ++--
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index a69b0fe..c0dc8ce 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1820,10 +1820,14 @@ proc short_path {path} {
 }
 
 set next_icon_id 0
-set null_sha1 [string repeat 0 40]
+if { [get_config extensions.objectformat] eq "sha256" } {
+	set null_oid [string repeat 0 64]
+} else {
+	set null_oid [string repeat 0 40]
+}
 
 proc merge_state {path new_state {head_info {}} {index_info {}}} {
-	global file_states next_icon_id null_sha1
+	global file_states next_icon_id null_oid
 
 	set s0 [string index $new_state 0]
 	set s1 [string index $new_state 1]
@@ -1845,7 +1849,7 @@ proc merge_state {path new_state {head_info {}} {index_info {}}} {
 	elseif {$s1 eq {_}} {set s1 _}
 
 	if {$s0 eq {A} && $s1 eq {_} && $head_info eq {}} {
-		set head_info [list 0 $null_sha1]
+		set head_info [list 0 $null_oid]
 	} elseif {$s0 ne {_} && [string index $state 0] eq {_}
 		&& $head_info eq {}} {
 		set head_info $index_info
@@ -2179,21 +2183,21 @@ proc do_gitk {revs {is_submodule false}} {
 			cd $current_diff_path
 			if {$revs eq {--}} {
 				set s $file_states($current_diff_path)
-				set old_sha1 {}
-				set new_sha1 {}
+				set old_oid {}
+				set new_oid {}
 				switch -glob -- [lindex $s 0] {
-				M_ { set old_sha1 [lindex [lindex $s 2] 1] }
-				_M { set old_sha1 [lindex [lindex $s 3] 1] }
+				M_ { set old_oid [lindex [lindex $s 2] 1] }
+				_M { set old_oid [lindex [lindex $s 3] 1] }
 				MM {
 					if {$current_diff_side eq $ui_index} {
-						set old_sha1 [lindex [lindex $s 2] 1]
-						set new_sha1 [lindex [lindex $s 3] 1]
+						set old_oid [lindex [lindex $s 2] 1]
+						set new_oid [lindex [lindex $s 3] 1]
 					} else {
-						set old_sha1 [lindex [lindex $s 3] 1]
+						set old_oid [lindex [lindex $s 3] 1]
 					}
 				}
 				}
-				set revs $old_sha1...$new_sha1
+				set revs $old_oid...$new_oid
 			}
 			# GIT_DIR and GIT_WORK_TREE for the submodule are not the ones
 			# we've been using for the main repository, so unset them.
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 6ece79d..e6d4302 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -1056,14 +1056,14 @@ method _format_offset_date {base offset} {
 }
 
 method _gitkcommit {} {
-	global null_sha1
+	global null_oid
 
 	set dat [_get_click_amov_info $this]
 	if {$dat ne {}} {
 		set cmit [lindex $dat 0]
 
 		# If the line belongs to the working copy, use HEAD instead
-		if {$cmit eq $null_sha1} {
+		if {$cmit eq $null_oid} {
 			if {[catch {set cmit [git rev-parse --verify HEAD]} err]} {
 				error_popup [strcat [mc "Cannot find HEAD commit:"] "\n\n$err"]
 				return;
@@ -1106,7 +1106,7 @@ method _gitkcommit {} {
 }
 
 method _blameparent {} {
-	global null_sha1
+	global null_oid
 
 	set dat [_get_click_amov_info $this]
 	if {$dat ne {}} {
@@ -1114,7 +1114,7 @@ method _blameparent {} {
 		set new_path [lindex $dat 1]
 
 		# Allow using Blame Parent on lines modified in the working copy
-		if {$cmit eq $null_sha1} {
+		if {$cmit eq $null_oid} {
 			set parent_ref "HEAD"
 		} else {
 			set parent_ref "$cmit^"
@@ -1129,7 +1129,7 @@ method _blameparent {} {
 		# Generate a diff between the commit and its parent,
 		# and use the hunks to update the line number.
 		# Request zero context to simplify calculations.
-		if {$cmit eq $null_sha1} {
+		if {$cmit eq $null_oid} {
 			set diffcmd [list diff-index --unified=0 $cparent -- $new_path]
 		} else {
 			set diffcmd [list diff-tree --unified=0 $cparent $cmit -- $new_path]
diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
index 21ea768..be1ebba 100644
--- a/lib/checkout_op.tcl
+++ b/lib/checkout_op.tcl
@@ -151,7 +151,7 @@ method _finish_fetch {ok} {
 }
 
 method _update_ref {} {
-	global null_sha1 current_branch repo_config
+	global null_oid current_branch repo_config
 
 	set ref $new_ref
 	set new $new_hash
@@ -177,7 +177,7 @@ method _update_ref {} {
 		}
 
 		set reflog_msg "branch: Created from $new_expr"
-		set cur $null_sha1
+		set cur $null_oid
 
 		if {($repo_config(branch.autosetupmerge) eq {true}
 			|| $repo_config(branch.autosetupmerge) eq {always})
-- 
2.33.0.1081.g099423f5b7

