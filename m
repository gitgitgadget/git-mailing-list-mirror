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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEC8C433E0
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 22:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0B464E27
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 22:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBFWxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 17:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhBFWxD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 17:53:03 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F50C061786
        for <git@vger.kernel.org>; Sat,  6 Feb 2021 14:52:23 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c12so12497135wrc.7
        for <git@vger.kernel.org>; Sat, 06 Feb 2021 14:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=PGRjQzl9BkG3yv+jV8uKDjIRk9MizOHpwOuVccr+YAI=;
        b=tHYNuIyjJU8lc7ySo+UnCWfsJtjY8+kgKarKX8NO8RfS2fPtJ5eiBWztIQ7i5uoq+n
         tJaucUdYfp5jb9+RLIvcVqAmUeCfEAFe52637wIff/m+42pys9O8cCDxNsbs4gx9G0M8
         5XhG4nlNGVo9SOL6WlmFO0NEI53pkMthmYsei0KhwBVezcaqMsC9dy6aB0iE2CbkTbMV
         60FLZoZ++5JlviUc1xptknda3Avku4hTZ7pUOuAuMV97DY5o87c4d5kzRhlI9IGU99uG
         M3+tjfKuTGU+0ck7kC/BH5lFR3YiLUF2PeQVeDej7rwxsDE9FEqK7uv74YbEaZL7e5rR
         tZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=PGRjQzl9BkG3yv+jV8uKDjIRk9MizOHpwOuVccr+YAI=;
        b=EfNYWdUVgRqaVosH/C8xuDD4bWLiCv326qb/PvQnS9ECgO/GK9NcuPX9yiujRutzD+
         3WczcfK7h2+i0t7McU2YffPM3OhQv9lC5Vaey7NS/dInIQGG9q+TWqSJLBtz+KOp+P02
         Z0IsSUlTn7yLlDgppgyKIvl9veWn1GalN1NqjaXovC/iOMMiJQ3CsXfxQ9bCif9iWxcw
         QiaeY0zg/v9ZsHHjw0KRVzhatL77NUdUucMllFImkK0jBg0kNIDySJN4mB+uEw1YHYrG
         vg3/svZiSW2V/DQ/mFpuXGLrgYE7bCywTZGcdTlLZmlqYUXlK930dAjIDic+w9jslVf1
         WtEg==
X-Gm-Message-State: AOAM5317MKJ9okS5/WrGjPtLKuGRvMO5PKGKJiktxLAfboFiIXRJPl2j
        8GMdC2uQ+m4+Exx+/7kf33TrVNmhboQ=
X-Google-Smtp-Source: ABdhPJxMO8EA465NwAwbmW1FnpI5fx2fp/sj5msMdT7FwJd5p57EsyLUWdwtm4TovILfA+YYG9pwPg==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr12460003wrp.110.1612651941770;
        Sat, 06 Feb 2021 14:52:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm18196827wro.4.2021.02.06.14.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 14:52:21 -0800 (PST)
Message-Id: <1d941c35076e8d515c8ff7ef01d6b9d8c092aaa9.1612651937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.git.1612651937.gitgitgadget@gmail.com>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 06 Feb 2021 22:52:17 +0000
Subject: [PATCH 3/3] diffcore-rename: guide inexact rename detection based on
 basenames
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
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Make use of the new find_basename_matches() function added in the last
two patches, to find renames more rapidly in cases where we can match up
files based on basenames.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       13.815 s ±  0.062 s    13.138 s ±  0.086 s
    mega-renames:   1799.937 s ±  0.493 s   169.488 s ±  0.494 s
    just-one-mega:    51.289 s ±  0.019 s     5.061 s ±  0.017 s

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index b1dda41de9b1..206c0bbdcdfb 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -367,7 +367,6 @@ static int find_exact_renames(struct diff_options *options)
 	return renames;
 }
 
-MAYBE_UNUSED
 static int find_basename_matches(struct diff_options *options,
 				 int minimum_score,
 				 int num_src)
@@ -718,12 +717,45 @@ void diffcore_rename(struct diff_options *options)
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
+		rename_count += find_basename_matches(options, minimum_score,
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
@@ -755,7 +787,7 @@ void diffcore_rename(struct diff_options *options)
 		struct diff_score *m;
 
 		if (rename_dst[i].is_rename)
-			continue; /* dealt with exact match already. */
+			continue; /* exact or basename match already handled */
 
 		m = &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
 		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)
-- 
gitgitgadget
