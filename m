Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019021F453
	for <e@80x24.org>; Wed, 26 Sep 2018 19:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeI0CJa (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 22:09:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37299 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeI0CJa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 22:09:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id n6-v6so259285qtl.4
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 12:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c0cdpW/ZL38zqaKZW8jRs6AIQhN4Hl6ioweMWbhKqyQ=;
        b=uiSmH1Pm7gahnWmweCaBCvho16BdRAlXcW2DPHXmqcXHBMv1PQDMWl/b3sUJE9ZEkg
         UJqEBlbMeRAysaYtFUOMrKO2eQV/4E928v1OXtwcYsRMO73esAOfKiez7iN0naqf3H9h
         9f58ElD4cmkgHZwAWWWeAycFzG8290pzF+drbpYJ1y4KVGhLC4Q1HISEp/vNNj3hTIXq
         zKHW4e6HmLO+TA7sMHd3uyin+QLJa3z2rZgQdJtQAiTemdifeSGTqJHvAqoCwfV0rpZp
         qHI1+DWNFu9HfYkN+yPItjaHVBXxXIzlFE07Y2WiawMMqxzEGcIP6DtjFV6to5bUv/Ie
         tatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c0cdpW/ZL38zqaKZW8jRs6AIQhN4Hl6ioweMWbhKqyQ=;
        b=EL1KTC29tZyRjPMqNug1SrpS7HPVDoHe6bEDs2rhEZZTZfQKC60Ubhf2r6ZVoqr2Eg
         K3gem2vbZJpB+pkeiW61VE1GK2wOTQidGIKbwUFO/oH/qtzmm53GUyzHbZedLZLAo6NH
         YIrJpxXdf2uURML4sNhDn3yr2Jm9CQzWDP/TSiDDikFGmQNMMu8soDGYyJcn/P5CGC41
         CfvmwESKDtWQnXtbQCIXWukkAVfvd/80NQAfAPyYzz41K7jjrMrsuMLkUdTyjj4qIGGu
         kbD6eFGc6VG9psUf4niR9B4wgK7xwIwYo5PCEYKH787lKZcao+joEjff4iHTuqELxkLF
         Trvw==
X-Gm-Message-State: ABuFfoj9UMusgzHzu3fbrKZk9/pfepPU635rgRozERn3cDmyrs3TO9uF
        7RFa5pRoSDiramZ56rD9IQZ5J6rq5E4=
X-Google-Smtp-Source: ACcGV63msdylh6bzCM7OTIeKDKAvwWpB60l+0A0PXm8sIlPtwtKa5buGN0bIse8CDkwOXts4ZWyd6Q==
X-Received: by 2002:a0c:e2cd:: with SMTP id t13-v6mr5599399qvl.79.1537991694575;
        Wed, 26 Sep 2018 12:54:54 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 23-v6sm3314922qkn.11.2018.09.26.12.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:54:53 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v6 1/7] read-cache.c: optimize reading index format v4
Date:   Wed, 26 Sep 2018 15:54:36 -0400
Message-Id: <20180926195442.1380-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20180926195442.1380-1-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Index format v4 requires some more computation to assemble a path
based on a previous one. The current code is not very efficient
because

 - it doubles memory copy, we assemble the final path in a temporary
   first before putting it back to a cache_entry

 - strbuf_remove() in expand_name_field() is not exactly a good fit
   for stripping a part at the end, _setlen() would do the same job
   and is much cheaper.

 - the open-coded loop to find the end of the string in
   expand_name_field() can't beat an optimized strlen()

This patch avoids the temporary buffer and writes directly to the new
cache_entry, which addresses the first two points. The last point
could also be avoided if the total string length fits in the first 12
bits of ce_flags, if not we fall back to strlen().

Running "test-tool read-cache 100" on webkit.git (275k files), reading
v2 only takes 4.226 seconds, while v4 takes 5.711 seconds, 35% more
time. The patch reduces read time on v4 to 4.319 seconds.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 128 ++++++++++++++++++++++++---------------------------
 1 file changed, 60 insertions(+), 68 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 8d04d78a58..583a4fb1f8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1713,63 +1713,24 @@ int read_index(struct index_state *istate)
 	return read_index_from(istate, get_index_file(), get_git_dir());
 }
 
-static struct cache_entry *cache_entry_from_ondisk(struct mem_pool *mem_pool,
-						   struct ondisk_cache_entry *ondisk,
-						   unsigned int flags,
-						   const char *name,
-						   size_t len)
-{
-	struct cache_entry *ce = mem_pool__ce_alloc(mem_pool, len);
-
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
-	ce->ce_flags = flags & ~CE_NAMEMASK;
-	ce->ce_namelen = len;
-	ce->index = 0;
-	hashcpy(ce->oid.hash, ondisk->sha1);
-	memcpy(ce->name, name, len);
-	ce->name[len] = '\0';
-	return ce;
-}
-
-/*
- * Adjacent cache entries tend to share the leading paths, so it makes
- * sense to only store the differences in later entries.  In the v4
- * on-disk format of the index, each on-disk cache entry stores the
- * number of bytes to be stripped from the end of the previous name,
- * and the bytes to append to the result, to come up with its name.
- */
-static unsigned long expand_name_field(struct strbuf *name, const char *cp_)
-{
-	const unsigned char *ep, *cp = (const unsigned char *)cp_;
-	size_t len = decode_varint(&cp);
-
-	if (name->len < len)
-		die("malformed name field in the index");
-	strbuf_remove(name, name->len - len, len);
-	for (ep = cp; *ep; ep++)
-		; /* find the end */
-	strbuf_add(name, cp, ep - cp);
-	return (const char *)ep + 1 - cp_;
-}
-
-static struct cache_entry *create_from_disk(struct mem_pool *mem_pool,
+static struct cache_entry *create_from_disk(struct index_state *istate,
 					    struct ondisk_cache_entry *ondisk,
 					    unsigned long *ent_size,
-					    struct strbuf *previous_name)
+					    const struct cache_entry *previous_ce)
 {
 	struct cache_entry *ce;
 	size_t len;
 	const char *name;
 	unsigned int flags;
+	size_t copy_len;
+	/*
+	 * Adjacent cache entries tend to share the leading paths, so it makes
+	 * sense to only store the differences in later entries.  In the v4
+	 * on-disk format of the index, each on-disk cache entry stores the
+	 * number of bytes to be stripped from the end of the previous name,
+	 * and the bytes to append to the result, to come up with its name.
+	 */
+	int expand_name_field = istate->version == 4;
 
 	/* On-disk flags are just 16 bits */
 	flags = get_be16(&ondisk->flags);
@@ -1789,21 +1750,54 @@ static struct cache_entry *create_from_disk(struct mem_pool *mem_pool,
 	else
 		name = ondisk->name;
 
-	if (!previous_name) {
-		/* v3 and earlier */
-		if (len == CE_NAMEMASK)
-			len = strlen(name);
-		ce = cache_entry_from_ondisk(mem_pool, ondisk, flags, name, len);
+	if (expand_name_field) {
+		const unsigned char *cp = (const unsigned char *)name;
+		size_t strip_len, previous_len;
 
-		*ent_size = ondisk_ce_size(ce);
-	} else {
-		unsigned long consumed;
-		consumed = expand_name_field(previous_name, name);
-		ce = cache_entry_from_ondisk(mem_pool, ondisk, flags,
-					     previous_name->buf,
-					     previous_name->len);
+		previous_len = previous_ce ? previous_ce->ce_namelen : 0;
+		strip_len = decode_varint(&cp);
+		if (previous_len < strip_len) {
+			if (previous_ce)
+				die(_("malformed name field in the index, near path '%s'"),
+				    previous_ce->name);
+			else
+				die(_("malformed name field in the index in the first path"));
+		}
+		copy_len = previous_len - strip_len;
+		name = (const char *)cp;
+	}
+
+	if (len == CE_NAMEMASK) {
+		len = strlen(name);
+		if (expand_name_field)
+			len += copy_len;
+	}
+
+	ce = mem_pool__ce_alloc(istate->ce_mem_pool, len);
+
+	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
+	ce->ce_stat_data.sd_mtime.sec = get_be32(&ondisk->mtime.sec);
+	ce->ce_stat_data.sd_ctime.nsec = get_be32(&ondisk->ctime.nsec);
+	ce->ce_stat_data.sd_mtime.nsec = get_be32(&ondisk->mtime.nsec);
+	ce->ce_stat_data.sd_dev   = get_be32(&ondisk->dev);
+	ce->ce_stat_data.sd_ino   = get_be32(&ondisk->ino);
+	ce->ce_mode  = get_be32(&ondisk->mode);
+	ce->ce_stat_data.sd_uid   = get_be32(&ondisk->uid);
+	ce->ce_stat_data.sd_gid   = get_be32(&ondisk->gid);
+	ce->ce_stat_data.sd_size  = get_be32(&ondisk->size);
+	ce->ce_flags = flags & ~CE_NAMEMASK;
+	ce->ce_namelen = len;
+	ce->index = 0;
+	hashcpy(ce->oid.hash, ondisk->sha1);
 
-		*ent_size = (name - ((char *)ondisk)) + consumed;
+	if (expand_name_field) {
+		if (copy_len)
+			memcpy(ce->name, previous_ce->name, copy_len);
+		memcpy(ce->name + copy_len, name, len + 1 - copy_len);
+		*ent_size = (name - ((char *)ondisk)) + len + 1 - copy_len;
+	} else {
+		memcpy(ce->name, name, len + 1);
+		*ent_size = ondisk_ce_size(ce);
 	}
 	return ce;
 }
@@ -1898,7 +1892,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	struct cache_header *hdr;
 	void *mmap;
 	size_t mmap_size;
-	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+	const struct cache_entry *previous_ce = NULL;
 
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -1936,11 +1930,9 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->initialized = 1;
 
 	if (istate->version == 4) {
-		previous_name = &previous_name_buf;
 		mem_pool_init(&istate->ce_mem_pool,
 			      estimate_cache_size_from_compressed(istate->cache_nr));
 	} else {
-		previous_name = NULL;
 		mem_pool_init(&istate->ce_mem_pool,
 			      estimate_cache_size(mmap_size, istate->cache_nr));
 	}
@@ -1952,12 +1944,12 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		unsigned long consumed;
 
 		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
-		ce = create_from_disk(istate->ce_mem_pool, disk_ce, &consumed, previous_name);
+		ce = create_from_disk(istate, disk_ce, &consumed, previous_ce);
 		set_index_entry(istate, i, ce);
 
 		src_offset += consumed;
+		previous_ce = ce;
 	}
-	strbuf_release(&previous_name_buf);
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
-- 
2.18.0.windows.1

