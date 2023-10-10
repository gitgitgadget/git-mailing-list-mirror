Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BE7CD80C1
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjJJMjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjJJMjK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:39:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC769D
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40684f53d11so57086995e9.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941546; x=1697546346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWT2tn9AECEPyoJkmXMc9sKmRafwP7GgxenQywqYvTA=;
        b=gnOVkWDWDcX65oD5uImGWs6HbXp1Yq9Jjxt8s0voPdjCyDV6kUilsyTFUwoeB3WXI5
         BCulMX5sr/5n1NdC/FyQZ6QFQJfSA6GvISN+vIX30tH8BJSqgJZDd2R14Pntcd7uag1+
         cBGNY2owHdU5ldrAaWdYImJSH5hO9YEF1TFXHeljax8CDv4UOuZ0yOvPaDtX6saxzCKK
         LAp16i2aT02PsoUHWjA3O75D98Dpy6JSMw2nBX0Z9/EU2Io2BMIarxPYKs9bt/pfS+VT
         tu9PgltXT63sfSCz5JgkKJFNj4stFJWXuZnR3Ai3wpi3T9lUyaOf/43pI4Rp7e/6x/u+
         0XMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941546; x=1697546346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWT2tn9AECEPyoJkmXMc9sKmRafwP7GgxenQywqYvTA=;
        b=qIY6K5U8YiroEAiyAKiEVaOIGjeF6negjnjonEXzFFlfjFHZMyueDAEYQWHKPSNTy0
         YECa8rZkbmX/pjgV9G4aEfc8DjxFNDNDvz0lwe+S7aXlUiHQOv6rTds654So93wkmZwH
         +xjS4QOxaBnYztxuQhxJYL19n1V++WMzye/MJ1r6zea3TkuufSvi0AK96xWvctqMZ3Sa
         Eyzbx8JIeEIQtRmpBYc+yPKbiYo5NjFwhps05UY2/mmCXZ4tlj4zbwHOljoL/W4DxjBH
         n6jOQUsc6WDpQ6w/a3hudqkD96sC4jQ1BOCw8zD1zFNP/7uE8Q6985FAAzSh3qTzNkN2
         Qocg==
X-Gm-Message-State: AOJu0Ywjjh5ogQtatzpi6c/Fp7xtSdzIlbTCK6kjgTj0yQIpztry6mUE
        YLE7/kI3T+oy7R5KM4GxHUIpoFhHJu0Tgw==
X-Google-Smtp-Source: AGHT+IG/fTU94Ox7dHIGGNLSNE8uxFi69uLYypw4Jiy7ZvdMW+RRMqMDa+4YLGeLJ7Ku4B+H4hANAw==
X-Received: by 2002:a05:600c:22c6:b0:405:3a65:1b4c with SMTP id 6-20020a05600c22c600b004053a651b4cmr15772685wmg.6.1696941545558;
        Tue, 10 Oct 2023 05:39:05 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:516d:299b:cbff:be05])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm14071689wma.45.2023.10.10.05.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:39:04 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Dragan Simic <dsimic@manjaro.org>,
        Linus Arver <linusa@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 02/14] replay: introduce new builtin
Date:   Tue, 10 Oct 2023 14:38:35 +0200
Message-ID: <20231010123847.2777056-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.339.g663cbc8ab1
In-Reply-To: <20231010123847.2777056-1-christian.couder@gmail.com>
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com>
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

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .gitignore                                    |  1 +
 Makefile                                      |  2 +-
 builtin.h                                     |  1 +
 .../test-fast-rebase.c => builtin/replay.c    | 27 ++++++-------------
 command-list.txt                              |  1 +
 git.c                                         |  1 +
 t/helper/test-tool.c                          |  1 -
 t/helper/test-tool.h                          |  1 -
 t/t6429-merge-sequence-rename-caching.sh      | 27 +++++++------------
 9 files changed, 22 insertions(+), 40 deletions(-)
 rename t/helper/test-fast-rebase.c => builtin/replay.c (89%)

diff --git a/.gitignore b/.gitignore
index 5e56e471b3..612c0f6a0f 100644
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
index 003e63b792..b5e3843d7f 100644
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
index d560baa661..28280636da 100644
--- a/builtin.h
+++ b/builtin.h
@@ -211,6 +211,7 @@ int cmd_remote(int argc, const char **argv, const char *prefix);
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
index 2bfab66b1b..e102749ab6 100644
--- a/t/helper/test-fast-rebase.c
+++ b/builtin/replay.c
@@ -1,17 +1,11 @@
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
+#include "git-compat-util.h"
+
+#include "builtin.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "environment.h"
@@ -27,7 +21,8 @@
 #include "sequencer.h"
 #include "setup.h"
 #include "strvec.h"
-#include "tree.h"
+#include <oidset.h>
+#include <tree.h>
 
 static const char *short_commit_name(struct commit *commit)
 {
@@ -94,7 +89,7 @@ static struct commit *create_commit(struct tree *tree,
 	return (struct commit *)obj;
 }
 
-int cmd__fast_rebase(int argc, const char **argv)
+int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
@@ -110,12 +105,6 @@ int cmd__fast_rebase(int argc, const char **argv)
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
@@ -136,7 +125,7 @@ int cmd__fast_rebase(int argc, const char **argv)
 	if (repo_read_index(the_repository) < 0)
 		BUG("Could not read index");
 
-	repo_init_revisions(the_repository, &revs, NULL);
+	repo_init_revisions(the_repository, &revs, prefix);
 	revs.verbose_header = 1;
 	revs.max_parents = 1;
 	revs.cherry_mark = 1;
diff --git a/command-list.txt b/command-list.txt
index 54b2a50f5f..c4cd0f352b 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -160,6 +160,7 @@ git-reflog                              ancillarymanipulators           complete
 git-remote                              ancillarymanipulators           complete
 git-repack                              ancillarymanipulators           complete
 git-replace                             ancillarymanipulators           complete
+git-replay                              plumbingmanipulators
 git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           history
diff --git a/git.c b/git.c
index c67e44dd82..7068a184b0 100644
--- a/git.c
+++ b/git.c
@@ -594,6 +594,7 @@ static struct cmd_struct commands[] = {
 	{ "remote-fd", cmd_remote_fd, NO_PARSEOPT },
 	{ "repack", cmd_repack, RUN_SETUP },
 	{ "replace", cmd_replace, RUN_SETUP },
+	{ "replay", cmd_replay, RUN_SETUP },
 	{ "rerere", cmd_rerere, RUN_SETUP },
 	{ "reset", cmd_reset, RUN_SETUP },
 	{ "restore", cmd_restore, RUN_SETUP | NEED_WORK_TREE },
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 621ac3dd10..3109ba5c7a 100644
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
index a641c3a81d..d3e55c3f4e 100644
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
2.42.0.339.g663cbc8ab1

