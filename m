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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290D8C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E454964F68
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhBCFt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 00:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhBCFtu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 00:49:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D7EC0613D6
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 21:49:09 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m13so22791815wro.12
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 21:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=zdv/t28S5o55O4WyGbFzJBmlH4ntQrFTQ08+Jcm6QmI=;
        b=hpTuuXGNtoQIsOyWCxRV4Wxr1fJbGJ9SvHNkx5NtcTKbc+GADpzxrafS253+Vst1SW
         21jlK98lmNmXdYqFCDPJR8WZYPfXTVIKHLloehCMDJRLshO0vLCBG2IJhKCIEU2PLCUf
         CjDkb+fKJqgtLLdqlZ6IyKQRgOIMD/WTyvPkTa9m93scfW2lB/c8Smwv/GOXKU0tp6gk
         HIhjFAtCorqyZqopF0XMPmLZvRhjPuVfCykHKIeMc+q7VEzOC+GzTX7fuiAoYXWMYT/C
         FSSyP1M8adXZC4j11byvnHx0nXzn22gOdfr1dqLGCV2Q06fK8Ioe9brKoMH3iVbCC/b1
         69Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=zdv/t28S5o55O4WyGbFzJBmlH4ntQrFTQ08+Jcm6QmI=;
        b=Q58m65UZbzEjjmHDT9j27r3dVCRCEKLeM11PdGweD8+WEL6yGwEPAMe0L33EZkPbIv
         FoIL/ARSTrqScVqqQdx9dQ/SbdxjcS1eblt433rvEIuybvm3C+yPgv6dVkM0M7Cd4VKZ
         /Qoyj/nH2rTmTS2FJFN3h1zZ/N/S4PF2ABPMwJi2LIvbfsPdlB8ENS58f0bAodHuvl1J
         HzcFjLXjG5Mtlk5qH8gC8xux54/hfO9mlebulUokDxDnPdvgHLDRDZVLCrsHhjpjt2bj
         x7RCMXseXL5QekurfDMOgcIJx0IYA3B3JsMwcijNWyzYP0RqJgaoGvpg/H3ETnyg7xek
         UuNw==
X-Gm-Message-State: AOAM532nf9R2IcRsV3z40vfyIgdUwyptnT+OUA9ZtSCqbeWUsUX/YhEz
        uWpW+JkeEgF7NfBaghUYxGoEdhbPrjY=
X-Google-Smtp-Source: ABdhPJzzznq6PepKW5uIvTuKj7ALt/COwOLZrGxZ5gsUaxUHLF7ITJeli7V9HZiii69JDjTvFDvylQ==
X-Received: by 2002:a5d:60c6:: with SMTP id x6mr1452777wrt.85.1612331348318;
        Tue, 02 Feb 2021 21:49:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm1144371wma.19.2021.02.02.21.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 21:49:07 -0800 (PST)
Message-Id: <580ba9a10f54c7a2e7f28d60395fc2edae25eec1.1612331345.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.842.git.1612331345.gitgitgadget@gmail.com>
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 05:49:05 +0000
Subject: [PATCH 2/2] diffcore-rename: filter rename_src list when possible
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
 diffcore-rename.c | 67 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 10 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index e3047da3aaf..2a8e7b84b9c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -454,6 +454,55 @@ static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, i
 	return count;
 }
 
+static int remove_unneeded_paths_from_src(int num_src,
+					  int detecting_copies)
+{
+	int i, new_num_src;
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
+	if (detecting_copies)
+		return num_src; /* nothing to remove */
+	if (break_idx)
+		return num_src; /* culling incompatbile with break detection */
+
+	for (i = 0, new_num_src = 0; i < num_src; i++) {
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
+	return new_num_src;
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename = options->detect_rename;
@@ -463,10 +512,11 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_score *mx;
 	int i, j, rename_count, skip_unmodified = 0;
 	int num_destinations, dst_cnt;
-	int num_sources;
+	int num_sources, want_copies;
 	struct progress *progress = NULL;
 
 	trace2_region_enter("diff", "setup", options->repo);
+	want_copies = (detect_rename == DIFF_DETECT_COPY);
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
 
@@ -529,13 +579,10 @@ void diffcore_rename(struct diff_options *options)
 		goto cleanup;
 
 	/*
-	 * Calculate how many renames are left (but all the source
-	 * files still remain as options for rename/copies!)
+	 * Calculate how many renames are left
 	 */
 	num_destinations = (rename_dst_nr - rename_count);
-	num_sources = rename_src_nr;
-	if (detect_rename != DIFF_DETECT_COPY)
-		num_sources -= rename_count;
+	num_sources = remove_unneeded_paths_from_src(rename_src_nr, want_copies);
 
 	/* All done? */
 	if (!num_destinations || !num_sources)
@@ -573,13 +620,13 @@ void diffcore_rename(struct diff_options *options)
 		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)
 			m[j].dst = -1;
 
-		for (j = 0; j < rename_src_nr; j++) {
+		for (j = 0; j < num_sources; j++) {
 			struct diff_filespec *one = rename_src[j].p->one;
 			struct diff_score this_src;
 
-			if (one->rename_used &&
-			    detect_rename != DIFF_DETECT_COPY)
-				continue;
+			assert(!one->rename_used ||
+			       detect_rename == DIFF_DETECT_COPY ||
+			       break_idx);
 
 			if (skip_unmodified &&
 			    diff_unmodified_pair(rename_src[j].p))
-- 
gitgitgadget
