Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2119C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 08:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EEF619F7
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 08:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhCXIhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 04:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhCXIgl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 04:36:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87891C061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 01:36:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q11so7540221pld.11
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 01:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wOu7vx20e9QwWcsk8yCbee9+9MMnJbJ02UM9I3Vs1Z8=;
        b=vbJq1n0PpdcZ0zCU1oUzN/9uEB/583fzP0cOoVjA0+qaagJwZLU2WSS9pzoyE1fZXv
         SnUIrM5RXBP9IAjSS2tFgAV99TQC7JLANSAATP3WcW1IK5FkIW6rvX8EHwSGn7ixtge8
         ClMo0Gmo1U0O2/o37kK6EInydLPFI8wW2EqIhpKDObsxZJHzRXbkzilaSH3tkLKkLYV1
         ve+rsoY1Y/KzQrUG1nBPMlFst7hz8ZHlSntUQwdKmNELzCWaY/KlqZiyvxbB7wIl/y0I
         v/f4uuvTfQcEI/39ePQxJNf4/haFDcRJNxlWqrqR1sX5p535OthT7VI4u5LlUGR8M8O1
         H82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wOu7vx20e9QwWcsk8yCbee9+9MMnJbJ02UM9I3Vs1Z8=;
        b=gQjWxbYrrRfpKAXEXkwfkNCwgxHGWwCVRBrYPTaLlekARnVoCKK5NOlPPrnnmicQ2Z
         /kmsUmD1WWvIyOKK5QLbEuqyyl/WwJLjo3gAXObDmN1e4T9Bh5ynGqxRgPdSHL6H7yy4
         JgPKjNwbloyUqj07I0j1k/mZuDDTBDtGsael5bi5xVDPfssBmsssRGVKpGyu7M8+1znV
         6Fju3oZ0nOm8MWPCU6QutThfJX+3uNRUyRs0QL1xzeNR2CvPuUx5dmJpOPaKeKTkAe96
         CWq3Ho9gSOpHZR3W1QyZGgNkC1prfBqziC3eQZglwKwKDS0GPBP5DMENZOepnJvKoOUY
         1kjQ==
X-Gm-Message-State: AOAM532lyxGQecQvOTBRMgGIC6i+i1iy1GYV63tKt4pcuuyPvuQvKPpa
        62gE5hake/NXZYpbgBS0IohfbqZC8rE=
X-Google-Smtp-Source: ABdhPJyNYGuE7/GIsQjx08pa9kL1UP5U0zFJrLS1RsHFgpBiYiC4gtuS9ZBKBuHxotzUKJf3MX2K+A==
X-Received: by 2002:a17:90b:809:: with SMTP id bk9mr2304537pjb.83.1616575000819;
        Wed, 24 Mar 2021 01:36:40 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id a15sm1609361pju.34.2021.03.24.01.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 01:36:40 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] git-completion.bash: pass $__git_subcommand_idx from __git_main()
Date:   Wed, 24 Mar 2021 01:36:27 -0700
Message-Id: <e4aa3e8cd7f64512ce0d72906f4d15f1f0dc0a60.1616574955.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1616574955.git.liu.denton@gmail.com>
References: <cover.1615855962.git.liu.denton@gmail.com> <cover.1616574955.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many completion functions perform hardcoded comparisons with $cword.
This fails in the case where the main git command is given arguments
(e.g. `git -C . bundle<TAB>` would fail to complete its subcommands).

Even _git_worktree(), which uses __git_find_on_cmdline(), could still
fail. With something like `git -C add worktree move<TAB>`, the
subcommand would be incorrectly identified as "add" instead of "move".

Assign $__git_subcommand_idx in __git_main(), where the git subcommand
is actually found and the corresponding completion function is called.
Use this variable to replace hardcoded comparisons with $cword.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7dc6cd8eb8..a2f1b5e916 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1474,12 +1474,12 @@ _git_branch ()
 
 _git_bundle ()
 {
-	local cmd="${words[2]}"
+	local cmd="${words[__git_subcommand_idx+1]}"
 	case "$cword" in
-	2)
+	$((__git_subcommand_idx+1)))
 		__gitcomp "create list-heads verify unbundle"
 		;;
-	3)
+	$((__git_subcommand_idx+2)))
 		# looking for a file
 		;;
 	*)
@@ -1894,7 +1894,7 @@ _git_grep ()
 	esac
 
 	case "$cword,$prev" in
-	2,*|*,-*)
+	$((__git_subcommand_idx+1)),*|*,-*)
 		__git_complete_symbol && return
 		;;
 	esac
@@ -3058,7 +3058,7 @@ _git_stash ()
 		branch,--*)
 			;;
 		branch,*)
-			if [ $cword -eq 3 ]; then
+			if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
 				__git_complete_refs
 			else
 				__gitcomp_nl "$(__git stash list \
@@ -3277,11 +3277,9 @@ __git_complete_worktree_paths ()
 _git_worktree ()
 {
 	local subcommands="add list lock move prune remove unlock"
-	local subcommand subcommand_idx
+	local subcommand
 
-	subcommand="$(__git_find_on_cmdline --show-idx "$subcommands")"
-	subcommand_idx="${subcommand% *}"
-	subcommand="${subcommand#* }"
+	subcommand="$(__git_find_on_cmdline "$subcommands")"
 
 	case "$subcommand,$cur" in
 	,*)
@@ -3306,7 +3304,7 @@ _git_worktree ()
 			# be either the 'add' subcommand, the unstuck
 			# argument of an option (e.g. branch for -b|-B), or
 			# the path for the new worktree.
-			if [ $cword -eq $((subcommand_idx+1)) ]; then
+			if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
 				# Right after the 'add' subcommand: have to
 				# complete the path, so fall back to Bash
 				# filename completion.
@@ -3330,7 +3328,7 @@ _git_worktree ()
 		__git_complete_worktree_paths
 		;;
 	move,*)
-		if [ $cword -eq $((subcommand_idx+1)) ]; then
+		if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
 			# The first parameter must be an existing working
 			# tree to be moved.
 			__git_complete_worktree_paths
@@ -3398,6 +3396,7 @@ __git_main ()
 {
 	local i c=1 command __git_dir __git_repo_path
 	local __git_C_args C_args_count=0
+	local __git_subcommand_idx
 
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
@@ -3412,7 +3411,7 @@ __git_main ()
 			__git_C_args[C_args_count++]="${words[c]}"
 			;;
 		-*) ;;
-		*) command="$i"; break ;;
+		*) command="$i"; __git_subcommand_idx="$c"; break ;;
 		esac
 		((c++))
 	done
-- 
2.31.0.rc2.261.g7f71774620

