Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9595C63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7A6241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="K2Yz+mbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgKQVq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKQVq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:46:59 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3589C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:57 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id v11so17079216qtq.12
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A1JWPrX0+V9iLB+u62uSdRbBNywDpECZ6X0CkSo1VC4=;
        b=K2Yz+mbeVME6pxLdkxuQiG095D9J31aTYuEV0En+eIWNyw82TG1AfmBvcxwKSyttS9
         lDMca+Fb3A/UI300zhtFmnqRAihccnSX2N5TXOPpOoLhVGCML69A6K7PpXOvaSgjQzgp
         1KF7B/ACDFz/+HnL8PUAXMxwOjmVYtEoO+BV40UxlF3lo6dUmdv+9G+MIcEwyE6htlNN
         A/J4iTQ4FVR63kaLT/fJduUijZUuC4LWTQ89/WcO2E7wiyp0jsKZRVpDYh1seaf+vzok
         sfG6wpv0X+bKPXKOONrLOenEXUyn6o/0YGIr5aePvYfDf5+lCnmv4phJAbRNulNJLTvH
         ZAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A1JWPrX0+V9iLB+u62uSdRbBNywDpECZ6X0CkSo1VC4=;
        b=TuK2JkfNuF68sqRDV0Ka00QuF5M4zfg38Q7ur8B7qHXO4mXXnp9KMtehqMc4wSal1l
         /ieJRLCLLFlLV59Wtm44B3Wwx0JrUjYsgXfWnjIkvBmQ0E68piZq+oMpbJHL9AEFyi3d
         QYhrEFk3sXYGEIjiq0WfCS6s4rZIMtoMOtOFaOWWf8hPAHZxpnvDObGL20smNj7P4c78
         FgYBy31bHf2GDjcAS0TmTdiTVf20+GiKKHm3Yp6OZkfD5UKh9VslClj4Xc6GMeFEEQLx
         f4K3Tpx6gD794ZeIuSyD7ROn/GLpEjlmKl3bsb2r9AvQFASqznhuW0Y4BuiGnIdKO8+Q
         TuUA==
X-Gm-Message-State: AOAM531qvq/FZIlG5wDfg6qqO86FaVTKkr9NaqswlioxV6rs6+bFoebp
        4dEPB8XbVG216IOZJADbZodyIXjiWvYzu3ME
X-Google-Smtp-Source: ABdhPJzCx6hOFpzsp9VSfkg3XzchswRfNaPW/5DrQCx51d8ay1SyLI2dFs/7yiD7Bi6+zj0c6dUJjA==
X-Received: by 2002:ac8:5649:: with SMTP id 9mr1729711qtt.379.1605649616887;
        Tue, 17 Nov 2020 13:46:56 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id f189sm14982766qkb.84.2020.11.17.13.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:46:56 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:46:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 06/24] ewah: factor out bitmap growth
Message-ID: <9bb1ea3b19c86507b7485ae872a8ef350cd0aedc.1605649533.git.me@ttaylorr.com>
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

We auto-grow bitmaps when somebody asks to set a bit whose position is
outside of our currently allocated range. Other operations besides
single bit-setting might need to do this, too, so let's pull it into its
own function.

Note that we change the semantics a little: you now ask for the number
of words you'd like to have, not the id of the block you'd like to write
to.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index d8cec585af..7c1ecfa6fd 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -35,18 +35,22 @@ struct bitmap *bitmap_new(void)
 	return bitmap_word_alloc(32);
 }
 
-void bitmap_set(struct bitmap *self, size_t pos)
+static void bitmap_grow(struct bitmap *self, size_t word_alloc)
 {
-	size_t block = EWAH_BLOCK(pos);
-
-	if (block >= self->word_alloc) {
+	if (word_alloc > self->word_alloc) {
 		size_t old_size = self->word_alloc;
-		self->word_alloc = block ? block * 2 : 1;
+		self->word_alloc = word_alloc * 2;
 		REALLOC_ARRAY(self->words, self->word_alloc);
 		memset(self->words + old_size, 0x0,
 			(self->word_alloc - old_size) * sizeof(eword_t));
 	}
+}
 
+void bitmap_set(struct bitmap *self, size_t pos)
+{
+	size_t block = EWAH_BLOCK(pos);
+
+	bitmap_grow(self, block + 1);
 	self->words[block] |= EWAH_MASK(pos);
 }
 
-- 
2.29.2.312.gabc4d358d8

