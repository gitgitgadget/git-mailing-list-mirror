Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A4CA0EC1
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349027AbjIKVcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241344AbjIKPHA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 11:07:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12438FA
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977e0fbd742so571126966b.2
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694444814; x=1695049614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYQf19dEwr1XOSB/au9CiCd6QyIYuCowppjcB77lfls=;
        b=fBRWrZXnPX3ixxTQVGocr4jnGvbkBifhqhTgd4M7ZjtjEHjgbzBMsO8Y7DHG8/XLMG
         94RX5z7J7ZUoTEexiPxqcHHT+kzWbpq1LD6IcCSpofJHreHwniuRSUkgac33dieMMx+4
         5bdMQTJoaHgl5tYOHE/7ERyi/FGlHYTEYOiZOCTcbsdX3PuuFb7uoKcRSq5gSDl/feAy
         WVAVQl3oE6NpCH55JEH4/bn9EeT0v6uZDdWAnZ/suppvj5o8hwU/hRYTtlYkgpMtAY7z
         8DXIQ5IBxxsRA0YXbyk3Xynihf2jX2l1uoOMhA7xalLBkghk+I1X/XDnR0hwjNUYwswl
         y44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444814; x=1695049614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYQf19dEwr1XOSB/au9CiCd6QyIYuCowppjcB77lfls=;
        b=FvxBqcsonn/XyO5dOYkHhs7bOEaMrJSfyVXdbHxXAPpPwCuxbVCRGBhR40F3mjwMPD
         kY/sVvLLDspKZWvmThSGh52IGkwewUgGZHdfnxBUoqFxfxyPz0fYLrRkVIA2UEPBBNGR
         OOI3Z1W6BP16zaLswjP4FLFg9HAoon0QTDEbOBK3mOBje3OYeoN4LjiRNkjfvo75H5ks
         WWC8vfsQLvbdtThmd5d3HxBVR1ILHrtODN11dDJA1fpmnTIPOCvUW/0XvfeM5nE3yJ3V
         jAhZRVjAewyQ8slgFjjqFS2n10B7P2JKgYGPzS8awoG8Q3hA+OjNMAdYGkRPIfV/Y5Vq
         l+fw==
X-Gm-Message-State: AOJu0YwK1EefbWEaNjTaQcIzQJNEbRS8av3nR0eb2JlKnwEHcz+A+Oqd
        s2Q25mmRZx2p7ln9HP3KYizQSuOnvUc=
X-Google-Smtp-Source: AGHT+IGiWExqtsuKTdhPu7dcsQoVl4/qbXzpE0rMwG/+nJlCyq42hQF0s4kFOBoecPi3oBXsJME7mQ==
X-Received: by 2002:a17:907:2cd2:b0:9a5:b8c1:2ce1 with SMTP id hg18-20020a1709072cd200b009a5b8c12ce1mr7933026ejc.31.1694444813981;
        Mon, 11 Sep 2023 08:06:53 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1085:31e2:f2be:e47a:b382:4542])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906138500b0099cb1a2cab0sm5485617ejc.28.2023.09.11.08.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:06:53 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 5/9] pack-bitmap-write: rebuild using new bitmap when remapping
Date:   Mon, 11 Sep 2023 17:06:14 +0200
Message-ID: <20230911150618.129737-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.167.gd6ff314189
In-Reply-To: <20230911150618.129737-1-christian.couder@gmail.com>
References: <20230812000011.1227371-1-christian.couder@gmail.com>
 <20230911150618.129737-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git repack` is about to learn a new `--filter=<filter-spec>` option and
we will want to check that this option is incompatible with
`--write-bitmap-index`.

Unfortunately it appears that a test like:

test_expect_success '--filter fails with --write-bitmap-index' '
       test_must_fail \
               env GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
               git -C bare.git repack -a -d --write-bitmap-index --filter=blob:none
'

sometimes fail because when rebuilding bitmaps, it appears that we are
reusing existing bitmap information. So instead of detecting that some
objects are missing and erroring out as it should, the
`git repack --write-bitmap-index --filter=...` command succeeds.

Let's fix that by making sure we rebuild bitmaps using new bitmaps
instead of existing ones.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pack-bitmap-write.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index f6757c3cbf..f4ecdf8b0e 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -413,15 +413,19 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 
 		if (old_bitmap && mapping) {
 			struct ewah_bitmap *old = bitmap_for_commit(old_bitmap, c);
+			struct bitmap *remapped = bitmap_new();
 			/*
 			 * If this commit has an old bitmap, then translate that
 			 * bitmap and add its bits to this one. No need to walk
 			 * parents or the tree for this commit.
 			 */
-			if (old && !rebuild_bitmap(mapping, old, ent->bitmap)) {
+			if (old && !rebuild_bitmap(mapping, old, remapped)) {
+				bitmap_or(ent->bitmap, remapped);
+				bitmap_free(remapped);
 				reused_bitmaps_nr++;
 				continue;
 			}
+			bitmap_free(remapped);
 		}
 
 		/*
-- 
2.42.0.167.gd6ff314189

