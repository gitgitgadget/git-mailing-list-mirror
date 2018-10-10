Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB691F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 15:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJJXWl (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 19:22:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40978 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJXWk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 19:22:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id l41-v6so6226727qtl.8
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 08:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iyTVoSLlgxNzmh7nGrmmjLlBb1pCULUhhmNBx6PivJI=;
        b=NphCddzQe/+W7Ww5BSDhCzxSE0D8ZQuvxKgRS2ZYaZJafPHOsp/3UdDAmg6SBCmqrP
         +oznTxk/tTVk94P87s+2wfyHi2C+QtlAq/47l8ORTowMPIIvcepJ7dW5aGyIaeWIbEHW
         xORsz3L1Bjyqts9cib1Lp1cp4YhUeUXo0vT/L9wKS08JlC1Gmd1eUBGGqUes9x+pjgT4
         e08hMEtdgem84D65UYmthkUXL+tDsFB2xCYrxiwCTyTVT3ro6l2yeQXRpNQgCo4eyLy0
         0/KE+cAQFllzxSeisokLXse9pCKcdVMDORLPlcQcr2wFaorObA6cO8XkuCP5MG96MGMN
         47Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iyTVoSLlgxNzmh7nGrmmjLlBb1pCULUhhmNBx6PivJI=;
        b=DBp5J6SPxiYsmpin7wfQ95FH387j289XbeRkVz26tDT9qh5+FPj1WvenjnzC/ggzOH
         glzfDJqvh2FBgzbxDl60BkajyEG4u6KspPYJTwr2LbVeztoD8V1TUFGtqsbjmy/Fd+3N
         +rCNxFtx+Bune+XPpiZX9y882ggxurRaf+c9oM/XR2yClrIDlwUAu1Lqf+5pQ0y4wAeY
         y8v0cdrKUZevD2uX9rfOyktrZW4x6cfFwpRmotOQYYIhzEWYZCmLuF6/q8lMg5zczfaK
         63R99EiNGN8AckD3Lg6zRMTDfPYNOQWNgvbM8Wx2FvfwK5npa4FtgH+VRwxgoS1c08bd
         bJeA==
X-Gm-Message-State: ABuFfoiDFrpiFTY9pzldG4sko1qDQWCzdE2nFiVXQi5NVSSBavszTNpG
        6oIA/CLtg1fg6TRpAQeC9JKr///SY1o=
X-Google-Smtp-Source: ACcGV62Xy2OgMBBbJ1fuMX3Zr5wEfJDopDpNQuTUJauAK1rL2WvplKfHLOUaaJxWckkZVOps1AQQ5A==
X-Received: by 2002:ac8:2729:: with SMTP id g38-v6mr27372063qtg.168.1539187191893;
        Wed, 10 Oct 2018 08:59:51 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d89-v6sm13704920qkj.29.2018.10.10.08.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 08:59:51 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v8 2/7] read-cache: clean up casting and byte decoding
Date:   Wed, 10 Oct 2018 11:59:33 -0400
Message-Id: <20181010155938.20996-3-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181010155938.20996-1-peartben@gmail.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

This patch does a clean up pass to minimize the casting required to work
with the memory mapped index (mmap).

It also makes the decoding of network byte order more consistent by using
get_be32() where possible.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
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

