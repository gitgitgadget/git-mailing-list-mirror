Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2969FC76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbjDGHZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239663AbjDGHZH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B5986B9
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:24:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y14so41638919wrq.4
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbkG0ugDsYqPtwGXpVzrHvuf+dTdaWeGHc1rAH7NQgM=;
        b=VssbmRbc+N7iRVxe4E/VYmJQ2SzrRLm+4JrAo3ZnukeC/EIJo0wiSuj5Q7MUgfxTw4
         Q7JYq2j+Q2YmaNjX1daIUDBaIXR0+CmDtVflpVsqZL4fQMylwIuF2k2fxhP7ktgFzzO7
         Z6gIaZAi3NHCw0RN8v1jKHAgajL+1gE5kmFZ8cJgwiy2VBQCSqJd1goBF3RnLQ72a/7j
         Usre2vxaaVGJ7Mx7U74V8qxIbZA855NVd+NzvTD0/1jpp7SwnDWzcUZec6/hSj+wqnWK
         oscAw3slJVss5XtHFv18EIUxholg0q7qLhccBu2981Ac5G2C7xinG2nDIAv/AgsYTsu7
         AH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbkG0ugDsYqPtwGXpVzrHvuf+dTdaWeGHc1rAH7NQgM=;
        b=mXqEAu2/JYkuqxpc0gPH4fjzmChJeFtnvOz0+0RzQg0rtnzS4SVElLiCGWZQMJ4Ztl
         V6wx6In20abisP343MojrWXj443a/uhe+jJvTF//6tjoAVUBd1kyqIaZ80pVEuw7u+Pj
         8BtQUsmOmsP2hUy3Dpd/Tc68aUuNAFpwHbWuVAnORMan1k8RfY9LXzFhakf/URoIjxSo
         yrQ9e9k2UcpJYm+SpUUXOMp/c2RXCWNIuFTmxEEwGzOs/LbH8kPGG47TKqdxovmaWAOv
         EH7FfDOHJlftx+6IvrP6aXn05YJhmqEFPA6wgjniDeUdjs+32IDLAEFZDsX1dF5lUWWL
         PpCw==
X-Gm-Message-State: AAQBX9fA11pF1Lk2QM29oKBl8D7/mvlXtr0bhAaADEjlrExNr4sSX/0+
        ks5N6QaKJNk1rkvcU6DBP14bHXF/hkOdHA==
X-Google-Smtp-Source: AKy350a9KCAvRpaDzdl0beFn/kCj5CSyYW3pN6y/yjq4DU+5Z1cljP08WUxtic7E1rYefs6Kdnn8fQ==
X-Received: by 2002:adf:facf:0:b0:2e5:25e7:45d2 with SMTP id a15-20020adffacf000000b002e525e745d2mr1034265wrs.66.1680852282677;
        Fri, 07 Apr 2023 00:24:42 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:42 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 01/14] replay: introduce new builtin
Date:   Fri,  7 Apr 2023 09:24:02 +0200
Message-Id: <20230407072415.1360068-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
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
 .../test-fast-rebase.c => builtin/replay.c    | 23 ++++------------
 command-list.txt                              |  1 +
 git.c                                         |  1 +
 t/helper/test-tool.c                          |  1 -
 t/helper/test-tool.h                          |  1 -
 t/t6429-merge-sequence-rename-caching.sh      | 27 +++++++------------
 9 files changed, 19 insertions(+), 39 deletions(-)
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
index 60ab1a8b4f..44546f74dc 100644
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
index 46cc789789..6ad9efd6cd 100644
--- a/builtin.h
+++ b/builtin.h
@@ -204,6 +204,7 @@ int cmd_remote(int argc, const char **argv, const char *prefix);
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
index b1edb92a03..154a976ca6 100644
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
+#include "git-compat-util.h"
 
+#include "builtin.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "hex.h"
@@ -86,7 +79,7 @@ static struct commit *create_commit(struct tree *tree,
 	return (struct commit *)obj;
 }
 
-int cmd__fast_rebase(int argc, const char **argv)
+int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
@@ -102,12 +95,6 @@ int cmd__fast_rebase(int argc, const char **argv)
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
@@ -128,7 +115,7 @@ int cmd__fast_rebase(int argc, const char **argv)
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
index ae2134f29a..e4ce39fd4d 100644
--- a/git.c
+++ b/git.c
@@ -571,6 +571,7 @@ static struct cmd_struct commands[] = {
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
index d02fa16614..40505c9054 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -71,8 +71,7 @@ test_expect_success 'caching renames does not preclude finding new ones' '
 
 		git switch upstream &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
-		#git cherry-pick upstream~1..topic
+		git replay --onto HEAD upstream~1 topic &&
 
 		git ls-files >tracked-files &&
 		test_line_count = 2 tracked-files &&
@@ -140,8 +139,7 @@ test_expect_success 'cherry-pick both a commit and its immediate revert' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
-		#git cherry-pick upstream~1..topic &&
+		git replay --onto HEAD upstream~1 topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 1 calls
@@ -199,8 +197,7 @@ test_expect_success 'rename same file identically, then reintroduce it' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
-		#git cherry-pick upstream~1..topic &&
+		git replay --onto HEAD upstream~1 topic &&
 
 		git ls-files >tracked &&
 		test_line_count = 2 tracked &&
@@ -276,8 +273,7 @@ test_expect_success 'rename same file identically, then add file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
-		#git cherry-pick upstream~1..topic &&
+		git replay --onto HEAD upstream~1 topic &&
 
 		git ls-files >tracked &&
 		test_line_count = 4 tracked &&
@@ -353,8 +349,7 @@ test_expect_success 'cached dir rename does not prevent noticing later conflict'
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test_must_fail test-tool fast-rebase --onto HEAD upstream~1 topic >output &&
-		#git cherry-pick upstream..topic &&
+		test_must_fail git replay --onto HEAD upstream~1 topic >output &&
 
 		grep CONFLICT..rename/rename output &&
 
@@ -455,8 +450,7 @@ test_expect_success 'dir rename unneeded, then add new file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
-		#git cherry-pick upstream..topic &&
+		git replay --onto HEAD upstream~1 topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls &&
@@ -521,8 +515,7 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
-		#git cherry-pick upstream..topic &&
+		git replay --onto HEAD upstream~1 topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 3 calls &&
@@ -623,8 +616,7 @@ test_expect_success 'caching renames only on upstream side, part 1' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
-		#git cherry-pick upstream..topic &&
+		git replay --onto HEAD upstream~1 topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 1 calls &&
@@ -681,8 +673,7 @@ test_expect_success 'caching renames only on upstream side, part 2' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
-		#git cherry-pick upstream..topic &&
+		git replay --onto HEAD upstream~1 topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls &&
-- 
2.40.0.228.gb2eb5bb98e

