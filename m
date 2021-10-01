Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DB9C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40FC61037
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbhJAWOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 18:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhJAWOC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 18:14:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA20C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 15:12:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z24so44056283lfu.13
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 15:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:user-agent:mime-version;
        bh=UlZttO/JwtaQyYaSF1QKP3IeWGWyHjd3AOKwVPXz/wg=;
        b=gFOlWWXsJqzF0TmAHrE5Fw53+VNIA5toFMZ/O0oCvFPa05GC9XNRu+FZ2eZ3UsuL6u
         WDhZ3CLYtEPKqPIxbiw6o4Pqv/+rHhaXchzSgV7UVrdgkx1sLWd4c3UAr/XuHetSAJAr
         JLIuRblwQjW20rRaCafKpWfBj6F7qD/5inh/82+t2mmi2XxIPkFbwoUEliIxIsxK5K9k
         jzc/RpaJpku480IScRioEnFMC7FTNaxpr69x4Hb6bZzHyWWnnvf0ptLS/+0L/G6yvshT
         yG42Znd9tjQqkPNNr7ubOmvty6cQoR+NtaeBV5NxkGzhHOCLrHJ19iX7PLOsUwNlFTs3
         le4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version;
        bh=UlZttO/JwtaQyYaSF1QKP3IeWGWyHjd3AOKwVPXz/wg=;
        b=iisd75oJzgHjxwF5k3R08QZmYSUjl6WGjjH4t21ECkvubfdtAOOXSpHh0C54GtN5Dq
         lpUkdLBlZQinwZufgWUHMseC1YDIVOhJze4H8723exkBzxJFa4bNDJwSkZFdzrnhuIeA
         o4BE34ZryThHRz1CPb5DO19T2lf81Dl/WR8aedgCSRoDcKKdj1PQFOHUiK+rFFsFrxmo
         4Ap4FuKsKfYiQ11CJez3ukVNwHFZI3ZI/lBhd/+WCIB39BHHiqyJWrQIbunBlJnsNYbi
         PxGIU5nkFBEu6d0Nyp0xpPk5bZqvtIEeJLSkUFxh16ULxtIUL0iAFBjGcjn+hF8CT0oj
         EuzQ==
X-Gm-Message-State: AOAM532x4S4Tbp/ukCL/TVtEyNyZBd6rkIkmjaEObe+wYD00e6HWQGcB
        ohou6w0zTKL2dUQ3hJy9dIKEhLbEi8g=
X-Google-Smtp-Source: ABdhPJwVYxzrkwv/Y2jHBcoJoD7Ebbm+phKhmhhH1k/MG/MsVzUxGFqBebOZQrRbe3HClensybU2SQ==
X-Received: by 2002:a05:6512:312:: with SMTP id t18mr511731lfp.688.1633126335811;
        Fri, 01 Oct 2021 15:12:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j20sm684991lfu.304.2021.10.01.15.12.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 15:12:15 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH RFC] stash: implement '--staged' option for 'push' and 'save'
Date:   Sat, 02 Oct 2021 01:12:14 +0300
Message-ID: <875yugcs3l.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Stash only the changes that are staged.

This mode allows to easily stash-out for later reuse some changes
unrelated to the current work in progress.

Unlike 'stash push --patch', --staged supports using of any tool to
select the changes to stash-out, including, but not limited to 'git add
--interactive'.

This operation that is essentially just a 'git commit', but to the
stash, is somehow missed, complicating the task that is otherwise simple
and natural. For example, see discussions here:

https://stackoverflow.com/questions/14759748/stashing-only-staged-changes-in-git-is-it-possible

NOTE: I'm entirely unfamiliar with the code, and the implementation
below is the first thing that came to my mind, without much thought.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-stash.txt | 32 +++++++++++++++--
 builtin/stash.c             | 72 ++++++++++++++++++++++++-------------
 2 files changed, 77 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index be6084ccefbe..90d83839d282 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+'git stash' [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	     [--] [<pathspec>...]]
@@ -47,7 +47,7 @@ stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 COMMANDS
 --------
 
-push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]::
+push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]::
 
 	Save your local modifications to a new 'stash entry' and roll them
 	back to HEAD (in the working tree and in the index).
@@ -60,7 +60,7 @@ subcommand from making an unwanted stash entry.  The two exceptions to this
 are `stash -p` which acts as alias for `stash push -p` and pathspec elements,
 which are allowed after a double hyphen `--` for disambiguation.
 
-save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
 	This option is deprecated in favour of 'git stash push'.  It
 	differs from "stash push" in that it cannot take pathspec.
@@ -205,6 +205,14 @@ to learn how to operate the `--patch` mode.
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
 
+-S::
+--staged::
+	This option is only valid for `push` and `save` commands.
++
+Stash only the changes that are currently staged in the index.
++
+The `--patch` option has priority over this one.
+
 --pathspec-from-file=<file>::
 	This option is only valid for `push` command.
 +
@@ -341,6 +349,24 @@ $ edit/build/test remaining parts
 $ git commit foo -m 'Remaining parts'
 ----------------------------------------------------------------
 
+Saving unrelated changes for future use::
+
+When you are in the middle of massive changes and you find some
+unrelated issue that you don't want to forget to fix, you can do the
+change(s), stage them, and use `git stash push --staged` to stash them
+out for future use. This is similar to committing the staged changes,
+only the commit ends-up being in the stash and not on the current branch.
++
+----------------------------------------------------------------
+# ... hack hack hack ...
+$ git add --patch foo           # add unrelated changes to the index
+$ git stash push --staged       # save these changes to the stash
+# ... hack hack hack, finish curent changes ...
+$ git commit -m 'Massive'       # commit fully tested changes
+$ git switch fixup-branch       # switch to another branch
+$ git stash pop                 # to finish work on the saved changes
+----------------------------------------------------------------
+
 Recovering stash entries that were cleared/dropped erroneously::
 
 If you mistakenly drop or clear stash entries, they cannot be recovered
diff --git a/builtin/stash.c b/builtin/stash.c
index 8f42360ca913..82d97b0c7e42 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -27,11 +27,11 @@ static const char * const git_stash_usage[] = {
 	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash branch <branchname> [<stash>]"),
 	"git stash clear",
-	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	N_("git stash [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
 	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
 	   "          [--] [<pathspec>...]]"),
-	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	N_("git stash save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
 	NULL
 };
@@ -1117,7 +1117,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 }
 
 static int stash_patch(struct stash_info *info, const struct pathspec *ps,
-		       struct strbuf *out_patch, int quiet)
+		       struct strbuf *out_patch, int only_staged, int quiet)
 {
 	int ret = 0;
 	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
@@ -1136,24 +1136,27 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 		goto done;
 	}
 
-	/* Find out what the user wants. */
-	old_repo_index_file = the_repository->index_file;
-	the_repository->index_file = stash_index_path.buf;
-	old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
-	setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
+	if (!only_staged) {
+		/* Find out what the user wants. */
+		old_repo_index_file = the_repository->index_file;
+		the_repository->index_file = stash_index_path.buf;
+		old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
+		setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
 
-	ret = run_add_interactive(NULL, "--patch=stash", ps);
+		ret = run_add_interactive(NULL, "--patch=stash", ps);
 
-	the_repository->index_file = old_repo_index_file;
-	if (old_index_env && *old_index_env)
-		setenv(INDEX_ENVIRONMENT, old_index_env, 1);
-	else
-		unsetenv(INDEX_ENVIRONMENT);
-	FREE_AND_NULL(old_index_env);
+		the_repository->index_file = old_repo_index_file;
+		if (old_index_env && *old_index_env)
+			setenv(INDEX_ENVIRONMENT, old_index_env, 1);
+		else
+			unsetenv(INDEX_ENVIRONMENT);
+		FREE_AND_NULL(old_index_env);
+	}
 
 	/* State of the working tree. */
-	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
-				NULL)) {
+	if (write_index_as_tree(&info->w_tree, &istate,
+				(only_staged ? the_repository->index_file : stash_index_path.buf),
+				0, NULL)) {
 		ret = -1;
 		goto done;
 	}
@@ -1242,7 +1245,7 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 }
 
 static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_buf,
-			   int include_untracked, int patch_mode,
+			   int include_untracked, int patch_mode, int only_staged,
 			   struct stash_info *info, struct strbuf *patch,
 			   int quiet)
 {
@@ -1312,7 +1315,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
-		ret = stash_patch(info, ps, patch, quiet);
+		ret = stash_patch(info, ps, patch, only_staged, quiet);
 		if (ret < 0) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the current "
@@ -1379,7 +1382,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	if (!check_changes_tracked_files(&ps))
 		return 0;
 
-	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, &info,
+	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, 0, &info,
 			      NULL, 0);
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1389,7 +1392,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 }
 
 static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
-			 int keep_index, int patch_mode, int include_untracked)
+			 int keep_index, int patch_mode, int include_untracked, int only_staged)
 {
 	int ret = 0;
 	struct stash_info info;
@@ -1407,6 +1410,21 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		goto done;
 	}
 
+	/* --patch overrides --staged */
+	if (patch_mode)
+		only_staged = 0;
+
+	/* --staged reuses 'patch_mode' for implementation */
+	if (only_staged)
+		patch_mode = 1;
+
+	if (only_staged && include_untracked) {
+		fprintf_ln(stderr, _("Can't use --staged and --include-untracked"
+				     " or --all at the same time"));
+		ret = -1;
+		goto done;
+	}
+
 	read_cache_preload(NULL);
 	if (!include_untracked && ps->nr) {
 		int i;
@@ -1447,7 +1465,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 	if (stash_msg)
 		strbuf_addstr(&stash_msg_buf, stash_msg);
-	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
+	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode, only_staged,
 			    &info, &patch, quiet)) {
 		ret = -1;
 		goto done;
@@ -1581,6 +1599,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 {
 	int force_assume = 0;
 	int keep_index = -1;
+	int only_staged = 0;
 	int patch_mode = 0;
 	int include_untracked = 0;
 	int quiet = 0;
@@ -1591,6 +1610,8 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
 			 N_("keep index")),
+		OPT_BOOL('S', "staged", &only_staged,
+			 N_("stash staged changes only")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
 		OPT__QUIET(&quiet, N_("quiet mode")),
@@ -1640,12 +1661,13 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	}
 
 	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
-			     include_untracked);
+			     include_untracked, only_staged);
 }
 
 static int save_stash(int argc, const char **argv, const char *prefix)
 {
 	int keep_index = -1;
+	int only_staged = 0;
 	int patch_mode = 0;
 	int include_untracked = 0;
 	int quiet = 0;
@@ -1656,6 +1678,8 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
 			 N_("keep index")),
+		OPT_BOOL('S', "staged", &only_staged,
+			 N_("stash in patch mode")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
 		OPT__QUIET(&quiet, N_("quiet mode")),
@@ -1677,7 +1701,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 
 	memset(&ps, 0, sizeof(ps));
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
-			    patch_mode, include_untracked);
+			    patch_mode, include_untracked, only_staged);
 
 	strbuf_release(&stash_msg_buf);
 	return ret;
-- 
2.25.1
