Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9F4C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54BC207F7
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="INuZNxNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgKKTm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbgKKTmz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:42:55 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4FBC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:42:55 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id 63so1516052qva.7
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/v80Nm5n3Jy6++VHoC545Uu99XrlcvvkxM1yto8kTBg=;
        b=INuZNxNNYWL7SXAvMvIjwyJFupyUR2dSclLHHs6xfFMqLAj8z5v/MlNcf9o7IU3AWS
         VO1SroZcLick9gwd5QzsHsL+YY5+IKsXhLTbEKRbpnOWYTHnWHirJvJvV858eMBzMJKZ
         z04BIB3IqrUjt2FFaI3BhyXE5gC2bt2UsTdUh1IET4ecnILGGYLJ/+tHTNrdXv+4ZE1Q
         vNMM9DBnzvLFHhbeVZCNb2V1FqSKYFQMpfSmS+Rf1rm841TkN3ihS+9/pQnvx2lvac5f
         dzyzs/OAN9NP3smuwRbRrbp7LrOafqRFyvpaopk1fmf7YHye0BkBLl5nABoP79hs1ahi
         D3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/v80Nm5n3Jy6++VHoC545Uu99XrlcvvkxM1yto8kTBg=;
        b=ds8G0KGjjYj+01X36RmzJuI5HQGAOkMDtrPIWwnc0tehyDnt+SL4jRmwfeh17/8k8+
         LNxTMYKsjlzFa0f9KNXLwXYlrjyIFoxnPYF27UPrqTLk2yVGJeQ4lyO98TqHIuHcFh5d
         jU3UExWMYnWWEVf2Ar1Ot18B/bCEBIBvYPhYq/8cx20aQETzQa3QhDehb5ipT8MPw6nU
         IBBbiBU89V6zggRtoWOdvdWI1s9ITPTReh5nuJxpvDDuSJFEsMaVhNwqfvphLvO554B9
         +y+uLwKiHkKNxGv3EuusVtPuAtW1VN3I9xuVps91n/ch6kk7MRmTaDen3e25yHvxeY63
         zXxw==
X-Gm-Message-State: AOAM53087AOE81YL5HsUU/0mzP0RDKSMbQUA6JkTm57qNnFLCH1EPgDQ
        pABr+edtUWxFkG5LJPg6RyxoGBhgEiHici9v
X-Google-Smtp-Source: ABdhPJzXekRgV4s1N1YHxZOyNLhZv4eH9yvv4LwGfnoeVJzkuiJ6L4vW02bdaRGNY2kVQDBP9ks9PA==
X-Received: by 2002:a0c:ba85:: with SMTP id x5mr26323534qvf.7.1605123774485;
        Wed, 11 Nov 2020 11:42:54 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id g9sm3051472qtq.21.2020.11.11.11.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:42:53 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:42:51 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 06/23] ewah: factor out bitmap growth
Message-ID: <f6eaf05482d46dce58bcf8af884688afb102c386.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
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
2.29.2.156.gc03786897f

