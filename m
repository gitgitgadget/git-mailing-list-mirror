Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDC8EC8748
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 16:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbjIGQzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjIGQzd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 12:55:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192C71BE4
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 09:55:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-501be2d45e0so1943998e87.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 09:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694105647; x=1694710447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx8a78kSeIAviuV/vuA4G6UNVTFx+KKhZ3+hsqXQs60=;
        b=heNprYVG8YZ/zY++OEFeNbHQ0psbYmTLsPxZ9nf60HfJl2xf7H9tcjb+RfU7DHiMoj
         CrYO62iAJIAEf0OrZ438a/Yc+LmP6/vODefhKnRU4EQ1S0Y0ROYY6CTUzrCngpmXZz05
         kutZkSxy7VKV2HLcALYwBXRx9LhSGdK4/V9VxZzlQ7C6ZrOraqJjucJcN1gV29wupn+Q
         ZN/0juE5mVFxKvIXd224TNwoK1XuaQV+09yjV3dySknooN10FlR3+pnRgTRQPNq2Sv5G
         ABpuRlFeNhTgOs0KHi6rWRXPuXn7C2eTSS1G+0PlnQdNgvQmp2bNrLhsLsAP5jBj4OTJ
         XLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105647; x=1694710447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx8a78kSeIAviuV/vuA4G6UNVTFx+KKhZ3+hsqXQs60=;
        b=R+N4itZxTabC/gjuAhMH/yJxsvaARoo1KzaKyUHJW5a9IV03Ekcjwz717lGtoVSdr6
         2MVN3t/eAtw/8bbzNMXX8N01V9manrTw0ahDZLaDFsJVP26QN8rKMbGuYZgaQualPkNh
         7nbHpIANSywiuvcAX7tUYtR486cBni94roeIZODzWUc3fCQmCHomAkh08GiC8NXyep00
         7ueOSXUxIDgMxvFn1M1vADRZTfsG/9gSEVo+GKko3mO99kZnkItmr2+q5uq2vMeqaVsp
         ZocozMZijQnqf865loH8zb+6PxQavtSSUpwLDPlxeIXJEJy80LPKXz+7xaoWeEsW2kmB
         nt1w==
X-Gm-Message-State: AOJu0YwPkZyHn+jbR0zUDZL/8Hi+nnVOgoN2MyQaZs5avgjEFMexPx32
        NPKQ2ama26VtneDgl2c2f8fdGe4PnmA=
X-Google-Smtp-Source: AGHT+IEOuYRozGg3i8R8enO2bQwj23tsJqwmDiTamv0syGq/al4GR62OfVhm4ZNAuA5VYENT8c2fNg==
X-Received: by 2002:adf:f6c7:0:b0:319:5e0d:9b0f with SMTP id y7-20020adff6c7000000b003195e0d9b0fmr4217174wrp.33.1694078950721;
        Thu, 07 Sep 2023 02:29:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:29:10 -0700 (PDT)
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
Subject: [PATCH v4 13/15] replay: add --advance or 'cherry-pick' mode
Date:   Thu,  7 Sep 2023 11:25:19 +0200
Message-ID: <20230907092521.733746-14-christian.couder@gmail.com>
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

There is already a 'rebase' mode with `--onto`. Let's add an 'advance' or
'cherry-pick' mode with `--advance`. This new mode will make the target
branch advance as we replay commits onto it.

The replayed commits should have a single tip, so that it's clear where
the target branch should be advanced. If they have more than one tip,
this new mode will error out.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replay.txt |  40 ++++++--
 builtin/replay.c             | 185 +++++++++++++++++++++++++++++++++--
 t/t3650-replay-basics.sh     |  34 +++++++
 3 files changed, 242 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index 9a2087b01a..5c5c15237d 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -9,7 +9,7 @@ git-replay - Replay commits on a different base, without touching working tree
 SYNOPSIS
 --------
 [verse]
-'git replay' --onto <newbase> <revision-range>...
+'git replay' (--onto <newbase> | --advance <branch>) <revision-range>...
 
 DESCRIPTION
 -----------
@@ -29,14 +29,24 @@ OPTIONS
 	Starting point at which to create the new commits.  May be any
 	valid commit, and not just an existing branch name.
 +
-The update-ref command(s) in the output will update the branch(es) in
-the revision range to point at the new commits, similar to the way how
-`git rebase --update-refs` updates multiple branches in the affected
-range.
+When `--onto` is specified, the update-ref command(s) in the output will
+update the branch(es) in the revision range to point at the new
+commits, similar to the way how `git rebase --update-refs` updates
+multiple branches in the affected range.
+
+--advance <branch>::
+	Starting point at which to create the new commits; must be a
+	branch name.
++
+When `--advance` is specified, the update-ref command(s) in the output
+will update the branch passed as an argument to `--advance` to point at
+the new commits (in other words, this mimics a cherry-pick operation).
 
 <revision-range>::
-	Range of commits to replay; see "Specifying Ranges" in
-	linkgit:git-rev-parse.
+	Range of commits to replay. More than one <revision-range> can
+	be passed, but in `--advance <branch>` mode, they should have
+	a single tip, so that it's clear where <branch> should point
+	to. See "Specifying Ranges" in linkgit:git-rev-parse.
 
 OUTPUT
 ------
@@ -49,7 +59,9 @@ input to `git update-ref --stdin`.  It is basically of the form:
 	update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
 
 where the number of refs updated depends on the arguments passed and
-the shape of the history being replayed.
+the shape of the history being replayed.  When using `--advance`, the
+number of refs updated is always one, but for `--onto`, it can be one
+or more (rebasing multiple branches simultaneously is supported).
 
 EXIT STATUS
 -----------
@@ -69,6 +81,18 @@ $ git replay --onto target origin/main..mybranch
 update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
 ------------
 
+To cherry-pick the commits from mybranch onto target:
+
+------------
+$ git replay --advance target origin/main..mybranch
+update refs/heads/target ${NEW_target_HASH} ${OLD_target_HASH}
+------------
+
+Note that the first two examples replay the exact same commits and on
+top of the exact same new base, they only differ in that the first
+provides instructions to make mybranch point at the new commits and
+the second provides instructions to make target point at them.
+
 When calling `git replay`, one does not need to specify a range of
 commits to replay using the syntax `A..B`; any range expression will
 do:
diff --git a/builtin/replay.c b/builtin/replay.c
index 60abdaee9e..6b89964be9 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -14,6 +14,7 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
+#include "strmap.h"
 #include <oidset.h>
 #include <tree.h>
 
@@ -82,6 +83,146 @@ static struct commit *create_commit(struct tree *tree,
 	return (struct commit *)obj;
 }
 
+struct ref_info {
+	struct commit *onto;
+	struct strset positive_refs;
+	struct strset negative_refs;
+	int positive_refexprs;
+	int negative_refexprs;
+};
+
+static void get_ref_information(struct rev_cmdline_info *cmd_info,
+				struct ref_info *ref_info)
+{
+	int i;
+
+	ref_info->onto = NULL;
+	strset_init(&ref_info->positive_refs);
+	strset_init(&ref_info->negative_refs);
+	ref_info->positive_refexprs = 0;
+	ref_info->negative_refexprs = 0;
+
+	/*
+	 * When the user specifies e.g.
+	 *   git replay origin/main..mybranch
+	 *   git replay ^origin/next mybranch1 mybranch2
+	 * we want to be able to determine where to replay the commits.  In
+	 * these examples, the branches are probably based on an old version
+	 * of either origin/main or origin/next, so we want to replay on the
+	 * newest version of that branch.  In contrast we would want to error
+	 * out if they ran
+	 *   git replay ^origin/master ^origin/next mybranch
+	 *   git replay mybranch~2..mybranch
+	 * the first of those because there's no unique base to choose, and
+	 * the second because they'd likely just be replaying commits on top
+	 * of the same commit and not making any difference.
+	 */
+	for (i = 0; i < cmd_info->nr; i++) {
+		struct rev_cmdline_entry *e = cmd_info->rev + i;
+		struct object_id oid;
+		const char *refexpr = e->name;
+		char *fullname = NULL;
+		int can_uniquely_dwim = 1;
+
+		if (*refexpr == '^')
+			refexpr++;
+		if (repo_dwim_ref(the_repository, refexpr, strlen(refexpr), &oid, &fullname, 0) != 1)
+			can_uniquely_dwim = 0;
+
+		if (e->flags & BOTTOM) {
+			if (can_uniquely_dwim)
+				strset_add(&ref_info->negative_refs, fullname);
+			if (!ref_info->negative_refexprs)
+				ref_info->onto = lookup_commit_reference_gently(the_repository,
+										&e->item->oid, 1);
+			ref_info->negative_refexprs++;
+		} else {
+			if (can_uniquely_dwim)
+				strset_add(&ref_info->positive_refs, fullname);
+			ref_info->positive_refexprs++;
+		}
+
+		free(fullname);
+	}
+}
+
+static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
+				  const char *onto_name,
+				  const char **advance_name,
+				  struct commit **onto,
+				  struct strset **update_refs)
+{
+	struct ref_info rinfo;
+
+	get_ref_information(cmd_info, &rinfo);
+	if (!rinfo.positive_refexprs)
+		die(_("need some commits to replay"));
+	if (onto_name && *advance_name)
+		die(_("--onto and --advance are incompatible"));
+	else if (onto_name) {
+		*onto = peel_committish(onto_name);
+		if (rinfo.positive_refexprs <
+		    strset_get_size(&rinfo.positive_refs))
+			die(_("all positive revisions given must be references"));
+	} else if (*advance_name) {
+		struct object_id oid;
+		char *fullname = NULL;
+
+		*onto = peel_committish(*advance_name);
+		if (repo_dwim_ref(the_repository, *advance_name, strlen(*advance_name),
+			     &oid, &fullname, 0) == 1) {
+			*advance_name = fullname;
+		} else {
+			die(_("argument to --advance must be a reference"));
+		}
+		if (rinfo.positive_refexprs > 1)
+			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
+	} else {
+		int positive_refs_complete = (
+			rinfo.positive_refexprs ==
+			strset_get_size(&rinfo.positive_refs));
+		int negative_refs_complete = (
+			rinfo.negative_refexprs ==
+			strset_get_size(&rinfo.negative_refs));
+		/*
+		 * We need either positive_refs_complete or
+		 * negative_refs_complete, but not both.
+		 */
+		if (rinfo.negative_refexprs > 0 &&
+		    positive_refs_complete == negative_refs_complete)
+			die(_("cannot implicitly determine whether this is an --advance or --onto operation"));
+		if (negative_refs_complete) {
+			struct hashmap_iter iter;
+			struct strmap_entry *entry;
+
+			if (rinfo.negative_refexprs == 0)
+				die(_("all positive revisions given must be references"));
+			else if (rinfo.negative_refexprs > 1)
+				die(_("cannot implicitly determine whether this is an --advance or --onto operation"));
+			else if (rinfo.positive_refexprs > 1)
+				die(_("cannot advance target with multiple source branches because ordering would be ill-defined"));
+
+			/* Only one entry, but we have to loop to get it */
+			strset_for_each_entry(&rinfo.negative_refs,
+					      &iter, entry) {
+				*advance_name = entry->key;
+			}
+		} else { /* positive_refs_complete */
+			if (rinfo.negative_refexprs > 1)
+				die(_("cannot implicitly determine correct base for --onto"));
+			if (rinfo.negative_refexprs == 1)
+				*onto = rinfo.onto;
+		}
+	}
+	if (!*advance_name) {
+		*update_refs = xcalloc(1, sizeof(**update_refs));
+		**update_refs = rinfo.positive_refs;
+		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
+	}
+	strset_clear(&rinfo.negative_refs);
+	strset_clear(&rinfo.positive_refs);
+}
+
 static struct commit *pick_regular_commit(struct commit *pickme,
 					  struct commit *last_commit,
 					  struct merge_options *merge_opt,
@@ -114,20 +255,26 @@ static struct commit *pick_regular_commit(struct commit *pickme,
 
 int cmd_replay(int argc, const char **argv, const char *prefix)
 {
-	struct commit *onto;
+	const char *advance_name = NULL;
+	struct commit *onto = NULL;
 	const char *onto_name = NULL;
-	struct commit *last_commit = NULL;
+
 	struct rev_info revs;
+	struct commit *last_commit = NULL;
 	struct commit *commit;
 	struct merge_options merge_opt;
 	struct merge_result result;
+	struct strset *update_refs = NULL;
 	int ret = 0, i;
 
 	const char * const replay_usage[] = {
-		N_("git replay --onto <newbase> <revision-range>..."),
+		N_("git replay (--onto <newbase> | --advance <branch>) <revision-range>..."),
 		NULL
 	};
 	struct option replay_options[] = {
+		OPT_STRING(0, "advance", &advance_name,
+			   N_("branch"),
+			   N_("make replay advance given branch")),
 		OPT_STRING(0, "onto", &onto_name,
 			   N_("revision"),
 			   N_("replay onto given commit")),
@@ -151,13 +298,11 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			usage_with_options(replay_usage, replay_options);
 		}
 
-	if (!onto_name) {
-		error(_("option --onto is mandatory"));
+	if (!onto_name && !advance_name) {
+		error(_("option --onto or --advance is mandatory"));
 		usage_with_options(replay_usage, replay_options);
 	}
 
-	onto = peel_committish(onto_name);
-
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	argc = setup_revisions(argc, argv, &revs, NULL);
@@ -182,6 +327,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	revs.topo_order = 1;
 	revs.simplify_history = 0;
 
+	determine_replay_mode(&revs.cmdline, onto_name, &advance_name,
+			      &onto, &update_refs);
+
+	if (!onto) /* FIXME: Should handle replaying down to root commit */
+		die("Replaying down to root commit is not supported yet!");
+
 	if (prepare_revision_walk(&revs) < 0) {
 		ret = error(_("error preparing revisions"));
 		goto cleanup;
@@ -190,6 +341,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 0;
+
 	result.tree = repo_get_commit_tree(the_repository, onto);
 	last_commit = onto;
 	while ((commit = get_revision(&revs))) {
@@ -204,12 +356,15 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (!last_commit)
 			break;
 
+		/* Update any necessary branches */
+		if (advance_name)
+			continue;
 		decoration = get_name_decoration(&commit->object);
 		if (!decoration)
 			continue;
-
 		while (decoration) {
-			if (decoration->type == DECORATION_REF_LOCAL) {
+			if (decoration->type == DECORATION_REF_LOCAL &&
+			    strset_contains(update_refs, decoration->name)) {
 				printf("update %s %s %s\n",
 				       decoration->name,
 				       oid_to_hex(&last_commit->object.oid),
@@ -219,10 +374,22 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	/* In --advance mode, advance the target ref */
+	if (result.clean == 1 && advance_name) {
+		printf("update %s %s %s\n",
+		       advance_name,
+		       oid_to_hex(&last_commit->object.oid),
+		       oid_to_hex(&onto->object.oid));
+	}
+
 	merge_finalize(&merge_opt, &result);
 	ret = result.clean;
 
 cleanup:
+	if (update_refs) {
+		strset_clear(update_refs);
+		free(update_refs);
+	}
 	release_revisions(&revs);
 
 	/* Return */
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index de6e40950e..1919f7d5d1 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -96,4 +96,38 @@ test_expect_success 'using replay on bare repo with disallowed pathspec' '
 	test_must_fail git -C bare replay --onto main topic1..topic2 -- A.t
 '
 
+test_expect_success 'using replay to perform basic cherry-pick' '
+	# The differences between this test and previous ones are:
+	#   --advance vs --onto
+	# 2nd field of result is refs/heads/main vs. refs/heads/topic2
+	# 4th field of result is hash for main instead of hash for topic2
+
+	git replay --advance main topic1..topic2 >result &&
+
+	test_line_count = 1 result &&
+
+	git log --format=%s $(cut -f 3 -d " " result) >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual &&
+
+	printf "update refs/heads/main " >expect &&
+	printf "%s " $(cut -f 3 -d " " result) >>expect &&
+	git rev-parse main >>expect &&
+
+	test_cmp expect result
+'
+
+test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
+	git -C bare replay --advance main topic1..topic2 >result-bare &&
+	test_cmp expect result-bare
+'
+
+test_expect_success 'replay on bare repo fails with both --advance and --onto' '
+	test_must_fail git -C bare replay --advance main --onto main topic1..topic2 >result-bare
+'
+
+test_expect_success 'replay fails when both --advance and --onto are omitted' '
+	test_must_fail git replay topic1..topic2 >result
+'
+
 test_done
-- 
2.42.0.126.gcf8c984877

