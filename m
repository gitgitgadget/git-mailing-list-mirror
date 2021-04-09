Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EFCC43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E528610CD
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhDISLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbhDISLt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:49 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0D7C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:11:36 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id 6so5439009ilt.9
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2bntr2nvQj0B9IO4AfZjCtG7ckldbI/jOp0eVzXWjCk=;
        b=pggiFvMcsvQQlY520UiP/lY5cwL5iAICQk9ZhN9xRWMkfw/Yr7hXfJVqPualMCqHbm
         GS3VxBzKhS29Z1k11EGqodY5HeZEQy8jf2FXAswxJMMktl1xnv6fftoOhf9Yf8yXNiiH
         UrhcQkPqPSmuDvRZzBMIAJtkOP6MShdobs2LYPOhdBnr6OnDyMdiVi5GLeC0Zt+hekbW
         +lhFNTCxW2HOVlm1wiL1Fv8qq9HlacVZpdpbH4t1auJpOl3jKOlyDp6A0AlNylr/bgTB
         oZMn72g5A83HUH7tk8/EPClB5oJo02EQOjebckbt+4g8HG1+P/iptOS/OQzD7MWlfRPz
         ThEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2bntr2nvQj0B9IO4AfZjCtG7ckldbI/jOp0eVzXWjCk=;
        b=kyZt0V6uzU5EbDjtjPC+tyel5NYMFfvMxlVdWNHl/pYDVWfhxylRjjxNERDmQ+rZij
         j+sRPkCuv0DygDgUdb/zZeQWG4jF0Ab2qAsjMV0z1pJFvjbV8cCnC0AqAEFe2aWX/Svg
         n+MaVDhwUeZ0jKXo4KlGxWqgwOMXvwEq9yg1GL+MLpFfzQ4nOLdMDoxDf15yGUGy/qtW
         X6Pj4J5LtxIu0VH6sDdzMgcDnF74NVQ7eGb5GWzFp1UQh/Xe4wx9BCd1JORY0kQVZNwH
         CHcenD2VqVKrzd1FHj1LUDuU09jV7LUvajtJwD7Q9UKvFLCJJuSE542j1px14WFj1BjS
         5iOg==
X-Gm-Message-State: AOAM530HzfY/RJdhweaFnqG8nZB2acAW5qg8EF24ZfoHY3yoURDsDfY5
        jxpd0SJa4ulhTw286AFxGf7aziC8N3Er+a31
X-Google-Smtp-Source: ABdhPJwckRNgBPorfVtfSCSM4WH61fOMGWVDPg+EaHfYv6RF/63qzee9CKSHv+NPqhopamNwm3/CDQ==
X-Received: by 2002:a05:6e02:1989:: with SMTP id g9mr12332420ilf.40.1617991895672;
        Fri, 09 Apr 2021 11:11:35 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id b4sm1579541iog.15.2021.04.09.11.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:11:35 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:11:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 10/22] pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
Message-ID: <a6fdf7234afda1b103342b13b17e026f15a7db9a.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch to support reading MIDX bitmaps will be less noisy
after extracting a generic function to fetch the nth OID contained in
the bitmap.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index a6c616aa3e..97ee2d331d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -223,6 +223,13 @@ static inline uint8_t read_u8(const unsigned char *buffer, size_t *pos)
 
 #define MAX_XOR_OFFSET 160
 
+static void nth_bitmap_object_oid(struct bitmap_index *index,
+				  struct object_id *oid,
+				  uint32_t n)
+{
+	nth_packed_object_id(oid, index->pack, n);
+}
+
 static int load_bitmap_entries_v1(struct bitmap_index *index)
 {
 	uint32_t i;
@@ -242,9 +249,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		xor_offset = read_u8(index->map, &index->map_pos);
 		flags = read_u8(index->map, &index->map_pos);
 
-		if (nth_packed_object_id(&oid, index->pack, commit_idx_pos) < 0)
-			return error("corrupt ewah bitmap: commit index %u out of range",
-				     (unsigned)commit_idx_pos);
+		nth_bitmap_object_oid(index, &oid, commit_idx_pos);
 
 		bitmap = read_bitmap_1(index);
 		if (!bitmap)
@@ -844,8 +849,8 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 		off_t ofs = pack_pos_to_offset(pack, pos);
 		if (packed_object_info(the_repository, pack, ofs, &oi) < 0) {
 			struct object_id oid;
-			nth_packed_object_id(&oid, pack,
-					     pack_pos_to_index(pack, pos));
+			nth_bitmap_object_oid(bitmap_git, &oid,
+					      pack_pos_to_index(pack, pos));
 			die(_("unable to get size of %s"), oid_to_hex(&oid));
 		}
 	} else {
-- 
2.31.1.163.ga65ce7f831

