Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C521F404
	for <e@80x24.org>; Sat, 24 Mar 2018 17:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeCXRhh (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 13:37:37 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33463 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeCXRhg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 13:37:36 -0400
Received: by mail-pg0-f44.google.com with SMTP id i194so1536989pgd.0
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gwf5Zeygc+HirkV0dEnF5JHT6zoIuaTJrcKsiBYU1bI=;
        b=bZ5BDDGe2gXsAdM+JZXloCIpgjcOCw8tclLvxoq/ScPeNkOG9JVZ4S59moYBG4G2/d
         WW1zAb8ODmwAnm6rRnuL9Q28yccKyHSQIzgg+U9HcD+1tC5tRnPwbuQDlJeCRmrolRme
         rqCiHcZ6QtRlySsFXetoGvKK8Ur7AOD6J983ZskbsI67JuPzWn12W8AFKEzCtpVbfpa4
         RkISlgbw0afIBfZWPPP4CIwukoK9P96DzUKgSD8qjSK726rY779PDrtLPaVYvPbTOgt1
         DZfQWLPShl+E3ExFJ084jt5sN4ubQ9f/WUj1FvszZB6v6PT2Il7XFdho+i474zLnQC6D
         m+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gwf5Zeygc+HirkV0dEnF5JHT6zoIuaTJrcKsiBYU1bI=;
        b=azxjzlKr0aVnLPEfwX0fUgqSKKWh7+XotHW+KaT88mh51U0/g3Am2lhOp0UrCZehb7
         3S8mv14ZSTHHSkyyNQHjy/c2x6sR/4lQFZI5JqBUJCjvdYSpDQiVc6Gjpz3T1y34szfq
         s7+r0fNK9UQRg9gmwRH2IzZebVKOyubN6jWkbX/3cKOY+64GPz9N10pB4+29phCk/exU
         9nTni9UIblf8iJ/VoB1GH+QxKOP95QOHZtc9SnB4g5ODx6u6+Ng6vcAY30dCsyMKGgjv
         LCHJkEUsEeFxArNSJukaf5c4lzs7btO4YKLT3YrQaMNKQTlz4Vfa+HAHP69WwW6AQn4G
         gMSg==
X-Gm-Message-State: AElRT7Gde0kVBiWN/2/LLHmXdItZqoW9t3rbJeWNomqrXCKj3KdBhfyF
        bNQC75yMaKWedP/u0WieUophhJA=
X-Google-Smtp-Source: AG47ELsINCYyGvVRNBhtf3D4HYaI6+hbdQsvIManmr515xKEsyeztZ0AXR1+SJsIJWNlpezJN/y6Dw==
X-Received: by 10.99.125.87 with SMTP id m23mr23582453pgn.297.1521913055289;
        Sat, 24 Mar 2018 10:37:35 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id z6sm22005486pfe.9.2018.03.24.10.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 10:37:34 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH 1/4] stash: convert apply to builtin
Date:   Sat, 24 Mar 2018 10:37:04 -0700
Message-Id: <20180324173707.17699-2-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180324173707.17699-1-joel@teichroeb.net>
References: <20180324173707.17699-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 .gitignore              |   1 +
 Makefile                |   1 +
 builtin.h               |   1 +
 builtin/stash--helper.c | 339 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |   3 +-
 git.c                   |   1 +
 6 files changed, 345 insertions(+), 1 deletion(-)
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
index a1d8775adb..8ca361c57a 100644
--- a/Makefile
+++ b/Makefile
@@ -1020,6 +1020,7 @@ BUILTIN_OBJS += builtin/send-pack.o
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
index 0000000000..e9a9574f40
--- /dev/null
+++ b/builtin/stash--helper.c
@@ -0,0 +1,339 @@
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
+	const char *message;
+	const char *revision;
+	int is_stash_ref;
+	int has_u;
+	const char *patch;
+};
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
+	} else if (strspn(commit, "0123456789") == strlen(commit)) {
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
+
+	ret = !get_oid(w_commit_rev.buf, &info->w_commit) &&
+		!get_oid(b_commit_rev.buf, &info->b_commit) &&
+		!get_oid(w_tree_rev.buf, &info->w_tree) &&
+		!get_oid(b_tree_rev.buf, &info->b_tree) &&
+		!get_oid(i_tree_rev.buf, &info->i_tree);
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
+	strbuf_addf(&u_tree_rev, "%s^3:", revision);
+
+	info->has_u = !get_oid(u_tree_rev.buf, &info->u_tree);
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
+	if (out.len - 1 == strlen(ref_stash))
+		info->is_stash_ref = !strncmp(out.buf, ref_stash, out.len - 1);
+	strbuf_release(&out);
+
+	return 0;
+}
+
+static int reset_tree(struct object_id i_tree, int update, int reset)
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
+	tree = parse_tree_indirect(&i_tree);
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
+	if (write_cache_as_tree(c_tree.hash, 0, NULL) || reset_tree(c_tree, 0, 0))
+		return error(_("Cannot apply a stash in the middle of a merge"));
+
+	if (index) {
+		if (!oidcmp(&info->b_tree, &info->i_tree) || !oidcmp(&c_tree, &info->i_tree)) {
+			has_index = 0;
+		} else {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			struct strbuf out = STRBUF_INIT;
+			struct argv_array args = ARGV_ARRAY_INIT;
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
+			argv_array_pushf(&cp.args, "%s^2^..%s^2", sha1_to_hex(info->w_commit.hash), sha1_to_hex(info->w_commit.hash));
+			if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0))
+				return -1;
+
+			child_process_init(&cp);
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "apply", "--cached", NULL);
+			if (pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0))
+				return -1;
+
+			strbuf_release(&out);
+			discard_cache();
+			read_cache();
+			if (write_cache_as_tree(index_tree.hash, 0, NULL))
+				return -1;
+
+			argv_array_push(&args, "reset");
+			cmd_reset(args.argc, args.argv, prefix);
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
+		argv_array_push(&cp.args, sha1_to_hex(info->u_tree.hash));
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
+	if (!hashcmp(info->b_tree.hash, c_tree.hash))
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
+	if (has_index) {
+		if (reset_tree(index_tree, 0, 0))
+			return -1;
+	} else {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf out = STRBUF_INIT;
+		cp.git_cmd = 1;
+		argv_array_pushl(&cp.args, "diff-index", "--cached", "--name-only", "--diff-filter=A", NULL);
+		argv_array_push(&cp.args, sha1_to_hex(c_tree.hash));
+		ret = pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
+		if (ret)
+			return -1;
+
+		if (reset_tree(c_tree, 0, 1))
+			return -1;
+
+		child_process_init(&cp);
+		cp.git_cmd = 1;
+		argv_array_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
+		ret = pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0);
+		if (ret)
+			return -1;
+
+		strbuf_release(&out);
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
+			git_stash_helper_apply_usage, 0);
+
+	if (argc == 1) {
+		commit = argv[0];
+	}
+
+	if (get_stash_info(&info, commit))
+		return -1;
+
+
+	return do_apply_stash(prefix, &info, index);
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
index fc8f8ae640..92c084eb17 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -711,7 +711,8 @@ push)
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

