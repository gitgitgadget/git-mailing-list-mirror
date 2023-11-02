Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86851CAB6
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io1cVyf+"
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C212E
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:52:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32f737deedfso558930f8f.3
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933150; x=1699537950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHOLRsLHPKeFgeopTzXV5xfagG71+oHPhlWpsK62kCI=;
        b=Io1cVyf+8AR3Z7xEBBiLCelVMOAk5jSicShfh+YhilITePNe07uUCdwMnuFFO3SLWN
         YBaIu4HbYxP2imHLJLTzoU7OK3T/AktvHjPH9aCxqBb2LSPx6lp9HXGC3k3dD5V6Q3QJ
         073hKE9+yMT730g+BSxLbW9R6DFCByBU0/DGWstXG+qi3LCae+SNG9BRvCyuB1HT7aMq
         V5RjFc6Fv4AOAhfjBfnSMlIZ7MFZRUiO+CjgEbAkjH738gkVUEdlo3BKAB6XYehXj/zZ
         /p0GmKIg27icykbzFTnvW6OUjsmwNhxuoxhuIgsrObdZ/5VXWiGlNWBeCEHgeHLwaK2G
         I+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933150; x=1699537950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHOLRsLHPKeFgeopTzXV5xfagG71+oHPhlWpsK62kCI=;
        b=lKKlw4AJNRJn/GrYBRWw5vkml40mL9I9glNs0SqtpaPZUQY9pywxEeaTes6BmekXPS
         tQvP0r4Q3X93Tv5iljYYV8KDj25onm3r1boxMNhxsK5Nuca/ePDDp9guv/JJwybedHzQ
         5lcb8tiHZmIV9xDSCX8xdw6/EtAgY+f9341DE6UaFSfqAebQIn7C42/YXsGsf1erfoeb
         OipoOSpBKY9gkDDSG8ALG+RRo0v6SQA+K8UxEs+7wlYY76qVle/ZGhqIaFmS8DwH0nWA
         vaV2CpyUwSNeoX981b9rJl+7KTHm6eaTowvGny8a6f+aLB/Mi0MCctVob8qxNH5BB3Rv
         +ddQ==
X-Gm-Message-State: AOJu0YxzbUA6GYhauP3Y5Ria8Oz8FmkxRYzdkVJTxMRcCKSo17Hxlzwr
	6URKtfaYra09ekScTHdgHdRS3DeFBEs=
X-Google-Smtp-Source: AGHT+IEsjkIZ3nwT6mkNSg7lGch5Rs8zq8wXthHXWtfA631voNDjZCQq7a5TlCr/UpqwsinFGxhqag==
X-Received: by 2002:a5d:64c5:0:b0:32f:952f:c524 with SMTP id f5-20020a5d64c5000000b0032f952fc524mr6709579wri.10.1698933149897;
        Thu, 02 Nov 2023 06:52:29 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:116d:4e46:313c:1f52:4963:91b6])
        by smtp.gmail.com with ESMTPSA id e6-20020adffc46000000b0030647449730sm2514996wrs.74.2023.11.02.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:52:29 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 11/14] replay: use standard revision ranges
Date: Thu,  2 Nov 2023 14:51:48 +0100
Message-ID: <20231102135151.843758-12-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.496.g529a7fda40
In-Reply-To: <20231102135151.843758-1-christian.couder@gmail.com>
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
we can add more documentation and more testcases to make sure
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
 Documentation/git-replay.txt             | 55 +++++++++++++++++++++++-
 builtin/replay.c                         | 21 ++-------
 t/t3650-replay-basics.sh                 | 12 +++++-
 t/t6429-merge-sequence-rename-caching.sh | 18 ++++----
 4 files changed, 76 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index 4c852ff3bd..36ddd7daed 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -9,7 +9,7 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-'git replay' --onto <newbase> <oldbase> <branch> # EXPERIMENTAL
+'git replay' --onto <newbase> <revision-range>... # EXPERIMENTAL
 
 DESCRIPTION
 -----------
@@ -17,7 +17,8 @@ DESCRIPTION
 Takes a range of commits and replays them onto a new location. Leaves
 the working tree and the index untouched, and updates no
 references. The output of this command is meant to be used as input to
-`git update-ref --stdin`, which would update the relevant branches.
+`git update-ref --stdin`, which would update the relevant branches
+(see the OUTPUT section below).
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
@@ -27,6 +28,30 @@ OPTIONS
 --onto <newbase>::
 	Starting point at which to create the new commits.  May be any
 	valid commit, and not just an existing branch name.
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
 
 EXIT STATUS
 -----------
@@ -36,6 +61,32 @@ the replay has conflicts, the exit status is 1.  If the replay is not
 able to complete (or start) due to some kind of error, the exit status
 is something other than 0 or 1.
 
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
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/replay.c b/builtin/replay.c
index 7e3ebac3db..8fe4391976 100644
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
 	int i, ret = 0;
 
 	const char * const replay_usage[] = {
-		N_("git replay --onto <newbase> <oldbase> <branch> # EXPERIMENTAL"),
+		N_("git replay --onto <newbase> <revision-range>... # EXPERIMENTAL"),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -145,18 +142,10 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
 	/*
 	 * TODO: For now, let's warn when we see an option that we are
 	 * going to override after setup_revisions() below. In the
@@ -170,8 +159,9 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			warning(_("option '%s' will be overridden"), argv[i]);
 	}
 
-	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
-		ret = error(_("unhandled options"));
+	argc = setup_revisions(argc, argv, &revs, NULL);
+	if (argc > 1) {
+		ret = error(_("unrecognized argument: %s"), argv[1]);
 		goto cleanup;
 	}
 
@@ -181,8 +171,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	revs.topo_order = 1;
 	revs.simplify_history = 0;
 
-	strvec_clear(&rev_walk_args);
-
 	if (prepare_revision_walk(&revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto cleanup;
@@ -224,7 +212,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	ret = result.clean;
 
 cleanup:
-	strbuf_release(&branch_name);
 	release_revisions(&revs);
 
 	/* Return */
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 3567c98362..a1da4f9ef9 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -52,7 +52,7 @@ test_expect_success 'setup bare' '
 '
 
 test_expect_success 'using replay to rebase two branches, one on top of other' '
-	git replay --onto main topic1 topic2 >result &&
+	git replay --onto main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
@@ -68,8 +68,16 @@ test_expect_success 'using replay to rebase two branches, one on top of other' '
 '
 
 test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
-	git -C bare replay --onto main topic1 topic2 >result-bare &&
+	git -C bare replay --onto main topic1..topic2 >result-bare &&
 	test_cmp expect result-bare
 '
 
+test_expect_success 'using replay to rebase with a conflict' '
+	test_expect_code 1 git replay --onto topic1 B..conflict
+'
+
+test_expect_success 'using replay on bare repo to rebase with a conflict' '
+	test_expect_code 1 git -C bare replay --onto topic1 B..conflict
+'
+
 test_done
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
2.42.0.496.g529a7fda40

