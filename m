Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE22C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 09:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6075D61363
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 09:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhDTJUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 05:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhDTJUd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 05:20:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D58C06138A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 02:20:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 31so10688178pgn.13
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oz9EgYl8lU1Gaw389Uq8GHGSxK5HGbLF0V3e4S6MBaA=;
        b=R0hqHYtyhXsR+HHqMpBZaKCpdqDBagdFoiJ9E1zq5W8Z4EZJhnncVOFLJoWJnyP94r
         gfIhkQPBIN7e+ydCr8MdRqJOF8+C+I7I5lzQWBABPVdE9dr/QO/dV1U0w32qzIi/84uh
         fKJ4KVfeMxzYX+ZyT9aJ6a8LUYAXqEp+YRIPbv5Sky63v1qnXuCh4ZyleZZ8WJUwZ3vX
         dvu+QXh578Nok2AyffuGYhBtls9l2J5Wsfu58Mz8bJW15My/Y0vOPAOWD0KV0A2rWOXa
         bfiu5g2Xa8X7wG6A/aPNVAAN7Gs0UgoXeHTkROY7KqKPO09d/8YLuxVdF2SgPDkQjmVX
         Jqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oz9EgYl8lU1Gaw389Uq8GHGSxK5HGbLF0V3e4S6MBaA=;
        b=syAPY8pe+t9zGRJ1LUmUZu5fDeS6t8vewyl5CxUyA/DRoJoSgcJm3/HEYTupCRSev/
         6AsT3hz3b+gn3z0qaw2NMKTCGGsTeLGH0iewTqKPxB0Lb1qVj5Kkvssdxwj9PslluDNp
         uIj5WNDJHl7nG9cLbyE/KdD5YSaMhUt0Efw1wRTmJLa37jEzltuGhlQ9u2HvfARr1IzX
         9/BCP9pew1g4Bf1MFbo77yS7xaEFzWy222O1860JPqVMn5Js7Zopqddr5TzOjebcUqv7
         m1e/1/teXmf003HKhxTywHLqX/9sn5ej/skPj3mX2Y1HMkfWT5gR5ch2QKUSMwgxQxxP
         x30w==
X-Gm-Message-State: AOAM530kOjKfNKhlLwOm4/yDduSElTeqHVqyQZiXUBxeUkN0hnBYA3mf
        hgP+IPlg4WsQMXSn0SgOi1ZgIqSWsn4=
X-Google-Smtp-Source: ABdhPJz5tUF2hm6/L24PWMaGJYnS+c4BH+uGaZgzIP/kil7tr/6By8jooHzLvN30A0QmIJE6QcpN5Q==
X-Received: by 2002:a63:1b10:: with SMTP id b16mr15764978pgb.308.1618910401618;
        Tue, 20 Apr 2021 02:20:01 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id k15sm15247630pfi.0.2021.04.20.02.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 02:20:01 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] git-completion.bash: rename to $__git_cmd_idx
Date:   Tue, 20 Apr 2021 02:19:48 -0700
Message-Id: <7c7d6de380d1aaa860e86627778bef6c0c78ca08.1618910364.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.1.424.g95a8dafae5
In-Reply-To: <cover.1618910364.git.liu.denton@gmail.com>
References: <cover.1618910364.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e94fb44042 (git-completion.bash: pass $__git_subcommand_idx from
__git_main(), 2021-03-24), the $__git_subcommand_idx variable was
introduced. Naming it after the index of the subcommand is flat-out
wrong as this variable really holds the index of the git comand (e.g.
"stash").

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
2.31.1.424.g95a8dafae5

