Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C34C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 17:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiI1RTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiI1RTH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 13:19:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE37110D5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:19:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id iv17so8938086wmb.4
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=9sR81/ZVNW95ax1NSNTcKJ0Fv9roq1xzsgJ63SA+kgk=;
        b=UWC4cyY5huSmNy3ghnoK0QT0XE3y92Vbm3gWG3vRnttm1bUze3YtO0O/wzRH6fop/H
         h0DWjECtMDEjBHgaWKOh6FGd/KTrHdT+/TVmrkldoVUsTdmmvlZzI7sj+B3LplMfvjeV
         f4e0wI6FzV2pkcH9m5QAqsd36Urc/Vexuj9LDyDGPb2rFJBYvw8cNQomSsg1fRsUu33m
         QaFA0nLq/m+vHEH0JfbL3jUcf81/b4EYPuOHMpI7GPcxS9Ydcbjc88WERaLJ5QqiQxjz
         L57jWl+Pzq4yh8rofQYuzWvSCDgC6Gi6qixqD4XavxFWSgihGeDWzg90fhbAoFsKEYmx
         ZpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9sR81/ZVNW95ax1NSNTcKJ0Fv9roq1xzsgJ63SA+kgk=;
        b=3hK5b0koDPsXSXShTCBl7k6VnnVS+Lom69e9kbkw4Ptl5VpLPdXtn08+GCHDZeiAwY
         +BY+N1+r1dsSttG8I9CKQ1gBJ7eNPxPSFn/MXgH5oRNUugax/kWG2AWqDY3HqCL/dI5Q
         Be8riM/nnjdaUnH3fVYbdU3bwnu2YaSQgx0imcfA1512wminvREJHooKzckIOWoIWRtC
         0VEdCdRXw/hptB0tsRIy5EScXLevZh7wFtI832QO42qwhSbGf1R6YSQAqgI/ACMZKxcK
         oHnDfqfhUOBEwVcddjM8OYD0AHS9nvJ+n4aEfqIM/5mZrd6lmDhLq3bVMh2Q+cu70wQ6
         oyfg==
X-Gm-Message-State: ACrzQf3Jb8hi2CFJ/HkT4hmxHzjQeY0dM1Tnd8kTzWkxyfsVS6NkEs3o
        fAER9xYWOXtdJLwkaFboS/IxJzdSlFU=
X-Google-Smtp-Source: AMsMyM5OkAH6BsqoLiacGQctV0oa6gsj5fwqs+OlaTfwILhMxzY0I7Iuj3iLAGXTxUgFt39UFF+CaQ==
X-Received: by 2002:a05:600c:1d94:b0:3b4:7b91:7056 with SMTP id p20-20020a05600c1d9400b003b47b917056mr7586206wms.18.1664385542727;
        Wed, 28 Sep 2022 10:19:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg33-20020a05600c3ca100b003a5f4fccd4asm2367860wmb.35.2022.09.28.10.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:19:02 -0700 (PDT)
Message-Id: <pull.1366.v2.git.1664385541084.gitgitgadget@gmail.com>
In-Reply-To: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
References: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Sep 2022 17:19:00 +0000
Subject: [PATCH v2] read-cache: avoid misaligned reads in index v4
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, derrickstolee@github.com, gitster@pobox.com,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

The process for reading the index into memory from disk is to first read its
contents into a single memory-mapped file buffer (type 'char *'), then
sequentially convert each on-disk index entry into a corresponding incore
'cache_entry'. To access the contents of the on-disk entry for processing, a
moving pointer within the memory-mapped file is cast to type 'struct
ondisk_cache_entry *'.

In index v4, the entries in the on-disk index file are written *without*
aligning their first byte to a 4-byte boundary; entries are a variable
length (depending on the entry name and whether or not extended flags are
used). As a result, casting the 'char *' buffer pointer to 'struct
ondisk_cache_entry *' then accessing its contents in a 'SANITIZE=undefined'
build can trigger the following error:

  read-cache.c:1886:46: runtime error: member access within misaligned
  address <address> for type 'struct ondisk_cache_entry', which requires 4
  byte alignment

Avoid this error by reading fields directly from the 'char *' buffer, using
the 'offsetof' individual fields in 'struct ondisk_cache_entry'.
Additionally, add documentation describing why the new approach avoids the
misaligned address error, as well as advice on how to improve the
implementation in the future.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Victoria Dye <vdye@github.com>
---
    read-cache: avoid misaligned reads in index v4
    
    This fixes the bug reported in [1], where unaligned index entries in the
    memory-mapped index file triggered a 'SANITIZE=undefined' error due to
    casting to & accessing unaligned data a 4 byte-aligned 'struct
    ondisk_cache_entry *' type.
    
    In addition to the originally-reported 't9210-scalar.sh' now passing in
    a 'SANITIZE=undefined' build, I did some light testing by first writing
    a v4 index with a released version of Git (v2.37), then running some
    index-modifying operations ('git status', 'git add') with this patch's
    changes, then again running 'git status' with the stable version. I
    didn't see anything out of the ordinary but, considering how critical
    "reading the index" is, I'd very much appreciate some extra-thorough
    reviews on this patch. :)
    
    
    Changes since V1
    ================
    
     * Added a comment explaining the somewhat unintuitive use of the
       'ondisk' buffer in 'create_from_disk()', including why the 'get_be*'
       functions do not run into the same misaligned address error this
       patch is fixing.
     * Added a 'NEEDSWORK' comment recommending a future refactor to avoid
       the need for 'struct ondisk_cache_entry' entirely.
    
    Thanks!
    
     * Victoria
    
    [1]
    https://lore.kernel.org/git/YywzNTzd72tox8Z+@coredump.intra.peff.net/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1366%2Fvdye%2Fbugfix%2Findex-v4-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1366/vdye/bugfix/index-v4-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1366

Range-diff vs v1:

 1:  be9039c810b ! 1:  0f0fe7cabfd read-cache: avoid misaligned reads in index v4
     @@ Commit message
      
          Avoid this error by reading fields directly from the 'char *' buffer, using
          the 'offsetof' individual fields in 'struct ondisk_cache_entry'.
     +    Additionally, add documentation describing why the new approach avoids the
     +    misaligned address error, as well as advice on how to improve the
     +    implementation in the future.
      
          Reported-by: Jeff King <peff@peff.net>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## read-cache.c ##
      @@ read-cache.c: static int read_index_extension(struct index_state *istate,
     + 	return 0;
     + }
       
     ++/*
     ++ * Parses the contents of the cache entry contained within the 'ondisk' buffer
     ++ * into a new incore 'cache_entry'.
     ++ *
     ++ * Note that 'char *ondisk' may not be aligned to a 4-byte address interval in
     ++ * index v4, so we cannot cast it to 'struct ondisk_cache_entry *' and access
     ++ * its members. Instead, we use the byte offsets of members within the struct to
     ++ * identify where 'get_be16()', 'get_be32()', and 'oidread()' (which can all
     ++ * read from an unaligned memory buffer) should read from the 'ondisk' buffer
     ++ * into the corresponding incore 'cache_entry' members.
     ++ */
       static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
       					    unsigned int version,
      -					    struct ondisk_cache_entry *ondisk,
     @@ read-cache.c: static struct cache_entry *create_from_disk(struct mem_pool *ce_me
      -	ce->ce_stat_data.sd_uid   = get_be32(&ondisk->uid);
      -	ce->ce_stat_data.sd_gid   = get_be32(&ondisk->gid);
      -	ce->ce_stat_data.sd_size  = get_be32(&ondisk->size);
     ++	/*
     ++	 * NEEDSWORK: using 'offsetof()' is cumbersome and should be replaced
     ++	 * with something more akin to 'load_bitmap_entries_v1()'s use of
     ++	 * 'read_be16'/'read_be32'. For consistency with the corresponding
     ++	 * ondisk entry write function ('copy_cache_entry_to_ondisk()'), this
     ++	 * should be done at the same time as removing references to
     ++	 * 'ondisk_cache_entry' there.
     ++	 */
      +	ce->ce_stat_data.sd_ctime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
      +							+ offsetof(struct cache_time, sec));
      +	ce->ce_stat_data.sd_mtime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)


 read-cache.c | 61 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index b09128b1884..32024029274 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1873,9 +1873,20 @@ static int read_index_extension(struct index_state *istate,
 	return 0;
 }
 
+/*
+ * Parses the contents of the cache entry contained within the 'ondisk' buffer
+ * into a new incore 'cache_entry'.
+ *
+ * Note that 'char *ondisk' may not be aligned to a 4-byte address interval in
+ * index v4, so we cannot cast it to 'struct ondisk_cache_entry *' and access
+ * its members. Instead, we use the byte offsets of members within the struct to
+ * identify where 'get_be16()', 'get_be32()', and 'oidread()' (which can all
+ * read from an unaligned memory buffer) should read from the 'ondisk' buffer
+ * into the corresponding incore 'cache_entry' members.
+ */
 static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 					    unsigned int version,
-					    struct ondisk_cache_entry *ondisk,
+					    const char *ondisk,
 					    unsigned long *ent_size,
 					    const struct cache_entry *previous_ce)
 {
@@ -1883,7 +1894,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	size_t len;
 	const char *name;
 	const unsigned hashsz = the_hash_algo->rawsz;
-	const uint16_t *flagsp = (const uint16_t *)(ondisk->data + hashsz);
+	const char *flagsp = ondisk + offsetof(struct ondisk_cache_entry, data) + hashsz;
 	unsigned int flags;
 	size_t copy_len = 0;
 	/*
@@ -1901,15 +1912,15 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 
 	if (flags & CE_EXTENDED) {
 		int extended_flags;
-		extended_flags = get_be16(flagsp + 1) << 16;
+		extended_flags = get_be16(flagsp + sizeof(uint16_t)) << 16;
 		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
 		if (extended_flags & ~CE_EXTENDED_FLAGS)
 			die(_("unknown index entry format 0x%08x"), extended_flags);
 		flags |= extended_flags;
-		name = (const char *)(flagsp + 2);
+		name = (const char *)(flagsp + 2 * sizeof(uint16_t));
 	}
 	else
-		name = (const char *)(flagsp + 1);
+		name = (const char *)(flagsp + sizeof(uint16_t));
 
 	if (expand_name_field) {
 		const unsigned char *cp = (const unsigned char *)name;
@@ -1935,20 +1946,32 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 
 	ce = mem_pool__ce_alloc(ce_mem_pool, len);
 
-	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
-	ce->ce_stat_data.sd_mtime.sec = get_be32(&ondisk->mtime.sec);
-	ce->ce_stat_data.sd_ctime.nsec = get_be32(&ondisk->ctime.nsec);
-	ce->ce_stat_data.sd_mtime.nsec = get_be32(&ondisk->mtime.nsec);
-	ce->ce_stat_data.sd_dev   = get_be32(&ondisk->dev);
-	ce->ce_stat_data.sd_ino   = get_be32(&ondisk->ino);
-	ce->ce_mode  = get_be32(&ondisk->mode);
-	ce->ce_stat_data.sd_uid   = get_be32(&ondisk->uid);
-	ce->ce_stat_data.sd_gid   = get_be32(&ondisk->gid);
-	ce->ce_stat_data.sd_size  = get_be32(&ondisk->size);
+	/*
+	 * NEEDSWORK: using 'offsetof()' is cumbersome and should be replaced
+	 * with something more akin to 'load_bitmap_entries_v1()'s use of
+	 * 'read_be16'/'read_be32'. For consistency with the corresponding
+	 * ondisk entry write function ('copy_cache_entry_to_ondisk()'), this
+	 * should be done at the same time as removing references to
+	 * 'ondisk_cache_entry' there.
+	 */
+	ce->ce_stat_data.sd_ctime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
+							+ offsetof(struct cache_time, sec));
+	ce->ce_stat_data.sd_mtime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
+							+ offsetof(struct cache_time, sec));
+	ce->ce_stat_data.sd_ctime.nsec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
+							 + offsetof(struct cache_time, nsec));
+	ce->ce_stat_data.sd_mtime.nsec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
+							 + offsetof(struct cache_time, nsec));
+	ce->ce_stat_data.sd_dev   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, dev));
+	ce->ce_stat_data.sd_ino   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ino));
+	ce->ce_mode  = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mode));
+	ce->ce_stat_data.sd_uid   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, uid));
+	ce->ce_stat_data.sd_gid   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, gid));
+	ce->ce_stat_data.sd_size  = get_be32(ondisk + offsetof(struct ondisk_cache_entry, size));
 	ce->ce_flags = flags & ~CE_NAMEMASK;
 	ce->ce_namelen = len;
 	ce->index = 0;
-	oidread(&ce->oid, ondisk->data);
+	oidread(&ce->oid, (const unsigned char *)ondisk + offsetof(struct ondisk_cache_entry, data));
 
 	if (expand_name_field) {
 		if (copy_len)
@@ -2117,12 +2140,12 @@ static unsigned long load_cache_entry_block(struct index_state *istate,
 	unsigned long src_offset = start_offset;
 
 	for (i = offset; i < offset + nr; i++) {
-		struct ondisk_cache_entry *disk_ce;
 		struct cache_entry *ce;
 		unsigned long consumed;
 
-		disk_ce = (struct ondisk_cache_entry *)(mmap + src_offset);
-		ce = create_from_disk(ce_mem_pool, istate->version, disk_ce, &consumed, previous_ce);
+		ce = create_from_disk(ce_mem_pool, istate->version,
+				      mmap + src_offset,
+				      &consumed, previous_ce);
 		set_index_entry(istate, i, ce);
 
 		src_offset += consumed;

base-commit: 1b3d6e17fe83eb6f79ffbac2f2c61bbf1eaef5f8
-- 
gitgitgadget
