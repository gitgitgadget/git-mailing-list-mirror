Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C95C4741F
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAAE206E3
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohaR+baj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgKHVhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHVhk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:37:40 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E24C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:37:39 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b8so6752249wrn.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=QtmwmSuGVWIrzPitLxUCZkLQfcVKgF7jxAveQJYokdQ=;
        b=ohaR+bajVHQr4EPKOdLQcMDM0EKPe/+V7ACa7No13FGcSvZqnvN6rsFh44Sue3b53L
         jyzmNJ0S1tWbZGi7cKaZZqFdM2ktExd6lTNoxBGmMQpgPg2y8BNDBc14HeWbFk2q9Lmv
         f/6HByr2aPRA6Y6w0FNKfuQOVBt+dqK+gyVJg3iUrGkVThdYi49tiMwzQkxBWyxhhiAp
         OWFBS09zPauYk3JqHdmtjyK8k94/aTiZ/fyEVKdGWL5o07Tfjk2+V/gieENuOYUMMEX+
         zuQE9xX/62Ss+z/zDcth4tWxvvMfKEBW50M6ym4J7bNHgonquRsWgBd6wHqMPNCe/nH8
         ZnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QtmwmSuGVWIrzPitLxUCZkLQfcVKgF7jxAveQJYokdQ=;
        b=iOpwa3Fk3b0pkciM1CmEgXDnpJtJ9u0p7yrURnoce8w/usvd3zTV+RzHI+i6DU6U1M
         a2Lg5NzfhsBt7RuHo5MPNc8RaIHl0B1h0IaSQ5D49C/kUeFXxxn6e02X449rMu/703Me
         Sj3hCT88v0G+SlK6wG2vonPovx1sOTqHXpnRA57ju+gehYK+OsERNLG2Xxjd5/+TqvSb
         K6MF0PMsETFUzfOpdZjDAJAbo4vjcOsnozjGUQqAk5SPtJ3OW/mssk2Lrs8Cro4L6rMh
         hI8mO+rb+0hNTGLc8+RCAO5eBYyXzvDxZxcbaT2Nw9cM+5ygZO1FQlh7y8uwzqQX0Y6g
         crxw==
X-Gm-Message-State: AOAM5327/FTrqjpAxanIwiS9r0T3fnSGk6xcBb/mgLMaOIlJGb13Ws4d
        oMs8VA2BTJvpUhKKCoQLg1p+5YGpE84=
X-Google-Smtp-Source: ABdhPJyz34VXOUYniH2fXQtVfp6zJtHvGmZXt8W9Foev887heNoAtIPTpCdg62PJrrZSAQEetDJqNw==
X-Received: by 2002:adf:e506:: with SMTP id j6mr5412920wrm.411.1604871458148;
        Sun, 08 Nov 2020 13:37:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g20sm3568213wmh.20.2020.11.08.13.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:37:37 -0800 (PST)
Message-Id: <pull.911.git.git.1604871456715.gitgitgadget@gmail.com>
From:   "Seija K. via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Nov 2020 21:37:36 +0000
Subject: [PATCH] Simplified merge logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pi1024e <pi1024e@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: pi1024e <pi1024e@github.com>

commit: Avoid extraneous boolean checking by simplifying the if statements.
Signed-off-by: Seija <pi1024e@github.com>
---
    Simplified merge logic
    
    The logic for the merging is somewhat confusing. So I simplified it to
    be equivalent. I tested all my changes to ensure in practice they work.
    
    The first thing I did was test out which branch would occur for every
    possible value of 
    
    remoteheads->nextcommon->nextoption_commitBranchTTTATTFATFTATFFAFTTCFTFC
    FFTBFFFAUsing this truth table, I was able to deduce that if the second
    branch ran, the if statement for the first branch was false. Taking the
    inverse, it was then found many of the checks were redundant, so the if
    statement was rewritten to have each branch run under the same exact
    conditions, except each value is evaluated as little as possible.
    
    I hope you can approve of this and show me how to send it.
    
    Thank you.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-911%2Fpi1024e%2Fmerge-cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-911/pi1024e/merge-cleanup-v1
Pull-Request: https://github.com/git/git/pull/911

 builtin/merge.c | 85 ++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 47 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 4c133402a6..9664da6031 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -853,9 +853,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
 			    git_path_merge_msg(the_repository), "merge", NULL))
 		abort_commit(remoteheads, NULL);
-	if (0 < option_edit) {
-		if (launch_editor(git_path_merge_msg(the_repository), NULL, NULL))
-			abort_commit(remoteheads, NULL);
+	if (0 < option_edit && launch_editor(git_path_merge_msg(the_repository), NULL, NULL)) {
+		abort_commit(remoteheads, NULL);
 	}
 
 	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
@@ -1213,7 +1212,7 @@ static int merging_a_throwaway_tag(struct commit *commit)
 	if (!merge_remote_util(commit) ||
 	    !merge_remote_util(commit)->obj ||
 	    merge_remote_util(commit)->obj->type != OBJ_TAG)
-		return is_throwaway_tag;
+		return 0;
 
 	/*
 	 * Now we know we are merging a tag object.  Are we downstream
@@ -1459,13 +1458,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			fast_forward = FF_NO;
 	}
 
-	if (!use_strategies) {
-		if (!remoteheads)
-			; /* already up-to-date */
-		else if (!remoteheads->next)
-			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
-		else
+	if (!use_strategies && remoteheads) {
+		/* not up-to-date */
+		if (remoteheads->next)
 			add_strategies(pull_octopus, DEFAULT_OCTOPUS);
+		else
+			add_strategies(pull_twohead, DEFAULT_TWOHEAD);
 	}
 
 	for (i = 0; i < use_strategies_nr; i++) {
@@ -1475,15 +1473,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
@@ -1542,31 +1540,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
@@ -1592,6 +1566,24 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
@@ -1685,9 +1677,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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

base-commit: 7f7ebe054af6d831b999d6c2241b9227c4e4e08d
-- 
gitgitgadget
