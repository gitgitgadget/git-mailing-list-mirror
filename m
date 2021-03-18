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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D75C43381
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 09:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4BE64F70
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 09:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhCRJrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 05:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRJrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 05:47:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD1CC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 02:47:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so2854059pjb.0
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=y/FyqYdUrIEtuuDrl3IU5HHgBCKoHDsokOpXAuTpXVA=;
        b=oSeZ3pGNsCvUazbHJuxh9VbzNbe2zmTRkpdSPzP2CBpyjZkcvbrNnfF4bxWFYOsZHh
         fZO0rgV0smndSqyXS7sJDYji6ViCrAHL2+JQcDb1HvkIZUK0OF1fKh1o5+FlYRwQAUt+
         Ic/QngH40z41ybBEvedEZ6Su9kriJ/J2VwCXL+qaNAk75YhATlNBVVdP87TW0vJAvx7K
         VKYYNOfmqYRUfsD1UU3Ba8Lwj6IOzs8gso7jLNPLsxwmWtmXJC+kynOtQL6+Pd19B4JD
         yfTD6XD6E0wgLunIlE4o0DkxR7/z8O4qxhY0gOJJdOHsjKv/F735j5hMgognwsnsoZEw
         4iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/FyqYdUrIEtuuDrl3IU5HHgBCKoHDsokOpXAuTpXVA=;
        b=Eth3wwaInk/1Es1ww6xWu0BjG0MC3QmaujK+/wCxJJsQEyC0J1PxZhffNafDtw2I4O
         WvdAED3lnHm1Zpv12nPlggrRWyP38uQ8O3yWeJrYArKMicneAKo8y9wZAtRydM5Ueyq7
         6weTctxu2i4OqYZti9mf3MSTUmauBotC1bvsXVjzlzHmInNggJoGhjN+8HScD1663iiy
         LfQwEY6RzH7/daLEQCAQtlUA5bzYVjFse8OMk4Pura38e3cEWlz1kRIhTnJoyc4QpPeq
         vVtu4ID6EX7CN4/59HZ7On9aT4huQAB3htK6x7zoIZBUxOsiA8Ub9sKeLKlcZOzZwbKz
         68zA==
X-Gm-Message-State: AOAM530gadV8lEvIcMk9xlRMXAMmAYmEfPjUxkOsBfOjXEP7WMReRDNP
        UpeXzgTpgr6Sua716k7XkaGsfFFtVnI=
X-Google-Smtp-Source: ABdhPJzm2EBCTaZJIKpIkbuhgUnXrdOtkJ2cryMtX5KxaXA69zja5HwpnOCenBdbYkqa4Jcb52+D2A==
X-Received: by 2002:a17:90b:4b0e:: with SMTP id lx14mr3358615pjb.147.1616060828477;
        Thu, 18 Mar 2021 02:47:08 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id b186sm1902326pfb.170.2021.03.18.02.47.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 02:47:08 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [RESEND PATCH 3/3] git-completion.bash: use __gitcomp_builtin() in _git_stash()
Date:   Thu, 18 Mar 2021 02:46:56 -0700
Message-Id: <d6deaecc1feb771b245f50bc8b9cb197bf693405.1616060793.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1616060793.git.liu.denton@gmail.com>
References: <cover.1615855962.git.liu.denton@gmail.com> <cover.1616060793.git.liu.denton@gmail.com>
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

