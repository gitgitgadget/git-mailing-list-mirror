Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A529C2BB40
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D06B6222B3
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgLHWFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730728AbgLHWE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:04:58 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11758C061793
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:04:12 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id b62so251898otc.5
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9mqvfpcaLJPH1p9MC9DOD+j9GQThZNPIDACNQV59NaA=;
        b=JwszJnqBTszbZBZY18Y8jzQ1zBnYsMvWjbGDRbKVxIHeprYg3dFo1Yu8dqPgZILDoS
         U/Q/q/ILvCUiRjcYCSn1FGfjfG3MPYXYbSyFBY9WME82AF2X7MQ/vooFrK/KdBXlflZi
         PZTK3ehF45iralk+q3gKIzOnrW+X0UHGgSeQftIjcbewz/GtNeRQdxUmNxP497oSnIMg
         ewXB1kBSCI9o03rEf80nm1hfTcKzAUk2buoItt6EFo4boaA6S7JgqxHiMTFNUU9BWb6M
         FULGeCBl7ggzNmm1zpx6G+2aYpokUvmOZKP2HY5TFpGnXk6iagvtcyWr7t3xgofod1p4
         3RwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9mqvfpcaLJPH1p9MC9DOD+j9GQThZNPIDACNQV59NaA=;
        b=Obg7gg9Qub/xn0UdAa1aDWCYybv3tcvah3oPH4LGYH7O8mUCtOOPlLeeK8FJM3zHHG
         fDFALjp5AJK1KS3LXO4DU5+XY5CKcv9cOSwCkanaf5/Xd3pAdvXZYOy3PkQMD5DQQAk9
         CO6kIX25mDLdw+IyhzNBXt8u59YFzrVz9Fh3149I92c6JDZcPRae4qXWPUTJJGmRryaM
         nmA9gs14yJ5c6/8PzfY8sBluERtxUmTld1fIri/83sKYwpHCAxku3CPCZ6NAXtpuLslF
         9vE0gwtKpzlpFd5kTykJg8YB9G/nj6ibv2GclQHRDF9o+aGP7IHN4F3zHzqOhWL2JuFL
         G5mA==
X-Gm-Message-State: AOAM532aIpN0Vg5MYA3v4HoJclkBLc7a/cBE+Vaj1FPblNWVTvOclQyh
        uQfx+keK+b2HMqHLBkgKFhBOYhXhn8zjwOLt
X-Google-Smtp-Source: ABdhPJx6XjNZwZMqiULfFtntbTv1SJa6MQWP0myE23ogFRR/BK9NbW3BrvFsGCIhnZQNGm7E9s8Ajg==
X-Received: by 2002:a05:6830:3154:: with SMTP id c20mr150275ots.286.1607465051204;
        Tue, 08 Dec 2020 14:04:11 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id o135sm58325ooo.38.2020.12.08.14.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:04:10 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:04:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 13/24] bitmap: implement bitmap_is_subset()
Message-ID: <0cfa932b7175ab2863f42c195c2eea6c711f6553.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The bitmap_is_subset() function checks if the 'self' bitmap contains any
bitmaps that are not on in the 'other' bitmap. Up until this patch, it
had a declaration, but no implementation or callers. A subsequent patch
will want this function, so implement it here.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 21 +++++++++++++++++++++
 ewah/ewok.h   |  2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index b5f6376282..0d31cdc866 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -195,6 +195,27 @@ int bitmap_equals(struct bitmap *self, struct bitmap *other)
 	return 1;
 }
 
+int bitmap_is_subset(struct bitmap *self, struct bitmap *other)
+{
+	size_t common_size, i;
+
+	if (self->word_alloc < other->word_alloc)
+		common_size = self->word_alloc;
+	else {
+		common_size = other->word_alloc;
+		for (i = common_size; i < self->word_alloc; i++) {
+			if (self->words[i])
+				return 1;
+		}
+	}
+
+	for (i = 0; i < common_size; i++) {
+		if (self->words[i] & ~other->words[i])
+			return 1;
+	}
+	return 0;
+}
+
 void bitmap_reset(struct bitmap *bitmap)
 {
 	memset(bitmap->words, 0x0, bitmap->word_alloc * sizeof(eword_t));
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 1fc555e672..66920965da 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -180,7 +180,7 @@ int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_reset(struct bitmap *self);
 void bitmap_free(struct bitmap *self);
 int bitmap_equals(struct bitmap *self, struct bitmap *other);
-int bitmap_is_subset(struct bitmap *self, struct bitmap *super);
+int bitmap_is_subset(struct bitmap *self, struct bitmap *other);
 
 struct ewah_bitmap * bitmap_to_ewah(struct bitmap *bitmap);
 struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah);
-- 
2.29.2.533.g07db1f5344

