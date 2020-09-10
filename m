Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A002AC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3202064B
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ti2ZVogD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgIJRXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgIJRWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:22:16 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA24C06179A
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:22:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z2so5427213qtv.12
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOCt51zmKkQrR3v2gSQ+dAA0ex5Syp9OrbTF/GUegME=;
        b=ti2ZVogD5ucNE9HR9wTlg6zW5U8J9BpCl+Qgi52Gw6DxG1kJ0TXW3KTvb3jJ9bYRJM
         I3278izUjBEAH4ESSWg/UQQ+xBbf+3xO8it/w50hYPONZL2E5ryPnm2wqy9a4/hDmgX7
         pOTvhltVsydMEBGVfpB/OTBUC8F5YSa5ZvjxDbydvUoIihawnnQYCNVN+lQ2PGX3UlWB
         nGyIcbZDHdMxcaa/LQqa7R/GT6MGFjAV+qeiT/BC/4foju762BMh1rE04AX4oAAU+kDh
         E4RVoaRhmKnewb2qathAw2LZIY0C1r9vs3pDDi3L68OazS2/umLPGkmnd1CGREo6Qm7X
         tRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOCt51zmKkQrR3v2gSQ+dAA0ex5Syp9OrbTF/GUegME=;
        b=uewCcq/uyIYQuvD/jCUeHL79HqenKKcRjP+6KvWCv2I7Rx8GaoTUDRoq4pFhpN4Pk6
         KhoPGAHYwxVRlqMFuP4AHTrWWqXY76O/WpSYHGgbu+GOcZICroEQYRENcZDSp3YBbTke
         XeRJiJmsoqbDnio2Tt6eK39qN4RwQh9hr3aXM9R5CVApZqp47YvPhsYastUn495cN7NA
         9VwLXvBzOJYdiFXAib/OFx9gW9/6b1vLH/Y86vFY86V6nrcjz3vdgHeRXWEkT3CmYUCX
         2fb8TPNOkQzbz9YBAU1N5OzgzNv8elYpCcEDkeJjZrWiDwsNomJGNaV7fKV/sn54UOC+
         ItHg==
X-Gm-Message-State: AOAM532T7j17DFbzWuiiF4saSZRT0D772snEnaokAm5VH6xifiCxKgHl
        /cpJAwRyZz1Dxt3UyTZsy65QI/O0uRRAfQ==
X-Google-Smtp-Source: ABdhPJwmCDMZFw8yphIHj76VYlq5D0nwBUX0WymKg10UJ1biR+F6GRV5+X3WjF4HHEoeRiIS4OUEpg==
X-Received: by 2002:ac8:310c:: with SMTP id g12mr8970527qtb.281.1599758522030;
        Thu, 10 Sep 2020 10:22:02 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id h18sm7037437qkl.12.2020.09.10.10.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:22:01 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v6 7/9] config: correctly read worktree configs in submodules
Date:   Thu, 10 Sep 2020 14:21:26 -0300
Message-Id: <3a28b8e608c727d0e184fadf34ba4113933517c5.1599758167.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599758167.git.matheus.bernardino@usp.br>
References: <cover.1599758167.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The config machinery is not able to read worktree configs from a
submodule in a process where the_repository represents the superproject
and extensions.worktreeConfig is not set there. Furthermore, when
extensions.worktreeConfig is set on the superproject, querying for a
worktree config in a submodule will, instead, return the value set at
the superproject.

The relevant code is in do_git_config_sequence(). Although it is
designed to act on an arbitrary repository, specified in the passed-in
`struct config_options`, it accidentally depends on the_repository in
two places:

- it reads the global variable `repository_format_worktree_config`,
  which is set based on the content of the_repository, to determine
  whether extensions.worktreeConfig is set.

- it uses the git_pathdup() helper to find the config.worktree file,
  instead of making a path using the passed-in repository.

Sever these dependencies and add a regression test. Also, to avoid
future misuses of `repository_format_worktree_config` like this one,
remove this global variable and store the config value on
`struct repository` itself.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/config.c           |  2 +-
 cache.h                    |  1 -
 config.c                   | 12 +++++---
 environment.c              |  1 -
 repository.c               |  1 +
 repository.h               |  1 +
 setup.c                    |  4 +--
 t/helper/test-config.c     | 62 ++++++++++++++++++++++++++++++++------
 t/t2404-worktree-config.sh | 16 ++++++++++
 9 files changed, 81 insertions(+), 19 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ca4caedf33..586faad359 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -673,7 +673,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		given_config_source.scope = CONFIG_SCOPE_LOCAL;
 	} else if (use_worktree_config) {
 		struct worktree **worktrees = get_worktrees();
-		if (repository_format_worktree_config)
+		if (!nongit && the_repository->worktree_config_extension)
 			given_config_source.file = git_pathdup("config.worktree");
 		else if (worktrees[0] && worktrees[1])
 			die(_("--worktree cannot be used with multiple "
diff --git a/cache.h b/cache.h
index 4cad61ffa4..4cdce7b68f 100644
--- a/cache.h
+++ b/cache.h
@@ -1029,7 +1029,6 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
-extern int repository_format_worktree_config;
 
 /*
  * You _have_ to initialize a `struct repository_format` using
diff --git a/config.c b/config.c
index 97f3022c92..38c177d1e5 100644
--- a/config.c
+++ b/config.c
@@ -1747,11 +1747,13 @@ static int do_git_config_sequence(const struct config_options *opts,
 		ret += git_config_from_file(fn, repo_config, data);
 
 	current_parsing_scope = CONFIG_SCOPE_WORKTREE;
-	if (!opts->ignore_worktree && repository_format_worktree_config) {
-		char *path = git_pathdup("config.worktree");
-		if (!access_or_die(path, R_OK, 0))
-			ret += git_config_from_file(fn, path, data);
-		free(path);
+	if (!opts->ignore_worktree && opts->repo && opts->repo->gitdir &&
+	    opts->repo->worktree_config_extension) {
+		struct strbuf path = STRBUF_INIT;
+		strbuf_repo_git_path(&path, opts->repo, "config.worktree");
+		if (!access_or_die(path.buf, R_OK, 0))
+			ret += git_config_from_file(fn, path.buf, data);
+		strbuf_release(&path);
 	}
 
 	current_parsing_scope = CONFIG_SCOPE_COMMAND;
diff --git a/environment.c b/environment.c
index bb518c61cd..5bfb8cf9c2 100644
--- a/environment.c
+++ b/environment.c
@@ -32,7 +32,6 @@ int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
-int repository_format_worktree_config;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 char *apply_default_whitespace;
diff --git a/repository.c b/repository.c
index a4174ddb06..8d18d9d3f2 100644
--- a/repository.c
+++ b/repository.c
@@ -170,6 +170,7 @@ int repo_init(struct repository *repo,
 		goto error;
 
 	repo_set_hash_algo(repo, format.hash_algo);
+	repo->worktree_config_extension = format.worktree_config;
 
 	if (worktree)
 		repo_set_worktree(repo, worktree);
diff --git a/repository.h b/repository.h
index 3c1f7d54bd..3d060bc3e6 100644
--- a/repository.h
+++ b/repository.h
@@ -136,6 +136,7 @@ struct repository {
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
+	unsigned worktree_config_extension:1;
 };
 
 extern struct repository *the_repository;
diff --git a/setup.c b/setup.c
index c04cd25a30..73cd42dbbe 100644
--- a/setup.c
+++ b/setup.c
@@ -567,11 +567,11 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 
 	repository_format_precious_objects = candidate->precious_objects;
 	set_repository_format_partial_clone(candidate->partial_clone);
-	repository_format_worktree_config = candidate->worktree_config;
+	the_repository->worktree_config_extension = candidate->worktree_config;
 	string_list_clear(&candidate->unknown_extensions, 0);
 	string_list_clear(&candidate->v1_only_extensions, 0);
 
-	if (repository_format_worktree_config) {
+	if (the_repository->worktree_config_extension) {
 		/*
 		 * pick up core.bare and core.worktree from per-worktree
 		 * config if present
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 06c61d91e1..87488aab6b 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -2,12 +2,20 @@
 #include "cache.h"
 #include "config.h"
 #include "string-list.h"
+#include "submodule-config.h"
+#include "parse-options.h"
 
 /*
  * This program exposes the C API of the configuration mechanism
  * as a set of simple commands in order to facilitate testing.
  *
- * Reads stdin and prints result of command to stdout:
+ * Usage: test-tool config [--submodule=<path>] <cmd> [<args>]
+ *
+ * If --submodule=<path> is given, <cmd> will operate on the submodule at the
+ * given <path>. This option is not valid for the commands: read_early_config,
+ * configset_get_value and configset_get_value_multi.
+ *
+ * Possible cmds are:
  *
  * get_value -> prints the value with highest priority for the entered key
  *
@@ -72,14 +80,34 @@ static int early_config_cb(const char *var, const char *value, void *vdata)
 #define TC_VALUE_NOT_FOUND 1
 #define TC_CONFIG_FILE_ERROR 2
 
+static const char *test_config_usage[] = {
+	"test-tool config [--submodule=<path>] <cmd> [<args>]",
+	NULL
+};
+
 int cmd__config(int argc, const char **argv)
 {
 	int i, val, ret = 0;
 	const char *v;
 	const struct string_list *strptr;
 	struct config_set cs;
+	struct repository subrepo, *repo = the_repository;
+	const char *subrepo_path = NULL;
+
+	struct option options[] = {
+		OPT_STRING(0, "submodule", &subrepo_path, "path",
+			   "run <cmd> on the submodule at <path>"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options, test_config_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc < 2)
+		usage_with_options(test_config_usage, options);
 
 	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
+		if (subrepo_path)
+			die("cannot use --submodule with read_early_config");
 		read_early_config(early_config_cb, (void *)argv[2]);
 		return 0;
 	}
@@ -88,11 +116,18 @@ int cmd__config(int argc, const char **argv)
 
 	git_configset_init(&cs);
 
-	if (argc < 2)
-		die("Please, provide a command name on the command-line");
+	if (subrepo_path) {
+		const struct submodule *sub;
+
+		sub = submodule_from_path(the_repository, &null_oid, subrepo_path);
+		if (!sub || repo_submodule_init(&subrepo, the_repository, sub))
+			die("invalid argument to --submodule: '%s'", subrepo_path);
+
+		repo = &subrepo;
+	}
 
 	if (argc == 3 && !strcmp(argv[1], "get_value")) {
-		if (!git_config_get_value(argv[2], &v)) {
+		if (!repo_config_get_value(repo, argv[2], &v)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
@@ -102,7 +137,7 @@ int cmd__config(int argc, const char **argv)
 			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
-		strptr = git_config_get_value_multi(argv[2]);
+		strptr = repo_config_get_value_multi(repo, argv[2]);
 		if (strptr) {
 			for (i = 0; i < strptr->nr; i++) {
 				v = strptr->items[i].string;
@@ -116,27 +151,31 @@ int cmd__config(int argc, const char **argv)
 			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
-		if (!git_config_get_int(argv[2], &val)) {
+		if (!repo_config_get_int(repo, argv[2], &val)) {
 			printf("%d\n", val);
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
-		if (!git_config_get_bool(argv[2], &val)) {
+		if (!repo_config_get_bool(repo, argv[2], &val)) {
 			printf("%d\n", val);
 		} else {
+
 			printf("Value not found for \"%s\"\n", argv[2]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_string")) {
-		if (!git_config_get_string_tmp(argv[2], &v)) {
+		if (!repo_config_get_string_tmp(repo, argv[2], &v)) {
 			printf("%s\n", v);
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
+		if (subrepo_path)
+			die("cannot use --submodule with configset_get_value");
+
 		for (i = 3; i < argc; i++) {
 			int err;
 			if ((err = git_configset_add_file(&cs, argv[i]))) {
@@ -155,6 +194,9 @@ int cmd__config(int argc, const char **argv)
 			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
+		if (subrepo_path)
+			die("cannot use --submodule with configset_get_value_multi");
+
 		for (i = 3; i < argc; i++) {
 			int err;
 			if ((err = git_configset_add_file(&cs, argv[i]))) {
@@ -177,12 +219,14 @@ int cmd__config(int argc, const char **argv)
 			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (!strcmp(argv[1], "iterate")) {
-		git_config(iterate_cb, NULL);
+		repo_config(repo, iterate_cb, NULL);
 	} else {
 		die("%s: Please check the syntax and the function name", argv[0]);
 	}
 
 out:
 	git_configset_clear(&cs);
+	if (repo != the_repository)
+		repo_clear(repo);
 	return ret;
 }
diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
index 9536d10919..1e32c93735 100755
--- a/t/t2404-worktree-config.sh
+++ b/t/t2404-worktree-config.sh
@@ -78,4 +78,20 @@ test_expect_success 'config.worktree no longer read without extension' '
 	test_cmp_config -C wt2 shared this.is
 '
 
+test_expect_success 'correctly read config.worktree from submodules' '
+	test_unconfig extensions.worktreeConfig &&
+	git init sub &&
+	(
+		cd sub &&
+		test_commit A &&
+		git config extensions.worktreeConfig true &&
+		git config --worktree wtconfig.sub test-value
+	) &&
+	git submodule add ./sub &&
+	git commit -m "add sub" &&
+	echo test-value >expect &&
+	test-tool config --submodule=sub get_value wtconfig.sub >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.28.0

