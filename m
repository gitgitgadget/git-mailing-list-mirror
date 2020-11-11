Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6662C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 907872087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MmshsSUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbgKKTne (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgKKTnd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:43:33 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CF6C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:32 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so2935255qkf.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q0JDLDeqmjbZWetZBWxBOsVHgE1yq9OO5bMtjjsWEDk=;
        b=MmshsSUS1H+Djv/E+lwr0sasD2rR/XrmH4By+hQ79pvr6CPRH/vCDKRRdG4dA1pt4c
         6oBLQiyqiYqzfeFWbc7vvD7FALxIkPOV8P5CFiUjAxCNt0kZsl1vLyWXwkWnXNmuL5WR
         0N0kNINAQc5dHFgGqu6vDyu/W3SIAkrgJxu5i9MJf7d6UTrcuFA91/r24yPZkc/OsQmr
         dk7KMHjLrJv4MlPRyYiUz9XY/Nq5Y03/0dxk8l5Fon0Bsj6NijKCcTjwHIOAtuZ88jJn
         AXaUNGhAObTtLLqrUtcdiErgF+wBwgfgR3aumEeqHBKTU0ojPLb8aKlD5axtqinkHTc1
         DVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q0JDLDeqmjbZWetZBWxBOsVHgE1yq9OO5bMtjjsWEDk=;
        b=pqugNoNLT1kzBZt71I85Vne8svEQKD2XCl8AGbGsWykLVTvRYBeuE3p+5Mpl0aCJC9
         enArXrj4Vw+VxAExUJdouSvk6nI5k/9WLxTTcpuqwUnNfkMDqhDRpYTymhbAuCmWGhfb
         usNcm5blKrBw3OzjXtG6XrzDtyCgnT5XFGIgq5P5I0yDol4AF4pF+f/6ddsu8PakNzJn
         I6iIygMWYwVvnO6lQbmwskn0qMPnGpRpYshyDn9+V7EQOi4jnHO/F7wjr9WdX0u3UJpr
         niMKCEFlx5HgGqixtYcn4D2WxgFiidm3YqNI5aNjHiTP+wjGl0g67o6NQ7HB4jTRmWIS
         yiRQ==
X-Gm-Message-State: AOAM532baWGArSsl0Ldp7ziE0K+Xqr+w6ZXlfXgUrqkJ+S37kCMTXaWo
        KMot9uvLYDXogOhpmI6kkq/k9Vt0at5KR/u1
X-Google-Smtp-Source: ABdhPJwbnH52xi/ERlV6GWego/nEpa2MjQ8/DBbJC6TN5jVFIUBGfVgHcR5mqmhot6CWiJKznHebMQ==
X-Received: by 2002:a37:6403:: with SMTP id y3mr4011334qkb.204.1605123811505;
        Wed, 11 Nov 2020 11:43:31 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id o14sm3261897qto.16.2020.11.11.11.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:43:31 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:43:29 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 13/23] bitmap: add bitmap_diff_nonzero()
Message-ID: <3f25315cf7960dcdb33e56ce8ea083b4b9688f99.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The bitmap_diff_nonzero() checks if the 'self' bitmap contains any bits
that are not on in the 'other' bitmap.

Also, delete the declaration of bitmap_is_subset() as it is not used or
implemented.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 24 ++++++++++++++++++++++++
 ewah/ewok.h   |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index eb7e2539be..e2ebeac0e5 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -200,6 +200,30 @@ int bitmap_equals(struct bitmap *self, struct bitmap *other)
 	return 1;
 }
 
+int bitmap_diff_nonzero(struct bitmap *self, struct bitmap *other)
+{
+	struct bitmap *small;
+	size_t i;
+
+	if (self->word_alloc < other->word_alloc) {
+		small = self;
+	} else {
+		small = other;
+
+		for (i = other->word_alloc; i < self->word_alloc; i++) {
+			if (self->words[i] != 0)
+				return 1;
+		}
+	}
+
+	for (i = 0; i < small->word_alloc; i++) {
+		if ((self->words[i] & ~other->words[i]))
+			return 1;
+	}
+
+	return 0;
+}
+
 void bitmap_reset(struct bitmap *bitmap)
 {
 	memset(bitmap->words, 0x0, bitmap->word_alloc * sizeof(eword_t));
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 1fc555e672..156c71d06d 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -180,7 +180,7 @@ int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_reset(struct bitmap *self);
 void bitmap_free(struct bitmap *self);
 int bitmap_equals(struct bitmap *self, struct bitmap *other);
-int bitmap_is_subset(struct bitmap *self, struct bitmap *super);
+int bitmap_diff_nonzero(struct bitmap *self, struct bitmap *other);
 
 struct ewah_bitmap * bitmap_to_ewah(struct bitmap *bitmap);
 struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah);
-- 
2.29.2.156.gc03786897f

