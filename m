Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC121FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 00:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbdFHA5b (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 20:57:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35901 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbdFHA53 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 20:57:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id y7so3178604pfd.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 17:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JfzcyRUeGDZ0g7Oy3f9ckI+o2RxNo9LdkbykiWWct/4=;
        b=Q7Ouzw1hCWSgfGHVHx2bY8Mpn1SHwB5wjuC2uEtzKq0/+0U9oxEWCs1MVOWkltOt1q
         nxzPN5NZtaOaAmyTCTvG7sQwIK6E0Alt5yWled2SHdjP6umzHB5Vf/mSXGRaqfHBxSAw
         cNyEJDzaIfedTdEH8HZV0JqMoWMHiK0mJG+sG6C3m6FSTa+A6iVeVWwP/1RGSf2ZLils
         jkJLeJBlIjOh3D1c1AzjnXchM889X1nuz2d3dKzSltjw77wQ68LnonKPAT/qwdll5L6Q
         IGeuarNyLKcbadn2ofzi4htxJK3La8F4Wx9xhKeZhKiyLEeLoQlQJUHkIhp6AZinC/ZZ
         FvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JfzcyRUeGDZ0g7Oy3f9ckI+o2RxNo9LdkbykiWWct/4=;
        b=NvGOjjN1Depe4ImsilDLR6TD/vi/nnY+3Wfvc/ovrMMyIcnruquGXS9Fi+PDzde9sQ
         wWUf1R8KHWr2GQkmjrdKk9wjnK5IiU5YC/flxQp2SQ9aPf8ZLqQixd3kkbYca0L3zMI/
         COsAnsKJgiciULYuGAnPzTiCX4QtDmNFcfiKjMkYRF9VAyUnT6lg/lvfQPkwgxNmLTQN
         rhdtDWNK1p/KVi1ZLPtlSIFyC3Ok5jHJgaYsclVldvDPHHIvRp/M+b45nAjlgcoij9J/
         JPqLS9FKgeI4wCNpMulP/Q1TvgeBM0PeJJfaMSyF4aMuAekrIDARzpBn9V3X73CV3zrT
         jyUg==
X-Gm-Message-State: AODbwcDQmjX/PjKzN2UpkMRAm5lEkF4A6+PwyYz+qqpFT/jrlSXVsLSw
        6qokfTLSZCCrY1kMvtw=
X-Received: by 10.84.232.130 with SMTP id i2mr31516841plk.251.1496883448222;
        Wed, 07 Jun 2017 17:57:28 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id s17sm6418848pfk.112.2017.06.07.17.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jun 2017 17:57:27 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v4 5/5] stash: implement builtin stash
Date:   Wed,  7 Jun 2017 17:55:35 -0700
Message-Id: <20170608005535.13080-6-joel@teichroeb.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170608005535.13080-1-joel@teichroeb.net>
References: <20170608005535.13080-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement all git stash functionality as a builtin command

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 Makefile                                      |    2 +-
 builtin.h                                     |    1 +
 builtin/stash.c                               | 1224 +++++++++++++++++++++++++
 git-stash.sh => contrib/examples/git-stash.sh |    0
 git.c                                         |    1 +
 5 files changed, 1227 insertions(+), 1 deletion(-)
 create mode 100644 builtin/stash.c
 rename git-stash.sh => contrib/examples/git-stash.sh (100%)

diff --git a/Makefile b/Makefile
index 7c621f7f76..3364d87630 100644
--- a/Makefile
+++ b/Makefile
@@ -525,7 +525,6 @@ SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
-SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
@@ -965,6 +964,7 @@ BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/stash.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
diff --git a/builtin.h b/builtin.h
index 498ac80d07..fa59481420 100644
--- a/builtin.h
+++ b/builtin.h
@@ -119,6 +119,7 @@ extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
+extern int cmd_stash(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/builtin/stash.c b/builtin/stash.c
new file mode 100644
index 0000000000..a9680f2909
--- /dev/null
+++ b/builtin/stash.c
@@ -0,0 +1,1224 @@
+#include "builtin.h"
+#include "parse-options.h"
+#include "refs.h"
+#include "tree.h"
+#include "lockfile.h"
+#include "object.h"
+#include "tree-walk.h"
+#include "cache-tree.h"
+#include "unpack-trees.h"
+#include "diff.h"
+#include "revision.h"
+#include "commit.h"
+#include "diffcore.h"
+#include "merge-recursive.h"
+#include "argv-array.h"
+#include "run-command.h"
+
+static const char * const git_stash_usage[] = {
+	N_("git stash list [<options>]"),
+	N_("git stash show [<stash>]"),
+	N_("git stash drop [-q|--quiet] [<stash>]"),
+	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash branch <branchname> [<stash>]"),
+	N_("git stash [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]"),
+	N_("                [-u|--include-untracked] [-a|--all] [<message>]]"),
+	N_("git stash clear"),
+	N_("git stash create [<message>]"),
+	N_("git stash store [-m|--message <message>] [-q|--quiet] <commit>"),
+	NULL
+};
+
+static const char * const git_stash_list_usage[] = {
+	N_("git stash list [<options>]"),
+	NULL
+};
+
+static const char * const git_stash_show_usage[] = {
+	N_("git stash show [<stash>]"),
+	NULL
+};
+
+static const char * const git_stash_drop_usage[] = {
+	N_("git stash drop [-q|--quiet] [<stash>]"),
+	NULL
+};
+
+static const char * const git_stash_pop_usage[] = {
+	N_("git stash pop [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
+static const char * const git_stash_apply_usage[] = {
+	N_("git stash apply [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
+static const char * const git_stash_branch_usage[] = {
+	N_("git stash branch <branchname> [<stash>]"),
+	NULL
+};
+
+static const char * const git_stash_save_usage[] = {
+	N_("git stash [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]"),
+	N_("                [-u|--include-untracked] [-a|--all] [<message>]]"),
+	NULL
+};
+
+static const char * const git_stash_clear_usage[] = {
+	N_("git stash clear"),
+	NULL
+};
+
+static const char * const git_stash_create_usage[] = {
+	N_("git stash create [<message>]"),
+	NULL
+};
+
+static const char * const git_stash_store_usage[] = {
+	N_("git stash store [-m|--message <message>] [-q|--quiet] <commit>"),
+	NULL
+};
+
+static const char *ref_stash = "refs/stash";
+static int quiet = 0;
+static struct lock_file lock_file;
+static char stash_index_path[64];
+
+struct stash_info {
+	struct object_id w_commit;
+	struct object_id b_commit;
+	struct object_id i_commit;
+	struct object_id u_commit;
+	struct object_id w_tree;
+	struct object_id b_tree;
+	struct object_id i_tree;
+	struct object_id u_tree;
+	const char *message;
+	const char *revision;
+	int is_stash_ref;
+	int has_u;
+	const char *patch;
+};
+
+static int untracked_files(struct strbuf *out, int include_untracked,
+		int include_ignored, const char **argv)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "ls-files", "-o", "-z", NULL);
+	if (include_untracked && !include_ignored)
+		argv_array_push(&cp.args, "--exclude-standard");
+	argv_array_push(&cp.args, "--");
+	if (argv)
+		argv_array_pushv(&cp.args, argv);
+	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
+}
+
+static int check_no_changes(const char *prefix, int include_untracked,
+		int include_ignored, const char **argv)
+{
+	struct argv_array args1 = ARGV_ARRAY_INIT;
+	struct argv_array args2 = ARGV_ARRAY_INIT;
+	struct strbuf out = STRBUF_INIT;
+	int ret;
+
+	argv_array_pushl(&args1, "diff-index", "--quiet", "--cached", "HEAD",
+		"--ignore-submodules", "--", NULL);
+	if (argv)
+		argv_array_pushv(&args1, argv);
+
+	argv_array_pushl(&args2, "diff-files", "--quiet", "--ignore-submodules",
+		"--", NULL);
+	if (argv)
+		argv_array_pushv(&args2, argv);
+
+	if (include_untracked)
+		untracked_files(&out, include_untracked, include_ignored, argv);
+
+	ret = cmd_diff_index(args1.argc, args1.argv, prefix) == 0 &&
+			cmd_diff_files(args2.argc, args2.argv, prefix) == 0 &&
+			(!include_untracked || out.len == 0);
+	strbuf_release(&out);
+	return ret;
+}
+
+static int get_stash_info(struct stash_info *info, const char *commit)
+{
+	struct strbuf w_commit_rev = STRBUF_INIT;
+	struct strbuf b_commit_rev = STRBUF_INIT;
+	struct strbuf w_tree_rev = STRBUF_INIT;
+	struct strbuf b_tree_rev = STRBUF_INIT;
+	struct strbuf i_tree_rev = STRBUF_INIT;
+	struct strbuf u_tree_rev = STRBUF_INIT;
+	struct strbuf commit_buf = STRBUF_INIT;
+	struct strbuf symbolic = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	int ret;
+	const char *revision = commit;
+	char *end_of_rev;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	info->is_stash_ref = 0;
+
+	if (commit == NULL) {
+		strbuf_addf(&commit_buf, "%s@{0}", ref_stash);
+		revision = commit_buf.buf;
+	} else if (strlen(commit) < 3) {
+		strbuf_addf(&commit_buf, "%s@{%s}", ref_stash, commit);
+		revision = commit_buf.buf;
+	}
+	info->revision = revision;
+
+	strbuf_addf(&w_commit_rev, "%s", revision);
+	strbuf_addf(&b_commit_rev, "%s^1", revision);
+	strbuf_addf(&w_tree_rev, "%s:", revision);
+	strbuf_addf(&b_tree_rev, "%s^1:", revision);
+	strbuf_addf(&i_tree_rev, "%s^2:", revision);
+	strbuf_addf(&u_tree_rev, "%s^3:", revision);
+
+	ret = (get_sha1(w_commit_rev.buf, info->w_commit.hash) == 0 &&
+		get_sha1(b_commit_rev.buf, info->b_commit.hash) == 0 &&
+		get_sha1(w_tree_rev.buf, info->w_tree.hash) == 0 &&
+		get_sha1(b_tree_rev.buf, info->b_tree.hash) == 0 &&
+		get_sha1(i_tree_rev.buf, info->i_tree.hash) == 0);
+
+	strbuf_release(&w_commit_rev);
+	strbuf_release(&b_commit_rev);
+	strbuf_release(&w_tree_rev);
+	strbuf_release(&b_tree_rev);
+	strbuf_release(&i_tree_rev);
+
+	if (!ret)
+		return error(_("%s is not a valid reference"), revision);
+
+	info->has_u = get_sha1(u_tree_rev.buf, info->u_tree.hash) == 0;
+
+	strbuf_release(&u_tree_rev);
+
+	end_of_rev = strchrnul(revision, '@');
+	strbuf_add(&symbolic, revision, end_of_rev - revision);
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "rev-parse", "--symbolic-full-name", NULL);
+	argv_array_pushf(&cp.args, "%s", symbolic.buf);
+	strbuf_release(&symbolic);
+	pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
+
+	if (out.len-1 == strlen(ref_stash))
+		info->is_stash_ref = strncmp(out.buf, ref_stash, out.len-1) == 0;
+	strbuf_release(&out);
+
+	return !ret;
+}
+
+static void stash_create_callback(struct diff_queue_struct *q,
+				struct diff_options *opt, void *cbdata)
+{
+	int i;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		const char *path = p->one->path;
+		struct stat st;
+		remove_file_from_index(&the_index, path);
+		if (!lstat(path, &st))
+			add_to_index(&the_index, path, &st, 0);
+	}
+}
+
+/*
+ * Untracked files are stored by themselves in a parentless commit, for
+ * ease of unpacking later.
+ */
+static int save_untracked(struct stash_info *info, const char *message,
+		int include_untracked, int include_ignored, const char **argv)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+	struct object_id orig_tree;
+	int ret;
+	const char *index_file = get_index_file();
+
+	set_alternate_index_output(stash_index_path);
+	untracked_files(&out, include_untracked, include_ignored, argv);
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "update-index", "-z", "--add", "--remove",
+		"--stdin", NULL);
+	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
+
+	if (pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0)) {
+		strbuf_release(&out);
+		return 1;
+	}
+
+	strbuf_reset(&out);
+
+	discard_cache();
+	read_cache_from(stash_index_path);
+
+	write_index_as_tree(orig_tree.hash, &the_index, stash_index_path, 0,NULL);
+	discard_cache();
+
+	read_cache_from(stash_index_path);
+
+	write_cache_as_tree(info->u_tree.hash, 0, NULL);
+	strbuf_addf(&out, "untracked files on %s", message);
+
+	ret = commit_tree(out.buf, out.len, info->u_tree.hash, NULL,
+			info->u_commit.hash, NULL, NULL);
+	strbuf_release(&out);
+	if (ret)
+		return 1;
+
+	set_alternate_index_output(index_file);
+	discard_cache();
+	read_cache();
+
+	return 0;
+}
+
+static int save_working_tree(struct stash_info *info, const char *prefix,
+		const char **argv)
+{
+	struct object_id orig_tree;
+	struct rev_info rev;
+	int nr_trees = 1;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct tree *tree;
+	struct unpack_trees_options opts;
+	struct object *obj;
+
+	discard_cache();
+	tree = parse_tree_indirect(&info->i_tree);
+	prime_cache_tree(&the_index, tree);
+	write_index_as_tree(orig_tree.hash, &the_index, stash_index_path, 0, NULL);
+	discard_cache();
+
+	read_cache_from(stash_index_path);
+
+	memset(&opts, 0, sizeof(opts));
+
+	parse_tree(tree);
+
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.merge = 1;
+	opts.fn = oneway_merge;
+
+	init_tree_desc(t, tree->buffer, tree->size);
+
+	if (unpack_trees(nr_trees, t, &opts))
+		return 1;
+
+	init_revisions(&rev, prefix);
+	setup_revisions(0, NULL, &rev, NULL);
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = stash_create_callback;
+	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
+
+	parse_pathspec(&rev.prune_data, 0, 0, prefix, argv);
+
+	diff_setup_done(&rev.diffopt);
+	obj = parse_object(&info->b_commit);
+	add_pending_object(&rev, obj, "");
+	if (run_diff_index(&rev, 0))
+		return 1;
+
+	if (write_cache_as_tree(info->w_tree.hash, 0, NULL))
+		return 1;
+
+	discard_cache();
+	read_cache();
+
+	return 0;
+}
+
+static int patch_working_tree(struct stash_info *info, const char *prefix,
+		const char **argv)
+{
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+	size_t unused;
+	const char *index_file = get_index_file();
+
+	argv_array_pushl(&args, "read-tree", "HEAD", NULL);
+	argv_array_pushf(&args, "--index-output=%s", stash_index_path);
+	cmd_read_tree(args.argc, args.argv, prefix);
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "add--interactive", "--patch=stash", "--", NULL);
+	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
+	if (run_command(&cp))
+		return 1;
+
+	discard_cache();
+	read_cache_from(stash_index_path);
+
+	if (write_cache_as_tree(info->w_tree.hash, 0, NULL))
+		return 1;
+
+	child_process_init(&cp);
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "diff-tree", "-p", "HEAD", NULL);
+	argv_array_push(&cp.args, sha1_to_hex(info->w_tree.hash));
+	argv_array_push(&cp.args, "--");
+	if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0) || out.len == 0)
+		return 1;
+
+	info->patch = strbuf_detach(&out, &unused);
+
+	set_alternate_index_output(index_file);
+	discard_cache();
+	read_cache();
+
+	return 0;
+}
+
+static int do_create_stash(struct stash_info *info, const char *prefix,
+		const char *message, int include_untracked, int include_ignored,
+		int patch, const char **argv)
+{
+	struct object_id curr_head;
+	char *branch_path = NULL;
+	const char *branch_name = NULL;
+	struct commit_list *parents = NULL;
+	struct strbuf out_message = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	struct pretty_print_context ctx = {0};
+
+	struct commit *c = NULL;
+	const char *hash;
+
+	read_cache_preload(NULL);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
+	if (check_no_changes(prefix, include_untracked, include_ignored, argv))
+		return 1;
+
+	if (get_sha1_tree("HEAD", info->b_commit.hash))
+		return error(_("You do not have the initial commit yet"));
+
+	branch_path = resolve_refdup("HEAD", 0, curr_head.hash, NULL);
+
+	if (branch_path == NULL || strcmp(branch_path, "HEAD") == 0)
+		branch_name = "(no branch)";
+	else
+		skip_prefix(branch_path, "refs/heads/", &branch_name);
+
+	c = lookup_commit(&info->b_commit);
+
+	ctx.output_encoding = get_log_output_encoding();
+	ctx.abbrev = 1;
+	ctx.fmt = CMIT_FMT_ONELINE;
+	hash = find_unique_abbrev(c->object.oid.hash, DEFAULT_ABBREV);
+
+	strbuf_addf(&out_message, "%s: %s ", branch_name, hash);
+
+	pretty_print_commit(&ctx, c, &out_message);
+
+	strbuf_addf(&out, "index on %s\n", out_message.buf);
+
+	commit_list_insert(lookup_commit(&info->b_commit), &parents);
+
+	if (write_cache_as_tree(info->i_tree.hash, 0, NULL))
+		return error(_("git write-tree failed to write a tree"));
+
+	if (commit_tree(out.buf, out.len, info->i_tree.hash, parents, info->i_commit.hash, NULL, NULL))
+		return error(_("Cannot save the current index state"));
+
+	strbuf_reset(&out);
+
+	if (include_untracked) {
+		if (save_untracked(info, out_message.buf, include_untracked, include_ignored, argv))
+			return error(_("Cannot save the untracked files"));
+	}
+
+	if (patch) {
+		if (patch_working_tree(info, prefix, argv))
+			return error(_("Cannot save the current worktree state"));
+	} else {
+		if (save_working_tree(info, prefix, argv))
+			return error(_("Cannot save the current worktree state"));
+	}
+	parents = NULL;
+
+	if (include_untracked)
+		commit_list_insert(lookup_commit(&info->u_commit), &parents);
+
+	commit_list_insert(lookup_commit(&info->i_commit), &parents);
+	commit_list_insert(lookup_commit(&info->b_commit), &parents);
+
+	if (message != NULL && strlen(message) != 0)
+		strbuf_addf(&out, "On %s: %s\n", branch_name, message);
+	else
+		strbuf_addf(&out, "WIP on %s\n", out_message.buf);
+
+	if (commit_tree(out.buf, out.len, info->w_tree.hash, parents, info->w_commit.hash, NULL, NULL))
+		return error(_("Cannot record working tree state"));
+
+	info->message = out.buf;
+
+	strbuf_release(&out_message);
+	free(branch_path);
+
+	return 0;
+}
+
+static int create_stash(int argc, const char **argv, const char *prefix)
+{
+	int include_untracked = 0;
+	const char *message = NULL;
+	struct stash_info info;
+	int ret;
+	struct strbuf out = STRBUF_INIT;
+	struct option options[] = {
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			N_("stash untracked filed")),
+		OPT_STRING('m', "message", &message, N_("message"),
+			N_("stash commit message")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_create_usage, 0);
+
+	if (argc != 0) {
+		int i;
+		for (i = 0; i < argc; ++i) {
+			if (i != 0) {
+				strbuf_addf(&out, " ");
+			}
+			strbuf_addf(&out, "%s", argv[i]);
+		}
+		message = out.buf;
+	}
+
+	ret = do_create_stash(&info, prefix, message, include_untracked, 0, 0, NULL);
+
+	strbuf_release(&out);
+
+	if (ret)
+		return 0;
+
+	printf("%s\n", sha1_to_hex(info.w_commit.hash));
+	return 0;
+}
+
+static int do_store_stash(const char *prefix, int quiet, const char *message,
+		struct object_id commit)
+{
+	int ret;
+	ret = update_ref(message, ref_stash, commit.hash, NULL,
+			REF_FORCE_CREATE_REFLOG, UPDATE_REFS_DIE_ON_ERR);
+
+	if (ret && !quiet)
+		return error(_("Cannot update %s with %s"), ref_stash, sha1_to_hex(commit.hash));
+
+	return ret;
+}
+
+static int store_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *message = "Create via \"git stash store\".";
+	const char *commit = NULL;
+	struct object_id obj;
+	struct option options[] = {
+		OPT_STRING('m', "message", &message, N_("message"),
+			N_("stash commit message")),
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, prefix, options, git_stash_store_usage, 0);
+
+	if (argc != 1)
+		return error(_("\"git stash store\" requires one <commit> argument"));
+
+	commit = argv[0];
+
+	if (get_sha1(commit, obj.hash)) {
+		fprintf_ln(stderr, _("fatal: %s: not a valid SHA1"), commit);
+		fprintf_ln(stderr, _("cannot update %s with %s"), ref_stash, commit);
+		return 1;
+	}
+
+	return do_store_stash(prefix, quiet, message, obj);
+}
+
+static int do_clear_stash(void)
+{
+	struct object_id obj;
+	if (get_sha1(ref_stash, obj.hash))
+		return 0;
+
+	return delete_ref(NULL, ref_stash, obj.hash, 0);
+}
+
+static int clear_stash(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, git_stash_clear_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc != 0)
+		return error(_("git stash clear with parameters is unimplemented"));
+
+	return do_clear_stash();
+}
+
+static int reset_tree(struct object_id i_tree, int update, int reset)
+{
+	struct unpack_trees_options opts;
+	int nr_trees = 1;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct tree *tree;
+
+	read_cache_preload(NULL);
+	if (refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL))
+		return 1;
+
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+
+	memset(&opts, 0, sizeof(opts));
+
+	tree = parse_tree_indirect(&i_tree);
+	if (parse_tree(tree))
+		return 1;
+
+	init_tree_desc(t, tree->buffer, tree->size);
+
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.merge = 1;
+	opts.reset = reset;
+	opts.update = update;
+	opts.fn = oneway_merge;
+
+	if (unpack_trees(nr_trees, t, &opts))
+		return 1;
+
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK)) {
+		error(_("unable to write new index file"));
+		return 1;
+	}
+
+	return 0;
+}
+
+static int do_push_stash(const char *prefix, const char *message,
+	int keep_index, int include_untracked, int include_ignored, int patch,
+	const char **argv)
+{
+	int res;
+	struct stash_info info;
+
+	if (patch && include_untracked)
+		return error(_("can't use --patch and --include-untracked or --all at the same time"));
+
+	if (!include_untracked) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+
+		cp.git_cmd = 1;
+		cp.no_stdout = 1;
+		argv_array_pushl(&cp.args, "ls-files", "--error-unmatch", "--", NULL);
+		if (argv)
+			argv_array_pushv(&cp.args, argv);
+		res = run_command(&cp);
+		if (res)
+			return 1;
+	}
+
+	read_cache_preload(NULL);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
+	if (check_no_changes(prefix, include_untracked, include_ignored, argv)) {
+		printf_ln(_("No local changes to save"));
+		return 0;
+	}
+
+	if (!reflog_exists(ref_stash)) {
+		if (do_clear_stash())
+			return error(_("Cannot initialize stash"));
+	}
+
+	if (do_create_stash(&info, prefix, message, include_untracked, include_ignored, patch, argv))
+		return 1;
+	res = do_store_stash(prefix, 1, info.message, info.w_commit);
+
+	if (res == 0 && !quiet)
+		printf(_("Saved working directory and index state %s"), info.message);
+
+	if (!patch) {
+		if (argv && *argv) {
+			struct argv_array args = ARGV_ARRAY_INIT;
+			struct argv_array args2 = ARGV_ARRAY_INIT;
+			struct child_process cp = CHILD_PROCESS_INIT;
+			struct strbuf out = STRBUF_INIT;
+			argv_array_pushl(&args, "reset", "--quiet", "--", NULL);
+			argv_array_pushv(&args, argv);
+			cmd_reset(args.argc, args.argv, prefix);
+
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "ls-files", "-z", "--modified", "--",
+				NULL);
+			argv_array_pushv(&cp.args, argv);
+			pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
+
+			child_process_init(&cp);
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "checkout-index", "-z", "--force",
+				"--stdin", NULL);
+			pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0);
+			strbuf_release(&out);
+
+			argv_array_pushl(&args2, "clean", "--force", "-d", "--quiet", "--",
+				NULL);
+			argv_array_pushv(&args2, argv);
+			cmd_clean(args2.argc, args2.argv, prefix);
+		} else {
+			struct argv_array args = ARGV_ARRAY_INIT;
+			argv_array_pushl(&args, "reset", "--hard", "--quiet", NULL);
+			cmd_reset(args.argc, args.argv, prefix);
+		}
+
+		if (include_untracked) {
+			struct argv_array args = ARGV_ARRAY_INIT;
+			argv_array_pushl(&args, "clean", "--force", "--quiet", "-d", NULL);
+			if (include_ignored)
+				argv_array_push(&args, "-x");
+			argv_array_push(&args, "--");
+			if (argv)
+				argv_array_pushv(&args, argv);
+			cmd_clean(args.argc, args.argv, prefix);
+		}
+
+		if (keep_index) {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			struct strbuf out = STRBUF_INIT;
+
+			reset_tree(info.i_tree, 0, 1);
+
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "ls-files", "-z", "--modified", "--",
+				NULL);
+			argv_array_pushv(&cp.args, argv);
+			if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0))
+				return 1;
+
+			child_process_init(&cp);
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "checkout-index", "-z", "--force",
+				"--stdin", NULL);
+			if (pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0))
+				return 1;
+			strbuf_release(&out);
+		}
+	} else {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		cp.git_cmd = 1;
+		argv_array_pushl(&cp.args, "apply", "-R", NULL);
+		if (pipe_command(&cp, info.patch, strlen(info.patch), NULL, 0, NULL, 0))
+			return error(_("Cannot remove worktree changes"));
+
+		if (!keep_index) {
+			struct argv_array args = ARGV_ARRAY_INIT;
+			argv_array_pushl(&args, "reset", "--quiet", "--", NULL);
+			if (argv)
+				argv_array_pushv(&args, argv);
+			cmd_reset(args.argc, args.argv, prefix);
+		}
+	}
+
+	return 0;
+}
+
+static int push_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *message = NULL;
+	int include_untracked = 0;
+	int include_ignored = 0;
+	int patch = 0;
+	int keep_index_set = -1;
+	int keep_index = 0;
+	struct option options[] = {
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			N_("stash untracked filed")),
+		OPT_BOOL('a', "all", &include_ignored,
+			N_("stash ignored untracked files")),
+		OPT_BOOL('k', "keep-index", &keep_index_set,
+			N_("restore the index after applying the stash")),
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_STRING('m', "message", &message, N_("message"),
+			N_("stash commit message")),
+		OPT_BOOL('p', "patch", &patch,
+			N_("edit current diff and apply")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+				git_stash_save_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (include_ignored)
+		include_untracked = 1;
+
+	if (keep_index_set != -1)
+		keep_index = keep_index_set;
+	else if (patch)
+		keep_index = 1;
+
+	return do_push_stash(prefix, message, keep_index, include_untracked, include_ignored, patch, argv);
+}
+
+static int save_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *message = NULL;
+	int include_untracked = 0;
+	int include_ignored = 0;
+	int patch = 0;
+	int keep_index_set = -1;
+	int keep_index = 0;
+	int ret;
+	struct strbuf out = STRBUF_INIT;
+	struct option options[] = {
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			N_("stash untracked filed")),
+		OPT_BOOL('a', "all", &include_ignored,
+			N_("stash ignored untracked files")),
+		OPT_BOOL('k', "keep-index", &keep_index_set,
+			N_("restore the index after applying the stash")),
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_STRING('m', "message", &message, N_("message"),
+			N_("stash commit message")),
+		OPT_BOOL('p', "patch", &patch,
+			N_("edit current diff and apply")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_save_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (include_ignored)
+		include_untracked = 1;
+
+	if (keep_index_set != -1)
+		keep_index = keep_index_set;
+	else if (patch)
+		keep_index = 1;
+
+	if (argc != 0) {
+		int i;
+		for (i = 0; i < argc; ++i) {
+			if (i != 0)
+				strbuf_addf(&out, " ");
+			strbuf_addf(&out, "%s", argv[i]);
+		}
+		message = out.buf;
+	}
+
+	ret = do_push_stash(prefix, message, keep_index, include_untracked,
+			include_ignored, patch, NULL);
+	strbuf_release(&out);
+	return ret;
+}
+
+static int do_apply_stash(const char *prefix, struct stash_info *info, int index)
+{
+	struct merge_options o;
+	struct object_id c_tree;
+	struct object_id index_tree;
+	const struct object_id *bases[1];
+	int bases_count = 1;
+	struct commit *result;
+	int ret;
+
+	read_cache_preload(NULL);
+	if (refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL))
+		return 1;
+
+	if (write_cache_as_tree(c_tree.hash, 0, NULL))
+		return 1;
+
+	if (index) {
+		if (hashcmp(info->b_tree.hash, info->i_tree.hash) == 0 || hashcmp(c_tree.hash, info->i_tree.hash) == 0) {
+			index = 0;
+		} else {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			struct strbuf out = STRBUF_INIT;
+			struct argv_array args = ARGV_ARRAY_INIT;
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
+			argv_array_pushf(&cp.args, "%s^2^..%s^2", sha1_to_hex(info->w_commit.hash), sha1_to_hex(info->w_commit.hash));
+			if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0))
+				return 1;
+
+			child_process_init(&cp);
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "apply", "--cached", NULL);
+			if (pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0))
+				return 1;
+
+			strbuf_release(&out);
+			discard_cache();
+			read_cache();
+			if (write_cache_as_tree(index_tree.hash, 0, NULL))
+				return 1;
+
+			argv_array_push(&args, "reset");
+			cmd_reset(args.argc, args.argv, prefix);
+		}
+	}
+
+	if (info->has_u) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		struct child_process cp = CHILD_PROCESS_INIT;
+		const char *index_file = get_index_file();
+
+		argv_array_push(&args, "read-tree");
+		argv_array_push(&args, sha1_to_hex(info->u_tree.hash));
+		argv_array_pushf(&args, "--index-output=%s", stash_index_path);
+
+		cp.git_cmd = 1;
+		argv_array_pushl(&cp.args, "checkout-index", "--all", NULL);
+		argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
+
+		if (cmd_read_tree(args.argc, args.argv, prefix) ||
+				run_command(&cp)) {
+			return error(_("Could not restore untracked files from stash"));
+		}
+		set_alternate_index_output(index_file);
+	}
+
+	init_merge_options(&o);
+
+	o.branch1 = "Updated upstream";
+	o.branch2 = "Stashed changes";
+
+	if (hashcmp(info->b_tree.hash, c_tree.hash) == 0)
+		o.branch1 = "Version stash was based on";
+
+	if (quiet)
+		o.verbosity = 0;
+
+	if (o.verbosity >= 3)
+		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
+
+	bases[0] = &info->b_tree;
+
+	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, bases_count, bases, &result);
+	if (ret != 0) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		argv_array_push(&args, "rerere");
+		cmd_rerere(args.argc, args.argv, prefix);
+
+		if (index)
+			printf_ln(_("Index was not unstashed."));
+
+		return ret;
+	}
+
+	if (index) {
+		ret = reset_tree(index_tree, 0, 0);
+	} else {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf out = STRBUF_INIT;
+		cp.git_cmd = 1;
+		argv_array_pushl(&cp.args, "diff-index", "--cached", "--name-only", "--diff-filter=A", NULL);
+		argv_array_push(&cp.args, sha1_to_hex(c_tree.hash));
+		ret = pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
+		if (ret)
+			return 1;
+
+		ret = reset_tree(c_tree, 0, 1);
+		if (ret)
+			return 1;
+
+		child_process_init(&cp);
+		cp.git_cmd = 1;
+		argv_array_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
+		ret = pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0);
+		if (ret)
+			return 1;
+
+		strbuf_release(&out);
+		discard_cache();
+		read_cache();
+	}
+
+	if (!quiet) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		argv_array_push(&args, "status");
+		cmd_status(args.argc, args.argv, prefix);
+	}
+
+	return 0;
+}
+
+static int apply_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *commit = NULL;
+	int index = 0;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			N_("attempt to ininstate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_apply_usage, 0);
+
+	if (argc == 1) {
+		commit = argv[0];
+	}
+
+	if (get_stash_info(&info, commit))
+		return 1;
+
+	return do_apply_stash(prefix, &info, index);
+}
+
+static int do_drop_stash(const char *prefix, struct stash_info *info)
+{
+	struct argv_array args = ARGV_ARRAY_INIT;
+	int ret;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	argv_array_pushl(&args, "reflog", "delete", "--updateref", "--rewrite", NULL);
+	argv_array_push(&args, info->revision);
+	ret = cmd_reflog(args.argc, args.argv, prefix);
+	if (ret == 0) {
+		if (!quiet) {
+			printf(_("Dropped %s (%s)\n"), info->revision, sha1_to_hex(info->w_commit.hash));
+		}
+	} else {
+		return error(_("%s: Could not drop stash entry"), info->revision);
+	}
+
+	cp.git_cmd = 1;
+	/* Even though --quiet is specified, rev-parse still outputs the hash */
+	cp.no_stdout = 1;
+	argv_array_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
+	argv_array_pushf(&cp.args, "%s@{0}", ref_stash);
+	ret = run_command(&cp);
+
+	if (ret)
+		do_clear_stash();
+
+	return 0;
+}
+
+static int drop_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *commit = NULL;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_drop_usage, 0);
+
+	if (argc == 1)
+		commit = argv[0];
+
+	if (get_stash_info(&info, commit))
+		return 1;
+
+	if (!info.is_stash_ref)
+		return error(_("'%s' is not a stash reference"), commit);
+
+	return do_drop_stash(prefix, &info);
+}
+
+static int list_stash(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	struct object_id obj;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_list_usage, PARSE_OPT_KEEP_UNKNOWN);
+
+	if (get_sha1(ref_stash, obj.hash))
+		return 0;
+
+	argv_array_pushl(&args, "log", "--format=%gd: %gs", "-g", "--first-parent", "-m", NULL);
+	argv_array_pushv(&args, argv);
+	argv_array_push(&args, ref_stash);
+	ret = cmd_log(args.argc, args.argv, prefix);
+	if (ret)
+		return 1;
+
+	return 0;
+}
+
+static int show_stash(int argc, const char **argv, const char *prefix)
+{
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct stash_info info;
+	const char *commit = NULL;
+	int numstat = 0;
+	int patch = 0;
+	int ret;
+
+	struct option options[] = {
+		OPT_BOOL(0, "numstat", &numstat,
+			N_("Shows number of added and deleted lines in decimal notation")),
+		OPT_BOOL('p', "patch", &patch,
+			N_("Generate patch")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_show_usage, 0);
+
+	if (argc == 1)
+		commit = argv[0];
+
+	if (get_stash_info(&info, commit))
+		return 1;
+
+	argv_array_push(&args, "diff");
+	if (numstat)
+		argv_array_push(&args, "--numstat");
+	else if (patch)
+		argv_array_push(&args, "-p");
+	else
+		argv_array_push(&args, "--stat");
+
+	argv_array_push(&args, sha1_to_hex(info.b_commit.hash));
+	argv_array_push(&args, sha1_to_hex(info.w_commit.hash));
+	ret = cmd_diff(args.argc, args.argv, prefix);
+	return ret;
+}
+
+static int pop_stash(int argc, const char **argv, const char *prefix)
+{
+	int index = 0;
+	const char *commit = NULL;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			N_("attempt to ininstate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_pop_usage, 0);
+
+	if (argc == 1)
+		commit = argv[0];
+
+	if (get_stash_info(&info, commit))
+		return 1;
+
+	if (!info.is_stash_ref)
+		return error(_("'%s' is not a stash reference"), commit);
+
+	if (do_apply_stash(prefix, &info, index))
+		return 1;
+
+	return do_drop_stash(prefix, &info);
+}
+
+static int branch_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *commit = NULL, *branch = NULL;
+	int ret;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct stash_info info;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_branch_usage, 0);
+
+	if (argc != 0) {
+		branch = argv[0];
+		if (argc == 2)
+			commit = argv[1];
+	}
+
+	if (get_stash_info(&info, commit))
+		return 1;
+
+	argv_array_pushl(&args, "checkout", "-b", NULL);
+	argv_array_push(&args, branch);
+	argv_array_push(&args, sha1_to_hex(info.b_commit.hash));
+	ret = cmd_checkout(args.argc, args.argv, prefix);
+	if (ret)
+		return 1;
+
+	ret = do_apply_stash(prefix, &info, 1);
+	if (ret == 0 && info.is_stash_ref)
+		ret = do_drop_stash(prefix, &info);
+
+	return ret;
+}
+
+int cmd_stash(int argc, const char **argv, const char *prefix)
+{
+	int result = 0;
+	pid_t pid = getpid();
+
+	struct option options[] = {
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+
+	xsnprintf(stash_index_path, 64, ".git/index.stash.%d", pid);
+
+	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
+		PARSE_OPT_KEEP_UNKNOWN|PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc < 1) {
+		result = do_push_stash(NULL, prefix, 0, 0, 0, 0, NULL);
+	} else if (!strcmp(argv[0], "list"))
+		result = list_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "show"))
+		result = show_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "save"))
+		result = save_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "push"))
+		result = push_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "apply"))
+		result = apply_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "clear"))
+		result = clear_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "create"))
+		result = create_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "store"))
+		result = store_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "drop"))
+		result = drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		result = pop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "branch"))
+		result = branch_stash(argc, argv, prefix);
+	else {
+		if (argv[0][0] == '-') {
+			struct argv_array args = ARGV_ARRAY_INIT;
+			argv_array_push(&args, "push");
+			argv_array_pushv(&args, argv);
+			result = push_stash(args.argc, args.argv, prefix);
+			if (!result)
+				printf_ln(_("To restore them type \"git stash apply\""));
+		} else {
+			error(_("unknown subcommand: %s"), argv[0]);
+			result = 1;
+		}
+	}
+
+	return result;
+}
diff --git a/git-stash.sh b/contrib/examples/git-stash.sh
similarity index 100%
rename from git-stash.sh
rename to contrib/examples/git-stash.sh
diff --git a/git.c b/git.c
index 8ff44f081d..4531011cdc 100644
--- a/git.c
+++ b/git.c
@@ -491,6 +491,7 @@ static struct cmd_struct commands[] = {
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
-- 
2.13.0

