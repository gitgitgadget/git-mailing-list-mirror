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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E9EC433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251B7611CB
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhEDCNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 22:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhEDCNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 22:13:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B44C0613ED
        for <git@vger.kernel.org>; Mon,  3 May 2021 19:12:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p6-20020a05600c3586b029014131bbe5c7so341652wmq.3
        for <git@vger.kernel.org>; Mon, 03 May 2021 19:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w4GJi3ty/atVcewhO2bTD/C+Z0hRpCTJO44uI8VwQmI=;
        b=dNDNWiIhMEJWoR0xQ3STXdDDsMTJ3hkOB5fRGKfaEZyCSXT62wiZUkryHDt3bgTSIN
         h61kVoI4xTYKKVOI/yGQe2wtEFWkgg1S4zkRy+5cNv+cXApfc7pv/a9olp3IQoiJj8mN
         tNDn/CwVGXKdVqwLibyr6iJkvwoBHgotsy7JU4Eh3c563DZ1E/eekZ2NKT2TnhGbFNwQ
         OhPr8J+uG8TwA1o/1aSVGtgStxdvoiqx0h0+2yKMFusOpa68gzhdChZT0ADKhyvpyhqk
         cP/gwUM0kSgNGT80+qf8hTN+/RIK0Y8PuJ7um5JCMbUIrrCcjR8sHD0YQilQyrbGTbcm
         tsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w4GJi3ty/atVcewhO2bTD/C+Z0hRpCTJO44uI8VwQmI=;
        b=bJjdE4P6C1PZ5WLNHokf/AlXmNa2iBCjbCdYWrzQh7W5ESUl9Ze1vszs/huoZBpKwk
         2xHkv4riYb1LeXSKEOI2uyXPYtz9U4pl9zssVCddGBYqdSSu0fEUro8y9y4UfErFNov5
         XyN8g8uE1LtMHGe+7XkbGJ+19lkilI8rUuJ4abtBjzoXkTVzSfaC0TMh5lxETnTrsfeY
         42Wx4HxHmFcLVZFmgRvkdSx8FHWEJ6GDmw9qyPG0U7rCbEJhZEEBj5dU8cVeyU897K2/
         oHpEAQtVNvqRqyHxOH3T9bwo65RiIePTBc/aDSVRJ2YDpTU58/SvtHKJnjFTbX0q8oH4
         hhGg==
X-Gm-Message-State: AOAM533mSXRhehn9Lfq+i8f0EBvEUayCk2zMGQhwXQ2SZ9TdYE2oC+sJ
        Fou4jKBJVQDmpDIyaxmxcfNL5b+wONk=
X-Google-Smtp-Source: ABdhPJzENA9CGYXVPTjtffEbWlm3r2K6at1/+wjFCwA4vaP5QsbRvun5qOngnpCjpt2Ti7W6FzaMoQ==
X-Received: by 2002:a05:600c:2315:: with SMTP id 21mr23913902wmo.39.1620094350085;
        Mon, 03 May 2021 19:12:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 61sm14955849wrm.52.2021.05.03.19.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 19:12:29 -0700 (PDT)
Message-Id: <c0c1956e75c6881303691669dfdbfbb0c0d9b1d4.1620094339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
        <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 02:12:17 +0000
Subject: [PATCH v2 11/13] merge-ort: add helper functions for using cached
 renames
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

If we have a usable rename cache, then we can remove from
relevant_sources all the paths that were cached;
diffcore_rename_extended() can then consider an even smaller set of
relevant_sources in its rename detection.

However, when diffcore_rename_extended() is done, we will need to take
the renames it detected and then add back in all the ones we had cached
from before.

Add helper functions for doing these two operations; the next commit
will make use of them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index b524a2db2769..741970cd05e7 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2360,6 +2360,53 @@ static void resolve_diffpair_statuses(struct diff_queue_struct *q)
 	}
 }
 
+MAYBE_UNUSED
+static void prune_cached_from_relevant(struct rename_info *renames,
+				       unsigned side)
+{
+	/* Reason for this function described in add_pair() */
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	/* Remove from relevant_sources all entries in cached_pairs[side] */
+	strmap_for_each_entry(&renames->cached_pairs[side], &iter, entry) {
+		strintmap_remove(&renames->relevant_sources[side],
+				 entry->key);
+	}
+	/* Remove from relevant_sources all entries in cached_irrelevant[side] */
+	strset_for_each_entry(&renames->cached_irrelevant[side], &iter, entry) {
+		strintmap_remove(&renames->relevant_sources[side],
+				 entry->key);
+	}
+}
+
+MAYBE_UNUSED
+static void use_cached_pairs(struct merge_options *opt,
+			     struct strmap *cached_pairs,
+			     struct diff_queue_struct *pairs)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	/*
+	 * Add to side_pairs all entries from renames->cached_pairs[side_index].
+	 * (Info in cached_irrelevant[side_index] is not relevant here.)
+	 */
+	strmap_for_each_entry(cached_pairs, &iter, entry) {
+		struct diff_filespec *one, *two;
+		const char *old_name = entry->key;
+		const char *new_name = entry->value;
+		if (!new_name)
+			new_name = old_name;
+
+		/* We don't care about oid/mode, only filenames and status */
+		one = alloc_filespec(old_name);
+		two = alloc_filespec(new_name);
+		diff_queue(pairs, one, two);
+		pairs->queue[pairs->nr-1]->status = entry->value ? 'R' : 'D';
+	}
+}
+
 static void possibly_cache_new_pair(struct rename_info *renames,
 				    struct diff_filepair *p,
 				    unsigned side,
-- 
gitgitgadget

