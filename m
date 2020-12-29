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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4325C433E9
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A1022209
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgL2UGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 15:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgL2UGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 15:06:23 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DFDC061793
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:32 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i9so15620347wrc.4
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uKzxYlth5/h5Z+r4ojWksiqQ0jpLKXXnqR8B6eOh0po=;
        b=OJ2U4+LeLOh+XJX2PdGRYR+GiT2HIQQCLZlMpvOHWfBORAE21PNSlVspMNHwBIdFg8
         jDRZKYXqcue1s85S1aI14PK8mPN4yXk8FCh7rhtszCvHi7lrT5eC/MlvSBsWwjRTRCYb
         8wVuj3iMsOvtShzoAfHPBMFpCosKlPduqnyibuL2BtiXulRSBYVrLNg6sePcGYzTMP3R
         /VtkJc6jFIDdIIXMBdEzZkNaVyP61sxuYdWR/wTHzkUUgnZ9tupk42ejrF+sbX7LpFHn
         ATGUMHNMu78r8B+w/W4mU+COhvFNTa7Zwqe0Z5lGeMIjLGWOkOWgkV5E1HNOzbnERUKr
         nfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uKzxYlth5/h5Z+r4ojWksiqQ0jpLKXXnqR8B6eOh0po=;
        b=nIk+hkci08pbYCfdMHogHqZ90ZRMY15yKSkaS39mH95WyA4s+9KU5EO4OdTdfjSMVg
         /yZaWD1nSrh8ldj4DRNcSZUlV5Rs+EZToiGkrEdcFkr+S1PSqalfJLxIolNdiTOkQ17/
         ujLiP5uUv/Nch0YYLv7ymLRnE5CHNQS2bdKv5QADm9auZUpCJ0zyTLmZ6VZQUcolepC3
         wTHvuNXSmU6LlrItfUb7WwaQh11hksXvCffAEhCCfXTWhLUqQ6CNpPB4pCvgSzm3g3Da
         /5LP1pZitFoNsobhJ7T0nCu2Jsli8NfdAI8sxSRfow/qNaNjJJ7rvPVYCf24PNFzpI/u
         x2SA==
X-Gm-Message-State: AOAM5331dfTOTOKFG0/0tQqtO07SM3iQ+yaRB6U6dTp6cuXQJYPFG8KZ
        gFiAY1y6P4g1ARFq+mGiuMTcFAFoJKw=
X-Google-Smtp-Source: ABdhPJx9DvwNzmRfSnq6lyL/ZZ65Z5HdpNYTXQcEBCEE36fZ++hdKvvt3CBGcWtjLpDe/dUND/I/CQ==
X-Received: by 2002:a5d:5385:: with SMTP id d5mr57015964wrv.384.1609272331138;
        Tue, 29 Dec 2020 12:05:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm64211813wrl.95.2020.12.29.12.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 12:05:30 -0800 (PST)
Message-Id: <428d8204894f668e925c640b2f72dc597164e706.1609272328.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
References: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
        <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Dec 2020 20:05:20 +0000
Subject: [PATCH v3 1/9] diffcore-rename: rename num_create to num_destinations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Our main data structures are rename_src and rename_dst.  For counters of
these data structures, num_sources and num_destinations seem natural;
definitely more so than using num_create for the latter.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index d367a6d2443..15a98f566e4 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -434,7 +434,7 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
  * 1 if we need to disable inexact rename detection;
  * 2 if we would be under the limit if we were given -C instead of -C -C.
  */
-static int too_many_rename_candidates(int num_create,
+static int too_many_rename_candidates(int num_destinations,
 				      struct diff_options *options)
 {
 	int rename_limit = options->rename_limit;
@@ -447,17 +447,17 @@ static int too_many_rename_candidates(int num_create,
 	 * This basically does a test for the rename matrix not
 	 * growing larger than a "rename_limit" square matrix, ie:
 	 *
-	 *    num_create * num_src > rename_limit * rename_limit
+	 *    num_destinations * num_src > rename_limit * rename_limit
 	 */
 	if (rename_limit <= 0)
 		rename_limit = 32767;
-	if ((num_create <= rename_limit || num_src <= rename_limit) &&
-	    ((uint64_t)num_create * (uint64_t)num_src
+	if ((num_destinations <= rename_limit || num_src <= rename_limit) &&
+	    ((uint64_t)num_destinations * (uint64_t)num_src
 	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
 		return 0;
 
 	options->needed_rename_limit =
-		num_src > num_create ? num_src : num_create;
+		num_src > num_destinations ? num_src : num_destinations;
 
 	/* Are we running under -C -C? */
 	if (!options->flags.find_copies_harder)
@@ -469,8 +469,8 @@ static int too_many_rename_candidates(int num_create,
 			continue;
 		num_src++;
 	}
-	if ((num_create <= rename_limit || num_src <= rename_limit) &&
-	    ((uint64_t)num_create * (uint64_t)num_src
+	if ((num_destinations <= rename_limit || num_src <= rename_limit) &&
+	    ((uint64_t)num_destinations * (uint64_t)num_src
 	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
 		return 2;
 	return 1;
@@ -505,7 +505,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
 	int i, j, rename_count, skip_unmodified = 0;
-	int num_create, dst_cnt;
+	int num_destinations, dst_cnt;
 	struct progress *progress = NULL;
 
 	if (!minimum_score)
@@ -570,13 +570,13 @@ void diffcore_rename(struct diff_options *options)
 	 * Calculate how many renames are left (but all the source
 	 * files still remain as options for rename/copies!)
 	 */
-	num_create = (rename_dst_nr - rename_count);
+	num_destinations = (rename_dst_nr - rename_count);
 
 	/* All done? */
-	if (!num_create)
+	if (!num_destinations)
 		goto cleanup;
 
-	switch (too_many_rename_candidates(num_create, options)) {
+	switch (too_many_rename_candidates(num_destinations, options)) {
 	case 1:
 		goto cleanup;
 	case 2:
@@ -593,7 +593,8 @@ void diffcore_rename(struct diff_options *options)
 				(uint64_t)rename_dst_nr * (uint64_t)rename_src_nr);
 	}
 
-	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_create), sizeof(*mx));
+	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_destinations),
+		     sizeof(*mx));
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
 		struct diff_filespec *two = rename_dst[i].two;
 		struct diff_score *m;
-- 
gitgitgadget

