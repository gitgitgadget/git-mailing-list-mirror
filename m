Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48C0C433E2
	for <git@archiver.kernel.org>; Thu, 28 May 2020 01:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9FF208B8
	for <git@archiver.kernel.org>; Thu, 28 May 2020 01:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="jnUr5B2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgE1BNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 21:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgE1BNu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 21:13:50 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9EC05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 18:13:50 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c185so1642063qke.7
        for <git@vger.kernel.org>; Wed, 27 May 2020 18:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTlFEnOPMIEPQscrGGxHcP+GTuaiBD3/F6KgeOc9eAw=;
        b=jnUr5B2tvm/1qU8nxyK0eXEATWEfAef2AlOAkU/72oh0S5B3mxeMPLIGpHestti/+g
         HoHZWqA95aVoFxTERspnwyb1o1qs6Pf/oQHLv2yi9WjH7bjzsA/eruXIEjl8ikMRxbot
         J7dB6Q0M+cHT9lttELtqACTj4zDU8u2blD5l3+0OzgSTN2EHNzMqZ2m54hwpJ05AsWV3
         6b2uwe0hJi1uIVBLmqOOptRTNl1Q3df4/OafU/Js32DR3zXulfKUyLAD25be7msG210J
         MEZaYoTTpgsxtShouXBgpwDGiSw5vuqzWtuxscVzpmsoHI2oUDz7v2xGfECLvctFzJ0T
         AgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTlFEnOPMIEPQscrGGxHcP+GTuaiBD3/F6KgeOc9eAw=;
        b=ChpxAmkqqnYn5nQuhRQYUaqOsQ0aYHiUMDUggNf0uPz/9Rd1heQooz10Y5Ki3Kj04b
         vJmXzMp0vf8JaHlULaVZtQz9eNDDoHtgsDCN2z48tvSq4Flr7pXPop5bzdgteB2PZVGd
         SNLBI2oODCIbe0dAFI/ldwFvASrnAejH0i8KKUEaf4xfOE0TyGtDdymRlKewNxgIL8fq
         hZOLAoKOVBFGkWktc+DJpqSXNGyIB2ehE1OoivC21gx/KqMwlvMLKfAeY0oZkFZa7t3B
         VsQgs0ydpPPaeQc/i68C4EqFTIxBqA75/lPwP3mla+MDNooa/u4IGGqtuUJG8ANtMvQl
         /hHg==
X-Gm-Message-State: AOAM530fPL/xEpvedXUAds6rgCBowTbY/r4GOY/GxQH01Gyr4gDoJfIq
        HV73hG2WoFJ+QDX5UlFJTdsImoCW5ED0rQ==
X-Google-Smtp-Source: ABdhPJzxEv8d/utorNnGi6oMYWQVDeyEX+smF9zd/G2y9VkKSIgk4ZY9zOzu+7jS3XipZViLWgiixg==
X-Received: by 2002:a37:9cd5:: with SMTP id f204mr640858qke.346.1590628428547;
        Wed, 27 May 2020 18:13:48 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::1])
        by smtp.gmail.com with ESMTPSA id a188sm3547872qkg.11.2020.05.27.18.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:13:47 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: [PATCH v3 3/5] config: correctly read worktree configs in submodules
Date:   Wed, 27 May 2020 22:13:01 -0300
Message-Id: <448e0efffd0bbc89d8ea891923f242b5123c5826.1590627264.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590627264.git.matheus.bernardino@usp.br>
References: <cover.1590627264.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the steps in do_git_config_sequence() is to load the
worktree-specific config file. Although the function receives a git_dir
string, it relies on git_pathdup(), which uses the_repository->git_dir,
to make the path to the file. Furthermore, it also checks that
extensions.worktreeConfig is set through the
repository_format_worktree_config variable, which refers to
the_repository only. Thus, when a submodule has worktree settings, a
command executed in the superproject that recurses into the submodule
won't find the said settings.

Such a scenario might not be needed now, but it will be in the following
patch. git-grep will learn to honor sparse checkouts and, when running
with --recurse-submodules, the submodule's sparse checkout settings must
be loaded. As these settings are stored in the config.worktree file,
they would be ignored without this patch. So let's fix this by reading
the right config.worktree file and extensions.worktreeConfig setting,
based on the git_dir and commondir paths given to
do_git_config_sequence(). Also add a test to avoid any regressions.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 config.c                   |  21 +++++--
 t/helper/test-config.c     | 119 +++++++++++++++++++++++++++----------
 t/t2404-worktree-config.sh |  16 +++++
 3 files changed, 118 insertions(+), 38 deletions(-)

diff --git a/config.c b/config.c
index 8db9c77098..c2d56309dc 100644
--- a/config.c
+++ b/config.c
@@ -1747,11 +1747,22 @@ static int do_git_config_sequence(const struct config_options *opts,
 		ret += git_config_from_file(fn, repo_config, data);
 
 	current_parsing_scope = CONFIG_SCOPE_WORKTREE;
-	if (!opts->ignore_worktree && repository_format_worktree_config) {
-		char *path = git_pathdup("config.worktree");
-		if (!access_or_die(path, R_OK, 0))
-			ret += git_config_from_file(fn, path, data);
-		free(path);
+	if (!opts->ignore_worktree && repo_config && opts->git_dir) {
+		struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+		struct strbuf buf = STRBUF_INIT;
+
+		read_repository_format(&repo_fmt, repo_config);
+
+		if (!verify_repository_format(&repo_fmt, &buf) &&
+		    repo_fmt.worktree_config) {
+			char *path = mkpathdup("%s/config.worktree", opts->git_dir);
+			if (!access_or_die(path, R_OK, 0))
+				ret += git_config_from_file(fn, path, data);
+			free(path);
+		}
+
+		strbuf_release(&buf);
+		clear_repository_format(&repo_fmt);
 	}
 
 	current_parsing_scope = CONFIG_SCOPE_COMMAND;
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 1c8e965840..284f83a921 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -2,12 +2,19 @@
 #include "cache.h"
 #include "config.h"
 #include "string-list.h"
+#include "submodule-config.h"
 
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
@@ -84,33 +91,63 @@ int cmd__config(int argc, const char **argv)
 	int i, val;
 	const char *v;
 	const struct string_list *strptr;
-	struct config_set cs;
+	struct config_set cs = { .hash_initialized = 0 };
 	enum test_config_exit_code ret = TC_SUCCESS;
+	struct repository *repo = the_repository;
+	const char *subrepo_path = NULL;
+
+	argc--; /* skip over "config" */
+	argv++;
+
+	if (argc == 0)
+		goto print_usage_error;
+
+	if (skip_prefix(*argv, "--submodule=", &subrepo_path)) {
+		argc--;
+		argv++;
+		if (argc == 0)
+			goto print_usage_error;
+	}
 
-	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
-		read_early_config(early_config_cb, (void *)argv[2]);
+	if (argc == 2 && !strcmp(argv[0], "read_early_config")) {
+		if (subrepo_path) {
+			fprintf(stderr, "Cannot use --submodule with read_early_config\n");
+			return TC_USAGE_ERROR;
+		}
+		read_early_config(early_config_cb, (void *)argv[1]);
 		return TC_SUCCESS;
 	}
 
 	setup_git_directory();
-
 	git_configset_init(&cs);
 
-	if (argc < 2)
-		goto print_usage_error;
+	if (subrepo_path) {
+		const struct submodule *sub;
+		struct repository *subrepo = xcalloc(1, sizeof(*repo));
+
+		sub = submodule_from_path(the_repository, &null_oid, subrepo_path);
+		if (!sub || repo_submodule_init(subrepo, the_repository, sub)) {
+			fprintf(stderr, "Invalid argument to --submodule: '%s'\n",
+				subrepo_path);
+			free(subrepo);
+			ret = TC_USAGE_ERROR;
+			goto out;
+		}
+		repo = subrepo;
+	}
 
-	if (argc == 3 && !strcmp(argv[1], "get_value")) {
-		if (!git_config_get_value(argv[2], &v)) {
+	if (argc == 2 && !strcmp(argv[0], "get_value")) {
+		if (!repo_config_get_value(repo, argv[1], &v)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
-		strptr = git_config_get_value_multi(argv[2]);
+	} else if (argc == 2 && !strcmp(argv[0], "get_value_multi")) {
+		strptr = repo_config_get_value_multi(repo, argv[1]);
 		if (strptr) {
 			for (i = 0; i < strptr->nr; i++) {
 				v = strptr->items[i].string;
@@ -120,32 +157,38 @@ int cmd__config(int argc, const char **argv)
 					printf("%s\n", v);
 			}
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
-		if (!git_config_get_int(argv[2], &val)) {
+	} else if (argc == 2 && !strcmp(argv[0], "get_int")) {
+		if (!repo_config_get_int(repo, argv[1], &val)) {
 			printf("%d\n", val);
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
-		if (!git_config_get_bool(argv[2], &val)) {
+	} else if (argc == 2 && !strcmp(argv[0], "get_bool")) {
+		if (!repo_config_get_bool(repo, argv[1], &val)) {
 			printf("%d\n", val);
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (argc == 3 && !strcmp(argv[1], "get_string")) {
-		if (!git_config_get_string_const(argv[2], &v)) {
+	} else if (argc == 2 && !strcmp(argv[0], "get_string")) {
+		if (!repo_config_get_string_const(repo, argv[1], &v)) {
 			printf("%s\n", v);
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
-		for (i = 3; i < argc; i++) {
+	} else if (argc >= 2 && !strcmp(argv[0], "configset_get_value")) {
+		if (subrepo_path) {
+			fprintf(stderr, "Cannot use --submodule with configset_get_value\n");
+			ret = TC_USAGE_ERROR;
+			goto out;
+		}
+		for (i = 2; i < argc; i++) {
 			int err;
 			if ((err = git_configset_add_file(&cs, argv[i]))) {
 				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
@@ -153,17 +196,22 @@ int cmd__config(int argc, const char **argv)
 				goto out;
 			}
 		}
-		if (!git_configset_get_value(&cs, argv[2], &v)) {
+		if (!git_configset_get_value(&cs, argv[1], &v)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
-		for (i = 3; i < argc; i++) {
+	} else if (argc >= 2 && !strcmp(argv[0], "configset_get_value_multi")) {
+		if (subrepo_path) {
+			fprintf(stderr, "Cannot use --submodule with configset_get_value_multi\n");
+			ret = TC_USAGE_ERROR;
+			goto out;
+		}
+		for (i = 2; i < argc; i++) {
 			int err;
 			if ((err = git_configset_add_file(&cs, argv[i]))) {
 				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
@@ -171,7 +219,7 @@ int cmd__config(int argc, const char **argv)
 				goto out;
 			}
 		}
-		strptr = git_configset_get_value_multi(&cs, argv[2]);
+		strptr = git_configset_get_value_multi(&cs, argv[1]);
 		if (strptr) {
 			for (i = 0; i < strptr->nr; i++) {
 				v = strptr->items[i].string;
@@ -181,18 +229,23 @@ int cmd__config(int argc, const char **argv)
 					printf("%s\n", v);
 			}
 		} else {
-			printf("Value not found for \"%s\"\n", argv[2]);
+			printf("Value not found for \"%s\"\n", argv[1]);
 			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (!strcmp(argv[1], "iterate")) {
-		git_config(iterate_cb, NULL);
+	} else if (!strcmp(argv[0], "iterate")) {
+		repo_config(repo, iterate_cb, NULL);
 	} else {
 print_usage_error:
-		fprintf(stderr, "Invalid syntax. Usage: test-tool config <cmd> [args]\n");
+		fprintf(stderr, "Invalid syntax. Usage: test-tool config"
+				" [--submodule=<path>] <cmd> [args]\n");
 		ret = TC_USAGE_ERROR;
 	}
 
 out:
 	git_configset_clear(&cs);
+	if (repo != the_repository) {
+		repo_clear(repo);
+		free(repo);
+	}
 	return ret;
 }
diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
index 286121d8de..b6ab793203 100755
--- a/t/t2404-worktree-config.sh
+++ b/t/t2404-worktree-config.sh
@@ -76,4 +76,20 @@ test_expect_success 'config.worktree no longer read without extension' '
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
2.26.2

