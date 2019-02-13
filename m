Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4E91F453
	for <e@80x24.org>; Wed, 13 Feb 2019 12:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbfBMMIQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 07:08:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42019 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbfBMMIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 07:08:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so1035686pga.9
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 04:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PEhL1agXty+3MwpgyUYIMLsiI1d6v5+T8GT+edBiR0w=;
        b=OEucJsRFJvWxrEpqq8vzJzKkDuAVGN5PcUo56f/lf/Oe5mkrSNV1a4UjOrXl//mIgt
         WnuLAybcmBOzUET6Tc11vkP+E4bylV6bBY5uAlfAGrZhFQ+Aepbcu+qpimAqKdI+gMPb
         Wpt1mVQ5hSggaW4xdrAoyR6vCkxikpTNsomrepK0pi+MoUwGwQ8YbBqc7DKgK2LRL7Cp
         T/duYt2cX/6hoUqLWLcB66ZYoHEpRD+Jy7/IQEn0oQBYdvuZeDztBzvNyxRYK/86yo4O
         wTlsvjUJq4Hq0odXWXNDn1GlfhfKDHDBHCPK2Zd6Gpxc7XyKVez3PQUYyu712bWTa1vc
         zuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PEhL1agXty+3MwpgyUYIMLsiI1d6v5+T8GT+edBiR0w=;
        b=bPQ161dLt0WWfZN/Yj9oQAhb8PVK3unq7mikG4LyiJZmxwjxCzI68KRZBLFDY28A/z
         7aos6MtTN8u3L6OEjNYD2RRvBWb3FIP+wQC7D7NBAUuNWQSj0pKmwgsvxb9m01tC83vx
         1m/Gtx6wQ88xF13Jpdycrp0JZgDFotjgNADcRTIpLwIrsCoPiANiu4LU6stXKfcjXpjz
         1JhuQf3UrvoAWwPcu2fXu99TBxAu/ZNmqX4lxiVmifDB1/DHUeZhjqLh+kGOFmewmQ1A
         twDDS4xlJbcHfxTQ0Mn39Z3lSmKympWUiEe+96hYFaN/LuXtSX9hB292M/XqACpXYykO
         13Xg==
X-Gm-Message-State: AHQUAuZgDUEk4Jp7fe3qH8zv1VWjTouJuyrx6XEWreF3jLBDBycEkXkV
        G1M2WFIYGDQnEYAtBctd+oMGQxfi
X-Google-Smtp-Source: AHgI3IZ1Fw7wQ0qUEbw8bqaO28nBzNaiVaMEXDikIY7qtTmROA27hiKWC5XqyF6kXPdSBSKN/6fyIQ==
X-Received: by 2002:a63:f201:: with SMTP id v1mr171426pgh.232.1550059694788;
        Wed, 13 Feb 2019 04:08:14 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id f62sm20558630pgc.67.2019.02.13.04.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 04:08:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 13 Feb 2019 19:08:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] read-cache.c: index format v5 -- 30% smaller/faster than v4
Date:   Wed, 13 Feb 2019 19:08:07 +0700
Message-Id: <20190213120807.25326-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Index file size more or less translates to write time because we hash
the entire file every time we update the index. And we update the index
quite often (automatically index refresh is done everywhere). This means
smaller index files are faster, especially true for very large
worktrees.

Index v4 attempts to reduce file size by "prefix compressing"
paths. This reduces file size from 17% (git.git) to 41% (webkit.git,
deep hierarchy).

Index v5 takes the same idea to the next level. Instead of compressing
just paths, based on the previous entry, we "compress" a lot more
fields.

Take a look at stat data, st_dev, st_uid, st_gid and st_mode are the
same most of the time. ctime should often be the same (or differs just
slightly). And sometimes mtime is the same as well. st_ino is also
always zero on Windows. We're storing a lot of duplicate values.

Index v5 handles this

 - by adding a "same mask" per entry. If st_dev is the same as previous
   entry, for instance, we set "st_dev is the same" flag and will not
   store it at all, saving 31 bits per entry.

 - even when we store it, "varint" encoding is used. We should rarely
   need to write out 4 bytes

 - for ctime and mtime, even if we have to store it, we store the offset
   instead of absolute numbers. This often leads to smaller numbers,
   which also means fewer bytes to encode.

As a result of this, v5 reduces file size from 30% (git.git) to
36% (webkit.git) compared to v4. Comparing to v2, webkit.git index file
size is reduced by 63%! A 8.4MB index file is _almost_ acceptable.

Of course we trade off storage with cpu. We now need to spend more
cycles writing or even reading (but still plenty fast compared to
zlib). For reading, I'm counting on multi thread to hide away all this
even if it becomes significant.

For writing, I believe the extra cycles spent in writing is still
nothing compared to hashing code and this should still result in faster
index update (numbers needed). On webkit.git, updating one entry on v5
is 30% faster than v4.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I forgot why I started on this again. Something from the mailing
 list... Anyway this looks exciting!

 cache.h      |   2 +-
 read-cache.c | 245 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 234 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index 27fe635f62..fb5175fbb2 100644
--- a/cache.h
+++ b/cache.h
@@ -140,7 +140,7 @@ struct cache_header {
 };
 
 #define INDEX_FORMAT_LB 2
-#define INDEX_FORMAT_UB 4
+#define INDEX_FORMAT_UB 5
 
 /*
  * The "cache_time" is just the low 32 bits of the
diff --git a/read-cache.c b/read-cache.c
index 0e0c93edc9..48c8d24d14 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1733,10 +1733,11 @@ static int read_index_extension(struct index_state *istate,
 
 static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 					    unsigned int version,
-					    struct ondisk_cache_entry *ondisk,
+					    const void *mmap,
 					    unsigned long *ent_size,
 					    const struct cache_entry *previous_ce)
 {
+	const struct ondisk_cache_entry *ondisk = mmap;
 	struct cache_entry *ce;
 	size_t len;
 	const char *name;
@@ -1749,16 +1750,16 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	 * number of bytes to be stripped from the end of the previous name,
 	 * and the bytes to append to the result, to come up with its name.
 	 */
-	int expand_name_field = version == 4;
+	int expand_name_field = version >= 4;
 
 	/* On-disk flags are just 16 bits */
 	flags = get_be16(&ondisk->flags);
 	len = flags & CE_NAMEMASK;
 
 	if (flags & CE_EXTENDED) {
-		struct ondisk_cache_entry_extended *ondisk2;
+		const struct ondisk_cache_entry_extended *ondisk2 = mmap;
 		int extended_flags;
-		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
+
 		extended_flags = get_be16(&ondisk2->flags2) << 16;
 		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
 		if (extended_flags & ~CE_EXTENDED_FLAGS)
@@ -1820,6 +1821,113 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	return ce;
 }
 
+enum same_value_bit {
+	DELTA_FORMAT = 1 << 0,
+	SAME_CTIME   = 1 << 1, /* only covers sec, not nsec */
+	SAME_MTIME   = 1 << 2, /* only covers sec, not nsec */
+	SAME_DEV     = 1 << 3,
+	SAME_INO     = 1 << 4,
+	SAME_MODE    = 1 << 5,
+	SAME_UID     = 1 << 6,
+	SAME_GID     = 1 << 7,
+	SAME_FLAGS   = 1 << 7
+};
+
+static struct cache_entry no_previous_ce;
+
+static uintmax_t decode_varoffset(const unsigned char **bufp, uintmax_t prev)
+{
+	uintmax_t val = decode_varint(bufp);
+
+	return val & 1 ? prev - (val >> 1) : prev + (val >> 1);
+}
+
+static uintmax_t decode_varoffset_same(const unsigned char **bufp, uintmax_t prev,
+				       int same_flag)
+{
+	return same_flag ? prev : decode_varoffset(bufp, prev);
+}
+
+static uintmax_t decode_varint_same(const unsigned char **bufp, uintmax_t prev,
+				    int same_flag)
+{
+	return same_flag ? prev : decode_varint(bufp);
+}
+
+static struct cache_entry *create_from_disk_v5(struct mem_pool *ce_mem_pool,
+					       const void *mmap,
+					       unsigned long *ent_size,
+					       const struct cache_entry *previous_ce)
+{
+	const unsigned char *p = mmap;
+	uintmax_t same_mask = decode_varint(&p);
+	const struct stat_data *old = &previous_ce->ce_stat_data;
+	struct cache_entry tmp;
+	struct stat_data *new = &tmp.ce_stat_data;
+	size_t copy_len = 0;
+	struct cache_entry *ce;
+	size_t len;
+	const char *name;
+	size_t strip_len;
+
+	if (same_mask == 0) {
+		unsigned long consumed;
+		ce = create_from_disk(ce_mem_pool, 5, p, &consumed,
+				      previous_ce == &no_previous_ce ? NULL : previous_ce);
+		*ent_size = consumed + (p - (const unsigned char *)mmap);
+		return ce;
+	}
+
+	if (!(same_mask & DELTA_FORMAT))
+		die(_("bad index file, same_mask must have flag DELTA_FORMAT set"));
+
+
+	new->sd_ctime.sec = decode_varoffset_same(&p, old->sd_ctime.sec,
+						  same_mask & SAME_CTIME);
+	new->sd_ctime.nsec = decode_varoffset(&p, old->sd_ctime.nsec);
+	new->sd_mtime.sec = decode_varoffset_same(&p, old->sd_mtime.sec,
+						  same_mask & SAME_MTIME);
+	new->sd_mtime.nsec = decode_varoffset(&p, old->sd_mtime.nsec);
+	new->sd_dev = decode_varint_same(&p, old->sd_dev,
+					 same_mask & SAME_DEV);
+	new->sd_ino = decode_varint_same(&p, old->sd_ino,
+					 same_mask & SAME_INO);
+	tmp.ce_mode = decode_varint_same(&p, previous_ce->ce_mode,
+					 same_mask & SAME_MODE);
+	new->sd_uid = decode_varint_same(&p, old->sd_uid,
+					 same_mask & SAME_UID);
+	new->sd_gid = decode_varint_same(&p, old->sd_gid,
+					 same_mask & SAME_GID);
+	new->sd_size = decode_varint(&p);
+	memcpy(&tmp.oid.hash, p, GIT_SHA1_RAWSZ);
+	p += GIT_SHA1_RAWSZ;
+	tmp.ce_flags = decode_varint(&p); /* fixme */
+
+	strip_len = decode_varint(&p);
+	if (previous_ce != &no_previous_ce) {
+		size_t previous_len = previous_ce->ce_namelen;
+		if (previous_len < strip_len)
+			die(_("malformed name field in the index, near path '%s'"),
+			    previous_ce->name);
+		copy_len = previous_len - strip_len;
+	}
+	name = (const char *)p;
+
+	len = strlen(name) + copy_len;
+
+	ce = mem_pool__ce_alloc(ce_mem_pool, len);
+	memcpy(ce, &tmp, offsetof(struct cache_entry, name));
+	ce->ce_namelen = len;
+	ce->index = 0;
+
+	if (copy_len)
+		memcpy(ce->name, previous_ce->name, copy_len);
+	memcpy(ce->name + copy_len, name, len + 1 - copy_len);
+	*ent_size = (p - (const unsigned char *)mmap) + len + 1 - copy_len;
+
+	return ce;
+}
+
 static void check_ce_order(struct index_state *istate)
 {
 	unsigned int i;
@@ -1967,12 +2075,18 @@ static unsigned long load_cache_entry_block(struct index_state *istate,
 	unsigned long src_offset = start_offset;
 
 	for (i = offset; i < offset + nr; i++) {
-		struct ondisk_cache_entry *disk_ce;
 		struct cache_entry *ce;
 		unsigned long consumed;
 
-		disk_ce = (struct ondisk_cache_entry *)(mmap + src_offset);
-		ce = create_from_disk(ce_mem_pool, istate->version, disk_ce, &consumed, previous_ce);
+		if (istate->version <= 4)
+			ce = create_from_disk(ce_mem_pool, istate->version,
+					      mmap + src_offset, &consumed,
+					      previous_ce);
+		else
+			ce = create_from_disk_v5(ce_mem_pool,
+						 mmap + src_offset,
+						 &consumed,
+						 previous_ce);
 		set_index_entry(istate, i, ce);
 
 		src_offset += consumed;
@@ -2551,8 +2665,103 @@ static void copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 	}
 }
 
+static int ce_write_varint(git_hash_ctx *c, int fd, uintmax_t value)
+{
+	unsigned char varint[16];
+	int len = encode_varint(value, varint);
+	ce_write(c, fd, varint, len);
+	return len;
+}
+
+static int ce_write_varoffset(git_hash_ctx *c, int fd, uintmax_t next, uintmax_t prev)
+{
+	unsigned char varint[16];
+	uintmax_t value;
+	int len;
+
+	if (prev < next)
+		value = (next - prev) << 1;
+	else
+		value = ((prev - next) << 1) | 1;
+	len = encode_varint(value, varint);
+	ce_write(c, fd, varint, len);
+	return len;
+}
+
+static int ce_write_entry_v5(git_hash_ctx *c, int fd,
+			     struct cache_entry *ce,
+			     const struct cache_entry *previous_ce,
+			     struct ondisk_cache_entry *ondisk,
+			     int size)
+{
+	const struct stat_data *old = &previous_ce->ce_stat_data;
+	struct stat_data *new = &ce->ce_stat_data;
+	const uint32_t flags_mask = 0xf000 | CE_EXTENDED_FLAGS;
+	uint32_t flags;
+	uint32_t same_mask = 0;
+	uint32_t written = 0;
+
+	if (previous_ce == &no_previous_ce) {
+		ce_write(c, fd, &same_mask, 1);
+		copy_cache_entry_to_ondisk(ondisk, ce);
+		return ce_write(c, fd, ondisk, size);
+	}
+
+	same_mask |= DELTA_FORMAT;
+	if (old->sd_ctime.sec == new->sd_ctime.sec)
+		same_mask |= SAME_CTIME;
+	if (old->sd_mtime.sec == new->sd_mtime.sec)
+		same_mask |= SAME_MTIME;
+	if (old->sd_dev == new->sd_dev)
+		same_mask |= SAME_DEV;
+	if (old->sd_ino == new->sd_ino)
+		same_mask |= SAME_INO;
+	if (previous_ce->ce_mode == ce->ce_mode)
+		same_mask |= SAME_MODE;
+	if (old->sd_uid == new->sd_uid)
+		same_mask |= SAME_UID;
+	if (old->sd_gid == new->sd_gid)
+		same_mask |= SAME_GID;
+	if ((previous_ce->ce_flags & flags_mask) == (ce->ce_flags & flags_mask))
+		same_mask |= SAME_FLAGS;
+
+	written += ce_write_varint(c, fd, same_mask);
+	if (!(same_mask & SAME_CTIME))
+		written += ce_write_varoffset(c, fd,
+					      new->sd_ctime.sec,
+					      old->sd_ctime.sec);
+	written += ce_write_varoffset(c, fd,
+				      new->sd_ctime.nsec,
+				      old->sd_ctime.nsec);
+	if (!(same_mask & SAME_MTIME))
+		written += ce_write_varoffset(c, fd,
+					      new->sd_mtime.sec,
+					      old->sd_mtime.sec);
+	written += ce_write_varoffset(c, fd,
+				      new->sd_mtime.nsec,
+				      old->sd_mtime.nsec);
+	if (!(same_mask & SAME_DEV))
+		written += ce_write_varint(c, fd, new->sd_dev);
+	if (!(same_mask & SAME_INO))
+		written += ce_write_varint(c, fd, new->sd_ino);
+	if (!(same_mask & SAME_MODE))
+		written += ce_write_varint(c, fd, ce->ce_mode);
+	if (!(same_mask & SAME_UID))
+		written += ce_write_varint(c, fd, new->sd_uid);
+	if (!(same_mask & SAME_GID))
+		written += ce_write_varint(c, fd, new->sd_gid);
+	written += ce_write_varint(c, fd, new->sd_size);
+	written += ce_write(c, fd, &ce->oid.hash, GIT_SHA1_RAWSZ);
+	flags = (ce->ce_flags & 0xf000) >> 12;
+	flags |= (ce->ce_flags & CE_EXTENDED_FLAGS) >> 25;
+	written += ce_write_varint(c, fd, flags);
+	return written;
+}
+
 static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
-			  struct strbuf *previous_name, struct ondisk_cache_entry *ondisk)
+			  const struct cache_entry *previous_ce,
+			  struct strbuf *previous_name,
+			  struct ondisk_cache_entry *ondisk)
 {
 	int size;
 	int result;
@@ -2591,8 +2800,13 @@ static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
 		to_remove = previous_name->len - common;
 		prefix_size = encode_varint(to_remove, to_remove_vi);
 
-		copy_cache_entry_to_ondisk(ondisk, ce);
-		result = ce_write(c, fd, ondisk, size);
+		if (previous_ce)
+			size = ce_write_entry_v5(c, fd, ce, previous_ce,
+						 ondisk, size);
+		else {
+			copy_cache_entry_to_ondisk(ondisk, ce);
+			result = ce_write(c, fd, ondisk, size);
+		}
 		if (!result)
 			result = ce_write(c, fd, to_remove_vi, prefix_size);
 		if (!result)
@@ -2729,6 +2943,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct stat st;
 	struct ondisk_cache_entry_extended ondisk;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+	const struct cache_entry *previous_ce;
 	int drop_cache_tree = istate->drop_cache_tree;
 	off_t offset;
 	int ieot_entries = 1;
@@ -2807,7 +3022,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	}
 	offset += write_buffer_len;
 	nr = 0;
-	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
+	previous_name = (hdr_version >= 4) ? &previous_name_buf : NULL;
+	previous_ce = hdr_version >= 5 ? &no_previous_ce : NULL;
 
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
@@ -2839,6 +3055,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			 */
 			if (previous_name)
 				previous_name->buf[0] = 0;
+			if (previous_ce)
+				previous_ce = &no_previous_ce;
 			nr = 0;
 			offset = lseek(newfd, 0, SEEK_CUR);
 			if (offset < 0) {
@@ -2847,11 +3065,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			}
 			offset += write_buffer_len;
 		}
-		if (ce_write_entry(&c, newfd, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
+		if (ce_write_entry(&c, newfd, ce, previous_ce, previous_name,
+				   (struct ondisk_cache_entry *)&ondisk) < 0)
 			err = -1;
 
 		if (err)
 			break;
+		if (previous_ce)
+			previous_ce = ce;
 		nr++;
 	}
 	if (ieot && nr) {
-- 
2.21.0.rc0.328.g0e39304f8d

