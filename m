Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9024FC63777
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D212241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="eJe8NBLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgKQVqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgKQVqh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:46:37 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDB9C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:37 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id v143so22408687qkb.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3oGTX7BFfV53cenzji9PUIDZ4Kg6jEo0uaSL1SEMJVo=;
        b=eJe8NBLNR2D69yo1hD4ZxBBrKW0rHuPIYXazNDeKmf4zuA5Vv8fK60sT+HBc8Z/yCd
         wfeCKrfvyuG0q8X+3zFLLlVGDq+Wsq+RQn5xQtZlzO9kg+uvFwMCsSKsuIP2fZFK+epo
         4CY4VDgCc+ivuK2/zBIlqLX3hCVHxRnxFiqsh5S4YRmc2ka6XqHTXWDKsKyHqUJOAz3i
         myUhbj5e9+wgMqSNBmyeUiWBSjL7OYV89M7Jdykr+2kzQ2UzLNeGkHzrFKl0bj8OGEAr
         Fja2MuEltGvBlIitx5OUzf3lnk4mtoUDE6WpUzK0LnEwB/a/aKKjzwzLdrI9/kt2IHmR
         iaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3oGTX7BFfV53cenzji9PUIDZ4Kg6jEo0uaSL1SEMJVo=;
        b=NSoFr0LSlA7Y5BVkyJrASKMTLlO29/+hECsaattrjLtt3GG8o+MUZT75OsW27dy8x8
         SZlqGJCRzG/45V03lALxza43bIxOxDZz8DPKIkJHSskwWPxyulcBPjnrvWQs1/7oZ/nR
         iyX/KiHxOLwSy3is+6ibvsmlHv7rIh/3Gv5aGPQHW9CjsV4d51tEA8YUuF0+O6p5mzc2
         rlghDgQvCu44DhcCBiyqRDo0V8YDZQMEtxb0JyfLEUB7Yzv0qSOpJgcfnk45mdEw619p
         fgRrccUu0aS0tmHK9ctiLflu4Hp/TPeol9i5EQrdVppp3HIqHqDbEzISWo4XOa8vTOba
         ImBw==
X-Gm-Message-State: AOAM533FxfvSlo3PY2Om9rF9MflFvVMuZxQjKL3Bo3vX11LttvBAHFte
        MlKi+trR4AlU9bUWcOX98aZ+7+GvyTtdLAan
X-Google-Smtp-Source: ABdhPJyyjC6hcGwMNblfpkKM0WIEzHc9MLbqVOBrGxn47aT72VEVq/kPysEZaKeo7l2BduSSaHAHdA==
X-Received: by 2002:a37:aad2:: with SMTP id t201mr1710938qke.61.1605649596518;
        Tue, 17 Nov 2020 13:46:36 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id z26sm14618337qki.40.2020.11.17.13.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:46:35 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:46:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 02/24] pack-bitmap: fix header size check
Message-ID: <74a13b4a6edaa8f9c679019017fafe2fd8512357.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
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
2.29.2.312.gabc4d358d8

