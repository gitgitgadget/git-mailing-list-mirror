Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90947C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C0061AD0
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhKSMti (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 07:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbhKSMth (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 07:49:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88393C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t30so17915304wra.10
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZSoM3d7EkFywymygC17U5d9eyKUqxAtOEtkTU2Pp94=;
        b=Psq7iYCXJI03yQd25ZwQ7yIZMbUuA9x0ESnBy1zittDdeIFAdZcZ3yGz5XdNo8zzW+
         S4cVNx4itKBqwfYsyFpuZmKt2g5/OJGKcsuYP4QKJKb8tyE0w612F8Z8s6ACwsZzNMaq
         r4BEEuKdONj4MCnrYJwA+HhXAAbRE2oV2VE/iYhux+4B4FaTxJRzi38jBrwDCPIaHv1B
         863RF9r5Y1+0LopeVtjZKCYuzhYHPIb2xHIMpmqi0kwJHC7lRz3wKahjujzUTQlPv+fX
         2JDl/WtU4TQlp/bd2z/HedX8TYmDeDUOMuQE295gU5j4FjQg2d6EkM2AavObDtqbYRT6
         0YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZSoM3d7EkFywymygC17U5d9eyKUqxAtOEtkTU2Pp94=;
        b=3vH18JpLtLlVyKJAgTNUEr88RcEWyRaHQPmLLcuJaH0N0cOh7arsHvmvrclFJplFlI
         mBKDtxb5SKjTd4RHyB4CZdm7kHXo9F+55F/1EEq1zDgGo0qcONhyD5M77aGbQfYrkiN5
         IhghRAU40RgvuSUe8PgwFLywszyUOBFEzHoh0JV1UzCSNwXHFPAfXFe26LZeStWIOBcY
         2/a1mmjc9uRrxlhwICivdigLJ3XpfUxJBbKL7vCLSUsBimICZWqhq9WHtm3ESTpAf+Hg
         HNIM2WKR8J5/BlOR5Qi2gwdBc98q9D1n6/JqHb/LDhfBmvAF7iBjRtXeO7FIfHT3L35x
         8+3Q==
X-Gm-Message-State: AOAM531uuXJ4AbPjAeNpH+Z9xKAZ61G0EN2xq8BqB8B3n7YWo5oRJ7Mp
        kHPW83sZZBe5ilzdjgCVpg4wjZDfa33Agw==
X-Google-Smtp-Source: ABdhPJxHXeoTTWMRb8fOtqx5w6/AKw54F6DTcCiPsQML8/P6+uRVLS9rxnVx/tbAXHKyHGw6Pmxtyg==
X-Received: by 2002:adf:f448:: with SMTP id f8mr7316800wrp.47.1637325993804;
        Fri, 19 Nov 2021 04:46:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm2857567wru.51.2021.11.19.04.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:46:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] pack-bitmap-write: remove unused bitmap_reset() function
Date:   Fri, 19 Nov 2021 13:46:22 +0100
Message-Id: <patch-2.6-826027d2cd5-20211119T124420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.817.gb03b3d32691
In-Reply-To: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function hasn't been used since 449fa5ee069 (pack-bitmap-write:
ignore BITMAP_FLAG_REUSE, 2020-12-08), which was a cleanup commit
intending to get rid of the code around the resetting of bitmaps.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ewah/bitmap.c | 5 -----
 ewah/ewok.h   | 1 -
 2 files changed, 6 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 38a47c44db4..87d5cc8fa30 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -216,11 +216,6 @@ int bitmap_is_subset(struct bitmap *self, struct bitmap *other)
 	return 0;
 }
 
-void bitmap_reset(struct bitmap *bitmap)
-{
-	memset(bitmap->words, 0x0, bitmap->word_alloc * sizeof(eword_t));
-}
-
 void bitmap_free(struct bitmap *bitmap)
 {
 	if (bitmap == NULL)
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 66920965da1..7eb8b9b6301 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -177,7 +177,6 @@ struct bitmap *bitmap_dup(const struct bitmap *src);
 void bitmap_set(struct bitmap *self, size_t pos);
 void bitmap_unset(struct bitmap *self, size_t pos);
 int bitmap_get(struct bitmap *self, size_t pos);
-void bitmap_reset(struct bitmap *self);
 void bitmap_free(struct bitmap *self);
 int bitmap_equals(struct bitmap *self, struct bitmap *other);
 int bitmap_is_subset(struct bitmap *self, struct bitmap *other);
-- 
2.34.0.817.gb03b3d32691

