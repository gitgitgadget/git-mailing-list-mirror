Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF75C4321E
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387598AbiBHWZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386336AbiBHUJv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 15:09:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D5EC0613CB
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 12:09:50 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s18so347755wrv.7
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 12:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8J/n4RpowF6IqoUxLaNtgScn+d11Z+3sHMlEvPPvaBE=;
        b=lfRnCAicxwTJbK5KM+5MvAnfma5Z9LVzMV+agoujuSpG7nDX5RjcrFbf1YL4AOszV3
         BNkry7PWXVp5klDYeyshpkGebY+6CAIMOyFD1HUN0C/BJOlhgH9lHQ0doPTb5joGbxbA
         Y/osJDb3XiktG6Wfc0MREj1SZKJkPvc3E5QrdPoDW1T77v1g9k3axZRBbRTNUV9mg63+
         6JH3i5Z0wvT3j6jWdV2mIrZI+Rw9pMK+AoOYPYXNoFnxuo5u6VHzjYVQRO8zcz2qqPIL
         ypIGQWpqBLhIibBYG5qZy4/YHRLP2u+KEOwLBGYRi9onxOEiSVIe8JK+Pw4LBEixsxGn
         hLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8J/n4RpowF6IqoUxLaNtgScn+d11Z+3sHMlEvPPvaBE=;
        b=mA9jivlziH9aE+pn104zZMCuN+07Yk/bnF14a6zdkZ9Tk9WMzw1EUsTJjiq0YBRq/C
         hfx6d48ez1BKCLpIu26nb1G6wujZXPfnjeH5d4BIGuInCkejqQl05dRf7/JaUY5Iz3Gv
         0+pnJOLV8nAo9236sTHsn11UDefKEG6CRTFajK4t6uuGch98Hjn9LmHHS5WsayPu/3rV
         WNSJN6GnU9SYy9q4K1wlCOarHkxWaHdzGaSaO5+tmYg3NI0oIT67/s283874XAVzQzPM
         U+cJSYtDPkoqYxNMMviwLfuFpiFzI5hkK5T9vI9D2a+xxD+L+Mi2cQfUnKUdLk2Ih34h
         fJ0A==
X-Gm-Message-State: AOAM530aT5gc0XcEACfnvi4iQHsp64n/EQU09WXR4bTqzxcESEuR3I+Z
        0WgbVYj49kScEPkVbzBOfHJTIcl+erg=
X-Google-Smtp-Source: ABdhPJw0djs0Sxn6cHydwPlFfAs7bGWCd7tRsiBrF9m9JGRlrKUu75tGI2impse4ObzMyic+DY50EQ==
X-Received: by 2002:adf:fb4a:: with SMTP id c10mr4678340wrs.243.1644350988619;
        Tue, 08 Feb 2022 12:09:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i20sm3917283wra.62.2022.02.08.12.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:09:47 -0800 (PST)
Message-Id: <395baf11c9f7f9a54de24ab99c2242933b3c25a7.1644350985.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1214.git.git.1644350985.gitgitgadget@gmail.com>
References: <pull.1214.git.git.1644350985.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 20:09:45 +0000
Subject: [PATCH 2/2] Treat MERGE_AUTOSTASH and friends as a pseudoref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

In t7600-merge.sh, we can see

        git stash show -p MERGE_AUTOSTASH

which yields

        error: MERGE_AUTOSTASH is not a valid reference

in reftable. stash.c further confirms the stash should be treated as a
revision, by calling setup_revisions() on the first argument to
show_stash()

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 branch.c         |  2 +-
 builtin/commit.c |  2 +-
 builtin/merge.c  | 29 ++++++++++++++---------------
 builtin/rebase.c | 34 ++++++++++++++++++++++++++++------
 path.c           |  1 -
 path.h           |  3 +--
 sequencer.c      | 46 +++++++++++++++++++++-------------------------
 7 files changed, 66 insertions(+), 51 deletions(-)

diff --git a/branch.c b/branch.c
index 6b31df539a5..f506f56de09 100644
--- a/branch.c
+++ b/branch.c
@@ -637,7 +637,7 @@ void remove_merge_branch_state(struct repository *r)
 	unlink(git_path_merge_msg(r));
 	unlink(git_path_merge_mode(r));
 	unlink(git_path_auto_merge(r));
-	save_autostash(git_path_merge_autostash(r));
+	save_autostash(MERGE_AUTOSTASH);
 }
 
 void remove_branch_state(struct repository *r, int verbose)
diff --git a/builtin/commit.c b/builtin/commit.c
index 33ca9e99c80..ef05ecf39df 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1855,7 +1855,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 				     &oid, flags);
 	}
 
-	apply_autostash(git_path_merge_autostash(the_repository));
+	apply_autostash(MERGE_AUTOSTASH);
 
 	UNLEAK(err);
 	UNLEAK(sb);
diff --git a/builtin/merge.c b/builtin/merge.c
index a94a03384ae..81f4fa83c24 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -492,7 +492,7 @@ static void finish(struct commit *head_commit,
 	/* Run a post-merge hook */
 	run_hooks_l("post-merge", squash ? "1" : "0", NULL);
 
-	apply_autostash(git_path_merge_autostash(the_repository));
+	apply_autostash(MERGE_AUTOSTASH);
 	strbuf_release(&reflog_message);
 }
 
@@ -1318,8 +1318,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (abort_current_merge) {
 		int nargc = 2;
 		const char *nargv[] = {"reset", "--merge", NULL};
-		struct strbuf stash_oid = STRBUF_INIT;
-
+		struct object_id stash_oid;
+		char hex[GIT_MAX_HEXSZ + 1] = { 0 };
 		if (orig_argc != 2)
 			usage_msg_opt(_("--abort expects no arguments"),
 			      builtin_merge_usage, builtin_merge_options);
@@ -1327,17 +1327,17 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (!file_exists(git_path_merge_head(the_repository)))
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
 
-		if (read_oneliner(&stash_oid, git_path_merge_autostash(the_repository),
-		    READ_ONELINER_SKIP_IF_EMPTY))
-			unlink(git_path_merge_autostash(the_repository));
+		if (!read_ref(MERGE_AUTOSTASH, &stash_oid)) {
+			oid_to_hex_r(hex, &stash_oid);
+			delete_ref("merge --abort", MERGE_AUTOSTASH, NULL, 0);
+		}
 
 		/* Invoke 'git reset --merge' */
 		ret = cmd_reset(nargc, nargv, prefix);
 
-		if (stash_oid.len)
-			apply_autostash_oid(stash_oid.buf);
+		if (hex[0])
+			apply_autostash_oid(hex);
 
-		strbuf_release(&stash_oid);
 		goto done;
 	}
 
@@ -1567,13 +1567,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 
 		if (autostash)
-			create_autostash(the_repository,
-					 git_path_merge_autostash(the_repository));
+			create_autostash(the_repository, MERGE_AUTOSTASH);
 		if (checkout_fast_forward(the_repository,
 					  &head_commit->object.oid,
 					  &commit->object.oid,
 					  overwrite_ignore)) {
-			apply_autostash(git_path_merge_autostash(the_repository));
+			apply_autostash(MERGE_AUTOSTASH);
+
 			ret = 1;
 			goto done;
 		}
@@ -1638,8 +1638,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		die_ff_impossible();
 
 	if (autostash)
-		create_autostash(the_repository,
-				 git_path_merge_autostash(the_repository));
+		create_autostash(the_repository, MERGE_AUTOSTASH);
 
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_STRICT);
@@ -1722,7 +1721,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		else
 			fprintf(stderr, _("Merge with strategy %s failed.\n"),
 				use_strategies[0]->name);
-		apply_autostash(git_path_merge_autostash(the_repository));
+		apply_autostash(MERGE_AUTOSTASH);
 		ret = 2;
 		goto done;
 	} else if (best_strategy == wt_strategy)
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b29ad2b65e7..e84c21ab8fc 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -414,6 +414,17 @@ static const char *state_dir_path(const char *filename, struct rebase_options *o
 	return path.buf;
 }
 
+static const char *state_pseudoref(const char *suffix,
+				   struct rebase_options *opts)
+{
+	static struct strbuf pseudo_ref = STRBUF_INIT;
+	strbuf_reset(&pseudo_ref);
+	strbuf_addstr(&pseudo_ref, strrchr(opts->state_dir, '/') + 1);
+	strbuf_addstr(&pseudo_ref, "/");
+	strbuf_addstr(&pseudo_ref, suffix);
+	return pseudo_ref.buf;
+}
+
 /* Initialize the rebase options from the state directory. */
 static int read_basic_state(struct rebase_options *opts)
 {
@@ -544,10 +555,11 @@ static int finish_rebase(struct rebase_options *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
 	int ret = 0;
+	const char *autostash_ref = state_pseudoref("autostash", opts);
 
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 	unlink(git_path_auto_merge(the_repository));
-	apply_autostash(state_dir_path("autostash", opts));
+	apply_autostash(autostash_ref);
 	/*
 	 * We ignore errors in 'git maintenance run --auto', since the
 	 * user should see them.
@@ -559,6 +571,9 @@ static int finish_rebase(struct rebase_options *opts)
 		replay.action = REPLAY_INTERACTIVE_REBASE;
 		ret = sequencer_remove_state(&replay);
 	} else {
+		if (delete_ref("cleanup autostash", autostash_ref, NULL,
+			       REF_SKIP_REFNAME_VERIFICATION))
+			die("failed cleaning up autostash ref");
 		strbuf_addstr(&dir, opts->state_dir);
 		if (remove_dir_recursively(&dir, 0))
 			ret = error(_("could not remove '%s'"),
@@ -760,8 +775,11 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 			finish_rebase(opts);
 	} else if (status == 2) {
 		struct strbuf dir = STRBUF_INIT;
-
-		apply_autostash(state_dir_path("autostash", opts));
+		const char *autostash_ref = state_pseudoref("autostash", opts);
+		apply_autostash(autostash_ref);
+		if (delete_ref("cleanup autostash", autostash_ref, NULL,
+			       REF_SKIP_REFNAME_VERIFICATION))
+			die("failed cleaning up autostash ref");
 		strbuf_addstr(&dir, opts->state_dir);
 		remove_dir_recursively(&dir, 0);
 		strbuf_release(&dir);
@@ -1310,13 +1328,18 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	case ACTION_QUIT: {
-		save_autostash(state_dir_path("autostash", &options));
+		const char *autostash_ref =
+			state_pseudoref("autostash", &options);
+		save_autostash(autostash_ref);
 		if (options.type == REBASE_MERGE) {
 			struct replay_opts replay = REPLAY_OPTS_INIT;
 
 			replay.action = REPLAY_INTERACTIVE_REBASE;
 			ret = sequencer_remove_state(&replay);
 		} else {
+			if (delete_ref("deleted autostash_ref", autostash_ref,
+				       NULL, REF_SKIP_REFNAME_VERIFICATION))
+				die("failed to cleanup autostash ref");
 			strbuf_reset(&buf);
 			strbuf_addstr(&buf, options.state_dir);
 			ret = remove_dir_recursively(&buf, 0);
@@ -1670,8 +1693,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.autostash)
 		create_autostash(the_repository,
-				 state_dir_path("autostash", &options));
-
+				 state_pseudoref("autostash", &options));
 
 	if (require_clean_work_tree(the_repository, "rebase",
 				    _("Please commit or stash them."), 1, 1)) {
diff --git a/path.c b/path.c
index 2c895471d90..f69a912a279 100644
--- a/path.c
+++ b/path.c
@@ -1552,7 +1552,6 @@ REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
 REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
 REPO_GIT_PATH_FUNC(merge_mode, "MERGE_MODE")
 REPO_GIT_PATH_FUNC(merge_head, "MERGE_HEAD")
-REPO_GIT_PATH_FUNC(merge_autostash, "MERGE_AUTOSTASH")
 REPO_GIT_PATH_FUNC(auto_merge, "AUTO_MERGE")
 REPO_GIT_PATH_FUNC(fetch_head, "FETCH_HEAD")
 REPO_GIT_PATH_FUNC(shallow, "shallow")
diff --git a/path.h b/path.h
index b68691a86b8..e1cf1db98ba 100644
--- a/path.h
+++ b/path.h
@@ -175,7 +175,6 @@ struct path_cache {
 	const char *merge_rr;
 	const char *merge_mode;
 	const char *merge_head;
-	const char *merge_autostash;
 	const char *auto_merge;
 	const char *fetch_head;
 	const char *shallow;
@@ -188,11 +187,11 @@ const char *git_path_merge_msg(struct repository *r);
 const char *git_path_merge_rr(struct repository *r);
 const char *git_path_merge_mode(struct repository *r);
 const char *git_path_merge_head(struct repository *r);
-const char *git_path_merge_autostash(struct repository *r);
 const char *git_path_auto_merge(struct repository *r);
 const char *git_path_fetch_head(struct repository *r);
 const char *git_path_shallow(struct repository *r);
 
+#define MERGE_AUTOSTASH "MERGE_AUTOSTASH"
 
 int ends_with_path_components(const char *path, const char *components);
 
diff --git a/sequencer.c b/sequencer.c
index 35006c0cea6..d61ad1e215d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -160,7 +160,6 @@ static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
 static GIT_PATH_FUNC(rebase_path_signoff, "rebase-merge/signoff")
 static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
 static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
-static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
 static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
 static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
@@ -4085,7 +4084,7 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
-void create_autostash(struct repository *r, const char *path)
+void create_autostash(struct repository *r, const char *pseudoref)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4117,10 +4116,10 @@ void create_autostash(struct repository *r, const char *path)
 		strbuf_reset(&buf);
 		strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
 
-		if (safe_create_leading_directories_const(path))
-			die(_("Could not create directory for '%s'"),
-			    path);
-		write_file(path, "%s", oid_to_hex(&oid));
+		refs_update_ref(get_main_ref_store(r), "create_autostash",
+				pseudoref, &oid, null_oid(), 0,
+				UPDATE_REFS_DIE_ON_ERR);
+
 		printf(_("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
@@ -4174,33 +4173,30 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 	return ret;
 }
 
-static int apply_save_autostash(const char *path, int attempt_apply)
+static int apply_save_autostash(const char *pseudoref, int attempt_apply)
 {
-	struct strbuf stash_oid = STRBUF_INIT;
+	struct object_id oid;
+	char hex[GIT_MAX_HEXSZ + 1] = { 0 };
 	int ret = 0;
 
-	if (!read_oneliner(&stash_oid, path,
-			   READ_ONELINER_SKIP_IF_EMPTY)) {
-		strbuf_release(&stash_oid);
+	if (read_ref(pseudoref, &oid))
 		return 0;
-	}
-	strbuf_trim(&stash_oid);
 
-	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
+	ret = apply_save_autostash_oid(oid_to_hex_r(hex, &oid), attempt_apply);
 
-	unlink(path);
-	strbuf_release(&stash_oid);
+	delete_ref("save autostash", pseudoref, NULL,
+		   REF_SKIP_REFNAME_VERIFICATION);
 	return ret;
 }
 
-int save_autostash(const char *path)
+int save_autostash(const char *pseudoref)
 {
-	return apply_save_autostash(path, 0);
+	return apply_save_autostash(pseudoref, 0);
 }
 
-int apply_autostash(const char *path)
+int apply_autostash(const char *pseudoref)
 {
-	return apply_save_autostash(path, 1);
+	return apply_save_autostash(pseudoref, 1);
 }
 
 int apply_autostash_oid(const char *stash_oid)
@@ -4222,7 +4218,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 		.default_reflog_action = "rebase"
 	};
 	if (reset_head(r, &ropts)) {
-		apply_autostash(rebase_path_autostash());
+		apply_autostash("rebase-merge/autostash");
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));
 	}
@@ -4556,7 +4552,7 @@ cleanup_head_ref:
 				run_command(&hook);
 			}
 		}
-		apply_autostash(rebase_path_autostash());
+		apply_autostash("rebase-merge/autostash");
 
 		if (!opts->quiet) {
 			if (!opts->verbose)
@@ -5635,7 +5631,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		todo_list_add_exec_commands(todo_list, commands);
 
 	if (count_commands(todo_list) == 0) {
-		apply_autostash(rebase_path_autostash());
+		apply_autostash("rebase-merge/autostash");
 		sequencer_remove_state(opts);
 
 		return error(_("nothing to do"));
@@ -5646,12 +5642,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (res == -1)
 		return -1;
 	else if (res == -2) {
-		apply_autostash(rebase_path_autostash());
+		apply_autostash("rebase-merge/autostash");
 		sequencer_remove_state(opts);
 
 		return -1;
 	} else if (res == -3) {
-		apply_autostash(rebase_path_autostash());
+		apply_autostash("rebase-merge/autostash");
 		sequencer_remove_state(opts);
 		todo_list_release(&new_todo);
 
-- 
gitgitgadget
