Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4620C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2B46103A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbhHaUxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbhHaUxV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:21 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA1AC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:20 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id s16so676642ilo.9
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zVk2Sv4JxjtOV0AzqifItb828qzQjqxuFrEIv8yMvE8=;
        b=TQwNsEQEtjzmIg/cLUXvmqUtT9DNNZ1e0ZM60fOf4XjeprJwq8JQYYX67UIVW3Ildn
         N901mv29ekdPbtua19nXb35WeZEA02Gza8EHo29rXg9Nq/SD8ckuo6tikJQGbQPE+2hm
         scbE7Qj458bRERbnQIL+vYy9/YFE5r53om9GsyQPB7Si4L3iwniS63gjxq8wJp7kRh2c
         yyCA7L7eqN4bOnxkkR+X9/D3Gx8f/NJDWiQd0FADBT4RHJYYqE1V24FJ9vn1PeVlEr50
         9WkAeunQ6/ijIrfmcIh6uAikLy/hNw6Jp/QdfSuzv/wjSQXiFppHedubiGoM8uzexIwy
         XCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zVk2Sv4JxjtOV0AzqifItb828qzQjqxuFrEIv8yMvE8=;
        b=M5wy7Mti0qtAsLqPiSMfABF/dfAiVHHadvtye2Esy2S9K8wci0qUdFfzHHN7JoWOQR
         ni1d+ijK9ReJqYzk+O1hccRnDqk7OJKA7bD3wYYWNvuESjKPF0RZK/FQOrJZJZMz0fU5
         36rIAZ/P71pYl/EC4HLF/oEyq8Cry4E2hOmiV+gzH4LUtRruvpChN+dfkSMd6JIwjbmb
         ebJZgdj+N0KbwSd9Ry1pKh+WxgkbxzEJCd+ZC7WGX3QRdGpgwB/kWPSd2Uv+D5MtAnqF
         umKMxCwZUxEyzOFpxTrNaP7FDt56wqLRyzQed8yTbdRlWMS5JJ2x9W+l7rTUpzu/s5LY
         YuKg==
X-Gm-Message-State: AOAM5334Gat4VvXtqhkRwrq1HJXc6Q3fPdqql7LMlv0WOTx1//QUt39s
        DxOoJcHBKXoxGfSio9J2ouvt7jgc3RvFlhY/
X-Google-Smtp-Source: ABdhPJzWb5HxLJOn+aqiBsF+sh3+7y5R+bdqKsRgzB5xY+S6y28XK/19lV94Xz3VSByO2zuRvEI+gA==
X-Received: by 2002:a92:cb4d:: with SMTP id f13mr22090863ilq.220.1630443140075;
        Tue, 31 Aug 2021 13:52:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s5sm10472581iol.33.2021.08.31.13.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:19 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 15/27] pack-bitmap.c: avoid redundant calls to
 try_partial_reuse
Message-ID: <06db8dbbc163ac41f0bd6e45b83e684660ca2746.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

try_partial_reuse() is used to mark any bits in the beginning of a
bitmap whose objects can be reused verbatim from the pack they came
from.

Currently this function returns void, and signals nothing to the caller
when bits could not be reused. But multi-pack bitmaps would benefit from
having such a signal, because they may try to pass objects which are in
bounds, but from a pack other than the preferred one.

Any extra calls are noops because of a conditional in
reuse_partial_packfile_from_bitmap(), but those loop iterations can be
avoided by letting try_partial_reuse() indicate when it can't accept any
more bits for reuse, and then listening to that signal.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d5296750eb..4e37f5d574 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1140,22 +1140,26 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	return NULL;
 }
 
-static void try_partial_reuse(struct bitmap_index *bitmap_git,
-			      size_t pos,
-			      struct bitmap *reuse,
-			      struct pack_window **w_curs)
+/*
+ * -1 means "stop trying further objects"; 0 means we may or may not have
+ * reused, but you can keep feeding bits.
+ */
+static int try_partial_reuse(struct bitmap_index *bitmap_git,
+			     size_t pos,
+			     struct bitmap *reuse,
+			     struct pack_window **w_curs)
 {
 	off_t offset, header;
 	enum object_type type;
 	unsigned long size;
 
 	if (pos >= bitmap_num_objects(bitmap_git))
-		return; /* not actually in the pack or MIDX */
+		return -1; /* not actually in the pack or MIDX */
 
 	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
 	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
 	if (type < 0)
-		return; /* broken packfile, punt */
+		return -1; /* broken packfile, punt */
 
 	if (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA) {
 		off_t base_offset;
@@ -1172,9 +1176,9 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 		base_offset = get_delta_base(bitmap_git->pack, w_curs,
 					     &offset, type, header);
 		if (!base_offset)
-			return;
+			return 0;
 		if (offset_to_pack_pos(bitmap_git->pack, base_offset, &base_pos) < 0)
-			return;
+			return 0;
 
 		/*
 		 * We assume delta dependencies always point backwards. This
@@ -1186,7 +1190,7 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 		 * odd parameters.
 		 */
 		if (base_pos >= pos)
-			return;
+			return 0;
 
 		/*
 		 * And finally, if we're not sending the base as part of our
@@ -1197,13 +1201,14 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 		 * object_entry code path handle it.
 		 */
 		if (!bitmap_get(reuse, base_pos))
-			return;
+			return 0;
 	}
 
 	/*
 	 * If we got here, then the object is OK to reuse. Mark it.
 	 */
 	bitmap_set(reuse, pos);
+	return 0;
 }
 
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
@@ -1239,10 +1244,23 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
-			try_partial_reuse(bitmap_git, pos + offset, reuse, &w_curs);
+			if (try_partial_reuse(bitmap_git, pos + offset, reuse,
+					      &w_curs) < 0) {
+				/*
+				 * try_partial_reuse indicated we couldn't reuse
+				 * any bits, so there is no point in trying more
+				 * bits in the current word, or any other words
+				 * in result.
+				 *
+				 * Jump out of both loops to avoid future
+				 * unnecessary calls to try_partial_reuse.
+				 */
+				goto done;
+			}
 		}
 	}
 
+done:
 	unuse_pack(&w_curs);
 
 	*entries = bitmap_popcount(reuse);
-- 
2.33.0.96.g73915697e6

