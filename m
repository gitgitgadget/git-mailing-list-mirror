Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FB5C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C0A208B8
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Y8E05TL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgKKTnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgKKTnC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:43:02 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6833FC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:02 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id 13so1516621qvr.5
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2IwwukICgO2aonhDeOrRN3bUyQ69oFdrn20lHy8bdOM=;
        b=Y8E05TL63EnuYw2AZg3D++DoSnlsslHZ97X+cCr0IQPxMITHCpQ2rJEtWop9JrvfXW
         qxQ3jSORhZMc9/FgVgnnkctwVHz6hwVBvAlvf0agzsZf7lBNGkxkhKRExM3jaO8NhzBb
         qE4SjSC+V3329EvtKmZpilFPE09MYkCwqfr3Ni13QBj2Tgp7B+I4ZrSfCAZ/KzykuveE
         J1F2iPWeg65KRjmjN59bV1qrxUrImWr/zLdXDNOKwqA0J4FQ4+Z+gbTkYQo7Q3QVWllF
         TXQxpv/Hmt2KhGoOI7gOnzbs4va47FQ7WVTvnO9vAyW9G1zyJAy/qIKm46to2+zlTTyq
         asgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2IwwukICgO2aonhDeOrRN3bUyQ69oFdrn20lHy8bdOM=;
        b=e49drNO9QjAqIqouKFX+PsJd6tGmGE/McgiG9ldb8gJUE7eyye60tp/pR8v/0JpLLU
         GxN1Xmm7ROByQV0UcRn4rkkIc8fh9/BAtnRTq+Ps/r91iLe14KqmvWmz7x8Bz5yuwl2S
         h0aJUHyPNwopah+dleVgBDXLm2RG+T9KUV/poJI4CbmbbAb+nhfR2zIK6ufb3ZlC4qZs
         /VNQmvbu3DqaEHw2Ld+QXGez/7kRgZn4vqMP5Z6IfvivtEXRsuDibetiKm+OBDHmKTUe
         R0B8aGDsIspALvP7sn5Px1ZxOE9rmBLp9FwnLuiouYuYgtMbMhAwLf467goLhcIrnWMJ
         U+2w==
X-Gm-Message-State: AOAM533DYvV7zYA02UlS1br1U8tOykiZu1wFBS/lpvjiRE5kV19VnhcF
        c3YrJBi8mNq0i0XeXQkwa05ucAsfyt5lfLwD
X-Google-Smtp-Source: ABdhPJz0iC2NnBs5hJEjtaGzTtWE93azhJM8UQqsIGs0mMvxp4QxrGLJXZUvLcM7DAhf+UPzzUsZyQ==
X-Received: by 2002:a05:6214:386:: with SMTP id l6mr2437700qvy.49.1605123781334;
        Wed, 11 Nov 2020 11:43:01 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id p187sm2919913qkf.70.2020.11.11.11.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:43:00 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:42:58 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 07/23] ewah: make bitmap growth less aggressive
Message-ID: <c7db594fae4d0447a55a92e830475d9bc418ae7f.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

If you ask to set a bit in the Nth word and we haven't yet allocated
that many slots in our array, we'll increase the bitmap size to 2*N.
This means we might frequently end up with bitmaps that are twice the
necessary size (as soon as you ask for the biggest bit, we'll size up to
twice that).

But if we just allocate as many words as were asked for, we may not grow
fast enough. The worst case there is setting bit 0, then 1, etc. Each
time we grow we'd just extend by one more word, giving us linear
reallocations (and quadratic memory copies).

Let's combine those by allocating the maximum of:

 - what the caller asked for

 - a geometric increase in existing size; we'll switch to 3/2 instead of
   2 here. That's less aggressive and may help avoid fragmenting memory
   (N + 3N/2 > 9N/4, so old chunks can be reused as we scale up).

Our worst case is still 3/2N wasted bits (you set bit N-1, then setting
bit N causes us to grow by 3/2), but our average should be much better.

This isn't usually that big a deal, but it will matter as we shift the
reachability bitmap generation code to store more bitmaps in memory.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 7c1ecfa6fd..43a59d7fed 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -39,7 +39,9 @@ static void bitmap_grow(struct bitmap *self, size_t word_alloc)
 {
 	if (word_alloc > self->word_alloc) {
 		size_t old_size = self->word_alloc;
-		self->word_alloc = word_alloc * 2;
+		self->word_alloc = old_size * 3 / 2;
+		if (word_alloc > self->word_alloc)
+			self->word_alloc = word_alloc;
 		REALLOC_ARRAY(self->words, self->word_alloc);
 		memset(self->words + old_size, 0x0,
 			(self->word_alloc - old_size) * sizeof(eword_t));
-- 
2.29.2.156.gc03786897f

