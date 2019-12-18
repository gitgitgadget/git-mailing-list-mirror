Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD328C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31D021D7D
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMn4MUXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLRL0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:26:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39211 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfLRL0L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:26:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so1353604wmj.4
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eg0SAYG3hzVkghScUnwSMvJzjm05LrtCowdPWgs7dro=;
        b=kMn4MUXGyiyQ88j+JulZRFGFr+Qa0w63TFGSY6qCh5AiLve7AqvqsIELXplCiOd4Ey
         c4qjhtbWrgnbzXCjr5/KU43tWSrx25eR5FcKMwTqyYUMWTxoJmw5DP68O0EtX+hocBOk
         NTg+DXCeI6FoJpnn5SlkVk/2MisCBu0m+rvZqX68LR37sMBxRESVichnhyC+kQXbKScY
         tMY6WYZhqiM25iczoeus29JbiuRXsaqs/egsagg73W3Pk2Uva26GufIh5lIkQuymCLHX
         QbisAXKOcpxNbzrTbLii8MoeZJbefNL84Eirfnl0SAgL1ioxSWaxC7y7usE58yQGWYp+
         NFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eg0SAYG3hzVkghScUnwSMvJzjm05LrtCowdPWgs7dro=;
        b=q1BqJ5b6oCZdmcbp79zmfTjNdHFc7CcL/2isiuJn15Z7gDszh+k3TMXhNHPQpbt4Q7
         IXaCIJx1pupZxQWkVSFtUo79kC6408LlX4LtVaKatfFi1KJq7fw0OlCjGvMcEYXWHniS
         odjPvTmoQ+gPq6WPkg5+dvg2Hv6v96mSPdMyZ67TJs2iKF27OzygazMrD3sEolQ95FFV
         ZgDY82qUu5GDixiyhGJIb/gi+qbbGfLHg/LfAHKoRVNIgkOq/09Bhv/jWslrNhvHR+sz
         41yuYBmfp70L14+6eIDGpOBCGOweDmE/RhjCF/FUhkk0k05sjHlxPgROiNOLghkdU+oY
         KPiA==
X-Gm-Message-State: APjAAAXusDh4VJSOSEN/CWygnqbbuYOdLSNsEHwDyaomj+eN7ExQ4mWG
        dI1XjMLSOSaNjVdgaxIf6+3kx5zY
X-Google-Smtp-Source: APXvYqypzMYtjqhX4GKvMVC5Ck7wzjzhwzrwSFByiL8ILiY0QxTgQlhfbpk0aH9SugyiWgMKzQFtVQ==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr2579658wmb.73.1576668369706;
        Wed, 18 Dec 2019 03:26:09 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:116b:f417:15eb:66f2:c98d:a463])
        by smtp.gmail.com with ESMTPSA id f127sm1204647wma.4.2019.12.18.03.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:26:09 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v4 03/12] ewah/bitmap: introduce bitmap_word_alloc()
Date:   Wed, 18 Dec 2019 12:25:38 +0100
Message-Id: <20191218112547.4974-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.1.498.g561400140f
In-Reply-To: <20191218112547.4974-1-chriscool@tuxfamily.org>
References: <20191218112547.4974-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In a following commit we will need to allocate a variable
number of bitmap words, instead of always 32, so let's add
bitmap_word_alloc() for this purpose.

Note that we have to adjust the block growth in bitmap_set(),
since a caller could now use an initial size of "0" (we don't
plan to do that, but it doesn't hurt to be defensive).

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 ewah/bitmap.c | 13 +++++++++----
 ewah/ewok.h   |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 52f1178db4..b5fed9621f 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -22,21 +22,26 @@
 #define EWAH_MASK(x) ((eword_t)1 << (x % BITS_IN_EWORD))
 #define EWAH_BLOCK(x) (x / BITS_IN_EWORD)
 
-struct bitmap *bitmap_new(void)
+struct bitmap *bitmap_word_alloc(size_t word_alloc)
 {
 	struct bitmap *bitmap = xmalloc(sizeof(struct bitmap));
-	bitmap->words = xcalloc(32, sizeof(eword_t));
-	bitmap->word_alloc = 32;
+	bitmap->words = xcalloc(word_alloc, sizeof(eword_t));
+	bitmap->word_alloc = word_alloc;
 	return bitmap;
 }
 
+struct bitmap *bitmap_new(void)
+{
+	return bitmap_word_alloc(32);
+}
+
 void bitmap_set(struct bitmap *self, size_t pos)
 {
 	size_t block = EWAH_BLOCK(pos);
 
 	if (block >= self->word_alloc) {
 		size_t old_size = self->word_alloc;
-		self->word_alloc = block * 2;
+		self->word_alloc = block ? block * 2 : 1;
 		REALLOC_ARRAY(self->words, self->word_alloc);
 		memset(self->words + old_size, 0x0,
 			(self->word_alloc - old_size) * sizeof(eword_t));
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 84b2a29faa..1b98b57c8b 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -172,6 +172,7 @@ struct bitmap {
 };
 
 struct bitmap *bitmap_new(void);
+struct bitmap *bitmap_word_alloc(size_t word_alloc);
 void bitmap_set(struct bitmap *self, size_t pos);
 int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_reset(struct bitmap *self);
-- 
2.24.1.498.g561400140f

