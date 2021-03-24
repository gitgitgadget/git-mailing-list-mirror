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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AD3C433E1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 08:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8ACC619EC
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 08:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbhCXIhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 04:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbhCXIgo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 04:36:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8717C061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 01:36:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g15so16806371pfq.3
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8hPzGPdDYZtIlbuwbtu5eIHsr+yILMTARd22XBhMVvw=;
        b=CR3zSzXugdKMEkQ3Zz7c4YlFetjjlvepJZ5aI+Y2nWq9JjizW1S8oUDjc/7HRs1ziT
         Zg+bgYQypsh28P6HWcjvFYGWJlKO6PtkJcITyJELTFERv+J2pth4ZB9GiOOXUdYdK65X
         jVw0bSGsC4Qyn4nzWEi6lnF1UUxjnkbNhNiEaK15oJbYE8Fw04pkou80fQKgeQfctDVm
         Tqml9VeLyqvf/wdnUPRPtpPdCNcMByV85tfTATk7m0O06TuEzsCf3dRpAR7StmsHZ4p4
         BjwY6EoI573dPql+HRc/nklWXOwAjgvMby0stgID+DqVnlnrGhwfRU/V2AGtr7QNKKAH
         hQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8hPzGPdDYZtIlbuwbtu5eIHsr+yILMTARd22XBhMVvw=;
        b=VJ/iXYgLtI0AtD+GbY4ai4LezteitkM3QO7lUaZp+/SBwth0v1LOJjtmH7ppaEQOFx
         +Uwba2fHbMukiiPO0mGJiZYpsYUwJ+QcIxmjgdD/x5r75iyzp4eGi3rLvpoJmA8NeJK/
         THZ8nlj1HSXalkOTeNjtJWWPCCLIkL5uE5UVXlSp0kZxdZpBXHDJ1FRt9uahm0w8WG/d
         DfeJj9cte39dqkCrhyKQCii0veP9wEBGarIYj/wl+WG4Ni8qd7efa1KvMcSOqKWPBjO0
         PqHWrOBfd9QgpwB/ofPV7G9B8co9yVYMUehccO6rPah1kVf0XIXizQ8qXxEhcREw6xc6
         UxCQ==
X-Gm-Message-State: AOAM532LLCc1YDtU8GsS8yxXlKmGjN567am65OpNWsX8nebGWSZ0QakL
        Ulmogjml/rNWj5pYbZJ9vAVtOEHSRdo=
X-Google-Smtp-Source: ABdhPJyG0kzFDetf149Kf8xiDfkrAHpyZodGlckXvaltMXkPy4LvXijxwJBLLF//nQ8Ome2FnzdM8A==
X-Received: by 2002:a65:4347:: with SMTP id k7mr2141019pgq.88.1616575002783;
        Wed, 24 Mar 2021 01:36:42 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id a15sm1609361pju.34.2021.03.24.01.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 01:36:42 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] git-completion.bash: use __gitcomp_builtin() in _git_stash()
Date:   Wed, 24 Mar 2021 01:36:29 -0700
Message-Id: <680f3a3146355e6b09aa2e0f59471c7695954a1b.1616574955.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1616574955.git.liu.denton@gmail.com>
References: <cover.1615855962.git.liu.denton@gmail.com> <cover.1616574955.git.liu.denton@gmail.com>
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
completing a non-option after "stash".

One area that this patch could improve upon is that the `git stash list`
command accepts log-options. It would be nice if the completion for this
were unified with that of _git_log() and _git_show() which would allow
completions to be provided for options such as `--pretty` but that is
outside the scope of this patch.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 42 ++++++++++++--------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8d4d8cc0fe..c926ca26c6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3013,26 +3013,19 @@ _git_sparse_checkout ()
 
 _git_stash ()
 {
-	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
 	local subcommands='push list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
-	if [ -z "$subcommand" -a -n "$(__git_find_on_cmdline "-p")" ]; then
-		subcommand="push"
-	fi
+
 	if [ -z "$subcommand" ]; then
-		case "$cur" in
-		--*)
-			__gitcomp "$save_opts"
+		case "$((cword - __git_subcommand_idx)),$cur" in
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
@@ -3040,24 +3033,29 @@ _git_stash ()
 
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
 		if [ $cword -eq $((__git_subcommand_idx+2)) ]; then
-- 
2.31.0.rc2.261.g7f71774620

