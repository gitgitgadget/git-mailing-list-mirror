Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0145C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F086207BC
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsjrkLe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgKQVyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKQVyg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:54:36 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ACBC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:54:35 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so24925972wrb.9
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yvCTBGw9wvdACIcCZpO/GFyuBzP4hnkbto17msPpi5k=;
        b=RsjrkLe8VRh4CNvLRksQgVjBZ0Kbk2xlKogE281PZ7JvB4ED4Oy3ckbtWWUBvjyMDl
         dH2JFt78kc9JUniNvg54/Zj+o4tnVm9XxJCLm6ZQ67xZ6PjuRh+uTwAVWpgcXyhlQAnY
         JdAZR2J/s0AI+wKw82p26dhM0wIEoGACo5BIAtxHFynQVC/6WvNp5yNJdL1ko4Jpslur
         Zc/RRMAVy6/hX1w4kNGPuxnhJm/Fwq1oHpitjdereZsMMaFahsH8cbBDTfl7n/VW+TOn
         L/6+ao+jArH+Qn1iE1OHAO6fQZII/VW1D8Dww9GlmxY/8kMCCpAiEtfVT2bFMbrabvgu
         AEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yvCTBGw9wvdACIcCZpO/GFyuBzP4hnkbto17msPpi5k=;
        b=nz+GTgTConamkOBfmEONyRIS4sJ1UwCejtP16/PL3jVyEtkopZfhJBx6ApttVZ8YfQ
         y1/DKMbqZ97z4KLe/dafeZkUZmWxyF5hYfqUqj1QQ2y5Ll9xYbkQao8gwzwr8gOSIZ+E
         tG/yp+DAxapfZp6A9EHLklA4QEsZ8rGVgXyEuJ4gCaYeDY+DhyJwsc2ouleVaaPPwgtj
         4a9x7+5VHcwnIE/KwLF4qzT/rN21/DydJs7yDzuTKw0YTTlICiJwC4TWQIEC/nnIptxF
         0oiMVvNs8D2IaRknLo4cTnsKPJ/gcMg0Mg9F9rsrfu67ytVZbos0Z5u5/8uF/J6FqnNm
         zUpg==
X-Gm-Message-State: AOAM530IIibapvIlShj8yoAimH88SdxK9jSJx4DTNyoJuG+ha8GpoWkZ
        taZL6VXZc0hBafTrt8fBDk9mG7gDRJE=
X-Google-Smtp-Source: ABdhPJzMRLaxVkjT9UMkPgFxDm6VI3BOoWBCtga8k3ci0OXUrc5GGjj57DvLivLUHbjXYHt4QLZQNQ==
X-Received: by 2002:a5d:6550:: with SMTP id z16mr1587882wrv.266.1605650074032;
        Tue, 17 Nov 2020 13:54:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm25628704wrw.4.2020.11.17.13.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:54:33 -0800 (PST)
Message-Id: <pull.911.v2.git.git.1605650072908.gitgitgadget@gmail.com>
In-Reply-To: <pull.911.git.git.1604871456715.gitgitgadget@gmail.com>
References: <pull.911.git.git.1604871456715.gitgitgadget@gmail.com>
From:   "Seija K. via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 21:54:32 +0000
Subject: [PATCH v2] Simplify merge logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Seija K <pi1024e@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija K <pi1024e@github.com>

commit: Avoid extraneous boolean checking by simplifying the if statements.
This is so that the code can be clearer and avoid duplicate boolean checks.

Changes since v1: Undid if statement combos as suggested by Junio C Hamano.

The current logic for the merging is somewhat confusing.
So I simplified said logic to be equivalent, but simpler.
I tested all my changes to ensure in practice they work as well.

First, I tested out which branch would occur for every possible value below:

remoteheads->next | common->next | option_commit | Branch
-- | -- | -- | --
T | T | T | A
T | T | F | A
T | F | T | A
T | F | F | A
F | T | T | C
F | T | F | C
F | F | T | B
F | F | F | A

Then, using this truth table, I was able to deduce that if the second branch ran,
the if statement for the first branch would be false.

Then, taking the inverse, I found that many of the checks were redundant,
so I rewrote the if statements to have each branch run under the same exact conditions,
except each value is evaluated as little as possible.

I hope you find value in these changes.

Thank you!

Signed-off-by: Seija K. <pi1024e@github.com>
---
    Simplify merge logic
    
    This is so that the code can be clearer and avoid duplicate boolean
    checks.
    
    Changes since v1: Undid if statement combos as suggested by Junio C
    Hamano.
    
    The current logic for the merging is somewhat confusing. So I simplified
    said logic to be equivalent, but simpler. I tested all my changes to
    ensure in practice they work as well.
    
    First, I tested out which branch would occur for every possible value
    below:
    
    remoteheads->nextcommon->nextoption_commitBranchTTTATTFATFTATFFAFTTCFTFC
    FFTBFFFAThen, using this truth table, I was able to deduce that if the
    second branch ran, the if statement for the first branch would be false.
    
    Then, taking the inverse, I found that many of the checks were
    redundant, so I rewrote the if statements to have each branch run under
    the same exact conditions, except each value is evaluated as little as
    possible.
    
    I hope you find value in these changes.
    
    Thank you!
    
    Signed-off-by: Seija K. pi1024e@github.com [pi1024e@github.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-911%2Fpi1024e%2Fmerge-cleanup-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-911/pi1024e/merge-cleanup-v2
Pull-Request: https://github.com/git/git/pull/911

Range-diff vs v1:

 1:  9b333c9872 ! 1:  dd1c4dd678 Simplified merge logic
     @@
       ## Metadata ##
     -Author: pi1024e <pi1024e@github.com>
     +Author: Seija K <pi1024e@github.com>
      
       ## Commit message ##
     -    Simplified merge logic
     +    Simplify merge logic
      
          commit: Avoid extraneous boolean checking by simplifying the if statements.
     -    Signed-off-by: Seija <pi1024e@github.com>
     +    This is so that the code can be clearer and avoid duplicate boolean checks.
     +
     +    Changes since v1: Undid if statement combos as suggested by Junio C Hamano.
     +
     +    The current logic for the merging is somewhat confusing.
     +    So I simplified said logic to be equivalent, but simpler.
     +    I tested all my changes to ensure in practice they work as well.
     +
     +    First, I tested out which branch would occur for every possible value below:
     +
     +    remoteheads->next | common->next | option_commit | Branch
     +    -- | -- | -- | --
     +    T | T | T | A
     +    T | T | F | A
     +    T | F | T | A
     +    T | F | F | A
     +    F | T | T | C
     +    F | T | F | C
     +    F | F | T | B
     +    F | F | F | A
     +
     +    Then, using this truth table, I was able to deduce that if the second branch ran,
     +    the if statement for the first branch would be false.
     +
     +    Then, taking the inverse, I found that many of the checks were redundant,
     +    so I rewrote the if statements to have each branch run under the same exact conditions,
     +    except each value is evaluated as little as possible.
     +
     +    I hope you find value in these changes.
     +
     +    Thank you!
     +
     +    Signed-off-by: Seija K. <pi1024e@github.com>
      
       ## builtin/merge.c ##
     -@@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
     - 	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
     - 			    git_path_merge_msg(the_repository), "merge", NULL))
     - 		abort_commit(remoteheads, NULL);
     --	if (0 < option_edit) {
     --		if (launch_editor(git_path_merge_msg(the_repository), NULL, NULL))
     --			abort_commit(remoteheads, NULL);
     -+	if (0 < option_edit && launch_editor(git_path_merge_msg(the_repository), NULL, NULL)) {
     -+		abort_commit(remoteheads, NULL);
     - 	}
     - 
     - 	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
      @@ builtin/merge.c: static int merging_a_throwaway_tag(struct commit *commit)
       	if (!merge_remote_util(commit) ||
       	    !merge_remote_util(commit)->obj ||
     @@ builtin/merge.c: static int merging_a_throwaway_tag(struct commit *commit)
       	/*
       	 * Now we know we are merging a tag object.  Are we downstream
      @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
     - 			fast_forward = FF_NO;
       	}
       
     --	if (!use_strategies) {
     + 	if (!use_strategies) {
      -		if (!remoteheads)
      -			; /* already up-to-date */
      -		else if (!remoteheads->next)
      -			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
      -		else
     -+	if (!use_strategies && remoteheads) {
     -+		/* not up-to-date */
     -+		if (remoteheads->next)
     - 			add_strategies(pull_octopus, DEFAULT_OCTOPUS);
     -+		else
     -+			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
     +-			add_strategies(pull_octopus, DEFAULT_OCTOPUS);
     ++		if (remoteheads) {
     ++			/* not up-to-date */
     ++			if (remoteheads->next)
     ++				add_strategies(pull_octopus, DEFAULT_OCTOPUS);
     ++			else
     ++				add_strategies(pull_twohead, DEFAULT_TWOHEAD);
     ++		}
       	}
       
       	for (i = 0; i < use_strategies_nr; i++) {


 builtin/merge.c | 82 +++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 4c133402a6..148d08f8db 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1213,7 +1213,7 @@ static int merging_a_throwaway_tag(struct commit *commit)
 	if (!merge_remote_util(commit) ||
 	    !merge_remote_util(commit)->obj ||
 	    merge_remote_util(commit)->obj->type != OBJ_TAG)
-		return is_throwaway_tag;
+		return 0;
 
 	/*
 	 * Now we know we are merging a tag object.  Are we downstream
@@ -1460,12 +1460,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!use_strategies) {
-		if (!remoteheads)
-			; /* already up-to-date */
-		else if (!remoteheads->next)
-			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
-		else
-			add_strategies(pull_octopus, DEFAULT_OCTOPUS);
+		if (remoteheads) {
+			/* not up-to-date */
+			if (remoteheads->next)
+				add_strategies(pull_octopus, DEFAULT_OCTOPUS);
+			else
+				add_strategies(pull_twohead, DEFAULT_TWOHEAD);
+		}
 	}
 
 	for (i = 0; i < use_strategies_nr; i++) {
@@ -1475,15 +1476,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			allow_trivial = 0;
 	}
 
-	if (!remoteheads)
-		; /* already up-to-date */
-	else if (!remoteheads->next)
-		common = get_merge_bases(head_commit, remoteheads->item);
-	else {
-		struct commit_list *list = remoteheads;
-		commit_list_insert(head_commit, &list);
-		common = get_octopus_merge_bases(list);
-		free(list);
+	if (remoteheads) {
+		/* not up-to-date */
+		if (remoteheads->next) {
+			struct commit_list *list = remoteheads;
+			commit_list_insert(head_commit, &list);
+			common = get_octopus_merge_bases(list);
+			free(list);
+		} else
+			common = get_merge_bases(head_commit, remoteheads->item);
 	}
 
 	update_ref("updating ORIG_HEAD", "ORIG_HEAD",
@@ -1542,31 +1543,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		finish(head_commit, remoteheads, &commit->object.oid, msg.buf);
 		remove_merge_branch_state(the_repository);
 		goto done;
-	} else if (!remoteheads->next && common->next)
-		;
-		/*
-		 * We are not doing octopus and not fast-forward.  Need
-		 * a real merge.
-		 */
-	else if (!remoteheads->next && !common->next && option_commit) {
-		/*
-		 * We are not doing octopus, not fast-forward, and have
-		 * only one common.
-		 */
-		refresh_cache(REFRESH_QUIET);
-		if (allow_trivial && fast_forward != FF_ONLY) {
-			/* See if it is really trivial. */
-			git_committer_info(IDENT_STRICT);
-			printf(_("Trying really trivial in-index merge...\n"));
-			if (!read_tree_trivial(&common->item->object.oid,
-					       &head_commit->object.oid,
-					       &remoteheads->item->object.oid)) {
-				ret = merge_trivial(head_commit, remoteheads);
-				goto done;
-			}
-			printf(_("Nope.\n"));
-		}
-	} else {
+	} else if (remoteheads->next || (!common->next && !option_commit)) {
 		/*
 		 * An octopus.  If we can reach all the remote we are up
 		 * to date.
@@ -1592,6 +1569,24 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			finish_up_to_date(_("Already up to date. Yeeah!"));
 			goto done;
 		}
+	} else if (!common->next) {
+		/*
+		 * We are not doing octopus, not fast-forward, and have
+		 * only one common.
+		 */
+		refresh_cache(REFRESH_QUIET);
+		if (allow_trivial && fast_forward != FF_ONLY) {
+			/* See if it is really trivial. */
+			git_committer_info(IDENT_STRICT);
+			printf(_("Trying really trivial in-index merge...\n"));
+			if (!read_tree_trivial(&common->item->object.oid,
+					       &head_commit->object.oid,
+					       &remoteheads->item->object.oid)) {
+				ret = merge_trivial(head_commit, remoteheads);
+				goto done;
+			}
+			printf(_("Nope.\n"));
+		}
 	}
 
 	if (fast_forward == FF_ONLY)
@@ -1685,9 +1680,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				use_strategies[0]->name);
 		ret = 2;
 		goto done;
-	} else if (best_strategy == wt_strategy)
-		; /* We already have its result in the working tree. */
-	else {
+	} else if (best_strategy != wt_strategy) {
+		/* We do not have its result in the working tree. */
 		printf(_("Rewinding the tree to pristine...\n"));
 		restore_state(&head_commit->object.oid, &stash);
 		printf(_("Using the %s to prepare resolving by hand.\n"),

base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
-- 
gitgitgadget
