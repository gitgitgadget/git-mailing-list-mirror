Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFE2C63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C10241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="NAzpINx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgKQVrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKQVrE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:47:04 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF84C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:04 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id g20so5282662qtu.4
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=17lcZ0zqXOkBUp/MGOpfciq4MhQIFv8u9HznwaBQsZI=;
        b=NAzpINx7YyRB8FIOpCmUTiUpVLLtbNjRXMFJWkvg1NaNwuY0Ukc4d3YFz+1o8Y2gMZ
         0rur92X+1MkCTKnrjpN+OW2kgK20WtEDAeC+sMAr1HT8H6v5jA7WlPtJy4sBXVyC6Sld
         701JMhkxKZUZv3MgdBsGFm1k65lPDsWrzjcypj2o7M9E7PrWSskC0NvLfPiw5l6IadGV
         Xzo59sTaISjv0h0QT2YayuiAQKRqcB/u9IbVogqM/8jRmwhBVh15/jFKqrXhNgkEVOS5
         Yr4oGPpeLzoFt6ZVPITDvwNKbJtdr0pAbjUuei6N8OhCJyqiaIMQ7uH2xMypUoNVTRzv
         X40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=17lcZ0zqXOkBUp/MGOpfciq4MhQIFv8u9HznwaBQsZI=;
        b=ekHTFL6n1yX7CpA2Xm+pVa/FghpseDu37ZfKvsB9wPwduSQKHnnIdpRTzqMiIM3DlY
         Tt65NGiQsjqrJCWCn0TljFGaIRIW5JCwfaYtMSB//XOeARxVse17NTbWn1a0sYf7JDPf
         1e5MF972NusR1Fo+g6syksQF2r66+tF2Tq6HMcg5JFmAGAmte0b7/bf40O2r2zSaeLyk
         SQc/bOxKTw4Etrmtj4d+r/Pgf7pHbxvScEB0J1yC4jDe5dcnHEJR22LIe/OqPy7QMoVz
         Jwy7iTiE9pip7/FT/q5Qa5VefvY/lys/dJy1+lN3kJDY+VSNyAJKorymn3LVwGFrExrf
         3QEw==
X-Gm-Message-State: AOAM530gQaHa3AX0f8ujA+D6X23vmJgvnTR0TVD8pLEY7161p1AHXs93
        I3c00T8DahpDKlFjoJMvRKQWAeuUKIeocUYO
X-Google-Smtp-Source: ABdhPJwblMlIuv1dZ61PMhmSP7N5/ELv0FIKwUH6K+H5Qtx3sWtSP/mh9XCvPN1ncJgzzLqhErPqDw==
X-Received: by 2002:ac8:71d9:: with SMTP id i25mr1798728qtp.218.1605649623040;
        Tue, 17 Nov 2020 13:47:03 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id y23sm6431121qkb.26.2020.11.17.13.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:47:02 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:47:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 07/24] ewah: make bitmap growth less aggressive
Message-ID: <f8426c7e8b2523711f8d6f917dff4d89881f4340.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
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
2.29.2.312.gabc4d358d8

