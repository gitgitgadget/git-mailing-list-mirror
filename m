Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96931C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjCTUDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCTUDW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:03:22 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CE110F9
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:57 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h11so7074848ild.11
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679342576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWncWiA7gWVip1Q3SNRB5NqMi++Gucqu939gFHKmVhk=;
        b=ZGL0rDNJ9mPytjQrQiYur7V8NRkdRhe/ikTHKZhtXukSNjtitClBMq6kG0jvtPGV5b
         jkX5QFCNV4wvAIo/e/9nODiaeyE2JbUlcoxq6FdAIymjdKukddUHK07rSnyuw5iAm/zp
         8mwl/yJ6BfsG938UtD/5HhIBi6K4Hb0obz8ATCZ7BldkgjA0Vj5KdWzrL0TNfzBg4EJC
         XwBIwTa/3K5oEjDnuD4/nTwBZq0oMJnXJRs2wla3Cnl85nb4beUuedPlg3hqfpkFL3iY
         s1TPXOMOQsBa+upGg50MZWRQPJ1AYosH6tY/c1PAdIuR94UWWqGxrQLqGuGCjVJmILHA
         mJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679342576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWncWiA7gWVip1Q3SNRB5NqMi++Gucqu939gFHKmVhk=;
        b=bJMLFW3DdGvDcJpmA6IQzR4VRjYY2Fl1hey6MQGUHu9r4cyCIDwjHTTHh/SdJKsKCq
         4sCtQjVWJPmY3jlVSyLchssZ+NS9foI4/sV5iOTHg98Aq1wwM75KStF/4aabCxB64v8C
         0O0knE73D/RjSqoRRopdZKbXmJzOhoqS2epkvtvtOr+EntP1X5MxIhpn1DuGStZU3W3R
         iqDfuoRE/uxpuU2oBI85hxO7mwRVEtrbKTwJd4KCKJqrnnA6UzjxHp1moomsfeBBCWym
         7C9ydoxO5Re/NrYvn4mc4+OILJOIsdiTHAXnfmRzLehfx2eUl8xHGy79h7Rn+4jz/QdP
         v2ww==
X-Gm-Message-State: AO0yUKVGX+AbhWtSN1BoiPW1xlMCjdvNlAycqXeZWEmpZ+br7Zmuk+aw
        ZoAErsD0PBL2dme0/3ISjTtAFIM3AViix2gQLtzHAw==
X-Google-Smtp-Source: AK7set9oT2UYUBZ4FFPA5oVaLGfZ26gcdZwPjjKAJ2gv7cNJ8eDlKBHTL3MoyVxqIEmSh2o40BKMFA==
X-Received: by 2002:a92:da10:0:b0:316:e39f:1212 with SMTP id z16-20020a92da10000000b00316e39f1212mr550704ilm.4.1679342576067;
        Mon, 20 Mar 2023 13:02:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g9-20020a025b09000000b0040610ade715sm3597861jab.83.2023.03.20.13.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:02:55 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:02:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 6/6] pack-bitmap.c: factor out `bitmap_index_seek_commit()`
Message-ID: <82049ed09e1695db644d1d4cf17557214e54dcea.1679342296.git.me@ttaylorr.com>
References: <cover.1679342296.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1679342296.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out a common pattern within `lazy_bitmap_for_commit()` where we
seek to a given position (expecting to read the start of an individual
bitmap entry).

Both spots within `lazy_bitmap_for_commit()` emit a common error, so
factor out the whole routine into its own function to DRY things up a
little.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 38a3c6a3f9..9859f61a5a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -156,6 +156,21 @@ static size_t bitmap_index_seek(struct bitmap_index *bitmap_git, size_t offset,
 	return bitmap_git->map_pos;
 }
 
+static int bitmap_index_seek_commit(struct bitmap_index *bitmap_git,
+				     struct object_id *oid,
+				     size_t pos)
+{
+	const int bitmap_header_size = 6;
+
+	bitmap_index_seek(bitmap_git, pos, SEEK_SET);
+
+	if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size)
+		return error(_("corrupt ewah bitmap: truncated header for "
+			       "bitmap of commit \"%s\""),
+			oid_to_hex(oid));
+	return 0;
+}
+
 /*
  * Read a bitmap from the current read position on the mmaped
  * index, and increase the read position accordingly
@@ -737,7 +752,6 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	struct object_id *oid = &commit->object.oid;
 	struct ewah_bitmap *bitmap;
 	struct stored_bitmap *xor_bitmap = NULL;
-	const int bitmap_header_size = 6;
 	static struct bitmap_lookup_table_xor_item *xor_items = NULL;
 	static size_t xor_items_nr = 0, xor_items_alloc = 0;
 	static int is_corrupt = 0;
@@ -796,13 +810,10 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 
 	while (xor_items_nr) {
 		xor_item = &xor_items[xor_items_nr - 1];
-		bitmap_index_seek(bitmap_git, xor_item->offset, SEEK_SET);
 
-		if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
-			error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
-				oid_to_hex(&xor_item->oid));
+		if (bitmap_index_seek_commit(bitmap_git, &xor_item->oid,
+					     xor_item->offset) < 0)
 			goto corrupt;
-		}
 
 		bitmap_index_seek(bitmap_git,
 				  sizeof(uint32_t) + sizeof(uint8_t), SEEK_CUR);
@@ -816,12 +827,8 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 		xor_items_nr--;
 	}
 
-	bitmap_index_seek(bitmap_git, offset, SEEK_SET);
-	if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
-		error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
-			oid_to_hex(oid));
+	if (bitmap_index_seek_commit(bitmap_git, oid, offset) < 0)
 		goto corrupt;
-	}
 
 	/*
 	 * Don't bother reading the commit's index position or its xor
-- 
2.40.0.77.gd564125b3f
