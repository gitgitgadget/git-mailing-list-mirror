Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14D3C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjCTUDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjCTUDA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:03:00 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF0527D6D
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:42 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id i19so7075983ila.10
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679342562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNweSWarDDL6D6PfGWXryB9GRQymDMh0xU8ckrfKFhI=;
        b=Z19uI5yyXYnPt9dsN5JAHXzTxKHInT6GvuRzQOGPcZl458AnczbNHilpnVBesHsCSA
         3okqKxOkaKDUSNIgyaIw7A/bt2atw4AXZ2c/WsJ97oPr/xfHv/LcTzaDznSN0WQcxT9i
         wNijA+w5ENou82VbOKLfJTvk3oYSB4GP2ZmXZQdJ6oa6G2potnXN7UtHiYP5wF75+vHK
         dAK9q7POQpdH9PJ2mu2V9eKxkeQ1bC8pp6STbGfluZT9oRGa2HhQ6ALvY4vaZ6gMVsAE
         tJJSP+4rNkyf+BxOEEtnMxetaiV2TSoZ7lC8wWPvORUVmWKrKearzcwiXphXXbXHn8v+
         4E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679342562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNweSWarDDL6D6PfGWXryB9GRQymDMh0xU8ckrfKFhI=;
        b=oYgsLzIwaLgXoAQhtoKBW8wkulq3imBpqSUp8kcPaWeqMINuUwFtZHT3ZpN09j0v0L
         c0aaWAzL9ATJHVadR0YH5moTp0gGwHY6JP1p+9iCQsq1rkDiS4T1KJ/G8PIBAj1LFPDc
         UNTPe4hd+yM8dTpUJ1btg3ab4aZ1DQWaa2ql1FnKZ74quwUPHm1WHKtkP8yfftvTYOri
         lFqOJdhzbXJ5y3cSMC2modv6JkFeoyRi82sxkiaXse3++rBbxotGIgQ7Jsz4HP1dCmi+
         BWnnLvjzLSp1ZIXf41eAac/XJ8a0YS6rRpGbnNdICDW9B/PPvZDFanhvaf2XYdZCAqTe
         hFHg==
X-Gm-Message-State: AO0yUKW7VWqh6DpyJ1PYs+MNyhiFmdKDla428UUEqjgIcKCsGt0pTF7T
        5+OSsDJAnl54WQdsuyHBFi+AVTqTlC+Wxwu29m9NNA==
X-Google-Smtp-Source: AK7set8naRTVj7MeAp/moOavIi7lMJkVzet8LdmR8aj0vP/EUjC/UrJ9gIVCW72AoKXM9Nv8TaE7Ww==
X-Received: by 2002:a92:7412:0:b0:314:17d4:e9f6 with SMTP id p18-20020a927412000000b0031417d4e9f6mr5856412ilc.6.1679342561816;
        Mon, 20 Mar 2023 13:02:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i11-20020a92540b000000b00313b08feec7sm2967900ilb.42.2023.03.20.13.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:02:41 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:02:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 1/6] pack-bitmap.c: hide bitmap internals in `read_u8()`
Message-ID: <8c70c94a3f5f0463041dbaaa542fd69bd159428b.1679342296.git.me@ttaylorr.com>
References: <cover.1679342296.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1679342296.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `read_u8()` helper function internal to pack-bitmap.c was defined in
b5007211b6 (pack-bitmap: do not use gcc packed attribute, 2014-11-27).

Prior to b5007211b6, callers within pack-bitmap.c would read an
individual unsigned integer by doing something like:

    struct bitmap_disk_entry *e;

    e = (struct bitmap_disk_entry *)(index->map + index->map_pos);
    index->map_pos += sizeof(*e);

...which relied on the fact that the `bitmap_disk_entry` struct was
defined with `__attribute((packed))`, which b5007211b6 sought to get rid
of since the `__attribute__` flag is a noop on some compilers (which
makes the above code rely on the absence of padding to be correct).

So b5007211b6 got rid of the above convention and replaced it by reading
individual fields of that structure with a `read_u8()` helper that reads
from the region of memory pointed to by `->map`, and updates the
`->map_pos` pointer accordingly.

But this forces callers to be intimately aware of `bitmap_git->map` and
`bitmap_git->map_pos`. Instead, teach `read_u8()` to take a `struct
bitmap_index *` directly, and avoid having callers deal with the
internals themselves.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index ca7c81b5c9..d8ba252ba1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -251,9 +251,9 @@ static inline uint32_t read_be32(const unsigned char *buffer, size_t *pos)
 	return result;
 }
 
-static inline uint8_t read_u8(const unsigned char *buffer, size_t *pos)
+static inline uint8_t read_u8(struct bitmap_index *bitmap_git)
 {
-	return buffer[(*pos)++];
+	return bitmap_git->map[bitmap_git->map_pos++];
 }
 
 #define MAX_XOR_OFFSET 160
@@ -283,8 +283,8 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 			return error(_("corrupt ewah bitmap: truncated header for entry %d"), i);
 
 		commit_idx_pos = read_be32(index->map, &index->map_pos);
-		xor_offset = read_u8(index->map, &index->map_pos);
-		flags = read_u8(index->map, &index->map_pos);
+		xor_offset = read_u8(index);
+		flags = read_u8(index);
 
 		if (nth_bitmap_object_oid(index, &oid, commit_idx_pos) < 0)
 			return error(_("corrupt ewah bitmap: commit index %u out of range"),
@@ -780,7 +780,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 		}
 
 		bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
-		xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
+		xor_flags = read_u8(bitmap_git);
 		bitmap = read_bitmap_1(bitmap_git);
 
 		if (!bitmap)
@@ -821,7 +821,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	 * ewah bitmap.
 	 */
 	bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
-	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
+	flags = read_u8(bitmap_git);
 	bitmap = read_bitmap_1(bitmap_git);
 
 	if (!bitmap)
-- 
2.40.0.77.gd564125b3f

