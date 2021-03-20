Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D47FC433C1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119D361982
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCTAEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTAEA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 20:04:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2746FC061760
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id d191so6262332wmd.2
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=skoEo4SWYtUg71kvRBx6/BANdZpAEw7WB2wFqMP+Wc4=;
        b=WI42uW3UBOsbmzyR7LkJa6Ott1a6lLVIzriHVI4tNw4pey6cvgwdb1slkU9sNCN3AI
         lAkN/NTO3sWgTCxEyjNfCNDm1ak58XWzDkDB75S5e/o7nEK58nOTdc9frolPnoXM+Nzz
         8JMcs3jEoyJtYQA9L6Q4wPjO01fnEiCC0MrBRL4g8TOzI2IIGColzhDJVo5L6IZ8S6f6
         PBcM8IQLwbJOEv9F5qPUtsIaW1Oa+ecWpPfctmRX+3PeisIKmwLSRNGOL7CZClLnMvGa
         /DxDN9dxjOS5/uBkOxC5CpYeozada5zxi1HyZ1Nor2NbNxRbD2y0euZk7zkwggGVm1e9
         TOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=skoEo4SWYtUg71kvRBx6/BANdZpAEw7WB2wFqMP+Wc4=;
        b=EAPNJXxLfXa0ObJ+fhUnICFsgvYksdUsjFd3s/0op5NXWI1tRwI0YTvosJyeW3v3HG
         zDVSYT0suvmNpBVWR5X9TADdfh/98NBLFK2aZbDhuRmKJLUZVSqRYWS7nWubETVMSfwK
         JCWNQwf0ct4WOi2MxnfGKp5K2Py/ASWQIq6N8WeRk2aIJ2o7SLbEUf0PwH7Rpp5h+ytz
         4ojTDyoZQOhVC/JK+4D043Rc4b457d3gQluxZRXcP14TyP/x3J5zPe1LXTm0dLbb2VZM
         /eaOIgrNWKCGGglBr/zxwhUyRYnR7oXAPopQGiS1m2wzZN5ZAXDBSL1JYDu1JY/vLQ/g
         O+Rw==
X-Gm-Message-State: AOAM531NN4uuZ4fLvCft5YUgYQwjQy5Tk/3mDHyHmk2G3qwMAOXdX/KJ
        McrNNru2+yLcKiZcGecekFlGddU02L4=
X-Google-Smtp-Source: ABdhPJzv2MyI8G5E9/EQhzCXqDeTG1B72n1luPcldd2Ht3ZUehdLVN7QJ7Lw6EVaVOqpoIrs8PVdMg==
X-Received: by 2002:a1c:7fcd:: with SMTP id a196mr5754937wmd.180.1616198638547;
        Fri, 19 Mar 2021 17:03:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u9sm7600653wmc.38.2021.03.19.17.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:03:58 -0700 (PDT)
Message-Id: <e223f842748c797a3df967321de7650aba3a9801.1616198636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
        <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 00:03:44 +0000
Subject: [PATCH v3 01/13] merge-ort: use STABLE_QSORT instead of QSORT where
 required
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

rename/rename conflict handling depends on the fact that if both sides
renamed the same path, that the one on the MERGE_SIDE1 will appear first
in the combined diff_queue_struct passed to process_renames().  Since we
add all pairs from MERGE_SIDE1 to combined first, and then all pairs
from MERGE_SIDE2, and then sort based on filename, this will only be
true if the sort used is stable.  This was found due to the fact that
Mac, unlike Linux, apparently has a system-defined qsort that is not
stable.

While we are at it, review the other callers of QSORT and add comments
about why they can remain as calls to QSORT instead of being modified
to call STABLE_QSORT.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 7f5750ce6ab0..34a91c435737 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2405,7 +2405,7 @@ static int detect_and_process_renames(struct merge_options *opt,
 	clean &= collect_renames(opt, &combined, MERGE_SIDE2,
 				 &renames->dir_renames[1],
 				 &renames->dir_renames[2]);
-	QSORT(combined.queue, combined.nr, compare_pairs);
+	STABLE_QSORT(combined.queue, combined.nr, compare_pairs);
 	trace2_region_leave("merge", "directory renames", opt->repo);
 
 	trace2_region_enter("merge", "process renames", opt->repo);
@@ -2550,6 +2550,7 @@ static void write_tree(struct object_id *result_oid,
 	 */
 	relevant_entries.items = versions->items + offset;
 	relevant_entries.nr = versions->nr - offset;
+	/* No need for STABLE_QSORT -- filenames must be unique */
 	QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_order);
 
 	/* Pre-allocate some space in buf */
@@ -3325,6 +3326,11 @@ static int record_conflicted_index_entries(struct merge_options *opt,
 	 * entries we added to the end into their right locations.
 	 */
 	remove_marked_cache_entries(index, 1);
+	/*
+	 * No need for STABLE_QSORT -- cmp_cache_name_compare sorts primarily
+	 * on filename and secondarily on stage, and (name, stage #) are a
+	 * unique tuple.
+	 */
 	QSORT(index->cache, index->cache_nr, cmp_cache_name_compare);
 
 	return errs;
-- 
gitgitgadget

