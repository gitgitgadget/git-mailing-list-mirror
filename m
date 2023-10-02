Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B26BE748F8
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 16:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbjJBQzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbjJBQzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 12:55:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A11DA
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 09:55:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5345a3dfe3bso14351344a12.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 09:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696265733; x=1696870533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9nO8oWC472P5aBqV0C0wBRIcLVlNzXG1XN5nKL/aDE=;
        b=nf0vTtnneLWjLqeKhYI5XrxpE6iXeC0RErmfh/9sXQpAoA88aTPcBaUdAZ1lLh/cl3
         OroRmUeXKvTjuyDpffq/g0Q2IGcQo9Ln0rSCjlX07PJbmGpor6NjhFWsCxVVw5MA/Ft6
         yRo2i5N8I2pk5xeQPzzcx5Wj82vpJRlsAgBitDSUBenFtUvCyDx7yK4ZJkRhgR4O7OHr
         d5xdChIQZUsCUo9dBf1WCaEPkjW6H648BFaeqyUUEfxS202HafzRMHyLEfyw2zQLDbYr
         5JQM86D/xGXZptCBm4JAV0nFrJ0TDjkcU79IXKjfsgufHlEbJwMkNbBTnU/p+2XGlDjW
         Q+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265733; x=1696870533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9nO8oWC472P5aBqV0C0wBRIcLVlNzXG1XN5nKL/aDE=;
        b=o+PbJoPz90CV+ZC13VhojE/ww2whO3bdRROz9RCQbkq3VB3O0VgqGTz5JLYZXMDtfw
         7FAxuFgx84VeQaZO+dXAo9337gWVbS+YP8DMnUx3OlyAz5iMw5C2LQn7KzHAqPAwEYYw
         1lf13u4QZZ8ZxXpU1mKTqZ+H7RFJO3GgVmkJtLNgN/T8Gj/2eWgNWuurjmXWku5Gqv5S
         WPjCwS3VTJFclQrFzLsJ5ZBC/gGHlS3UNi/9f/kFynZVnWe2WlvljHKTLTLFOcDEzJ+z
         dliu3IXiGOniUXX+han7JyfG2hnCQ1smBitcgCmsrie3fP/pqVpuU/jQousvlB3sBbc+
         oJJQ==
X-Gm-Message-State: AOJu0YzMnt6qDmeoKL/b73O1rIcp5N8ApHV6J2IyLBDdF11+GuwlP0Dp
        P06V+8eHELhOKuh6/NeWYRxl5wIsOMsSDQ==
X-Google-Smtp-Source: AGHT+IFPRRKNdA3m+KzbMd+LYjtDRNSwttIH4DKCk5DWqvc7mBBhcLUkTIFxcFbjIxGXt/oC1z3+BA==
X-Received: by 2002:aa7:c746:0:b0:522:564d:6de with SMTP id c6-20020aa7c746000000b00522564d06demr12166221eds.36.1696265732973;
        Mon, 02 Oct 2023 09:55:32 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:c027:f1d4:d825:fbf4:9197:5c9f])
        by smtp.gmail.com with ESMTPSA id er15-20020a056402448f00b00533c844e337sm12762364edb.85.2023.10.02.09.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:55:32 -0700 (PDT)
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
Subject: [PATCH v8 5/9] pack-bitmap-write: rebuild using new bitmap when remapping
Date:   Mon,  2 Oct 2023 18:55:00 +0200
Message-ID: <20231002165504.1325153-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.305.g5bfd918c90
In-Reply-To: <20231002165504.1325153-1-christian.couder@gmail.com>
References: <20230925152517.803579-1-christian.couder@gmail.com>
 <20231002165504.1325153-1-christian.couder@gmail.com>
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
2.42.0.305.g5bfd918c90

