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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41519C63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6DE2417E
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 22:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXG/mXj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgKQWGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgKQWGI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 17:06:08 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFF5C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 14:06:08 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h2so154435wmm.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 14:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EAtIGwsGsYljBhnllBEX5fyu+82GiA7p779t7OI41iM=;
        b=cXG/mXj2h/B3RP/97FcOEuGn0IRcVbiHE4Be+h953I0T4j96aMkR2TpAhF+xoXwZ2G
         ArokzFLdIBQXIoHrVDx/hqlyU6yprYdxVCewmYY9emP7dtj8JfsVO+4BZI4gqARqSWGd
         zZAT+/zqKswxtYKDb2WbfTVYsk6XD+2Tt9MIOZ9v7sC08qTHGMDP59fJLAVvTOa+dM7C
         nACOvXFNDmZ7etqMvVAHpTvMEBX6GuqP1vpnXWPoqoyGxQokYka0CwHJy2z4DZJbf0rU
         0xeOGDINPF7p6fqn/oX3Q8WCYqggtt7u9BHWwE8heR0xU9pbPeV2nJ9Q7g692h2iakXG
         5MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EAtIGwsGsYljBhnllBEX5fyu+82GiA7p779t7OI41iM=;
        b=TM+XYcx0HLg060Tj6BK+yWpDLuOFlzAp6cnNhp1NXykv8HP0MiYXq39thsbQlKwYag
         nGKl5NXItVph/p4HQvKstP/rJ2Wf2fpuKpXhszoA5DurCOsnhXxZEG34e4S2TIZ+zUCQ
         1TcHUVozixg4xGJKPwmH41LZL7sq0lu326XNFc1AJ6B64lHPtBnRoo7rq+4lJtYC4G2P
         YTmVmwNu/UPZWNOre9/tGnJB16Kl7ifI9hJ49IpPy4BRawO5hYaC7lFf3CAwO0DSM4Uq
         hhg4kEPdmd8eNnkhooG+AbQFaa9CLvsqV8uktiAX6lGMdasxv9ExVg7ylMZjZGamM4CH
         OtRA==
X-Gm-Message-State: AOAM531Vms9TL8THEUV3OWPkfPAswvi+l21rcHFW6c2LJl1kSG/96jcv
        1X9izCVH9ggElS0CV43lT9leuPtKcbg=
X-Google-Smtp-Source: ABdhPJxaTQDU1/2smksHQZpWI2qR9s4EBqDKvbEtq4AK7zUwMzyowxf1NwbLStb+HGJC7lG1p6c99Q==
X-Received: by 2002:a1c:b104:: with SMTP id a4mr1101583wmf.138.1605650763022;
        Tue, 17 Nov 2020 14:06:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t74sm175150wmt.8.2020.11.17.14.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 14:06:02 -0800 (PST)
Message-Id: <pull.911.v3.git.git.1605650762205.gitgitgadget@gmail.com>
In-Reply-To: <pull.911.v2.git.git.1605650072908.gitgitgadget@gmail.com>
References: <pull.911.v2.git.git.1605650072908.gitgitgadget@gmail.com>
From:   "Seija K. via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 22:06:01 +0000
Subject: [PATCH v3] Simplify merge logic
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
This is so that the code can be clearer and we can avoid duplicate checks.

Changes since v1: Undid if statement combos as suggested by Junio C Hamano.

Currently, the logic for merging is somewhat confusing.
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
    
    commit: Avoid extraneous boolean checking by simplifying the if
    statements. This is so that the code can be clearer and we can avoid
    duplicate checks.
    
    Changes since v1: Undid if statement combos as suggested by Junio C
    Hamano.
    
    Currently, the logic for merging is somewhat confusing. So I simplified
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-911%2Fpi1024e%2Fmerge-cleanup-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-911/pi1024e/merge-cleanup-v3
Pull-Request: https://github.com/git/git/pull/911

Range-diff vs v2:

 1:  dd1c4dd678 ! 1:  92e0b7ec32 Simplify merge logic
     @@ Commit message
          Simplify merge logic
      
          commit: Avoid extraneous boolean checking by simplifying the if statements.
     -    This is so that the code can be clearer and avoid duplicate boolean checks.
     +    This is so that the code can be clearer and we can avoid duplicate checks.
      
          Changes since v1: Undid if statement combos as suggested by Junio C Hamano.
      
     -    The current logic for the merging is somewhat confusing.
     +    Currently, the logic for merging is somewhat confusing.
          So I simplified said logic to be equivalent, but simpler.
          I tested all my changes to ensure in practice they work as well.
      


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
