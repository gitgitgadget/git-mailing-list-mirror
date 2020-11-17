Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B8AC63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00212463B
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ZWVI95Zm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgKQVq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgKQVq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:46:29 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053B4C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:28 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id z17so11562135qvy.11
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UplR+lA1i/f+BbgtcWFX3ZDVG/ISKvLsoJrbR1qzcvg=;
        b=ZWVI95ZmMWMhkQKC5ovkr6Zz6w4jhLv7yZLdvYjGWQZOeZu2G+JWzyD+2YdNQc5B30
         pDXPNEiCX4Kol+NleyYHutPeq0gSp7hCULvqdhaIkAVjARJdlAuQP8LluDJ/UaElMi/5
         KnavQrXCcwYE9TzPdcWIrQqvhD+MCbNolYmx3uL72Iyt34XMYzAe5YyX1SCGrH5EyEXg
         g6VarKO3IkZzy0TKefu/MoSzrCMkroeTZe+++UQU4k7otISSR2X3Njfqe7o8JT+6yozA
         c69Vn33ABpL11bjY8B4myoMnH6VQNMRec9wEl03I/uorgETEJxCQifkb/xmmoC7YNdQy
         UYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UplR+lA1i/f+BbgtcWFX3ZDVG/ISKvLsoJrbR1qzcvg=;
        b=O4mbbE/8+ayw0T6KEmMeAmzUL0qrifhD1FNsPPFj8IVhQuj9deV19p2SHx6L8ZPpv1
         LGH0r/FjANznH0nwcPYau3djoesMlRQofgL5p1rKEFFSwD5ZhNLGzjzD/5SRj8VV2dH3
         TCtmZfjXrr6clqUne72wPKrjpGtMoxgOT47+dHk9Ka53Hhn/ewPcyckjDGGvYSVUHQps
         3whY5ZrK6sHZSqji9dVmM/X+zGUdfamx7kgXTcEsM1g7x1MxaTrIxY/I+2Pef3EhAqjD
         M8cXgWUg389YpkGzkk9Jh4axsCRgZSeMeW4JKnbwNi7I4S/RTQoFD5Y19tGv3geVjyjy
         aT7g==
X-Gm-Message-State: AOAM533ZwPsq3Wuvq6dEQ/MRVb4E8J3uVah2G62Zi4oG4yhB+GNJ8+dH
        +EhFYbFVoMJz/YVX9mq0w8pnM2ePoB8CwkV5
X-Google-Smtp-Source: ABdhPJyMvVpeHCB8QQJap5776Al83EHT6ysXacb7gTbEn5zC0IjX04LylhDHNyKH+oqcxvnCesDk3w==
X-Received: by 2002:a0c:e608:: with SMTP id z8mr1908391qvm.2.1605649586936;
        Tue, 17 Nov 2020 13:46:26 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id v14sm15556520qkb.15.2020.11.17.13.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:46:26 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:46:24 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 01/24] ewah/ewah_bitmap.c: grow buffer past 1
Message-ID: <07054ff8ee43c4361c472e40b72f767107f66ed8.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the buffer size is exactly 1, we fail to grow it properly, since
the integer truncation means that 1 * 3 / 2 = 1. This can cause a bad
write on the line below.

Bandaid this by first padding the buffer by 16, and then growing it.
This still allows old blocks to fit into new ones, but fixes the case
where the block size equals 1.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/ewah_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index d59b1afe3d..3fae04ad00 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -45,7 +45,7 @@ static inline void buffer_grow(struct ewah_bitmap *self, size_t new_size)
 static inline void buffer_push(struct ewah_bitmap *self, eword_t value)
 {
 	if (self->buffer_size + 1 >= self->alloc_size)
-		buffer_grow(self, self->buffer_size * 3 / 2);
+		buffer_grow(self, (self->buffer_size + 16) * 3 / 2);
 
 	self->buffer[self->buffer_size++] = value;
 }
-- 
2.29.2.312.gabc4d358d8

