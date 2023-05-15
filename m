Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D51C7EE26
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245022AbjEOTXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244998AbjEOTX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:23:28 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C662100DE
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:19 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55d2e87048cso190604887b3.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178598; x=1686770598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B/guUdyNpi75FMSjjUWiFCSDmxbsAUlqZEhvtlsyOCI=;
        b=pycF5CB5nOD5HTTj/3lDANb14wvUIfhZwpQLPt0dY6GOotayKbG9Cr/eY5/HoBhc0x
         cZO8+bK2oU6vD6spXn8wPqTlZPhyEdosfI4zEjxq8+BulhnkdlaKogdhXJnCwhmbmaQG
         khAd9p6UbEQ4Ht2IxduwvrjdvhTVil1lrBsY/ri7d92ZRBUwxV+QHtbY85cKm824aACY
         sy0IgUZr+6JxG1GTZnkRAgwx1AtKebR0ssMkPYjOpkxaEVyPFT3PKh0irk5LS+lYE1/8
         kecMIpwglcVtt4RMtTJRo674/st7fzNSdio8YT/00DTqexRtcMwxgmJ0Ea1ubZ1Lo/jU
         2yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178598; x=1686770598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/guUdyNpi75FMSjjUWiFCSDmxbsAUlqZEhvtlsyOCI=;
        b=GXBhs8mhIGAkmqASTDv7E+TS8yOTnDfVIOi7ylD4I3ZnH5HIxb1vxEFUWspqaez02z
         EokymCPydZLd9XzPAPJRALxYbfdcNU/8Kt9MovtVCSPScwTdEvsGb3Exxwn6rcJnL6VY
         PSgF+sEY9Bqgm34u8U+G3jbIagBw8rvklYbZNiK4HFe61C9yg2uU/D7hKGJh5MKKixpZ
         GSLHQBfrUqXVWRd3CGQxS7sKQuO0GIhoHyPPcUrWIwodCJxXNlkKq5KoFdQOECKpx+f4
         kgioTaGvNOpHegyeJyK0rw7iMe1/wx0rwdYHG9Ehrs7B7kz0PaVPWSEhqWTyCg2t9na8
         kWOg==
X-Gm-Message-State: AC+VfDyAWvWhgHqiy9zwkwrdvMd6m/j7phqG9/oNeFO9egeTp4DUq7oJ
        vtWqhVmQ1WqlY68s0/p5CHWgfXswQLRln2VOk4xk2g==
X-Google-Smtp-Source: ACHHUZ7uVO5o+NThIdgFsjVHJqpRe4q1kcaQEF27uWALM99Ww5P2tQzdD8U6XM2V84nbMfzSJMZQ0A==
X-Received: by 2002:a81:4e83:0:b0:559:e50b:fa80 with SMTP id c125-20020a814e83000000b00559e50bfa80mr29826350ywb.44.1684178598025;
        Mon, 15 May 2023 12:23:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p64-20020a0dcd43000000b00559f1cb8444sm20879ywd.70.2023.05.15.12.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:17 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 03/16] ref-filter: clear reachable list pointers after
 freeing
Message-ID: <bf21df783d3f99099a4e0a53c9f813690f6ef785.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
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
2.40.1.572.g5c4ab523ef

