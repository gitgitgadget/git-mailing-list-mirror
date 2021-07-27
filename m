Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE15AC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAAD460F9C
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhG0VVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbhG0VVY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:24 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE24C0613A1
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:58 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id u7so636931ilj.8
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GI6oGBL1oYlqJpUNBU41aiv3Vp2jB9mHIYjgiOZ/U4c=;
        b=G1aR/mQX6Njj9if6p3p4zfFDCG/iODOndlh+PvOMC7nekuwgBsddJgymyfzXpBaRGy
         jAYTPFQhs1I0xtfH1MvNC7Y040ADvxRILYOCmACfhhNq4jX/GptuZsha9B4CuzukP6r3
         ieqNWUmNlcHDkA51UY6rpNsoS6jzh3IdXOkb6NEBmJpeuMGxAr8uyls8WdO4GxXHWk7m
         rJTUbStqTnL2kRUlM+Op8g77u6we58FNY2OkC9HLGfvsiwvPEI0TJx53bEOypynq2ULS
         q6e7Wjj2LpT9tGiPxd00K3q2qxoLSR8pud94UyPuyjL7bAKWFfn5KF0Nf0Uhak5qVJ3a
         aQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GI6oGBL1oYlqJpUNBU41aiv3Vp2jB9mHIYjgiOZ/U4c=;
        b=l0TCAAmQbgMhU3ffplZJyYIW3iVNkuViS4g5SVR9c5WTeRKZUzSfyetg60zzNyk22C
         weDBxK1/q2XrpV3YdprYYbV1sw+ZnpvbTjm0ZqnHYWCr3RzHJ4SOHBv2CAKpdLrgqJAh
         9qGAB7F+ivyK1hQulwshoH6U5anPi4oR4P2ZKz1ZeTFv87SwVvI/S/qttSYLTyO1m1kJ
         vLF1NOE55yFBYppzhgv6lcET7UIhG1P0txohX60Km1k0aRimnfUPpVSrxm8c/EvNY33j
         96ROvjylAQopEuszy+2WWHknLbM6KyOx91lSE9opFw5Kq6QJR8qFMOOr8vSUnk5hkRWC
         5AGQ==
X-Gm-Message-State: AOAM531aIH+UmPyeyxwIhdEHrqOv5PthwLDViRgnAPJfs/Af+cRrc15U
        jscSdlvyjz54maDIe6mMQrSlgAhp9zpB4kEk
X-Google-Smtp-Source: ABdhPJyJYj95L53fRUyv9pudwLsEupp/YRb7TxiDpy3YMMKLc7G9/3Ni4QdJ/AfjDiQmBwqJlQ1c7w==
X-Received: by 2002:a05:6e02:15c8:: with SMTP id q8mr4001299ilu.285.1627420797869;
        Tue, 27 Jul 2021 14:19:57 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id d186sm3334008iof.3.2021.07.27.14.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:57 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:19:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 13/25] pack-bitmap.c: avoid redundant calls to
 try_partial_reuse
Message-ID: <a3b641b3e66a6fe8257064e976e271a5750aff9f.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
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
index 6b12c96e32..1442f0c8f2 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1134,22 +1134,26 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
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
@@ -1166,9 +1170,9 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
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
@@ -1180,7 +1184,7 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 		 * odd parameters.
 		 */
 		if (base_pos >= pos)
-			return;
+			return 0;
 
 		/*
 		 * And finally, if we're not sending the base as part of our
@@ -1191,13 +1195,14 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
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
@@ -1233,10 +1238,23 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
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

