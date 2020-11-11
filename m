Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E094C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BE42087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="wLojPmCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgKKTl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgKKTl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:41:59 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84F9C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:41:58 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id t191so2916311qka.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iP/7a2VntiLlnAaVrnGYm87IoWVvfW65anp38JXV3Qw=;
        b=wLojPmCRqZhpgAq5eLmbAR6g3EoqvnLrTh8h+ROuP1LtyjyWdDq3cc+ZbQ0Ut1KbbP
         2C6LsUHVQ5LD9ypL+d3yR9a6iM45dkcIFKfjWe44wijQt9ALuQXeidRaYJILHw1ExqAX
         yb7rcu/mRKe3M+VKBwAHmULWYcNIC+GTgZqy5knN73uJP28EKN0OntLvqhyDhg2B063u
         9LDxylTEoRwcgrCRkzMx7y149dA7S2ToLGBMNNXgyafO8f7Isf26wMSPjLYER/kSvjyL
         ku9rO6pwlw87v+gcnNq/ka0HF5qUbvQGgG4RhQPYBMk5rikqN4AZu6K029b7kvVDelcs
         H01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iP/7a2VntiLlnAaVrnGYm87IoWVvfW65anp38JXV3Qw=;
        b=DxzpW/XbzCv1wc/g4yEt8NR96aBplm7GRP+FX6Hm9W5co5EoADukPzGyUsbE/VFbfh
         RXJUkd6hHdiaPoQcmicmPENAG2dEE6p+Z45pB56AoJXwCWeKt8TBZ7GrwAko5l14qz37
         seJUxVkEg3gArDGanISrQ2EyqdHFcED4uNmoEaiNiwxtgdrrBGu6Hc0IV2nbIVoJQ/Ld
         tH+puOhcMXsx4sTa/X7Z4HVnncOU5865nJSrL1OzldKPERZDiJklWi4Ob/Aq8oKIH4P8
         mxMvzrTtLThxztqZ4Msp+JJ1/UUrxnSYvUW4rEr4RSGamiIG1FTHYMWFD44nT+TSRnNS
         8qnQ==
X-Gm-Message-State: AOAM533DU7nsc+ZPEWGVoHGSau8FPe3NDwO7y4yVSXe4xTaGRqxIF3hF
        MBQSwNVoFEqEKbe8v1/Km1CqFFUcs0j3C/Fd
X-Google-Smtp-Source: ABdhPJzdAMMFdjTDyT18f1My43B8MMVz01HdNNRKnDevDXfuRk/XTXNPZAdKGfyaKLQiHStETtBRpQ==
X-Received: by 2002:a37:98c7:: with SMTP id a190mr27174894qke.471.1605123717929;
        Wed, 11 Nov 2020 11:41:57 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id 9sm2814578qty.30.2020.11.11.11.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:41:57 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:41:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 02/23] pack-bitmap: fix header size check
Message-ID: <c59fcbcc67556c5c9c5a22a2ee745a2f58234efd.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
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
 pack-bitmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4077e731e8..cea3bb88bf 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -138,8 +138,9 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 static int load_bitmap_header(struct bitmap_index *index)
 {
 	struct bitmap_disk_header *header = (void *)index->map;
+	size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
 
-	if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
+	if (index->map_size < header_size)
 		return error("Corrupted bitmap index (missing header data)");
 
 	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
@@ -164,7 +165,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 	}
 
 	index->entry_count = ntohl(header->entry_count);
-	index->map_pos += sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
+	index->map_pos += header_size;
 	return 0;
 }
 
-- 
2.29.2.156.gc03786897f

