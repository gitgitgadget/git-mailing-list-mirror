Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C764C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06EC23442
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbhANCF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbhAMWZm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:25:42 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5099C0617A5
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:59 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id l7so1565868qvt.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GosB9Yjgb0Kn5JVNBnzEWD9cZazhce4gUyaHBUupnbg=;
        b=QrvlDMnXOl+m+xX01Mq+NhkjTzQIwfofj3rJYFLsK65rF1inEnlG31riilYNOVjZG+
         kO6Xs/vdTFKArGRtpzQU8vjEu9tCKHQ9iA1T2DJf3lcYMxuMr/X38vpWS4+VlF/ly48c
         PtqIBaKy+P6EGVXfi3UcMPDdXRfCu+iA3+BqTSwP88xIQB8H/m0acx3JFwKh2TIKMpuk
         QUxTWICMH8DW5zFP4qfPzYLHbcfrp5ed6asv9uY/G+5nX7sM8hRYEmhZy72y/hfAnFnL
         NKxJcq3HDo6U8s7J6Hc8vrYBYO07Cb827p3DnBaIftZKDgxCrBfy7+m3iQ9znp0/iGFc
         mAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GosB9Yjgb0Kn5JVNBnzEWD9cZazhce4gUyaHBUupnbg=;
        b=FyvT9c6fKXa4rj0rRyDc5tQem4+O3fbssZ7r2eoOK9ZmUNFUrYyFA9MZ0hECGNHWYB
         kePBe4GjHHETZasy5zbzVGxv45zgKEtPqsnG4E9VHig5kk+oQhuxU5YOcoklRM+26E92
         mBQeiSBuh5eMn8L+LrDo0ruR8+f758VjTOU3b3cpYSVfOHdNyYnqhRq02X8mU+zSpLkb
         beIR8A9uFOfpU1Rpr6jhGcU18whTvcVHb03zUao2NxEo9czWzp8HXqJkzy6EpASMOudo
         Kiu8Tdnk2WZLjYcsTYOTBEmdKtzRTC+xdjlozKaqOAd4xah8b9M7wf5NiioUkCkupAJi
         U5uA==
X-Gm-Message-State: AOAM532oabY5Jwp4tV54N+RnmbWSOwFdzbyL9zSZ16zkrm2Kvsq+9Y0t
        e6rsIMhdHC8PEplbxj+qCZxIz0d386eXkw==
X-Google-Smtp-Source: ABdhPJyTMomxbJ/gFBs6ZyZIhKAqmetid1wP46P9X2oYYxhKM+a6zaaKAQJybpoMks94VnzR6vshoQ==
X-Received: by 2002:a0c:80ca:: with SMTP id 68mr4495603qvb.28.1610576638958;
        Wed, 13 Jan 2021 14:23:58 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id j30sm1876108qtl.43.2021.01.13.14.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:23:58 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:23:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 07/20] show_objects_for_type(): convert to new revindex API
Message-ID: <68794e9484d303b832e8a9f7163cf89e2c506479.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid storing the revindex entry directly, since this structure will
soon be removed from the public interface. Instead, store the offset and
index position by calling 'pack_pos_to_offset()' and
'pack_pos_to_index()', respectively.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d6861ddd4d..27a7a8ac4c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -711,21 +711,22 @@ static void show_objects_for_type(
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
 			struct object_id oid;
-			struct revindex_entry *entry;
-			uint32_t hash = 0;
+			uint32_t hash = 0, index_pos;
+			off_t ofs;
 
 			if ((word >> offset) == 0)
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
 
-			entry = &bitmap_git->pack->revindex[pos + offset];
-			nth_packed_object_id(&oid, bitmap_git->pack, entry->nr);
+			index_pos = pack_pos_to_index(bitmap_git->pack, pos + offset);
+			ofs = pack_pos_to_offset(bitmap_git->pack, pos + offset);
+			nth_packed_object_id(&oid, bitmap_git->pack, index_pos);
 
 			if (bitmap_git->hashes)
-				hash = get_be32(bitmap_git->hashes + entry->nr);
+				hash = get_be32(bitmap_git->hashes + index_pos);
 
-			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, entry->offset);
+			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, ofs);
 		}
 	}
 }
-- 
2.30.0.138.g6d7191ea01

