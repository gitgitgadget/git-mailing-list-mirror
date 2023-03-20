Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7443C6FD1C
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCTUD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCTUDS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:03:18 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C472D44
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:55 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id bp11so7095658ilb.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679342573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GeXZQEB1xM+JoBV53w/xzzVWBFhPhNSGC4ynfnsdxL4=;
        b=v8sEH9WHDh8HOZoX4uk6dHCI77jc7Dp7+++IaK6S5WmznBRlva2B/442ViaaT8UuPM
         Ssiy0Co0pRpw04eyBLM8XVJq+jDFHrxSJClUjWC4zpSu0fO/pFktkPv2lDpRaJJ+5So3
         wF2ZlRqyFamAW20K6/56HaH4zzRiXhuAtpP8WGhFFgYMAFjKUuLIxIb6/AWcMKBG6B9D
         ay6yc7Cq+wnvBXWIeKSz5c7egKhvUVWh6acoRHShmznNzlgfV0sTVWMfHw/tUD6Zvu3r
         C52TCwRceW59LPTl8Vs80UhFKAUcciQTkpPT9mRwC9TVrWH0sSFxHHxgn6onrggApjf/
         4koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679342573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeXZQEB1xM+JoBV53w/xzzVWBFhPhNSGC4ynfnsdxL4=;
        b=1ix9S3XG22ib6mVspr+qo5MQ7leB91M0o2aH0PVBR7sYqVSiKWbp6kjaM6puzDdsn9
         ZPC4xVphVI1l2iALI9pmfUdG6Dwj5NePUo/6/lbC8kS0npn/tYaW0ZxyGIypkGJL2X4L
         HbPXXYrPkXua5okLumTfaeVpZR0cIH69pizP4m7NZxDB1u8C6/gg3V2kEp9l+X2HyR1D
         gd12em5vXLQTTRZR0y6/UVaCwTpxKl1u/tyx2svN6VD1yDtslOogWhychpZf65B+zwXt
         b6zjzKsMdmOR+tL+nqaYPgk+VNgkcQh7MWkDnwR5kJ+Nf5mUkM3yyvsLLVugP+xzLhmL
         lUUw==
X-Gm-Message-State: AO0yUKUHbtUQ6NTXaCINXiO13rrFeuGTdD52GkZ+HrgmVrA4tBtnRKcH
        8JNWq+z9N5Gv+EMnTVOHNSJZC7Ai7YhUQD/0Yi1msg==
X-Google-Smtp-Source: AK7set9inoMfYhuBmCDBNcjIve+TK/MmpWxs8QHlKAi9wBVMI7mOZ5jz5Cf9DF5YSAqDsIqgm0nDRA==
X-Received: by 2002:a92:d203:0:b0:323:891:6f27 with SMTP id y3-20020a92d203000000b0032308916f27mr560226ily.9.1679342573405;
        Mon, 20 Mar 2023 13:02:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a17-20020a056e0208b100b00315785bfabfsm2998516ilt.47.2023.03.20.13.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:02:53 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:02:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 5/6] pack-bitmap.c: use `bitmap_index_seek()` where possible
Message-ID: <9a3e45b78b7810e0116848f1de80096b04285a55.1679342296.git.me@ttaylorr.com>
References: <cover.1679342296.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1679342296.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As described in the previous commit, now that we have a functional
`bitmap_index_seek()`, rewrite all callers that manually manipulate the
`map_pos` variable with calls to `bitmap_index_seek()`.

This means that all callers that adjust the value of `map_pos` have
those changes automatically bounds- and overflow-checked.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index fabcf01c14..38a3c6a3f9 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -174,7 +174,7 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 		return NULL;
 	}
 
-	index->map_pos += bitmap_size;
+	bitmap_index_seek(index, bitmap_size, SEEK_CUR);
 	return b;
 }
 
@@ -230,7 +230,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 
 	index->entry_count = ntohl(header->entry_count);
 	index->checksum = header->checksum;
-	index->map_pos += header_size;
+	bitmap_index_seek(index, header_size, SEEK_CUR);
 	return 0;
 }
 
@@ -269,13 +269,15 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 static uint32_t read_be32(struct bitmap_index *bitmap_git)
 {
 	uint32_t result = get_be32(bitmap_git->map + bitmap_git->map_pos);
-	bitmap_git->map_pos += sizeof(result);
+	bitmap_index_seek(bitmap_git, sizeof(uint32_t), SEEK_CUR);
 	return result;
 }
 
 static uint8_t read_u8(struct bitmap_index *bitmap_git)
 {
-	return bitmap_git->map[bitmap_git->map_pos++];
+	uint8_t result = bitmap_git->map[bitmap_git->map_pos];
+	bitmap_index_seek(bitmap_git, sizeof(uint8_t), SEEK_CUR);
+	return result;
 }
 
 #define MAX_XOR_OFFSET 160
@@ -794,14 +796,16 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 
 	while (xor_items_nr) {
 		xor_item = &xor_items[xor_items_nr - 1];
-		bitmap_git->map_pos = xor_item->offset;
+		bitmap_index_seek(bitmap_git, xor_item->offset, SEEK_SET);
+
 		if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
 			error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
 				oid_to_hex(&xor_item->oid));
 			goto corrupt;
 		}
 
-		bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
+		bitmap_index_seek(bitmap_git,
+				  sizeof(uint32_t) + sizeof(uint8_t), SEEK_CUR);
 		xor_flags = read_u8(bitmap_git);
 		bitmap = read_bitmap_1(bitmap_git);
 
@@ -812,7 +816,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 		xor_items_nr--;
 	}
 
-	bitmap_git->map_pos = offset;
+	bitmap_index_seek(bitmap_git, offset, SEEK_SET);
 	if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
 		error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
 			oid_to_hex(oid));
@@ -842,7 +846,8 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	 * Instead, we can skip ahead and immediately read the flags and
 	 * ewah bitmap.
 	 */
-	bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
+	bitmap_index_seek(bitmap_git, sizeof(uint32_t) + sizeof(uint8_t),
+			  SEEK_CUR);
 	flags = read_u8(bitmap_git);
 	bitmap = read_bitmap_1(bitmap_git);
 
-- 
2.40.0.77.gd564125b3f

