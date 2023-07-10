Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E0CEB64DC
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjGJVMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjGJVMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:17 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42F91B8
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:12 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5768a7e3adbso89409547b3.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023532; x=1691615532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMZg/cSyUKlkSuKoinFxU/Ai6RGGHgmeW3kjx1o9cL4=;
        b=5Aqb7smiKCqiFs1xW5dlW1O75s4NDxQGwuZFyXWX+gtsY6WTpt9NAAoUW+koiJxW9v
         cbeAiievkseWffyDneM57coKAVPshW9G2eLTlyk6U8PfGDuGpaM8gv+qe91T42CXkvXk
         iNq0Z/RlFhVNNgG2G1HbqjllcTYlioeRNxWl4+rEeYTA3vN5fQERDhUoODUrI+Zlce/C
         YcSebZh+OujHwWS7jQkA1DdcyZ/OUY+ewrAlzGkAgmIZczjO249BIPi17ZAy78neAggk
         8ycQDr2jAhryH1dKWSXCzPiRDTB/vqApXbGI9jiP1w69NCcsU0uALe/BbKAtsBHlJ4VK
         DBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023532; x=1691615532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMZg/cSyUKlkSuKoinFxU/Ai6RGGHgmeW3kjx1o9cL4=;
        b=R1BSwFcsXtr2lsB6t3bFDMhopllDzPtdM0qEcPlBkmRJ410WX+aRe8sKWHjdR4ll+q
         CRP6Cdjv15lV5Jrvjhr3qBWMAsSN+EnhWEFleHs0WYk3psM65ALnaF3RouBNWnIh825t
         9pfGnE3Zw08ho5khkgo2mlHH9bn1xu4tQBhVZteW5R3QIhoiMRk+HjBAubvVumiyvBzQ
         WpPGRWW13iGEjEcRFybHrCQDfjfhTIQbmPwF1orA4MHYs/86R+hUpWVrYriG1VcJTHZG
         +OW1a4mfqCDFSZdd8AhKbntVj4w5yKBCuUy3IzImAMDr/eYG6jfBVA1ydxvcWK9sy9rc
         XWSQ==
X-Gm-Message-State: ABy/qLbn2SqzbOq35X5+mG9m2uo/mugjjBrGK1EMaEU5Ic6lKDftW6gC
        n/wnpMg0eKeRJunGZMlCMz1sJkx0hNT/ujRklMJPSg==
X-Google-Smtp-Source: APBJJlEMQrdTy49cd2YdLNt5B/nxF7Vo9ZlpiDxKfPMvle403anBv05PViTsBGbKpy2a7+DzDGrHWA==
X-Received: by 2002:a0d:dd85:0:b0:56c:e371:aad with SMTP id g127-20020a0ddd85000000b0056ce3710aadmr10848360ywe.14.1689023531934;
        Mon, 10 Jul 2023 14:12:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o8-20020a0dcc08000000b0054c0f3fd3ddsm193307ywd.30.2023.07.10.14.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:11 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 03/16] ref-filter: clear reachable list pointers after
 freeing
Message-ID: <cea1e88d35871f84d504a7e5eaa6186fcc6f46f0.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In `reach_filter()`, we pop all commits from the reachable lists,
leaving them empty. But because we're operating on a list pointer that
was passed by value, the original `filter.reachable_from` and
`filter.unreachable_from` pointers are left dangling.

As is the case with the previous commit, nobody touches either of these
fields after calling `reach_filter()`, so leaving them dangling is OK.
But this future proofs against dangerous situations.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ref-filter.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e0d03a9f8e9..4dd6575400c 100644
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
2.41.0.343.gdff068c469f

