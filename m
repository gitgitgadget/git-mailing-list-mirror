Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFF2C2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2874520731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxCTVSFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgDDBMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33995 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgDDBMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id 14so7904715qtp.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h40MC6mBNbcIpzQQD5uwq6s+5+65M7z4l7rJIduVMbo=;
        b=SxCTVSFJAEa9eHSpPLrn/BYPrS3D5GbLigxaF74igX3UJ3jZrLcGz5XTf3nohg2I20
         z57y2WzPm3b+ktmrVf+NezT5+K5ej4taaENPSyewgPuH54FwBZuBPtIBgBqedBSMtYm0
         b2QR2TZoN5ZCrZ5wwhJ5ytHL3ibCnadRmLCE5LUqcTmBeO3ZGj+nunMfI2sunBYgWJWa
         kyILmsshRz+RAs3tkKkIOq0DvHLM+FGnNgdShoLXXnuMrJRyVpOilW7/lrkGj3j/w3kd
         5eGbBCoezeLb0/9gWK2gO8O3vLK1dQ/khOdhevnAeGqLMLFwerVGhRiJDtYf4zU5A2KU
         9P5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h40MC6mBNbcIpzQQD5uwq6s+5+65M7z4l7rJIduVMbo=;
        b=uMtMGe8vFgPBgJ++m4Tzbyz1WY4iHtR3TTW51B1/HDtkT/IM5FEmLyahKsBeEUquv2
         XIkI8sOIYmzPNzcJs1Rj2koNB4kMY7X+MdMnzL3Ov3BT5EQvpAOxDr9rCpGxLQb8zNuw
         ANTaydDYLEQ7HUWH3jqQ+XUSDHc9ea5OHk/T4diHD+JWZHO/f0CXCfwNZF3Ic2sBk2HJ
         O+7RcpQ6pLivuvF2HBA9o1ske0jroBwnW9e9EaCaSg+7glYpZKXRAVJPJ8m23S4GLMdz
         56EtZ14G6/RK3A+GdHwoxKPAV9+L6MG1s9gzNTz+5mTrVyeff8YHayHODYV8TetiHQbH
         aG+Q==
X-Gm-Message-State: AGi0Pub+4e+7GQsvpwRl+YQ5XkXhD9v5tle9MUJeoi1cL99eUDuGaWbQ
        gES9q+8vKgW5wNBR9O13JoNeygbI
X-Google-Smtp-Source: APiQypKwhUnYcKbZzEUkYDZR7aYC2w7R7JalXs/ZhDjybSVrlurMJJvsjbzy6S7NSrV9Oxmz1DxzbA==
X-Received: by 2002:ac8:fe9:: with SMTP id f38mr11237491qtk.130.1585962741377;
        Fri, 03 Apr 2020 18:12:21 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:20 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 21/23] merge: teach --autostash option
Date:   Fri,  3 Apr 2020 21:11:34 -0400
Message-Id: <7adf7941921065fa1a5e68524e2dd3cd28f9a12b.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In rebase, one can pass the `--autostash` option to cause the worktree
to be automatically stashed before continuing with the rebase. This
option is missing in merge, however.

Implement the `--autostash` option and corresponding `merge.autoStash`
option in merge which stashes before merging and then pops after.

This option is useful when a developer has some local changes on a topic
branch but they realize that their work depends on another branch.
Previously, they had to run something like

	git fetch ...
	git stash push
	git merge FETCH_HEAD
	git stash pop

but now, that is reduced to

	git fetch ...
	git merge --autostash FETCH_HEAD

When an autostash is generated, it is automatically reapplied to the
worktree only in three explicit situations:

	1. An incomplete merge is commit using `git commit`.
	2. A merge completes successfully.
	3. A merge is aborted using `git merge --abort`.

In all other situations where the merge state is removed using
remove_merge_branch_state() such as aborting a merge via
`git reset --hard`, the autostash is saved into the stash reflog
instead keeping the worktree clean.

Suggested-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/merge.txt  |  10 +++
 Documentation/git-merge.txt     |   6 +-
 Documentation/merge-options.txt |   8 +++
 branch.c                        |   1 +
 builtin/commit.c                |   2 +
 builtin/merge.c                 |  27 ++++++++
 builtin/rebase.c                |   3 +-
 builtin/reset.c                 |   4 +-
 parse-options.h                 |   1 +
 path.c                          |   1 +
 path.h                          |   4 +-
 t/t3033-merge-toplevel.sh       |  22 ++++++
 t/t7600-merge.sh                | 118 ++++++++++++++++++++++++++++++++
 13 files changed, 201 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index 6a313937f8..cb2ed58907 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -70,6 +70,16 @@ merge.stat::
 	Whether to print the diffstat between ORIG_HEAD and the merge result
 	at the end of the merge.  True by default.
 
+merge.autoStash::
+	When set to true, automatically create a temporary stash entry
+	before the operation begins, and apply it after the operation
+	ends.  This means that you can run merge on a dirty worktree.
+	However, use with care: the final stash application after a
+	successful merge might result in non-trivial conflicts.
+	This option can be overridden by the `--no-autostash` and
+	`--autostash` options of linkgit:git-merge[1].
+	Defaults to false.
+
 merge.tool::
 	Controls which merge tool is used by linkgit:git-mergetool[1].
 	The list below shows the valid built-in values.
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 092529c619..9cb14f0059 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -94,7 +94,8 @@ will be appended to the specified message.
 
 --abort::
 	Abort the current conflict resolution process, and
-	try to reconstruct the pre-merge state.
+	try to reconstruct the pre-merge state. If an autostash entry is
+	present, apply it back to the worktree.
 +
 If there were uncommitted worktree changes present when the merge
 started, 'git merge --abort' will in some cases be unable to
@@ -102,7 +103,8 @@ reconstruct these changes. It is therefore recommended to always
 commit or stash your changes before running 'git merge'.
 +
 'git merge --abort' is equivalent to 'git reset --merge' when
-`MERGE_HEAD` is present.
+`MERGE_HEAD` is present unless `MERGE_AUTOSTASH` is also present where
+the stash entry is applied to the worktree.
 
 --quit::
 	Forget about the current merge in progress. Leave the index
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 40dc4f5e8c..3985e6d4a9 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -155,6 +155,14 @@ ifndef::git-pull[]
 	Note that not all merge strategies may support progress
 	reporting.
 
+--autostash::
+--no-autostash::
+	Automatically create a temporary stash entry before the operation
+	begins, and apply it after the operation ends.  This means
+	that you can run the operation on a dirty worktree.  However, use
+	with care: the final stash application after a successful
+	merge might result in non-trivial conflicts.
+
 endif::git-pull[]
 
 --allow-unrelated-histories::
diff --git a/branch.c b/branch.c
index 579494738a..2d9e7675a6 100644
--- a/branch.c
+++ b/branch.c
@@ -344,6 +344,7 @@ void remove_merge_branch_state(struct repository *r)
 	unlink(git_path_merge_rr(r));
 	unlink(git_path_merge_msg(r));
 	unlink(git_path_merge_mode(r));
+	save_autostash(git_path_merge_autostash(r));
 }
 
 void remove_branch_state(struct repository *r, int verbose)
diff --git a/builtin/commit.c b/builtin/commit.c
index 7ba33a3bec..c1b25d2954 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1713,6 +1713,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 				     &oid, flags);
 	}
 
+	apply_autostash(git_path_merge_autostash(the_repository));
+
 	UNLEAK(err);
 	UNLEAK(sb);
 	return 0;
diff --git a/builtin/merge.c b/builtin/merge.c
index d127d2225f..f2f8069f85 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -82,6 +82,7 @@ static int show_progress = -1;
 static int default_to_upstream = 1;
 static int signoff;
 static const char *sign_commit;
+static int autostash;
 static int no_verify;
 
 static struct strategy all_strategy[] = {
@@ -286,6 +287,7 @@ static struct option builtin_merge_options[] = {
 	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+	OPT_AUTOSTASH(&autostash),
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
 	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
@@ -475,6 +477,7 @@ static void finish(struct commit *head_commit,
 	/* Run a post-merge hook */
 	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
 
+	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
 }
 
@@ -634,6 +637,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return 0;
 	} else if (!strcmp(k, "gpg.mintrustlevel")) {
 		check_trust_level = 0;
+	} else if (!strcmp(k, "merge.autostash")) {
+		autostash = git_config_bool(k, v);
+		return 0;
 	}
 
 	status = fmt_merge_msg_config(k, v, cb);
@@ -1281,6 +1287,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (abort_current_merge) {
 		int nargc = 2;
 		const char *nargv[] = {"reset", "--merge", NULL};
+		struct strbuf stash_oid = STRBUF_INIT;
 
 		if (orig_argc != 2)
 			usage_msg_opt(_("--abort expects no arguments"),
@@ -1289,8 +1296,19 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (!file_exists(git_path_merge_head(the_repository)))
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
 
+		if (read_oneliner(&stash_oid, git_path_merge_autostash(the_repository),
+			   READ_ONELINER_SKIP_IF_EMPTY)) {
+			strbuf_trim(&stash_oid);
+			unlink(git_path_merge_autostash(the_repository));
+		}
+
 		/* Invoke 'git reset --merge' */
 		ret = cmd_reset(nargc, nargv, prefix);
+
+		if (stash_oid.len)
+			apply_autostash_oid(stash_oid.buf);
+
+		strbuf_release(&stash_oid);
 		goto done;
 	}
 
@@ -1513,6 +1531,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			goto done;
 		}
 
+		if (autostash)
+			create_autostash(the_repository,
+					 git_path_merge_autostash(the_repository),
+					 "merge");
 		if (checkout_fast_forward(the_repository,
 					  &head_commit->object.oid,
 					  &commit->object.oid,
@@ -1579,6 +1601,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (fast_forward == FF_ONLY)
 		die(_("Not possible to fast-forward, aborting."));
 
+	if (autostash)
+		create_autostash(the_repository,
+				 git_path_merge_autostash(the_repository),
+				 "merge");
+
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_STRICT);
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b800c8bfca..e681ff58de 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1371,8 +1371,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
 			N_("GPG-sign commits"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-		OPT_BOOL(0, "autostash", &options.autostash,
-			 N_("automatically stash/stash pop before and after")),
+		OPT_AUTOSTASH(&options.autostash),
 		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
 				N_("add exec lines after each commit of the "
 				   "editable list")),
diff --git a/builtin/reset.c b/builtin/reset.c
index 18228c312e..0d155101f4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -25,6 +25,7 @@
 #include "cache-tree.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "sequencer.h"
 
 #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
 
@@ -437,8 +438,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		if (reset_type == HARD && !update_ref_status && !quiet)
 			print_new_head_line(lookup_commit_reference(the_repository, &oid));
 	}
-	if (!pathspec.nr)
+	if (!pathspec.nr) {
 		remove_branch_state(the_repository, 0);
+	}
 
 	return update_ref_status;
 }
diff --git a/parse-options.h b/parse-options.h
index fece5ba628..46af942093 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -336,5 +336,6 @@ int parse_opt_passthru_argv(const struct option *, const char *, int);
 #define OPT_CLEANUP(v) OPT_STRING(0, "cleanup", v, N_("mode"), N_("how to strip spaces and #comments from message"))
 #define OPT_PATHSPEC_FROM_FILE(v) OPT_FILENAME(0, "pathspec-from-file", v, N_("read pathspec from file"))
 #define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
+#define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically stash/stash pop before and after"))
 
 #endif
diff --git a/path.c b/path.c
index 88cf593007..d764738146 100644
--- a/path.c
+++ b/path.c
@@ -1535,5 +1535,6 @@ REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
 REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
 REPO_GIT_PATH_FUNC(merge_mode, "MERGE_MODE")
 REPO_GIT_PATH_FUNC(merge_head, "MERGE_HEAD")
+REPO_GIT_PATH_FUNC(merge_autostash, "MERGE_AUTOSTASH")
 REPO_GIT_PATH_FUNC(fetch_head, "FETCH_HEAD")
 REPO_GIT_PATH_FUNC(shallow, "shallow")
diff --git a/path.h b/path.h
index 14d6dcad16..1f1bf8f87a 100644
--- a/path.h
+++ b/path.h
@@ -177,11 +177,12 @@ struct path_cache {
 	const char *merge_rr;
 	const char *merge_mode;
 	const char *merge_head;
+	const char *merge_autostash;
 	const char *fetch_head;
 	const char *shallow;
 };
 
-#define PATH_CACHE_INIT { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL }
+#define PATH_CACHE_INIT { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL }
 
 const char *git_path_cherry_pick_head(struct repository *r);
 const char *git_path_revert_head(struct repository *r);
@@ -190,6 +191,7 @@ const char *git_path_merge_msg(struct repository *r);
 const char *git_path_merge_rr(struct repository *r);
 const char *git_path_merge_mode(struct repository *r);
 const char *git_path_merge_head(struct repository *r);
+const char *git_path_merge_autostash(struct repository *r);
 const char *git_path_fetch_head(struct repository *r);
 const char *git_path_shallow(struct repository *r);
 
diff --git a/t/t3033-merge-toplevel.sh b/t/t3033-merge-toplevel.sh
index d314599428..e29c284b9b 100755
--- a/t/t3033-merge-toplevel.sh
+++ b/t/t3033-merge-toplevel.sh
@@ -142,6 +142,17 @@ test_expect_success 'refuse two-project merge by default' '
 	test_must_fail git merge five
 '
 
+test_expect_success 'refuse two-project merge by default, quit before --autostash happens' '
+	t3033_reset &&
+	git reset --hard four &&
+	echo change >>one.t &&
+	git diff >expect &&
+	test_must_fail git merge --autostash five 2>err &&
+	test_i18ngrep ! "stash" err &&
+	git diff >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'two-project merge with --allow-unrelated-histories' '
 	t3033_reset &&
 	git reset --hard four &&
@@ -149,4 +160,15 @@ test_expect_success 'two-project merge with --allow-unrelated-histories' '
 	git diff --exit-code five
 '
 
+test_expect_success 'two-project merge with --allow-unrelated-histories with --autostash' '
+	t3033_reset &&
+	git reset --hard four &&
+	echo change >>one.t &&
+	git diff one.t >expect &&
+	git merge --allow-unrelated-histories --autostash five 2>err &&
+	test_i18ngrep "Applied autostash." err &&
+	git diff one.t >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 4fa0ef8e3b..d809310df1 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -30,13 +30,17 @@ Testing basic merge operations/option parsing.
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
 test_write_lines 1 2 3 4 5 6 7 8 9 >file
+cp file file.orig
 test_write_lines '1 X' 2 3 4 5 6 7 8 9 >file.1
+test_write_lines 1 2 '3 X' 4 5 6 7 8 9 >file.3
 test_write_lines 1 2 3 4 '5 X' 6 7 8 9 >file.5
 test_write_lines 1 2 3 4 5 6 7 8 '9 X' >file.9
 test_write_lines 1 2 3 4 5 6 7 8 '9 Y' >file.9y
 test_write_lines '1 X' 2 3 4 5 6 7 8 9 >result.1
 test_write_lines '1 X' 2 3 4 '5 X' 6 7 8 9 >result.1-5
+test_write_lines '1 X' 2 3 4 5 6 7 8 '9 X' >result.1-9
 test_write_lines '1 X' 2 3 4 '5 X' 6 7 8 '9 X' >result.1-5-9
+test_write_lines '1 X' 2 '3 X' 4 '5 X' 6 7 8 '9 X' >result.1-3-5-9
 test_write_lines 1 2 3 4 5 6 7 8 '9 Z' >result.9z
 
 create_merge_msgs () {
@@ -675,6 +679,120 @@ test_expect_success 'refresh the index before merging' '
 	git merge c3
 '
 
+test_expect_success 'merge with --autostash' '
+	git reset --hard c1 &&
+	git merge-file file file.orig file.9 &&
+	git merge --autostash c2 2>err &&
+	test_i18ngrep "Applied autostash." err &&
+	git show HEAD:file >merge-result &&
+	test_cmp result.1-5 merge-result &&
+	test_cmp result.1-5-9 file
+'
+
+test_expect_success 'merge with merge.autoStash' '
+	test_config merge.autoStash true &&
+	git reset --hard c1 &&
+	git merge-file file file.orig file.9 &&
+	git merge c2 2>err &&
+	test_i18ngrep "Applied autostash." err &&
+	git show HEAD:file >merge-result &&
+	test_cmp result.1-5 merge-result &&
+	test_cmp result.1-5-9 file
+'
+
+test_expect_success 'fast-forward merge with --autostash' '
+	git reset --hard c0 &&
+	git merge-file file file.orig file.5 &&
+	git merge --autostash c1 2>err &&
+	test_i18ngrep "Applied autostash." err &&
+	test_cmp result.1-5 file
+'
+
+test_expect_success 'octopus merge with --autostash' '
+	git reset --hard c1 &&
+	git merge-file file file.orig file.3 &&
+	git merge --autostash c2 c3 2>err &&
+	test_i18ngrep "Applied autostash." err &&
+	git show HEAD:file >merge-result &&
+	test_cmp result.1-5-9 merge-result &&
+	test_cmp result.1-3-5-9 file
+'
+
+test_expect_success 'conflicted merge with --autostash, --abort restores stash' '
+	git reset --hard c3 &&
+	cp file.1 file &&
+	test_must_fail git merge --autostash c7 &&
+	git merge --abort 2>err &&
+	test_i18ngrep "Applied autostash." err &&
+	test_cmp file.1 file
+'
+
+test_expect_success 'completed merge (git commit) with --no-commit and --autostash' '
+	git reset --hard c1 &&
+	git merge-file file file.orig file.9 &&
+	git diff >expect &&
+	git merge --no-commit --autostash c2 &&
+	git stash show -p MERGE_AUTOSTASH >actual &&
+	test_cmp expect actual &&
+	git commit 2>err &&
+	test_i18ngrep "Applied autostash." err &&
+	git show HEAD:file >merge-result &&
+	test_cmp result.1-5 merge-result &&
+	test_cmp result.1-5-9 file
+'
+
+test_expect_success 'completed merge (git merge --continue) with --no-commit and --autostash' '
+	git reset --hard c1 &&
+	git merge-file file file.orig file.9 &&
+	git diff >expect &&
+	git merge --no-commit --autostash c2 &&
+	git stash show -p MERGE_AUTOSTASH >actual &&
+	test_cmp expect actual &&
+	git merge --continue 2>err &&
+	test_i18ngrep "Applied autostash." err &&
+	git show HEAD:file >merge-result &&
+	test_cmp result.1-5 merge-result &&
+	test_cmp result.1-5-9 file
+'
+
+test_expect_success 'aborted merge (merge --abort) with --no-commit and --autostash' '
+	git reset --hard c1 &&
+	git merge-file file file.orig file.9 &&
+	git diff >expect &&
+	git merge --no-commit --autostash c2 &&
+	git stash show -p MERGE_AUTOSTASH >actual &&
+	test_cmp expect actual &&
+	git merge --abort 2>err &&
+	test_i18ngrep "Applied autostash." err &&
+	git diff >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'aborted merge (reset --hard) with --no-commit and --autostash' '
+	git reset --hard c1 &&
+	git merge-file file file.orig file.9 &&
+	git diff >expect &&
+	git merge --no-commit --autostash c2 &&
+	git stash show -p MERGE_AUTOSTASH >actual &&
+	test_cmp expect actual &&
+	git reset --hard 2>err &&
+	test_i18ngrep "Autostash exists; creating a new stash entry." err &&
+	git diff --exit-code
+'
+
+test_expect_success 'merge with conflicted --autostash changes' '
+	git reset --hard c1 &&
+	git merge-file file file.orig file.9y &&
+	git diff >expect &&
+	test_when_finished "test_might_fail git stash drop" &&
+	git merge --autostash c3 2>err &&
+	test_i18ngrep "Applying autostash resulted in conflicts." err &&
+	git show HEAD:file >merge-result &&
+	test_cmp result.1-9 merge-result &&
+	git stash show -p >actual &&
+	test_cmp expect actual
+'
+
 cat >expected.branch <<\EOF
 Merge branch 'c5-branch' (early part)
 EOF
-- 
2.26.0.159.g23e2136ad0

