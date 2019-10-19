Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 939BA1F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 10:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfJSKf4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 06:35:56 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36723 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfJSKfz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 06:35:55 -0400
Received: by mail-wr1-f49.google.com with SMTP id w18so8185670wrt.3
        for <git@vger.kernel.org>; Sat, 19 Oct 2019 03:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6VTcwaoI1go6JkzckWqozzEySf/t0UZ7pe3UqqHDKsI=;
        b=mJHJeU1UXfB/Qi9FQrsu3mcVuC+rdUn4ueYnTts6CUNyyeK3Y5obXI7NRRip/yonx3
         +6f9dywy89k9eDHHeyM4j9Rb45hj/IYZxnXbmyrhbiSYMCN/+Nxti2fxWyjwFftAUWUk
         6UzBrWrtNEqMjPut/wOJQRzE0GV+piytSn07UxuBa1GNtWEP/E6UO+nZw7LdO1qVIiB9
         H5TonE7Hb5EI406YYwQL8hPymn4AgyxMERpbNsoYMQsgM4StzUD+IJGmBDuGwqrvQVPW
         rabf0XDFwg0FxoxGTwY7Bale2ZsRYAxMAPoDZH5slPTj60c5PmAoetYusk9PExTZbRFM
         Ozhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6VTcwaoI1go6JkzckWqozzEySf/t0UZ7pe3UqqHDKsI=;
        b=m8ywbQXH4y/EEfLo68Qlr5o6JSEqdnWIth+H7FQWuSjhQNMxjnEf0YU8tugN79ow7T
         XBMsNcaGbSRhwrGADlUUb/3Qmya9hjcliQnYBWalABNlKqZOoCRL/b4j+T92hdBQoXN3
         8/B85YwowZpFjl3nDjr0DCZ7ccXNYiRSfekYjseFko1h1kPmlKyxzTjAVDkLvofWx5dx
         NrpyPcvReiXnCnesPbAKC4/lNy/Ai3wyTi0FSe4YAD0+wEAh8zNUj5LMzRRDwu7A6jgm
         72u8D44O7aFq+pvTKbUMXqpA+fYjSlYjkAxZgYMiofPIGTk41PJRYxRrzVi+bzSiPS5p
         7Xxg==
X-Gm-Message-State: APjAAAVmlZ/CsiHhuYSJPHaNKacCQY1cAs7oDg5COh/GWK6epKIlaVq/
        PoHB7igRBUThOc0oZetdGdRK8OqssEp90A==
X-Google-Smtp-Source: APXvYqwuTZnVAhf8GvFrXo1S2+SFu1FSB5hF4iuOaFljwi4e+L3zFMQJ+zdRiM7MteMpgQUNKkV4ig==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr11828205wrn.334.1571481353614;
        Sat, 19 Oct 2019 03:35:53 -0700 (PDT)
Received: from localhost.localdomain ([80.214.68.206])
        by smtp.gmail.com with ESMTPSA id p68sm6383086wme.0.2019.10.19.03.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 03:35:53 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 3/9] ewah/bitmap: introduce bitmap_word_alloc()
Date:   Sat, 19 Oct 2019 12:35:25 +0200
Message-Id: <20191019103531.23274-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0.rc0.9.gef620577e2
In-Reply-To: <20191019103531.23274-1-chriscool@tuxfamily.org>
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
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

We will also always access at least one word for each bitmap,
so we want to make sure that at least one is always
allocated.

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
2.24.0.rc0.9.gef620577e2

