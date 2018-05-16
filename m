Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E58221F406
	for <e@80x24.org>; Wed, 16 May 2018 22:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeEPWWI (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:22:08 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:32812 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751430AbeEPWVf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:21:35 -0400
Received: by mail-pg0-f52.google.com with SMTP id v7-v6so909491pgs.0
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fK0PgTUt9WNCDarW6LbCpzftL/3sbxQtBTJDh068u+A=;
        b=EHW9LalhftdgmFWg87D1eszgbxmSsIYjQmq0ev+URtx/v76D/8R5DCDETvPJsSWQhA
         ewOlxfnuU+jYbLRSV0gRF/r8TNmUsYAOE6FfZEVCzX+l2TgMclHs7WhZI8TtWMRuAtGX
         VZZJPPJOQtdMB6VPy+WopZxq3jtFuNfB9Aon3E0pTvVrLRO8fWUGzvwowf6ZjRseKcOK
         W3rfi7PIXKSz2QVA7EyZix49Pt+rmr7eag3hYz3duYfQ1b12wq2lrUUoq0ZNHC/8ceNp
         tK6Z8hD0myQTd8yBDTyMkYaGIuUBWkdNwttbSlB94k+V+6RZ+XaE3rykShD7Pw48hbLc
         806g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fK0PgTUt9WNCDarW6LbCpzftL/3sbxQtBTJDh068u+A=;
        b=Q5R0SngKHeDorj1gzqnVTP04Ws2pa98VSLV3S+LLmCOomly3Qd2W1upZQvih6Gamvf
         03q8w8cGDzh5Thz+xy0UOYqbbPP8kZHse7bnqGBXGmo88uG4ovkGs4eagACgM05MdzgS
         7YVUemp+cn7hllG2UnuWB90rRp5fdBqqXIh1wGXtOl4tKiobXZx0h4BlB5dx5K0alNIU
         vyfSUFiGx0wkGNBsk/ypZ/zAbbhSlE5W7jRs7WX0mfivGXBiYUu7p/UgGc4MY3+ONd64
         a7HA9qWhvSmdIk7ONaLU0SmcuGz7OvLhpkDEbURF5Kjuj53GNSeXoUtIdImKwvxjuyTT
         iX4w==
X-Gm-Message-State: ALKqPwe81QcPGCQjzzt7zrKuqsxPy2iWoH4GtvZVvYbHLMlR964455OS
        JrFILGtcKchsYwgitKtygib+zg==
X-Google-Smtp-Source: AB8JxZr+RemKI9xSfnCCiojBv6jYTzsG6n2ZfpNUyBm2ZxP/a6DWlzCcpTTwJDBUkQwp6L5lHjw7Jw==
X-Received: by 2002:a62:ccdc:: with SMTP id j89-v6mr2783994pfk.182.1526509294579;
        Wed, 16 May 2018 15:21:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id e5-v6sm6002889pfk.28.2018.05.16.15.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 15:21:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com
Subject: [PATCH 02/11] repository: introduce repo_read_index_or_die
Date:   Wed, 16 May 2018 15:21:09 -0700
Message-Id: <20180516222118.233868-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180516222118.233868-1-sbeller@google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A common pattern with the repo_read_index function is to die if the return
of repo_read_index is negative.  Move this pattern into a function.

This patch replaces the calls of repo_read_index with its _or_die version,
if the error message is exactly the same.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/add.c               | 3 +--
 builtin/check-ignore.c      | 7 ++++---
 builtin/clean.c             | 4 ++--
 builtin/mv.c                | 3 +--
 builtin/reset.c             | 3 +--
 builtin/rm.c                | 3 +--
 builtin/submodule--helper.c | 3 +--
 repository.c                | 6 ++++++
 repository.h                | 8 ++++++++
 9 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c9e2619a9ad..e4751c198c1 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -445,8 +445,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
+	repo_read_index_or_die(the_repository);
 
 	die_in_unpopulated_submodule(&the_index, prefix);
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index ec9a959e08d..2a46bf9af7f 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -6,6 +6,7 @@
 #include "pathspec.h"
 #include "parse-options.h"
 #include "submodule.h"
+#include "repository.h"
 
 static int quiet, verbose, stdin_paths, show_non_matching, no_index;
 static const char * const check_ignore_usage[] = {
@@ -172,9 +173,9 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 	if (show_non_matching && !verbose)
 		die(_("--non-matching is only valid with --verbose"));
 
-	/* read_cache() is only necessary so we can watch out for submodules. */
-	if (!no_index && read_cache() < 0)
-		die(_("index file corrupt"));
+	/* repo_read_index() is only necessary so we can watch out for submodules. */
+	if (!no_index)
+		repo_read_index_or_die(the_repository);
 
 	memset(&dir, 0, sizeof(dir));
 	setup_standard_excludes(&dir);
diff --git a/builtin/clean.c b/builtin/clean.c
index fad533a0a73..6c1c6fdd7f9 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -16,6 +16,7 @@
 #include "column.h"
 #include "color.h"
 #include "pathspec.h"
+#include "repository.h"
 
 static int force = -1; /* unset */
 static int interactive;
@@ -954,8 +955,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (remove_directories)
 		dir.flags |= DIR_SHOW_IGNORED_TOO | DIR_KEEP_UNTRACKED_CONTENTS;
 
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
+	repo_read_index_or_die(the_repository);
 
 	if (!ignored)
 		setup_standard_excludes(&dir);
diff --git a/builtin/mv.c b/builtin/mv.c
index 7a63667d648..7f62e626dda 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -140,8 +140,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_mv_usage, builtin_mv_options);
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
+	repo_read_index_or_die(the_repository);
 
 	source = internal_prefix_pathspec(prefix, argv, argc, 0);
 	modes = xcalloc(argc, sizeof(enum update_mode));
diff --git a/builtin/reset.c b/builtin/reset.c
index 7f1c3f02a30..fd514eec822 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -237,8 +237,7 @@ static void parse_args(struct pathspec *pathspec,
 	}
 	*rev_ret = rev;
 
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
+	repo_read_index_or_die(the_repository);
 
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
diff --git a/builtin/rm.c b/builtin/rm.c
index 5b6fc7ee818..3b90191aa53 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -267,8 +267,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
+	repo_read_index_or_die(the_repository);
 
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c2403a915ff..7aebed9bd66 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -323,8 +323,7 @@ static int module_list_compute(int argc, const char **argv,
 	if (pathspec->nr)
 		ps_matched = xcalloc(pathspec->nr, 1);
 
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
+	repo_read_index_or_die(the_repository);
 
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
diff --git a/repository.c b/repository.c
index beff3caa9e2..ceca14ba718 100644
--- a/repository.c
+++ b/repository.c
@@ -249,3 +249,9 @@ int repo_read_index(struct repository *repo)
 
 	return read_index_from(repo->index, repo->index_file, repo->gitdir);
 }
+
+void repo_read_index_or_die(struct repository *repo)
+{
+	if (repo_read_index(repo) < 0)
+		die(_("index file corrupt"));
+}
diff --git a/repository.h b/repository.h
index f2646f0c52a..8efd8979ad3 100644
--- a/repository.h
+++ b/repository.h
@@ -118,4 +118,12 @@ extern void repo_clear(struct repository *repo);
  */
 extern int repo_read_index(struct repository *repo);
 
+/*
+ * Populates the index in the repository from its index file,
+ * allocating the struct index if needed.
+ *
+ * If the index file cannot be read, die.
+ */
+void repo_read_index_or_die(struct repository *r);
+
 #endif /* REPOSITORY_H */
-- 
2.17.0.582.gccdcbd54c44.dirty

