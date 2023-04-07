Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5722C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbjDGHZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239874AbjDGHZU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E57A5EF
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:24:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e18so41597309wra.9
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vxa5OhhmUjOxXPvuIRh3xlWU9K1vh91Ux20n7ja7Wg0=;
        b=fMoEVRYz0xGTWN7SZjGordNS4JKT/uUXiaXzjFa1jF1LWHMVnNuiM8cUR5jvom4gtN
         ywFVO1EaoPdFNXgxg0dJ6QsAtIbAcFGT51lXYGNL6GD7SOFXEnUy/pOKWNE0NAZa/gf9
         ESGxsKu7xfSzIv5l8CxU5su8rbMIE06CCcANQIoHHPPi1mpxSvPfbHa2aDIuM2RHAG/w
         4bPZuZCZPFViLUWmXbq/7pHrlNzJ/fl0/BJIes9KLELuA/zS2jvo+gQrD+6ODOtxD4w7
         IzYSsvvZBYXKfDk+X8ydX+Dkk/4zfyt017FbEi3nujX7SEMiCsg7TrxEX4DfdZcN6XVb
         QXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vxa5OhhmUjOxXPvuIRh3xlWU9K1vh91Ux20n7ja7Wg0=;
        b=gY9vIapuiMdzwjHeFnYtj6sy7WtdBC5OyWheNkYIlkfEU7GLXy+8WpGYbUkpy98yDr
         ABVtNaM+IR41jzLzTfCm2JJXxsjevA/ng2KK9AGtZzyltt9mtDDPOj+QAZaGtLPJZ4r8
         PmscM09mFcyT/5rx9FiG0B9Z4SD49zkuQ+UqkjhUcPBOhQ19NEo6QPmKnOEoW8znw20E
         R6DQb/e3uFy/y/JdkMWLQ7l88pbZhs418RG8ha8UJgXUd8E2B0Ng1mgappbVxDpG2TjB
         PsjiEGVlY4avaUKEuiLqaeBqihlEf7jh0gziKbNyUUuogPichh9U2GlhLTEBNQhsXXl8
         y6uQ==
X-Gm-Message-State: AAQBX9fY3zKCifuFpI3DiOabmsVPMfmzMn3GmAbT1ZCqdJAAm5VKt41J
        MrhxPmFTVIp0O9L292pBNTIhD60fVuqr8A==
X-Google-Smtp-Source: AKy350ZgmwsLFqmr5OKv1+nBUerT0qq3stGIzSB0ewXn2VL30s35BGmIwMBk9w4BUuyr2m3PCeKrMA==
X-Received: by 2002:a5d:4610:0:b0:2dc:cad4:87b9 with SMTP id t16-20020a5d4610000000b002dccad487b9mr586526wrq.68.1680852290714;
        Fri, 07 Apr 2023 00:24:50 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:50 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 11/14] replay: use standard revision ranges
Date:   Fri,  7 Apr 2023 09:24:12 +0200
Message-Id: <20230407072415.1360068-12-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
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
 Documentation/git-replay.txt             | 86 ++++++++++++++++++++++++
 builtin/replay.c                         | 21 ++----
 t/t3650-replay-basics.sh                 | 63 +++++++++++++++++
 t/t6429-merge-sequence-rename-caching.sh | 18 ++---
 4 files changed, 162 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/git-replay.txt
 create mode 100755 t/t3650-replay-basics.sh

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
new file mode 100644
index 0000000000..7a83f70343
--- /dev/null
+++ b/Documentation/git-replay.txt
@@ -0,0 +1,86 @@
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
index 119cfecfe7..63513ea6f1 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -12,7 +12,6 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
-#include "strvec.h"
 
 static const char *short_commit_name(struct commit *commit)
 {
@@ -111,16 +110,14 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
@@ -138,20 +135,13 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
 
@@ -161,8 +151,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	revs.topo_order = 1;
 	revs.simplify_history = 0;
 
-	strvec_clear(&rev_walk_args);
-
 	if (prepare_revision_walk(&revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto cleanup;
@@ -228,7 +216,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	ret = result.clean;
 
 cleanup:
-	strbuf_release(&branch_name);
 	release_revisions(&revs);
 
 	/* Return */
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
new file mode 100755
index 0000000000..f55b71763a
--- /dev/null
+++ b/t/t3650-replay-basics.sh
@@ -0,0 +1,63 @@
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
+	test_commit M
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
+test_done
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index bfdf7f30b3..8f3c394f0e 100755
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
 
 		grep CONFLICT..rename/rename output &&
 
@@ -458,7 +458,7 @@ test_expect_success 'dir rename unneeded, then add new file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -525,7 +525,7 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -628,7 +628,7 @@ test_expect_success 'caching renames only on upstream side, part 1' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
@@ -687,7 +687,7 @@ test_expect_success 'caching renames only on upstream side, part 2' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		git replay --onto HEAD upstream~1 topic >out &&
+		git replay --onto HEAD upstream~1..topic >out &&
 		git update-ref --stdin <out &&
 		git checkout topic &&
 
-- 
2.40.0.228.gb2eb5bb98e

