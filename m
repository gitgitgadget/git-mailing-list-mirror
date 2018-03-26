Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533B71F404
	for <e@80x24.org>; Mon, 26 Mar 2018 01:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbeCZBOn (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 21:14:43 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33660 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbeCZBOm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 21:14:42 -0400
Received: by mail-pg0-f68.google.com with SMTP id i194so2474804pgd.0
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 18:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ca/W3LcHS3FYI3eEcLXB8a1cFhdJu+Pp9S1iGZVdelM=;
        b=oUI8zcZayz9q/9LY6IqoD2OE1WfLi7bnu/xlWBwMyTHg9x4gCBRdqxV3lWoFkCPBca
         IlkZK1+dgqre7Afj//RycfPPQjWHGCDgAa9i2kXw6XWWAfnypcZN4CkNpPjFauxlCtaz
         UfTAD8mHIyne3PLfvhicwDuZMge2pNm/ts0zBv7mJPphJFNHbAt1pn33HknCz5l2ojGz
         aerfOaEbjBI1NBlqWHoKQ+tfrq8Qwvp2Yq66dsFZcEQoFEdIG3nG+6jsWBQ7qfNRKCN2
         MimUfIVTlvqrUjC1zmDKNswd6+mP6YvfHi+ikRGMPD+ElFkGRqqt5OBdmUl9rdF/bb0z
         jLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ca/W3LcHS3FYI3eEcLXB8a1cFhdJu+Pp9S1iGZVdelM=;
        b=F7inNHGTj0xKzfhLDp++UsHVI31J5H1TJHMPNS6WKH655q/I4Dp1OT2z7/08tdXg/B
         H/UZ9S7a1r3XdzUK++Lu7rxZ6zk+mrWp78rrb2E5TJPFAoCRstYPgRSpzVyLV815K291
         6cIEKD3sLxqFIYKVONl7uUs54QP7YpcVlejp3iCzfQ8XShZCCMeQPGcetGTVmnn4J87h
         XLOdxsIRAPQciX6LjbWOnEpqMHaZRPqoVKe3QM6I6/8pJJJwBWfpTKc1AQSAU4tCrJvL
         iXQ96YFn1Iv8cQ4jHRVkEaBbjxU9Ncdflp8TaSjryU58r81aIpnB5PIPwURHqtIXH1/n
         uPGg==
X-Gm-Message-State: AElRT7FI5zpKy7hdYu+4cwO9/ad5s/YKTmi5l8ASC0nNtXX7R1ZTj89m
        Gu7D9tDC4uBH6+Ni8UGySkxyELM=
X-Google-Smtp-Source: AG47ELsRX5eVSJaX1h965nFKjPY5JHkI44ivxeDEnv6BWeMnxvPLMBozN5U5myZJYvhNvXDxiwC6WA==
X-Received: by 10.99.54.73 with SMTP id d70mr15949995pga.86.1522026880999;
        Sun, 25 Mar 2018 18:14:40 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id k70sm18664894pga.72.2018.03.25.18.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 18:14:40 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v2 3/6] stash: convert apply to builtin
Date:   Sun, 25 Mar 2018 18:14:23 -0700
Message-Id: <20180326011426.19159-4-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180326011426.19159-1-joel@teichroeb.net>
References: <20180326011426.19159-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 .gitignore              |   1 +
 Makefile                |   1 +
 builtin.h               |   1 +
 builtin/stash--helper.c | 431 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |  75 +--------
 git.c                   |   1 +
 6 files changed, 440 insertions(+), 70 deletions(-)
 create mode 100644 builtin/stash--helper.c

diff --git a/.gitignore b/.gitignore
index 833ef3b0b7..296d5f376d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -152,6 +152,7 @@
 /git-show-ref
 /git-stage
 /git-stash
+/git-stash--helper
 /git-status
 /git-stripspace
 /git-submodule
diff --git a/Makefile b/Makefile
index 96f6138f63..6cfdbe9a32 100644
--- a/Makefile
+++ b/Makefile
@@ -1028,6 +1028,7 @@ BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/stash--helper.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
diff --git a/builtin.h b/builtin.h
index 42378f3aa4..a14fd85b0e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -219,6 +219,7 @@ extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
+extern int cmd_stash__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
new file mode 100644
index 0000000000..050de415b4
--- /dev/null
+++ b/builtin/stash--helper.c
@@ -0,0 +1,431 @@
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
+static int quiet;
+static char stash_index_path[PATH_MAX];
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
+static int get_symbolic_name(const char *symbolic, struct strbuf *out)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "rev-parse", "--symbolic-full-name", NULL);
+	argv_array_pushf(&cp.args, "%s", symbolic);
+	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
+}
+
+static int have_stash(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.git_cmd = 1;
+	cp.no_stdout = 1;
+	argv_array_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
+	argv_array_pushf(&cp.args, "%s", ref_stash);
+	return pipe_command(&cp, NULL, 0, NULL, 0, NULL, 0);
+}
+
+static void destroy_stash_info(struct stash_info *info)
+{
+	strbuf_release(&info->revision);
+}
+
+static int get_stash_info(struct stash_info *info, int argc, const char **argv)
+{
+	struct strbuf w_commit_rev = STRBUF_INIT;
+	struct strbuf b_commit_rev = STRBUF_INIT;
+	struct strbuf w_tree_rev = STRBUF_INIT;
+	struct strbuf b_tree_rev = STRBUF_INIT;
+	struct strbuf i_tree_rev = STRBUF_INIT;
+	struct strbuf u_tree_rev = STRBUF_INIT;
+	struct strbuf symbolic = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	int ret;
+	const char *revision;
+	const char *commit = NULL;
+	char *end_of_rev;
+	info->is_stash_ref = 0;
+
+	if (argc > 1) {
+		int i;
+		fprintf(stderr, _("Too many revisions specified:"));
+		for (i = 0; i < argc; ++i) {
+			fprintf(stderr, " '%s'", argv[i]);
+		}
+		fprintf(stderr, "\n");
+
+		return -1;
+	}
+
+	if (argc == 1)
+		commit = argv[0];
+
+	strbuf_init(&info->revision, 0);
+	if (commit == NULL) {
+		if (have_stash()) {
+			destroy_stash_info(info);
+			return error(_("No stash entries found."));
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
+	strbuf_addf(&w_commit_rev, "%s", revision);
+
+
+	ret = !get_oid(w_commit_rev.buf, &info->w_commit);
+
+	strbuf_release(&w_commit_rev);
+
+	if (!ret) {
+		destroy_stash_info(info);
+		return error(_("%s is not a valid reference"), revision);
+	}
+
+	strbuf_addf(&b_commit_rev, "%s^1", revision);
+	strbuf_addf(&w_tree_rev, "%s:", revision);
+	strbuf_addf(&b_tree_rev, "%s^1:", revision);
+	strbuf_addf(&i_tree_rev, "%s^2:", revision);
+
+	ret = !get_oid(b_commit_rev.buf, &info->b_commit) &&
+		!get_oid(w_tree_rev.buf, &info->w_tree) &&
+		!get_oid(b_tree_rev.buf, &info->b_tree) &&
+		!get_oid(i_tree_rev.buf, &info->i_tree);
+
+	strbuf_release(&b_commit_rev);
+	strbuf_release(&w_tree_rev);
+	strbuf_release(&b_tree_rev);
+	strbuf_release(&i_tree_rev);
+
+	if (!ret) {
+		destroy_stash_info(info);
+		return error(_("'%s' is not a stash-like commit"), revision);
+	}
+
+	strbuf_addf(&u_tree_rev, "%s^3:", revision);
+
+	info->has_u = !get_oid(u_tree_rev.buf, &info->u_tree);
+
+	strbuf_release(&u_tree_rev);
+
+	end_of_rev = strchrnul(revision, '@');
+	strbuf_add(&symbolic, revision, end_of_rev - revision);
+
+	ret = get_symbolic_name(symbolic.buf, &out);
+	strbuf_release(&symbolic);
+	if (ret) {
+		destroy_stash_info(info);
+		strbuf_release(&out);
+		return -1;
+	}
+
+	if (out.len - 1 == strlen(ref_stash))
+		info->is_stash_ref = !strncmp(out.buf, ref_stash, out.len - 1);
+	strbuf_release(&out);
+
+	return 0;
+}
+
+static int reset_tree(struct object_id *i_tree, int update, int reset)
+{
+	struct unpack_trees_options opts;
+	int nr_trees = 1;
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
+    struct child_process cp = CHILD_PROCESS_INIT;
+    const char *w_commit_hex = oid_to_hex(w_commit);
+
+    cp.git_cmd = 1;
+    argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
+    argv_array_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
+
+    return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
+}
+
+static int apply_cached(struct strbuf *out)
+{
+    struct child_process cp = CHILD_PROCESS_INIT;
+
+    cp.git_cmd = 1;
+    argv_array_pushl(&cp.args, "apply", "--cached", NULL);
+    return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
+}
+
+static int reset_head(const char *prefix)
+{
+	struct argv_array args = ARGV_ARRAY_INIT;
+
+	argv_array_push(&args, "reset");
+	return cmd_reset(args.argc, args.argv, prefix);
+}
+
+static int diff_cached_index(struct strbuf *out, struct object_id *c_tree)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+    const char *c_tree_hex = oid_to_hex(c_tree);
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "diff-index", "--cached", "--name-only", "--diff-filter=A", NULL);
+	argv_array_push(&cp.args, c_tree_hex);
+	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
+}
+
+static int update_index(struct strbuf *out) {
+	struct child_process cp = CHILD_PROCESS_INIT;
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
+	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
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
+	int has_index = index;
+
+	read_cache_preload(NULL);
+	if (refresh_cache(REFRESH_QUIET))
+		return -1;
+
+	if (write_cache_as_tree(&c_tree, 0, NULL) || reset_tree(&c_tree, 0, 0))
+		return error(_("Cannot apply a stash in the middle of a merge"));
+
+	if (index) {
+		if (!oidcmp(&info->b_tree, &info->i_tree) || !oidcmp(&c_tree, &info->i_tree)) {
+			has_index = 0;
+		} else {
+			struct strbuf out = STRBUF_INIT;
+
+			if (diff_tree_binary(&out, &info->w_commit)) {
+				strbuf_release(&out);
+				return -1;
+			}
+
+			ret = apply_cached(&out);
+			strbuf_release(&out);
+			if (ret)
+				return -1;
+
+			discard_cache();
+			read_cache();
+			if (write_cache_as_tree(&index_tree, 0, NULL))
+				return -1;
+
+			reset_head(prefix);
+		}
+	}
+
+	if (info->has_u) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct child_process cp2 = CHILD_PROCESS_INIT;
+		int res;
+
+		cp.git_cmd = 1;
+		argv_array_push(&cp.args, "read-tree");
+		argv_array_push(&cp.args, oid_to_hex(&info->u_tree));
+		argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
+
+		cp2.git_cmd = 1;
+		argv_array_pushl(&cp2.args, "checkout-index", "--all", NULL);
+		argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
+
+		res = run_command(&cp) || run_command(&cp2);
+		remove_path(stash_index_path);
+		if (res)
+			return error(_("Could not restore untracked files from stash"));
+	}
+
+	init_merge_options(&o);
+
+	o.branch1 = "Updated upstream";
+	o.branch2 = "Stashed changes";
+
+	if (!oidcmp(&info->b_tree, &c_tree))
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
+		if (diff_cached_index(&out, &c_tree)) {
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
+	int index = 0;
+	struct stash_info info;
+	int ret;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			N_("attempt to recreate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_helper_apply_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	ret = do_apply_stash(prefix, &info, index);
+	destroy_stash_info(&info);
+	return ret;
+}
+
+int cmd_stash__helper(int argc, const char **argv, const char *prefix)
+{
+	int result = 0;
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
+		PARSE_OPT_KEEP_UNKNOWN|PARSE_OPT_KEEP_DASHDASH);
+
+	index_file = get_index_file();
+	xsnprintf(stash_index_path, PATH_MAX, "%s.stash.%d", index_file, pid);
+
+	if (argc < 1)
+		usage_with_options(git_stash_helper_usage, options);
+	else if (!strcmp(argv[0], "apply"))
+		result = apply_stash(argc, argv, prefix);
+	else {
+		error(_("unknown subcommand: %s"), argv[0]);
+		usage_with_options(git_stash_helper_usage, options);
+		result = 1;
+	}
+
+	return result;
+}
diff --git a/git-stash.sh b/git-stash.sh
index 94793c1a91..0b5d1f3743 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -566,76 +566,11 @@ assert_stash_ref() {
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
diff --git a/git.c b/git.c
index ceaa58ef40..6ffe6364ac 100644
--- a/git.c
+++ b/git.c
@@ -466,6 +466,7 @@ static struct cmd_struct commands[] = {
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "stash--helper", cmd_stash__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
-- 
2.16.2

