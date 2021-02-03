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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EBCC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973AE64F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 20:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhBCUEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 15:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhBCUEh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 15:04:37 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77666C06178B
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 12:03:53 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z6so652375wrq.10
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 12:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=yfDtjcJ1TJXIGMyNUMt1kQBPOnO99QJK9uriR9Vve44=;
        b=rRedbHH3047FMa9nZg+WVmrL9mP1GRNpwQFNdlVxsIywNohrXT6PVeGiQd/aCmHRpp
         qkxPZC+jLwOL6s1f1Nrua9SOZRFdcPgh9MB4xByO5KYsFCB/YjGvxsOKDGl6qhUUOyT9
         vDkmAvVuISFqpaxzT0Klk0oWKz4oktI+Cmlg80wbKdkUuhyZWjxsi4Jy0eJRNHeQHxwq
         UAEZooa1KfmESOsG41/VdrKeNCeUbTZzc8YLrZn/4P5kjylwwGoDipAZCiDHLuEZa/Ve
         klew5ya13d7WZZkrYSI7eeAUWpnC52R/q5itjzIg8ve57OQk2kfSVrbeT9nNDje97xEn
         O3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=yfDtjcJ1TJXIGMyNUMt1kQBPOnO99QJK9uriR9Vve44=;
        b=CQ4xLi/d1pOu3ZBptrzyeinMxmdC6H0RWJcy95/uP7QRn1SjpH9nJRkleFzsUVS/Wv
         u1dfLpxr0A2drYT7GEHi4gpgU3BhRb5CykSZA/rni5AS9yKMMItwueXNyvsY/r7S9b+j
         QxqNq7W7ay6ITzTmBdZEySTI7EnAdmsbrcRLUPByZAiiSIrUn/aF2ll7odnYt66ydAlG
         M73XNFrF20QlbIBg8oZl0Qc2ioIx0plY3fZd1AyEItfdQ1ODL55RVnfXSb9iCUyB/lIe
         C6Me1s7yroJZSNgVHxN+2hlaRpl9izNpmeGTyYRfQVQVFLuwYqRS5FKgl3KRjfc+yrRG
         hmLA==
X-Gm-Message-State: AOAM532Ns9J/1MWfgTBO2FbCuzHJMcq5TodJoMfDNE5GyKhuNOwO6IQJ
        KXoQS8UdsuCT60mXbvLurwUEOPmSIi0=
X-Google-Smtp-Source: ABdhPJxofSpWmJbaYd61CpmYnJOHK3VYUxaua6/SzMnYxZyPbtZ90FObG8276b75PPMDGeIpUwXf7w==
X-Received: by 2002:a05:6000:1788:: with SMTP id e8mr5444700wrg.171.1612382632013;
        Wed, 03 Feb 2021 12:03:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm4970563wrp.62.2021.02.03.12.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 12:03:51 -0800 (PST)
Message-Id: <7ae9460d3dba84122c2674b46e4339b9d42bdedd.1612382628.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.842.v2.git.1612382628.gitgitgadget@gmail.com>
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
        <pull.842.v2.git.1612382628.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 20:03:47 +0000
Subject: [PATCH v2 2/2] diffcore-rename: filter rename_src list when possible
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
 diffcore-rename.c | 57 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 8b118628b4e..74930716e70 100644
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
+		return; /* culling incompatbile with break detection */
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
@@ -530,13 +578,11 @@ void diffcore_rename(struct diff_options *options)
 		goto cleanup;
 
 	/*
-	 * Calculate how many renames are left (but all the source
-	 * files still remain as options for rename/copies!)
+	 * Calculate how many renames are left
 	 */
 	num_destinations = (rename_dst_nr - rename_count);
+	remove_unneeded_paths_from_src(want_copies);
 	num_sources = rename_src_nr;
-	if (!want_copies)
-		num_sources -= rename_count;
 
 	/* All done? */
 	if (!num_destinations || !num_sources)
@@ -578,8 +624,7 @@ void diffcore_rename(struct diff_options *options)
 			struct diff_filespec *one = rename_src[j].p->one;
 			struct diff_score this_src;
 
-			if (one->rename_used && !want_copies)
-				continue;
+			assert(!one->rename_used || want_copies || break_idx);
 
 			if (skip_unmodified &&
 			    diff_unmodified_pair(rename_src[j].p))
-- 
gitgitgadget
