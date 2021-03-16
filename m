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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73706C43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6E264F6C
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhCPAyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhCPAyg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:54:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD888C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:54:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso420269pji.3
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=y/FyqYdUrIEtuuDrl3IU5HHgBCKoHDsokOpXAuTpXVA=;
        b=lE4gJ5w76s3K1JFsiw+O4b7R3qWK8fGiXgrVdJaD3AEb193ft6E9kl/SlXesmcGhTD
         zrf/C9r9WvngtuglGJnu4r3xnDnYQ/JLPMRTqd1FOncn9uHj+ym1f2DZkJRzVzIVlWC/
         1bkPmQZLkAs6rpaHqnqEbMyxpeaj+rQ0xoCsdLFmctb2fQHdkzE7aH1OmR3/kLFWoIdH
         WXsWYZwXxF+B9nFC+HnFEaiOEdn7LEaXr7QHk6uUFAyQ1OKkKyXzkYBieYj1JBnrdgsm
         3fraLg/XTSAroykjOfZ72ZY6LjxCBSv090NnnU6GthtjZNdOwiNJtfJ4Eo0EWV6vzrlr
         wLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/FyqYdUrIEtuuDrl3IU5HHgBCKoHDsokOpXAuTpXVA=;
        b=FIUvy/yM0m3J7USYhKamCJywGgp5xLe5+ZXDFr0DbjSpXNFZ9DyZUBcSklBHcJnVq5
         yI8dJ/yl0m4/6r6+2rNkkBAkedRhRVnQ6tKsD4exZ9ETymQ/JA5lG2YOhuAvy+FxEcit
         o4VfCQiMo4JcqMGByxVt875pCVj153XZYwrsFG3JiVDU9DNByUJVIEsEwTa03qy8acN6
         cyad1/gcULNwBA9hz2+tn0Xze9biT0oAusDPliWfs6RbVzxv7PixZ9JlLNf32nhuIzYp
         n+qFW4gXz1qVAn0uaxwExk5rnRvgxn5DOTMAIWBms7WH/XhO6xJagRxIdzb4yI7M2X2+
         cR+w==
X-Gm-Message-State: AOAM530VNg9UYA8tJOXTuJM3j1GegcIbLGxVLQXFl/s2Y7K4R0buHQbA
        cVFc4MmGSkni9FOMg/TLHQFhISxKOcs=
X-Google-Smtp-Source: ABdhPJyVc+AdAjoNL39aOUeu9R8X6qS66iAOjj+DpE1WtKkS/xJESPloEX533zP2xh73nV34pmG7Hg==
X-Received: by 2002:a17:90a:9103:: with SMTP id k3mr1984654pjo.157.1615856076073;
        Mon, 15 Mar 2021 17:54:36 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id y24sm14449791pfn.213.2021.03.15.17.54.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:54:35 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] git-completion.bash: use __gitcomp_builtin() in _git_stash()
Date:   Mon, 15 Mar 2021 17:54:20 -0700
Message-Id: <d6deaecc1feb771b245f50bc8b9cb197bf693405.1615855962.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1615855962.git.liu.denton@gmail.com>
References: <cover.1615855962.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The completion for 'git stash' has not changed in a major way since it
was converted from shell script to builtin. Now that it's a builtin, we
can take advantage of the groundwork laid out by parse-options and use
the generated options.

Rewrite _git_stash() to take use __gitcomp_builtin() to generate
completions for subcommands.

The main `git stash` command does not take any arguments directly. If no
subcommand is given, it automatically defaults to `git stash push`. This
means that we can simplify the logic for when no subcommands have been
given yet. We only have to offer subcommand completions when we're
completing the word after "stash". Unfortunately, this does not work
100% correctly. For example, in the case of something like `git -C stash
stash<TAB>`, this will incorrectly identify the first "stash" as the
command. This seems to be an edge-case that we can ignore, though, as
other functions, such as _git_worktree(), suffer from the same problem.

One area that this patch could improve upon is that the `git stash list`
command accepts log-options. It would be nice if the completion for this
were unified with that of _git_log() and _git_show() which would allow
completions to be provided for options such as `--pretty` but that is
outside the scope of this patch.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 41 ++++++++++++--------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index da46f46e3c..83b6415b13 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3013,29 +3013,21 @@ _git_sparse_checkout ()
 
 _git_stash ()
 {
-	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
 	local subcommands='push list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
 	local stash_idx="$(__git_find_on_cmdline --show-idx stash)"
 	stash_idx="${stash_idx% *}"
 
-	if [ -z "$subcommand" -a -n "$(__git_find_on_cmdline "-p")" ]; then
-		subcommand="push"
-	fi
 	if [ -z "$subcommand" ]; then
-		case "$cur" in
-		--*)
-			__gitcomp "$save_opts"
+		case "$((cword - stash_idx)),$cur" in
+		*,--*)
+			__gitcomp_builtin stash_push
 			;;
-		sa*)
-			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
-				__gitcomp "save"
-			fi
+		1,sa*)
+			__gitcomp "save"
 			;;
-		*)
-			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
-				__gitcomp "$subcommands"
-			fi
+		1,*)
+			__gitcomp "$subcommands"
 			;;
 		esac
 		return
@@ -3043,24 +3035,29 @@ _git_stash ()
 
 	case "$subcommand,$cur" in
 	push,--*)
-		__gitcomp "$save_opts --message"
+		__gitcomp_builtin stash_push
 		;;
 	save,--*)
-		__gitcomp "$save_opts"
+		__gitcomp_builtin stash_save
 		;;
-	apply,--*|pop,--*)
-		__gitcomp "--index --quiet"
+	pop,--*)
+		__gitcomp_builtin stash_pop
+		;;
+	apply,--*)
+		__gitcomp_builtin stash_apply
 		;;
 	drop,--*)
-		__gitcomp "--quiet"
+		__gitcomp_builtin stash_drop
 		;;
 	list,--*)
-		__gitcomp "--name-status --oneline --patch-with-stat"
+		# NEEDSWORK: can we somehow unify this with the options in _git_log() and _git_show()
+		__gitcomp_builtin stash_list "$__git_log_common_options $__git_diff_common_options"
 		;;
 	show,--*)
-		__gitcomp "$__git_diff_common_options"
+		__gitcomp_builtin stash_show "$__git_diff_common_options"
 		;;
 	branch,--*)
+		__gitcomp_builtin stash_branch
 		;;
 	branch,*)
 		if [ $((cword - stash_idx)) -eq 2 ]; then
-- 
2.31.0.rc2.261.g7f71774620

