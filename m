Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CB3C76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjDGHZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239888AbjDGHZU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C2AA5FA
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:25:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g5so1663641wrb.5
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F22gc7CMK/IkrjH4+XLPMdpTh5abX8hRPQ02EpYvKw8=;
        b=DItG7t18iazyRmpe0Frej0mNcWerYfAmM4SkHqm0JhYpabWD8bnVOzl8FiOQLavdT0
         dNxi0DQBhjLZJN7C5NDw83Gu1pcWSEPwsbYSszUseV5/jTMgANQkuXKVUjuxalQh/Af1
         JkGC+/lcLvpi+XOGshvLNb5Sr+7zLmzjP2+bQGPnLr1pyXJMCXHrkC7q89BB2OflcPjx
         H6rtt+lb52wlESQ/W5O0UHjayGfVM6kvOfQDczavUciXuWD1eByAxBrp2Osw9wJXq/qY
         QCAuWe3gqXq/8SNnh85hEA1SrjwkFlCKWmm+f36UvH12+zCwRYOfBUN3nLCm3taUO3db
         I2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F22gc7CMK/IkrjH4+XLPMdpTh5abX8hRPQ02EpYvKw8=;
        b=mZteavdBrF8KV8WB/Q9vAIfvxImuMolfvwnhcIwKYLAjmZkrEb6OKM1/LuDWVtRQ8j
         Dm4O1G6Nhe3evrKdloOYDlOuxJ3wz51r53SHSpAdDJzfu4ApEYmTBqGagucxFB0U2oK2
         mnq589xugYEnM42bFUY17fh2Ky/H88/Nu7qB6Mf0LidZyNKA4DaUsFxigX7LM6TWNpXh
         FhFZunjPetq7MYcbL6AdrPdb0I2pv7llcMGV+T1aBw+ChwPO7Nmk+rgA2+0EIYbHsRGd
         MLryH7qrR6zSOhter0OUxZZxh2mUchsupMx61BOsAK7z8+weqR78atAmsQTj/igSnHno
         yT+A==
X-Gm-Message-State: AAQBX9fHJsUguD6KwvdyMxPoZuavx6xoktz1vEdm2PfpC321L3Mj/4DH
        xe59EfDHHdmimk3aMA1rsyOgJD2tiuefew==
X-Google-Smtp-Source: AKy350Y1PDW0UTauQ7DTNQdNFkyOc7YQ5ESlckBFfTGz6EQOUm5GWYSsFlfA8tmT4g6hS4rMIL9nSw==
X-Received: by 2002:a5d:4530:0:b0:2ef:45d2:6ac2 with SMTP id j16-20020a5d4530000000b002ef45d26ac2mr617859wra.27.1680852292192;
        Fri, 07 Apr 2023 00:24:52 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:51 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 13/14] replay: add different modes
Date:   Fri,  7 Apr 2023 09:24:14 +0200
Message-Id: <20230407072415.1360068-14-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There is already a 'rebase' mode with `--onto`. Let's add an 'advance' or
'cherry-pick' mode with `--advance`. This new mode will make the target
branch advance as we replay commits onto it.

While at it, let's also add a `--contained` that can be used along with
`--onto` to rebase all the branches contained in the <revision-range>
argument.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replay.txt |  58 +++++++++--
 builtin/replay.c             | 185 +++++++++++++++++++++++++++++------
 t/t3650-replay-basics.sh     |  45 +++++++++
 3 files changed, 247 insertions(+), 41 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index ce2cafc42e..d714c72188 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -9,7 +9,7 @@ git-replay - Replay commits on a different base, without touching working tree
 SYNOPSIS
 --------
 [verse]
-'git replay' [--onto <newbase>] <revision-range>...
+'git replay' [--contained] [--onto <newbase> | --advance <branch>] <revision-range>...
 
 DESCRIPTION
 -----------
@@ -20,11 +20,12 @@ references.  However, the output of this command is meant to be used
 as input to `git update-ref --stdin`, which would update the relevant
 branches.
 
-When the `--onto <newbase>` option is not passed, the commits will be
-replayed onto a base guessed from the `<revision-range>`.  For example
-if the `<revision-range>` is `origin/main..mybranch` then `mybranch`
-was probably based on an old version of `origin/main`, so we will
-replay it on the newest version of that branch.
+When neither the `--onto <newbase>` option nor the
+`--advance <branch>` option are passed, the commits will be replayed
+onto a base guessed from the `<revision-range>`.  For example if the
+`<revision-range>` is `origin/main..mybranch` then `mybranch` was
+probably based on an old version of `origin/main`, so we will replay
+it on the newest version of that branch.
 
 OPTIONS
 -------
@@ -33,9 +34,17 @@ OPTIONS
 	Starting point at which to create the new commits.  May be any
 	valid commit, and not just an existing branch name.
 +
-The update-ref commands in the output will update the branch(es)
-in the revision range to point at the new commits (in other
-words, this mimics a rebase operation).
+When `--onto` is specified, the update-ref command(s) in the output will
+update the branch(es) in the revision range to point at the new
+commits (in other words, this mimics a rebase operation).
+
+--advance <branch>::
+	Starting point at which to create the new commits; must be a
+	branch name.
++
+When `--advance` is specified, the update-ref command(s) in the output
+will update the branch passed as an argument to `--advance` to point at
+the new commits (in other words, this mimics a cherry-pick operation).
 
 <revision-range>::
 	Range of commits to replay; see "Specifying Ranges" in
@@ -51,7 +60,10 @@ input to `git update-ref --stdin`.  It is basically of the form:
 	update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
 	update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
 
-where the number of refs updated depend on the arguments passed.
+where the number of refs updated depend on the arguments passed.  When
+using `--advance`, the number of refs updated is always one, but for
+`--onto`, it can be one or more (rebasing multiple branches
+simultaneously is supported).
 
 EXIT STATUS
 -----------
@@ -71,6 +83,32 @@ $ git replay --onto target origin/main..mybranch
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
+What if you have a stack of branches, one depending upon another, and
+you'd really like to rebase the whole set?
+
+------------
+$ git replay --contained --onto origin/main origin/main..tipbranch
+update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
+update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
+update refs/heads/tipbranch ${NEW_tipbranch_HASH} ${OLD_tipbranch_HASH}
+------------
+
+In contrast, trying to do this with rebase would require 3 separate
+rebases, eacho of which involves a different <ONTO> and <UPSTREAM> and
+forces you to first check out each branch in turn.
+
 When calling `git replay`, one does not need to specify a range of
 commits to replay using the syntax `A..B`; any range expression will
 do:
diff --git a/builtin/replay.c b/builtin/replay.c
index af948af73c..63b3ad518e 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -12,6 +12,7 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
+#include "strmap.h"
 
 static const char *short_commit_name(struct commit *commit)
 {
@@ -75,10 +76,24 @@ static struct commit *create_commit(struct tree *tree,
 	return (struct commit *)obj;
 }
 
-static struct commit *guess_new_base(struct rev_cmdline_info *info)
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
 {
-	struct commit *new_base = NULL;
-	int i, bottom_commits = 0;
+	int i;
+
+	ref_info->onto = NULL;
+	strset_init(&ref_info->positive_refs);
+	strset_init(&ref_info->negative_refs);
+	ref_info->positive_refexprs = 0;
+	ref_info->negative_refexprs = 0;
 
 	/*
 	 * When the user specifies e.g.
@@ -95,32 +110,110 @@ static struct commit *guess_new_base(struct rev_cmdline_info *info)
 	 * the second because they'd likely just be replaying commits on top
 	 * of the same commit and not making any difference.
 	 */
-	for (i = 0; i < info->nr; i++) {
-		struct rev_cmdline_entry *e = info->rev + i;
+	for (i = 0; i < cmd_info->nr; i++) {
+		struct rev_cmdline_entry *e = cmd_info->rev + i;
 		struct object_id oid;
+		const char *refexpr = e->name;
 		char *fullname = NULL;
+		int can_uniquely_dwim = 1;
+
+		if (*refexpr == '^')
+			refexpr++;
+		if (dwim_ref(refexpr, strlen(refexpr), &oid, &fullname, 0) != 1)
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
 
-		if (!(e->flags & BOTTOM))
-			continue;
+		free(fullname);
+	}
+}
 
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
+		if (dwim_ref(*advance_name, strlen(*advance_name),
+			     &oid, &fullname, 0) == 1) {
+			*advance_name = fullname;
+		} else {
+			die(_("argument to --advance must be a reference"));
+		}
+		if (rinfo.positive_refexprs > 1)
+			die(_("cannot advance target with multiple source branches because ordering would be ill-defined"));
+	} else {
+		int positive_refs_complete = (
+			rinfo.positive_refexprs ==
+			strset_get_size(&rinfo.positive_refs));
+		int negative_refs_complete = (
+			rinfo.negative_refexprs ==
+			strset_get_size(&rinfo.negative_refs));
 		/*
-		 * We need a unique base commit to know where to replay; error
-		 * out if not unique.
-		 *
-		 * Also, we usually don't want to replay commits on the same
-		 * base they started on, so only accept this as the base if
-		 * it uniquely names some ref.
+		 * We need either positive_refs_complete or
+		 * negative_refs_complete, but not both.
 		 */
-		if (bottom_commits++ ||
-		    dwim_ref(e->name, strlen(e->name), &oid, &fullname, 0) != 1)
-			die(_("cannot determine where to replay commits; please specify --onto"));
-
-		free(fullname);
-		new_base = lookup_commit_reference_gently(the_repository,
-							  &e->item->oid, 1);
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
 	}
-
-	return new_base;
+	if (!*advance_name) {
+		*update_refs = xcalloc(1, sizeof(**update_refs));
+		**update_refs = rinfo.positive_refs;
+		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
+	}
+	strset_clear(&rinfo.negative_refs);
+	strset_clear(&rinfo.positive_refs);
 }
 
 static struct commit *pick_regular_commit(struct commit *pickme,
@@ -155,29 +248,41 @@ static struct commit *pick_regular_commit(struct commit *pickme,
 
 int cmd_replay(int argc, const char **argv, const char *prefix)
 {
-	struct commit *onto;
+	const char *advance_name = NULL;
+	struct commit *onto = NULL;
 	const char *onto_name = NULL;
-	struct commit *last_commit = NULL;
+	int contained = 0;
+
 	struct rev_info revs;
+	struct commit *last_commit = NULL;
 	struct commit *commit;
 	struct merge_options merge_opt;
 	struct merge_result result;
+	struct strset *update_refs = NULL;
 	int ret = 0;
 
 	const char * const replay_usage[] = {
-		N_("git replay [--onto <newbase>] <revision-range>..."),
+		N_("git replay [--contained] [--onto <newbase> | --advance <branch>] <revision-range>..."),
 		NULL
 	};
 	struct option replay_options[] = {
+		OPT_STRING(0, "advance", &advance_name,
+			   N_("branch"),
+			   N_("make replay advance given branch")),
 		OPT_STRING(0, "onto", &onto_name,
 			   N_("revision"),
 			   N_("replay onto given commit")),
+		OPT_BOOL(0, "contained", &contained,
+			 N_("advance all branches contained in revision-range")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
 
+	if (advance_name && contained)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--advance", "--contained");
 
 	repo_init_revisions(the_repository, &revs, prefix);
 
@@ -193,10 +298,11 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	revs.topo_order = 1;
 	revs.simplify_history = 0;
 
-	if (onto_name)
-		onto = peel_committish(onto_name);
-	else
-		onto = guess_new_base(&revs.cmdline);
+	determine_replay_mode(&revs.cmdline, onto_name, &advance_name,
+			      &onto, &update_refs);
+
+	if (!onto) /* FIXME: Should handle replaying down to root commit */
+		die("Replaying down to root commit is not supported yet!");
 
 	if (prepare_revision_walk(&revs) < 0) {
 		ret = error(_("error preparing revisions"));
@@ -206,6 +312,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 0;
+
 	result.tree = get_commit_tree(onto);
 	last_commit = onto;
 	while ((commit = get_revision(&revs))) {
@@ -243,12 +350,16 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&commit->object.oid));
 		}
 
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
+			    (contained || strset_contains(update_refs,
+							  decoration->name))) {
 				printf("update %s %s %s\n",
 				       decoration->name,
 				       oid_to_hex(&last_commit->object.oid),
@@ -258,11 +369,23 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
 	/* Cleanup */
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
index f55b71763a..976032ad18 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -60,4 +60,49 @@ test_expect_success 'using replay to rebase two branches, one on top of other' '
 	test_cmp expect result
 '
 
+test_expect_success 'using replay to perform basic cherry-pick' '
+	# The differences between this test and the last one are:
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
+test_expect_success 'using replay to also rebase a contained branch' '
+	git replay --contained --onto main main..topic3 >result &&
+
+	test_line_count = 2 result &&
+	cut -f 3 -d " " result >new-branch-tips &&
+
+	git log --format=%s $(head -n 1 new-branch-tips) >actual &&
+	test_write_lines F C M L B A >expect &&
+	test_cmp expect actual &&
+
+	git log --format=%s $(tail -n 1 new-branch-tips) >actual &&
+	test_write_lines H G F C M L B A >expect &&
+	test_cmp expect actual &&
+
+	printf "update refs/heads/topic1 " >expect &&
+	printf "%s " $(head -n 1 new-branch-tips) >>expect &&
+	git rev-parse topic1 >>expect &&
+	printf "update refs/heads/topic3 " >>expect &&
+	printf "%s " $(tail -n 1 new-branch-tips) >>expect &&
+	git rev-parse topic3 >>expect &&
+
+	test_cmp expect result
+'
+
 test_done
-- 
2.40.0.228.gb2eb5bb98e

