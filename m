Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C69C20248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfBYXRV (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46855 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfBYXRU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so11794708wrs.13
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PKTEUnatwYrfdesxhzV7wxLi4iyWfGRDdZqs9FzrjQw=;
        b=XbM8QWCBCKm/fS+rXNGqDQbqB6N0T5h5xMdq+itdKz6foVZlISZOBKOuXVW+PKYT11
         dvPbR5tuA8nks0cYhZatrBIA//Nlw998NSpr8Ss/rq33oRAebOr+jABNfQFXcHSW6/Jc
         IW43MQ8hjrQepIYHCUxEEjE9cfux6oBfSEWuB+rAkMoWCyqXabdXIdwv3N999rcE6R0W
         0g/53FK5QxjuYqKe1ZrnWw/LX/ZmJssPvBXLmqfB4G2Ds0SQSs/UtY7SEXBYtihfirUz
         6C/PibJWzGaxQ/qv1pZxNtMDSS+Y2k/lxHMlxYYOpmDylzRZbuM5ygrz6PXeM9D6B6mV
         oLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKTEUnatwYrfdesxhzV7wxLi4iyWfGRDdZqs9FzrjQw=;
        b=QzxtnuPqZyIhFqic85jlU2EET6N+v3OdBHXGAicWqNJ8aybJHeIxcuGRd9C5rwyPv9
         ZzfBkkYIpyhOzdBbeWZDgeujlLH1ynMgzL2pY9FTscFgDdnaQAH5BF++lz9pLWT33kOo
         rSL9dFcVvqqkR1k7vXX9Y282qMnntxCSCHf3prgF6/m1fKulx5+dtlqzKHyy+tHS3XJY
         Rp+0+6opU6fgorEZlQRtndbX8l7kgNhMmHNwVMjzMlGV1IaLYE0lGXg6q2vPfykTi5j5
         4UrB7i8oZFjBXgBrSHB6dVvPnah4iGngFrXfsS2QWTO83eFGg3ihbamX77R/osCIL42U
         Zwcw==
X-Gm-Message-State: AHQUAubglfd6GMB2QHBiWzmoGODLnn4nl6cHrKVo/xIJz42dV9x8vsy6
        sSvCkQXHBiWBzb5s5qCJVZjUaFLm
X-Google-Smtp-Source: AHgI3IYt2e0QIQ+3Wt0rgEVWHubK4lBky/dc1jGzhlbpcNcAcf3Ws80zD6XvocsvbMn8+Xcwfy9WZg==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr14745289wrt.78.1551136637008;
        Mon, 25 Feb 2019 15:17:17 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id m15sm8146723wrx.30.2019.02.25.15.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:15 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 18/27] stash: convert create to builtin
Date:   Mon, 25 Feb 2019 23:16:22 +0000
Message-Id: <20190225231631.30507-19-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

Add stash create to the helper.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Helped-by: Matthew Kraai <mkraai@its.jnj.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash--helper.c | 449 +++++++++++++++++++++++++++++++++++++++-
 git-stash.sh            |   2 +-
 2 files changed, 449 insertions(+), 2 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 763a5ffd25..56864c126b 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,6 +12,9 @@
 #include "rerere.h"
 #include "revision.h"
 #include "log-tree.h"
+#include "diffcore.h"
+
+#define INCLUDE_ALL_FILES 2
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper list [<options>]"),
@@ -63,6 +66,11 @@ static const char * const git_stash_helper_store_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_create_usage[] = {
+	N_("git stash--helper create [<message>]"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
@@ -287,6 +295,20 @@ static int reset_head(void)
 	return run_command(&cp);
 }
 
+static void add_diff_to_buf(struct diff_queue_struct *q,
+			    struct diff_options *options,
+			    void *data)
+{
+	int i;
+
+	for (i = 0; i < q->nr; i++) {
+		strbuf_addstr(data, q->queue[i]->one->path);
+
+		/* NUL-terminate: will be fed to update-index -z */
+		strbuf_addch(data, '\0');
+	}
+}
+
 static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -789,6 +811,429 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 	return do_store_stash(&obj, stash_msg, quiet);
 }
 
+static void add_pathspecs(struct argv_array *args,
+			  struct pathspec ps) {
+	int i;
+
+	for (i = 0; i < ps.nr; i++)
+		argv_array_push(args, ps.items[i].match);
+}
+
+/*
+ * `untracked_files` will be filled with the names of untracked files.
+ * The return value is:
+ *
+ * = 0 if there are not any untracked files
+ * > 0 if there are untracked files
+ */
+static int get_untracked_files(struct pathspec ps, int include_untracked,
+			       struct strbuf *untracked_files)
+{
+	int i;
+	int max_len;
+	int found = 0;
+	char *seen;
+	struct dir_struct dir;
+
+	memset(&dir, 0, sizeof(dir));
+	if (include_untracked != INCLUDE_ALL_FILES)
+		setup_standard_excludes(&dir);
+
+	seen = xcalloc(ps.nr, 1);
+
+	max_len = fill_directory(&dir, the_repository->index, &ps);
+	for (i = 0; i < dir.nr; i++) {
+		struct dir_entry *ent = dir.entries[i];
+		if (dir_path_match(&the_index, ent, &ps, max_len, seen)) {
+			found++;
+			strbuf_addstr(untracked_files, ent->name);
+			/* NUL-terminate: will be fed to update-index -z */
+			strbuf_addch(untracked_files, '\0');
+		}
+		free(ent);
+	}
+
+	free(seen);
+	free(dir.entries);
+	free(dir.ignored);
+	clear_directory(&dir);
+	return found;
+}
+
+/*
+ * The return value of `check_changes()` can be:
+ *
+ * < 0 if there was an error
+ * = 0 if there are no changes.
+ * > 0 if there are changes.
+ */
+static int check_changes(struct pathspec ps, int include_untracked)
+{
+	int result;
+	struct rev_info rev;
+	struct object_id dummy;
+	struct strbuf out = STRBUF_INIT;
+
+	/* No initial commit. */
+	if (get_oid("HEAD", &dummy))
+		return -1;
+
+	if (read_cache() < 0)
+		return -1;
+
+	init_revisions(&rev, NULL);
+	rev.prune_data = ps;
+
+	rev.diffopt.flags.quick = 1;
+	rev.diffopt.flags.ignore_submodules = 1;
+	rev.abbrev = 0;
+
+	add_head_to_pending(&rev);
+	diff_setup_done(&rev.diffopt);
+
+	result = run_diff_index(&rev, 1);
+	if (diff_result_code(&rev.diffopt, result))
+		return 1;
+
+	object_array_clear(&rev.pending);
+	result = run_diff_files(&rev, 0);
+	if (diff_result_code(&rev.diffopt, result))
+		return 1;
+
+	if (include_untracked && get_untracked_files(ps, include_untracked,
+						     &out)) {
+		strbuf_release(&out);
+		return 1;
+	}
+
+	strbuf_release(&out);
+	return 0;
+}
+
+static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
+				struct strbuf files)
+{
+	int ret = 0;
+	struct strbuf untracked_msg = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
+	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
+
+	cp_upd_index.git_cmd = 1;
+	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
+			 "--remove", "--stdin", NULL);
+	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+
+	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
+	if (pipe_command(&cp_upd_index, files.buf, files.len, NULL, 0,
+			 NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	cp_write_tree.git_cmd = 1;
+	argv_array_push(&cp_write_tree.args, "write-tree");
+	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+	get_oid_hex(out.buf, &info->u_tree);
+
+	if (commit_tree(untracked_msg.buf, untracked_msg.len,
+			&info->u_tree, NULL, &info->u_commit, NULL, NULL)) {
+		ret = -1;
+		goto done;
+	}
+
+done:
+	strbuf_release(&untracked_msg);
+	strbuf_release(&out);
+	remove_path(stash_index_path.buf);
+	return ret;
+}
+
+static int stash_patch(struct stash_info *info, struct pathspec ps,
+		       struct strbuf *out_patch)
+{
+	int ret = 0;
+	struct strbuf out = STRBUF_INIT;
+	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
+	struct child_process cp_add_i = CHILD_PROCESS_INIT;
+	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
+	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
+
+	remove_path(stash_index_path.buf);
+
+	cp_read_tree.git_cmd = 1;
+	argv_array_pushl(&cp_read_tree.args, "read-tree", "HEAD", NULL);
+	argv_array_pushf(&cp_read_tree.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (run_command(&cp_read_tree)) {
+		ret = -1;
+		goto done;
+	}
+
+	/* Find out what the user wants. */
+	cp_add_i.git_cmd = 1;
+	argv_array_pushl(&cp_add_i.args, "add--interactive", "--patch=stash",
+			 "--", NULL);
+	add_pathspecs(&cp_add_i.args, ps);
+	argv_array_pushf(&cp_add_i.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (run_command(&cp_add_i)) {
+		ret = -1;
+		goto done;
+	}
+
+	/* State of the working tree. */
+	cp_write_tree.git_cmd = 1;
+	argv_array_push(&cp_write_tree.args, "write-tree");
+	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	get_oid_hex(out.buf, &info->w_tree);
+
+	cp_diff_tree.git_cmd = 1;
+	argv_array_pushl(&cp_diff_tree.args, "diff-tree", "-p", "HEAD",
+			 oid_to_hex(&info->w_tree), "--", NULL);
+	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	if (!out_patch->len) {
+		fprintf_ln(stderr, _("No changes selected"));
+		ret = 1;
+	}
+
+done:
+	strbuf_release(&out);
+	remove_path(stash_index_path.buf);
+	return ret;
+}
+
+static int stash_working_tree(struct stash_info *info, struct pathspec ps)
+{
+	int ret = 0;
+	struct rev_info rev;
+	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
+	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+	struct strbuf diff_output = STRBUF_INIT;
+
+	init_revisions(&rev, NULL);
+
+	set_alternate_index_output(stash_index_path.buf);
+	if (reset_tree(&info->i_tree, 0, 0)) {
+		ret = -1;
+		goto done;
+	}
+	set_alternate_index_output(NULL);
+
+	rev.prune_data = ps;
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = add_diff_to_buf;
+	rev.diffopt.format_callback_data = &diff_output;
+
+	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
+		ret = -1;
+		goto done;
+	}
+
+	add_pending_object(&rev, parse_object(the_repository, &info->b_commit),
+			   "");
+	if (run_diff_index(&rev, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	cp_upd_index.git_cmd = 1;
+	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
+			 "--remove", "--stdin", NULL);
+	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+
+	if (pipe_command(&cp_upd_index, diff_output.buf, diff_output.len,
+			 NULL, 0, NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	cp_write_tree.git_cmd = 1;
+	argv_array_push(&cp_write_tree.args, "write-tree");
+	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	get_oid_hex(out.buf, &info->w_tree);
+
+done:
+	UNLEAK(rev);
+	strbuf_release(&out);
+	object_array_clear(&rev.pending);
+	strbuf_release(&diff_output);
+	remove_path(stash_index_path.buf);
+	return ret;
+}
+
+static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
+			   int include_untracked, int patch_mode,
+			   struct stash_info *info)
+{
+	int ret = 0;
+	int flags = 0;
+	int untracked_commit_option = 0;
+	const char *head_short_sha1 = NULL;
+	const char *branch_ref = NULL;
+	const char *branch_name = "(no branch)";
+	struct commit *head_commit = NULL;
+	struct commit_list *parents = NULL;
+	struct strbuf msg = STRBUF_INIT;
+	struct strbuf commit_tree_label = STRBUF_INIT;
+	struct strbuf untracked_files = STRBUF_INIT;
+	struct strbuf patch = STRBUF_INIT;
+
+	prepare_fallback_ident("git stash", "git@stash");
+
+	read_cache_preload(NULL);
+	refresh_cache(REFRESH_QUIET);
+
+	if (get_oid("HEAD", &info->b_commit)) {
+		fprintf_ln(stderr, _("You do not have the initial commit yet"));
+		ret = -1;
+		goto done;
+	} else {
+		head_commit = lookup_commit(the_repository, &info->b_commit);
+	}
+
+	if (!check_changes(ps, include_untracked)) {
+		ret = 1;
+		goto done;
+	}
+
+	branch_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
+	if (flags & REF_ISSYMREF)
+		branch_name = strrchr(branch_ref, '/') + 1;
+	head_short_sha1 = find_unique_abbrev(&head_commit->object.oid,
+					     DEFAULT_ABBREV);
+	strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);
+	pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);
+
+	strbuf_addf(&commit_tree_label, "index on %s\n", msg.buf);
+	commit_list_insert(head_commit, &parents);
+	if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
+	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
+			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
+		fprintf_ln(stderr, _("Cannot save the current index state"));
+		ret = -1;
+		goto done;
+	}
+
+	if (include_untracked && get_untracked_files(ps, include_untracked,
+						     &untracked_files)) {
+		if (save_untracked_files(info, &msg, untracked_files)) {
+			fprintf_ln(stderr, _("Cannot save "
+					     "the untracked files"));
+			ret = -1;
+			goto done;
+		}
+		untracked_commit_option = 1;
+	}
+	if (patch_mode) {
+		ret = stash_patch(info, ps, &patch);
+		if (ret < 0) {
+			fprintf_ln(stderr, _("Cannot save the current "
+					     "worktree state"));
+			goto done;
+		} else if (ret > 0) {
+			goto done;
+		}
+	} else {
+		if (stash_working_tree(info, ps)) {
+			fprintf_ln(stderr, _("Cannot save the current "
+					     "worktree state"));
+			ret = -1;
+			goto done;
+		}
+	}
+
+	if (!stash_msg_buf->len)
+		strbuf_addf(stash_msg_buf, "WIP on %s", msg.buf);
+	else
+		strbuf_insertf(stash_msg_buf, 0, "On %s: ", branch_name);
+
+	/*
+	 * `parents` will be empty after calling `commit_tree()`, so there is
+	 * no need to call `free_commit_list()`
+	 */
+	parents = NULL;
+	if (untracked_commit_option)
+		commit_list_insert(lookup_commit(the_repository,
+						 &info->u_commit),
+				   &parents);
+	commit_list_insert(lookup_commit(the_repository, &info->i_commit),
+			   &parents);
+	commit_list_insert(head_commit, &parents);
+
+	if (commit_tree(stash_msg_buf->buf, stash_msg_buf->len, &info->w_tree,
+			parents, &info->w_commit, NULL, NULL)) {
+		fprintf_ln(stderr, _("Cannot record working tree state"));
+		ret = -1;
+		goto done;
+	}
+
+done:
+	strbuf_release(&commit_tree_label);
+	strbuf_release(&msg);
+	strbuf_release(&untracked_files);
+	return ret;
+}
+
+static int create_stash(int argc, const char **argv, const char *prefix)
+{
+	int include_untracked = 0;
+	int ret = 0;
+	const char *stash_msg = NULL;
+	struct strbuf stash_msg_buf = STRBUF_INIT;
+	struct stash_info info;
+	struct pathspec ps;
+	struct option options[] = {
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			 N_("include untracked files in stash")),
+		OPT_STRING('m', "message", &stash_msg, N_("message"),
+			 N_("stash message")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_create_usage,
+			     0);
+
+	memset(&ps, 0, sizeof(ps));
+	strbuf_addstr(&stash_msg_buf, stash_msg);
+	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info);
+	if (!ret)
+		printf_ln("%s", oid_to_hex(&info.w_commit));
+
+	strbuf_release(&stash_msg_buf);
+
+	/*
+	 * ret can be 1 if there were no changes. In this case, we should
+	 * not error out.
+	 */
+	return ret < 0;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -798,7 +1243,7 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_diff_basic_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_helper_usage,
 			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
@@ -825,6 +1270,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!show_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "store"))
 		return !!store_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "create"))
+		return !!create_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index ff5556ccb0..a9b3064ff0 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -442,7 +442,7 @@ clear)
 	;;
 create)
 	shift
-	create_stash -m "$*" && echo "$w_commit"
+	git stash--helper create --message "$*"
 	;;
 store)
 	shift
-- 
2.21.0.rc2.291.g17236886c5

