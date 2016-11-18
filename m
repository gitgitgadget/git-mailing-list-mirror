Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE691FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 19:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbcKRT7V (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 14:59:21 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34212 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753350AbcKRT7K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 14:59:10 -0500
Received: by mail-pf0-f182.google.com with SMTP id c4so44095033pfb.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ww4z3IWcsbmoH1aCLUE3s48EzzymSEUorFnkm+kIGfE=;
        b=gyQ83Y5Jv/kLmFWnhYGtTKPGaZXc3J/KDUkGt4hGCphv53xMRC1kDdFzQnSUIHV9o7
         q5t/ewx1SZ7SAk050YpnzlM4pDWAcc1ou2kI7/Fu20A2DFdhr7pBay0XMATHJZh1QWZb
         vPDs1twaAHjgqaV6o7P+1qJFnSIjorlaAw4nOQmHUGOSkGl0JIKqrpxZzr8WVwWdO1Oa
         /lypogqKIOWCHPrDRCDsDhpepuhcDt4MM4U3TxZ7wACZW7UQcH0AmLPlOZfWPjmz4Xg4
         mRxBnjRG00NbAyzi8wC7g5gQ6FZRuz3WlzGaWDeeO6etcuhtWIj2TX65Ttep/HraUQo7
         g1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ww4z3IWcsbmoH1aCLUE3s48EzzymSEUorFnkm+kIGfE=;
        b=NZxlbTrtPacC6c48OIGMn0/Juvi+k/RtHvF0bUAkzZY6/EdBvKKCqKdvZW8T8aBN+3
         pm0AgBQGdkad/sbLyR2+ZOBBT5rgO81D9v7IVti/0nLEbZ8iSdpTImd+vpeoaQU9+jn+
         KMrZYhNJOJgH9ek+kHsMqlxrtM0/6ui5oDra02gBekazo2q03IGkBzEvLz4eOdImJTyc
         XCIjV6yoY83mYZNEalcK1fRD1b/wzxoPGSkCRY+HRb9VLlUD/svdf5CpgL+/OOVffVMo
         RFjqL25yZ1TK748+gXYCU9oFXIi+CxBUnzv4TIzuQ7AlgoNyxTueFtgOwbX9UQ0X09P0
         62cQ==
X-Gm-Message-State: AKaTC02KPmotD7QkTf4F8d+qYZt60V/SgnRSx6jbw7fi82pj/2IHsbazBSBU09SWykMA12oF
X-Received: by 10.99.47.7 with SMTP id v7mr2916383pgv.15.1479499149415;
        Fri, 18 Nov 2016 11:59:09 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm19850441pfb.42.2016.11.18.11.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Nov 2016 11:59:08 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v4 4/6] grep: optionally recurse into submodules
Date:   Fri, 18 Nov 2016 11:58:53 -0800
Message-Id: <1479499135-64269-5-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479499135-64269-1-git-send-email-bmwill@google.com>
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1479499135-64269-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow grep to recognize submodules and recursively search for patterns in
each submodule.  This is done by forking off a process to recursively
call grep on each submodule.  The top level --super-prefix option is
used to pass a path to the submodule which can in turn be used to
prepend to output or in pathspec matching logic.

Recursion only occurs for submodules which have been initialized and
checked out by the parent project.  If a submodule hasn't been
initialized and checked out it is simply skipped.

In order to support the existing multi-threading infrastructure in grep,
output from each child process is captured in a strbuf so that it can be
later printed to the console in an ordered fashion.

To limit the number of theads that are created, each child process has
half the number of threads as its parents (minimum of 1), otherwise we
potentailly have a fork-bomb.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-grep.txt         |   5 +
 builtin/grep.c                     | 300 ++++++++++++++++++++++++++++++++++---
 git.c                              |   2 +-
 t/t7814-grep-recurse-submodules.sh |  99 ++++++++++++
 4 files changed, 385 insertions(+), 21 deletions(-)
 create mode 100755 t/t7814-grep-recurse-submodules.sh

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 0ecea6e..17aa1ba 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -26,6 +26,7 @@ SYNOPSIS
 	   [--threads <num>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
+	   [--recurse-submodules]
 	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
 
@@ -88,6 +89,10 @@ OPTIONS
 	mechanism.  Only useful when searching files in the current directory
 	with `--no-index`.
 
+--recurse-submodules::
+	Recursively search in each submodule that has been initialized and
+	checked out in the repository.
+
 -a::
 --text::
 	Process binary files as if they were text.
diff --git a/builtin/grep.c b/builtin/grep.c
index 8887b6a..cfafa15 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -18,12 +18,20 @@
 #include "quote.h"
 #include "dir.h"
 #include "pathspec.h"
+#include "submodule.h"
 
 static char const * const grep_usage[] = {
 	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
 	NULL
 };
 
+static const char *super_prefix;
+static int recurse_submodules;
+static struct argv_array submodule_options = ARGV_ARRAY_INIT;
+
+static int grep_submodule_launch(struct grep_opt *opt,
+				 const struct grep_source *gs);
+
 #define GREP_NUM_THREADS_DEFAULT 8
 static int num_threads;
 
@@ -174,7 +182,10 @@ static void *run(void *arg)
 			break;
 
 		opt->output_priv = w;
-		hit |= grep_source(opt, &w->source);
+		if (w->source.type == GREP_SOURCE_SUBMODULE)
+			hit |= grep_submodule_launch(opt, &w->source);
+		else
+			hit |= grep_source(opt, &w->source);
 		grep_source_clear_data(&w->source);
 		work_done(w);
 	}
@@ -300,6 +311,10 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 	if (opt->relative && opt->prefix_length) {
 		quote_path_relative(filename + tree_name_len, opt->prefix, &pathbuf);
 		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
+	} else if (super_prefix) {
+		strbuf_add(&pathbuf, filename, tree_name_len);
+		strbuf_addstr(&pathbuf, super_prefix);
+		strbuf_addstr(&pathbuf, filename + tree_name_len);
 	} else {
 		strbuf_addstr(&pathbuf, filename);
 	}
@@ -328,10 +343,13 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	if (opt->relative && opt->prefix_length)
+	if (opt->relative && opt->prefix_length) {
 		quote_path_relative(filename, opt->prefix, &buf);
-	else
+	} else {
+		if (super_prefix)
+			strbuf_addstr(&buf, super_prefix);
 		strbuf_addstr(&buf, filename);
+	}
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
@@ -378,31 +396,258 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 		exit(status);
 }
 
-static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int cached)
+static void compile_submodule_options(const struct grep_opt *opt,
+				      const struct pathspec *pathspec,
+				      int cached, int untracked,
+				      int opt_exclude, int use_index,
+				      int pattern_type_arg)
+{
+	struct grep_pat *pattern;
+	int i;
+
+	if (recurse_submodules)
+		argv_array_push(&submodule_options, "--recurse-submodules");
+
+	if (cached)
+		argv_array_push(&submodule_options, "--cached");
+	if (!use_index)
+		argv_array_push(&submodule_options, "--no-index");
+	if (untracked)
+		argv_array_push(&submodule_options, "--untracked");
+	if (opt_exclude > 0)
+		argv_array_push(&submodule_options, "--exclude-standard");
+
+	if (opt->invert)
+		argv_array_push(&submodule_options, "-v");
+	if (opt->ignore_case)
+		argv_array_push(&submodule_options, "-i");
+	if (opt->word_regexp)
+		argv_array_push(&submodule_options, "-w");
+	switch (opt->binary) {
+	case GREP_BINARY_NOMATCH:
+		argv_array_push(&submodule_options, "-I");
+		break;
+	case GREP_BINARY_TEXT:
+		argv_array_push(&submodule_options, "-a");
+		break;
+	default:
+		break;
+	}
+	if (opt->allow_textconv)
+		argv_array_push(&submodule_options, "--textconv");
+	if (opt->max_depth != -1)
+		argv_array_pushf(&submodule_options, "--max-depth=%d",
+				 opt->max_depth);
+	if (opt->linenum)
+		argv_array_push(&submodule_options, "-n");
+	if (!opt->pathname)
+		argv_array_push(&submodule_options, "-h");
+	if (!opt->relative)
+		argv_array_push(&submodule_options, "--full-name");
+	if (opt->name_only)
+		argv_array_push(&submodule_options, "-l");
+	if (opt->unmatch_name_only)
+		argv_array_push(&submodule_options, "-L");
+	if (opt->null_following_name)
+		argv_array_push(&submodule_options, "-z");
+	if (opt->count)
+		argv_array_push(&submodule_options, "-c");
+	if (opt->file_break)
+		argv_array_push(&submodule_options, "--break");
+	if (opt->heading)
+		argv_array_push(&submodule_options, "--heading");
+	if (opt->pre_context)
+		argv_array_pushf(&submodule_options, "--before-context=%d",
+				 opt->pre_context);
+	if (opt->post_context)
+		argv_array_pushf(&submodule_options, "--after-context=%d",
+				 opt->post_context);
+	if (opt->funcname)
+		argv_array_push(&submodule_options, "-p");
+	if (opt->funcbody)
+		argv_array_push(&submodule_options, "-W");
+	if (opt->all_match)
+		argv_array_push(&submodule_options, "--all-match");
+	if (opt->debug)
+		argv_array_push(&submodule_options, "--debug");
+	if (opt->status_only)
+		argv_array_push(&submodule_options, "-q");
+
+	switch (pattern_type_arg) {
+	case GREP_PATTERN_TYPE_BRE:
+		argv_array_push(&submodule_options, "-G");
+		break;
+	case GREP_PATTERN_TYPE_ERE:
+		argv_array_push(&submodule_options, "-E");
+		break;
+	case GREP_PATTERN_TYPE_FIXED:
+		argv_array_push(&submodule_options, "-F");
+		break;
+	case GREP_PATTERN_TYPE_PCRE:
+		argv_array_push(&submodule_options, "-P");
+		break;
+	case GREP_PATTERN_TYPE_UNSPECIFIED:
+		break;
+	}
+
+	for (pattern = opt->pattern_list; pattern != NULL;
+	     pattern = pattern->next) {
+		switch (pattern->token) {
+		case GREP_PATTERN:
+			argv_array_pushf(&submodule_options, "-e%s",
+					 pattern->pattern);
+			break;
+		case GREP_AND:
+		case GREP_OPEN_PAREN:
+		case GREP_CLOSE_PAREN:
+		case GREP_NOT:
+		case GREP_OR:
+			argv_array_push(&submodule_options, pattern->pattern);
+			break;
+		/* BODY and HEAD are not used by git-grep */
+		case GREP_PATTERN_BODY:
+		case GREP_PATTERN_HEAD:
+			break;
+		}
+	}
+
+	/*
+	 * Limit number of threads for child process to use.
+	 * This is to prevent potential fork-bomb behavior of git-grep as each
+	 * submodule process has its own thread pool.
+	 */
+	argv_array_pushf(&submodule_options, "--threads=%d",
+			 (num_threads + 1) / 2);
+
+	/* Add Pathspecs */
+	argv_array_push(&submodule_options, "--");
+	for (i = 0; i < pathspec->nr; i++)
+		argv_array_push(&submodule_options,
+				pathspec->items[i].original);
+}
+
+/*
+ * Launch child process to grep contents of a submodule
+ */
+static int grep_submodule_launch(struct grep_opt *opt,
+				 const struct grep_source *gs)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int status, i;
+	struct work_item *w = opt->output_priv;
+
+	prepare_submodule_repo_env(&cp.env_array);
+
+	/* Add super prefix */
+	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
+			 super_prefix ? super_prefix : "",
+			 gs->name);
+	argv_array_push(&cp.args, "grep");
+
+	/* Add options */
+	for (i = 0; i < submodule_options.argc; i++)
+		argv_array_push(&cp.args, submodule_options.argv[i]);
+
+	cp.git_cmd = 1;
+	cp.dir = gs->path;
+
+	/*
+	 * Capture output to output buffer and check the return code from the
+	 * child process.  A '0' indicates a hit, a '1' indicates no hit and
+	 * anything else is an error.
+	 */
+	status = capture_command(&cp, &w->out, 0);
+	if (status && (status != 1)) {
+		/* flush the buffer */
+		write_or_die(1, w->out.buf, w->out.len);
+		die("process for submodule '%s' failed with exit code: %d",
+		    gs->name, status);
+	}
+
+	/* invert the return code to make a hit equal to 1 */
+	return !status;
+}
+
+/*
+ * Prep grep structures for a submodule grep
+ * sha1: the sha1 of the submodule or NULL if using the working tree
+ * filename: name of the submodule including tree name of parent
+ * path: location of the submodule
+ */
+static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
+			  const char *filename, const char *path)
+{
+	if (!is_submodule_initialized(path))
+		return 0;
+	if (!is_submodule_populated(path))
+		return 0;
+
+#ifndef NO_PTHREADS
+	if (num_threads) {
+		add_work(opt, GREP_SOURCE_SUBMODULE, filename, path, sha1);
+		return 0;
+	} else
+#endif
+	{
+		struct work_item w;
+		int hit;
+
+		grep_source_init(&w.source, GREP_SOURCE_SUBMODULE,
+				 filename, path, sha1);
+		strbuf_init(&w.out, 0);
+		opt->output_priv = &w;
+		hit = grep_submodule_launch(opt, &w.source);
+
+		write_or_die(1, w.out.buf, w.out.len);
+
+		grep_source_clear(&w.source);
+		strbuf_release(&w.out);
+		return hit;
+	}
+}
+
+static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
+		      int cached)
 {
 	int hit = 0;
 	int nr;
+	struct strbuf name = STRBUF_INIT;
+	int name_base_len = 0;
+	if (super_prefix) {
+		name_base_len = strlen(super_prefix);
+		strbuf_addstr(&name, super_prefix);
+	}
+
 	read_cache();
 
 	for (nr = 0; nr < active_nr; nr++) {
 		const struct cache_entry *ce = active_cache[nr];
-		if (!S_ISREG(ce->ce_mode))
-			continue;
-		if (!ce_path_match(ce, pathspec, NULL))
-			continue;
-		/*
-		 * If CE_VALID is on, we assume worktree file and its cache entry
-		 * are identical, even if worktree file has been modified, so use
-		 * cache version instead
-		 */
-		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
-			if (ce_stage(ce) || ce_intent_to_add(ce))
-				continue;
-			hit |= grep_sha1(opt, ce->oid.hash, ce->name, 0,
-					 ce->name);
+		strbuf_setlen(&name, name_base_len);
+		strbuf_addstr(&name, ce->name);
+
+		if (S_ISREG(ce->ce_mode) &&
+		    match_pathspec(pathspec, name.buf, name.len, 0, NULL,
+				   S_ISDIR(ce->ce_mode) ||
+				   S_ISGITLINK(ce->ce_mode))) {
+			/*
+			 * If CE_VALID is on, we assume worktree file and its
+			 * cache entry are identical, even if worktree file has
+			 * been modified, so use cache version instead
+			 */
+			if (cached || (ce->ce_flags & CE_VALID) ||
+			    ce_skip_worktree(ce)) {
+				if (ce_stage(ce) || ce_intent_to_add(ce))
+					continue;
+				hit |= grep_sha1(opt, ce->oid.hash, ce->name,
+						 0, ce->name);
+			} else {
+				hit |= grep_file(opt, ce->name);
+			}
+		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
+			   submodule_path_match(pathspec, name.buf, NULL)) {
+			hit |= grep_submodule(opt, NULL, ce->name, ce->name);
 		}
-		else
-			hit |= grep_file(opt, ce->name);
+
 		if (ce_stage(ce)) {
 			do {
 				nr++;
@@ -413,6 +658,8 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 		if (hit && opt->status_only)
 			break;
 	}
+
+	strbuf_release(&name);
 	return hit;
 }
 
@@ -651,6 +898,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("search in both tracked and untracked files")),
 		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
 			    N_("ignore files specified via '.gitignore'"), 1),
+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
+			 N_("recursivley search in each submodule")),
 		OPT_GROUP(""),
 		OPT_BOOL('v', "invert-match", &opt.invert,
 			N_("show non-matching lines")),
@@ -755,6 +1004,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	init_grep_defaults();
 	git_config(grep_cmd_config, NULL);
 	grep_init(&opt, prefix);
+	super_prefix = get_super_prefix();
 
 	/*
 	 * If there is no -- then the paths must exist in the working
@@ -872,6 +1122,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.max_depth = opt.max_depth;
 	pathspec.recursive = 1;
 
+	if (recurse_submodules) {
+		gitmodules_config();
+		compile_submodule_options(&opt, &pathspec, cached, untracked,
+					  opt_exclude, use_index,
+					  pattern_type_arg);
+	}
+
 	if (show_in_pager && (cached || list.nr))
 		die(_("--open-files-in-pager only works on the worktree"));
 
@@ -895,6 +1152,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (recurse_submodules && (!use_index || untracked || list.nr))
+		die(_("option not supported with --recurse-submodules."));
+
 	if (!show_in_pager && !opt.status_only)
 		setup_pager();
 
diff --git a/git.c b/git.c
index efa1059..a156efd 100644
--- a/git.c
+++ b/git.c
@@ -434,7 +434,7 @@ static struct cmd_struct commands[] = {
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id },
-	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
+	{ "grep", cmd_grep, RUN_SETUP_GENTLY | SUPPORT_SUPER_PREFIX },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
new file mode 100755
index 0000000..1019125
--- /dev/null
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -0,0 +1,99 @@
+#!/bin/sh
+
+test_description='Test grep recurse-submodules feature
+
+This test verifies the recurse-submodules feature correctly greps across
+submodules.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup directory structure and submodule' '
+	echo "foobar" >a &&
+	mkdir b &&
+	echo "bar" >b/b &&
+	git add a b &&
+	git commit -m "add a and b" &&
+	git init submodule &&
+	echo "foobar" >submodule/a &&
+	git -C submodule add a &&
+	git -C submodule commit -m "add a" &&
+	git submodule add ./submodule &&
+	git commit -m "added submodule"
+'
+
+test_expect_success 'grep correctly finds patterns in a submodule' '
+	cat >expect <<-\EOF &&
+	a:foobar
+	b/b:bar
+	submodule/a:foobar
+	EOF
+
+	git grep -e "bar" --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep and basic pathspecs' '
+	cat >expect <<-\EOF &&
+	submodule/a:foobar
+	EOF
+
+	git grep -e. --recurse-submodules -- submodule >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep and nested submodules' '
+	git init submodule/sub &&
+	echo "foobar" >submodule/sub/a &&
+	git -C submodule/sub add a &&
+	git -C submodule/sub commit -m "add a" &&
+	git -C submodule submodule add ./sub &&
+	git -C submodule add sub &&
+	git -C submodule commit -m "added sub" &&
+	git add submodule &&
+	git commit -m "updated submodule" &&
+
+	cat >expect <<-\EOF &&
+	a:foobar
+	b/b:bar
+	submodule/a:foobar
+	submodule/sub/a:foobar
+	EOF
+
+	git grep -e "bar" --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep and multiple patterns' '
+	cat >expect <<-\EOF &&
+	a:foobar
+	submodule/a:foobar
+	submodule/sub/a:foobar
+	EOF
+
+	git grep -e "bar" --and -e "foo" --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep and multiple patterns' '
+	cat >expect <<-\EOF &&
+	b/b:bar
+	EOF
+
+	git grep -e "bar" --and --not -e "foo" --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_incompatible_with_recurse_submodules ()
+{
+	test_expect_success "--recurse-submodules and $1 are incompatible" "
+		test_must_fail git grep -e. --recurse-submodules $1 2>actual &&
+		test_i18ngrep 'not supported with --recurse-submodules' actual
+	"
+}
+
+test_incompatible_with_recurse_submodules --untracked
+test_incompatible_with_recurse_submodules --no-index
+test_incompatible_with_recurse_submodules HEAD
+
+test_done
-- 
2.8.0.rc3.226.g39d4020

