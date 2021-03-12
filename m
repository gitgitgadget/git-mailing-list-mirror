Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60AFC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 850A764FC3
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhCLL1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhCLL0q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 06:26:46 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B5C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:26:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v11so1570554wro.7
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=RMf2JM+G3+tILz6eUZVmt1KWxwLSGMCAK977zGUIayk=;
        b=NgEt0NHOBD3llC4wwlOxEAvmHxVYw9jrAA2+iMoUSPq9wlkSW7DvSf4YyK9KDbD/fw
         Oy3h9g0Ub6SF3pN3bF2VsCdr92cneNampHYzjzx3yosLTCnzr0kT5rk7qLwt5RtHZTvY
         6Nbf+YxYkv2g1qWqT0JvGB/bErF1W1k9ZUhz3Gxddj/2khIQkmVl98AF32fZUrRrqnC0
         nRuHez5sQI4t8B3VkiRyFNZo+RzJFwHKV00kGVpjVHr+1q/336xNkYP9Jsj0ohnBo+6v
         zyhbLf4lhmAJsbbSmOYg7ImtzJIfjtFym/Z/V94FfDvg3Z7kWup8cO/RdPbGQF3t9MJ9
         ufWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=RMf2JM+G3+tILz6eUZVmt1KWxwLSGMCAK977zGUIayk=;
        b=ML6GczViwZtwudSQ15inm6m3z1qC/BVP5W9ryqFbbfrjbOa/oxCl/mqdcWHYTLRGlb
         UiY2kxxeh6n2JL8kB8T3LmELS4u83Czcte/Nv2pOqiNeXbvjaBL2s8bZxiOebllNeCHi
         w25vf9ovDQNNaly/z6Sf80JobdbVAznSsvIt6YcBUDWkIlJBgImic6li5bY9p1yvHGrC
         Qpu3Qmdm0mU5ec/t15csv8PdXIIkxwfEaJbRLCMVhGtk9anH8P/zuXYg1zDaUQOWuU9g
         ZQDKJsr9LrOWMtvEHOKnk8N8LcK2t2K2PQs2xtqTSYnToP+RNSMGBKyrlKlrdniKAp0G
         1L/Q==
X-Gm-Message-State: AOAM531ftofO6+o6bOXWl3SljyR2zH/RD0mnAbvSH5PtSjihacuaWhM0
        BJZqit1O6bpzH2fLHhziqD/4BgvTlMw=
X-Google-Smtp-Source: ABdhPJxHIoh90k6v8BVHFcdQ2Nd6ADAwy5FvGnkgeWoB9V0PAy42AIjAMbIaIIIjXK5aXTD/ewMwtg==
X-Received: by 2002:adf:9b82:: with SMTP id d2mr13466345wrc.193.1615548404815;
        Fri, 12 Mar 2021 03:26:44 -0800 (PST)
Received: from localhost.localdomain (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.gmail.com with ESMTPSA id n23sm7788264wra.71.2021.03.12.03.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:26:44 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [WIP][PATCH] rebase: update the list of rewritten commits when amending pick
Date:   Fri, 12 Mar 2021 11:26:36 +0000
Message-Id: <20210312112636.22711-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <xmqq8s6tcuxc.fsf@gitster.g>
References: <xmqq8s6tcuxc.fsf@gitster.g>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If HEAD is amended during an exec command then the amended commit is missing
from the list of rewritten commits. The commonest way for this to happen is if a
commit is amended to fix a test failure when running `git rebase --exec "make
test"` but it can also happen if the exec command calls `git commit --amend`
directly. Amending commits with exec commands was discussed on the mailing list
recently where someone wanted to reset the author before submitting patches
upstream[1].

[1] https://public-inbox.org/git/CABPp-BEYRmhrb4Tx3bGzkx8y53T_0BYhLE5J0cEmxj18WtZs9A@mail.gmail.com/#t

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

This is what I've been using for a couple of years to update the list
of rewritten commits when running "git commit --amend" during a
rebase. I think it changes which commit gets used as the rewritten one
if you split a commit with 'edit', the patch is so old I cannot
remember if there were any other corner cases.


 builtin/commit.c             |   2 +-
 sequencer.c                  | 119 +++++++++++++++++++++++++++++------
 sequencer.h                  |   6 +-
 t/lib-rebase.sh              |   2 +-
 t/t5407-post-rewrite-hook.sh |  70 ++++++++++++++++++++-
 5 files changed, 176 insertions(+), 23 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index ae7aaf6dc6..9b6f3d8b6b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1697,7 +1697,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
-		commit_post_rewrite(the_repository, current_head, &oid);
+		commit_post_rewrite(the_repository, current_head, &oid, NULL);
 	}
 	if (!quiet) {
 		unsigned int flags = 0;
diff --git a/sequencer.c b/sequencer.c
index b395dd6e11..5d68e7341d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -129,6 +129,7 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
 static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
 static GIT_PATH_FUNC(rebase_path_rewritten_pending,
 	"rebase-merge/rewritten-pending")
+static GIT_PATH_FUNC(rebase_path_rewritten_head, "rebase-merge/rewritten-head")
 
 /*
  * The path of the file containig the OID of the "squash onto" commit, i.e.
@@ -159,6 +160,9 @@ static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
 static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
 
+static void write_rewritten_head(struct object_id *rewritten_head);
+static void read_rewritten_head(struct object_id *rewritten_head);
+
 static int git_sequencer_config(const char *k, const char *v, void *cb)
 {
 	struct replay_opts *opts = cb;
@@ -953,12 +957,12 @@ static int run_git_commit(struct repository *r,
 			  unsigned int flags)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
+	int res = 0;
 
 	if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
 		struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
 		const char *author = NULL;
 		struct object_id root_commit, *cache_tree_oid;
-		int res = 0;
 
 		if (is_rebase_i(opts)) {
 			author = read_author_ident(&script);
@@ -1004,6 +1008,9 @@ static int run_git_commit(struct repository *r,
 			     gpg_opt, gpg_opt);
 	}
 
+	if (is_rebase_i(opts) && (flags & AMEND_MSG))
+		write_rewritten_head(&opts->rewritten_head);
+
 	argv_array_push(&cmd.args, "commit");
 
 	if (!(flags & VERIFY_MSG))
@@ -1032,9 +1039,14 @@ static int run_git_commit(struct repository *r,
 		argv_array_push(&cmd.args, "--allow-empty-message");
 
 	if (is_rebase_i(opts) && !(flags & EDIT_MSG))
-		return run_command_silent_on_success(&cmd);
+		res = run_command_silent_on_success(&cmd);
 	else
-		return run_command(&cmd);
+		res = run_command(&cmd);
+
+	if (is_rebase_i(opts) && !res && (flags & AMEND_MSG))
+		read_rewritten_head(&opts->rewritten_head);
+
+	return res;
 }
 
 static int rest_is_empty(const struct strbuf *sb, int start)
@@ -1177,12 +1189,42 @@ static int run_rewrite_hook(const struct object_id *oldoid,
 	return finish_command(&proc);
 }
 
+static void update_rewritten(const struct repository *r,
+			     const struct object_id *old_head,
+			     const struct object_id *new_head,
+			     struct object_id *rewritten_head)
+{
+	struct object_id oid;
+
+	if (!rewritten_head) {
+		read_rewritten_head(&oid);
+		rewritten_head = &oid;
+	}
+	if (oideq(old_head, rewritten_head)) {
+		FILE *fp;
+		fp = fopen_or_warn(rebase_path_rewritten_list(), "a");
+		if (fp) {
+			fprintf(fp, "%s %s\n",
+			    oid_to_hex(old_head), oid_to_hex(new_head));
+			fclose(fp);
+		}
+		oidcpy(rewritten_head, new_head);
+	}
+	if (rewritten_head == &oid)
+		write_rewritten_head(rewritten_head);
+
+	return;
+}
+
 void commit_post_rewrite(struct repository *r,
 			 const struct commit *old_head,
-			 const struct object_id *new_head)
+			 const struct object_id *new_head,
+			 struct object_id *rewritten_head)
 {
 	struct notes_rewrite_cfg *cfg;
 
+	update_rewritten(r, &old_head->object.oid, new_head, rewritten_head);
+
 	cfg = init_copy_notes_for_rewrite("amend");
 	if (cfg) {
 		/* we are amending, so old_head is not NULL */
@@ -1473,7 +1515,8 @@ static int try_to_commit(struct repository *r,
 	}
 
 	if (flags & AMEND_MSG)
-		commit_post_rewrite(r, current_head, oid);
+		commit_post_rewrite(r, current_head, oid,
+				    &opts->rewritten_head);
 
 out:
 	free_commit_extra_headers(extra);
@@ -1731,7 +1774,7 @@ static int update_squash_messages(struct repository *r,
 	return res;
 }
 
-static void flush_rewritten_pending(void)
+static void flush_rewritten_pending(struct object_id *rewritten_head)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id newoid;
@@ -1752,12 +1795,14 @@ static void flush_rewritten_pending(void)
 		}
 		fclose(out);
 		unlink(rebase_path_rewritten_pending());
+		oidcpy(rewritten_head, &newoid);
 	}
 	strbuf_release(&buf);
 }
 
 static void record_in_rewritten(struct object_id *oid,
-		enum todo_command next_command)
+				enum todo_command next_command,
+				struct object_id *rewritten_head)
 {
 	FILE *out = fopen_or_warn(rebase_path_rewritten_pending(), "a");
 
@@ -1768,7 +1813,7 @@ static void record_in_rewritten(struct object_id *oid,
 	fclose(out);
 
 	if (!is_fixup(next_command))
-		flush_rewritten_pending();
+		flush_rewritten_pending(rewritten_head);
 }
 
 static int do_pick_commit(struct repository *r,
@@ -2510,6 +2555,11 @@ static int read_populate_opts(struct replay_opts *opts)
 	if (is_rebase_i(opts)) {
 		struct strbuf buf = STRBUF_INIT;
 
+		if (file_exists(rebase_path_rewritten_head()))
+			read_rewritten_head(&opts->rewritten_head);
+		else
+			opts->rewritten_head = null_oid;
+
 		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
 			if (!starts_with(buf.buf, "-S"))
 				strbuf_reset(&buf);
@@ -3065,6 +3115,7 @@ static int error_with_patch(struct repository *r,
 			    struct replay_opts *opts,
 			    int exit_code, int to_amend)
 {
+	write_rewritten_head(&opts->rewritten_head);
 	if (commit) {
 		if (make_patch(r, commit, opts))
 			return -1;
@@ -3119,12 +3170,14 @@ static int error_failed_squash(struct repository *r,
 	return error_with_patch(r, commit, subject, subject_len, opts, 1, 0);
 }
 
-static int do_exec(struct repository *r, const char *command_line)
+static int do_exec(struct repository *r, const char *command_line,
+		   struct object_id *rewritten_head)
 {
 	struct argv_array child_env = ARGV_ARRAY_INIT;
 	const char *child_argv[] = { NULL, NULL };
 	int dirty, status;
 
+	write_rewritten_head(rewritten_head);
 	fprintf(stderr, "Executing: %s\n", command_line);
 	child_argv[0] = command_line;
 	argv_array_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
@@ -3133,6 +3186,7 @@ static int do_exec(struct repository *r, const char *command_line)
 	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
 					  child_env.argv);
 
+	read_rewritten_head(rewritten_head);
 	/* force re-reading of the cache */
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
 		return error(_("could not read index"));
@@ -3331,10 +3385,12 @@ static int do_reset(struct repository *r,
 		ret = error(_("could not write index"));
 	free((void *)desc.buffer);
 
-	if (!ret)
+	if (!ret) {
 		ret = update_ref(reflog_message(opts, "reset", "'%.*s'",
 						len, name), "HEAD", &oid,
 				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+		oidcpy(&opts->rewritten_head, &oid);
+	}
 
 	strbuf_release(&ref_name);
 	return ret;
@@ -3862,6 +3918,7 @@ static int pick_commits(struct repository *r,
 			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
 			if (item->command == TODO_BREAK) {
+				write_rewritten_head(&opts->rewritten_head);
 				if (!opts->verbose)
 					term_clear_line();
 				return stopped_at_head(r);
@@ -3900,7 +3957,8 @@ static int pick_commits(struct repository *r,
 			}
 			if (is_rebase_i(opts) && !res)
 				record_in_rewritten(&item->commit->object.oid,
-					peek_command(todo_list, 1));
+						    peek_command(todo_list, 1),
+						    &opts->rewritten_head);
 			if (res && is_fixup(item->command)) {
 				if (res == 1)
 					intend_to_amend();
@@ -3935,7 +3993,7 @@ static int pick_commits(struct repository *r,
 			if (!opts->verbose)
 				term_clear_line();
 			*end_of_arg = '\0';
-			res = do_exec(r, arg);
+			res = do_exec(r, arg, &opts->rewritten_head);
 			*end_of_arg = saved;
 
 			if (res) {
@@ -3965,7 +4023,8 @@ static int pick_commits(struct repository *r,
 				reschedule = 1;
 			else if (item->commit)
 				record_in_rewritten(&item->commit->object.oid,
-						    peek_command(todo_list, 1));
+						    peek_command(todo_list, 1),
+						    &opts->rewritten_head);
 			if (res > 0)
 				/* failed with merge conflicts */
 				return error_with_patch(r, item->commit,
@@ -4062,7 +4121,7 @@ static int pick_commits(struct repository *r,
 				log_tree_diff_flush(&log_tree_opt);
 			}
 		}
-		flush_rewritten_pending();
+		flush_rewritten_pending(&opts->rewritten_head);
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process child = CHILD_PROCESS_INIT;
@@ -4299,7 +4358,8 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 
 		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1) &&
 		    !get_oid_committish(buf.buf, &oid))
-			record_in_rewritten(&oid, peek_command(&todo_list, 0));
+			record_in_rewritten(&oid, peek_command(&todo_list, 0),
+					    &opts->rewritten_head);
 		strbuf_release(&buf);
 	}
 
@@ -5024,7 +5084,8 @@ int check_todo_list_from_file(struct repository *r)
 /* skip picking commits whose parents are unchanged */
 static int skip_unnecessary_picks(struct repository *r,
 				  struct todo_list *todo_list,
-				  struct object_id *base_oid)
+				  struct object_id *base_oid,
+				  struct object_id *rewritten_head)
 {
 	struct object_id *parent_oid;
 	int i;
@@ -5062,8 +5123,15 @@ static int skip_unnecessary_picks(struct repository *r,
 		todo_list->current = 0;
 		todo_list->done_nr += i;
 
-		if (is_fixup(peek_command(todo_list, 0)))
-			record_in_rewritten(base_oid, peek_command(todo_list, 0));
+		if (is_fixup(peek_command(todo_list, 0))) {
+			record_in_rewritten(base_oid, peek_command(todo_list, 0),
+					    rewritten_head);
+			oidcpy(rewritten_head, &null_oid);
+		} else {
+			oidcpy(rewritten_head, base_oid);
+		}
+	} else {
+		oidcpy(rewritten_head, base_oid);
 	}
 
 	return 0;
@@ -5129,7 +5197,8 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return -1;
 	}
 
-	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {
+	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid,
+						     &opts->rewritten_head)) {
 		todo_list_release(&new_todo);
 		return error(_("could not skip unnecessary pick commands"));
 	}
@@ -5315,3 +5384,15 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 
 	return 0;
 }
+static void write_rewritten_head(struct object_id *rewritten_head)
+{
+	const char *hex = oid_to_hex(rewritten_head);
+	write_message(hex, strlen(hex), rebase_path_rewritten_head(), 1);
+}
+
+static void read_rewritten_head(struct object_id *rewritten_head)
+{
+	struct strbuf buf = STRBUF_INIT;
+	read_oneliner(&buf, rebase_path_rewritten_head(), 0);
+	get_oid(buf.buf, rewritten_head);
+}
diff --git a/sequencer.h b/sequencer.h
index 574260f621..91834cfe1c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -63,6 +63,9 @@ struct replay_opts {
 	struct object_id squash_onto;
 	int have_squash_onto;
 
+	/* Used to update rewritten-list */
+	struct object_id rewritten_head;
+
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
 };
@@ -188,7 +191,8 @@ int update_head_with_reflog(const struct commit *old_head,
 			    struct strbuf *err);
 void commit_post_rewrite(struct repository *r,
 			 const struct commit *current_head,
-			 const struct object_id *new_head);
+			 const struct object_id *new_head,
+			 struct object_id *rewritten_head);
 
 int prepare_branch_to_be_rebased(struct repository *r, struct replay_opts *opts,
 				 const char *commit);
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6d87961e41..9c0016848d 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -49,7 +49,7 @@ set_fake_editor () {
 		case $line in
 		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|r|merge|m)
 			action="$line";;
-		exec_*|x_*|break|b)
+		exec_*|x_*|break|b|reset_*|t_*)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
 		"#")
 			echo '# comment' >> "$1";;
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 7344253bfb..18773709a3 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -14,7 +14,11 @@ test_expect_success 'setup' '
 	git checkout A^0 &&
 	test_commit E bar E &&
 	test_commit F foo F &&
-	git checkout master
+	git checkout master &&
+
+	write_script amend-head <<-\EOS
+	git commit --amend --only --allow-empty -m "$1"
+	EOS
 '
 
 mkdir .git/hooks
@@ -263,4 +267,68 @@ test_expect_success 'git rebase -i (exec)' '
 	verify_hook_input
 '
 
+test_expect_success 'git rebase -i (exec amends commit)' '
+	git reset --hard D &&
+	clear_hook_input &&
+	test_must_fail env FAKE_LINES="1 \
+		exec_./amend-head_edited-1a \
+		exec_./amend-head_edited-1b \
+		2 \
+		exec_false \
+		3 \
+		break" git rebase -i A &&
+	./amend-head edited-2 &&
+	git rebase --continue &&
+	./amend-head edited-3 &&
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	printf "%s %s\n%s %s\n%s %s\n%s %s\n%s %s\n%s %s\n" >expected.data \
+		$(git rev-parse B        HEAD@{6} \
+				HEAD@{6} HEAD^^   \
+				C        HEAD@{4} \
+				HEAD@{4} HEAD^    \
+				D        HEAD@{2} \
+				HEAD@{2} HEAD) &&
+
+	verify_hook_input
+'
+
+test_expect_success 'git rebase -i (exec amends onto)' '
+	git reset --hard D &&
+	clear_hook_input &&
+	FAKE_LINES="exec_./amend-head_edited 1 \
+		exec_git_commit_--allow-empty_-m_empty \
+		exec_./amend-head_edited-empty" git rebase -i B &&
+	echo rebase >expected.args &&
+	printf "%s %s\n%s %s\n" >expected.data \
+		$(git rev-parse B HEAD^^ \
+				C HEAD^) &&
+	verify_hook_input
+'
+
+test_expect_success 'git rebase -i (fixup after exec)' '
+	git reset --hard D &&
+	clear_hook_input &&
+	FAKE_LINES="1 exec_true fixup 2 squash 3" git rebase -i A &&
+	echo rebase >expected.args &&
+	printf "%s %s\n%s %s\n%s %s\n%s %s\n" >expected.data \
+		$(git rev-parse B        HEAD@{2} \
+				HEAD@{2} HEAD     \
+				C        HEAD     \
+				D        HEAD) &&
+	verify_hook_input
+'
+
+test_expect_success 'git rebase -i (exec after reset)' '
+	git reset --hard D &&
+	clear_hook_input &&
+	FAKE_LINES="reset_C \
+		exec_./amend-head_edited 3" git rebase -i A &&
+	echo rebase >expected.args &&
+	printf "%s %s\n%s %s\n" >expected.data \
+		$(git rev-parse C HEAD^ \
+				D HEAD) &&
+	verify_hook_input
+'
+
 test_done
-- 
2.30.1

