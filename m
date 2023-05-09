Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739FEC77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjEIRyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEIRyR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:54:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1355040E5
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:54:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso4206505e9.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654853; x=1686246853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhnVVzO2j9oay522o31GAsSVqahvFaFjZD7fxOD/0fA=;
        b=BNbXRU/uYCzunuD3OgTp9Gj0KUys6navPQ8SbFC0oDV+b7/pcehD8rXwkQiIayYNt2
         rGnjec6px5CjHsL8I8k5vwFzv1bPY2JEpJafwwWfZXkHERCrMzdwX8Q829gA0The1Cse
         Hp4acrCVEVwQqW8B9VSp9bP7W4SsEMdaePsHWmRCVspj43fzv1LDemu9rTcGTMsEd38J
         +FHZHW2Y8StN26+5LPXVgI89s0+utJQ/6QhH+V2L7/VMEUkKUGs8p7ZXuYI8yROyxBeK
         dezAEauLZ7FEKoScttKhxjXkDLiktfarpSumXd0RNzKEPH4B6H8tiZDAnH6LmYqsJ3zJ
         YyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654853; x=1686246853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhnVVzO2j9oay522o31GAsSVqahvFaFjZD7fxOD/0fA=;
        b=TWs2OG/gcychV2UjNd8vo268nvn9U4cl1anQM10wmGZZ0DQ/njNA5DPgzStTtIGMOA
         gOgFMggj6YKdJtUM4X1m9eF9amuSuoRRLOOMqrKGz6viOYy+CfkZ/lBoM/FdEItgU1g/
         c9wH9wuiQ72UXOGqguCefunvhZ7Ox4sfBZKtrz7JsAOGq//97zQaCwgCnuhXIYJq+Pav
         IDtPwYRshqzfkpui1G76NiUatOPKRCXtsn67R5U8j01wI/p65+XLlV77qK3ZTh1g4+TV
         +YlpV+6G5bsXR99iRBIVqjZayX2txmVrdtDsHm41kdUyXmS5F5QTzWVQTdxxolbiM7wd
         EpqA==
X-Gm-Message-State: AC+VfDx9mQT0/DgmJch6gasghzJ8kuNYLm7f5aYgcZGrt+D9uSFdTvBa
        I4szA6yP9NMH6hFUYsjbuBFCcOgm3T8=
X-Google-Smtp-Source: ACHHUZ5nUl80wEbJ4Sttg32Ne+spicv3SFQjhVfTB0jhwHCFCdQenJQ44PQphgjlLXI55fLFJwATXQ==
X-Received: by 2002:a7b:c5d3:0:b0:3f1:6ef6:c9d0 with SMTP id n19-20020a7bc5d3000000b003f16ef6c9d0mr9681702wmk.17.1683654852958;
        Tue, 09 May 2023 10:54:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:df87:46e2:83de:c1fa])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm8584435wml.18.2023.05.09.10.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:54:11 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 02/15] replay: introduce new builtin
Date:   Tue,  9 May 2023 19:53:34 +0200
Message-ID: <20230509175347.1714141-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.1.491.gbdd8a3b3e1
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

For now, this is just a rename from `t/helper/test-fast-rebase.c` into
`builtin/replay.c` with minimal changes to make it build appropriately.

Subsequent commits will flesh out its capabilities and make it a more
standard regular builtin.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .gitignore                                    |  1 +
 Makefile                                      |  2 +-
 builtin.h                                     |  1 +
 .../test-fast-rebase.c => builtin/replay.c    | 25 +++++------------
 command-list.txt                              |  1 +
 git.c                                         |  1 +
 t/helper/test-tool.c                          |  1 -
 t/helper/test-tool.h                          |  1 -
 t/t6429-merge-sequence-rename-caching.sh      | 27 +++++++------------
 9 files changed, 20 insertions(+), 40 deletions(-)
 rename t/helper/test-fast-rebase.c => builtin/replay.c (89%)

diff --git a/.gitignore b/.gitignore
index e875c59054..b5f025a296 100644
--- a/.gitignore
+++ b/.gitignore
@@ -135,6 +135,7 @@
 /git-remote-ext
 /git-repack
 /git-replace
+/git-replay
 /git-request-pull
 /git-rerere
 /git-reset
diff --git a/Makefile b/Makefile
index e440728c24..a6ab78840f 100644
--- a/Makefile
+++ b/Makefile
@@ -799,7 +799,6 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-env-helper.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
-TEST_BUILTINS_OBJS += test-fast-rebase.o
 TEST_BUILTINS_OBJS += test-fsmonitor-client.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
@@ -1286,6 +1285,7 @@ BUILTIN_OBJS += builtin/remote-fd.o
 BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/repack.o
 BUILTIN_OBJS += builtin/replace.o
+BUILTIN_OBJS += builtin/replay.o
 BUILTIN_OBJS += builtin/rerere.o
 BUILTIN_OBJS += builtin/reset.o
 BUILTIN_OBJS += builtin/rev-list.o
diff --git a/builtin.h b/builtin.h
index cb0db67681..c3f0b56915 100644
--- a/builtin.h
+++ b/builtin.h
@@ -214,6 +214,7 @@ int cmd_remote(int argc, const char **argv, const char *prefix);
 int cmd_remote_ext(int argc, const char **argv, const char *prefix);
 int cmd_remote_fd(int argc, const char **argv, const char *prefix);
 int cmd_repack(int argc, const char **argv, const char *prefix);
+int cmd_replay(int argc, const char **argv, const char *prefix);
 int cmd_rerere(int argc, const char **argv, const char *prefix);
 int cmd_reset(int argc, const char **argv, const char *prefix);
 int cmd_restore(int argc, const char **argv, const char *prefix);
diff --git a/t/helper/test-fast-rebase.c b/builtin/replay.c
similarity index 89%
rename from t/helper/test-fast-rebase.c
rename to builtin/replay.c
index 403bdf8e75..9637c31da2 100644
--- a/t/helper/test-fast-rebase.c
+++ b/builtin/replay.c
@@ -1,18 +1,11 @@
 /*
- * "git fast-rebase" builtin command
- *
- * FAST: Forking Any Subprocesses (is) Taboo
- *
- * This is meant SOLELY as a demo of what is possible.  sequencer.c and
- * rebase.c should be refactored to use the ideas here, rather than attempting
- * to extend this file to replace those (unless Phillip or Dscho say that
- * refactoring is too hard and we need a clean slate, but I'm guessing that
- * refactoring is the better route).
+ * "git replay" builtin command
  */
 
 #define USE_THE_INDEX_VARIABLE
-#include "test-tool.h"
-#include "cache.h"
+#include "git-compat-util.h"
+
+#include "builtin.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "environment.h"
@@ -93,7 +86,7 @@ static struct commit *create_commit(struct tree *tree,
 	return (struct commit *)obj;
 }
 
-int cmd__fast_rebase(int argc, const char **argv)
+int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
@@ -109,12 +102,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 	struct strbuf branch_name = STRBUF_INIT;
 	int ret = 0;
 
-	/*
-	 * test-tool stuff doesn't set up the git directory by default; need to
-	 * do that manually.
-	 */
-	setup_git_directory();
-
 	if (argc == 2 && !strcmp(argv[1], "-h")) {
 		printf("Sorry, I am not a psychiatrist; I can not give you the help you need.  Oh, you meant usage...\n");
 		exit(129);
@@ -135,7 +122,7 @@ int cmd__fast_rebase(int argc, const char **argv)
 	if (repo_read_index(the_repository) < 0)
 		BUG("Could not read index");
 
-	repo_init_revisions(the_repository, &revs, NULL);
+	repo_init_revisions(the_repository, &revs, prefix);
 	revs.verbose_header = 1;
 	revs.max_parents = 1;
 	revs.cherry_mark = 1;
diff --git a/command-list.txt b/command-list.txt
index 54b2a50f5f..d74836ab21 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -160,6 +160,7 @@ git-reflog                              ancillarymanipulators           complete
 git-remote                              ancillarymanipulators           complete
 git-repack                              ancillarymanipulators           complete
 git-replace                             ancillarymanipulators           complete
+git-replay                              mainporcelain           history
 git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           history
diff --git a/git.c b/git.c
index 45899be826..a1252e4cd3 100644
--- a/git.c
+++ b/git.c
@@ -577,6 +577,7 @@ static struct cmd_struct commands[] = {
 	{ "remote-fd", cmd_remote_fd, NO_PARSEOPT },
 	{ "repack", cmd_repack, RUN_SETUP },
 	{ "replace", cmd_replace, RUN_SETUP },
+	{ "replay", cmd_replay, RUN_SETUP },
 	{ "rerere", cmd_rerere, RUN_SETUP },
 	{ "reset", cmd_reset, RUN_SETUP },
 	{ "restore", cmd_restore, RUN_SETUP | NEED_WORK_TREE },
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index abe8a785eb..9ca1586de7 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -30,7 +30,6 @@ static struct test_cmd cmds[] = {
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "env-helper", cmd__env_helper },
 	{ "example-decorate", cmd__example_decorate },
-	{ "fast-rebase", cmd__fast_rebase },
 	{ "fsmonitor-client", cmd__fsmonitor_client },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ea2672436c..a03bbfc6b2 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -24,7 +24,6 @@ int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__dump_reftable(int argc, const char **argv);
 int cmd__env_helper(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
-int cmd__fast_rebase(int argc, const char **argv);
 int cmd__fsmonitor_client(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index 75d3fd2dba..7670b72008 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -71,9 +71,8 @@ test_expect_success 'caching renames does not preclude finding new ones' '
 
 		git switch upstream &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream~1..topic
 
 		git ls-files >tracked-files &&
 		test_line_count = 2 tracked-files &&
@@ -141,8 +140,7 @@ test_expect_success 'cherry-pick both a commit and its immediate revert' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
-		#git cherry-pick upstream~1..topic &&
+		git replay --onto HEAD upstream~1 topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 1 calls
@@ -200,9 +198,8 @@ test_expect_success 'rename same file identically, then reintroduce it' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream~1..topic &&
 
 		git ls-files >tracked &&
 		test_line_count = 2 tracked &&
@@ -278,9 +275,8 @@ test_expect_success 'rename same file identically, then add file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream~1..topic &&
 
 		git ls-files >tracked &&
 		test_line_count = 4 tracked &&
@@ -356,8 +352,7 @@ test_expect_success 'cached dir rename does not prevent noticing later conflict'
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test_must_fail test-tool fast-rebase --onto HEAD upstream~1 topic >output &&
-		#git cherry-pick upstream..topic &&
+		test_must_fail git replay --onto HEAD upstream~1 topic >output &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls
@@ -456,9 +451,8 @@ test_expect_success 'dir rename unneeded, then add new file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls &&
@@ -523,9 +517,8 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 3 calls &&
@@ -626,9 +619,8 @@ test_expect_success 'caching renames only on upstream side, part 1' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 1 calls &&
@@ -685,9 +677,8 @@ test_expect_success 'caching renames only on upstream side, part 2' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls &&
-- 
2.40.1.491.gdff9a222ea

