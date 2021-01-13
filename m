Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C876C432C3
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD1D235E4
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbhANCFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbhAMWZw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:25:52 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD6FC0617AB
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:45 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id h13so1576759qvo.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Sew6UVLwtawBAMq7mXqyFp8UmME/Kil7jsnpb9Kp7k=;
        b=d5OyHJRm1Ha/2gIhO2wrHZXaEN1u1WPOCieGrKpfV+e3K+usp4azbgdwUZIZutk/y+
         Uye1Jh2zgj0WwmpKndofzPXHQkSBeclaLeu7SoqgqJjxUcfhYLZntzqLjA9aeZiOGtga
         8JjNF6y1GD8891jeb30rD+oGr9x/LoVHiF6F31lI3wUwFkyNfpxfDMweBb0uAVVF6YDm
         aXx7TImlOcpjLs6AaXuhmHF6l/fL+Ov3RyiFPMjDcbkKts1LiorSMVJBwrx20V+kYcq/
         dFdOtT+tqJaPkDx0XFfRWx4BA588mIEzrqWSekjUx5z7aEfiOrji+bN6LWWPtW8q48P7
         iJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Sew6UVLwtawBAMq7mXqyFp8UmME/Kil7jsnpb9Kp7k=;
        b=e1rldWD5MwFqdYj3ZPXRhfTt2QiCKlTGF8J63dX3LsV/SN6oUo13DQ1FgqI9SerXxl
         Aw6YvJV53166ZICOIxRYEokQB4ESdjEWsU8JA6kQPWT3sg4iKpUe2+uU6g/uA260iAXI
         Nihc0xUc0Ti3PP0FHhZJ/K8OBBTafgp8yorHp7Fl1GYG+HgqZWxs+OxVX3aYOU/3MM0U
         NIC8HS7xcdLx9/arfZaA7Pbil7fhJ0fcChc7yJToK3LXmnc/NHUZ2J7vz98vaBb5Mb33
         SjM05b0jMEMNwUhICvq8wbP4TNktuvGWcLqzOpc7yqXdFyrFJqKeEFGBfZFsEbnEr6nl
         rNUA==
X-Gm-Message-State: AOAM532rZO5f6gXMf9X/AGWMkLyY19w8X6K/VYxZeLAlkCN8+rZr9P3C
        ZdXwmgMa6GXYqxqUCPoamcvV3SurCxmRvw==
X-Google-Smtp-Source: ABdhPJyJVxg6us9zPC0uRyk/ciMMJ0rx9jdY9TEq0Trp1h5cl7DihWyhum5jV/NaPEKxx0rX7QmfYw==
X-Received: by 2002:a0c:df94:: with SMTP id w20mr4399577qvl.33.1610576683997;
        Wed, 13 Jan 2021 14:24:43 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id l191sm1973333qke.7.2021.01.13.14.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:24:43 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:24:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 13/20] packed_object_info(): convert to new revindex API
Message-ID: <41b2e00947bdac416e5f599dc50ebf4b0e3e238b.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert another call of 'find_pack_revindex()' to its replacement
'pack_pos_to_offset()'. Likewise:

  - Avoid manipulating `struct packed_git`'s `revindex` pointer directly
    by removing the pointer-as-array indexing.

  - Add an additional guard to check that the offset 'obj_offset()'
    points to a real object. This should be the case with well-behaved
    callers to 'packed_object_info()', but isn't guarenteed.

    Other blocks that fill in various other values from the 'struct
    object_info' request handle bad inputs by setting the type to
    'OBJ_BAD' and jumping to 'out'. Do the same when given a bad offset
    here.

    The previous code would have segfaulted when given a bad
    'obj_offset' value, since 'find_pack_revindex()' would return
    'NULL', and then the line that fills 'oi->disk_sizep' would try to
    access 'NULL[1]' with a stride of 16 bytes (the width of 'struct
    revindex_entry)'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7c37f9ec5c..bb4bb14671 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1537,8 +1537,15 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	}
 
 	if (oi->disk_sizep) {
-		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
-		*oi->disk_sizep = revidx[1].offset - obj_offset;
+		uint32_t pos;
+		if (offset_to_pack_pos(p, obj_offset, &pos) < 0) {
+			error("could not find object at offset %"PRIuMAX" "
+			      "in pack %s", (uintmax_t)obj_offset, p->pack_name);
+			type = OBJ_BAD;
+			goto out;
+		}
+
+		*oi->disk_sizep = pack_pos_to_offset(p, pos + 1) - obj_offset;
 	}
 
 	if (oi->typep || oi->type_name) {
-- 
2.30.0.138.g6d7191ea01

