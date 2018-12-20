Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5F71F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389399AbeLTTpE (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:04 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:50999 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731483AbeLTTpC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:02 -0500
Received: by mail-wm1-f50.google.com with SMTP id n190so3259211wmd.0
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5437Q2Sp7n0f1v5a6KFtGIlUK8YGWfwoQL1NFPYIFL4=;
        b=lMLAlBQ5PiNAc/UBrhSh63xUjknT3QfDe3oqxvtxwPCYhPhMd/Fmml0CYZdCqXBW22
         YQmRdT/6dRUUnqB9eBK0OQZBv1OLhCX+ySMRODVsQKGYZaKDc/z8fvQqrhE/qfqcUC2v
         0UQ5d0tPWBfvcnbVbIx7+X22ia80shXuag4miD7DWNPMYz4LLgaTCzOwAhmxxOaosF5W
         PYuCOhLJgr7uai7BrEcrfeB+SyJr+kkar7ZW85Vg6RUbXTojKVusopaaHx4Kv6rJxLEl
         QEH4c9l1B2MdBVT7X6+lmMNSQgqkSF2SM7ZZQ6zsdCMTmUAz/gxAK/LmGAPX+nIL1qOf
         XO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5437Q2Sp7n0f1v5a6KFtGIlUK8YGWfwoQL1NFPYIFL4=;
        b=bxIblTECsseEegfABId4s+e6HwOuYD58Z8yk+gat2KEFPVeKhJcUsz6MXnsbHpXdtz
         8T1kCiql7TFk+lGWh+Nj7PjSI30LTvdzEBDQMhu5Gq13z6E1tCOZRwHVFhup2lKdPJOE
         V6rfR2EglLwtXhsadKDDamQvIWOa570cTUJzAvwZV0Z1mZco2i2H0ey990EnA32XG8q/
         xIm/S5jFygdLHgFaw0MdZN9al5kAyUrGcCuqjdGvWRCazEXaGkuNElV9wwjMdceALY8/
         01y+zNOrLZ8BgZJe51Foy7BQXL8nc0HmKhBj4wFGhYeZT+t30yRNY3kuzg9nwK3t26tG
         5oOA==
X-Gm-Message-State: AA+aEWZi4YcWbAdEH/0EnFJNuFuLFowr7kaHykA5PGUbcvDgWLOqO+LU
        RD6/OQftHQvkvSdVtGRczmsv4JVbuMI=
X-Google-Smtp-Source: AFSGD/Vde62RlTkORwD+MeUlVMt9Lam49ao4mK6PkalNacMSP95NpmGNEb2UX1mdTrx3YAJoqQvicg==
X-Received: by 2002:a1c:e287:: with SMTP id z129mr12558151wmg.71.1545335098167;
        Thu, 20 Dec 2018 11:44:58 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:44:57 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 10/26] stash: convert apply to builtin
Date:   Thu, 20 Dec 2018 21:44:26 +0200
Message-Id: <c8165faa0f594a5098fb7436042d78490e885c3f.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

Add a builtin helper for performing stash commands. Converting
all at once proved hard to review, so starting with just apply
lets conversion get started without the other commands being
finished.

The helper is being implemented as a drop in replacement for
stash so that when it is complete it can simply be renamed and
the shell script deleted.

Delete the contents of the apply_stash shell function and replace
it with a call to stash--helper apply until pop is also
converted.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 .gitignore              |   1 +
 Makefile                |   1 +
 builtin.h               |   1 +
 builtin/stash--helper.c | 452 ++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |  78 +------
 git.c                   |   1 +
 6 files changed, 463 insertions(+), 71 deletions(-)
 create mode 100644 builtin/stash--helper.c

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..6ecab90ab2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -162,6 +162,7 @@
 /git-show-ref
 /git-stage
 /git-stash
+/git-stash--helper
 /git-status
 /git-stripspace
 /git-submodule
diff --git a/Makefile b/Makefile
index 1a44c811aa..c246fc7078 100644
--- a/Makefile
+++ b/Makefile
@@ -1117,6 +1117,7 @@ BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-index.o
 BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/stash--helper.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
diff --git a/builtin.h b/builtin.h
index 6538932e99..ff4460aff7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -225,6 +225,7 @@ extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_show_index(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
+extern int cmd_stash__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
new file mode 100644
index 0000000000..997b1c0ecf
--- /dev/null
+++ b/builtin/stash--helper.c
@@ -0,0 +1,452 @@
+#include "builtin.h"
+#include "config.h"
+#include "parse-options.h"
+#include "refs.h"
+#include "lockfile.h"
+#include "cache-tree.h"
+#include "unpack-trees.h"
+#include "merge-recursive.h"
+#include "argv-array.h"
+#include "run-command.h"
+#include "dir.h"
+#include "rerere.h"
+
+static const char * const git_stash_helper_usage[] = {
+	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
+static const char * const git_stash_helper_apply_usage[] = {
+	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
+static const char *ref_stash = "refs/stash";
+static struct strbuf stash_index_path = STRBUF_INIT;
+
+/*
+ * w_commit is set to the commit containing the working tree
+ * b_commit is set to the base commit
+ * i_commit is set to the commit containing the index tree
+ * u_commit is set to the commit containing the untracked files tree
+ * w_tree is set to the working tree
+ * b_tree is set to the base tree
+ * i_tree is set to the index tree
+ * u_tree is set to the untracked files tree
+ */
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
+	struct strbuf revision;
+	int is_stash_ref;
+	int has_u;
+};
+
+static void free_stash_info(struct stash_info *info)
+{
+	strbuf_release(&info->revision);
+}
+
+static void assert_stash_like(struct stash_info *info, const char *revision)
+{
+	if (get_oidf(&info->b_commit, "%s^1", revision) ||
+	    get_oidf(&info->w_tree, "%s:", revision) ||
+	    get_oidf(&info->b_tree, "%s^1:", revision) ||
+	    get_oidf(&info->i_tree, "%s^2:", revision))
+		die(_("'%s' is not a stash-like commit"), revision);
+}
+
+static int get_stash_info(struct stash_info *info, int argc, const char **argv)
+{
+	int ret;
+	char *end_of_rev;
+	char *expanded_ref;
+	const char *revision;
+	const char *commit = NULL;
+	struct object_id dummy;
+	struct strbuf symbolic = STRBUF_INIT;
+
+	if (argc > 1) {
+		int i;
+		struct strbuf refs_msg = STRBUF_INIT;
+
+		for (i = 0; i < argc; i++)
+			strbuf_addf(&refs_msg, " '%s'", argv[i]);
+
+		fprintf_ln(stderr, _("Too many revisions specified:%s"),
+			   refs_msg.buf);
+		strbuf_release(&refs_msg);
+
+		return -1;
+	}
+
+	if (argc == 1)
+		commit = argv[0];
+
+	strbuf_init(&info->revision, 0);
+	if (!commit) {
+		if (!ref_exists(ref_stash)) {
+			free_stash_info(info);
+			fprintf_ln(stderr, _("No stash entries found."));
+			return -1;
+		}
+
+		strbuf_addf(&info->revision, "%s@{0}", ref_stash);
+	} else if (strspn(commit, "0123456789") == strlen(commit)) {
+		strbuf_addf(&info->revision, "%s@{%s}", ref_stash, commit);
+	} else {
+		strbuf_addstr(&info->revision, commit);
+	}
+
+	revision = info->revision.buf;
+
+	if (get_oid(revision, &info->w_commit)) {
+		error(_("%s is not a valid reference"), revision);
+		free_stash_info(info);
+		return -1;
+	}
+
+	assert_stash_like(info, revision);
+
+	info->has_u = !get_oidf(&info->u_tree, "%s^3:", revision);
+
+	end_of_rev = strchrnul(revision, '@');
+	strbuf_add(&symbolic, revision, end_of_rev - revision);
+
+	ret = dwim_ref(symbolic.buf, symbolic.len, &dummy, &expanded_ref);
+	strbuf_release(&symbolic);
+	switch (ret) {
+	case 0: /* Not found, but valid ref */
+		info->is_stash_ref = 0;
+		break;
+	case 1:
+		info->is_stash_ref = !strcmp(expanded_ref, ref_stash);
+		break;
+	default: /* Invalid or ambiguous */
+		free_stash_info(info);
+	}
+
+	free(expanded_ref);
+	return !(ret == 0 || ret == 1);
+}
+
+static int reset_tree(struct object_id *i_tree, int update, int reset)
+{
+	int nr_trees = 1;
+	struct unpack_trees_options opts;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	struct tree *tree;
+	struct lock_file lock_file = LOCK_INIT;
+
+	read_cache_preload(NULL);
+	if (refresh_cache(REFRESH_QUIET))
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
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		return error(_("unable to write new index file"));
+
+	return 0;
+}
+
+static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const char *w_commit_hex = oid_to_hex(w_commit);
+
+	/*
+	 * Diff-tree would not be very hard to replace with a native function,
+	 * however it should be done together with apply_cached.
+	 */
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
+	argv_array_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
+
+	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
+}
+
+static int apply_cached(struct strbuf *out)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	/*
+	 * Apply currently only reads either from stdin or a file, thus
+	 * apply_all_patches would have to be updated to optionally take a
+	 * buffer.
+	 */
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "apply", "--cached", NULL);
+	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
+}
+
+static int reset_head(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	/*
+	 * Reset is overall quite simple, however there is no current public
+	 * API for resetting.
+	 */
+	cp.git_cmd = 1;
+	argv_array_push(&cp.args, "reset");
+
+	return run_command(&cp);
+}
+
+static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const char *c_tree_hex = oid_to_hex(c_tree);
+
+	/*
+	 * diff-index is very similar to diff-tree above, and should be
+	 * converted together with update_index.
+	 */
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "diff-index", "--cached", "--name-only",
+			 "--diff-filter=A", NULL);
+	argv_array_push(&cp.args, c_tree_hex);
+	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
+}
+
+static int update_index(struct strbuf *out)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	/*
+	 * Update-index is very complicated and may need to have a public
+	 * function exposed in order to remove this forking.
+	 */
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
+	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
+}
+
+static int restore_untracked(struct object_id *u_tree)
+{
+	int res;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	/*
+	 * We need to run restore files from a given index, but without
+	 * affecting the current index, so we use GIT_INDEX_FILE with
+	 * run_command to fork processes that will not interfere.
+	 */
+	cp.git_cmd = 1;
+	argv_array_push(&cp.args, "read-tree");
+	argv_array_push(&cp.args, oid_to_hex(u_tree));
+	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (run_command(&cp)) {
+		remove_path(stash_index_path.buf);
+		return -1;
+	}
+
+	child_process_init(&cp);
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "checkout-index", "--all", NULL);
+	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+
+	res = run_command(&cp);
+	remove_path(stash_index_path.buf);
+	return res;
+}
+
+static int do_apply_stash(const char *prefix, struct stash_info *info,
+			  int index, int quiet)
+{
+	int ret;
+	int has_index = index;
+	struct merge_options o;
+	struct object_id c_tree;
+	struct object_id index_tree;
+	struct commit *result;
+	const struct object_id *bases[1];
+
+	read_cache_preload(NULL);
+	if (refresh_cache(REFRESH_QUIET))
+		return -1;
+
+	if (write_cache_as_tree(&c_tree, 0, NULL) || reset_tree(&c_tree, 0, 0))
+		return error(_("cannot apply a stash in the middle of a merge"));
+
+	if (index) {
+		if (oideq(&info->b_tree, &info->i_tree) ||
+		    oideq(&c_tree, &info->i_tree)) {
+			has_index = 0;
+		} else {
+			struct strbuf out = STRBUF_INIT;
+
+			if (diff_tree_binary(&out, &info->w_commit)) {
+				strbuf_release(&out);
+				return error(_("could not generate diff %s^!."),
+					     oid_to_hex(&info->w_commit));
+			}
+
+			ret = apply_cached(&out);
+			strbuf_release(&out);
+			if (ret)
+				return error(_("conflicts in index."
+					       "Try without --index."));
+
+			discard_cache();
+			read_cache();
+			if (write_cache_as_tree(&index_tree, 0, NULL))
+				return error(_("could not save index tree"));
+
+			reset_head();
+		}
+	}
+
+	if (info->has_u && restore_untracked(&info->u_tree))
+		return error(_("could not restore untracked files from stash"));
+
+	init_merge_options(&o);
+
+	o.branch1 = "Updated upstream";
+	o.branch2 = "Stashed changes";
+
+	if (oideq(&info->b_tree, &c_tree))
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
+	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
+				      &result);
+	if (ret) {
+		rerere(0);
+
+		if (index)
+			fprintf_ln(stderr, _("Index was not unstashed."));
+
+		return ret;
+	}
+
+	if (has_index) {
+		if (reset_tree(&index_tree, 0, 0))
+			return -1;
+	} else {
+		struct strbuf out = STRBUF_INIT;
+
+		if (get_newly_staged(&out, &c_tree)) {
+			strbuf_release(&out);
+			return -1;
+		}
+
+		if (reset_tree(&c_tree, 0, 1)) {
+			strbuf_release(&out);
+			return -1;
+		}
+
+		ret = update_index(&out);
+		strbuf_release(&out);
+		if (ret)
+			return -1;
+
+		discard_cache();
+	}
+
+	if (quiet) {
+		if (refresh_cache(REFRESH_QUIET))
+			warning("could not refresh index");
+	} else {
+		struct child_process cp = CHILD_PROCESS_INIT;
+
+		/*
+		 * Status is quite simple and could be replaced with calls to
+		 * wt_status in the future, but it adds complexities which may
+		 * require more tests.
+		 */
+		cp.git_cmd = 1;
+		cp.dir = prefix;
+		argv_array_push(&cp.args, "status");
+		run_command(&cp);
+	}
+
+	return 0;
+}
+
+static int apply_stash(int argc, const char **argv, const char *prefix)
+{
+	int ret;
+	int quiet = 0;
+	int index = 0;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			 N_("attempt to recreate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_apply_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	ret = do_apply_stash(prefix, &info, index, quiet);
+	free_stash_info(&info);
+	return ret;
+}
+
+int cmd_stash__helper(int argc, const char **argv, const char *prefix)
+{
+	pid_t pid = getpid();
+	const char *index_file;
+
+	struct option options[] = {
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, options, git_stash_helper_usage,
+			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
+
+	index_file = get_index_file();
+	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
+		    (uintmax_t)pid);
+
+	if (argc < 1)
+		usage_with_options(git_stash_helper_usage, options);
+	if (!strcmp(argv[0], "apply"))
+		return !!apply_stash(argc, argv, prefix);
+
+	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
+		      git_stash_helper_usage, options);
+}
diff --git a/git-stash.sh b/git-stash.sh
index 789ce2f41d..366a082853 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -583,76 +583,11 @@ assert_stash_ref() {
 }
 
 apply_stash () {
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
-		GIT_INDEX_FILE="$TMPindex" git read-tree "$u_tree" &&
-		GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
-		rm -f "$TMPindex" ||
-		die "$(gettext "Could not restore untracked files from stash entry")"
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
+	cd "$START_DIR"
+	git stash--helper apply "$@"
+	res=$?
+	cd_to_toplevel
+	return $res
 }
 
 pop_stash() {
@@ -730,7 +665,8 @@ push)
 	;;
 apply)
 	shift
-	apply_stash "$@"
+	cd "$START_DIR"
+	git stash--helper apply "$@"
 	;;
 clear)
 	shift
diff --git a/git.c b/git.c
index 4d53a3d50d..de9c774573 100644
--- a/git.c
+++ b/git.c
@@ -554,6 +554,7 @@ static struct cmd_struct commands[] = {
 	{ "show-index", cmd_show_index },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "stash--helper", cmd_stash__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
-- 
2.20.1.441.g764a526393

