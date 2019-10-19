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
	by dcvr.yhbt.net (Postfix) with ESMTP id A8B3E1F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 10:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfJSKf5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 06:35:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44257 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfJSKf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 06:35:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so8723862wrl.11
        for <git@vger.kernel.org>; Sat, 19 Oct 2019 03:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mZD6CHAoeLktNUBmB4u3H0zNOFeqE0gRxk0+vJ91mGM=;
        b=cF/VkOBPW3wohjWbXwJL9ebyEXaEp6kCzaP9aql5t8Eb7HxW02nnUC6kOVA6F4hr0d
         zUnO3S0PDIJuEepfDohpTO4BM7hKNiU3N2huyiyA3eyXRfzYP+XJKV4maotQX2IUUwOm
         4BFW2bm6QG1/sUwfE7ZHYn4bCr+ghT6OsauxuNjnVKMugVecv6XDtHSACez+zBWhoqtB
         3o5eeBl83QQL1s+3oP3eV1as3bwlkrlUxAGqIBzmdoW+5TXb2PdJkdQ1EdYezvMaAKxL
         ou1pWdxpo3mh3yIsvWyRWfhJeFepUqiP0RpwS/PKPt2kbXEa+RM9c2zXRZL7U8FkdHAU
         rCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZD6CHAoeLktNUBmB4u3H0zNOFeqE0gRxk0+vJ91mGM=;
        b=ICpywrE2+oEZqj7w8NJmy/5hLjpI2la1VXwdLjTeo9XFtwUGH82Syua7KmB2pRjF+S
         24oe4d1xHfxoCMdj3HF9hP177Xtfw/aPbLDyRWTegn7+Rkm32cVH61svHVJ/2EdUPHF0
         gPlzsM1rf8o2z50UpOhJDWONz4/n9tcQ7MLzyZbOx26BZbLXydnVW/65k3cl95OfLU8E
         dJH0KzwznsnQXf4EPkcpkyKjiPO1M69qOWieBQkH2mlYxPduKFwwCNH20zA3LPGGUgjb
         MC7ROBoFgbq9ZMCOdUhyvXCvlj/UMFjavXHequx2ivQ6beFkaNlgEsyEKUwumzzYD0v3
         8jWw==
X-Gm-Message-State: APjAAAVAAOWdls3lrayHzNoKVLe8LTV1uA1Vdn9UW4LgUim4L6pi9Ck3
        T4mMcU4MqrKm1taT/UAJrdG8R8gVojI2cg==
X-Google-Smtp-Source: APXvYqwtzJekCAdiTzH6/sr975hBHCgt6zegEUs8dRnH+IyVT2cDtr2OrK4YHoBtVr6V11mLtbHewA==
X-Received: by 2002:adf:8481:: with SMTP id 1mr1687696wrg.189.1571481355007;
        Sat, 19 Oct 2019 03:35:55 -0700 (PDT)
Received: from localhost.localdomain ([80.214.68.206])
        by smtp.gmail.com with ESMTPSA id p68sm6383086wme.0.2019.10.19.03.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 03:35:54 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 4/9] pack-bitmap: don't rely on bitmap_git->reuse_objects
Date:   Sat, 19 Oct 2019 12:35:26 +0200
Message-Id: <20191019103531.23274-5-chriscool@tuxfamily.org>
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

We will no longer compute bitmap_git->reuse_objects in a
following commit, so we cannot rely on it anymore to
terminate the loop early; we have to iterate to the end.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pack-bitmap.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e07c798879..016d0319fc 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -622,7 +622,7 @@ static void show_objects_for_type(
 	enum object_type object_type,
 	show_reachable_fn show_reach)
 {
-	size_t pos = 0, i = 0;
+	size_t i = 0;
 	uint32_t offset;
 
 	struct ewah_iterator it;
@@ -630,13 +630,15 @@ static void show_objects_for_type(
 
 	struct bitmap *objects = bitmap_git->result;
 
-	if (bitmap_git->reuse_objects == bitmap_git->pack->num_objects)
-		return;
-
 	ewah_iterator_init(&it, type_filter);
 
-	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
+	for (i = 0; i < objects->word_alloc &&
+			ewah_iterator_next(&filter, &it); i++) {
 		eword_t word = objects->words[i] & filter;
+		size_t pos = (i * BITS_IN_EWORD);
+
+		if (!word)
+			continue;
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
 			struct object_id oid;
@@ -648,9 +650,6 @@ static void show_objects_for_type(
 
 			offset += ewah_bit_ctz64(word >> offset);
 
-			if (pos + offset < bitmap_git->reuse_objects)
-				continue;
-
 			entry = &bitmap_git->pack->revindex[pos + offset];
 			nth_packed_object_oid(&oid, bitmap_git->pack, entry->nr);
 
@@ -659,9 +658,6 @@ static void show_objects_for_type(
 
 			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, entry->offset);
 		}
-
-		pos += BITS_IN_EWORD;
-		i++;
 	}
 }
 
-- 
2.24.0.rc0.9.gef620577e2

