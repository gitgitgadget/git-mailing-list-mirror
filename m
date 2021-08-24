Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A527C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519FD61212
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhHXQRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhHXQRK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:17:10 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2C4C061292
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:19 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i13so9900997ilm.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bw3CvqdrhpEOXdqlwAX99hXO+wxsKpEMzaMvZpwbHu8=;
        b=wKRiPepuc9Jh2LUFYxjMipLJQNq0xtRz0jYaGtawUkqMhvfNpX+yhG2oQwnpTsOGaA
         rAkozlLthNQdVD63kluORuXH7xZcHq0rXYR8lbg9ectFt21Ns5bZtaNYrcaOOybhj4yz
         1rAX7y8XPPSwdGfGG/u6qqFru1XKdXq8RMY4edbqDn6VvxF2lxaa0IgpRtLJQny8Aus1
         sM0qIa9HPAhen94vW5xPppu6heap9LgjbIfDKD3Bx5m1Fk9ZQTWv9rU8RVxLXYSHWTW0
         IiUVpNxFXSHzQ1ht6s4lX9omk01ADlgdY3UCa1pnaGmUvk2vILPF18GZbM1z3ptM/ok/
         95Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bw3CvqdrhpEOXdqlwAX99hXO+wxsKpEMzaMvZpwbHu8=;
        b=bhdRfro5NJFvxO4xG338ezbmdPlK+Vs55Wgqwc3CNvqjLXOFuv8FfwqETxQGsl8tyy
         JHmrZaZkmRDh9chgmHcIGdm67Uu2GBVaMcpTgVIT198YHaxC5hv8WcLY12n9dJ1Zrzja
         L1Pg5o4ryu1oooaBbCEK8UrMgjRvrUGBFoXjdrCrvoVqQjRTsxaTN9Jjj8gD/Ec3aboC
         yFNljrhikfQMLrjsiAX/LGsSvOjOjfHMic6klAz2ghamfJu8HqYFl4Jy59Dh+6SsQNtJ
         dRqHpUJCowwYBXkld4XS2lvthpRZct/pWqf5Np6b8Z3J8zC8qrVa1BFrPdRyj57vlRwG
         owJA==
X-Gm-Message-State: AOAM53213g8bLT+DRxn9Kj1QbyGgMbf5TKG9A0370zSoaFvSe/U0B/6C
        vVkQDq2vZyH28QjkBYZn27dBFbuALH/jGlvp
X-Google-Smtp-Source: ABdhPJxxSVtQ1SeHlSqI1+LvvAan/KLaeNWNwM/lccRDI4h8vpYcSg5GHR6zWaBKzK9jsHCdOGnocg==
X-Received: by 2002:a05:6e02:e51:: with SMTP id l17mr27781496ilk.73.1629821778793;
        Tue, 24 Aug 2021 09:16:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i6sm3009940ilb.30.2021.08.24.09.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:18 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 11/25] pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
Message-ID: <ede0bf1ce1f1f42783d59928dd033d17c2ad6314.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch to support reading MIDX bitmaps will be less noisy
after extracting a generic function to fetch the nth OID contained in
the bitmap.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 65356f9657..612f62da97 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -223,6 +223,13 @@ static inline uint8_t read_u8(const unsigned char *buffer, size_t *pos)
 
 #define MAX_XOR_OFFSET 160
 
+static int nth_bitmap_object_oid(struct bitmap_index *index,
+				 struct object_id *oid,
+				 uint32_t n)
+{
+	return nth_packed_object_id(oid, index->pack, n);
+}
+
 static int load_bitmap_entries_v1(struct bitmap_index *index)
 {
 	uint32_t i;
@@ -242,7 +249,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		xor_offset = read_u8(index->map, &index->map_pos);
 		flags = read_u8(index->map, &index->map_pos);
 
-		if (nth_packed_object_id(&oid, index->pack, commit_idx_pos) < 0)
+		if (nth_bitmap_object_oid(index, &oid, commit_idx_pos) < 0)
 			return error("corrupt ewah bitmap: commit index %u out of range",
 				     (unsigned)commit_idx_pos);
 
@@ -868,8 +875,8 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
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

