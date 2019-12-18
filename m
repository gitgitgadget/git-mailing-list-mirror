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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70837C2D0C3
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E5E21582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNCCvPTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLRL0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:26:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38376 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLRL0W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:26:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so1881987wrh.5
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ZF7E9SDkzTDxY+2XMD91lyyqEH3cakGYfsZejGNZcg=;
        b=MNCCvPTSrRqqcymmanakYTzldGUeVryFqNhI3mEJTO0/Amk9k9bvFfYrybNYcGnDIx
         /3RwqIXCh3BeasE4+ADEf74UxykB2/cU4BYjcdF8hqsvO1AHgajZYj/CBLS4ykdc3zvL
         eKaBmJrbg+QnG0ujYSRNb60fnBJT/7Y/oMda4JReNd5fttnEyaiiwJiGLCtXe4GAwJKn
         RXrjv6p3YTKNp+ktQ24GWnuZmZzo4LBG9eU+O98IKnFp0JNI0tB9QJtebtc7T0syt5Ye
         0emsCdmISIUpsAQvjOOpB5dRXamCIbiKdN7ovy4FNx29DuAnJFSQ3i9/SAx7jPG2yJg4
         gVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ZF7E9SDkzTDxY+2XMD91lyyqEH3cakGYfsZejGNZcg=;
        b=W6fbpFFfYVhoI826na4dOSDNfK+bQMZ/9Vk9ZcDfa8wQ7IcUlQH3eMKzHBOX2xwo4U
         6NJyTjsfVvLJuo8UgbuPot04W0JLGgcxjIFzDzYmasWC3BABr9uY0AmZiOjztoHgE1B5
         NwIOu/pA7aw2kTm8zgOXDtLG0XQqnXJE2eRWmTRuu4D4HF2JmKsw1aeUbJgjZwSodimP
         jDHgZPq9hVNx6fM+hTKtINeSQVqheMUfTVzYM6+8LdmQfioqHxPAr/VSEuwAB4TxtQXC
         DhKBs4HuRIAynLBgvjhMORaYVAdGH9Mj+/zB/wijomtEBDFfAWKrF9aF9CRJ/vHEaxrm
         eohg==
X-Gm-Message-State: APjAAAWSs/VGL6cYWafbvNVwzOQuKCJznx/iip4E5Ups5xW36k1SbBe3
        96QhHVru980g4YiSNnSTE4Jv6lyA
X-Google-Smtp-Source: APXvYqydYYPMrqyGWjvcdvkEpUB9a6vF1J9ogpoMOfCTEMLgLjmqQYjbUszyaigoDeXwEFscSr+8GQ==
X-Received: by 2002:adf:f604:: with SMTP id t4mr2384095wrp.33.1576668379731;
        Wed, 18 Dec 2019 03:26:19 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:116b:f417:15eb:66f2:c98d:a463])
        by smtp.gmail.com with ESMTPSA id f127sm1204647wma.4.2019.12.18.03.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:26:19 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v4 12/12] pack-bitmap: don't rely on bitmap_git->reuse_objects
Date:   Wed, 18 Dec 2019 12:25:47 +0100
Message-Id: <20191218112547.4974-13-chriscool@tuxfamily.org>
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

We no longer compute bitmap_git->reuse_objects, so we
cannot rely on it anymore to terminate the loop early;
we have to iterate to the end.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pack-bitmap.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index a1d43d367a..5a8689cdf8 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -629,7 +629,7 @@ static void show_objects_for_type(
 	enum object_type object_type,
 	show_reachable_fn show_reach)
 {
-	size_t pos = 0, i = 0;
+	size_t i = 0;
 	uint32_t offset;
 
 	struct ewah_iterator it;
@@ -637,13 +637,15 @@ static void show_objects_for_type(
 
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
@@ -655,9 +657,6 @@ static void show_objects_for_type(
 
 			offset += ewah_bit_ctz64(word >> offset);
 
-			if (pos + offset < bitmap_git->reuse_objects)
-				continue;
-
 			entry = &bitmap_git->pack->revindex[pos + offset];
 			nth_packed_object_oid(&oid, bitmap_git->pack, entry->nr);
 
@@ -666,9 +665,6 @@ static void show_objects_for_type(
 
 			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, entry->offset);
 		}
-
-		pos += BITS_IN_EWORD;
-		i++;
 	}
 }
 
-- 
2.24.1.498.g561400140f

