Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2865F1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbdEaVpm (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:42 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36159 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdEaVpX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:23 -0400
Received: by mail-pf0-f172.google.com with SMTP id m17so18559371pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hYPxgHtO+QVcKAP3HYsFtbEkaI4GfjL7lUE5bbNWYzo=;
        b=AmJZFvxoL8M43wB4pimdl2ip4S22Rxu81FIo0Yc+oBvoHm5D7OM2kEBNF1mJwV3s1c
         Ly64TAJiosIzXWbtUDFEnY7OrPTIjtc5ekvfl0I4SVaUBG10LY9Giy4hiBGaD0VaVjdI
         P88cVYjG7vdFb1wkks+2SdQ63yBW8rwS0OEsYE1MaFfi52j7/ZhrStR6WT5J9B7QS6Ry
         Zv8STCk0zXJL0vkYtsJHWhz/eDk2aJymkY3TgJEGy8cGJmUtV/i7jn8DoUcgig4oamMG
         l6ehQ0vNlVuoSXWh6VClYRAyBvYxqcGF1HJSpEvFXuMSWVevhpON9ElFwlv8WCsmx81M
         72Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hYPxgHtO+QVcKAP3HYsFtbEkaI4GfjL7lUE5bbNWYzo=;
        b=WQM7T0xIQP1BlVbr6DxH0fJLtdpJW3oywQ937nDUozysXL/uLsAyDmiGUrtxV+w4Cc
         DwaixRasSnPJV14wIk7Gg8zOqVCRfg9bds7VW3ktkc1yGn93uirklswFPqLa5TXiIQYZ
         qsQltwc/wzBJFj4ulDIua3DN5JiqN8TrfN8cZjImtBoGleC11k5zjVgDbmS3b3rhL6o6
         q9WzZLQb8xlMljGlsj8IqGUgd/mblEzJQ4MnLasJ8hkizhZvSp+ysBiEGpW9nNQz+mMq
         tA6Hi5fhkSjWauyKe4yVQGVyi2g8kFZIIkdBktfrPCh/tA49OB4u/AwOiNiXEpfNa30c
         b70w==
X-Gm-Message-State: AODbwcChWCLXo2ugaZf6EUVDHwdsnLsTzNRnOESYGDvbCRYMQxmv1RAT
        KgbkqmaO1mgU+3O6
X-Received: by 10.84.167.168 with SMTP id d37mr65937226plb.125.1496267122666;
        Wed, 31 May 2017 14:45:22 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:45:21 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 31/31] ls-files: use repository object
Date:   Wed, 31 May 2017 14:44:17 -0700
Message-Id: <20170531214417.38857-32-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert ls-files to use a repository struct and recurse submodules
inprocess.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c                     | 211 ++++++++++++++-------------------
 git.c                                  |   2 +-
 repo.c                                 |   3 +
 repo.h                                 |   1 +
 t/t3007-ls-files-recurse-submodules.sh |  39 ++++++
 5 files changed, 135 insertions(+), 121 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 6a0302a28..46962815f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -5,6 +5,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "quote.h"
@@ -17,6 +18,7 @@
 #include "pathspec.h"
 #include "run-command.h"
 #include "submodule.h"
+#include "repo.h"
 
 static int abbrev;
 static int show_deleted;
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
@@ -210,101 +197,59 @@ static void show_killed_files(const struct index_state *istate,
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
+static void show_files(struct repo *repo, struct dir_struct *dir);
 
-/**
- * Recursively call ls-files on a submodule
- */
-static void show_gitlink(const struct cache_entry *ce)
+static void show_submodule(const struct repo *superproject,
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
+	struct repo submodule;
+	char *gitdir = mkpathdup("%s/%s", superproject->worktree, path);
+	repo_init(&submodule, gitdir);
+
+	repo_read_index(&submodule);
+	repo_read_gitmodules(&submodule);
+
+	if (superproject->submodule_prefix)
+		submodule.submodule_prefix = xstrfmt("%s%s/", superproject->submodule_prefix, path);
+	else
+		submodule.submodule_prefix = xstrfmt("%s/", path);
+	show_files(&submodule, dir);
+
+	repo_clear(&submodule);
+	free(gitdir);
 }
 
-static void show_ce_entry(const char *tag, const struct cache_entry *ce)
+static void show_ce(struct repo *repo, struct dir_struct *dir,
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
+	    submodule_path_match(&pathspec, fullname, ps_matched) &&
+	    is_submodule_active(repo, ce->name)) {
+		show_submodule(repo, dir, ce->name);
+	} else if (match_pathspec(&pathspec, fullname, strlen(fullname),
+				  max_prefix_len, ps_matched,
 				  S_ISDIR(ce->ce_mode) ||
 				  S_ISGITLINK(ce->ce_mode))) {
 		tag = get_tag(ce, tag);
 
-		if (!show_stage) {
-			fputs(tag, stdout);
-		} else {
+		if (show_stage) {
 			printf("%s%06o %s %d\t",
 			       tag,
 			       ce->ce_mode,
 			       find_unique_abbrev(ce->oid.hash, abbrev),
 			       ce_stage(ce));
+		} else {
+			fputs(tag, stdout);
 		}
-		write_eolinfo(&the_index, ce, ce->name);
-		write_name(ce->name);
+
+		write_eolinfo(repo->index, ce, fullname);
+		write_name(fullname);
 		print_debug(ce);
 	}
-
-	strbuf_release(&name);
 }
 
 static void show_ru_info(const struct index_state *istate)
@@ -337,59 +282,80 @@ static void show_ru_info(const struct index_state *istate)
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
+static void construct_fullname(struct strbuf *out, const struct repo *repo,
+			       const struct cache_entry *ce)
+{
+	strbuf_reset(out);
+	if (repo->submodule_prefix)
+		strbuf_addstr(out, repo->submodule_prefix);
+	strbuf_addstr(out, ce->name);
+
+}
+
+static void show_files(struct repo *repo, struct dir_struct *dir)
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
-			show_ce_entry(ce_stage(ce) ? tag_unmerged :
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
-				show_ce_entry(tag_removed, ce);
-			if (show_modified && ie_modified(istate, ce, &st, 0))
-				show_ce_entry(tag_modified, ce);
+				show_ce(repo, dir, ce, fullname.buf, tag_removed);
+			if (show_modified && ie_modified(repo->index, ce, &st, 0))
+				show_ce(repo, dir, ce, fullname.buf, tag_modified);
 		}
 	}
+
+	strbuf_release(&fullname);
 }
 
 /*
@@ -544,7 +510,7 @@ static int option_parse_exclude_standard(const struct option *opt,
 int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
 	int require_work_tree = 0, show_tag = 0, i;
-	const char *max_prefix;
+	char *max_prefix;
 	struct dir_struct dir;
 	struct exclude_list *el;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
@@ -614,11 +580,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	prefix = cmd_prefix;
 	if (prefix)
 		prefix_len = strlen(prefix);
-	super_prefix = get_super_prefix();
 	git_config(git_default_config, NULL);
 
-	if (read_cache() < 0)
-		die("index file corrupt");
+	repo_read_index(&the_repository);
 
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
@@ -650,12 +614,14 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
-	if (recurse_submodules)
-		compile_submodule_options(argv, &dir, show_tag);
+	if (recurse_submodules) {
+		repo_read_gitmodules(&the_repository);
+	}
 
 	if (recurse_submodules &&
 	    (show_stage || show_deleted || show_others || show_unmerged ||
-	     show_killed || show_modified || show_resolve_undo || with_tree))
+	     show_killed || show_modified || show_resolve_undo || with_tree ||
+	     show_eol))
 		die("ls-files --recurse-submodules unsupported mode");
 
 	if (recurse_submodules && error_unmatch)
@@ -669,7 +635,10 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
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
@@ -677,7 +646,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = get_common_prefix_len(max_prefix);
 
-	prune_index(&the_index, max_prefix, max_prefix_len);
+	prune_index(the_repository.index, max_prefix, max_prefix_len);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec.nr && error_unmatch)
@@ -698,11 +667,13 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		 */
 		if (show_stage || show_unmerged)
 			die("ls-files --with-tree is incompatible with -s or -u");
-		overlay_tree_on_index(&the_index, with_tree, max_prefix);
+		overlay_tree_on_index(the_repository.index, with_tree, max_prefix);
 	}
-	show_files(&the_index, &dir);
+
+	show_files(&the_repository, &dir);
+
 	if (show_resolve_undo)
-		show_ru_info(&the_index);
+		show_ru_info(the_repository.index);
 
 	if (ps_matched) {
 		int bad;
diff --git a/git.c b/git.c
index 594436e43..16c6e325d 100644
--- a/git.c
+++ b/git.c
@@ -442,7 +442,7 @@ static struct cmd_struct commands[] = {
 	{ "init-db", cmd_init_db },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
 	{ "log", cmd_log, RUN_SETUP },
-	{ "ls-files", cmd_ls_files, RUN_SETUP | SUPPORT_SUPER_PREFIX },
+	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
diff --git a/repo.c b/repo.c
index 6f7b2015f..01001e577 100644
--- a/repo.c
+++ b/repo.c
@@ -154,6 +154,7 @@ int repo_init(struct repo *repo, const char *gitdir)
 	}
 
 	repo_set_gitdir(repo, resolved_gitdir);
+	repo_set_worktree(repo, gitdir);
 
 	/* NEEDSWORK: Verify repository format version */
 
@@ -169,6 +170,8 @@ void repo_clear(struct repo *repo)
 	repo_clear_env(repo);
 	free(repo->worktree);
 	repo->worktree = NULL;
+	free(repo->submodule_prefix);
+	repo->submodule_prefix = NULL;
 
 	if (repo->config) {
 		git_configset_clear(repo->config);
diff --git a/repo.h b/repo.h
index ad0184eaa..cb83f765b 100644
--- a/repo.h
+++ b/repo.h
@@ -14,6 +14,7 @@ struct repo {
 	char *graft_file;
 	char *namespace;
 	char *worktree;
+	char *submodule_prefix;
 
 	/* Subsystems */
 	/*
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
2.13.0.506.g27d5fe0cd-goog

