Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B0EC433E6
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1E6206C0
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="G5yebAdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIBGSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgIBGSO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 02:18:14 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C08AC061247
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 23:18:14 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so2817761qtp.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 23:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDCTjUqGtrqsojg5+9uvNRFT3Rkdj5hAmOW6dYdpW6o=;
        b=G5yebAdoYNVMwqtgdNl/Cp5xR9Eo7P4XZvrICcMdPbpKrj8GWuYWaYii+g7tezfMzA
         Pk+y367jCpsYn7VHwkkaGy//Xta2ibA/49MHgRflEajBJo5g/0Ic9r6oWziHYmZ+og2c
         hh48eLTa8Mb9RocI8EHxCV0Ppeb1r/b9+nD9Eb3houNVA1GIW6Rw/WdM2yjx3y80ITli
         4gOpxM6c+0rFio5mDSZkLSY+3hYAIG8MfCOtQdB523ra97a4QIODr9KTgs8ylgTniutR
         JiiQbjL7lBFBGMjK8b3kuL8UeBWsdXMHFKUW7xWPtobFbNz+JD9rs0sDXeTxJMTeXK2E
         1E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDCTjUqGtrqsojg5+9uvNRFT3Rkdj5hAmOW6dYdpW6o=;
        b=EsIRZyiu9mOdr3zCl3GkYdCSMFGW6xzaWeDpyBd37mg/wsRVyYjXfutpHDcH4a9pW6
         3DvDFN5/9a9dyxVXFItrbFX/coCRFJRBmuo2HFWlcyBYg0JPW7rCUdw+lJHUoIC94mjL
         h8u3XD9xKkUVvA9ynKmykdM4AxA8BGLKyt6mkhhDyfz8rmSg68bEy7wjV7O3WXB09as6
         qBnmlw1BV7gfjyCw/6uvKde4xGKg4xn8ABXA0VDklA+n/330RzXFFFkCsMw9M7JqjvE5
         JtdE8VF1nO0O6pS83mA5DSpurArTnFW/7HSfVHGB3usKmkyXbGHhF1P8uF8PwErgtQEx
         hDIg==
X-Gm-Message-State: AOAM531+WFyRaBMzHZpr6ndF/YXqBCOwiQb5mZKlgdfda9GNDfy71f6N
        m/2f2Q3pWPYPHIdRfCUs6uyKjiJ2wLaxig==
X-Google-Smtp-Source: ABdhPJyFZevitivj7CGeHOEPSY28WxqkZQqnnuUzB52ykRnWFLEM238Sxg9/8mGeZNw+A7vkdrr4HQ==
X-Received: by 2002:ac8:6d32:: with SMTP id r18mr5517491qtu.246.1599027493061;
        Tue, 01 Sep 2020 23:18:13 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id x28sm3731234qki.55.2020.09.01.23.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:18:12 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH v5 6/8] config: correctly read worktree configs in submodules
Date:   Wed,  2 Sep 2020 03:17:35 -0300
Message-Id: <3e02e1bd248438e0b435a19d857432edcaa15a2c.1599026986.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599026986.git.matheus.bernardino@usp.br>
References: <cover.1599026986.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The config machinery is not able to read worktree configs from a
submodule in a process where the_repository represents the superproject.
Furthermore, when extensions.worktreeConfig is set on the superproject,
querying for a worktree config in a submodule will, instead, return
the value set at the superproject.

The problem resides in do_git_config_sequence(). Although the function
receives a git_dir string, it uses the_repository->git_dir when making
the path to the worktree config file. And when checking if
extensions.worktreeConfig is set, it uses the global
repository_format_worktree_config variable, which refers to
the_repository only. So let's fix this by using the git_dir given to the
function and reading the extension value from the right place. Also add
a test to avoid any regressions.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 config.c                   | 21 ++++++++++---
 t/helper/test-config.c     | 62 ++++++++++++++++++++++++++++++++------
 t/t2404-worktree-config.sh | 16 ++++++++++
 3 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/config.c b/config.c
index 2bdff4457b..e1e7fab6dc 100644
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
index 8fe43e9775..2924c09c21 100644
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
+		die("Please, provide a command name on the command-line");
 
 	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
+		if (subrepo_path)
+			die("cannot use --submodule with read_early_config");
 		read_early_config(early_config_cb, (void *)argv[2]);
 		return ret;
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

