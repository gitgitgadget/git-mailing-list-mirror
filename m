Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA08C4332E
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B7164FF9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCKRF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhCKRFp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:05:45 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F409C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:45 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id d5so19566749iln.6
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dFq0lRmBt/kR5avjX9ISuKsERFydf+Naiz91SkYuCko=;
        b=zlI2PQVXO27vaqGk4oG9wZMB4QlB0QVvBE38OyiH2NyrBGY0WlY2mQga9ERrbEw3lV
         ay9t/3DfZiLUV0sHkI9Unz1x6LA7I/3E1t7DOOg4IfSXt3/vgCoAdBKnSRBuhTLFe0ZG
         W9U3A/+ao/oGjRQkVyzOZUU+wvikvZpzPneFweQPTF1VlybgdA8p5ZuC2Um5xst2kWSF
         rPvertcrXAJXKTNkpM+ZFyKTPMEKg/K7O39BHlhXW0PxHLeRpU5ndg7xe87pPM9qwz5E
         yS139BzEONdYtdXjItq1o0jYKVOAFknvPC5xpt8zb3nNK25JjRUpJ5FpCvX9HzOxRDND
         ZsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dFq0lRmBt/kR5avjX9ISuKsERFydf+Naiz91SkYuCko=;
        b=JtGCIcvO6im1+3es1Ns1Z2KPR1p/9uy5uok56j7K7zocOTKsvuL1q68wFW7d5HpFMU
         AKUbzKoj6Dpu/nHqYzfpeApDhs6yt1wIBmbKk1JVlN76QIR1IiU7eG7av5irryUnHjgB
         b+4FpoqkiYPwOm5lOPV2CrwBuYqVhOkX0qWHiOUDBcamtc6N1iSrYh+FDx6WJIyZd3oL
         ySOXh0aL3EAvWLj1oU4fZciMb3ALK5O/dAQwq8eC1A2EYeqXCVoNam06QZfSsNvWRm8C
         wCXb0Ai1FIG5I1EfUIiVvVe2mN3Kp1cnaeIT56MUje0mxeB8rFDDmTD4obzYGRop8xd7
         baVg==
X-Gm-Message-State: AOAM532FvksZvY+RgOCEw5JiT7l5Pib0J7xqS8tVHvYIHCyXitf7fJmL
        IGd8f6X6f06VldAbcsqsJk3t/fHM2q6p17fw
X-Google-Smtp-Source: ABdhPJwPRvu2rfEXth1ikQGhz/HDQQBl5Hk+gUTIFE5wr9aX9byikUKf4ZrYoryLF1SMbrgAUfctww==
X-Received: by 2002:a05:6e02:489:: with SMTP id b9mr7559612ils.37.1615482344693;
        Thu, 11 Mar 2021 09:05:44 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id l17sm1651629ilt.27.2021.03.11.09.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:05:44 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:05:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 16/16] midx.c: improve cache locality in
 midx_pack_order_cmp()
Message-ID: <550e785f10ba14f166958501c007b75a04052a0d.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
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
index eea9574d92..4835cc13d1 100644
--- a/midx.c
+++ b/midx.c
@@ -828,46 +828,49 @@ static int write_midx_large_offsets(struct hashfile *f,
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
