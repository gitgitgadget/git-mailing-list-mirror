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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F010C433E6
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E1F764E29
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 07:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhBNHfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 02:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhBNHfq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 02:35:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADB5C0613D6
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:35:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t15so4806455wrx.13
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=8QREYnHyswO8lro4ISNCC9EpXlyVwYxnV0U0u8z2BP0=;
        b=E+cZhc91EC2BgezAbeSzz6Ha27BoBywi06HTChg15U99IPO4vuLF+jizomE7mz1WTm
         c1p91sJvclMOB6F0uxwsMc5U/QLy0pb89OSA23ZPEsB7XsObWg+88HiRPIgMVNgfhCiD
         LbJvcTtN7Mt4Zuxr/wMxRaMq+/V6f4ety63Il6hOXDuCo3+cIZzAnjP20CxtG2fgBrXX
         RNV1rY89b60Ph+G+TaQMmLFjYwSUPM3tuMAfYjtsmK3Hq4TRejuxWKgcNs+JrCAZkGCA
         wGTVzPAQpA6BUkzXUFHYIOpI265TezPJOhu2jrsYLPsK4iiGbeWcBZH0wLjPKKhc1AlH
         GUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=8QREYnHyswO8lro4ISNCC9EpXlyVwYxnV0U0u8z2BP0=;
        b=P1MLoWhoAaghuVc8Od4uXsWGI1ALky13FZ2BhPVASDuJjIxvCxhmlyf2L54uqbi9dU
         TwB6UTJJSqnq1lgFkjyH6a42TtbSiiYpybPvW72sd2pxN8N9vYJhEr396IIXxz3GRtnA
         aa8r05bkpQ0feFzPEZ7XOw2afR9XYVfCJVVJkMAu53lYYH/uzBn9abDtyyZGlZ80wxWg
         U5olAvGy6gI1plmK8XIegybcL5WeM4VUtZpB76SMyU26fsUIqKL9lrQH6w2IQifkVZyi
         1vi9BmvcGrP1HAFb1rn/ZIWLtmyUr7lJcd4ClKDJw/NrdpJHsk8WGyTAVwvxRBlI504f
         fPvA==
X-Gm-Message-State: AOAM530AQZzWsYlOMke4xv1MTeluYIcfToDXnw7gRS38GGInhTHyOX1V
        lAF3sIOnmEJkqIMZNNdlKMJFOKOSF1U=
X-Google-Smtp-Source: ABdhPJw5CwwwKjafe4kSlKdQrDfNkDQGRhisazxZujINAXer+dV8B8Zbrx4OcM2QLQ2xGHEO0PX5Hw==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr12538161wru.88.1613288104341;
        Sat, 13 Feb 2021 23:35:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o129sm8687912wme.21.2021.02.13.23.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:35:04 -0800 (PST)
Message-Id: <dd6595b45640ee9894293e8b729ef9a254564a49.1613288101.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.842.v3.git.1613288101.gitgitgadget@gmail.com>
References: <pull.842.v2.git.1612382628.gitgitgadget@gmail.com>
        <pull.842.v3.git.1613288101.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:35:01 +0000
Subject: [PATCH v3 2/2] diffcore-rename: filter rename_src list when possible
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Karsten Blees <blees@dcon.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We have to look at each entry in rename_src a total of rename_dst_nr
times.  When we're not detecting copies, any exact renames or ignorable
rename paths will just be skipped over.  While checking that these can
be skipped over is a relatively cheap check, it's still a waste of time
to do that check more than once, let alone rename_dst_nr times.  When
rename_src_nr is a few thousand times bigger than the number of relevant
sources (such as when cherry-picking a commit that only touched a
handful of files, but from a side of history that has different names
for some high level directories), this time can add up.

First make an initial pass over the rename_src array and move all the
relevant entries to the front, so that we can iterate over just those
relevant entries.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       14.119 s ±  0.101 s    13.815 s ±  0.062 s
    mega-renames:   1802.044 s ±  0.828 s  1799.937 s ±  0.493 s
    just-one-mega:    51.391 s ±  0.028 s    51.289 s ±  0.019 s

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 59 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 8b118628b4ef..6fd0c4a2f485 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -454,6 +454,54 @@ static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, i
 	return count;
 }
 
+static void remove_unneeded_paths_from_src(int detecting_copies)
+{
+	int i, new_num_src;
+
+	if (detecting_copies)
+		return; /* nothing to remove */
+	if (break_idx)
+		return; /* culling incompatible with break detection */
+
+	/*
+	 * Note on reasons why we cull unneeded sources but not destinations:
+	 *   1) Pairings are stored in rename_dst (not rename_src), which we
+	 *      need to keep around.  So, we just can't cull rename_dst even
+	 *      if we wanted to.  But doing so wouldn't help because...
+	 *
+	 *   2) There is a matrix pairwise comparison that follows the
+	 *      "Performing inexact rename detection" progress message.
+	 *      Iterating over the destinations is done in the outer loop,
+	 *      hence we only iterate over each of those once and we can
+	 *      easily skip the outer loop early if the destination isn't
+	 *      relevant.  That's only one check per destination path to
+	 *      skip.
+	 *
+	 *      By contrast, the sources are iterated in the inner loop; if
+	 *      we check whether a source can be skipped, then we'll be
+	 *      checking it N separate times, once for each destination.
+	 *      We don't want to have to iterate over known-not-needed
+	 *      sources N times each, so avoid that by removing the sources
+	 *      from rename_src here.
+	 */
+	for (i = 0, new_num_src = 0; i < rename_src_nr; i++) {
+		/*
+		 * renames are stored in rename_dst, so if a rename has
+		 * already been detected using this source, we can just
+		 * remove the source knowing rename_dst has its info.
+		 */
+		if (rename_src[i].p->one->rename_used)
+			continue;
+
+		if (new_num_src < i)
+			memcpy(&rename_src[new_num_src], &rename_src[i],
+			       sizeof(struct diff_rename_src));
+		new_num_src++;
+	}
+
+	rename_src_nr = new_num_src;
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename = options->detect_rename;
@@ -529,14 +577,10 @@ void diffcore_rename(struct diff_options *options)
 	if (minimum_score == MAX_SCORE)
 		goto cleanup;
 
-	/*
-	 * Calculate how many renames are left (but all the source
-	 * files still remain as options for rename/copies!)
-	 */
+	/* Calculate how many renames are left */
 	num_destinations = (rename_dst_nr - rename_count);
+	remove_unneeded_paths_from_src(want_copies);
 	num_sources = rename_src_nr;
-	if (!want_copies)
-		num_sources -= rename_count;
 
 	/* All done? */
 	if (!num_destinations || !num_sources)
@@ -578,8 +622,7 @@ void diffcore_rename(struct diff_options *options)
 			struct diff_filespec *one = rename_src[j].p->one;
 			struct diff_score this_src;
 
-			if (one->rename_used && !want_copies)
-				continue;
+			assert(!one->rename_used || want_copies || break_idx);
 
 			if (skip_unmodified &&
 			    diff_unmodified_pair(rename_src[j].p))
-- 
gitgitgadget
