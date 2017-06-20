Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC84820D11
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbdFTTUr (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:47 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34229 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbdFTTUp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:45 -0400
Received: by mail-pg0-f47.google.com with SMTP id e187so14381248pgc.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5UJi01hutieWDuv/Cx5b5XEA5C0fvilr26Lilu1qezw=;
        b=naYe3DXIHPZX8n/IyM2SuQkGKoVxrq2a1T+mvm2QuJNPeLprFXFAGv1KJnoTE1jwSp
         /DEPuv/ILjrkfJY+CtwXUN/Ra3fVIK7M5iI5HKUfs2B3sQ9OlXCIp3WFbRTsDrNgyvo2
         wEbdb6k0CGts2/yypf/KwiImvYUOdAwezVhmBXPtxPaHQE9Ux3PDv9YjEaqhZ1+/6Gsa
         skdUdLTm1WjWm9CcVQZmQraCyah6r228VT0SnEL7ECamr80vLhy2T2uLD/Q2AWKwNAI2
         EIE+BIG0/zSIn+3d/OrTDnIFfKhs2TZjd2YtPTFpRtDJZCC1YpWf+QFO9DUR7HnV5kiE
         3bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5UJi01hutieWDuv/Cx5b5XEA5C0fvilr26Lilu1qezw=;
        b=jlj2nKgUc7Il0n7qawNVbW6vOBe81zoMVOBr+WeWSd05T8T6Td9lFRjiP0Feb3e7uZ
         WRzHWFqMKOrYhaYumwIrpVRUMmLoD3EAgt+5xGtTFO9bkSOGENVUlc+3kv3dIx9uzyKn
         NR8780oDiUqa1QYz150W0o/Sftk+nlDZxCMAeooQASrZSvsiwV2uxD7Fom6Mi2IMtHkn
         QxuKwFJA4BLIuk3OvM/MQ3cRKG/S4VnhZWHt5/Z/X97BwUGgw4I3YceagE0N5XaHPnVM
         R8gQ+fXrpyy66WoBD3nmSkuKxRuhiMUT6e7l/Lvqg+4PK2gMeYup2x8omBPdrGCBhYvc
         5P6w==
X-Gm-Message-State: AKS2vOwl7zwLOzLdOOzBVIQWDoBfaL2wa0tdPREiiOblCizTz6Y/WZH7
        NmFrO7Jt1Zui4ebxHS//kw==
X-Received: by 10.99.143.94 with SMTP id r30mr29047669pgn.102.1497986444312;
        Tue, 20 Jun 2017 12:20:44 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:43 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 20/20] ls-files: use repository object
Date:   Tue, 20 Jun 2017 12:19:51 -0700
Message-Id: <20170620191951.84791-21-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert ls-files to use a repository struct and recurse submodules
inprocess.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c                     | 195 ++++++++++++++-------------------
 git.c                                  |   2 +-
 t/t3007-ls-files-recurse-submodules.sh |  39 +++++++
 3 files changed, 120 insertions(+), 116 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b12d0bb61..f5f36ddb4 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -5,7 +5,9 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "quote.h"
 #include "dir.h"
@@ -32,10 +34,8 @@ static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
-static struct argv_array submodule_options = ARGV_ARRAY_INIT;
 
 static const char *prefix;
-static const char *super_prefix;
 static int max_prefix_len;
 static int prefix_len;
 static struct pathspec pathspec;
@@ -73,25 +73,12 @@ static void write_eolinfo(const struct index_state *istate,
 
 static void write_name(const char *name)
 {
-	/*
-	 * Prepend the super_prefix to name to construct the full_name to be
-	 * written.
-	 */
-	struct strbuf full_name = STRBUF_INIT;
-	if (super_prefix) {
-		strbuf_addstr(&full_name, super_prefix);
-		strbuf_addstr(&full_name, name);
-		name = full_name.buf;
-	}
-
 	/*
 	 * With "--full-name", prefix_len=0; this caller needs to pass
 	 * an empty string in that case (a NULL is good for "").
 	 */
 	write_name_quoted_relative(name, prefix_len ? prefix : NULL,
 				   stdout, line_terminator);
-
-	strbuf_release(&full_name);
 }
 
 static const char *get_tag(const struct cache_entry *ce, const char *tag)
@@ -210,83 +197,38 @@ static void show_killed_files(const struct index_state *istate,
 	}
 }
 
-/*
- * Compile an argv_array with all of the options supported by --recurse_submodules
- */
-static void compile_submodule_options(const char **argv,
-				      const struct dir_struct *dir,
-				      int show_tag)
-{
-	if (line_terminator == '\0')
-		argv_array_push(&submodule_options, "-z");
-	if (show_tag)
-		argv_array_push(&submodule_options, "-t");
-	if (show_valid_bit)
-		argv_array_push(&submodule_options, "-v");
-	if (show_cached)
-		argv_array_push(&submodule_options, "--cached");
-	if (show_eol)
-		argv_array_push(&submodule_options, "--eol");
-	if (debug_mode)
-		argv_array_push(&submodule_options, "--debug");
-
-	/* Add Pathspecs */
-	argv_array_push(&submodule_options, "--");
-	for (; *argv; argv++)
-		argv_array_push(&submodule_options, *argv);
-}
+static void show_files(struct repository *repo, struct dir_struct *dir);
 
-/**
- * Recursively call ls-files on a submodule
- */
-static void show_gitlink(const struct cache_entry *ce)
+static void show_submodule(struct repository *superproject,
+			   struct dir_struct *dir, const char *path)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	int status;
-	char *dir;
-
-	prepare_submodule_repo_env(&cp.env_array);
-	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
-
-	if (prefix_len)
-		argv_array_pushf(&cp.env_array, "%s=%s",
-				 GIT_TOPLEVEL_PREFIX_ENVIRONMENT,
-				 prefix);
-	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
-			 super_prefix ? super_prefix : "",
-			 ce->name);
-	argv_array_push(&cp.args, "ls-files");
-	argv_array_push(&cp.args, "--recurse-submodules");
-
-	/* add supported options */
-	argv_array_pushv(&cp.args, submodule_options.argv);
-
-	cp.git_cmd = 1;
-	dir = mkpathdup("%s/%s", get_git_work_tree(), ce->name);
-	cp.dir = dir;
-	status = run_command(&cp);
-	free(dir);
-	if (status)
-		exit(status);
+	struct repository submodule;
+
+	if (repo_submodule_init(&submodule, superproject, path))
+		return;
+
+	if (repo_read_index(&submodule) < 0)
+		die("index file corrupt");
+
+	repo_read_gitmodules(&submodule);
+
+	show_files(&submodule, dir);
+
+	repo_clear(&submodule);
 }
 
-static void show_ce_entry(const struct index_state *istate,
-			  const char *tag, const struct cache_entry *ce)
+static void show_ce(struct repository *repo, struct dir_struct *dir,
+		    const struct cache_entry *ce, const char *fullname,
+		    const char *tag)
 {
-	struct strbuf name = STRBUF_INIT;
-	int len = max_prefix_len;
-	if (super_prefix)
-		strbuf_addstr(&name, super_prefix);
-	strbuf_addstr(&name, ce->name);
-
-	if (len > ce_namelen(ce))
+	if (max_prefix_len > strlen(fullname))
 		die("git ls-files: internal error - cache entry not superset of prefix");
 
 	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
-	    submodule_path_match(&pathspec, name.buf, ps_matched)) {
-		show_gitlink(ce);
-	} else if (match_pathspec(&pathspec, name.buf, name.len,
-				  len, ps_matched,
+	    is_submodule_active(repo, ce->name)) {
+		show_submodule(repo, dir, ce->name);
+	} else if (match_pathspec(&pathspec, fullname, strlen(fullname),
+				  max_prefix_len, ps_matched,
 				  S_ISDIR(ce->ce_mode) ||
 				  S_ISGITLINK(ce->ce_mode))) {
 		tag = get_tag(ce, tag);
@@ -300,12 +242,10 @@ static void show_ce_entry(const struct index_state *istate,
 			       find_unique_abbrev(ce->oid.hash, abbrev),
 			       ce_stage(ce));
 		}
-		write_eolinfo(istate, ce, ce->name);
-		write_name(ce->name);
+		write_eolinfo(repo->index, ce, fullname);
+		write_name(fullname);
 		print_debug(ce);
 	}
-
-	strbuf_release(&name);
 }
 
 static void show_ru_info(const struct index_state *istate)
@@ -338,59 +278,79 @@ static void show_ru_info(const struct index_state *istate)
 }
 
 static int ce_excluded(struct dir_struct *dir, struct index_state *istate,
-		       const struct cache_entry *ce)
+		       const char *fullname, const struct cache_entry *ce)
 {
 	int dtype = ce_to_dtype(ce);
-	return is_excluded(dir, istate, ce->name, &dtype);
+	return is_excluded(dir, istate, fullname, &dtype);
 }
 
-static void show_files(struct index_state *istate, struct dir_struct *dir)
+static void construct_fullname(struct strbuf *out, const struct repository *repo,
+			       const struct cache_entry *ce)
+{
+	strbuf_reset(out);
+	if (repo->submodule_prefix)
+		strbuf_addstr(out, repo->submodule_prefix);
+	strbuf_addstr(out, ce->name);
+}
+
+static void show_files(struct repository *repo, struct dir_struct *dir)
 {
 	int i;
+	struct strbuf fullname = STRBUF_INIT;
 
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
 		if (!show_others)
 			dir->flags |= DIR_COLLECT_KILLED_ONLY;
-		fill_directory(dir, istate, &pathspec);
+		fill_directory(dir, repo->index, &pathspec);
 		if (show_others)
-			show_other_files(istate, dir);
+			show_other_files(repo->index, dir);
 		if (show_killed)
-			show_killed_files(istate, dir);
+			show_killed_files(repo->index, dir);
 	}
 	if (show_cached || show_stage) {
-		for (i = 0; i < istate->cache_nr; i++) {
-			const struct cache_entry *ce = istate->cache[i];
+		for (i = 0; i < repo->index->cache_nr; i++) {
+			const struct cache_entry *ce = repo->index->cache[i];
+
+			construct_fullname(&fullname, repo, ce);
+
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, istate, ce))
+			    !ce_excluded(dir, repo->index, fullname.buf, ce))
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
-			show_ce_entry(istate, ce_stage(ce) ? tag_unmerged :
-				(ce_skip_worktree(ce) ? tag_skip_worktree : tag_cached), ce);
+			show_ce(repo, dir, ce, fullname.buf,
+				ce_stage(ce) ? tag_unmerged :
+				(ce_skip_worktree(ce) ? tag_skip_worktree :
+				 tag_cached));
 		}
 	}
 	if (show_deleted || show_modified) {
-		for (i = 0; i < istate->cache_nr; i++) {
-			const struct cache_entry *ce = istate->cache[i];
+		for (i = 0; i < repo->index->cache_nr; i++) {
+			const struct cache_entry *ce = repo->index->cache[i];
 			struct stat st;
 			int err;
+
+			construct_fullname(&fullname, repo, ce);
+
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, istate, ce))
+			    !ce_excluded(dir, repo->index, fullname.buf, ce))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
 			if (ce_skip_worktree(ce))
 				continue;
-			err = lstat(ce->name, &st);
+			err = lstat(fullname.buf, &st);
 			if (show_deleted && err)
-				show_ce_entry(istate, tag_removed, ce);
-			if (show_modified && ie_modified(istate, ce, &st, 0))
-				show_ce_entry(istate, tag_modified, ce);
+				show_ce(repo, dir, ce, fullname.buf, tag_removed);
+			if (show_modified && ie_modified(repo->index, ce, &st, 0))
+				show_ce(repo, dir, ce, fullname.buf, tag_modified);
 		}
 	}
+
+	strbuf_release(&fullname);
 }
 
 /*
@@ -615,10 +575,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	prefix = cmd_prefix;
 	if (prefix)
 		prefix_len = strlen(prefix);
-	super_prefix = get_super_prefix();
 	git_config(git_default_config, NULL);
 
-	if (read_cache() < 0)
+	if (repo_read_index(the_repository) < 0)
 		die("index file corrupt");
 
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
@@ -651,8 +610,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
-	if (recurse_submodules)
-		compile_submodule_options(argv, &dir, show_tag);
+	if (recurse_submodules) {
+		repo_read_gitmodules(the_repository);
+	}
 
 	if (recurse_submodules &&
 	    (show_stage || show_deleted || show_others || show_unmerged ||
@@ -670,7 +630,10 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	/*
 	 * Find common prefix for all pathspec's
 	 * This is used as a performance optimization which unfortunately cannot
-	 * be done when recursing into submodules
+	 * be done when recursing into submodules because when a pathspec is
+	 * given which spans repository boundaries you can't simply remove the
+	 * submodule entry because the pathspec may match something inside the
+	 * submodule.
 	 */
 	if (recurse_submodules)
 		max_prefix = NULL;
@@ -678,7 +641,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = get_common_prefix_len(max_prefix);
 
-	prune_index(&the_index, max_prefix, max_prefix_len);
+	prune_index(the_repository->index, max_prefix, max_prefix_len);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec.nr && error_unmatch)
@@ -699,11 +662,13 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		 */
 		if (show_stage || show_unmerged)
 			die("ls-files --with-tree is incompatible with -s or -u");
-		overlay_tree_on_index(&the_index, with_tree, max_prefix);
+		overlay_tree_on_index(the_repository->index, with_tree, max_prefix);
 	}
-	show_files(&the_index, &dir);
+
+	show_files(the_repository, &dir);
+
 	if (show_resolve_undo)
-		show_ru_info(&the_index);
+		show_ru_info(the_repository->index);
 
 	if (ps_matched) {
 		int bad;
diff --git a/git.c b/git.c
index 5be27b07e..489aab4d8 100644
--- a/git.c
+++ b/git.c
@@ -400,7 +400,7 @@ static struct cmd_struct commands[] = {
 	{ "init-db", cmd_init_db },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
 	{ "log", cmd_log, RUN_SETUP },
-	{ "ls-files", cmd_ls_files, RUN_SETUP | SUPPORT_SUPER_PREFIX },
+	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index ebb956fd1..318b5bce7 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -135,6 +135,45 @@ test_expect_success '--recurse-submodules and pathspecs setup' '
 	test_cmp expect actual
 '
 
+test_expect_success 'inactive submodule' '
+	test_when_finished "git config --bool submodule.submodule.active true" &&
+	test_when_finished "git -C submodule config --bool submodule.subsub.active true" &&
+	git config --bool submodule.submodule.active "false" &&
+
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	h.txt
+	sib/file
+	sub/file
+	submodule
+	EOF
+
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual &&
+
+	git config --bool submodule.submodule.active "true" &&
+	git -C submodule config --bool submodule.subsub.active "false" &&
+
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	h.txt
+	sib/file
+	sub/file
+	submodule/.gitmodules
+	submodule/c
+	submodule/f.TXT
+	submodule/g.txt
+	submodule/subsub
+	EOF
+
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--recurse-submodules and pathspecs' '
 	cat >expect <<-\EOF &&
 	h.txt
-- 
2.13.1.611.g7e3b11ae1-goog

