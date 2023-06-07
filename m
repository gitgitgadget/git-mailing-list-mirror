Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0DAC77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbjFGKlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbjFGKlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:41:09 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A427A1BFB
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:41:07 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565aa2cc428so66703287b3.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134466; x=1688726466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Idaw3A+j8Lr4A1hR/sp3wu4pqRNzzh+DRmE9v8IG7NY=;
        b=hP7HTzx/5mexgggf+jR9A+b6yuHpV3nt0DCJyG5C4tt1bEh6H67kIfz15CCCkwe81r
         3SiUfYZK9AqapgNJJc3UKwnyAR84Bv2GOG1n653BA9cbzoGMYF1Nj2X/Rp5rhDLvEHp9
         YBwFdX331yWZMYY9abU4aHTD0IadI8Dc5T5lnaY7tnZs38JJn3otZttvqfWh5Kaa9yfV
         rspOxrgRBmro6oRCBxkxS9zw1Cl314CkDsWPqCuSTGziK2YNb6sf/M5Evj0cFWbjvVOp
         TyCHE9/r+PtSWBGztbSwG8P70Uge7rmptlugfCcmCguzOgPJ1/ZGBdu8uzgPE+7w5pQQ
         EQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134466; x=1688726466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Idaw3A+j8Lr4A1hR/sp3wu4pqRNzzh+DRmE9v8IG7NY=;
        b=hYb+2X+pvFT8R8MHp7N7OGbmGWJjYZEPBlihrWgqej42TNOIIjoEz8r7ihQx57yN8w
         L+Nwzpy0YLKaq+zvHlq46mmKs/wWsh26t9PHB6ZYS9+FnJWQC6wzhVWtVgzNK0zTIvY+
         o4uEUiPKYiW0VCFRKrRH3a5BZYD+Q3eI1KDCMWrkYndyIDlpNTZkSgXCK0jei0wnl1W2
         /1XEXRU9kP/nNJ8mpqZ9sNexUmXB8MczCntUhjNcRAsaWfbm3UdowkVNJs0t0VcwylpD
         VNYVahp5BYCMGgB/EW3S1hPhcm4GvVK8B4skHjsD4BeJjBmoybxkPJ7VC+3FbYjXGRxe
         k1rg==
X-Gm-Message-State: AC+VfDwyzxSUklhyvpmhofTzDTg4f8t+U/S4NDqJkFSonde2wATaXC2T
        LU4DAnXnu4Rrd5kAEHJRLUQopEsMzLBhEa9EwKYb8c3k
X-Google-Smtp-Source: ACHHUZ4ve+KJBuBLcZuD3f0oZnwof00YzkTOFfmVTyAHbSwq/qW5K5RsKBct04mhUTT8+Z9VXF0NxA==
X-Received: by 2002:a0d:df90:0:b0:55a:6100:c0e6 with SMTP id i138-20020a0ddf90000000b0055a6100c0e6mr5347852ywe.47.1686134466582;
        Wed, 07 Jun 2023 03:41:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t197-20020a8183ce000000b005619cfb1b88sm4720965ywf.52.2023.06.07.03.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:41:06 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:41:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 03/16] ref-filter: clear reachable list pointers after
 freeing
Message-ID: <fc28b5caaae2d72f147329a84e16aae416857565.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In reach_filter(), we pop all commits from the reachable lists, leaving
them empty. But because we're operating on a list pointer that was
passed by value, the original filter.reachable_from pointer is left
dangling.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ref-filter.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4991cd4f7a..048d277cbf 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2418,13 +2418,13 @@ void ref_array_clear(struct ref_array *array)
 #define EXCLUDE_REACHED 0
 #define INCLUDE_REACHED 1
 static void reach_filter(struct ref_array *array,
-			 struct commit_list *check_reachable,
+			 struct commit_list **check_reachable,
 			 int include_reached)
 {
 	int i, old_nr;
 	struct commit **to_clear;
 
-	if (!check_reachable)
+	if (!*check_reachable)
 		return;
 
 	CALLOC_ARRAY(to_clear, array->nr);
@@ -2434,7 +2434,7 @@ static void reach_filter(struct ref_array *array,
 	}
 
 	tips_reachable_from_bases(the_repository,
-				  check_reachable,
+				  *check_reachable,
 				  to_clear, array->nr,
 				  UNINTERESTING);
 
@@ -2455,8 +2455,8 @@ static void reach_filter(struct ref_array *array,
 
 	clear_commit_marks_many(old_nr, to_clear, ALL_REV_FLAGS);
 
-	while (check_reachable) {
-		struct commit *merge_commit = pop_commit(&check_reachable);
+	while (*check_reachable) {
+		struct commit *merge_commit = pop_commit(check_reachable);
 		clear_commit_marks(merge_commit, ALL_REV_FLAGS);
 	}
 
@@ -2553,8 +2553,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	clear_contains_cache(&ref_cbdata.no_contains_cache);
 
 	/*  Filters that need revision walking */
-	reach_filter(array, filter->reachable_from, INCLUDE_REACHED);
-	reach_filter(array, filter->unreachable_from, EXCLUDE_REACHED);
+	reach_filter(array, &filter->reachable_from, INCLUDE_REACHED);
+	reach_filter(array, &filter->unreachable_from, EXCLUDE_REACHED);
 
 	save_commit_buffer = save_commit_buffer_orig;
 	return ret;
-- 
2.41.0.16.g26cd413590

