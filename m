Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA313CD80C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjJJMjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjJJMj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:39:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B42FB
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40572aeb673so54277965e9.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941559; x=1697546359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WnV72tVPZcMUI+gcgnS1nrDKjuufUjlRcljke+jwOk=;
        b=jEWdl70taIKTmb3Ynrx/BO649tONzeNvWF8H6C9vtyrGMnxIpzmukTcwsni1zJAtAl
         Z+ezJwr2V+sHYLchjSUPHFFlXTkuh53LHkL0NKzhZwOiJ6+DqVE6zplz6hD6u2YszYc9
         /8z4KBtzz5rQP5MvGCG1jWHnUr30g/agfSG4hRI3Wf2azkLdAEdmLBD8dTp1ZayQWf+t
         ZorJE/HobIdy+0RJWDqiR8+kSeRR1s0oBiUlHGRPhg3+pn6o518/vyDIX1Y/93pbdQYi
         rfgXfjE4Ebls/2+QELguTsNIQqFSGO8zVhcWOqjKVVe+R1R4N/a0h9EJySC+NJ+qGmtW
         C1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941559; x=1697546359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WnV72tVPZcMUI+gcgnS1nrDKjuufUjlRcljke+jwOk=;
        b=dioxvquaJ7x5e2QHFMRLfDiZ516pRt133TI9SFIaWmK2FFbTNN1NnTzwDah7WU0lVN
         uGVgybmBe3LhUHLQ10kcM/Tn80pbrIwooX7ykRinePyIc38IcCmvc1IkMFBNbsd7REnA
         6vscxawvDvBnfDdtDYWkK3ILkX0KtxklaWixWaEmswYOw06VD76H5SDaoOzRCIVP1fnA
         opCk5p406LEA6e1wgjO+Vw8jozbrYlf8+YceIu9qM/N5BcMD0bIZXGub8udiqSGBfv8e
         qZsSLg0Geuh/Y0dz9380A2Yp279mcWgSRpfrYeJCDvvH3XP6/Yj5K3lRBw2Pzcl8wQyi
         JYew==
X-Gm-Message-State: AOJu0Yy9mKLH3uhDVTQ8a+em42pcpWNU+/SNW578k+acoBDt2xybUKMb
        JygomckdG+HXZOtJifu1k1yGW4tkcg05LQ==
X-Google-Smtp-Source: AGHT+IF8y/2UskzeRwjQ497zurUl/bMbQdd8cWrOwWtZ+QL4QWOuHUKNUZlibosEvDkqUwykTbmHiQ==
X-Received: by 2002:a05:600c:252:b0:402:f536:2d3e with SMTP id 18-20020a05600c025200b00402f5362d3emr15628385wmj.14.1696941559449;
        Tue, 10 Oct 2023 05:39:19 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:516d:299b:cbff:be05])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm14071689wma.45.2023.10.10.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:39:18 -0700 (PDT)
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
Subject: [PATCH v5 11/14] replay: use standard revision ranges
Date:   Tue, 10 Oct 2023 14:38:44 +0200
Message-ID: <20231010123847.2777056-12-christian.couder@gmail.com>
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

Instead of the fixed "<oldbase> <branch>" arguments, the replay
command now accepts "<revision-range>..." arguments in a similar
way as many other Git commands. This makes its interface more
standard and more flexible.

This also enables many revision related options accepted and
eaten by setup_revisions(). If the replay command was a high level
one or had a high level mode, it would make sense to restrict some
of the possible options, like those generating non-contiguous
history, as they could be confusing for most users.

Also as the interface of the command is now mostly finalized,
we can add some documentation as well as testcases to make sure
the command will continue to work as designed in the future.

We only document the rev-list related options among all the
revision related options that are now accepted, as the rev-list
related ones are probably the most useful for now.

Helped-by: Dragan Simic <dsimic@manjaro.org>
Helped-by: Linus Arver <linusa@google.com>
Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replay.txt             | 92 ++++++++++++++++++++++++
 builtin/replay.c                         | 21 ++----
 t/t3650-replay-basics.sh                 | 83 +++++++++++++++++++++
 t/t6429-merge-sequence-rename-caching.sh | 18 ++---
 4 files changed, 188 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/git-replay.txt
 create mode 100755 t/t3650-replay-basics.sh

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
new file mode 100644
index 0000000000..86be363f9b
--- /dev/null
+++ b/Documentation/git-replay.txt
@@ -0,0 +1,92 @@
+git-replay(1)
+=============
+
+NAME
+----
+git-replay - Replay commits on a new base, works on bare repos too
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
+Takes a range of commits and replays them onto a new location. Leaves
+the working tree and the index untouched, and updates no
+references. The output of this command is meant to be used as input to
+`git update-ref --stdin`, which would update the relevant branches
+(see the OUTPUT section below).
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
+The update-ref command(s) in the output will update the branch(es) in
+the revision range to point at the new commits, similar to the way how
+`git rebase --update-refs` updates multiple branches in the affected
+range.
+
+<revision-range>::
+	Range of commits to replay; see "Specifying Ranges" in
+	linkgit:git-rev-parse and the "Commit Limiting" options below.
+
+include::rev-list-options.txt[]
+
+OUTPUT
+------
+
+When there are no conflicts, the output of this command is usable as
+input to `git update-ref --stdin`.  It is of the form:
+
+	update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
+	update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
+	update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
+
+where the number of refs updated depends on the arguments passed and
+the shape of the history being replayed.
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
+To simply rebase `mybranch` onto `target`:
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
+This will simultaneously rebase `branch1`, `branch2`, and `branch3`,
+all commits they have since `base`, playing them on top of
+`origin/main`. These three branches may have commits on top of `base`
+that they have in common, but that does not need to be the case.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/builtin/replay.c b/builtin/replay.c
index ace9ac6df0..213ac2764e 100644
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
@@ -211,7 +199,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
2.42.0.339.g663cbc8ab1

