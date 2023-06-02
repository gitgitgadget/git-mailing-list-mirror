Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7B7C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjFBK31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbjFBK2w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:28:52 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910F41735
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:26:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30aeee7c8a0so1450605f8f.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701568; x=1688293568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8e2H4U5UUwV1RnmYcVFLJRUGH4b+zKLMWmbu8fM+aU=;
        b=e6b9jYf+8nfx+m6ON/01C8GsHU9ArkoxGT/V+B6Vtgxi/CpCgpEXegYkcrBDc9RWVG
         lVR8Avx4UYo4iUU16Cyj1zam+3zizC24C0d7SCd2aiyYxdEKIOJzbDdchAmrKkucSHYv
         AKrHbL4kDe+v4Jo+UccTlR4/MTz1M6RCgzwc10JbHDKVSkE6A2ff0CV+xHMvd3S4Lh6k
         fphJpnnfNwDvPj61Rhq7w68RcfHqartBaMeM8XUAYtpdRbbRXfrmpBsgSrylNwvPib6y
         XUz1/b0gUVOR5yqd+DjDWuJcKbxWEFrOrLeMqSYNG8wO699GCn3ygImJ3VidpQPnVuN9
         QjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701568; x=1688293568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8e2H4U5UUwV1RnmYcVFLJRUGH4b+zKLMWmbu8fM+aU=;
        b=erBHLUlAIvO0pHD5Krr7jYkTqlhW17zfb2QMBAK/o4FTBnE0DsXTcQi3Q+83zAwQvt
         6S6Cxoy4M/gBCnXcK/DiBOi4pDWAU9HmLfvOvNNru8fEwSSqduBwD4BsZlfS7w+BK8HB
         PvSXpxvihajzYtpcved9RP9XcdVV/1EpjPfyWxW0RcmcUGoSHos4CcHH3aw9twO0lDap
         4w9WlKHG3HcL8ujuAMqGt+8XD9PoOBZ/ZbrEUtXZYleN+cgSrq6TapJoxcQcfH+sfAFK
         C4m4kVp8gbhfh6uc4fKSYouvNTS5l7pEH54cJPUqj472HEAPKlNCXXGppHu773usOskk
         5gDg==
X-Gm-Message-State: AC+VfDzKsLeqzce7VHK/h288Tr6sOZi/NA5lxsYIIaHJZoj8tPwKFYQN
        rIE5o0/PWzB3Jo8UQ9tAYVBpSLUinn0zTg==
X-Google-Smtp-Source: ACHHUZ5pRnkueLKs7Xpu1KQuWX+z8QCvEdDDiG8wIDKb4ws3tgxxc8zQH2QrKkakFBZ/9RoFD0+NLw==
X-Received: by 2002:adf:e54e:0:b0:30a:f68f:9b94 with SMTP id z14-20020adfe54e000000b0030af68f9b94mr4196114wrm.21.1685701567684;
        Fri, 02 Jun 2023 03:26:07 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1169:70dc:520b:5de9:c23d:7cde])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1468035wmk.33.2023.06.02.03.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:26:07 -0700 (PDT)
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
Subject: [PATCH v3 11/15] replay: use standard revision ranges
Date:   Fri,  2 Jun 2023 12:25:29 +0200
Message-ID: <20230602102533.876905-12-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.15.ga6d88fc8f0
In-Reply-To: <20230602102533.876905-1-christian.couder@gmail.com>
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Instead of the fixed "<oldbase> <branch>" arguments, the replay
command now accepts "<revision-range>..." arguments in a similar
way as many other Git commands. This makes its interface more
standard and more flexible.

Also as the interface of the command is now mostly finalized,
we can add some documentation as well as testcases to make sure
the command will continue to work as designed in the future.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replay.txt             | 88 ++++++++++++++++++++++++
 builtin/replay.c                         | 21 ++----
 t/t3650-replay-basics.sh                 | 83 ++++++++++++++++++++++
 t/t6429-merge-sequence-rename-caching.sh | 18 ++---
 4 files changed, 184 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/git-replay.txt
 create mode 100755 t/t3650-replay-basics.sh

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
new file mode 100644
index 0000000000..394d7b0050
--- /dev/null
+++ b/Documentation/git-replay.txt
@@ -0,0 +1,88 @@
+git-replay(1)
+=============
+
+NAME
+----
+git-replay - Replay commits on a different base, without touching working tree
+
+
+SYNOPSIS
+--------
+[verse]
+'git replay' --onto <newbase> <revision-range>...
+
+DESCRIPTION
+-----------
+
+Takes a range of commits, and replays them onto a new location.  Does
+not touch the working tree or index, and does not update any
+references.  However, the output of this command is meant to be used
+as input to `git update-ref --stdin`, which would update the relevant
+branches.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+OPTIONS
+-------
+
+--onto <newbase>::
+	Starting point at which to create the new commits.  May be any
+	valid commit, and not just an existing branch name.
++
+The update-ref commands in the output will update the branch(es)
+in the revision range to point at the new commits (in other
+words, this mimics a rebase operation).
+
+<revision-range>::
+	Range of commits to replay; see "Specifying Ranges" in
+	linkgit:git-rev-parse.
+
+OUTPUT
+------
+
+When there are no conflicts, the output of this command is usable as
+input to `git update-ref --stdin`.  It is basically of the form:
+
+	update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
+	update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
+	update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
+
+where the number of refs updated depend on the arguments passed.
+
+EXIT STATUS
+-----------
+
+For a successful, non-conflicted replay, the exit status is 0.  When
+the replay has conflicts, the exit status is 1.  If the replay is not
+able to complete (or start) due to some kind of error, the exit status
+is something other than 0 or 1.
+
+EXAMPLES
+--------
+
+To simply rebase mybranch onto target:
+
+------------
+$ git replay --onto target origin/main..mybranch
+update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
+------------
+
+When calling `git replay`, one does not need to specify a range of
+commits to replay using the syntax `A..B`; any range expression will
+do:
+
+------------
+$ git replay --onto origin/main ^base branch1 branch2 branch3
+update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
+update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
+update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
+------------
+
+This will simultaneously rebase branch1, branch2, and branch3 -- all
+commits they have since base, playing them on top of origin/main.
+These three branches may have commits on top of base that they have in
+common, but that does not need to be the case.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/builtin/replay.c b/builtin/replay.c
index 9385973ffc..c1bd72c0e5 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -14,7 +14,6 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
-#include "strvec.h"
 #include <oidset.h>
 #include <tree.h>
 
@@ -118,16 +117,14 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct commit *onto;
 	const char *onto_name = NULL;
 	struct commit *last_commit = NULL;
-	struct strvec rev_walk_args = STRVEC_INIT;
 	struct rev_info revs;
 	struct commit *commit;
 	struct merge_options merge_opt;
 	struct merge_result result;
-	struct strbuf branch_name = STRBUF_INIT;
 	int ret = 0;
 
 	const char * const replay_usage[] = {
-		N_("git replay --onto <newbase> <oldbase> <branch>"),
+		N_("git replay --onto <newbase> <revision-range>..."),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -145,20 +142,13 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		usage_with_options(replay_usage, replay_options);
 	}
 
-	if (argc != 3) {
-		error(_("bad number of arguments"));
-		usage_with_options(replay_usage, replay_options);
-	}
-
 	onto = peel_committish(onto_name);
-	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
 	repo_init_revisions(the_repository, &revs, prefix);
 
-	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
-
-	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
-		ret = error(_("unhandled options"));
+	argc = setup_revisions(argc, argv, &revs, NULL);
+	if (argc > 1) {
+		ret = error(_("unrecognized argument: %s"), argv[1]);
 		goto cleanup;
 	}
 
@@ -168,8 +158,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	revs.topo_order = 1;
 	revs.simplify_history = 0;
 
-	strvec_clear(&rev_walk_args);
-
 	if (prepare_revision_walk(&revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto cleanup;
@@ -212,7 +200,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	ret = result.clean;
 
 cleanup:
-	strbuf_release(&branch_name);
 	release_revisions(&revs);
 
 	/* Return */
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
new file mode 100755
index 0000000000..a1da4f9ef9
--- /dev/null
+++ b/t/t3650-replay-basics.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+test_description='basic git replay tests'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+GIT_AUTHOR_NAME=author@name
+GIT_AUTHOR_EMAIL=bogus@email@address
+export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+
+test_expect_success 'setup' '
+	test_commit A &&
+	test_commit B &&
+
+	git switch -c topic1 &&
+	test_commit C &&
+	git switch -c topic2 &&
+	test_commit D &&
+	test_commit E &&
+	git switch topic1 &&
+	test_commit F &&
+	git switch -c topic3 &&
+	test_commit G &&
+	test_commit H &&
+	git switch -c topic4 main &&
+	test_commit I &&
+	test_commit J &&
+
+	git switch -c next main &&
+	test_commit K &&
+	git merge -m "Merge topic1" topic1 &&
+	git merge -m "Merge topic2" topic2 &&
+	git merge -m "Merge topic3" topic3 &&
+	>evil &&
+	git add evil &&
+	git commit --amend &&
+	git merge -m "Merge topic4" topic4 &&
+
+	git switch main &&
+	test_commit L &&
+	test_commit M &&
+
+	git switch -c conflict B &&
+	test_commit C.conflict C.t conflict
+'
+
+test_expect_success 'setup bare' '
+	git clone --bare . bare
+'
+
+test_expect_success 'using replay to rebase two branches, one on top of other' '
+	git replay --onto main topic1..topic2 >result &&
+
+	test_line_count = 1 result &&
+
+	git log --format=%s $(cut -f 3 -d " " result) >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual &&
+
+	printf "update refs/heads/topic2 " >expect &&
+	printf "%s " $(cut -f 3 -d " " result) >>expect &&
+	git rev-parse topic2 >>expect &&
+
+	test_cmp expect result
+'
+
+test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
+	git -C bare replay --onto main topic1..topic2 >result-bare &&
+	test_cmp expect result-bare
+'
+
+test_expect_success 'using replay to rebase with a conflict' '
+	test_expect_code 1 git replay --onto topic1 B..conflict
+'
+
+test_expect_success 'using replay on bare repo to rebase with a conflict' '
+	test_expect_code 1 git -C bare replay --onto topic1 B..conflict
+'
+
+test_done
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index 099aefeffc..0f39ed0d08 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -71,7 +71,7 @@ test_expect_success 'caching renames does not preclude finding new ones' '
 
 		git switch upstream &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -141,7 +141,7 @@ test_expect_success 'cherry-pick both a commit and its immediate revert' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -201,7 +201,7 @@ test_expect_success 'rename same file identically, then reintroduce it' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -279,7 +279,7 @@ test_expect_success 'rename same file identically, then add file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -357,7 +357,7 @@ test_expect_success 'cached dir rename does not prevent noticing later conflict'
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test_must_fail git replay --onto HEAD upstream~1 topic >output &&
+		test_must_fail git replay --onto HEAD upstream~1..topic >output &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls
@@ -456,7 +456,7 @@ test_expect_success 'dir rename unneeded, then add new file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -523,7 +523,7 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -626,7 +626,7 @@ test_expect_success 'caching renames only on upstream side, part 1' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -685,7 +685,7 @@ test_expect_success 'caching renames only on upstream side, part 2' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
-- 
2.41.0.15.ga6d88fc8f0

