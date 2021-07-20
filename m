Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C567BC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86B061009
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbhGTUCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhGTTfr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:35:47 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CEEC061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:16:23 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id g22so25440278iom.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xM9w1qXwORXJQvlhOLyU4labOqla6vwHNq+DI1Ab6Jw=;
        b=ZtXqOBKHVGQU+P3ub15IJCnISu6PzrDsC3qHBsBSUf2RAcBgWVXv57+G4sdMUTgyY8
         uuHRvtNL32XZ0rRU8uZ/vbsI6VJaHEk9ltf1s2sphb57dPsGMm09ooHXF21WPEmnZkV+
         TeHqS7g7XFR+KHhKK8Vbxz6ivteTOjZh4y+UfW6XVtmG+G6wpe33CrCdjcj3CiANZ7CS
         qLE4Ssebkvx7Olp/dcsDoiNJExh6IhTW6A9q5L8GC/mLFnmEYJT6vKuLKIJWyRRO6kJ0
         bjva4VmxTEso4Lb5wds05BhjzaP9YQtkMrA50G+k5vS3q4R2IGvr7ObQbcWoiMjuZio/
         Q/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xM9w1qXwORXJQvlhOLyU4labOqla6vwHNq+DI1Ab6Jw=;
        b=ElmGXgDfZIJZr3gSoXDkf4O+GqW88eZo/pTZ7fxj3DcEh48gmlEeIbBQzAXiLD5lN5
         wR5GuvQNhZa7RrmFsNt7E6ouHYxRdkntEotlXZOMw2n4kOk3j98CPC22dbSvNc3cBCOt
         g3jyobi6YZvwbcwbEHUDDQAgF+h5BZy0oNO1+yvk18RUSk/YXK1huym/+Ru0X76YN+tu
         D2Uuz++F3AwX9q/g6EtOfqBjWyxys2xWzS+mMiDmrRzKU45ReqVxPwH6QLYNCvh/a2Ju
         X0tX6q94DhldV2okKW35UdbasUgDlYnM3M+7JrOCf+BJsH0B89hJ1a0X5auK2Zdqq6O4
         kGpg==
X-Gm-Message-State: AOAM530BfRgnTY/d7ktrk7pMOvc3tY0a5lAAk2j9AtCkny2UUMEQ5T6B
        GCn0tEgZhQSP4Bd2GULM0Md5t6aci+h1V9pB
X-Google-Smtp-Source: ABdhPJzAlk8S4RvRbw4M2MxxKtAxTw6aX002lgOpjwTw3kootlyg/PxJnxskIP376Vm37AljSXvJog==
X-Received: by 2002:a6b:c90f:: with SMTP id z15mr23480618iof.183.1626812183114;
        Tue, 20 Jul 2021 13:16:23 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:9f71:89c7:e095:b8eb])
        by smtp.gmail.com with ESMTPSA id t3sm11887822ilm.87.2021.07.20.13.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:16:22 -0700 (PDT)
Date:   Tue, 20 Jul 2021 16:16:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net
Subject: [PATCH] pack-bitmap: clarify comment in filter_bitmap_exclude_type()
Message-ID: <0d52628985bf4f499e0d5622ea40cdf499e73ebe.1626812121.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code that eventually became filter_bitmap_exclude_type() was
originally introduced in 4f3bd5606a (pack-bitmap: implement BLOB_NONE
filtering, 2020-02-14) to accelerate BLOB_NONE filters with bitmaps.

In 856e12c18a (pack-bitmap.c: make object filtering functions generic,
2020-05-04), it became filter_bitmap_exclude_type(). But not all of the
comments were updated to be agnostic to the provided type.

Remove the remaining comments which should have been updated in
856e12c18a to reflect the type-agnostic nature of the function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Noticed while I was reading some code in this area to see if we had
accelerated the relatively new type filters. This trivial fix hopefully
shouldn't produce conflicts with other in-flight bitmap series.

 pack-bitmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index bfc10148f5..c8cb9ef13b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -809,8 +809,9 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	tips = find_tip_objects(bitmap_git, tip_objects, type);

 	/*
-	 * We can use the blob type-bitmap to work in whole words
-	 * for the objects that are actually in the bitmapped packfile.
+	 * We can use the type-level bitmap for 'type' to work in whole
+	 * words for the objects that are actually in the bitmapped
+	 * packfile.
 	 */
 	for (i = 0, init_type_iterator(&it, bitmap_git, type);
 	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
@@ -821,9 +822,9 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	}

 	/*
-	 * Clear any blobs that weren't in the packfile (and so would not have
-	 * been caught by the loop above. We'll have to check them
-	 * individually.
+	 * Clear any objects that weren't in the packfile (and so would
+	 * not have been caught by the loop above. We'll have to check
+	 * them individually.
 	 */
 	for (i = 0; i < eindex->count; i++) {
 		uint32_t pos = i + bitmap_git->pack->num_objects;
--
2.31.1.163.ga65ce7f831
