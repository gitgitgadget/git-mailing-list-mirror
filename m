Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ADDC43381
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A92923A7A
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbhAHSSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbhAHSSI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:08 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6FCC06129D
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:17:12 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id t3so7045291ilh.9
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FpJPKToZQKcilGpyUbSieoLEDXY0+Q/REGAmXy1kLFQ=;
        b=v+eG1g2+2Vyn20ANgkXhQVkyGUHu0kjet88IGPeL2+lUnfXYHaJ7nJ3DG4r4TuJHPr
         jhOTETwYyLKr3uhzFpL3vHaL3stemwg4JO2639CmGHqISBJG981ICS+8V3jSW4aDkuXf
         sBGqvbnTqAuNga0qEI4ubvri/J1OMnY5EBpGk4s0RLKT103Xsmr6AcajzhG51r3I5FGD
         TY8eaE+geitJFKhj0mbXN1TWZ32a4jiC+P6vGKl2pu6KS7olqieV7mqqhos57M9IU1Mf
         /Owsg6W7XF9xb3pn5HHOtra73dtbwJ2ndARkUSam8WqUBp4RCHVbMZ0jvw0+t6Z7Juk9
         VebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FpJPKToZQKcilGpyUbSieoLEDXY0+Q/REGAmXy1kLFQ=;
        b=TjVKsYO4ML8xpDqgHM02arb8lTKdFxoxhS+HlEkucsjte2Snc9edvmh7TWFFaQ5J/M
         j8u7aUYHCM2Z2VJb6rILxai/dbRB63F5pR55EpG7e2/A8WNlp3G7kk0n6X2cu7oUQEfy
         wntoPo5nPlY/t2Oqz3ohMHdYkOGt2UUl4FrY+ECebdQSudhJs9VP08rHdKcnDubrwTWr
         eyjNbh63LGeVqAsTF9se0e69a6ouEYDkWaXFiUB6v3dg/WMz1vhSLdtRLQL3dwW9wtth
         1KNtK7O5cUtRSNrJ2aWBIPGnXXYMLK+7d0YyPk/F5HACaimHm6UPKSG5g4gP6T0rzy5E
         szxg==
X-Gm-Message-State: AOAM531ycf3lxCarBTWuQ18nlymMN0zDAu5+R5b1mSCUYNXdL2R8wN73
        o2kjbOiJhBl+F+E5b0/5Nqr3OxVGyhvbmA==
X-Google-Smtp-Source: ABdhPJw7uk5+v0xS6DzW0pO5SUc7uKSvfocghiEAiCoyJVdXO7dLgMfBcLkioFinvzXKJFwKDbRu7g==
X-Received: by 2002:a92:1f87:: with SMTP id f7mr4859340ilf.0.1610129831889;
        Fri, 08 Jan 2021 10:17:11 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id r11sm7504985ilg.39.2021.01.08.10.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:11 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 07/20] show_objects_for_type(): convert to new revindex API
Message-ID: <bc67bb462ae0c87b34e46568d54b170a8aec870b.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
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
index d6861ddd4d..80c57bde73 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -711,21 +711,22 @@ static void show_objects_for_type(
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
 			struct object_id oid;
-			struct revindex_entry *entry;
-			uint32_t hash = 0;
+			uint32_t hash = 0, n;
+			off_t ofs;
 
 			if ((word >> offset) == 0)
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
 
-			entry = &bitmap_git->pack->revindex[pos + offset];
-			nth_packed_object_id(&oid, bitmap_git->pack, entry->nr);
+			n = pack_pos_to_index(bitmap_git->pack, pos + offset);
+			ofs = pack_pos_to_offset(bitmap_git->pack, pos + offset);
+			nth_packed_object_id(&oid, bitmap_git->pack, n);
 
 			if (bitmap_git->hashes)
-				hash = get_be32(bitmap_git->hashes + entry->nr);
+				hash = get_be32(bitmap_git->hashes + n);
 
-			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, entry->offset);
+			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, ofs);
 		}
 	}
 }
-- 
2.30.0.138.g6d7191ea01

