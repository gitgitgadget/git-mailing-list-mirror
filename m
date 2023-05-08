Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FDEC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 21:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjEHV76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 17:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjEHV7x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 17:59:53 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3DA5241
        for <git@vger.kernel.org>; Mon,  8 May 2023 14:59:51 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55a83e80262so75974147b3.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 14:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583190; x=1686175190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OmOhmOrxJpJeyICgzWAKI9cAhqjkipbsCj5HP5Ilgfk=;
        b=5p33H01NHscU9zB3BXW+UdRr1Z9udRlBYs9CmmoHw1+Fucbu4hNYrqjF0/KlLtTq1I
         A2dYfZ9zQInIHlGweDoHT9gjDJgS3vVhNtvYL/PxD50ptE5X9SSqNU6TwvXlXdNU/bUV
         aSsu3opJ5W6b/+Ed6PRYOdT0ZjibOBBCzSbqC00TRnOkwwPrnMKd/yHoYbVR4Tc7nAS1
         CVDIZO0INclN2jmE6vuX+kKByphAOx8BUSZMfa2qs65njqYmvH5huKZdo9P2uxQnxMrn
         SgySpvEdYTAKSSDg0EIV4TcbLfy4MzDo7kWLhet2QILP/8h3qvvs1N/9/9FhzlGC03JC
         4cMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583190; x=1686175190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmOhmOrxJpJeyICgzWAKI9cAhqjkipbsCj5HP5Ilgfk=;
        b=fkiE7bQyOQTKE7PjTAP02J9S09FQVPtv+p4h/9gx6I5iQYIgEG0VQZJWnO81MpFik7
         i5k2l/tVlXEvwmUfF/gPzdkPRw6ZOUSUZXBF0W7/IfnG55xF7nYlXbnpnZVfPkd06A5M
         GcLVbS2bbNcqBaxol/bBn3ZBvZKrcg8xxc7XHNLqI/9wnNrRJyaV0nSRiKRY0PirFDfq
         4pZracUCFA255mJoX88sZwEfsOMidvOFpZfyACDKYRtLMmtd01I8TWYKbX7h8BqiVPmP
         bwCbLidlhUjwsU+NAwviKEaJtujtLZusXlHYAmLgXaAzR3UzGNYtO2mRKTrEtiSgq6Rs
         FvsA==
X-Gm-Message-State: AC+VfDwXb7GUFecqnKK396439vwQoeoas0sGXhjFBZgInF8ic5t1NcT2
        Dfhagb0bXOnG5Y2ZPlS6RnWLL1OfcNbO26tcc3jg7g==
X-Google-Smtp-Source: ACHHUZ77yGlalaG9MzSc7eQpUTRnKzHbhf5oHzJNJHqszDDcxkUEVOqhjUJjoLX8JbpT0dT55l4BlA==
X-Received: by 2002:a81:5e41:0:b0:55a:985f:848d with SMTP id s62-20020a815e41000000b0055a985f848dmr14643481ywb.39.1683583190414;
        Mon, 08 May 2023 14:59:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t204-20020a0dead5000000b0055a1069886fsm2783339ywe.129.2023.05.08.14.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:59:49 -0700 (PDT)
Date:   Mon, 8 May 2023 17:59:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/15] ref-filter: clear reachable list pointers after freeing
Message-ID: <7fe8623f606d7abf20b39b24a849d4f8aad6ecec.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
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
index 10aab14f03..b1d5022a51 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2416,13 +2416,13 @@ void ref_array_clear(struct ref_array *array)
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
@@ -2432,7 +2432,7 @@ static void reach_filter(struct ref_array *array,
 	}
 
 	tips_reachable_from_bases(the_repository,
-				  check_reachable,
+				  *check_reachable,
 				  to_clear, array->nr,
 				  UNINTERESTING);
 
@@ -2453,8 +2453,8 @@ static void reach_filter(struct ref_array *array,
 
 	clear_commit_marks_many(old_nr, to_clear, ALL_REV_FLAGS);
 
-	while (check_reachable) {
-		struct commit *merge_commit = pop_commit(&check_reachable);
+	while (*check_reachable) {
+		struct commit *merge_commit = pop_commit(check_reachable);
 		clear_commit_marks(merge_commit, ALL_REV_FLAGS);
 	}
 
@@ -2551,8 +2551,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	clear_contains_cache(&ref_cbdata.no_contains_cache);
 
 	/*  Filters that need revision walking */
-	reach_filter(array, filter->reachable_from, INCLUDE_REACHED);
-	reach_filter(array, filter->unreachable_from, EXCLUDE_REACHED);
+	reach_filter(array, &filter->reachable_from, INCLUDE_REACHED);
+	reach_filter(array, &filter->unreachable_from, EXCLUDE_REACHED);
 
 	save_commit_buffer = save_commit_buffer_orig;
 	return ret;
-- 
2.40.1.477.g956c797dfc

