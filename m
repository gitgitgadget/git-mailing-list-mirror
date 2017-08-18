Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493B3208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbdHRWWC (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:22:02 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36397 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdHRWUu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:20:50 -0400
Received: by mail-pg0-f48.google.com with SMTP id i12so72233405pgr.3
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FqjIJPOrW4ni/MvN5La5dp0eWMZJco6LFhBHJQYf8io=;
        b=S5cZt3Nk2aXER8yFkF/21YhqLJZY6Y0U7aI3OyKL5ecd1zrlfWI/XxpaI8H3JQCDpR
         OgQVZmkw0K/f83cFkll67oe3DjeJ7u/BdkOJDJmip2+nYGe2wcSl/RxDHwGZsHOL1OS1
         vvCNpb4qZ+loUfVH7cXCg5xyFVOarSmNF/o+nSHIVs0vpXUFBoMDRn/NgHfT+9FFNEfq
         aLe9kPslTrsMvcMbZe5qKUAWYIzHsa91YnkPcxT5CbVLdz6/ApbMv44OpIvNEFnzkH9e
         Rc3Pi3ik0sroubvluige4GmAy4PDXGfPRXHW9iPmZCWBF5sZOtuSqluAomQgwnp/XHY+
         5KxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FqjIJPOrW4ni/MvN5La5dp0eWMZJco6LFhBHJQYf8io=;
        b=G6YUw3ElTGygymD76YynbBSuC8ZlbfWfpFcR15LM//wzQMK47XJ3dmjNnZitUpPkGA
         PHUFNdaoF7DVP8NjF+ANKBo279AJ+kYbANxR0j6IwBrGmz3r+HRd3uANxDUVXNo/xgWH
         9QaVsupPVvNUoCAVPdpWJ4hACps1eZZqOQGwZ+9GXHaOUrDDXvQDshLp1yTMLtLQHzQm
         AD+Fx1x1fVapUdjfnZKhrXTyzZ5DvQhY1nvFbufJUV6a/+SmXdtjdEGwXbHKo31FvBr6
         g4IdU1G9axWrEtzQwrVb73SUC1MWj7quSuidoidQE2fd3CA5HywVwVI5zEwpe3/twJEZ
         R2xg==
X-Gm-Message-State: AHYfb5jkc4O/hwElSR6q5N558tUAiI0uU5UdtVfXyt3PywTUYk2/jyvs
        4U27cH56BKvka+4g4R5T1Q==
X-Received: by 10.84.143.129 with SMTP id 1mr10938401plz.88.1503094849715;
        Fri, 18 Aug 2017 15:20:49 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:48 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 04/23] pack: move open_pack_index(), parse_pack_index()
Date:   Fri, 18 Aug 2017 15:20:19 -0700
Message-Id: <2e70949481a9e5b3fc906a6346f10ddd4046f33e.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

alloc_packed_git() in packfile.c is duplicated from sha1_file.c. In a
subsequent commit, alloc_packed_git() will be removed from sha1_file.c.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/count-objects.c |   1 +
 builtin/fsck.c          |   1 +
 builtin/pack-objects.c  |   1 +
 cache.h                 |   8 ---
 pack-bitmap.c           |   1 +
 pack-check.c            |   1 +
 packfile.c              | 149 ++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.h              |   8 +++
 sha1_file.c             | 140 ---------------------------------------------
 sha1_name.c             |   1 +
 10 files changed, 163 insertions(+), 148 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 1d82e61f2..33343818c 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -10,6 +10,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "quote.h"
+#include "packfile.h"
 
 static unsigned long garbage;
 static off_t size_garbage;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 99dea7adf..c56207b21 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -15,6 +15,7 @@
 #include "progress.h"
 #include "streaming.h"
 #include "decorate.h"
+#include "packfile.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5c5d3d507..08f05cb84 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -25,6 +25,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "mru.h"
+#include "packfile.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
diff --git a/cache.h b/cache.h
index a0497d469..f271033db 100644
--- a/cache.h
+++ b/cache.h
@@ -1611,8 +1611,6 @@ struct pack_entry {
 	struct packed_git *p;
 };
 
-extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
-
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2
@@ -1647,12 +1645,6 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
  */
 extern int odb_pack_keep(const char *name);
 
-/*
- * mmap the index file for the specified packfile (if it is not
- * already mmapped).  Return 0 on success.
- */
-extern int open_pack_index(struct packed_git *);
-
 /*
  * munmap the index file for the specified packfile (if it is
  * currently mmapped).
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 327634cd7..cb3d14ba4 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -9,6 +9,7 @@
 #include "pack-bitmap.h"
 #include "pack-revindex.h"
 #include "pack-objects.h"
+#include "packfile.h"
 
 /*
  * An entry on the bitmap index, representing the bitmap for a given
diff --git a/pack-check.c b/pack-check.c
index 84469168a..2086f5bb7 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -2,6 +2,7 @@
 #include "pack.h"
 #include "pack-revindex.h"
 #include "progress.h"
+#include "packfile.h"
 
 struct idx_entry {
 	off_t                offset;
diff --git a/packfile.c b/packfile.c
index 60d9fc3b0..6edc43228 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "mru.h"
+#include "pack.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -59,3 +60,151 @@ void pack_report(void)
 		pack_open_windows, peak_pack_open_windows,
 		sz_fmt(pack_mapped), sz_fmt(peak_pack_mapped));
 }
+
+/*
+ * Open and mmap the index file at path, perform a couple of
+ * consistency checks, then record its information to p.  Return 0 on
+ * success.
+ */
+static int check_packed_git_idx(const char *path, struct packed_git *p)
+{
+	void *idx_map;
+	struct pack_idx_header *hdr;
+	size_t idx_size;
+	uint32_t version, nr, i, *index;
+	int fd = git_open(path);
+	struct stat st;
+
+	if (fd < 0)
+		return -1;
+	if (fstat(fd, &st)) {
+		close(fd);
+		return -1;
+	}
+	idx_size = xsize_t(st.st_size);
+	if (idx_size < 4 * 256 + 20 + 20) {
+		close(fd);
+		return error("index file %s is too small", path);
+	}
+	idx_map = xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	hdr = idx_map;
+	if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
+		version = ntohl(hdr->idx_version);
+		if (version < 2 || version > 2) {
+			munmap(idx_map, idx_size);
+			return error("index file %s is version %"PRIu32
+				     " and is not supported by this binary"
+				     " (try upgrading GIT to a newer version)",
+				     path, version);
+		}
+	} else
+		version = 1;
+
+	nr = 0;
+	index = idx_map;
+	if (version > 1)
+		index += 2;  /* skip index header */
+	for (i = 0; i < 256; i++) {
+		uint32_t n = ntohl(index[i]);
+		if (n < nr) {
+			munmap(idx_map, idx_size);
+			return error("non-monotonic index %s", path);
+		}
+		nr = n;
+	}
+
+	if (version == 1) {
+		/*
+		 * Total size:
+		 *  - 256 index entries 4 bytes each
+		 *  - 24-byte entries * nr (20-byte sha1 + 4-byte offset)
+		 *  - 20-byte SHA1 of the packfile
+		 *  - 20-byte SHA1 file checksum
+		 */
+		if (idx_size != 4*256 + nr * 24 + 20 + 20) {
+			munmap(idx_map, idx_size);
+			return error("wrong index v1 file size in %s", path);
+		}
+	} else if (version == 2) {
+		/*
+		 * Minimum size:
+		 *  - 8 bytes of header
+		 *  - 256 index entries 4 bytes each
+		 *  - 20-byte sha1 entry * nr
+		 *  - 4-byte crc entry * nr
+		 *  - 4-byte offset entry * nr
+		 *  - 20-byte SHA1 of the packfile
+		 *  - 20-byte SHA1 file checksum
+		 * And after the 4-byte offset table might be a
+		 * variable sized table containing 8-byte entries
+		 * for offsets larger than 2^31.
+		 */
+		unsigned long min_size = 8 + 4*256 + nr*(20 + 4 + 4) + 20 + 20;
+		unsigned long max_size = min_size;
+		if (nr)
+			max_size += (nr - 1)*8;
+		if (idx_size < min_size || idx_size > max_size) {
+			munmap(idx_map, idx_size);
+			return error("wrong index v2 file size in %s", path);
+		}
+		if (idx_size != min_size &&
+		    /*
+		     * make sure we can deal with large pack offsets.
+		     * 31-bit signed offset won't be enough, neither
+		     * 32-bit unsigned one will be.
+		     */
+		    (sizeof(off_t) <= 4)) {
+			munmap(idx_map, idx_size);
+			return error("pack too large for current definition of off_t in %s", path);
+		}
+	}
+
+	p->index_version = version;
+	p->index_data = idx_map;
+	p->index_size = idx_size;
+	p->num_objects = nr;
+	return 0;
+}
+
+int open_pack_index(struct packed_git *p)
+{
+	char *idx_name;
+	size_t len;
+	int ret;
+
+	if (p->index_data)
+		return 0;
+
+	if (!strip_suffix(p->pack_name, ".pack", &len))
+		die("BUG: pack_name does not end in .pack");
+	idx_name = xstrfmt("%.*s.idx", (int)len, p->pack_name);
+	ret = check_packed_git_idx(idx_name, p);
+	free(idx_name);
+	return ret;
+}
+
+static struct packed_git *alloc_packed_git(int extra)
+{
+	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
+	memset(p, 0, sizeof(*p));
+	p->pack_fd = -1;
+	return p;
+}
+
+struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
+{
+	const char *path = sha1_pack_name(sha1);
+	size_t alloc = st_add(strlen(path), 1);
+	struct packed_git *p = alloc_packed_git(alloc);
+
+	memcpy(p->pack_name, path, alloc); /* includes NUL */
+	hashcpy(p->sha1, sha1);
+	if (check_packed_git_idx(idx_path, p)) {
+		free(p);
+		return NULL;
+	}
+
+	return p;
+}
diff --git a/packfile.h b/packfile.h
index bfa94c8fe..703887d41 100644
--- a/packfile.h
+++ b/packfile.h
@@ -33,6 +33,14 @@ extern unsigned int pack_max_fds;
 extern size_t peak_pack_mapped;
 extern size_t pack_mapped;
 
+extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
+
 extern void pack_report(void);
 
+/*
+ * mmap the index file for the specified packfile (if it is not
+ * already mmapped).  Return 0 on success.
+ */
+extern int open_pack_index(struct packed_git *);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index f7c8152ac..475d2032d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -680,130 +680,6 @@ static int has_loose_object(const unsigned char *sha1)
 	return check_and_freshen(sha1, 0);
 }
 
-/*
- * Open and mmap the index file at path, perform a couple of
- * consistency checks, then record its information to p.  Return 0 on
- * success.
- */
-static int check_packed_git_idx(const char *path, struct packed_git *p)
-{
-	void *idx_map;
-	struct pack_idx_header *hdr;
-	size_t idx_size;
-	uint32_t version, nr, i, *index;
-	int fd = git_open(path);
-	struct stat st;
-
-	if (fd < 0)
-		return -1;
-	if (fstat(fd, &st)) {
-		close(fd);
-		return -1;
-	}
-	idx_size = xsize_t(st.st_size);
-	if (idx_size < 4 * 256 + 20 + 20) {
-		close(fd);
-		return error("index file %s is too small", path);
-	}
-	idx_map = xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	close(fd);
-
-	hdr = idx_map;
-	if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
-		version = ntohl(hdr->idx_version);
-		if (version < 2 || version > 2) {
-			munmap(idx_map, idx_size);
-			return error("index file %s is version %"PRIu32
-				     " and is not supported by this binary"
-				     " (try upgrading GIT to a newer version)",
-				     path, version);
-		}
-	} else
-		version = 1;
-
-	nr = 0;
-	index = idx_map;
-	if (version > 1)
-		index += 2;  /* skip index header */
-	for (i = 0; i < 256; i++) {
-		uint32_t n = ntohl(index[i]);
-		if (n < nr) {
-			munmap(idx_map, idx_size);
-			return error("non-monotonic index %s", path);
-		}
-		nr = n;
-	}
-
-	if (version == 1) {
-		/*
-		 * Total size:
-		 *  - 256 index entries 4 bytes each
-		 *  - 24-byte entries * nr (20-byte sha1 + 4-byte offset)
-		 *  - 20-byte SHA1 of the packfile
-		 *  - 20-byte SHA1 file checksum
-		 */
-		if (idx_size != 4*256 + nr * 24 + 20 + 20) {
-			munmap(idx_map, idx_size);
-			return error("wrong index v1 file size in %s", path);
-		}
-	} else if (version == 2) {
-		/*
-		 * Minimum size:
-		 *  - 8 bytes of header
-		 *  - 256 index entries 4 bytes each
-		 *  - 20-byte sha1 entry * nr
-		 *  - 4-byte crc entry * nr
-		 *  - 4-byte offset entry * nr
-		 *  - 20-byte SHA1 of the packfile
-		 *  - 20-byte SHA1 file checksum
-		 * And after the 4-byte offset table might be a
-		 * variable sized table containing 8-byte entries
-		 * for offsets larger than 2^31.
-		 */
-		unsigned long min_size = 8 + 4*256 + nr*(20 + 4 + 4) + 20 + 20;
-		unsigned long max_size = min_size;
-		if (nr)
-			max_size += (nr - 1)*8;
-		if (idx_size < min_size || idx_size > max_size) {
-			munmap(idx_map, idx_size);
-			return error("wrong index v2 file size in %s", path);
-		}
-		if (idx_size != min_size &&
-		    /*
-		     * make sure we can deal with large pack offsets.
-		     * 31-bit signed offset won't be enough, neither
-		     * 32-bit unsigned one will be.
-		     */
-		    (sizeof(off_t) <= 4)) {
-			munmap(idx_map, idx_size);
-			return error("pack too large for current definition of off_t in %s", path);
-		}
-	}
-
-	p->index_version = version;
-	p->index_data = idx_map;
-	p->index_size = idx_size;
-	p->num_objects = nr;
-	return 0;
-}
-
-int open_pack_index(struct packed_git *p)
-{
-	char *idx_name;
-	size_t len;
-	int ret;
-
-	if (p->index_data)
-		return 0;
-
-	if (!strip_suffix(p->pack_name, ".pack", &len))
-		die("BUG: pack_name does not end in .pack");
-	idx_name = xstrfmt("%.*s.idx", (int)len, p->pack_name);
-	ret = check_packed_git_idx(idx_name, p);
-	free(idx_name);
-	return ret;
-}
-
 static void scan_windows(struct packed_git *p,
 	struct packed_git **lru_p,
 	struct pack_window **lru_w,
@@ -1301,22 +1177,6 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	return p;
 }
 
-struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
-{
-	const char *path = sha1_pack_name(sha1);
-	size_t alloc = st_add(strlen(path), 1);
-	struct packed_git *p = alloc_packed_git(alloc);
-
-	memcpy(p->pack_name, path, alloc); /* includes NUL */
-	hashcpy(p->sha1, sha1);
-	if (check_packed_git_idx(idx_path, p)) {
-		free(p);
-		return NULL;
-	}
-
-	return p;
-}
-
 void install_packed_git(struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
diff --git a/sha1_name.c b/sha1_name.c
index 74fcb6d78..ae237809c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -9,6 +9,7 @@
 #include "remote.h"
 #include "dir.h"
 #include "sha1-array.h"
+#include "packfile.h"
 
 static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *);
 
-- 
2.14.1.480.gb18f417b89-goog

