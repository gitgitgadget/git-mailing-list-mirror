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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1185AC43461
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16E6611CD
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhEDCNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 22:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhEDCNW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 22:13:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBBAC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 19:12:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l2so7576819wrm.9
        for <git@vger.kernel.org>; Mon, 03 May 2021 19:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VOu8FCKXmIIrUMbvuOjzcUv6+GzE8vjNh+KiKPLNun0=;
        b=vaBxRHy1LSamdAlQVSFpN1SfEr9BWssyGSs59al2h4YOwTYrAjULii6aihi7vLnLCp
         JJqvkIqJlNpNXD4TiNIfi9ECBIGdZJikKGegRP1aynR6pFZmILQ2//FNXs+NPqTsYT+W
         tTMr3elQeJtSrRrkpnQHmVd5CgvpUr5JAahoygB6JasJIiTlBAjaezs1XE44f8NFKd8t
         uerLX7PGYMJJ5h3nBCA3qgBIgOtzTTYtWsjpWqhgEtZPRTywwe3wQQlPpVUX/I+z/u8k
         DlGoONvKVhUIvuOiPLPNa2x5uyNqcV5dwWnAPfufqEnw6y23siBpEqS6vyoIC6jKkIuT
         nYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VOu8FCKXmIIrUMbvuOjzcUv6+GzE8vjNh+KiKPLNun0=;
        b=P3qB4VbqGdbzg3HmQi2g0+2RQeCsOl7uNyBrkirfMlGu+IOACuEf7Dlkub8Uw/SEfW
         oMOGsD5c1LPaBjdsG7OcJ/kEe8mUGLFZFMmtWDmBEuzroRmT+eFoYO/Vsj74nT2hW4vl
         3vLZFkOAHvFO7g4LNX+C1eBMPuFuLCuu+dPBBh9WQMdCy9eRAD4kTg0UaRHMFSV3aJlL
         5oDSRm4QgA7pXb5PoUOphuZ8FEds+eV3H+cmFBAKnrQHMUtw31SMEu9VGj10Y0cMhDbL
         rFMOdyaOo7xCbWJvfGc+Pw/kwKLYh1Q+Xb9BRA1B7JHGX6z/MjkfRys9CiUbXCLvBP50
         7J/Q==
X-Gm-Message-State: AOAM532/LuuCPzgF2wB62yJGFAG2h6G+3OHoNNLG4pH+Xwn3fWJEPYrn
        IVfwkvMHOQrovddCGCakSw6HVyncJG4=
X-Google-Smtp-Source: ABdhPJzetg1DpRrrfk7cJIYNomrDAnwEOHQGTaaQAIZqi9DSJDgB1hatIRnDOknqyCv7af2t3hRerg==
X-Received: by 2002:adf:d22c:: with SMTP id k12mr29045526wrh.25.1620094347276;
        Mon, 03 May 2021 19:12:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm15119918wrt.82.2021.05.03.19.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 19:12:26 -0700 (PDT)
Message-Id: <02d517f052a35a952c726e7e941650ce424abb85.1620094339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
        <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 02:12:13 +0000
Subject: [PATCH v2 07/13] merge-ort: populate caches of rename detection
 results
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

Fill in cache_pairs, cached_target_names, and cached_irrelevant based on
rename detection results.  Future commits will make use of these values.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8602f88a960c..5523fc9e86b3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2333,6 +2333,65 @@ static void resolve_diffpair_statuses(struct diff_queue_struct *q)
 	}
 }
 
+static void possibly_cache_new_pair(struct rename_info *renames,
+				    struct diff_filepair *p,
+				    unsigned side,
+				    char *new_path)
+{
+	char *old_value;
+	int dir_renamed_side = 0;
+
+	if (new_path) {
+		/*
+		 * Directory renames happen on the other side of history from
+		 * the side that adds new files to the old directory.
+		 */
+		dir_renamed_side = 3 - side;
+	} else {
+		int val = strintmap_get(&renames->relevant_sources[side],
+					p->one->path);
+		if (val == RELEVANT_NO_MORE) {
+			assert(p->status == 'D');
+			strset_add(&renames->cached_irrelevant[side],
+				   p->one->path);
+		}
+		if (val <= 0)
+			return;
+	}
+
+	if (p->status == 'D') {
+		/*
+		 * If we already had this delete, we'll just set it's value
+		 * to NULL again, so no harm.
+		 */
+		strmap_put(&renames->cached_pairs[side], p->one->path, NULL);
+	} else if (p->status == 'R') {
+		if (new_path) {
+			new_path = xstrdup(new_path);
+			old_value = strmap_put(&renames->cached_pairs[dir_renamed_side],
+					       p->two->path, new_path);
+			strset_add(&renames->cached_target_names[dir_renamed_side],
+				   new_path);
+			assert(!old_value);
+		}
+		if (!new_path)
+			new_path = p->two->path;
+		new_path = xstrdup(new_path);
+		old_value = strmap_put(&renames->cached_pairs[side],
+				       p->one->path, new_path);
+		strset_add(&renames->cached_target_names[side],
+			   new_path);
+		free(old_value);
+	} else if (p->status == 'A' && new_path) {
+		new_path = xstrdup(new_path);
+		old_value = strmap_put(&renames->cached_pairs[dir_renamed_side],
+				       p->two->path, new_path);
+		strset_add(&renames->cached_target_names[dir_renamed_side],
+			   new_path);
+		assert(!old_value);
+	}
+}
+
 static int compare_pairs(const void *a_, const void *b_)
 {
 	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
@@ -2415,6 +2474,7 @@ static int collect_renames(struct merge_options *opt,
 		char *new_path; /* non-NULL only with directory renames */
 
 		if (p->status != 'A' && p->status != 'R') {
+			possibly_cache_new_pair(renames, p, side_index, NULL);
 			diff_free_filepair(p);
 			continue;
 		}
@@ -2426,11 +2486,11 @@ static int collect_renames(struct merge_options *opt,
 						      &collisions,
 						      &clean);
 
+		possibly_cache_new_pair(renames, p, side_index, new_path);
 		if (p->status != 'R' && !new_path) {
 			diff_free_filepair(p);
 			continue;
 		}
-
 		if (new_path)
 			apply_directory_rename_modifications(opt, p, new_path);
 
@@ -3701,8 +3761,16 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 					 NULL, 1);
 		strmap_init_with_options(&renames->dir_renames[i],
 					 NULL, 0);
+		/*
+		 * relevant_sources uses -1 for the default, because we need
+		 * to be able to distinguish not-in-strintmap from valid
+		 * relevant_source values from enum file_rename_relevance.
+		 * In particular, possibly_cache_new_pair() expects a negative
+		 * value for not-found entries.
+		 */
 		strintmap_init_with_options(&renames->relevant_sources[i],
-					    0, NULL, 0);
+					    -1 /* explicitly invalid */,
+					    NULL, 0);
 		strmap_init_with_options(&renames->cached_pairs[i],
 					 NULL, 1);
 		strset_init_with_options(&renames->cached_irrelevant[i],
-- 
gitgitgadget

