Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322FBC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC47F64F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhBCUEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 15:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhBCUEb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 15:04:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1EAC061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 12:03:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c12so675090wrc.7
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 12:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=gh5Qxw1vhTFzXzAbK6bAxefW8Bl3QNeBsIIT+R7rkNY=;
        b=AGtyJGfoO7OS3Zs6kOtgYpJx4qmON4dcoq1jJZxL4nVODroHbLBEuamGbL0+fuSbY2
         5cwdJL7xcJfrIL9XrBMJF/SnosMwfTNtmgEPZhJHk1cFrN+sqZ6grXMUomm9uA8mjsWB
         1kPL6aT1jev7JHImlZ3RPMxGyop3ocfpkUhWZlZOkQ7TZUNhbH5mk4vHvfPSe1Aq04OD
         T9ibNh18pMzA03zP1cAfb4p3Qc+ioXJ8xvfs64vMjDUElqOt1WFiB27Xf4NWoIa53Bhc
         nA0NEVFmhqC0qPlQESufEgI5mlxYRGhL8Bb/HctPCyXFVG5FlkJk3RJ/VVs+bwhiKWMd
         UdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=gh5Qxw1vhTFzXzAbK6bAxefW8Bl3QNeBsIIT+R7rkNY=;
        b=J+NDJLWYu6SpXrHFJf/dmt2PGLeHEHTt/ZPPGcuzwytTtrM5z9xha26stSX+lFsWXv
         QO+xcyitDk8l4gAMjHP7ZHk3Xm+pmEFb8yNY5aEeewpmxFTVLbTrxTkzGJEj/qm9910X
         PT06GZPeZynHT772URdd6e9FDmQ922S2VO8jYND5tmhPJlTEMTPOZw+Bs55YmSnbZ7dx
         hqPC5WTcZY/gXYTRBv60Z2uZrN+v/yuH5Psc2hV2LmF8Y1rViEWPXnX7qazW762TY3PB
         Ko4/CG4x1OGNJSLvqBPAC6deJdKyaViW4Pwrqz16nXM5FrgTb0yR2FCMVrfPwSnBCbdE
         elwA==
X-Gm-Message-State: AOAM531o0q5BPHYRxPr3jhvWnVAgF2e1REkCSdLkZMgqUC+wD8BqVtK+
        WDbLIokqNVrtkirvKoJ1A25p/0N5wsY=
X-Google-Smtp-Source: ABdhPJxvZP5NVpaGQkK9POign2mPg/+UcmVneyORT0xbm7oor42iF9w75hM/lB7kZja2eEnFxkPdvA==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr5239190wrm.135.1612382629661;
        Wed, 03 Feb 2021 12:03:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7sm5089303wru.49.2021.02.03.12.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 12:03:49 -0800 (PST)
Message-Id: <pull.842.v2.git.1612382628.gitgitgadget@gmail.com>
In-Reply-To: <pull.842.git.1612331345.gitgitgadget@gmail.com>
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 20:03:45 +0000
Subject: [PATCH v2 0/2] Optimization batch 6: make full use of exact renames
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Karsten Blees <blees@dcon.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/merge-ort-perf and makes full use of exact
renames; see commit messages for details.

Thanks to Stolee and Junio for reviewing v1.

Changes since v1:

 * Update rename_src_nr when updating rename_src
 * Introduce want_copies in the first patch and use it in a few more places
 * Move a comment below a few exit-early if-checks.

Elijah Newren (2):
  diffcore-rename: no point trying to find a match better than exact
  diffcore-rename: filter rename_src list when possible

 diffcore-rename.c | 69 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 8 deletions(-)


base-commit: 557ac0350d9efa1f59c708779ca3fb3aee121131
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-842%2Fnewren%2Fort-perf-batch-6-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-842/newren/ort-perf-batch-6-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/842

Range-diff vs v1:

 1:  3e69857f37e ! 1:  770e894b4ab diffcore-rename: no point trying to find a match better than exact
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       	struct diff_score *mx;
       	int i, j, rename_count, skip_unmodified = 0;
       	int num_destinations, dst_cnt;
     -+	int num_sources;
     ++	int num_sources, want_copies;
       	struct progress *progress = NULL;
       
       	trace2_region_enter("diff", "setup", options->repo);
     ++	want_copies = (detect_rename == DIFF_DETECT_COPY);
     + 	if (!minimum_score)
     + 		minimum_score = DEFAULT_RENAME_SCORE;
     + 
     +@@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
     + 				p->one->rename_used++;
     + 			register_rename_src(p);
     + 		}
     +-		else if (detect_rename == DIFF_DETECT_COPY) {
     ++		else if (want_copies) {
     + 			/*
     + 			 * Increment the "rename_used" score by
     + 			 * one, to indicate ourselves as a user.
      @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       	 * files still remain as options for rename/copies!)
       	 */
       	num_destinations = (rename_dst_nr - rename_count);
      +	num_sources = rename_src_nr;
     -+	if (detect_rename != DIFF_DETECT_COPY)
     ++	if (!want_copies)
      +		num_sources -= rename_count;
       
       	/* All done? */
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       			struct diff_filespec *one = rename_src[j].p->one;
       			struct diff_score this_src;
       
     -+			if (one->rename_used &&
     -+			    detect_rename != DIFF_DETECT_COPY)
     ++			if (one->rename_used && !want_copies)
      +				continue;
      +
       			if (skip_unmodified &&
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       	}
       	stop_progress(&progress);
       
     +@@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
     + 	STABLE_QSORT(mx, dst_cnt * NUM_CANDIDATE_PER_DST, score_compare);
     + 
     + 	rename_count += find_renames(mx, dst_cnt, minimum_score, 0);
     +-	if (detect_rename == DIFF_DETECT_COPY)
     ++	if (want_copies)
     + 		rename_count += find_renames(mx, dst_cnt, minimum_score, 1);
     + 	free(mx);
     + 	trace2_region_leave("diff", "inexact renames", options->repo);
 2:  580ba9a10f5 ! 2:  7ae9460d3db diffcore-rename: filter rename_src list when possible
     @@ diffcore-rename.c: static int find_renames(struct diff_score *mx, int dst_cnt, i
       	return count;
       }
       
     -+static int remove_unneeded_paths_from_src(int num_src,
     -+					  int detecting_copies)
     ++static void remove_unneeded_paths_from_src(int detecting_copies)
      +{
      +	int i, new_num_src;
      +
     ++	if (detecting_copies)
     ++		return; /* nothing to remove */
     ++	if (break_idx)
     ++		return; /* culling incompatbile with break detection */
     ++
      +	/*
      +	 * Note on reasons why we cull unneeded sources but not destinations:
      +	 *   1) Pairings are stored in rename_dst (not rename_src), which we
     @@ diffcore-rename.c: static int find_renames(struct diff_score *mx, int dst_cnt, i
      +	 *      sources N times each, so avoid that by removing the sources
      +	 *      from rename_src here.
      +	 */
     -+	if (detecting_copies)
     -+		return num_src; /* nothing to remove */
     -+	if (break_idx)
     -+		return num_src; /* culling incompatbile with break detection */
     -+
     -+	for (i = 0, new_num_src = 0; i < num_src; i++) {
     ++	for (i = 0, new_num_src = 0; i < rename_src_nr; i++) {
      +		/*
      +		 * renames are stored in rename_dst, so if a rename has
      +		 * already been detected using this source, we can just
     @@ diffcore-rename.c: static int find_renames(struct diff_score *mx, int dst_cnt, i
      +		new_num_src++;
      +	}
      +
     -+	return new_num_src;
     ++	rename_src_nr = new_num_src;
      +}
      +
       void diffcore_rename(struct diff_options *options)
       {
       	int detect_rename = options->detect_rename;
     -@@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
     - 	struct diff_score *mx;
     - 	int i, j, rename_count, skip_unmodified = 0;
     - 	int num_destinations, dst_cnt;
     --	int num_sources;
     -+	int num_sources, want_copies;
     - 	struct progress *progress = NULL;
     - 
     - 	trace2_region_enter("diff", "setup", options->repo);
     -+	want_copies = (detect_rename == DIFF_DETECT_COPY);
     - 	if (!minimum_score)
     - 		minimum_score = DEFAULT_RENAME_SCORE;
     - 
      @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       		goto cleanup;
       
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
      +	 * Calculate how many renames are left
       	 */
       	num_destinations = (rename_dst_nr - rename_count);
     --	num_sources = rename_src_nr;
     --	if (detect_rename != DIFF_DETECT_COPY)
     ++	remove_unneeded_paths_from_src(want_copies);
     + 	num_sources = rename_src_nr;
     +-	if (!want_copies)
      -		num_sources -= rename_count;
     -+	num_sources = remove_unneeded_paths_from_src(rename_src_nr, want_copies);
       
       	/* All done? */
       	if (!num_destinations || !num_sources)
      @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
     - 		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)
     - 			m[j].dst = -1;
     - 
     --		for (j = 0; j < rename_src_nr; j++) {
     -+		for (j = 0; j < num_sources; j++) {
       			struct diff_filespec *one = rename_src[j].p->one;
       			struct diff_score this_src;
       
     --			if (one->rename_used &&
     --			    detect_rename != DIFF_DETECT_COPY)
     +-			if (one->rename_used && !want_copies)
      -				continue;
     -+			assert(!one->rename_used ||
     -+			       detect_rename == DIFF_DETECT_COPY ||
     -+			       break_idx);
     ++			assert(!one->rename_used || want_copies || break_idx);
       
       			if (skip_unmodified &&
       			    diff_unmodified_pair(rename_src[j].p))

-- 
gitgitgadget
