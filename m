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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5DCC433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878CE6144D
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 10:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhDVKBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 06:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbhDVKBn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 06:01:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D7AC06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 03:01:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u15so14712698plf.10
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 03:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kx+fJVZamUGpAY5sKjS7VYX+PeEwWphyhbnMBpr/DAQ=;
        b=TMsRkpja3TG75jIM1IOa9pY7kBRBUl1yqd6/yUdk9/WOpjv3s/pOM6xuFmfEYD8jA/
         L+2Wlo7IwcSenPSFLaUiF1MAxvYvxwlJk3+ZyvDp1FDWpXK2E9RfG7H2hHxdlr2g4BNj
         1ppYIVVHM5Ve/hHeRtcvpxp6v778F+iusbJNZWflDFSYIv8MdCj7WZBg3XsCkQepkXPM
         X7Rrk5SADGlLNc7NLnoMU44iODJDWcvq/x/smPIzvJoCNrf1+4ceVtCpBdDuPBdzHPPs
         DvfGj1x4X5tyyMj4m3nrn72+0mxyRaVq7z/R5f8CATRUeykMWEt6Z+F30EL8RXrka9Jd
         BaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kx+fJVZamUGpAY5sKjS7VYX+PeEwWphyhbnMBpr/DAQ=;
        b=mDt5/j7lkmkMH3pc2hsH3W7D1GVH4WJSwtPwip3VCnW5jm2v1Qw/kVJ/YrS6uvEtbt
         gylkUyPUmsEvGWUeIykHt7b6I353sJ4A3jGU9nNVvI0MQ5zmgcUaK7qsoxaT7cQc3e9I
         hJOQ1LLzsOI2hFDbBi2z2dqGLER4AE2LOC/ACFCeRKK9UbDmOP/ro/OIqZb/kSOsUu+6
         a729SzRPktnBIFfqsfwl/RxJKhNnhdGoGr2aqgp7CmD7P1Xbe0rMCbiveQ6uEATB5Ai3
         p+qTh+BSctS3tU2lYWqMreWQ7vJxfWObDPCn+mfaQyRylzD+K+ftoG0lXlPVsS1HwJdp
         FR2A==
X-Gm-Message-State: AOAM5307C+9w93PI9OxEtX0185nIcGtGW/e/0OfhQE0wDhKNxWrXA64p
        ybdCjcNZ57RFnQaUgOCHxurFwbkGz9k=
X-Google-Smtp-Source: ABdhPJwFmPjFHGjO5hTbxvKlgWwnOhol6wywcMPdsB2UKNye04RudZEipPqOr233CMZdVwabsYC8xQ==
X-Received: by 2002:a17:90b:813:: with SMTP id bk19mr16218645pjb.108.1619085666877;
        Thu, 22 Apr 2021 03:01:06 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id r3sm1741314pfl.159.2021.04.22.03.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 03:01:05 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] git-completion.bash: rename to $__git_cmd_idx
Date:   Thu, 22 Apr 2021 03:00:50 -0700
Message-Id: <76328e3123bd670435632244cbdd0e68db815804.1619085387.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.1.499.g90b4fd31cd
In-Reply-To: <cover.1619085387.git.liu.denton@gmail.com>
References: <cover.1618910364.git.liu.denton@gmail.com> <cover.1619085387.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e94fb44042 (git-completion.bash: pass $__git_subcommand_idx from
__git_main(), 2021-03-24), the $__git_subcommand_idx variable was
introduced. Naming it after the index of the subcommand is needlessly
confusing as, when this variable is used, it is in the completion
functions for commands (e.g. _git_remote()) where for `git remote add`,
the `remote` is referred to as the command and `add` is referred to as
the subcommand.

Rename this variable so that it's obvious it's about git commands. While
we're at it, shorten up its name so that it's still readable without
being a handful to type.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1dedb14b47..c29c129f87 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1474,12 +1474,12 @@ _git_branch ()
 
 _git_bundle ()
 {
-	local cmd="${words[__git_subcommand_idx+1]}"
+	local cmd="${words[__git_cmd_idx+1]}"
 	case "$cword" in
-	$((__git_subcommand_idx+1)))
+	$((__git_cmd_idx+1)))
 		__gitcomp "create list-heads verify unbundle"
 		;;
-	$((__git_subcommand_idx+2)))
+	$((__git_cmd_idx+2)))
 		# looking for a file
 		;;
 	*)
@@ -1894,7 +1894,7 @@ _git_grep ()
 	esac
 
 	case "$cword,$prev" in
-	$((__git_subcommand_idx+1)),*|*,-*)
+	$((__git_cmd_idx+1)),*|*,-*)
 		__git_complete_symbol && return
 		;;
 	esac
@@ -3017,7 +3017,7 @@ _git_stash ()
 	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
 
 	if [ -z "$subcommand" ]; then
-		case "$((cword - __git_subcommand_idx)),$cur" in
+		case "$((cword - __git_cmd_idx)),$cur" in
 		*,--*)
 			__gitcomp_builtin stash_push
 			;;
@@ -3058,7 +3058,7 @@ _git_stash ()
 		__gitcomp_builtin stash_branch
 		;;
 	branch,*)
-		if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
+		if [ $cword -eq $((__git_cmd_idx+2)) ]; then
 			__git_complete_refs
 		else
 			__gitcomp_nl "$(__git stash list \
@@ -3303,7 +3303,7 @@ _git_worktree ()
 			# be either the 'add' subcommand, the unstuck
 			# argument of an option (e.g. branch for -b|-B), or
 			# the path for the new worktree.
-			if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
+			if [ $cword -eq $((__git_cmd_idx+2)) ]; then
 				# Right after the 'add' subcommand: have to
 				# complete the path, so fall back to Bash
 				# filename completion.
@@ -3327,7 +3327,7 @@ _git_worktree ()
 		__git_complete_worktree_paths
 		;;
 	move,*)
-		if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
+		if [ $cword -eq $((__git_cmd_idx+2)) ]; then
 			# The first parameter must be an existing working
 			# tree to be moved.
 			__git_complete_worktree_paths
@@ -3395,7 +3395,7 @@ __git_main ()
 {
 	local i c=1 command __git_dir __git_repo_path
 	local __git_C_args C_args_count=0
-	local __git_subcommand_idx
+	local __git_cmd_idx
 
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
@@ -3426,7 +3426,7 @@ __git_main ()
 			;;
 		*)
 			command="$i"
-			__git_subcommand_idx="$c"
+			__git_cmd_idx="$c"
 			break
 			;;
 		esac
-- 
2.31.1.499.g90b4fd31cd

