Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6957320899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbdHIBXN (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:13 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:37999 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbdHIBXH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:07 -0400
Received: by mail-pg0-f43.google.com with SMTP id l64so21491936pge.5
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MqXdO/ZfbkFuFMq1hi9N9cCkdX1XNey+EdPa+n+ZX/8=;
        b=HYR5r+ffrEnqhh9WqttSYl8Ga5ZVYCilbV8NnVttga269XBueJFFr9FS92fpgEr1Ur
         BYCJ9hdtqbzt25Uf/Ea4m8q5GPG655YGbHwbtb1D9XmIMwEknyTNivFG/rBypr/JojlJ
         aiYXbvtM8/EPVDB8zh5EHSoFfkhx7I5YLShpJlCJH06VPFpvprE+JtahWJQOT1LPxgXP
         faE4ybfYmkuB95tDgqczbJWKiTeFiUJAHFWjuhwqG7jtvGpI6mrkuBYZh0AqeilQuK0i
         uyCwk+5k69gcikn421OOuE6Jqwr4zQI86/kubJk+CXM3M8eQwJXW4mGfEsjgiGnJYN97
         VHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MqXdO/ZfbkFuFMq1hi9N9cCkdX1XNey+EdPa+n+ZX/8=;
        b=of9lgA+pMiksLTGkYSzO5H2RmRyVwzDferJNuPwU2zt46UR8n7uFoJmh9n50OUoa8w
         Q7CmLD9+lGpCscIUFGSp2SrHB4H2DAt7HiPQAM5WyE7UL9yDnRQV/IklGHmEdVVIwhFx
         5AyXLPoHubxuFm3YzT2IaBA9jtgNr/kzEbhHs2XiMVbrBzo6c1DAV9b0kMGBKjFOz+Fj
         b+OpwNuj8Q6fCjea6fKxGTCqwFhqC7gq/VA3emvEkiO/NITe0OUTn5WpNiUVweLWEmaj
         uNiEeZ14+hgFldNH7COt5Bstv1VRjoDBdwkM9E0l7W0DeWCUJP8+xumHsk05wXWLzgny
         P2cA==
X-Gm-Message-State: AHYfb5iEf06iLVDdtXjBcZv6HTW+2wdv/TnnrPICkL7p3aA8BXYhD3tZ
        3e0B0ajfvSyPtFTMSPrN6A==
X-Received: by 10.99.97.129 with SMTP id v123mr5835256pgb.337.1502241786532;
        Tue, 08 Aug 2017 18:23:06 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:05 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 04/25] pack: move open_pack_index(), parse_pack_index()
Date:   Tue,  8 Aug 2017 18:22:36 -0700
Message-Id: <f5fece9ce66e7e2f466afa1d3be346e4214af26f.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

alloc_packed_git() in packfile.c is duplicated from sha1_file.c. In a
subsequent commit, alloc_packed_git() will be removed from sha1_file.c.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/count-objects.c |   1 +
 cache.h                 |   8 ---
 pack.h                  |   8 +++
 packfile.c              | 149 ++++++++++++++++++++++++++++++++++++++++++++++++
 sha1_file.c             | 140 ---------------------------------------------
 sha1_name.c             |   1 +
 6 files changed, 159 insertions(+), 148 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 1d82e61f2..185d3190a 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -10,6 +10,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "quote.h"
+#include "pack.h"
 
 static unsigned long garbage;
 static off_t size_garbage;
diff --git a/cache.h b/cache.h
index c7f802e4a..5d6839525 100644
--- a/cache.h
+++ b/cache.h
@@ -1603,8 +1603,6 @@ struct pack_entry {
 	struct packed_git *p;
 };
 
-extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
-
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2
@@ -1639,12 +1637,6 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
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
diff --git a/pack.h b/pack.h
index 6098bfe40..5be0ed42a 100644
--- a/pack.h
+++ b/pack.h
@@ -135,4 +135,12 @@ extern size_t pack_mapped;
 
 extern void pack_report(void);
 
+/*
+ * mmap the index file for the specified packfile (if it is not
+ * already mmapped).  Return 0 on success.
+ */
+extern int open_pack_index(struct packed_git *);
+
+extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
+
 #endif
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
diff --git a/sha1_file.c b/sha1_file.c
index 0de39f480..2e414f5f5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -679,130 +679,6 @@ static int has_loose_object(const unsigned char *sha1)
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
@@ -1300,22 +1176,6 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
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
index 74fcb6d78..28b7c9fd8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -9,6 +9,7 @@
 #include "remote.h"
 #include "dir.h"
 #include "sha1-array.h"
+#include "pack.h"
 
 static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *);
 
-- 
2.14.0.434.g98096fd7a8-goog

