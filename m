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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ADFC2BB48
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AAD522B2C
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440253AbgLNQWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440249AbgLNQWY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:22:24 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088A0C0613D3
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d26so3798918wrb.12
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4ZgmnIAxxFe/zz7tBB7sJd3LLx/SGlF0zE2Cu9nqR80=;
        b=ISpfKvCk1RoCATs8SCQyGYjBC0hati2Q/L3vmynvC7uF0Ikwn24YP/PfJBhVlWYpHR
         fhqaTd6tZIUYW/Aq0JgpvhWNNZ4JJoSYc79lOZyhBoGu3Rx5GocOlQNeX1be3Wtw5glN
         poBA9z6Zg8mCdgHpavP2+Y0WuRNuXQZZotPr88ywOiFknxpRGs6vgClHpP/2EuxOWi4g
         O+EFkMIqY9McAiEwYKv1O+ejpvL3BGMGka1FZ329YWdSnfQimwcTCqUNvRNECEFBBF7e
         1dZ8JrS1bnAw/8mxOMk7pc+xmatbI0i+KyN8coLlF+QcjnIde8i7TfjNB9J+TeSqrUMx
         5QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4ZgmnIAxxFe/zz7tBB7sJd3LLx/SGlF0zE2Cu9nqR80=;
        b=BivaIDP1GFri8vYxddpZXt9TdTXr+SJcAR+HJMKegwF7b4FRbBlrNapn/UhTg8FMxy
         qvZI8vTI5RXzl9uLX9kxVlAreHDzJaSOLCbvi27A6x11ivFi58xbW2cXtFjsm8VmITOY
         uPILfDugD537w2KhixI7iyylbrF9a3Pvrk/+fEgjbQB1liyef4/qF57QMpCbcpu9HKcy
         l/sQld5TthWzUtiqEvNddQiGtGQqIW6FSS/W8E4f6zkg8YXhbNuCQ4IuoDmZlQiu3SZ0
         MHDTcWMBal4BGlOsnsqyHPekEHnpQk1HnzAEKCFAOaJdEjmx6s9DmOumbBGOtV2J/iH3
         vb0g==
X-Gm-Message-State: AOAM533Rc63C/e/gATUGqWD7DzEIAlLcyWqikenpYkedpVZuTm1t+hX2
        QWoLCOQ083EUMXD0MD94I+evaYL2HmQ=
X-Google-Smtp-Source: ABdhPJzh7DgXLiYM5wGvAo3opwKXSgMB9qkrNqNS3NMK3qp+nFupcamNUoNMMTfmfCIt7KhV/ohwjA==
X-Received: by 2002:a5d:4242:: with SMTP id s2mr29907842wrr.187.1607962902159;
        Mon, 14 Dec 2020 08:21:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16sm34678728wrx.36.2020.12.14.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:21:41 -0800 (PST)
Message-Id: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.git.1607542887.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Dec 2020 16:21:29 +0000
Subject: [PATCH v2 00/11] merge-ort: add basic rename detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series builds on en/merge-ort-2 and adds basic rename detection to
merge-ort.

Changes since v1 (all due to feedback from Stolee's reviews):

 * embedded struct rename_info directly in struct merge_options_internal (no
   longer a pointer)
 * expanded use of new enum merge_side and its new MERGE_BASE, MERGE_SIDE1,
   MERGE_SIDE2 constants
 * removed unnecessary secondary sort in compare_pairs()
 * improved commit messages
 * document p->score reuse with better comment(s)
 * space around operators

Elijah Newren (11):
  merge-ort: add basic data structures for handling renames
  merge-ort: add initial outline for basic rename detection
  merge-ort: implement detect_regular_renames()
  merge-ort: implement compare_pairs() and collect_renames()
  merge-ort: add basic outline for process_renames()
  merge-ort: add implementation of both sides renaming identically
  merge-ort: add implementation of both sides renaming differently
  merge-ort: add implementation of rename collisions
  merge-ort: add implementation of rename/delete conflicts
  merge-ort: add implementation of normal rename handling
  merge-ort: add implementation of type-changed rename handling

 merge-ort.c | 445 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 429 insertions(+), 16 deletions(-)


base-commit: c5a6f65527aa3b6f5d7cf25437a88d8727ab0646
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-812%2Fnewren%2Fort-renames-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-812/newren/ort-renames-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/812

Range-diff vs v1:

  1:  ef8f315f828 !  1:  78621ca0788 merge-ort: add basic data structures for handling renames
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
     -@@
     - #include "unpack-trees.h"
     - #include "xdiff-interface.h"
     +@@ merge-ort.c: enum merge_side {
     + 	MERGE_SIDE2 = 2
     + };
       
      +struct rename_info {
      +	/*
     @@ merge-ort.c: struct merge_options_internal {
      +	/*
      +	 * renames: various data relating to rename detection
      +	 */
     -+	struct rename_info *renames;
     ++	struct rename_info renames;
      +
       	/*
       	 * current_dir_name: temporary var used in collect_merge_info_callback()
       	 *
     -@@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_result *result)
     - 
     - 	/* Initialization of opt->priv, our internal merge data */
     - 	opt->priv = xcalloc(1, sizeof(*opt->priv));
     -+	opt->priv->renames = xcalloc(1, sizeof(*opt->priv->renames));
     - 
     - 	/*
     - 	 * Although we initialize opt->priv->paths with strdup_strings=0,
  2:  b9e0e1a60b9 !  2:  d846decf40b merge-ort: add initial outline for basic rename detection
     @@ merge-ort.c: static int handle_content_merge(struct merge_options *opt,
       {
      -	int clean = 1;
      +	struct diff_queue_struct combined;
     -+	struct rename_info *renames = opt->priv->renames;
     ++	struct rename_info *renames = &opt->priv->renames;
      +	int s, clean = 1;
      +
      +	memset(&combined, 0, sizeof(combined));
      +
     -+	detect_regular_renames(opt, merge_base, side1, 1);
     -+	detect_regular_renames(opt, merge_base, side2, 2);
     ++	detect_regular_renames(opt, merge_base, side1, MERGE_SIDE1);
     ++	detect_regular_renames(opt, merge_base, side2, MERGE_SIDE2);
      +
      +	ALLOC_GROW(combined.queue,
      +		   renames->pairs[1].nr + renames->pairs[2].nr,
      +		   combined.alloc);
     -+	clean &= collect_renames(opt, &combined, 1);
     -+	clean &= collect_renames(opt, &combined, 2);
     ++	clean &= collect_renames(opt, &combined, MERGE_SIDE1);
     ++	clean &= collect_renames(opt, &combined, MERGE_SIDE2);
      +	QSORT(combined.queue, combined.nr, compare_pairs);
      +
      +	clean &= process_renames(opt, &combined);
      +
      +	/* Free memory for renames->pairs[] and combined */
     -+	for (s = 1; s <= 2; s++) {
     ++	for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++) {
      +		free(renames->pairs[s].queue);
      +		DIFF_QUEUE_CLEAR(&renames->pairs[s]);
      +	}
  3:  ba30bc8686e !  3:  620fc64032d merge-ort: implement detect_regular_renames()
     @@ Metadata
       ## Commit message ##
          merge-ort: implement detect_regular_renames()
      
     -    Based heavily on merge-recursive's get_diffpairs() function.
     +    Based heavily on merge-recursive's get_diffpairs() function, and also
     +    includes the necessary paired call to diff_warn_rename_limit() so that
     +    users will be warned if merge.renameLimit is not sufficiently large for
     +    rename detection to run.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ merge-ort.c: static void detect_regular_renames(struct merge_options *opt,
       {
      -	die("Not yet implemented.");
      +	struct diff_options diff_opts;
     -+	struct rename_info *renames = opt->priv->renames;
     ++	struct rename_info *renames = &opt->priv->renames;
      +
      +	repo_diff_setup(opt->repo, &diff_opts);
      +	diff_opts.flags.recursive = 1;
     @@ merge-ort.c: static void detect_regular_renames(struct merge_options *opt,
      +		      &diff_opts);
      +	diffcore_std(&diff_opts);
      +
     -+	if (diff_opts.needed_rename_limit > opt->priv->renames->needed_limit)
     -+		opt->priv->renames->needed_limit = diff_opts.needed_rename_limit;
     ++	if (diff_opts.needed_rename_limit > renames->needed_limit)
     ++		renames->needed_limit = diff_opts.needed_rename_limit;
      +
      +	renames->pairs[side_index] = diff_queued_diff;
      +
     @@ merge-ort.c: void merge_switch_to_result(struct merge_options *opt,
      +
      +		/* Also include needed rename limit adjustment now */
      +		diff_warn_rename_limit("merge.renamelimit",
     -+				       opti->renames->needed_limit, 0);
     ++				       opti->renames.needed_limit, 0);
       	}
       
       	merge_finalize(opt, result);
  4:  207bb9a837c !  4:  9382dc4d50b merge-ort: implement compare_pairs() and collect_renames()
     @@ merge-ort.c: static int process_renames(struct merge_options *opt,
      +	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
      +	const struct diff_filepair *b = *((const struct diff_filepair **)b_);
      +
     -+	int cmp = strcmp(a->one->path, b->one->path);
     -+	if (cmp)
     -+		return cmp;
     -+	return a->score - b->score;
     ++	return strcmp(a->one->path, b->one->path);
       }
       
       /* Call diffcore_rename() to compute which files have changed on given side */
     @@ merge-ort.c: static int collect_renames(struct merge_options *opt,
      -	die("Not yet implemented.");
      +	int i, clean = 1;
      +	struct diff_queue_struct *side_pairs;
     -+	struct rename_info *renames = opt->priv->renames;
     ++	struct rename_info *renames = &opt->priv->renames;
      +
      +	side_pairs = &renames->pairs[side_index];
      +
     @@ merge-ort.c: static int collect_renames(struct merge_options *opt,
      +			diff_free_filepair(p);
      +			continue;
      +		}
     ++
     ++		/*
     ++		 * p->score comes back from diffcore_rename_extended() with
     ++		 * the similarity of the renamed file.  The similarity is
     ++		 * was used to determine that the two files were related
     ++		 * and are a rename, which we have already used, but beyond
     ++		 * that we have no use for the similarity.  So p->score is
     ++		 * now irrelevant.  However, process_renames() will need to
     ++		 * know which side of the merge this rename was associated
     ++		 * with, so overwrite p->score with that value.
     ++		 */
      +		p->score = side_index;
      +		result->queue[result->nr++] = p;
      +	}
  5:  35b070b9b7c !  5:  d20fab8d403 merge-ort: add basic outline for process_renames()
     @@ merge-ort.c: static int handle_content_merge(struct merge_options *opt,
      +		 * diff_filepairs have copies of pathnames, thus we have to
      +		 * use standard 'strcmp()' (negated) instead of '=='.
      +		 */
     -+		if (i+1 < renames->nr &&
     ++		if (i + 1 < renames->nr &&
      +		    !strcmp(oldpath, renames->queue[i+1]->one->path)) {
      +			/* Handle rename/rename(1to2) or rename/rename(1to1) */
      +			const char *pathnames[3];
     @@ merge-ort.c: static int handle_content_merge(struct merge_options *opt,
      +
      +		VERIFY_CI(oldinfo);
      +		VERIFY_CI(newinfo);
     -+		target_index = pair->score; /* from append_rename_pairs() */
     ++		target_index = pair->score; /* from collect_renames() */
      +		assert(target_index == 1 || target_index == 2);
     -+		other_source_index = 3-target_index;
     ++		other_source_index = 3 - target_index;
      +		old_sidemask = (1 << other_source_index); /* 2 or 4 */
      +		source_deleted = (oldinfo->filemask == 1);
      +		collision = ((newinfo->filemask & old_sidemask) != 0);
  6:  9c79b9f4a09 !  6:  15fff3dd0c4 merge-ort: add implementation of both sides renaming identically
     @@ merge-ort.c: static int process_renames(struct merge_options *opt,
      +				assert(side1 == side2);
      +				memcpy(&side1->stages[0], &base->stages[0],
      +				       sizeof(merged));
     -+				side1->filemask |= (1 << 0);
     ++				side1->filemask |= (1 << MERGE_BASE);
      +				/* Mark base as resolved by removal */
      +				base->merged.is_null = 1;
      +				base->merged.clean = 1;
  7:  d4595397052 !  7:  d00e26be784 merge-ort: add implementation of both sides renaming differently
     @@ merge-ort.c: static int process_renames(struct merge_options *opt,
      +							   &merged);
      +			if (!clean_merge &&
      +			    merged.mode == side1->stages[1].mode &&
     -+			    oideq(&merged.oid, &side1->stages[1].oid)) {
     ++			    oideq(&merged.oid, &side1->stages[1].oid))
      +				was_binary_blob = 1;
     -+			}
      +			memcpy(&side1->stages[1], &merged, sizeof(merged));
      +			if (was_binary_blob) {
      +				/*
  8:  ab15f85f698 =  8:  edd610321a0 merge-ort: add implementation of rename collisions
  9:  c069d34b15f !  9:  f017534243c merge-ort: add implementation of rename/delete conflicts
     @@ merge-ort.c: static int process_renames(struct merge_options *opt,
      +			 */
      +			memcpy(&newinfo->stages[0], &oldinfo->stages[0],
      +			       sizeof(newinfo->stages[0]));
     -+			newinfo->filemask |= (1 << 0);
     ++			newinfo->filemask |= (1 << MERGE_BASE);
      +			newinfo->pathnames[0] = oldpath;
       			if (type_changed) {
       				/* rename vs. typechange */
 10:  14baa5874af = 10:  22cb7110261 merge-ort: add implementation of normal rename handling
 11:  476553e2b20 = 11:  ff09ddb9caf merge-ort: add implementation of type-changed rename handling

-- 
gitgitgadget
