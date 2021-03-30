Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F33C433E6
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A4B619D9
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhC3PFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhC3PEi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:04:38 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58090C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:38 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h7so7290529ilj.8
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3nVkSUnCuRKdX/20i8p1f+C/avnQBDdAKi+Iv4n5nPE=;
        b=uMg5e8aCTkmRjo/9WvJbMYgFRUmm1nXJivCweYpTdFpeszndwXkAMQMWOO+yKKmTr/
         evvDxIzNYxH9PyF8Iye3HkVR7xrwyUz40M7/B5ylqkjsIwcIwhR66HH+2z6Am8lQRr+3
         TPgf40nz0T8aVJ0HoAXyF/1fQw/9z0RBNf4FslcPePnqvf9AxO2/QvTdiYicrIvpoBSj
         qTpTzknTX/Ha/7+5X8YVuEM4E4LKX6p5KVKiboegzZAtxv5d3uHinIddz9Fr5Q4OReHo
         MQf9jIZRKuPOjoreUc/PmCYX8MjV4LrP6q4pTpPm9IdgSSonvrhxeJFGkC5/jgXzPHYU
         kp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3nVkSUnCuRKdX/20i8p1f+C/avnQBDdAKi+Iv4n5nPE=;
        b=XFBYRtKhwodpkD2qmX8Xqu6B5mDC0WkXGAmPQdfQ8SAU1MEAN+7PW/PcftcO9aUue7
         /YBNx7JLBojUp87MKgBwjImprD+NFaOFA0/qgYVssWoOAH9wKujuk4r4ZpBhFRs99qSn
         nD0j+HhphN/ZpkbqLcPAk9nXgUxkFKtvfztOhvG8d87yD38VPWE4PdZnguW1rbMZLPJw
         oKmYm90SVEQD2XVupP9QDORwR4JtJZk8phnB8kbylKCHlgkMtYC4nLeEzqJUtj+onNpd
         zWMe274NLv3FVinGZoQ7pctY0tuhH/u/iLd3A8j9TaKWwH6BfOwyme73XHdadbmeM5Z+
         VWfw==
X-Gm-Message-State: AOAM531e50uDBJt7XLg/rqxhkyVt6PXcQV8DV29bA6W1atCkwBurCLv7
        5jwPXz46k32imypQH+s5q5Qh0zPJMRYsYA==
X-Google-Smtp-Source: ABdhPJwQV6eR+5JAw1MZpwCox/qup65jKSUY4oyVlMRNLB0/59A52cdu/MaZb7rEt661MmxyYJTp4w==
X-Received: by 2002:a05:6e02:1a8d:: with SMTP id k13mr14029580ilv.3.1617116677566;
        Tue, 30 Mar 2021 08:04:37 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id x4sm8595121ilm.39.2021.03.30.08.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:04:37 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:04:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 16/16] midx.c: improve cache locality in
 midx_pack_order_cmp()
Message-ID: <7b793e7d0918bc5869f9c2aef818fdd7353ea77b.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

There is a lot of pointer dereferencing in the pre-image version of
'midx_pack_order_cmp()', which this patch gets rid of.

Instead of comparing the pack preferred-ness and then the pack id, both
of these checks are done at the same time by using the high-order bit of
the pack id to represent whether it's preferred. Then the pack id and
offset are compared as usual.

This produces the same result so long as there are less than 2^31 packs,
which seems like a likely assumption to make in practice.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 55 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/midx.c b/midx.c
index b96eaa12fb..9e86583172 100644
--- a/midx.c
+++ b/midx.c
@@ -818,46 +818,49 @@ static int write_midx_large_offsets(struct hashfile *f,
 	return 0;
 }
 
-static int midx_pack_order_cmp(const void *va, const void *vb, void *_ctx)
+struct midx_pack_order_data {
+	uint32_t nr;
+	uint32_t pack;
+	off_t offset;
+};
+
+static int midx_pack_order_cmp(const void *va, const void *vb)
 {
-	struct write_midx_context *ctx = _ctx;
-
-	struct pack_midx_entry *a = &ctx->entries[*(const uint32_t *)va];
-	struct pack_midx_entry *b = &ctx->entries[*(const uint32_t *)vb];
-
-	uint32_t perm_a = ctx->pack_perm[a->pack_int_id];
-	uint32_t perm_b = ctx->pack_perm[b->pack_int_id];
-
-	/* Sort objects in the preferred pack ahead of any others. */
-	if (a->preferred > b->preferred)
+	const struct midx_pack_order_data *a = va, *b = vb;
+	if (a->pack < b->pack)
 		return -1;
-	if (a->preferred < b->preferred)
+	else if (a->pack > b->pack)
 		return 1;
-
-	/* Then, order objects by which packs they appear in. */
-	if (perm_a < perm_b)
+	else if (a->offset < b->offset)
 		return -1;
-	if (perm_a > perm_b)
+	else if (a->offset > b->offset)
 		return 1;
-
-	/* Then, disambiguate by their offset within each pack. */
-	if (a->offset < b->offset)
-		return -1;
-	if (a->offset > b->offset)
-		return 1;
-
-	return 0;
+	else
+		return 0;
 }
 
 static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 {
+	struct midx_pack_order_data *data;
 	uint32_t *pack_order;
 	uint32_t i;
 
+	ALLOC_ARRAY(data, ctx->entries_nr);
+	for (i = 0; i < ctx->entries_nr; i++) {
+		struct pack_midx_entry *e = &ctx->entries[i];
+		data[i].nr = i;
+		data[i].pack = ctx->pack_perm[e->pack_int_id];
+		if (!e->preferred)
+			data[i].pack |= (1U << 31);
+		data[i].offset = e->offset;
+	}
+
+	QSORT(data, ctx->entries_nr, midx_pack_order_cmp);
+
 	ALLOC_ARRAY(pack_order, ctx->entries_nr);
 	for (i = 0; i < ctx->entries_nr; i++)
-		pack_order[i] = i;
-	QSORT_S(pack_order, ctx->entries_nr, midx_pack_order_cmp, ctx);
+		pack_order[i] = data[i].nr;
+	free(data);
 
 	return pack_order;
 }
-- 
2.30.0.667.g81c0cbc6fd
