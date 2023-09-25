Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA53CE7A81
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 15:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjIYP0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjIYPZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 11:25:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37B2197
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ad8a822508so821727066b.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695655547; x=1696260347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtoxgzyRi6IOP6IK0MX8kYV1/sFhqo8Ox2PkAkhPk/I=;
        b=mhxQB8xM3+iTnGuSngThmMRXCTbKqbFLtvQZ/85QxqmoeZ7te9gBUnXRQhSgaP1K08
         AeeB6vwAcA/AIgZOcOo6/xomjO46cBjkBjLO17Lm0s8vBB9IKBGbcDPy4kI6RrJWVo4z
         suJgug+psGoXKUG7alrrkq2STWMfPjP/BqkiFOqr/qv0wrYvipTEWOY9l3FdJvaYSChS
         RwURAHxIwXIxTQHDQY3Im10Oeysnz0/MePt6DK52bQyxur7Trg3kyG15fDCAk0jv7UDN
         p5Z4OOksC7MZGCCXivFtH7CQxFpAqfxVYjFPLi6ujgnC4aMo5D7B/sLGkfEaGbLLQvGC
         181g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655547; x=1696260347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtoxgzyRi6IOP6IK0MX8kYV1/sFhqo8Ox2PkAkhPk/I=;
        b=aFGOAhGdsiDigGZtVM8PLaJcdMA4Y66H7qxYCX8yjdA4Ydhc57HWaODIASu91NIXAl
         CZ3H3W6elIwF+8hePRm+avPe7E30iLeyH3ke7ucKGMUDnpXpbNAUP+ykKaRc3zSzXQj9
         ISmnMUEWIOdtzovcvyOIM4ZqmxJ6BxUzlepFdg2AihdeRXchl+WUI5nvTDJgli3Ttshs
         FTYauZaU4zik0uhdAPYjW62m1n0IpjrMni3sHAJ9DYG9IiGqPOQTAJybGzKH0Hxix+Ru
         N+J2WsiCL4s+2vIgSN+bG53p9d1Paln7zF1tJW4iapPRrnvam+W8MupN6vRZmCH0XyEw
         ZL8w==
X-Gm-Message-State: AOJu0Yy7wf8CaYRVFi0jTmqKj4jvzTGEMHCvkdiNnoLvC2eE7GSWgIpf
        bj+eT9u9PNcNI6UO/tpouc3R/cNzSp4eAw==
X-Google-Smtp-Source: AGHT+IGrHagBM08VFyrATDBngeueWBpIjFaTg36ZQuCiuaxDCKcAjM7z2zDI7e3LabPX+xD7sJ8HWQ==
X-Received: by 2002:a17:906:51dd:b0:9ae:62ec:f4a1 with SMTP id v29-20020a17090651dd00b009ae62ecf4a1mr5809295ejk.33.1695655546724;
        Mon, 25 Sep 2023 08:25:46 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:105a:e25e:7421:a01e:ee4a:ba03])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090624c100b009ae3e6c342asm6432045ejb.111.2023.09.25.08.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:25:45 -0700 (PDT)
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
Subject: [PATCH v7 5/9] pack-bitmap-write: rebuild using new bitmap when remapping
Date:   Mon, 25 Sep 2023 17:25:13 +0200
Message-ID: <20230925152517.803579-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.279.g57b2ba444c
In-Reply-To: <20230925152517.803579-1-christian.couder@gmail.com>
References: <20230911150618.129737-1-christian.couder@gmail.com>
 <20230925152517.803579-1-christian.couder@gmail.com>
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
2.42.0.279.g57b2ba444c

