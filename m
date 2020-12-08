Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555C4C1B0D9
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25BC322472
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgLHWEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgLHWED (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:04:03 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C829C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:03:23 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id b18so281763ots.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0biD3z7zmbAd3yPu0/4ZJpBDWIf7gZwf31aSZXDeAwY=;
        b=Rj7ZrtgzURLvVzZC8VVInduZrv0kABGBICz5NN1/cr9QyrW0PqWT4FByRNZshzlc1W
         ByhvvZlnEJJi6JefiHXOFedTYoJjEfGfR5HRbHSvzgnahMVDUV3uH/bij8q9llzKPZNm
         bFXeDp/KwVxohf4TLVG37CxwtBL7s8XuyC+aa6FP0cdraTBEtlspLfzYYxMQqNbwrNKh
         pUqRyH1rz5EQlPO8iBTUhHA5H5HjezCzURd0u3bU8yPNmnyzUoEzwH3HkpwuC/g8l5B2
         23XDeSJpMAA7vxXkaw5u0wttXsrwU/xKRm5+HlO+XMCCA4cBid0COJmFRXVAKTBY7Ovo
         hqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0biD3z7zmbAd3yPu0/4ZJpBDWIf7gZwf31aSZXDeAwY=;
        b=OPA6NC84hthcNCX/UY0pj86aUjjRskFeW+dtP1FCtwEu6OKE6NIkrpGJur467MoKif
         wVbJzER3INgmxDcwJiobqqEeXv3Omt+0I0JLg5cDo52yY9FTADQnKzG5wjVRG9fKR86x
         vP0lOx4eiiY9DZ+Yd6MKQ30h43KE7JQ/G825IEvpxtkXojr1Srm1QboUI1W8T0UHzH+F
         twf7/qCwOemgJtiFWrwC8Oz5Ilt/oSdr5bKOQRzAz+NsonndzsF04ytJjfJrYr0b00Hv
         CWByQQbXC6eWcjC9mPS5x7byaUYdFq9bvMSHelW7jhrXjU3jQC8zjTLhl/WjyfVku2J9
         Q08w==
X-Gm-Message-State: AOAM532N4qK/MyTjXd3vd8Jb7fiqRTnXq2gtdZ+RGfktBPr6zH3+OqMg
        F8Q174szHmTy3+SU6yjtYdGOzsTeTjOCIg3A
X-Google-Smtp-Source: ABdhPJyuHwFbS+6CawE8nxGR7uAizAhXpsop3RrN/9AeMCcdIfAAkRgJxEI9qcS5bqbhOEe+QN1mow==
X-Received: by 2002:a9d:3a2:: with SMTP id f31mr151544otf.216.1607465002235;
        Tue, 08 Dec 2020 14:03:22 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a18sm17545oia.29.2020.12.08.14.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:03:21 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:03:19 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 02/24] pack-bitmap: fix header size check
Message-ID: <b24395e4b0c1a8643371616cdae4499edf88939d.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

When we parse a .bitmap header, we first check that we have enough bytes
to make a valid header. We do that based on sizeof(struct
bitmap_disk_header). However, as of 0f4d6cada8 (pack-bitmap: make bitmap
header handling hash agnostic, 2019-02-19), that struct oversizes its
checksum member to GIT_MAX_RAWSZ. That means we need to adjust for the
difference between that constant and the size of the actual hash we're
using. That commit adjusted the code which moves our pointer forward,
but forgot to update the size check.

This meant we were overly strict about the header size (requiring room
for a 32-byte worst-case hash, when sha1 is only 20 bytes). But in
practice it didn't matter because bitmap files tend to have at least 12
bytes of actual data anyway, so it was unlikely for a valid file to be
caught by this.

Let's fix it by pulling the header size into a separate variable and
using it in both spots. That fixes the bug and simplifies the code to make
it harder to have a mismatch like this in the future. It will also come
in handy in the next patch for more bounds checking.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4077e731e8..fe5647e72e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -138,9 +138,10 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 static int load_bitmap_header(struct bitmap_index *index)
 {
 	struct bitmap_disk_header *header = (void *)index->map;
+	size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
 
-	if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
-		return error("Corrupted bitmap index (missing header data)");
+	if (index->map_size < header_size + the_hash_algo->rawsz)
+		return error("Corrupted bitmap index (too small)");
 
 	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
 		return error("Corrupted bitmap index file (wrong header)");
@@ -164,7 +165,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 	}
 
 	index->entry_count = ntohl(header->entry_count);
-	index->map_pos += sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
+	index->map_pos += header_size;
 	return 0;
 }
 
-- 
2.29.2.533.g07db1f5344

