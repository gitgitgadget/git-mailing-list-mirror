Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E84C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B343F2070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBDKWhcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgCUJWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:46 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:41725 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgCUJWm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:42 -0400
Received: by mail-qt1-f171.google.com with SMTP id i3so3452550qtv.8
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNdOaSMMTCA3LGdEz/bY1DoeHx277DFxc9SvKmOHQ20=;
        b=YBDKWhcY8MnF54YqvEy3+yXHnx6r6wggua8oEjvpJeWMJXxUE5pTIxv9l9MapV671j
         imW/kl83SuAzjZeSILlqxljpDQqODk4H3amZmVF8WaswDYnUVfOFLcpl40TQ0779B/WH
         ntUZICxpRHrO4XmW+DvPGGjmH30W6Kg46MDKaRmUA7OqCaqvXfP6gJxjIIfszvlDXMZt
         GDwseCF+IYcaFsK3pxKhR6SNp3TVMV2DED6UOF+3kJPbiK6CZ0dilIQCkdXkvAbCEWL7
         y9OPiz4s9jZM4YwqqR61Q+ydyPDuzxmRd1nBT17bWn0Hcd5lcm1yL3NZ8ECNm8aDy65P
         lA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNdOaSMMTCA3LGdEz/bY1DoeHx277DFxc9SvKmOHQ20=;
        b=gqHhcz7y2ViN/hE6SkA0DmlxLnox6uRRO2i3jIoyvGRaFfLv7G3v844r4DkoyGvFFn
         WmjBwoNHEHGYSril+G+cHtt4Y25xp+qUwv8STYg/kayEBG1zobY3VuvzfHoVS5HtvceI
         eZn8esz2wct50wUy8aRh5wYqSBAsBrhTqPadH7VQ+fkWl4FQgsHEWgLr2uNia2JFMd3b
         I+by+fWiGuTmQ3QUpdPzjBbgZv1V8XrDlT07Zydp9rm2XEtuLAYGd16Ki2LMtswr9Dql
         iwXsmHWAu/FcpxmEgFBwvHYsuAVdE6uyGnCOJ056QliPakhup5qLWbnQcJUk43RDn61x
         JvUQ==
X-Gm-Message-State: ANhLgQ2vFLQAQ2mx9y2JSk+HuQjxNN244SFdPlPvdi6+/zz7h1Wp06An
        pnc2HGKoT7RqMCl3Tne0JJXP30Rt
X-Google-Smtp-Source: ADFU+vv83gJOuF++ez+9V+7oJmv2g4z2gzrD2f0pBhPu47Iq2ASXBY46zpNuVTpUijANMKAjtuk9yw==
X-Received: by 2002:ac8:175d:: with SMTP id u29mr12602704qtk.150.1584782559772;
        Sat, 21 Mar 2020 02:22:39 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:39 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 17/19] merge: teach --autostash option
Date:   Sat, 21 Mar 2020 05:21:36 -0400
Message-Id: <9e3d4393cae8813cc4718c6ffcc28231b1344fbe.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
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

When `git reset --hard` is run to abort a merge, the working tree will
be left in a clean state, as expected, with the autostash pushed onto
the stash stack.

Suggested-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/merge.txt  |  10 +++
 Documentation/merge-options.txt |   8 +++
 branch.c                        |   1 +
 builtin/commit.c                |   2 +
 builtin/merge.c                 |  17 ++++++
 builtin/reset.c                 |   7 ++-
 path.c                          |   1 +
 path.h                          |   4 +-
 t/t3033-merge-toplevel.sh       |  22 +++++++
 t/t7600-merge.sh                | 104 ++++++++++++++++++++++++++++++++
 10 files changed, 174 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index 6a313937f8..88b29127bf 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -70,6 +70,16 @@ merge.stat::
 	Whether to print the diffstat between ORIG_HEAD and the merge result
 	at the end of the merge.  True by default.
 
+merge.autoStash::
+	When set to true, automatically create a temporary stash entry
+	before the operation begins, and apply it after the operation
+	ends.  This means that you can run rebase on a dirty worktree.
+	However, use with care: the final stash application after a
+	successful rebase might result in non-trivial conflicts.
+	This option can be overridden by the `--no-autostash` and
+	`--autostash` options of linkgit:git-merge[1].
+	Defaults to false.
+
 merge.tool::
 	Controls which merge tool is used by linkgit:git-mergetool[1].
 	The list below shows the valid built-in values.
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 40dc4f5e8c..34493eb58b 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -155,6 +155,14 @@ ifndef::git-pull[]
 	Note that not all merge strategies may support progress
 	reporting.
 
+--autostash::
+--no-autostash::
+	Automatically create a temporary stash entry before the operation
+	begins, and apply it after the operation ends.  This means
+	that you can run rebase on a dirty worktree.  However, use
+	with care: the final stash application after a successful
+	rebase might result in non-trivial conflicts.
+
 endif::git-pull[]
 
 --allow-unrelated-histories::
diff --git a/branch.c b/branch.c
index 579494738a..bf2536c70d 100644
--- a/branch.c
+++ b/branch.c
@@ -344,6 +344,7 @@ void remove_merge_branch_state(struct repository *r)
 	unlink(git_path_merge_rr(r));
 	unlink(git_path_merge_msg(r));
 	unlink(git_path_merge_mode(r));
+	apply_autostash(git_path_merge_autostash(r));
 }
 
 void remove_branch_state(struct repository *r, int verbose)
diff --git a/builtin/commit.c b/builtin/commit.c
index 7ba33a3bec..c11894423a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1687,6 +1687,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	unlink(git_path_merge_mode(the_repository));
 	unlink(git_path_squash_msg(the_repository));
 
+	apply_autostash(git_path_merge_autostash(the_repository));
+
 	if (commit_index_files())
 		die(_("repository has been updated, but unable to write\n"
 		      "new_index file. Check that disk is not full and quota is\n"
diff --git a/builtin/merge.c b/builtin/merge.c
index d127d2225f..e038bef5ad 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -82,6 +82,7 @@ static int show_progress = -1;
 static int default_to_upstream = 1;
 static int signoff;
 static const char *sign_commit;
+static int autostash;
 static int no_verify;
 
 static struct strategy all_strategy[] = {
@@ -286,6 +287,8 @@ static struct option builtin_merge_options[] = {
 	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+	OPT_BOOL(0, "autostash", &autostash,
+	      N_("automatically stash/stash pop before and after")),
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
 	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
@@ -441,6 +444,7 @@ static void finish(struct commit *head_commit,
 		strbuf_addf(&reflog_message, "%s: %s",
 			getenv("GIT_REFLOG_ACTION"), msg);
 	}
+	apply_autostash(git_path_merge_autostash(the_repository));
 	if (squash) {
 		squash_message(head_commit, remoteheads);
 	} else {
@@ -634,6 +638,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return 0;
 	} else if (!strcmp(k, "gpg.mintrustlevel")) {
 		check_trust_level = 0;
+	} else if (!strcmp(k, "merge.autostash")) {
+		autostash = git_config_bool(k, v);
+		return 0;
 	}
 
 	status = fmt_merge_msg_config(k, v, cb);
@@ -1291,6 +1298,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		/* Invoke 'git reset --merge' */
 		ret = cmd_reset(nargc, nargv, prefix);
+		apply_autostash(git_path_merge_autostash(the_repository));
 		goto done;
 	}
 
@@ -1513,6 +1521,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			goto done;
 		}
 
+		if (autostash)
+			create_autostash(the_repository,
+					 git_path_merge_autostash(the_repository),
+					 "merge");
 		if (checkout_fast_forward(the_repository,
 					  &head_commit->object.oid,
 					  &commit->object.oid,
@@ -1579,6 +1591,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (fast_forward == FF_ONLY)
 		die(_("Not possible to fast-forward, aborting."));
 
+	if (autostash)
+		create_autostash(the_repository,
+				 git_path_merge_autostash(the_repository),
+				 "merge");
+
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_STRICT);
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 18228c312e..038c8532eb 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -25,6 +25,7 @@
 #include "cache-tree.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "sequencer.h"
 
 #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
 
@@ -437,8 +438,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		if (reset_type == HARD && !update_ref_status && !quiet)
 			print_new_head_line(lookup_commit_reference(the_repository, &oid));
 	}
-	if (!pathspec.nr)
+	if (!pathspec.nr) {
+		if (reset_type == HARD)
+			save_autostash(git_path_merge_autostash(the_repository));
+
 		remove_branch_state(the_repository, 0);
+	}
 
 	return update_ref_status;
 }
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
index 4fa0ef8e3b..c08e4315f4 100755
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
@@ -675,6 +679,106 @@ test_expect_success 'refresh the index before merging' '
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
+test_expect_success 'completed merge with --no-commit and --autostash' '
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
2.25.0.114.g5b0ca878e0

