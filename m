Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F027FC432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD08A6125F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhHXQRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhHXQRM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:17:12 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ADCC06124C
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:25 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z2so21095936iln.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5HfFbBs0+y3zJfMUpG97rWi/FW9jxAgLk5VvVtPlBes=;
        b=bZbS+fgSqvgwFphMlUkkE2flQDWDeNKIhAqW/YGOwD1TpMEyH1gko2JxINbo/fIiM0
         i5Qkpw4oxeBy3x1c2Bt6iJTT1z2gou1VvuBuOW4sTBE2SLWIXhkr0EF16TBB/lkQXYWO
         IHDlO8nV1JolzwLPXGkQDGjnFqfbU3s662gphN1Atumc99DMVZs6UTnh6y2yvmWdy24P
         zlqVrOD/KKg1xCCKWpL5nzEKwrZ7AybhX461dVf3P2bcKF0f3qZdgaQjlCORO4VQptbT
         v9OH1aFzerEVDjwZOetClKUeASOVNWLLg8BhXe3uw5l98SZbNCXFO702p9J0FMSHeeof
         XrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5HfFbBs0+y3zJfMUpG97rWi/FW9jxAgLk5VvVtPlBes=;
        b=a375Tk3GG8+ssNXFyCLEGnd1GdEbiew1LzGwg7Rcbn0XYnhtw3lzxKIqTXnmPf/Tkp
         Xr2DQOHA/XyFW7ZzgXZ+wCyk1OOtT+tVHsAnQ5RCsdC97RS9TRd7TpxMdm4igD9NVCkm
         r3PDilNbOUc+QkrMCh9J9O3V91G0ZgOLZJMxK5gIS9YAeRziG0oQBhuuuRqmPls3znVC
         VSPfflZ6CQpAmFLdr5TWEe4uD09omsAJsiLngOfQVS81npyiN+2DM0Go4wYmgqoxcmV2
         ReV/ZoHI2xVnYsrtIzSc8nrARhorDNkECZRfZey3PlcpYsMUlvXBWzXAzB5wb514fcY/
         uBkA==
X-Gm-Message-State: AOAM533hz65cAJn2/Llev6zp5X5NmXHt/KUJTQujcQ/p08bRxXPWSZ03
        G4+CBekvheNGr9aciauic7swWcsQhf36pc10
X-Google-Smtp-Source: ABdhPJwITQpoKECu5SnvS+uutodkqD47hv1kFMyxPuHXR2HxJB6lwbaZnYUVtW23SfORw9XMHdbQgg==
X-Received: by 2002:a05:6e02:1074:: with SMTP id q20mr7147092ilj.204.1629821783829;
        Tue, 24 Aug 2021 09:16:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g23sm10133192ioc.8.2021.08.24.09.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:23 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 13/25] pack-bitmap.c: avoid redundant calls to
 try_partial_reuse
Message-ID: <4e06f051a7d56a906d1db97513c88d4b3029742e.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
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
2.31.1.163.ga65ce7f831

