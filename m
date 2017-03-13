Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AF0220373
	for <e@80x24.org>; Mon, 13 Mar 2017 22:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbdCMWXm (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 18:23:42 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34028 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbdCMWX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 18:23:26 -0400
Received: by mail-pg0-f65.google.com with SMTP id b5so19960304pgg.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WUEemOvIiVXnxS/rJKweHlcyIG8uJGZZ78VahC2g2oM=;
        b=cZSH9nivFUxrl1oyM1OIyFDyHdH0DI/LFoDDkBuNnPJHvvuTY11Yhy/MC9aKw0yXMX
         o1SfU4MN39uWN11CNUBqRmAjMxjLXxrxavfx1B646eG/PKDSYAIo6Dpa2BNMcvz/1T9E
         5/LeLG9Zw/Ph+n4rBXKYGWLzFrNX+4OEery7jH47lZw/ZKld8TPbfD0S7iF2MB7qGXLy
         vq6PSl1neNjE9se3tQcwXFiHIyyKIYAvh6gvV3UdmzsP3WowpRpHZ+wS+7Hxamt0m0kB
         mIhKbObHRipWojYF9GgAZsMCtECvFjwS1s6z7kJ1w1ACLgHZL+jAm4qoZT9PZAhUmtUu
         QMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WUEemOvIiVXnxS/rJKweHlcyIG8uJGZZ78VahC2g2oM=;
        b=fbzgwwaFtJ6oKxF0qPGeV2c+V7f6HT4RR447Aa6w4Se0o39F0quqTXRDJyE+tJejC6
         5pgctcGb1k8BnHrKOGxSMpDEVFs5iwkNPkrhIv0QYWrYOn/HYC85CFyBQ9rGLjIEbDYn
         08HtWk7Xh4iORPdHuQY2FWf9Thn4akcDDUh+hV6sZyCoGj+ZhBMW6vDeUv7rc1a6hHZO
         MHfTW8x0zmm20wzZIWY6powJxM7AWY2JNEOA9e0uCD2ENPC0f4P4Xl/suwU+1aiM94bT
         hcAVcq3Q2Xtw4uxPVU/wFeLBWN4w+0JfH7RLg7lshv8hCepSDet0mCXhi9q9xyVaBl96
         GyWw==
X-Gm-Message-State: AMke39kSNhLqGWoKp0gBNh3KZccybvFtdKhCzxsIfnLRC8tUdw0O9GtszaTwAiQSqEJaqQ==
X-Received: by 10.84.141.1 with SMTP id 1mr51767121plu.178.1489443804402;
        Mon, 13 Mar 2017 15:23:24 -0700 (PDT)
Received: from localhost.localdomain (216-71-194-243.dyn.novuscom.net. [216.71.194.243])
        by smtp.gmail.com with ESMTPSA id l3sm34762863pgn.10.2017.03.13.15.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 15:23:23 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     git@vger.kernel.org
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH/RFC V2] stash: implement builtin stash
Date:   Mon, 13 Mar 2017 15:23:18 -0700
Message-Id: <20170313222318.23312-1-joel@teichroeb.net>
X-Mailer: git-send-email 2.12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement all git stash functionality as a builtin command

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
I've been working on rewriting git stash as a c builtin and I have all
but three tests passing. I'm having a bit of trouble fixing them, as
well as a few other issues, so I'd really appreciate some help. Don't
bother commenting on the small details yet as I still need to go
though the code to make sure it matches the code style guidelines.

Test Summary Report
-------------------
t7601-merge-pull-config.sh                       (Wstat: 256 Tests: 14
Failed: 2)
  Failed tests:  11-12
  Non-zero exit status: 1
t3903-stash.sh                                   (Wstat: 256 Tests: 74
Failed: 1)
  Failed test:  69
  Non-zero exit status: 1

It looks to be the same issue for both of these cases where
merge-recursive reports:
error: Your local changes to the following files would be overwritten by merge:
        file
        other-file

which doesn't make sense as those files didn't exist before the merge.
Furthermore if I take the existing git stash implementation and have
it stop before running the merge-recursive command and then run it on
the commandline manually, I get the same issue. I've tried setting all
the same environment variables that the existing git stash
implementation does, but it doesn't help. It seems like there could be
a bug in merge-recursive, but I'm not sure how to track it down.

git stash uses the GIT_INDEX_FILE environment variable in order to not
trash the main index. I ended up doing things like this:

    discard_cache();
    ret = read_cache_from(index_path);
    write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL);
    discard_cache();
    ret = read_cache_from(index_path);

in order to have an empty cache. Could someone take a look at my uses
of the index and point out better ways to do it?

My main goal right now is replace as many of the cmd_* calls as
possible.

changes in v2:
* Better follow coding guidelines
* Improve error handling

 Makefile          |    2 +-
 builtin.h         |    1 +
 builtin/stash.c   | 1266 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh      |  731 -------------------------------
 git.c             |    1 +
 merge-recursive.c |    5 +-
 6 files changed, 1271 insertions(+), 735 deletions(-)
 create mode 100644 builtin/stash.c
 delete mode 100755 git-stash.sh

diff --git a/Makefile b/Makefile
index ba524f3a7..73915a2e0 100644
--- a/Makefile
+++ b/Makefile
@@ -516,7 +516,6 @@ SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
-SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
@@ -949,6 +948,7 @@ BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/stash.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
diff --git a/builtin.h b/builtin.h
index 9e4a89816..16e8a437d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -121,6 +121,7 @@ extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
+extern int cmd_stash(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/builtin/stash.c b/builtin/stash.c
new file mode 100644
index 000000000..785fc18d5
--- /dev/null
+++ b/builtin/stash.c
@@ -0,0 +1,1266 @@
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
+
+struct stash_info {
+	unsigned char w_commit[20];
+	unsigned char b_commit[20];
+	unsigned char i_commit[20];
+	unsigned char u_commit[20];
+	unsigned char w_tree[20];
+	unsigned char b_tree[20];
+	unsigned char i_tree[20];
+	unsigned char u_tree[20];
+	const char *message;
+	const char *REV;
+	int is_stash_ref;
+	int has_u;
+	const char *patch;
+};
+
+int untracked_files(struct strbuf *out, int include_untracked,
+		const char **argv)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	cp.git_cmd = 1;
+	argv_array_push(&cp.args, "ls-files");
+	argv_array_push(&cp.args, "-o");
+	argv_array_push(&cp.args, "-z");
+	if (include_untracked != 2) {
+		argv_array_push(&cp.args, "--exclude-standard");
+	}
+	if (argv) {
+		argv_array_push(&cp.args, "--");
+		argv_array_pushv(&cp.args, argv);
+	}
+	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
+}
+
+static int check_no_changes(const char *prefix, int include_untracked,
+		const char **argv)
+{
+	struct argv_array args1;
+	struct argv_array args2;
+	struct strbuf out = STRBUF_INIT;
+
+	argv_array_init(&args1);
+	argv_array_push(&args1, "diff-index");
+	argv_array_push(&args1, "--quiet");
+	argv_array_push(&args1, "--cached");
+	argv_array_push(&args1, "HEAD");
+	argv_array_push(&args1, "--ignore-submodules");
+	argv_array_push(&args1, "--");
+	if (argv) {
+		argv_array_pushv(&args1, argv);
+	}
+	argv_array_init(&args2);
+	argv_array_push(&args2, "diff-files");
+	argv_array_push(&args2, "--quiet");
+	argv_array_push(&args2, "--ignore-submodules");
+	if (argv) {
+		argv_array_push(&args2, "--");
+		argv_array_pushv(&args2, argv);
+	}
+	if (include_untracked) {
+		untracked_files(&out, include_untracked, argv);
+	}
+	return cmd_diff_index(args1.argc, args1.argv, prefix) == 0 &&
+			cmd_diff_files(args2.argc, args2.argv, prefix) == 0 &&
+			(!include_untracked || out.len == 0);
+}
+
+static int get_stash_info(struct stash_info *info, const char *commit)
+{
+	struct strbuf w_commit_rev = STRBUF_INIT;
+	struct strbuf b_commit_rev = STRBUF_INIT;
+	struct strbuf i_commit_rev = STRBUF_INIT;
+	struct strbuf u_commit_rev = STRBUF_INIT;
+	struct strbuf w_tree_rev = STRBUF_INIT;
+	struct strbuf b_tree_rev = STRBUF_INIT;
+	struct strbuf i_tree_rev = STRBUF_INIT;
+	struct strbuf u_tree_rev = STRBUF_INIT;
+	struct strbuf commit_buf = STRBUF_INIT;
+	struct object_context unused;
+	int ret;
+	const char *REV = commit;
+	info->is_stash_ref = 0;
+
+	if (commit == NULL) {
+		strbuf_addf(&commit_buf, "%s@{0}", ref_stash);
+		REV = commit_buf.buf;
+	} else if (strlen(commit) < 3) {
+		strbuf_addf(&commit_buf, "%s@{%s}", ref_stash, commit);
+		REV = commit_buf.buf;
+	}
+	info->REV = REV;
+
+	strbuf_addf(&w_commit_rev, "%s", REV);
+	strbuf_addf(&b_commit_rev, "%s^1", REV);
+	strbuf_addf(&i_commit_rev, "%s^2", REV);
+	strbuf_addf(&u_commit_rev, "%s^3", REV);
+	strbuf_addf(&w_tree_rev, "%s:", REV);
+	strbuf_addf(&b_tree_rev, "%s^1:", REV);
+	strbuf_addf(&i_tree_rev, "%s^2:", REV);
+	strbuf_addf(&u_tree_rev, "%s^3:", REV);
+
+
+	ret = (
+		get_sha1_with_context(w_commit_rev.buf, 0, info->w_commit, &unused) == 0 &&
+		get_sha1_with_context(b_commit_rev.buf, 0, info->b_commit, &unused) == 0 &&
+		get_sha1_with_context(i_commit_rev.buf, 0, info->i_commit, &unused) == 0 &&
+		get_sha1_with_context(w_tree_rev.buf, 0, info->w_tree, &unused) == 0 &&
+		get_sha1_with_context(b_tree_rev.buf, 0, info->b_tree, &unused) == 0 &&
+		get_sha1_with_context(i_tree_rev.buf, 0, info->i_tree, &unused) == 0);
+
+	info->has_u = get_sha1_with_context(u_commit_rev.buf, 0, info->u_commit, &unused) == 0 &&
+	get_sha1_with_context(u_tree_rev.buf, 0, info->u_tree, &unused) == 0;
+
+	// TODO: Properly check for stash refs
+	info->is_stash_ref = REV[4] == '/';
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
+
+	}
+}
+
+/* Untracked files are stored by themselves in a parentless commit, for
+ * ease of unpacking later.
+ */
+static int save_untracked(struct stash_info *info, struct strbuf *out,
+		int include_untracked, const char **argv)
+{
+	struct child_process cp2 = CHILD_PROCESS_INIT;
+	struct child_process cp3 = CHILD_PROCESS_INIT;
+	struct strbuf out3 = STRBUF_INIT;
+	struct strbuf out4 = STRBUF_INIT;
+	struct object_id orig_tree;
+	const char *index_path = ".git/foocache1";
+
+	set_alternate_index_output(index_path);
+	untracked_files(&out4, include_untracked, argv);
+
+	cp2.git_cmd = 1;
+	argv_array_push(&cp2.args, "update-index");
+	argv_array_push(&cp2.args, "-z");
+	argv_array_push(&cp2.args, "--add");
+	argv_array_push(&cp2.args, "--remove");
+	argv_array_push(&cp2.args, "--stdin");
+	argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s", index_path);
+
+	if (pipe_command(&cp2, out4.buf, out4.len, NULL, 0, NULL, 0))
+		return -1;
+
+	discard_cache();
+	read_cache_from(index_path);
+
+	write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL);
+	discard_cache();
+
+	read_cache_from(index_path);
+
+	write_cache_as_tree(info->u_tree, 0, NULL);
+	strbuf_addf(&out3, "untracked files on %s", out->buf);
+
+	if (commit_tree(out3.buf, out3.len, info->u_tree, NULL, info->u_commit, NULL, NULL))
+		return -1;
+
+	set_alternate_index_output(".git/index");
+	discard_cache();
+	read_cache();
+
+	argv_array_push(&cp3.args, "rm");
+	argv_array_push(&cp3.args, "-f");
+	argv_array_push(&cp3.args, index_path);
+	if (run_command(&cp3))
+		return -1;
+
+	return 0;
+}
+
+static int save_working_tree(struct stash_info *info, const char *prefix,
+		const char **argv)
+{
+	const char *index_path = ".git/foocache3";
+	struct object_id orig_tree;
+	struct rev_info rev;
+	int nr_trees = 1;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct tree *tree;
+	struct unpack_trees_options opts;
+	struct object *obj;
+
+	discard_cache();
+	tree = parse_tree_indirect(info->i_tree);
+	prime_cache_tree(&the_index, tree);
+	write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL);
+	discard_cache();
+
+	read_cache_from(index_path);
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
+		return -1;
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
+	obj = parse_object(info->b_commit);
+	add_pending_object(&rev, obj, "");
+	if (run_diff_index(&rev, 0))
+		return -1;
+
+	if (write_cache_as_tree(info->w_tree, 0, NULL))
+		return -1;
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
+	const char *index_path = ".git/foocache2";
+	struct argv_array args;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct child_process cp2 = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+
+	argv_array_init(&args);
+	argv_array_push(&args, "read-tree");
+	argv_array_push(&args, "HEAD");
+	argv_array_pushf(&args, "--index-output=%s", index_path);
+	cmd_read_tree(args.argc, args.argv, prefix);
+
+	cp2.git_cmd = 1;
+	argv_array_push(&cp2.args, "add--interactive");
+	argv_array_push(&cp2.args, "--patch=stash");
+	argv_array_push(&cp2.args, "--");
+	argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s", index_path);
+	if (run_command(&cp2))
+		return -1;
+
+	discard_cache();
+	read_cache_from(index_path);
+
+	if (write_cache_as_tree(info->w_tree, 0, NULL))
+		return -1;
+
+	cp.git_cmd = 1;
+	argv_array_push(&cp.args, "diff-tree");
+	argv_array_push(&cp.args, "-p");
+	argv_array_push(&cp.args, "HEAD");
+	argv_array_push(&cp.args, sha1_to_hex(info->w_tree));
+	argv_array_push(&cp.args, "--");
+	if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0) || out.len == 0)
+		return -1;
+
+	info->patch = out.buf;
+
+	set_alternate_index_output(".git/index");
+	discard_cache();
+	read_cache();
+
+	return 0;
+}
+
+static int do_create_stash(struct stash_info *info, const char *prefix,
+	const char *message, int include_untracked, int patch, const char **argv)
+{
+	struct object_id curr_head;
+	char *branch_path = NULL;
+	const char *branch_name = NULL;
+	struct commit_list *parents = NULL;
+	struct strbuf out = STRBUF_INIT;
+	struct pretty_print_context ctx = {0};
+
+	struct commit *c = NULL;
+	const char *hash;
+	struct strbuf out2 = STRBUF_INIT;
+
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
+	if (check_no_changes(prefix, include_untracked, argv))
+		return 0;
+
+	if (get_sha1_tree("HEAD", info->b_commit))
+		die(_("You do not have the initial commit yet"));
+
+	branch_path = resolve_refdup("HEAD", 0, curr_head.hash, NULL);
+
+	if (branch_path == NULL) {
+		branch_name = "(no_branch)";
+	} else {
+		skip_prefix(branch_path, "refs/heads/", &branch_name);
+	}
+
+	c = lookup_commit(info->b_commit);
+
+	ctx.output_encoding = get_log_output_encoding();
+	ctx.abbrev = 1;
+	ctx.fmt = CMIT_FMT_ONELINE;
+	hash = find_unique_abbrev(c->object.oid.hash, DEFAULT_ABBREV);
+
+	strbuf_addf(&out, "%s: %s ", branch_name, hash);
+
+	pretty_print_commit(&ctx, c, &out);
+
+
+	commit_list_insert(lookup_commit(info->b_commit), &parents);
+
+	if (write_cache_as_tree(info->i_tree, 0, NULL))
+		die(_("git write-tree failed to write a tree"));
+
+	if (commit_tree(out.buf, out.len, info->i_tree, parents, info->i_commit, NULL, NULL))
+		die(_("Cannot save the current index state"));
+
+
+	if (include_untracked) {
+		if (save_untracked(info, &out, include_untracked, argv))
+			die(_("Cannot save the untracked files"));
+	}
+
+
+	if (patch) {
+		if (patch_working_tree(info, prefix, argv))
+			die(_("Cannot save the current worktree state"));
+	} else {
+		if (save_working_tree(info, prefix, argv))
+			die(_("Cannot save the current worktree state"));
+	}
+	parents = NULL;
+
+	if (include_untracked) {
+		commit_list_insert(lookup_commit(info->u_commit), &parents);
+	}
+
+	commit_list_insert(lookup_commit(info->i_commit), &parents);
+	commit_list_insert(lookup_commit(info->b_commit), &parents);
+
+	if (message != NULL && strlen(message) != 0) {
+		strbuf_addf(&out2, "On %s: %s", branch_name, message);
+	} else {
+		strbuf_addf(&out2, "WIP on %s", out.buf);
+	}
+
+	if (commit_tree(out2.buf, out2.len, info->w_tree, parents, info->w_commit, NULL, NULL))
+		die(_("Cannot record working tree state"));
+
+	info->message = out2.buf;
+
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
+	struct option options[] = {
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			 N_("stash untracked filed")),
+		OPT_STRING('m', "message", &message, N_("message"),
+			 N_("stash commit message")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+				 git_stash_create_usage, 0);
+
+	if (argc != 0) {
+		struct strbuf out = STRBUF_INIT;
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
+
+	if (do_create_stash(&info, prefix, message, include_untracked, 0, NULL))
+		return -1;
+
+	printf("%s\n", sha1_to_hex(info.w_commit));
+	return 0;
+}
+
+static int do_store_stash(const char *prefix, int quiet, const char *message,
+		unsigned char sha1_commit[20])
+{
+	int ret;
+	ret = update_ref(message, ref_stash, sha1_commit, NULL,
+			REF_FORCE_CREATE_REFLOG, UPDATE_REFS_DIE_ON_ERR);
+
+	if (ret != 0 && !quiet)
+		die(_("Cannot update %s with %s"), ref_stash, sha1_to_hex(sha1_commit));
+
+	return ret;
+}
+
+static int store_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *message = NULL;
+	const char *commit = NULL;
+	unsigned char sha1[20];
+	struct option options[] = {
+		OPT_STRING('m', "message", &message, N_("message"),
+			 N_("stash commit message")),
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, prefix, options,
+				 git_stash_store_usage, 0);
+
+	if (message == NULL) {
+		message = "Create via \"git stash store\".";
+	}
+
+	if (argc != 1)
+		die(_("\"git stash store\" requires one <commit> argument"));
+
+	commit = argv[0];
+
+	if (get_sha1(commit, sha1)) {
+		die("%s: not a valid SHA1", commit);
+	}
+
+	return do_store_stash(prefix, quiet, message, sha1);
+}
+
+static int do_clear_stash(void)
+{
+	unsigned char sha1[20];
+	struct object_context unused;
+	if (get_sha1_with_context(ref_stash, 0, sha1, &unused))
+		return 0;
+
+	return delete_ref(NULL, ref_stash, sha1, 0);
+}
+
+static int clear_stash(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+				 git_stash_clear_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc != 0)
+		die(_("git stash clear with parameters is unimplemented"));
+
+	return do_clear_stash();
+}
+
+static int reset_tree(unsigned char i_tree[20], int update, int reset)
+{
+	struct unpack_trees_options opts;
+	int nr_trees = 1;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct tree *tree;
+
+	if (refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL))
+		return -1;
+
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+
+	memset(&opts, 0, sizeof(opts));
+
+	tree = parse_tree_indirect(i_tree);
+	if (parse_tree(tree))
+		return -1;
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
+		return -1;
+
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK)) {
+		error(_("unable to write new index file"));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int do_push_stash(const char *prefix, const char *message,
+		int keep_index, int include_untracked, int patch, const char **argv)
+{
+	int result;
+	struct stash_info info;
+
+	if (patch && include_untracked)
+		die(_("Can't use --patch and --include-untracked or --all at the same time"));
+
+	if (!include_untracked) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf out = STRBUF_INIT;
+
+		cp.git_cmd = 1;
+		argv_array_push(&cp.args, "ls-files");
+		argv_array_push(&cp.args, "--error-unmatch");
+		if (argv) {
+			argv_array_push(&cp.args, "--");
+			argv_array_pushv(&cp.args, argv);
+		}
+		result = pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
+		if (result != 0) {
+			die("TODO");
+		}
+	}
+
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
+	if (check_no_changes(prefix, include_untracked, argv)) {
+		printf(_("No local changes to save\n"));
+		return 0;
+	}
+
+	if (!reflog_exists(ref_stash)) {
+		if (do_clear_stash())
+			die(_("Cannot initialize stash"));
+	}
+
+
+	do_create_stash(&info, prefix, message, include_untracked, patch, argv);
+	result = do_store_stash(prefix, 1, info.message, info.w_commit);
+
+	if (result == 0 && !quiet) {
+		printf(_("Saved working directory and index state %s\n"), info.message);
+	}
+
+	if (!patch) {
+		if (argv) {
+			struct argv_array args;
+			struct child_process cp = CHILD_PROCESS_INIT;
+			struct child_process cp2 = CHILD_PROCESS_INIT;
+			struct strbuf out = STRBUF_INIT;
+			argv_array_init(&args);
+			argv_array_push(&args, "reset");
+			argv_array_push(&args, "--");
+			argv_array_pushv(&args, argv);
+			cmd_reset(args.argc, args.argv, prefix);
+
+
+			cp.git_cmd = 1;
+			argv_array_push(&cp.args, "ls-files");
+			argv_array_push(&cp.args, "-z");
+			argv_array_push(&cp.args, "--modified");
+			argv_array_push(&cp.args, "--");
+			argv_array_pushv(&cp.args, argv);
+			pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
+
+			cp2.git_cmd = 1;
+			argv_array_push(&cp2.args, "checkout-index");
+			argv_array_push(&cp2.args, "-z");
+			argv_array_push(&cp2.args, "--force");
+			argv_array_push(&cp2.args, "--stdin");
+			pipe_command(&cp2, out.buf, out.len, NULL, 0, NULL, 0);
+
+			argv_array_init(&args);
+			argv_array_push(&args, "clean");
+			argv_array_push(&args, "--force");
+			argv_array_push(&args, "-d");
+			argv_array_push(&args, "--");
+			argv_array_pushv(&args, argv);
+			cmd_clean(args.argc, args.argv, prefix);
+		} else {
+			struct argv_array args;
+			argv_array_init(&args);
+			argv_array_push(&args, "reset");
+			argv_array_push(&args, "--hard");
+			if (quiet) {
+				argv_array_push(&args, "--quiet");
+			}
+			cmd_reset(args.argc, args.argv, prefix);
+		}
+
+		if (include_untracked) {
+			struct argv_array args;
+			argv_array_init(&args);
+			argv_array_push(&args, "clean");
+			argv_array_push(&args, "--force");
+			argv_array_push(&args, "--quiet");
+			argv_array_push(&args, "-d");
+			if (include_untracked == 2) {
+				argv_array_push(&args, "-x");
+			}
+			if (argv) {
+				argv_array_push(&args, "--");
+				argv_array_pushv(&args, argv);
+			}
+			cmd_clean(args.argc, args.argv, prefix);
+		}
+
+		if (keep_index) {
+			reset_tree(info.i_tree, 1, 1);
+		}
+	} else {
+		struct child_process cp2 = CHILD_PROCESS_INIT;
+		cp2.git_cmd = 1;
+		argv_array_push(&cp2.args, "apply");
+		argv_array_push(&cp2.args, "-R");
+		if (pipe_command(&cp2, info.patch, strlen(info.patch), NULL, 0, NULL, 0))
+			die(_("Cannot remove worktree changes"));
+
+		if (!keep_index) {
+			struct argv_array args;
+			argv_array_init(&args);
+			argv_array_push(&args, "reset");
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
+	int all = 0;
+	int patch = 0;
+	int keep_index_set = -1;
+	int keep_index = 0;
+	const char **args = NULL;
+	struct option options[] = {
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			 N_("stash untracked filed")),
+		OPT_BOOL('a', "all", &all,
+			 N_("stash ignored untracked files")),
+		OPT_BOOL('k', "keep-index", &keep_index_set,
+			 N_("restore the index after applying the stash")),
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_STRING('m', "message", &message, N_("message"),
+			 N_("stash commit message")),
+		OPT_BOOL('p', "patch", &patch,
+			 N_("edit current diff and apply")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+				 git_stash_save_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (all) {
+		include_untracked = 2;
+	}
+
+	if (keep_index_set != -1) {
+		keep_index = keep_index_set;
+	} else if (patch) {
+		keep_index = 1;
+	}
+
+	if (argc != 0) {
+		args = argv;
+	}
+
+	return do_push_stash(prefix, message, keep_index, include_untracked, patch, args);
+}
+
+static int save_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *message = NULL;
+	int include_untracked = 0;
+	int all = 0;
+	int patch = 0;
+	int keep_index_set = -1;
+	int keep_index = 0;
+	struct option options[] = {
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			 N_("stash untracked filed")),
+		OPT_BOOL('a', "all", &all,
+			 N_("stash ignored untracked files")),
+		OPT_BOOL('k', "keep-index", &keep_index_set,
+			 N_("restore the index after applying the stash")),
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_STRING('m', "message", &message, N_("message"),
+			 N_("stash commit message")),
+		OPT_BOOL('p', "patch", &patch,
+			 N_("edit current diff and apply")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+				 git_stash_save_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (all) {
+		include_untracked = 2;
+	}
+
+	if (keep_index_set != -1) {
+		keep_index = keep_index_set;
+	} else if (patch) {
+		keep_index = 1;
+	}
+
+	if (argc != 0) {
+		struct strbuf out = STRBUF_INIT;
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
+	return do_push_stash(prefix, message, keep_index, include_untracked, patch, NULL);
+}
+
+static int do_apply_stash(const char *prefix, struct stash_info *info, int index)
+{
+	struct object_id h1, h2, btree;
+	struct merge_options o;
+	unsigned char c_tree[20];
+	unsigned char index_tree[20];
+	const struct object_id *bases[1];
+	int bases_count = 1;
+	struct commit *result;
+	int ret;
+
+	if (refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL))
+		return -1;
+
+	if (write_cache_as_tree(c_tree, 0, NULL))
+		return -1;
+
+	if (index) {
+		if (hashcmp(info->b_tree, info->i_tree) == 0 || hashcmp(c_tree, info->i_tree) == 0) {
+			index = 0;
+		} else {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			struct child_process cp2 = CHILD_PROCESS_INIT;
+			struct strbuf out = STRBUF_INIT;
+			struct argv_array args;
+			cp.git_cmd = 1;
+			argv_array_push(&cp.args, "diff-tree");
+			argv_array_push(&cp.args, "--binary");
+			argv_array_pushf(&cp.args, "%s^2^..%s^2", sha1_to_hex(info->w_commit), sha1_to_hex(info->w_commit));
+			pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
+
+			cp2.git_cmd = 1;
+			argv_array_push(&cp2.args, "apply");
+			argv_array_push(&cp2.args, "--cached");
+			pipe_command(&cp2, out.buf, out.len, NULL, 0, NULL, 0);
+
+			discard_cache();
+			read_cache();
+			if (write_cache_as_tree(index_tree, 0, NULL))
+				return -1;
+
+			argv_array_init(&args);
+			argv_array_push(&args, "reset");
+			cmd_reset(args.argc, args.argv, prefix);
+		}
+	}
+
+	if (info->has_u) {
+		struct argv_array args;
+		struct child_process cp2 = CHILD_PROCESS_INIT;
+		const char *index_path = ".git/foocache4";
+
+		argv_array_init(&args);
+		argv_array_push(&args, "read-tree");
+		argv_array_push(&args, sha1_to_hex(info->u_tree));
+		argv_array_pushf(&args, "--index-output=%s", index_path);
+
+
+		cp2.git_cmd = 1;
+		argv_array_push(&cp2.args, "checkout-index");
+		argv_array_push(&cp2.args, "--all");
+		argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s", index_path);
+
+		if (cmd_read_tree(args.argc, args.argv, prefix) ||
+			run_command(&cp2)) {
+			die(_("Could not restore untracked files from stash"));
+		}
+		set_alternate_index_output(".git/index");
+	}
+
+
+	init_merge_options(&o);
+
+	o.branch1 = sha1_to_hex(c_tree);
+	o.branch2 = sha1_to_hex(info->w_tree);
+
+	if (get_oid(o.branch1, &h1))
+		die(_("could not resolve ref '%s'"), o.branch1);
+	if (get_oid(o.branch2, &h2))
+		die(_("could not resolve ref '%s'"), o.branch2);
+
+	o.branch1 = "Updated upstream";
+	o.branch2 = "Stashed changes";
+
+	if (hashcmp(info->b_tree, c_tree) == 0)
+		o.branch1 = "Version stash was based on";
+
+	if (quiet)
+		o.verbosity = 0;
+
+	if (o.verbosity >= 3)
+		printf(_("Merging %s with %s\n"), o.branch1, o.branch2);
+
+	get_oid(sha1_to_hex(info->b_tree), &btree);
+	bases[0] = &btree;
+
+	ret = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, &result);
+	if (ret != 0) {
+		struct argv_array args;
+		argv_array_init(&args);
+		argv_array_push(&args, "rerere");
+		cmd_rerere(args.argc, args.argv, prefix);
+
+		return ret;
+	}
+
+	if (index) {
+		ret = reset_tree(index_tree, 0, 0);
+	} else {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct child_process cp2 = CHILD_PROCESS_INIT;
+		struct strbuf out = STRBUF_INIT;
+		cp.git_cmd = 1;
+		argv_array_push(&cp.args, "diff-index");
+		argv_array_push(&cp.args, "--cached");
+		argv_array_push(&cp.args, "--name-only");
+		argv_array_push(&cp.args, "--diff-filter=A");
+		argv_array_push(&cp.args, sha1_to_hex(c_tree));
+		ret = pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
+
+		ret = reset_tree(c_tree, 0, 1);
+
+		cp2.git_cmd = 1;
+		argv_array_push(&cp2.args, "update-index");
+		argv_array_push(&cp2.args, "--add");
+		argv_array_push(&cp2.args, "--stdin");
+		ret = pipe_command(&cp2, out.buf, out.len, NULL, 0, NULL, 0);
+		discard_cache();
+		read_cache();
+	}
+
+	if (!quiet) {
+		struct argv_array args;
+		argv_array_init(&args);
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
+	int ret;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			 N_("attempt to ininstate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+				 git_stash_apply_usage, 0);
+
+	if (argc == 1) {
+		commit = argv[0];
+	}
+
+	ret = get_stash_info(&info, commit);
+	if (ret) {
+		die("invalid");
+	}
+
+	return do_apply_stash(prefix, &info, index);
+}
+
+static int do_drop_stash(const char *prefix, struct stash_info *info)
+{
+	struct argv_array args;
+	int ret;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	argv_array_init(&args);
+	argv_array_push(&args, "reflog");
+	argv_array_push(&args, "delete");
+	argv_array_push(&args, "--updateref");
+	argv_array_push(&args, "--rewrite");
+	argv_array_push(&args, info->REV);
+	ret = cmd_reflog(args.argc, args.argv, prefix);
+	if (ret == 0) {
+		if (!quiet) {
+			printf(_("Dropped %s (%s)\n"), info->REV, sha1_to_hex(info->w_commit));
+		}
+	} else {
+		die(_("%s: Could not drop stash entry"), info->REV);
+	}
+
+	cp.git_cmd = 1;
+	/* Even though --quiet is specified, rev-parse still outputs the hash */
+	cp.no_stdout = 1;
+	argv_array_init(&cp.args);
+	argv_array_push(&cp.args, "rev-parse");
+	argv_array_push(&cp.args, "--verify");
+	argv_array_push(&cp.args, "--quiet");
+	argv_array_pushf(&cp.args, "%s@{0}", ref_stash);
+	ret = run_command(&cp);
+
+	if (ret != 0) {
+		do_clear_stash();
+	}
+	return 0;
+}
+
+static int drop_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *commit = NULL;
+	struct stash_info info;
+	int ret;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+				 git_stash_drop_usage, 0);
+
+	if (argc == 1) {
+		commit = argv[0];
+	}
+
+	ret = get_stash_info(&info, commit);
+	if (ret) {
+		die("invalid");
+	}
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
+	unsigned char sha1[20];
+	struct object_context unused;
+	struct argv_array args;
+
+	argc = parse_options(argc, argv, prefix, options,
+				 git_stash_list_usage, PARSE_OPT_KEEP_UNKNOWN);
+
+	if (get_sha1_with_context(ref_stash, 0, sha1, &unused))
+		return 0;
+
+	argv_array_init(&args);
+	argv_array_push(&args, "log");
+	argv_array_push(&args, "--format=%gd: %gs");
+	argv_array_push(&args, "-g");
+	argv_array_push(&args, "--first-parent");
+	argv_array_push(&args, "-m");
+	argv_array_pushv(&args, argv);
+	argv_array_push(&args, ref_stash);
+	if (cmd_log(args.argc, args.argv, prefix))
+		return -1;
+
+	return 0;
+}
+
+static int show_stash(int argc, const char **argv, const char *prefix)
+{
+	struct argv_array args;
+	struct stash_info info;
+	const char *commit = NULL;
+	int ret;
+	int numstat = 0;
+	int patch = 0;
+
+	struct option options[] = {
+		OPT_BOOL(0, "numstat", &numstat,
+			 N_("TODO??")),
+		OPT_BOOL('p', "patch", &patch,
+			 N_("TODO??")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+				 git_stash_show_usage, 0);
+
+	if (argc == 1) {
+		commit = argv[0];
+	}
+	ret = get_stash_info(&info, commit);
+	if (ret) {
+		die("invalid");
+	}
+	argv_array_init(&args);
+	argv_array_push(&args, "diff");
+	if (numstat) {
+		argv_array_push(&args, "--numstat");
+	} else if (patch) {
+		argv_array_push(&args, "-p");
+	} else {
+		argv_array_push(&args, "--stat");
+	}
+	argv_array_push(&args, sha1_to_hex(info.b_commit));
+	argv_array_push(&args, sha1_to_hex(info.w_commit));
+	return cmd_diff(args.argc, args.argv, prefix);
+}
+
+static int pop_stash(int argc, const char **argv, const char *prefix)
+{
+	int index = 0;
+	int ret;
+	const char *commit = NULL;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			 N_("attempt to ininstate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+				 git_stash_pop_usage, 0);
+
+	if (argc == 1) {
+		commit = argv[0];
+	}
+
+	get_stash_info(&info, commit);
+	if (!info.is_stash_ref) {
+		return 1;
+	}
+
+	ret = do_apply_stash(prefix, &info, index);
+	if (ret != 0) {
+		return ret;
+	}
+	ret = do_drop_stash(prefix, &info);
+	return ret;
+}
+
+static int branch_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *commit = NULL, *branch = NULL;
+	int ret;
+	struct argv_array args;
+	struct stash_info info;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+				 git_stash_branch_usage, 0);
+
+	if (argc != 0) {
+		branch = argv[0];
+		if (argc == 2) {
+			commit = argv[1];
+		}
+	}
+
+	ret = get_stash_info(&info, commit);
+	if (ret) {
+		return ret;
+	}
+
+	argv_array_init(&args);
+	argv_array_push(&args, "checkout");
+	argv_array_push(&args, "-b");
+	argv_array_push(&args, branch);
+	argv_array_push(&args, sha1_to_hex(info.b_commit));
+	ret = cmd_checkout(args.argc, args.argv, prefix);
+
+	ret = do_apply_stash(prefix, &info, 1);
+	if (info.is_stash_ref) {
+		ret = do_drop_stash(prefix, &info);
+	}
+
+	return ret;
+}
+
+int cmd_stash(int argc, const char **argv, const char *prefix)
+{
+	int result = 0;
+
+	struct option options[] = {
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
+		PARSE_OPT_KEEP_UNKNOWN|PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc < 1) {
+		result = do_push_stash(NULL, prefix, 0, 0, 0, NULL);
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
+			struct argv_array args;
+			argv_array_init(&args);
+			argv_array_push(&args, "push");
+			argv_array_pushv(&args, argv);
+			result = push_stash(args.argc, args.argv, prefix);
+			if (result == 0) {
+				printf(_("To restore them type \"git stash apply\"\n"));
+			}
+		} else {
+			error(_("Unknown subcommand: %s"), argv[0]);
+			result = 1;
+		}
+	}
+
+	return result;
+}
diff --git a/git-stash.sh b/git-stash.sh
deleted file mode 100755
index 9c70662cc..000000000
--- a/git-stash.sh
+++ /dev/null
@@ -1,731 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2007, Nanako Shiraishi
-
-dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="list [<options>]
-   or: $dashless show [<stash>]
-   or: $dashless drop [-q|--quiet] [<stash>]
-   or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
-   or: $dashless branch <branchname> [<stash>]
-   or: $dashless save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		      [-u|--include-untracked] [-a|--all] [<message>]
-   or: $dashless [push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		       [-u|--include-untracked] [-a|--all] [-m <message>]
-		       [-- <pathspec>...]]
-   or: $dashless clear"
-
-SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
-START_DIR=$(pwd)
-. git-sh-setup
-require_work_tree
-cd_to_toplevel
-
-TMP="$GIT_DIR/.git-stash.$$"
-TMPindex=${GIT_INDEX_FILE-"$(git rev-parse --git-path index)"}.stash.$$
-trap 'rm -f "$TMP-"* "$TMPindex"' 0
-
-ref_stash=refs/stash
-
-if git config --get-colorbool color.interactive; then
-       help_color="$(git config --get-color color.interactive.help 'red bold')"
-       reset_color="$(git config --get-color '' reset)"
-else
-       help_color=
-       reset_color=
-fi
-
-no_changes () {
-	git diff-index --quiet --cached HEAD --ignore-submodules -- "$@" &&
-	git diff-files --quiet --ignore-submodules -- "$@" &&
-	(test -z "$untracked" || test -z "$(untracked_files)")
-}
-
-untracked_files () {
-	excl_opt=--exclude-standard
-	test "$untracked" = "all" && excl_opt=
-	git ls-files -o -z $excl_opt -- "$@"
-}
-
-clear_stash () {
-	if test $# != 0
-	then
-		die "$(gettext "git stash clear with parameters is unimplemented")"
-	fi
-	if current=$(git rev-parse --verify --quiet $ref_stash)
-	then
-		git update-ref -d $ref_stash $current
-	fi
-}
-
-create_stash () {
-	stash_msg=
-	untracked=
-	while test $# != 0
-	do
-		case "$1" in
-		-m|--message)
-			shift
-			stash_msg=${1?"BUG: create_stash () -m requires an argument"}
-			;;
-		-u|--include-untracked)
-			shift
-			untracked=${1?"BUG: create_stash () -u requires an argument"}
-			;;
-		--)
-			shift
-			break
-			;;
-		esac
-		shift
-	done
-
-	git update-index -q --refresh
-	if no_changes "$@"
-	then
-		exit 0
-	fi
-
-	# state of the base commit
-	if b_commit=$(git rev-parse --verify HEAD)
-	then
-		head=$(git rev-list --oneline -n 1 HEAD --)
-	else
-		die "$(gettext "You do not have the initial commit yet")"
-	fi
-
-	if branch=$(git symbolic-ref -q HEAD)
-	then
-		branch=${branch#refs/heads/}
-	else
-		branch='(no branch)'
-	fi
-	msg=$(printf '%s: %s' "$branch" "$head")
-
-	# state of the index
-	i_tree=$(git write-tree) &&
-	i_commit=$(printf 'index on %s\n' "$msg" |
-		git commit-tree $i_tree -p $b_commit) ||
-		die "$(gettext "Cannot save the current index state")"
-
-	if test -n "$untracked"
-	then
-		# Untracked files are stored by themselves in a parentless commit, for
-		# ease of unpacking later.
-		u_commit=$(
-			untracked_files "$@" | (
-				GIT_INDEX_FILE="$TMPindex" &&
-				export GIT_INDEX_FILE &&
-				rm -f "$TMPindex" &&
-				git update-index -z --add --remove --stdin &&
-				u_tree=$(git write-tree) &&
-				printf 'untracked files on %s\n' "$msg" | git commit-tree $u_tree  &&
-				rm -f "$TMPindex"
-		) ) || die "$(gettext "Cannot save the untracked files")"
-
-		untracked_commit_option="-p $u_commit";
-	else
-		untracked_commit_option=
-	fi
-
-	if test -z "$patch_mode"
-	then
-
-		# state of the working tree
-		w_tree=$( (
-			git read-tree --index-output="$TMPindex" -m $i_tree &&
-			GIT_INDEX_FILE="$TMPindex" &&
-			export GIT_INDEX_FILE &&
-			git diff-index --name-only -z HEAD -- "$@" >"$TMP-stagenames" &&
-			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
-			git write-tree &&
-			rm -f "$TMPindex"
-		) ) ||
-			die "$(gettext "Cannot save the current worktree state")"
-
-	else
-
-		rm -f "$TMP-index" &&
-		GIT_INDEX_FILE="$TMP-index" git read-tree HEAD &&
-
-		# find out what the user wants
-		GIT_INDEX_FILE="$TMP-index" \
-			git add--interactive --patch=stash -- "$@" &&
-
-		# state of the working tree
-		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
-		die "$(gettext "Cannot save the current worktree state")"
-
-		git diff-tree -p HEAD $w_tree -- >"$TMP-patch" &&
-		test -s "$TMP-patch" ||
-		die "$(gettext "No changes selected")"
-
-		rm -f "$TMP-index" ||
-		die "$(gettext "Cannot remove temporary index (can't happen)")"
-
-	fi
-
-	# create the stash
-	if test -z "$stash_msg"
-	then
-		stash_msg=$(printf 'WIP on %s' "$msg")
-	else
-		stash_msg=$(printf 'On %s: %s' "$branch" "$stash_msg")
-	fi
-	w_commit=$(printf '%s\n' "$stash_msg" |
-	git commit-tree $w_tree -p $b_commit -p $i_commit $untracked_commit_option) ||
-	die "$(gettext "Cannot record working tree state")"
-}
-
-store_stash () {
-	while test $# != 0
-	do
-		case "$1" in
-		-m|--message)
-			shift
-			stash_msg="$1"
-			;;
-		-q|--quiet)
-			quiet=t
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-	test $# = 1 ||
-	die "$(eval_gettext "\"$dashless store\" requires one <commit> argument")"
-
-	w_commit="$1"
-	if test -z "$stash_msg"
-	then
-		stash_msg="Created via \"git stash store\"."
-	fi
-
-	git update-ref --create-reflog -m "$stash_msg" $ref_stash $w_commit
-	ret=$?
-	test $ret != 0 && test -z "$quiet" &&
-	die "$(eval_gettext "Cannot update \$ref_stash with \$w_commit")"
-	return $ret
-}
-
-push_stash () {
-	keep_index=
-	patch_mode=
-	untracked=
-	stash_msg=
-	while test $# != 0
-	do
-		case "$1" in
-		-k|--keep-index)
-			keep_index=t
-			;;
-		--no-keep-index)
-			keep_index=n
-			;;
-		-p|--patch)
-			patch_mode=t
-			# only default to keep if we don't already have an override
-			test -z "$keep_index" && keep_index=t
-			;;
-		-q|--quiet)
-			GIT_QUIET=t
-			;;
-		-u|--include-untracked)
-			untracked=untracked
-			;;
-		-a|--all)
-			untracked=all
-			;;
-		-m|--message)
-			shift
-			test -z ${1+x} && usage
-			stash_msg=$1
-			;;
-		--help)
-			show_help
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			option="$1"
-			# TRANSLATORS: $option is an invalid option, like
-			# `--blah-blah'. The 7 spaces at the beginning of the
-			# second line correspond to "error: ". So you should line
-			# up the second line with however many characters the
-			# translation of "error: " takes in your language. E.g. in
-			# English this is:
-			#
-			#    $ git stash save --blah-blah 2>&1 | head -n 2
-			#    error: unknown option for 'stash save': --blah-blah
-			#           To provide a message, use git stash save -- '--blah-blah'
-			eval_gettextln "error: unknown option for 'stash save': \$option
-       To provide a message, use git stash save -- '\$option'"
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	if test -n "$patch_mode" && test -n "$untracked"
-	then
-		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
-	fi
-
-	test -n "$untracked" || git ls-files --error-unmatch -- "$@" >/dev/null || exit 1
-
-	git update-index -q --refresh
-	if no_changes "$@"
-	then
-		say "$(gettext "No local changes to save")"
-		exit 0
-	fi
-
-	git reflog exists $ref_stash ||
-		clear_stash || die "$(gettext "Cannot initialize stash")"
-
-	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
-	store_stash -m "$stash_msg" -q $w_commit ||
-	die "$(gettext "Cannot save the current status")"
-	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
-
-	if test -z "$patch_mode"
-	then
-		if test $# != 0
-		then
-			git reset ${GIT_QUIET:+-q} -- "$@"
-			git ls-files -z --modified -- "$@" |
-			git checkout-index -z --force --stdin
-			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
-		else
-			git reset --hard ${GIT_QUIET:+-q}
-		fi
-		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
-		if test -n "$untracked"
-		then
-			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
-		fi
-
-		if test "$keep_index" = "t" && test -n "$i_tree"
-		then
-			git read-tree --reset -u $i_tree
-		fi
-	else
-		git apply -R < "$TMP-patch" ||
-		die "$(gettext "Cannot remove worktree changes")"
-
-		if test "$keep_index" != "t"
-		then
-			git reset
-		fi
-	fi
-}
-
-save_stash () {
-	push_options=
-	while test $# != 0
-	do
-		case "$1" in
-		--)
-			shift
-			break
-			;;
-		-*)
-			# pass all options through to push_stash
-			push_options="$push_options $1"
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	stash_msg="$*"
-
-	if test -z "$stash_msg"
-	then
-		push_stash $push_options
-	else
-		push_stash $push_options -m "$stash_msg"
-	fi
-}
-
-have_stash () {
-	git rev-parse --verify --quiet $ref_stash >/dev/null
-}
-
-list_stash () {
-	have_stash || return 0
-	git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash --
-}
-
-show_stash () {
-	ALLOW_UNKNOWN_FLAGS=t
-	assert_stash_like "$@"
-
-	if test -z "$FLAGS"
-	then
-		if test "$(git config --bool stash.showStat || echo true)" = "true"
-		then
-			FLAGS=--stat
-		fi
-
-		if test "$(git config --bool stash.showPatch || echo false)" = "true"
-		then
-			FLAGS=${FLAGS}${FLAGS:+ }-p
-		fi
-
-		if test -z "$FLAGS"
-		then
-			return 0
-		fi
-	fi
-
-	git diff ${FLAGS} $b_commit $w_commit
-}
-
-show_help () {
-	exec git help stash
-	exit 1
-}
-
-#
-# Parses the remaining options looking for flags and
-# at most one revision defaulting to ${ref_stash}@{0}
-# if none found.
-#
-# Derives related tree and commit objects from the
-# revision, if one is found.
-#
-# stash records the work tree, and is a merge between the
-# base commit (first parent) and the index tree (second parent).
-#
-#   REV is set to the symbolic version of the specified stash-like commit
-#   IS_STASH_LIKE is non-blank if ${REV} looks like a stash
-#   IS_STASH_REF is non-blank if the ${REV} looks like a stash ref
-#   s is set to the SHA1 of the stash commit
-#   w_commit is set to the commit containing the working tree
-#   b_commit is set to the base commit
-#   i_commit is set to the commit containing the index tree
-#   u_commit is set to the commit containing the untracked files tree
-#   w_tree is set to the working tree
-#   b_tree is set to the base tree
-#   i_tree is set to the index tree
-#   u_tree is set to the untracked files tree
-#
-#   GIT_QUIET is set to t if -q is specified
-#   INDEX_OPTION is set to --index if --index is specified.
-#   FLAGS is set to the remaining flags (if allowed)
-#
-# dies if:
-#   * too many revisions specified
-#   * no revision is specified and there is no stash stack
-#   * a revision is specified which cannot be resolve to a SHA1
-#   * a non-existent stash reference is specified
-#   * unknown flags were set and ALLOW_UNKNOWN_FLAGS is not "t"
-#
-
-parse_flags_and_rev()
-{
-	test "$PARSE_CACHE" = "$*" && return 0 # optimisation
-	PARSE_CACHE="$*"
-
-	IS_STASH_LIKE=
-	IS_STASH_REF=
-	INDEX_OPTION=
-	s=
-	w_commit=
-	b_commit=
-	i_commit=
-	u_commit=
-	w_tree=
-	b_tree=
-	i_tree=
-	u_tree=
-
-	FLAGS=
-	REV=
-	for opt
-	do
-		case "$opt" in
-			-q|--quiet)
-				GIT_QUIET=-t
-			;;
-			--index)
-				INDEX_OPTION=--index
-			;;
-			--help)
-				show_help
-			;;
-			-*)
-				test "$ALLOW_UNKNOWN_FLAGS" = t ||
-					die "$(eval_gettext "unknown option: \$opt")"
-				FLAGS="${FLAGS}${FLAGS:+ }$opt"
-			;;
-			*)
-				REV="${REV}${REV:+ }'$opt'"
-			;;
-		esac
-	done
-
-	eval set -- $REV
-
-	case $# in
-		0)
-			have_stash || die "$(gettext "No stash found.")"
-			set -- ${ref_stash}@{0}
-		;;
-		1)
-			:
-		;;
-		*)
-			die "$(eval_gettext "Too many revisions specified: \$REV")"
-		;;
-	esac
-
-	case "$1" in
-		*[!0-9]*)
-			:
-		;;
-		*)
-			set -- "${ref_stash}@{$1}"
-		;;
-	esac
-
-	REV=$(git rev-parse --symbolic --verify --quiet "$1") || {
-		reference="$1"
-		die "$(eval_gettext "\$reference is not a valid reference")"
-	}
-
-	i_commit=$(git rev-parse --verify --quiet "$REV^2") &&
-	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" 2>/dev/null) &&
-	s=$1 &&
-	w_commit=$1 &&
-	b_commit=$2 &&
-	w_tree=$3 &&
-	b_tree=$4 &&
-	i_tree=$5 &&
-	IS_STASH_LIKE=t &&
-	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
-	IS_STASH_REF=t
-
-	u_commit=$(git rev-parse --verify --quiet "$REV^3") &&
-	u_tree=$(git rev-parse "$REV^3:" 2>/dev/null)
-}
-
-is_stash_like()
-{
-	parse_flags_and_rev "$@"
-	test -n "$IS_STASH_LIKE"
-}
-
-assert_stash_like() {
-	is_stash_like "$@" || {
-		args="$*"
-		die "$(eval_gettext "'\$args' is not a stash-like commit")"
-	}
-}
-
-is_stash_ref() {
-	is_stash_like "$@" && test -n "$IS_STASH_REF"
-}
-
-assert_stash_ref() {
-	is_stash_ref "$@" || {
-		args="$*"
-		die "$(eval_gettext "'\$args' is not a stash reference")"
-	}
-}
-
-apply_stash () {
-
-	assert_stash_like "$@"
-
-	git update-index -q --refresh || die "$(gettext "unable to refresh index")"
-
-	# current index state
-	c_tree=$(git write-tree) ||
-		die "$(gettext "Cannot apply a stash in the middle of a merge")"
-
-	unstashed_index_tree=
-	if test -n "$INDEX_OPTION" && test "$b_tree" != "$i_tree" &&
-			test "$c_tree" != "$i_tree"
-	then
-		git diff-tree --binary $s^2^..$s^2 | git apply --cached
-		test $? -ne 0 &&
-			die "$(gettext "Conflicts in index. Try without --index.")"
-		unstashed_index_tree=$(git write-tree) ||
-			die "$(gettext "Could not save index tree")"
-		git reset
-	fi
-
-	if test -n "$u_tree"
-	then
-		GIT_INDEX_FILE="$TMPindex" git-read-tree "$u_tree" &&
-		GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
-		rm -f "$TMPindex" ||
-		die "$(gettext "Could not restore untracked files from stash")"
-	fi
-
-	eval "
-		GITHEAD_$w_tree='Stashed changes' &&
-		GITHEAD_$c_tree='Updated upstream' &&
-		GITHEAD_$b_tree='Version stash was based on' &&
-		export GITHEAD_$w_tree GITHEAD_$c_tree GITHEAD_$b_tree
-	"
-
-	if test -n "$GIT_QUIET"
-	then
-		GIT_MERGE_VERBOSITY=0 && export GIT_MERGE_VERBOSITY
-	fi
-	if git merge-recursive $b_tree -- $c_tree $w_tree
-	then
-		# No conflict
-		if test -n "$unstashed_index_tree"
-		then
-			git read-tree "$unstashed_index_tree"
-		else
-			a="$TMP-added" &&
-			git diff-index --cached --name-only --diff-filter=A $c_tree >"$a" &&
-			git read-tree --reset $c_tree &&
-			git update-index --add --stdin <"$a" ||
-				die "$(gettext "Cannot unstage modified files")"
-			rm -f "$a"
-		fi
-		squelch=
-		if test -n "$GIT_QUIET"
-		then
-			squelch='>/dev/null 2>&1'
-		fi
-		(cd "$START_DIR" && eval "git status $squelch") || :
-	else
-		# Merge conflict; keep the exit status from merge-recursive
-		status=$?
-		git rerere
-		if test -n "$INDEX_OPTION"
-		then
-			gettextln "Index was not unstashed." >&2
-		fi
-		exit $status
-	fi
-}
-
-pop_stash() {
-	assert_stash_ref "$@"
-
-	if apply_stash "$@"
-	then
-		drop_stash "$@"
-	else
-		status=$?
-		say "$(gettext "The stash is kept in case you need it again.")"
-		exit $status
-	fi
-}
-
-drop_stash () {
-	assert_stash_ref "$@"
-
-	git reflog delete --updateref --rewrite "${REV}" &&
-		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
-		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
-
-	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
-	clear_stash
-}
-
-apply_to_branch () {
-	test -n "$1" || die "$(gettext "No branch name specified")"
-	branch=$1
-	shift 1
-
-	set -- --index "$@"
-	assert_stash_like "$@"
-
-	git checkout -b $branch $REV^ &&
-	apply_stash "$@" && {
-		test -z "$IS_STASH_REF" || drop_stash "$@"
-	}
-}
-
-test "$1" = "-p" && set "push" "$@"
-
-PARSE_CACHE='--not-parsed'
-# The default command is "push" if nothing but options are given
-seen_non_option=
-for opt
-do
-	case "$opt" in
-	--) break ;;
-	-*) ;;
-	*) seen_non_option=t; break ;;
-	esac
-done
-
-test -n "$seen_non_option" || set "push" "$@"
-
-# Main command set
-case "$1" in
-list)
-	shift
-	list_stash "$@"
-	;;
-show)
-	shift
-	show_stash "$@"
-	;;
-save)
-	shift
-	save_stash "$@"
-	;;
-push)
-	shift
-	push_stash "$@"
-	;;
-apply)
-	shift
-	apply_stash "$@"
-	;;
-clear)
-	shift
-	clear_stash "$@"
-	;;
-create)
-	shift
-	create_stash -m "$*" && echo "$w_commit"
-	;;
-store)
-	shift
-	store_stash "$@"
-	;;
-drop)
-	shift
-	drop_stash "$@"
-	;;
-pop)
-	shift
-	pop_stash "$@"
-	;;
-branch)
-	shift
-	apply_to_branch "$@"
-	;;
-*)
-	case $# in
-	0)
-		push_stash &&
-		say "$(gettext "(To restore them type \"git stash apply\")")"
-		;;
-	*)
-		usage
-	esac
-	;;
-esac
diff --git a/git.c b/git.c
index 33f52acbc..2b8a69a42 100644
--- a/git.c
+++ b/git.c
@@ -493,6 +493,7 @@ static struct cmd_struct commands[] = {
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
diff --git a/merge-recursive.c b/merge-recursive.c
index 62decd51c..4502e649d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2145,9 +2145,8 @@ int merge_recursive_generic(struct merge_options *o,
 	if (clean < 0)
 		return clean;
 
-	if (active_cache_changed &&
-	    write_locked_index(&the_index, lock, COMMIT_LOCK))
-		return err(o, _("Unable to write index."));
+	    if (write_locked_index(&the_index, lock, COMMIT_LOCK))
+			return err(o, _("Unable to write index."));
 
 	return clean ? 0 : 1;
 }
-- 
2.12.0

