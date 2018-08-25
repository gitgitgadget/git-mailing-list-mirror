Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E611F404
	for <e@80x24.org>; Sat, 25 Aug 2018 06:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeHYKXi (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 06:23:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36949 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeHYKXi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 06:23:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id j8-v6so8258504lfb.4
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 23:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2C2SrH/os3knPG55JmCLaGy9Ogqqqf1yHGh1pL9inS8=;
        b=jvIZgc0Pkpv9oh9m5NZ9eK/s8s4y5qFDPhrv1lm9R4c5F/7Ng6kYN9uzbCSQkZ250Z
         81LCRfydo0yQO+hLJguKSbbMarEW4gTsoLDAIdBKb3VpSUb+mbJ9iiCHVwzEgT/OB6QT
         QL/9hoAmBIzJK0N22xIX+UIz/AgcteN8gRaEhJZM6YaYsoBOGJSZLksb73jvgUPczJaL
         HLnAu+RaSxk/66V6us752av9Rzyf0Q4ZhJ8WB5T8htFuvIOPFiy9cMiVnDUm9f2oGpCP
         0gJztIbtOFGI0ynoFbpvUsXcj1n0b9oMzcvhlVmaH+UlZjHLkxqXyE/O3Ds/bHK6BU+M
         4LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2C2SrH/os3knPG55JmCLaGy9Ogqqqf1yHGh1pL9inS8=;
        b=T7E6+/NuzyQnWUt7JXtVfqJEDqm1bJLJGjcPwf82LvqXYSK9ulPSlaWzvv3TfvxgqW
         0dvpSTLdWXZ0mZbI/bNNj9+5KCk0G1Ezqzj7I8SWXY2SvPxOCpbJGQFzc3IkyonTk956
         tK7O7JUMOGeRoJZ46PKeJUTD9B1pKECgD69vPGdD5WkMr2h4IcZKhgGtmIGUycTmUCvl
         ibprZLyM+sfRl8obEyMkXyo0ciAFI0xm/iq1dNFoEiiAXaE35QcoThzNm0HxDlX/2auB
         +jM1d3XPppoRvJE48kT+dGmxY1sGXRMAa1iC7mMF4QD17g4yUTZo1eHiOt68fzzH8xoM
         akVg==
X-Gm-Message-State: APzg51DjQr4efv1/sb3OY3ycc9R+ujpIOLmtYy7uR3iE4Yp3/gk/PFrJ
        qhijvjuXmAL7w0tN2o/LVoQ=
X-Google-Smtp-Source: ANB0VdbBsWH7RZnN5hOLr84dmfp8IMReVRom1/9piMOF3Rsb4iLS+oGM9SQ87oXnoMYMcXXMyp3zWg==
X-Received: by 2002:a19:be55:: with SMTP id o82-v6mr3054069lff.58.1535179539774;
        Fri, 24 Aug 2018 23:45:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z189-v6sm1663726lfa.14.2018.08.24.23.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 23:45:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com
Subject: [PATCH] read-cache.c: optimize reading index format v4
Date:   Sat, 25 Aug 2018 08:44:58 +0200
Message-Id: <20180825064458.28484-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180824155734.GA6170@duynguyen.home>
References: <20180824155734.GA6170@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

PS. I notice that v4 does not pad to align entries at 4 byte boundary
like v2/v3. This could cause a slight slow down on x86 and segfault on
some other platforms. We need to fix this in v5 when we introduce
SHA-256 support in the index.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 124 +++++++++++++++++++++++----------------------------
 1 file changed, 56 insertions(+), 68 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..5c04c8f200 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1713,63 +1713,16 @@ int read_index(struct index_state *istate)
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
 static struct cache_entry *create_from_disk(struct mem_pool *mem_pool,
 					    struct ondisk_cache_entry *ondisk,
 					    unsigned long *ent_size,
-					    struct strbuf *previous_name)
+					    const struct cache_entry *previous_ce)
 {
 	struct cache_entry *ce;
 	size_t len;
 	const char *name;
 	unsigned int flags;
+	size_t strip_len;
 
 	/* On-disk flags are just 16 bits */
 	flags = get_be16(&ondisk->flags);
@@ -1782,28 +1735,61 @@ static struct cache_entry *create_from_disk(struct mem_pool *mem_pool,
 		extended_flags = get_be16(&ondisk2->flags2) << 16;
 		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
 		if (extended_flags & ~CE_EXTENDED_FLAGS)
-			die("Unknown index entry format %08x", extended_flags);
+			die(_("unknown index entry format %08x"), extended_flags);
 		flags |= extended_flags;
 		name = ondisk2->name;
 	}
 	else
 		name = ondisk->name;
 
-	if (!previous_name) {
-		/* v3 and earlier */
-		if (len == CE_NAMEMASK)
-			len = strlen(name);
-		ce = cache_entry_from_ondisk(mem_pool, ondisk, flags, name, len);
+	/*
+	 * Adjacent cache entries tend to share the leading paths, so it makes
+	 * sense to only store the differences in later entries.  In the v4
+	 * on-disk format of the index, each on-disk cache entry stores the
+	 * number of bytes to be stripped from the end of the previous name,
+	 * and the bytes to append to the result, to come up with its name.
+	 */
+	if (previous_ce) {
+		const unsigned char *cp = (const unsigned char *)name;
 
-		*ent_size = ondisk_ce_size(ce);
-	} else {
-		unsigned long consumed;
-		consumed = expand_name_field(previous_name, name);
-		ce = cache_entry_from_ondisk(mem_pool, ondisk, flags,
-					     previous_name->buf,
-					     previous_name->len);
+		strip_len = decode_varint(&cp);
+		if (previous_ce->ce_namelen < strip_len)
+			die(_("malformed name field in the index, path '%s'"),
+			    previous_ce->name);
+		name = (const char *)cp;
+	}
 
-		*ent_size = (name - ((char *)ondisk)) + consumed;
+	if (len == CE_NAMEMASK) {
+		len = strlen(name);
+		if (previous_ce)
+			len += previous_ce->ce_namelen - strip_len;
+	}
+
+	ce = mem_pool__ce_alloc(mem_pool, len);
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
+
+	if (previous_ce) {
+		size_t copy_len = previous_ce->ce_namelen - strip_len;
+		memcpy(ce->name, previous_ce->name, copy_len);
+		memcpy(ce->name + copy_len, name, len + 1 - copy_len);
+		*ent_size = (name - ((char *)ondisk)) + len + 1 - copy_len;
+	} else {
+		memcpy(ce->name, name, len + 1);
+		*ent_size = ondisk_ce_size(ce);
 	}
 	return ce;
 }
@@ -1898,7 +1884,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	struct cache_header *hdr;
 	void *mmap;
 	size_t mmap_size;
-	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+	const struct cache_entry *previous_ce = NULL;
+	struct cache_entry *dummy_entry = NULL;
 
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -1936,11 +1923,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->initialized = 1;
 
 	if (istate->version == 4) {
-		previous_name = &previous_name_buf;
+		previous_ce = dummy_entry = make_empty_transient_cache_entry(0);
 		mem_pool_init(&istate->ce_mem_pool,
 			      estimate_cache_size_from_compressed(istate->cache_nr));
 	} else {
-		previous_name = NULL;
 		mem_pool_init(&istate->ce_mem_pool,
 			      estimate_cache_size(mmap_size, istate->cache_nr));
 	}
@@ -1952,12 +1938,14 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		unsigned long consumed;
 
 		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
-		ce = create_from_disk(istate->ce_mem_pool, disk_ce, &consumed, previous_name);
+		ce = create_from_disk(istate->ce_mem_pool, disk_ce, &consumed, previous_ce);
 		set_index_entry(istate, i, ce);
 
 		src_offset += consumed;
+		if (previous_ce)
+			previous_ce = ce;
 	}
-	strbuf_release(&previous_name_buf);
+	free(dummy_entry);
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
-- 
2.19.0.rc0.337.ge906d732e7

