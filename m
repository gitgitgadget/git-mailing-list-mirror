Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF09C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352370AbiCaBsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352369AbiCaBsC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:48:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A15488B1
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h23so31611503wrb.8
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQW3QfPgbIAzIzL+E9E9pZLdi6wjtQWvS/KZg8c91Pg=;
        b=GvVlGe/zhJGeOnfgiCuBapOgjlq/AYQnDftRhXKMI6F1y5zGNRAZReRLa5c2xeyYZd
         RNr/eyhRj98hadlf2JUnLhSniwKE+poWC6zsbf/QROvpFnEJIldA9HZPx0Rl43NRArVz
         GzhitZY/obrFpcgFJkw/o57TyPmMzqlJsuMQxoH3PSY8aSZ98sa2+NIjHO1qy2f8v7wy
         tceUO1MlmGnnYvL1iyKJRVTBgKzBfrtKxmwPTJpqW3rIT8l1+1bvWzxjEKEMDx1ooJPC
         E1MIuta91xv7hQ4Q6BBcJlYL4buWXsFxwvBibEZCdzVny/0DnQ6H9ObBX4DjP0dNVrDd
         +VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQW3QfPgbIAzIzL+E9E9pZLdi6wjtQWvS/KZg8c91Pg=;
        b=RDB8WuFya82JmybQ2lLnfJZgw3ulNdkVGvB5GIWS/LaroXi9qZeafAVeiBDCzeYRNg
         Knv8ge+VhAeqQkIeRc61Pwb+Ktr2KXcEpyP43eeGAQimGnV6EveZX9maTKkyopkW5E0o
         brJtZzJXdG7+ceMnDHaSKIGC4hKpThw0hEccKBG5lh92INbXtdUSTpjB/9uSt6w+yvtK
         aXbXVgWxPO7pNX0AJy+GwKpPZKzCfZJhurPtK1DmQVzcKQ74NprSqnc8ZtorP81TTVkQ
         I6EcfHqfNTXmbl6GaY1AUaUOc/SfDSYFoeYf8NIXXN7AJOftdbWonajFyOA0CozJM4kU
         qZzQ==
X-Gm-Message-State: AOAM532B1quSj6+VmijmUlOdaVHMHfp7w1NriD3sh/JGqpH2ZKcNIYAk
        oslwbQ/YfknuC8zLUKZLYwY+ebB+oEoQoQ==
X-Google-Smtp-Source: ABdhPJzjy5T0y7s1JsfYRIXIYyYBz4sjffgtMBz0SpsL5QhOh/qSo6carAf5q6nukp+GgcQUTMfebQ==
X-Received: by 2002:a05:6000:1:b0:205:e7cd:2a5 with SMTP id h1-20020a056000000100b00205e7cd02a5mr709750wrx.485.1648691173500;
        Wed, 30 Mar 2022 18:46:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600018af00b002057c72d45fsm23603272wri.77.2022.03.30.18.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:46:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/6] pack-bitmap-write: remove unused bitmap_reset() function
Date:   Thu, 31 Mar 2022 03:45:53 +0200
Message-Id: <patch-v4-4.6-a9b71c281c2-20220331T014349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1561.ge8eddc63765
In-Reply-To: <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function hasn't been used since 449fa5ee069 (pack-bitmap-write:
ignore BITMAP_FLAG_REUSE, 2020-12-08), which was a cleanup commit
intending to get rid of the code around the reusing of bitmaps.

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
2.35.1.1561.ge8eddc63765

