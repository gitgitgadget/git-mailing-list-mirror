Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD47F1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 13:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbeJAUYH (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 16:24:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41559 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbeJAUYH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 16:24:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15-v6so13933857qtp.8
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1bn+mVp1isgnUMG2UbNpszTwn40SGX9UTQCDMJJH8W4=;
        b=FnRDMCuaSN6YCk4OYIrAzj4QGN8mBDHfQZqENN3B0Xb5ILpLulCw+o1xgiZ04oDZRi
         LLjkE/aSChqGKwINcE4jP9Zf6fxQehsBxHBD6Ch0NotP7UKjLWGsO9zZZfeQM+f4olyv
         fjSFjsVEYH3kguL/Ez4Ei6PRXWAqJDqOgVKIP+UAooMfMKKmBA2B1v9K01UwwR1vyHPY
         4cUGohDWs7YrGBfbucCbyWT7hroNVeSDIzTSwwBiVNGy/hv8srYKDFX7K40z3c1eavW5
         ocq451ZTlgGQS+STiz0gOJJuaxnfmJjdw5Wi5cNSnkj8K/q8P/+fbcHxfxVBGJBp9iqJ
         fUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1bn+mVp1isgnUMG2UbNpszTwn40SGX9UTQCDMJJH8W4=;
        b=JrusCOkpFbe/F2cxM80G8FQOdN8kDYx8vNIyEqU4AgmGe6ojWb3nwNSH/Mxt6xoBXq
         IZQRDfwz7RjqsnPEN/Gsqmzzg48hr9tSAQFUOaguFVxnYsa3ZCMBwxQaW0ojYbxy4Iq3
         dMT43brrLNTFaS9hj38jPAAu5tgkH1LV8O+chrncbEV5g0zC8d+p1cozntz2otXXAt6V
         0lfpSm2q4pdbjIMPr9d/S+2oq3C312PgJlUqwiriJp86eTa9AHLhxd3XyVY5N9MjSOOX
         3PiOJuHnrjZuKmFA1LuingekudGlXnwDawCybPpYXvW5M6zyNaJetQ4Hgj0JaAdQrNYx
         q3fQ==
X-Gm-Message-State: ABuFfojkch3aNBv53zzjFcLYvxJ47vECHQwDLLjkyG6JdpaHYNC9Icls
        eS0CqPlLV9Habos4rxXhaTNsqGys2sg=
X-Google-Smtp-Source: ACcGV63GAwHycYdXZzNnnT42tyAqfRoA67cSMRfZydBFVeh9NoJXxO9CEuhEa9fQB0evdyHjzl+pzA==
X-Received: by 2002:a0c:b751:: with SMTP id q17-v6mr8209152qve.145.1538401573246;
        Mon, 01 Oct 2018 06:46:13 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id f129-v6sm6763435qkb.40.2018.10.01.06.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 06:46:12 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v7 2/7] read-cache: clean up casting and byte decoding
Date:   Mon,  1 Oct 2018 09:45:51 -0400
Message-Id: <20181001134556.33232-3-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181001134556.33232-1-peartben@gmail.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

This patch does a clean up pass to minimize the casting required to work
with the memory mapped index (mmap).

It also makes the decoding of network byte order more consistent by using
get_be32() where possible.

Signed-off-by: Ben Peart <peartben@gmail.com>
---
 read-cache.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 583a4fb1f8..6ba99e2c96 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1650,7 +1650,7 @@ int verify_index_checksum;
 /* Allow fsck to force verification of the cache entry order. */
 int verify_ce_order;
 
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 {
 	git_hash_ctx c;
 	unsigned char hash[GIT_MAX_RAWSZ];
@@ -1674,7 +1674,7 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 }
 
 static int read_index_extension(struct index_state *istate,
-				const char *ext, void *data, unsigned long sz)
+				const char *ext, const char *data, unsigned long sz)
 {
 	switch (CACHE_EXT(ext)) {
 	case CACHE_EXT_TREE:
@@ -1889,8 +1889,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	int fd, i;
 	struct stat st;
 	unsigned long src_offset;
-	struct cache_header *hdr;
-	void *mmap;
+	const struct cache_header *hdr;
+	const char *mmap;
 	size_t mmap_size;
 	const struct cache_entry *previous_ce = NULL;
 
@@ -1918,7 +1918,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		die_errno("unable to map index file");
 	close(fd);
 
-	hdr = mmap;
+	hdr = (const struct cache_header *)mmap;
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
 
@@ -1943,7 +1943,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		struct cache_entry *ce;
 		unsigned long consumed;
 
-		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
+		disk_ce = (struct ondisk_cache_entry *)(mmap + src_offset);
 		ce = create_from_disk(istate, disk_ce, &consumed, previous_ce);
 		set_index_entry(istate, i, ce);
 
@@ -1961,21 +1961,20 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		 * in 4-byte network byte order.
 		 */
 		uint32_t extsize;
-		memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
-		extsize = ntohl(extsize);
+		extsize = get_be32(mmap + src_offset + 4);
 		if (read_index_extension(istate,
-					 (const char *) mmap + src_offset,
-					 (char *) mmap + src_offset + 8,
+					 mmap + src_offset,
+					 mmap + src_offset + 8,
 					 extsize) < 0)
 			goto unmap;
 		src_offset += 8;
 		src_offset += extsize;
 	}
-	munmap(mmap, mmap_size);
+	munmap((void *)mmap, mmap_size);
 	return istate->cache_nr;
 
 unmap:
-	munmap(mmap, mmap_size);
+	munmap((void *)mmap, mmap_size);
 	die("index file corrupt");
 }
 
-- 
2.18.0.windows.1

