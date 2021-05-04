Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F008C43461
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAC9611CD
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhEDCN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 22:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhEDCNW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 22:13:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F20C061763
        for <git@vger.kernel.org>; Mon,  3 May 2021 19:12:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h4so7550529wrt.12
        for <git@vger.kernel.org>; Mon, 03 May 2021 19:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c+UKrxYhl2gCd0tRi0F4OvfFV2iYJN0KI6IcSt63GXg=;
        b=OyM6rwFFPAYpes1i51cplsqttjA9ajvs2MmK3rwzknEOXck+nZMdMbk8ORzthyXKbe
         i40edbjzFhYTScFATXkCqhx7gJOgaypfOfxvkf2Su7nlOwLv6OjSahGCF7Rss7VI9Tpn
         M5Cd89CFxFj+BLOuuPbOeKsgaZpoL+TmKBbDiBxz73w09B8ZxsgKNQk5hPNYS22aZAUI
         iW3B8OmcJiInkQshFiZg/YcGQHQjBlXRda5Va54VWeBQ3C6ftAYMuc+JOB4PgtREI6Tr
         NU1hEPcs9xjzT486c9sm+c3UNXl3RggcRwvtef6gECqta1F07eFdXhghIfYpGhlod8rU
         pZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c+UKrxYhl2gCd0tRi0F4OvfFV2iYJN0KI6IcSt63GXg=;
        b=cGxEXIvwjuXauFUhg7ntr9aZQYq3Lb818UYt+gXQxHyJVrRSB+uf1lnseTnce+MNB6
         Ut4X5LzfpC+dhyfXio6q3nGB3ZmwbYx7ewPxTGg8u2AcBAKlP013SSvT2m6zfTW2WWnE
         Gy2HoODO+aHyZ1oiFYg/ZJ8UdxoT1P6zPjZsWr2rcSnLgQNSYeiUvfwETAodqAlJnUSP
         l5oiDAUNAKWYCXLoZErYDpPploRevmIwGS0Duqib+uVnImQEK+KM1xXoQvOn9FuRhuIG
         cYLTYANfyLPmZluo+a4Ht6qb0uKGRIJ4El4TZipTQm+w7kJdCiUMmBWg9CnaRBSj+GCO
         l3mg==
X-Gm-Message-State: AOAM533xPzc0etv1WHvUF0wdxO9k0KwaTbPmZAhXupPciQoQQ3XktnhL
        ssP/hKWC3HH7Lp9C/ZzUKEEZTZrOdis=
X-Google-Smtp-Source: ABdhPJxBFUVcO8Jp70Dak8fdR1Kd3cimuikwlf9wRGbKKBH+J9vX837Z2T5Q7O/QisGVdQO+vSMI8g==
X-Received: by 2002:adf:e611:: with SMTP id p17mr2098838wrm.161.1620094345788;
        Mon, 03 May 2021 19:12:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm271280wmh.34.2021.05.03.19.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 19:12:25 -0700 (PDT)
Message-Id: <54c126f3809815acde0fc078f1bebb51cfe78edb.1620094339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
        <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 02:12:11 +0000
Subject: [PATCH v2 05/13] t6429: testcases for remembering renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We will soon be adding an optimization that caches (in memory only,
never written to disk) upstream renames during a sequence of merges such
as occurs during a cherry-pick or rebase operation.  Add several tests
meant to stress such an implementation to ensure it does the right
thing, and include a test whose outcome we will later change due to this
optimization as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 .../technical/remembering-renames.txt         |  14 +-
 t/t6429-merge-sequence-rename-caching.sh      | 692 ++++++++++++++++++
 2 files changed, 700 insertions(+), 6 deletions(-)
 create mode 100755 t/t6429-merge-sequence-rename-caching.sh

diff --git a/Documentation/technical/remembering-renames.txt b/Documentation/technical/remembering-renames.txt
index e7c298d83df2..a1d3499ca727 100644
--- a/Documentation/technical/remembering-renames.txt
+++ b/Documentation/technical/remembering-renames.txt
@@ -214,12 +214,14 @@ in-memory cache of renames and thus doesn't need to be considered further.
 In the special case that E->A does rename the file but also renames it to
 newfile, then there is no conflict from the renaming and the merge can
 succeed.  In this special case, the rename is not valid to cache because
-the second merge will find A:newfile in the MERGE_BASE.  So a
-rename/rename(1to1) needs to be specially handled by pruning renames from
-the cache and decrementing the dir_rename_counts in the current and leading
-directories associated with those renames.  Or, since these are really
-rare, one could just take the easy way out and disable the remembering
-renames optimization when a rename/rename(1to1) happens.
+the second merge will find A:newfile in the MERGE_BASE (see also the new
+testcases in t6429 with "rename same file identically" in their
+description).  So a rename/rename(1to1) needs to be specially handled by
+pruning renames from the cache and decrementing the dir_rename_counts in
+the current and leading directories associated with those renames.  Or,
+since these are really rare, one could just take the easy way out and
+disable the remembering renames optimization when a rename/rename(1to1)
+happens.
 
 The previous paragraph handled the cases for E->A renaming oldfile, let's
 continue assuming that oldfile is not renamed in A.
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
new file mode 100755
index 000000000000..f47d8924ee73
--- /dev/null
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -0,0 +1,692 @@
+#!/bin/sh
+
+test_description="remember regular & dir renames in sequence of merges"
+
+. ./test-lib.sh
+
+#
+# NOTE 1: this testfile tends to not only rename files, but modify on both
+#         sides; without modifying on both sides, optimizations can kick in
+#         which make rename detection irrelevant or trivial.  We want to make
+#         sure that we are triggering rename caching rather than rename
+#         bypassing.
+#
+# NOTE 2: this testfile uses 'test-tool fast-rebase' instead of either
+#         cherry-pick or rebase.  sequencer.c is only superficially
+#         integrated with merge-ort; it calls merge_switch_to_result()
+#         after EACH merge, which updates the index and working copy AND
+#         throws away the cached results (because merge_switch_to_result()
+#         is only supposed to be called at the end of the sequence).
+#         Integrating them more deeply is a big task, so for now the tests
+#         use 'test-tool fast-rebase'.
+#
+
+
+#
+# In the following simple testcase:
+#   Base:     numbers_1, values_1
+#   Upstream: numbers_2, values_2
+#   Topic_1:  sequence_3
+#   Topic_2:  scruples_3
+# or, in english, rename numbers -> sequence in the first commit, and rename
+# values -> scruples in the second commit.
+#
+# This shouldn't be a challenge, it's just verifying that cached renames isn't
+# preventing us from finding new renames.
+#
+test_expect_success 'caching renames does not preclude finding new ones' '
+	test_create_repo caching-renames-and-new-renames &&
+	(
+		cd caching-renames-and-new-renames &&
+
+		test_seq 2 10 >numbers &&
+		test_seq 2 10 >values &&
+		git add numbers values &&
+		git commit -m orig &&
+
+		git branch upstream &&
+		git branch topic &&
+
+		git switch upstream &&
+		test_seq 1 10 >numbers &&
+		test_seq 1 10 >values &&
+		git add numbers values &&
+		git commit -m "Tweaked both files" &&
+
+		git switch topic &&
+
+		test_seq 2 12 >numbers &&
+		git add numbers &&
+		git mv numbers sequence &&
+		git commit -m A &&
+
+		test_seq 2 12 >values &&
+		git add values &&
+		git mv values scruples &&
+		git commit -m B &&
+
+		#
+		# Actual testing
+		#
+
+		git switch upstream &&
+
+		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		#git cherry-pick upstream~1..topic
+
+		git ls-files >tracked-files &&
+		test_line_count = 2 tracked-files &&
+		test_seq 1 12 >expect &&
+		test_cmp expect sequence &&
+		test_cmp expect scruples
+	)
+'
+
+#
+# In the following testcase:
+#   Base:     numbers_1
+#   Upstream: rename numbers_1 -> sequence_2
+#   Topic_1:  numbers_3
+#   Topic_2:  numbers_1
+# or, in english, the first commit on the topic branch modifies numbers by
+# shrinking it (dramatically) and the second commit on topic reverts its
+# parent.
+#
+# Can git apply both patches?
+#
+# Traditional cherry-pick/rebase will fail to apply the second commit, the
+# one that reverted its parent, because despite detecting the rename from
+# 'numbers' to 'sequence' for the first commit, it fails to detect that
+# rename when picking the second commit.  That's "reasonable" given the
+# dramatic change in size of the file, but remembering the rename and
+# reusing it is reasonable too.
+#
+# Rename detection (diffcore_rename_extended()) will run twice here; it is
+# not needed on the topic side of history for either of the two commits
+# being merged, but it is needed on the upstream side of history for each
+# commit being picked.
+test_expect_success 'cherry-pick both a commit and its immediate revert' '
+	test_create_repo pick-commit-and-its-immediate-revert &&
+	(
+		cd pick-commit-and-its-immediate-revert &&
+
+		test_seq 11 30 >numbers &&
+		git add numbers &&
+		git commit -m orig &&
+
+		git branch upstream &&
+		git branch topic &&
+
+		git switch upstream &&
+		test_seq 1 30 >numbers &&
+		git add numbers &&
+		git mv numbers sequence &&
+		git commit -m "Renamed (and modified) numbers -> sequence" &&
+
+		git switch topic &&
+
+		test_seq 11 13 >numbers &&
+		git add numbers &&
+		git commit -m A &&
+
+		git revert HEAD &&
+
+		#
+		# Actual testing
+		#
+
+		git switch upstream &&
+
+		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
+		export GIT_TRACE2_PERF &&
+
+		test_might_fail test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		#git cherry-pick upstream~1..topic &&
+
+		grep region_enter.*diffcore_rename trace.output >calls &&
+		test_line_count = 2 calls
+	)
+'
+
+#
+# In the following testcase:
+#   Base:     sequence_1
+#   Upstream: rename sequence_1 -> values_2
+#   Topic_1:  rename sequence_1 -> values_3
+#   Topic_2:  add unrelated sequence_4
+# or, in english, both sides rename sequence -> values, and then the second
+# commit on the topic branch adds an unrelated file called sequence.
+#
+# This testcase presents no problems for git traditionally, but having both
+# sides do the same rename in effect "uses it up" and if it remains cached,
+# could cause a spurious rename/add conflict.
+#
+test_expect_success 'rename same file identically, then reintroduce it' '
+	test_create_repo rename-rename-1to1-then-add-old-filename &&
+	(
+		cd rename-rename-1to1-then-add-old-filename &&
+
+		test_seq 3 8 >sequence &&
+		git add sequence &&
+		git commit -m orig &&
+
+		git branch upstream &&
+		git branch topic &&
+
+		git switch upstream &&
+		test_seq 1 8 >sequence &&
+		git add sequence &&
+		git mv sequence values &&
+		git commit -m "Renamed (and modified) sequence -> values" &&
+
+		git switch topic &&
+
+		test_seq 3 10 >sequence &&
+		git add sequence &&
+		git mv sequence values &&
+		git commit -m A &&
+
+		test_write_lines A B C D E F G H I J >sequence &&
+		git add sequence &&
+		git commit -m B &&
+
+		#
+		# Actual testing
+		#
+
+		git switch upstream &&
+
+		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
+		export GIT_TRACE2_PERF &&
+
+		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		#git cherry-pick upstream~1..topic &&
+
+		git ls-files >tracked &&
+		test_line_count = 2 tracked &&
+		test_path_is_file values &&
+		test_path_is_file sequence &&
+
+		grep region_enter.*diffcore_rename trace.output >calls &&
+		test_line_count = 2 calls
+	)
+'
+
+#
+# In the following testcase:
+#   Base:     olddir/{valuesZ_1, valuesY_1, valuesX_1}
+#   Upstream: rename olddir/valuesZ_1 -> dirA/valuesZ_2
+#             rename olddir/valuesY_1 -> dirA/valuesY_2
+#             rename olddir/valuesX_1 -> dirB/valuesX_2
+#   Topic_1:  rename olddir/valuesZ_1 -> dirA/valuesZ_3
+#             rename olddir/valuesY_1 -> dirA/valuesY_3
+#   Topic_2:  add olddir/newfile
+#   Expected Pick1: dirA/{valuesZ, valuesY}, dirB/valuesX
+#   Expected Pick2: dirA/{valuesZ, valuesY}, dirB/{valuesX, newfile}
+#
+# This testcase presents no problems for git traditionally, but having both
+# sides do the same renames in effect "use it up" but if the renames remain
+# cached, the directory rename could put newfile in the wrong directory.
+#
+test_expect_success 'rename same file identically, then add file to old dir' '
+	test_create_repo rename-rename-1to1-then-add-file-to-old-dir &&
+	(
+		cd rename-rename-1to1-then-add-file-to-old-dir &&
+
+		mkdir olddir/ &&
+		test_seq 3 8 >olddir/valuesZ &&
+		test_seq 3 8 >olddir/valuesY &&
+		test_seq 3 8 >olddir/valuesX &&
+		git add olddir &&
+		git commit -m orig &&
+
+		git branch upstream &&
+		git branch topic &&
+
+		git switch upstream &&
+		test_seq 1 8 >olddir/valuesZ &&
+		test_seq 1 8 >olddir/valuesY &&
+		test_seq 1 8 >olddir/valuesX &&
+		git add olddir &&
+		mkdir dirA &&
+		git mv olddir/valuesZ olddir/valuesY dirA &&
+		git mv olddir/ dirB/ &&
+		git commit -m "Renamed (and modified) values*" &&
+
+		git switch topic &&
+
+		test_seq 3 10 >olddir/valuesZ &&
+		test_seq 3 10 >olddir/valuesY &&
+		git add olddir &&
+		mkdir dirA &&
+		git mv olddir/valuesZ olddir/valuesY dirA &&
+		git commit -m A &&
+
+		>olddir/newfile &&
+		git add olddir/newfile &&
+		git commit -m B &&
+
+		#
+		# Actual testing
+		#
+
+		git switch upstream &&
+		git config merge.directoryRenames true &&
+
+		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
+		export GIT_TRACE2_PERF &&
+
+		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		#git cherry-pick upstream~1..topic &&
+
+		git ls-files >tracked &&
+		test_line_count = 4 tracked &&
+		test_path_is_file dirA/valuesZ &&
+		test_path_is_file dirA/valuesY &&
+		test_path_is_file dirB/valuesX &&
+		test_path_is_file dirB/newfile &&
+
+		grep region_enter.*diffcore_rename trace.output >calls &&
+		test_line_count = 3 calls
+	)
+'
+
+#
+# In the following testcase, upstream renames a directory, and the topic branch
+# first adds a file to the directory, then later renames the directory
+# differently:
+#   Base:     olddir/a
+#             olddir/b
+#   Upstream: rename olddir/ -> newdir/
+#   Topic_1:  add olddir/newfile
+#   Topic_2:  rename olddir/ -> otherdir/
+#
+# Here we are just concerned that cached renames might prevent us from seeing
+# the rename conflict, and we want to ensure that we do get a conflict.
+#
+# While at it, also test that we do rename detection three times.  We have to
+# detect renames on the upstream side of history once for each merge, plus
+# Topic_2 has renames.
+#
+test_expect_success 'cached dir rename does not prevent noticing later conflict' '
+	test_create_repo dir-rename-cache-not-occluding-later-conflict &&
+	(
+		cd dir-rename-cache-not-occluding-later-conflict &&
+
+		mkdir olddir &&
+		test_seq 3 10 >olddir/a &&
+		test_seq 3 10 >olddir/b &&
+		git add olddir &&
+		git commit -m orig &&
+
+		git branch upstream &&
+		git branch topic &&
+
+		git switch upstream &&
+		test_seq 3 10 >olddir/a &&
+		test_seq 3 10 >olddir/b &&
+		git add olddir &&
+		git mv olddir newdir &&
+		git commit -m "Dir renamed" &&
+
+		git switch topic &&
+
+		>olddir/newfile &&
+		git add olddir/newfile &&
+		git commit -m A &&
+
+		test_seq 1 8 >olddir/a &&
+		test_seq 1 8 >olddir/b &&
+		git add olddir &&
+		git mv olddir otherdir &&
+		git commit -m B &&
+
+		#
+		# Actual testing
+		#
+
+		git switch upstream &&
+		git config merge.directoryRenames true &&
+
+		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
+		export GIT_TRACE2_PERF &&
+
+		test_must_fail test-tool fast-rebase --onto HEAD upstream~1 topic >output &&
+		#git cherry-pick upstream..topic &&
+
+		grep CONFLICT..rename/rename output &&
+
+		grep region_enter.*diffcore_rename trace.output >calls &&
+		test_line_count = 3 calls
+	)
+'
+
+# Helper for the next two tests
+test_setup_upstream_rename () {
+	test_create_repo $1 &&
+	(
+		cd $1 &&
+
+		test_seq 3 8 >somefile &&
+		test_seq 3 8 >relevant-rename &&
+		git add somefile relevant-rename &&
+		mkdir olddir &&
+		test_write_lines a b c d e f g >olddir/a &&
+		test_write_lines z y x w v u t >olddir/b &&
+		git add olddir &&
+		git commit -m orig &&
+
+		git branch upstream &&
+		git branch topic &&
+
+		git switch upstream &&
+		test_seq 1 8 >somefile &&
+		test_seq 1 8 >relevant-rename &&
+		git add somefile relevant-rename &&
+		git mv relevant-rename renamed &&
+		echo h >>olddir/a &&
+		echo s >>olddir/b &&
+		git add olddir &&
+		git mv olddir newdir &&
+		git commit -m "Dir renamed"
+	)
+}
+
+#
+# In the following testcase, upstream renames a file in the toplevel directory
+# as well as its only directory:
+#   Base:     relevant-rename_1
+#             somefile
+#             olddir/a
+#             olddir/b
+#   Upstream: rename relevant-rename_1 -> renamed_2
+#             rename olddir/           -> newdir/
+#   Topic_1:  relevant-rename_3
+#   Topic_2:  olddir/newfile_1
+#   Topic_3:  olddir/newfile_2
+#
+# In this testcase, since the first commit being picked only modifies a
+# file in the toplevel directory, the directory rename is irrelevant for
+# that first merge.  However, we need to notice the directory rename for
+# the merge that picks the second commit, and we don't want the third
+# commit to mess up its location either.  We want to make sure that
+# olddir/newfile doesn't exist in the result and that newdir/newfile does.
+#
+# We also expect rename detection to occur three times.  Although it is
+# typically needed two times per commit, there are no deleted files on the
+# topic side of history, so we only need to detect renames on the upstream
+# side for each of the 3 commits we need to pick.
+#
+test_expect_success 'dir rename unneeded, then add new file to old dir' '
+	test_setup_upstream_rename dir-rename-unneeded-until-new-file &&
+	(
+		cd dir-rename-unneeded-until-new-file &&
+
+		git switch topic &&
+
+		test_seq 3 10 >relevant-rename &&
+		git add relevant-rename &&
+		git commit -m A &&
+
+		echo foo >olddir/newfile &&
+		git add olddir/newfile &&
+		git commit -m B &&
+
+		echo bar >>olddir/newfile &&
+		git add olddir/newfile &&
+		git commit -m C &&
+
+		#
+		# Actual testing
+		#
+
+		git switch upstream &&
+		git config merge.directoryRenames true &&
+
+		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
+		export GIT_TRACE2_PERF &&
+
+		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		#git cherry-pick upstream..topic &&
+
+		grep region_enter.*diffcore_rename trace.output >calls &&
+		test_line_count = 3 calls &&
+
+		git ls-files >tracked &&
+		test_line_count = 5 tracked &&
+		test_path_is_missing olddir/newfile &&
+		test_path_is_file newdir/newfile
+	)
+'
+
+#
+# The following testcase is *very* similar to the last one, but instead of
+# adding a new olddir/newfile, it renames somefile -> olddir/newfile:
+#   Base:     relevant-rename_1
+#             somefile_1
+#             olddir/a
+#             olddir/b
+#   Upstream: rename relevant-rename_1 -> renamed_2
+#             rename olddir/           -> newdir/
+#   Topic_1:  relevant-rename_3
+#   Topic_2:  rename somefile -> olddir/newfile_2
+#   Topic_3:  modify olddir/newfile_3
+#
+# In this testcase, since the first commit being picked only modifies a
+# file in the toplevel directory, the directory rename is irrelevant for
+# that first merge.  However, we need to notice the directory rename for
+# the merge that picks the second commit, and we don't want the third
+# commit to mess up its location either.  We want to make sure that
+# neither somefile or olddir/newfile exists in the result and that
+# newdir/newfile does.
+#
+# This testcase needs one more call to rename detection than the last
+# testcase, because of the somefile -> olddir/newfile rename in Topic_2.
+test_expect_success 'dir rename unneeded, then rename existing file into old dir' '
+	test_setup_upstream_rename dir-rename-unneeded-until-file-moved-inside &&
+	(
+		cd dir-rename-unneeded-until-file-moved-inside &&
+
+		git switch topic &&
+
+		test_seq 3 10 >relevant-rename &&
+		git add relevant-rename &&
+		git commit -m A &&
+
+		test_seq 1 10 >somefile &&
+		git add somefile &&
+		git mv somefile olddir/newfile &&
+		git commit -m B &&
+
+		test_seq 1 12 >olddir/newfile &&
+		git add olddir/newfile &&
+		git commit -m C &&
+
+		#
+		# Actual testing
+		#
+
+		git switch upstream &&
+		git config merge.directoryRenames true &&
+
+		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
+		export GIT_TRACE2_PERF &&
+
+		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		#git cherry-pick upstream..topic &&
+
+		grep region_enter.*diffcore_rename trace.output >calls &&
+		test_line_count = 4 calls &&
+
+		test_path_is_missing somefile &&
+		test_path_is_missing olddir/newfile &&
+		test_path_is_file newdir/newfile &&
+		git ls-files >tracked &&
+		test_line_count = 4 tracked
+	)
+'
+
+# Helper for the next two tests
+test_setup_topic_rename () {
+	test_create_repo $1 &&
+	(
+		cd $1 &&
+
+		test_seq 3 8 >somefile &&
+		mkdir olddir &&
+		test_seq 3 8 >olddir/a &&
+		echo b >olddir/b &&
+		git add olddir somefile &&
+		git commit -m orig &&
+
+		git branch upstream &&
+		git branch topic &&
+
+		git switch topic &&
+		test_seq 1 8 >somefile &&
+		test_seq 1 8 >olddir/a &&
+		git add somefile olddir/a &&
+		git mv olddir newdir &&
+		git commit -m "Dir renamed" &&
+
+		test_seq 1 10 >somefile &&
+		git add somefile &&
+		mkdir olddir &&
+		>olddir/unrelated-file &&
+		git add olddir &&
+		git commit -m "Unrelated file in recreated old dir"
+	)
+}
+
+#
+# In the following testcase, the first commit on the topic branch renames
+# a directory, while the second recreates the old directory and places a
+# file into it:
+#   Base:     somefile
+#             olddir/a
+#             olddir/b
+#   Upstream: olddir/newfile
+#   Topic_1:  somefile_2
+#             rename olddir/ -> newdir/
+#   Topic_2:  olddir/unrelated-file
+#
+# Note that the first pick should merge:
+#   Base:     somefile
+#             olddir/{a,b}
+#   Upstream: olddir/newfile
+#   Topic_1:  rename olddir/ -> newdir/
+# For which the expected result (assuming merge.directoryRenames=true) is
+# clearly:
+#   Result:   somefile
+#             newdir/{a, b, newfile}
+#
+# While the second pick does the following three-way merge:
+#   Base (Topic_1):           somefile
+#                             newdir/{a,b}
+#   Upstream (Result from 1): same files as base, but adds newdir/newfile
+#   Topic_2:                  same files as base, but adds olddir/unrelated-file
+#
+# The second merge is pretty trivial; upstream adds newdir/newfile, and
+# topic_2 adds olddir/unrelated-file.  We're just testing that we don't
+# accidentally cache directory renames somehow and rename
+# olddir/unrelated-file to newdir/unrelated-file.
+#
+# This testcase should only need one call to diffcore_rename_extended().
+test_expect_success 'caching renames only on upstream side, part 1' '
+	test_setup_topic_rename cache-renames-only-upstream-add-file &&
+	(
+		cd cache-renames-only-upstream-add-file &&
+
+		git switch upstream &&
+
+		>olddir/newfile &&
+		git add olddir/newfile &&
+		git commit -m "Add newfile" &&
+
+		#
+		# Actual testing
+		#
+
+		git switch upstream &&
+
+		git config merge.directoryRenames true &&
+
+		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
+		export GIT_TRACE2_PERF &&
+
+		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		#git cherry-pick upstream..topic &&
+
+		grep region_enter.*diffcore_rename trace.output >calls &&
+		test_line_count = 1 calls &&
+
+		git ls-files >tracked &&
+		test_line_count = 5 tracked &&
+		test_path_is_missing newdir/unrelated-file &&
+		test_path_is_file olddir/unrelated-file &&
+		test_path_is_file newdir/newfile &&
+		test_path_is_file newdir/b &&
+		test_path_is_file newdir/a &&
+		test_path_is_file somefile
+	)
+'
+
+#
+# The following testcase is *very* similar to the last one, but instead of
+# adding a new olddir/newfile, it renames somefile -> olddir/newfile:
+#   Base:     somefile
+#             olddir/a
+#             olddir/b
+#   Upstream: somefile_1 -> olddir/newfile
+#   Topic_1:  rename olddir/ -> newdir/
+#             somefile_2
+#   Topic_2:  olddir/unrelated-file
+#             somefile_3
+#
+# Much like the previous test, this case is actually trivial and we are just
+# making sure there isn't some spurious directory rename caching going on
+# for the wrong side of history.
+#
+#
+# This testcase should only need three calls to diffcore_rename_extended(),
+# because there are no renames on the topic side of history for picking
+# Topic_2.
+#
+test_expect_success 'caching renames only on upstream side, part 2' '
+	test_setup_topic_rename cache-renames-only-upstream-rename-file &&
+	(
+		cd cache-renames-only-upstream-rename-file &&
+
+		git switch upstream &&
+
+		git mv somefile olddir/newfile &&
+		git commit -m "Add newfile" &&
+
+		#
+		# Actual testing
+		#
+
+		git switch upstream &&
+
+		git config merge.directoryRenames true &&
+
+		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
+		export GIT_TRACE2_PERF &&
+
+		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		#git cherry-pick upstream..topic &&
+
+		grep region_enter.*diffcore_rename trace.output >calls &&
+		test_line_count = 3 calls &&
+
+		git ls-files >tracked &&
+		test_line_count = 4 tracked &&
+		test_path_is_missing newdir/unrelated-file &&
+		test_path_is_file olddir/unrelated-file &&
+		test_path_is_file newdir/newfile &&
+		test_path_is_file newdir/b &&
+		test_path_is_file newdir/a
+	)
+'
+
+test_done
-- 
gitgitgadget

