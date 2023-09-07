Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53BDEC8726
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 18:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbjIGSRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbjIGSRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 14:17:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51F91A8
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 11:16:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52bcb8b199aso1717780a12.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694110597; x=1694715397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfNxmz/ybTqRxTj0jMppVWmWYoHRR6t83zfdM8frOBU=;
        b=lqJvBxRY7SY1zSH85uIlGlq8Kq0ONWIwGtDl69bRlFekusEEz+TqMiFML4ue58heQz
         PVQEThKwsKlDn1ZdMLUxWxhCJ9VP94KvuaEDbqj5HJwWto6tzv6RcV5sEARiPw5JciBW
         embeO5E4uAIUQiur2Kj5DGiCSuF/uv26RFW/3kHVhLk+X1WEgk299oB4B644iBxyAf/r
         7IMg/pKrXgMc3z38EIXQB/eBIIKvtT4GhEtysS0ZXhVASYdznWJ8NT/LforUmqexm6BA
         xwZ2CdslNyo8u/gBArXyQEOZY5Z5vIzvg4BPWhYdUCCcrp1ibO6djgipuOlErl5YChL1
         bBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694110597; x=1694715397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfNxmz/ybTqRxTj0jMppVWmWYoHRR6t83zfdM8frOBU=;
        b=UmRntQt8m5tFLcSHe7Uydoo1lBdELPQlZkhbbFIyS90lpBr+sbt1ZoGBdxyEgqogbN
         7rxmn5JX1x2rcbpJ+aYyH+x4necyJ7m2jDZsbswct2lOq3XPNzvxpZzccOxGErVwe3AB
         /jqtLsvpT32dDHZumjpNgThyDo2zaJaz6kZHR6o8GoL7GHWN3bZ86K2kcApXjUD8+qyB
         yAcrbLJTrIhQcl8CdA3o4ncTEny3ZD3TXNn5RnVo1LaI7HXX1QSBZ/S60eDgr6g9vvAo
         /EOOMPZnd5LTOQKX9sLhN+cU1mKgpBKHpK5JFhTk7V8UU645cDxDuUR5Cz2fIQjs+ZUR
         75uQ==
X-Gm-Message-State: AOJu0YxRrzpgad2CyKuDh4yAvEp9ZJGy7W+ye0vxci2qiUGXsXy34uTd
        AcZil+a2b5Addkn91MN+ZZ/BH/IngMQ=
X-Google-Smtp-Source: AGHT+IFt0FOTw5iQ85Q0pxxxy0hx0Z5/tAdDIUheic3Ad4wb6xGHYxWFTA0Bt0SxKwWv1lqKYir8gQ==
X-Received: by 2002:a5d:4a4d:0:b0:317:5eb8:b1c4 with SMTP id v13-20020a5d4a4d000000b003175eb8b1c4mr4308255wrs.2.1694078785098;
        Thu, 07 Sep 2023 02:26:25 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:26:24 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 02/15] replay: introduce new builtin
Date:   Thu,  7 Sep 2023 11:25:08 +0200
Message-ID: <20230907092521.733746-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.126.gcf8c984877
In-Reply-To: <20230907092521.733746-1-christian.couder@gmail.com>
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com>
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
index 5776309365..05a504dc28 100644
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
@@ -1287,6 +1286,7 @@ BUILTIN_OBJS += builtin/remote-fd.o
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
2.42.0.126.gcf8c984877

