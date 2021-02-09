Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995A4C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 11:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AEB64E77
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 11:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhBILmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 06:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhBILfx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 06:35:53 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5C9C0617AB
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 03:32:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o10so1523278wmc.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 03:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=mGWVDkeWbHVzoF1Sb+r70QO9VawowXIwV5HfLkCAptw=;
        b=IYj25GztWu9jfJ4pFW90D4SpFr7MfQg6zddJz7/PzLQfS9LsHKs+l5nMqrup0KmtG0
         PHZ77QhZZH8sLgxTM1GxS3U7TDH2I3jgnzSO0aHXLgrrgdn4sYcCLDyvf6phSIW20v1G
         p6OMbszUvqAiaiP67uSYOJMGNPjEYR6FFmSxCBtfcLjUtrzD3xhXS9V/KqquPe+g8gT+
         a/fVLqA6HiJE5FEk7ZTHVSELAcTLbMFrxcb9Hf4Lwped8nMEnu5ISkrC6ckabbfi1EvW
         sWrALRWnQSSF0aWmngqIqVeG/8FhKTuUuWTf3DUvikAJX/8cuXtBYvoOUh2lp5lIgK5t
         iPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=mGWVDkeWbHVzoF1Sb+r70QO9VawowXIwV5HfLkCAptw=;
        b=Z5Wwi2Bh85d5RYXSuRJNbgXkuYkOOuCvjRT2PejRmJSwttO/YAaFH3OovOwLdjTyZo
         tlUUD3Hza3LqwrOjgPWA6oFY5XOfZoelRdrdr4KjOhWijoYw0LLKGS12IHr6YNDD87jg
         MPCAnOF0TaTPossfLN/fTTyoVZZaZFRJNCDmw9DuvnYM2uaKBYpdo8EEYE0Nuk+zJ6q9
         8OM8q6OAUel9IYmLCdvZUK3x6GhQXU69mMMEwOG8YvKn7jPLexSS/r8VKKpQumJrc64U
         VgfJQ2vTilW7RE5R5j2CaMBK/9Lx867HXh6X5fcY3XQrt4gkBPCbHH01HAuDglrxk5/U
         Xokw==
X-Gm-Message-State: AOAM530I68wOorLfqFy5W6++8/2zxM6MOmv0tyh7vK90vb1Zbop4dI1z
        lWWM8DnudxhiNw5SsOk/iTramkqZ0IE=
X-Google-Smtp-Source: ABdhPJwofCG4kO722iW4g9uOPscklE9uhQb/nCrWZs1MyMhHy4+lwPOTsgBJfmrlok2TsIteOZQCRA==
X-Received: by 2002:a1c:40d4:: with SMTP id n203mr3040966wma.46.1612870331426;
        Tue, 09 Feb 2021 03:32:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm39062823wrw.76.2021.02.09.03.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 03:32:10 -0800 (PST)
Message-Id: <ce2173aa1fb7ac3830bf8856a14558446e16a3dd.1612870326.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
        <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 11:32:05 +0000
Subject: [PATCH v2 3/4] diffcore-rename: guide inexact rename detection based
 on basenames
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Make use of the new find_basename_matches() function added in the last
two patches, to find renames more rapidly in cases where we can match up
files based on basenames.  As a quick reminder (see the last two commit
messages for more details), this means for example that
docs/extensions.txt and docs/config/extensions.txt are considered likely
renames if there are no 'extensions.txt' files elsewhere among the added
and deleted files, and if a similarity check confirms they are similar,
then they are marked as a rename without looking for a better similarity
match among other files.  This is a behavioral change, as covered in
more detail in the previous commit message.

We do not use this heuristic together with either break or copy
detection.  The point of break detection is to say that filename
similarity does not imply file content similarity, and we only want to
know about file content similarity.  The point of copy detection is to
use more resources to check for additional similarities, while this is
an optimization that uses far less resources but which might also result
in finding slightly fewer similarities.  So the idea behind this
optimization goes against both of those features, and will be turned off
for both.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       13.815 s ±  0.062 s    13.138 s ±  0.086 s
    mega-renames:   1799.937 s ±  0.493 s   169.488 s ±  0.494 s
    just-one-mega:    51.289 s ±  0.019 s     5.061 s ±  0.017 s

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 46 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index b1dda41de9b1..048a6186fd21 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -367,7 +367,6 @@ static int find_exact_renames(struct diff_options *options)
 	return renames;
 }
 
-MAYBE_UNUSED
 static int find_basename_matches(struct diff_options *options,
 				 int minimum_score,
 				 int num_src)
@@ -718,12 +717,49 @@ void diffcore_rename(struct diff_options *options)
 	if (minimum_score == MAX_SCORE)
 		goto cleanup;
 
+	num_sources = rename_src_nr;
+
+	if (want_copies || break_idx) {
+		/*
+		 * Cull sources:
+		 *   - remove ones corresponding to exact renames
+		 */
+		trace2_region_enter("diff", "cull after exact", options->repo);
+		remove_unneeded_paths_from_src(want_copies);
+		trace2_region_leave("diff", "cull after exact", options->repo);
+	} else {
+		/* Determine minimum score to match basenames */
+		int min_basename_score = (int)(5*minimum_score + 0*MAX_SCORE)/5;
+
+		/*
+		 * Cull sources:
+		 *   - remove ones involved in renames (found via exact match)
+		 */
+		trace2_region_enter("diff", "cull exact", options->repo);
+		remove_unneeded_paths_from_src(want_copies);
+		trace2_region_leave("diff", "cull exact", options->repo);
+
+		/* Utilize file basenames to quickly find renames. */
+		trace2_region_enter("diff", "basename matches", options->repo);
+		rename_count += find_basename_matches(options,
+						      min_basename_score,
+						      rename_src_nr);
+		trace2_region_leave("diff", "basename matches", options->repo);
+
+		/*
+		 * Cull sources, again:
+		 *   - remove ones involved in renames (found via basenames)
+		 */
+		trace2_region_enter("diff", "cull basename", options->repo);
+		remove_unneeded_paths_from_src(want_copies);
+		trace2_region_leave("diff", "cull basename", options->repo);
+	}
+
 	/*
-	 * Calculate how many renames are left
+	 * Calculate how many rename destinations are left
 	 */
 	num_destinations = (rename_dst_nr - rename_count);
-	remove_unneeded_paths_from_src(want_copies);
-	num_sources = rename_src_nr;
+	num_sources = rename_src_nr; /* rename_src_nr reflects lower number */
 
 	/* All done? */
 	if (!num_destinations || !num_sources)
@@ -755,7 +791,7 @@ void diffcore_rename(struct diff_options *options)
 		struct diff_score *m;
 
 		if (rename_dst[i].is_rename)
-			continue; /* dealt with exact match already. */
+			continue; /* exact or basename match already handled */
 
 		m = &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
 		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)
-- 
gitgitgadget

