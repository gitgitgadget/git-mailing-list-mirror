Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E31EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjFTOVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjFTOVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:21:16 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA36E6C
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:15 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bb2ffa1e235so4749612276.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270874; x=1689862874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ws0QnKjly1jEjNTRdSJ79n+UxGFeoPe/V/EpPVx/oU0=;
        b=Ty+tr3ku/aESJ6/PBOfecB4EPSs5msbCd3u1azqpv2BCqkgziVPcr060tl4N2izmKh
         hO6oXKWyBnfCdPZgyeh9viNUpBGFZVoFW6w2NKpVktKS4dLzCpiwi2lBKM+UcHovZSqn
         eFjc3Qsul9xSD7zi4RZCrWDl8kl1cTpD8yE6RxDA3UVAJauH/Njxvw80JWK+sGLW7MC/
         BWgCxffZslPxpL4nVIlfVyHlwOkAURmHZS9txHDbXge4+IdpwRiaO4J+2g/chv4Vyz2n
         z+iTA8G/T0dIVOZpAp6JMoMvV44QvH1WZpEVfDwjth/4ivJOIV+voOQ+DfGQ7dwJ87S4
         Whqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270874; x=1689862874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ws0QnKjly1jEjNTRdSJ79n+UxGFeoPe/V/EpPVx/oU0=;
        b=NY8VjM8/9yN7vmwycC2IIFfw58ofAmveGEE+IvN11H5DgjwxR4sZa1cKQQo/TTOMf8
         oBzMUt7XzbPsaUnOvXSbWTKBZzLa7n3DCy1JjWGDlQCAU0CMxZVBwKcJuCZ/Rx4jQOd9
         QSWNrmBdP8zqKoe93N+C+/4DQPz8nXoZJadG555hvsECEQbKarZ5Ap2rQbsaV+xocdtM
         c9vioSUqATdpxUQqwoHD4a13hK4qkMX0PCIsShiGPc0ggJhvTZ0WkKTBhhE7PjoZ5Ymq
         knFRHAtDNH2o5mYxI/8ebAaha6Fm8J29Wr88n6z5A/eeP8W8T3woPy5SF1mG6TX81u0l
         bDFQ==
X-Gm-Message-State: AC+VfDxGKfQVAe1ZeWMontUAdNnHviNNNTySwnhkor5arkB/bwU3nxxK
        9yRGNdWHSKE7NBXmN5S00pmsxLzrQw6hENoBqZ2A29rj
X-Google-Smtp-Source: ACHHUZ7bigrKiB8PZsGDjYViaWPSs4TST5UiVnTLl25ZcegX7DkwIYYLHHJYIMY6kyRaMkKqzTifdQ==
X-Received: by 2002:a25:9385:0:b0:bea:918f:2f01 with SMTP id a5-20020a259385000000b00bea918f2f01mr8039363ybm.44.1687270874341;
        Tue, 20 Jun 2023 07:21:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e63-20020a255042000000b00be674b1b740sm394616ybb.5.2023.06.20.07.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:21:13 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:21:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 03/16] ref-filter: clear reachable list pointers after
 freeing
Message-ID: <7e6bf7766d020914af53e7d6926f5a6c4c4d0668.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
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
2.41.0.44.gf2359540d2

