Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16097208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbdHRWVL (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:11 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33958 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbdHRWVE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:21:04 -0400
Received: by mail-pg0-f51.google.com with SMTP id n4so8535585pgn.1
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=n0HNGSGdUYszsLu66WSP/NPM1OFbP7th6DyJW+qAQTE=;
        b=fMw43B9DbmV8++phEKj1N6MS/k5v46cj8K/wnLa38RB6QXl5WydjCVysiUnu2Wky55
         Bmp0sWvKL7/K+OorxTQPbl/xpYGQrc9fRRKPAIr/EaoXw5YHLjhFnsBs9AgxJZsFCKuQ
         gaQCY9DsR5vH9xbllsMiIlLaqzQs5YOHgluBC4L6d6EYe3MSSXZeq1XGzjAXkRpkDKEB
         kTKhRqiKp6uzsp+DUEoETf8RmK7XTEM5OqQGVUWdpTsom7UR3Rf+xz57xHXZo4OsvHdg
         TZQ4YTrM3fsM7ZS/Z754cbtQHifs/0yATV2I66r114TLq8kZIccPRzt17C1hYN1wqyjy
         4hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=n0HNGSGdUYszsLu66WSP/NPM1OFbP7th6DyJW+qAQTE=;
        b=kICflbCV5ocPqMJHsusvE08hpUQNswjbwV8dXOqCYnQDB5qWJy2EAT8PH/ZDf1ghJX
         1bFZPREmvIpopG6nYavJHvWiVMqgq/jF5p2ZQI/B2CaDLwUWLQHvGZzPmfrqMXPBiSN2
         J856mss3oUKUWHqp/0q0PlJOzKv6yF1EakuHE4pg+XhGYd3mkGF0HLXb0XzTnl9ONL5j
         wlO0P4ZpMa4x//Bu2KzLALc6Y+UfUe1OJ7blftfBzsU4/wNR4hUbvXjeCgNd/nsC1iPa
         Tzv+RhDvc6OYs7CLLB4vNBBX6VW/viYizMOpOU6VsSTETTIN28iaHMifdY6pTjcAQ1+X
         mK7A==
X-Gm-Message-State: AHYfb5j7Bd61EJJyqrKLZcVY2KuXiyqtbST/IymsdrB30AwC3wKG00Sg
        KoLi3WbR/vvXETY++/e/Xg==
X-Received: by 10.99.96.211 with SMTP id u202mr6161238pgb.347.1503094863667;
        Fri, 18 Aug 2017 15:21:03 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:21:03 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 17/23] pack: move check_pack_index_ptr(), nth_packed_object_offset()
Date:   Fri, 18 Aug 2017 15:20:32 -0700
Message-Id: <5f95065362e9eef27eb9738cb5a676e80b80b791.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     | 16 ----------------
 packfile.c  | 33 +++++++++++++++++++++++++++++++++
 packfile.h  | 16 ++++++++++++++++
 sha1_file.c | 33 ---------------------------------
 4 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/cache.h b/cache.h
index 83aa3cc62..ee75a4949 100644
--- a/cache.h
+++ b/cache.h
@@ -1626,22 +1626,6 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
  */
 extern int odb_pack_keep(const char *name);
 
-/*
- * Make sure that a pointer access into an mmap'd index file is within bounds,
- * and can provide at least 8 bytes of data.
- *
- * Note that this is only necessary for variable-length segments of the file
- * (like the 64-bit extended offset table), as we compare the size to the
- * fixed-length parts when we open the file.
- */
-extern void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
-
-/*
- * Return the offset of the nth object within the specified packfile.
- * The index must already be opened.
- */
-extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
-
 /*
  * If the object named sha1 is present in the specified packfile,
  * return its offset within the packfile; otherwise, return 0.
diff --git a/packfile.c b/packfile.c
index e9b16da94..e914422e9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1667,3 +1667,36 @@ const struct object_id *nth_packed_object_oid(struct object_id *oid,
 	hashcpy(oid->hash, hash);
 	return oid;
 }
+
+void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
+{
+	const unsigned char *ptr = vptr;
+	const unsigned char *start = p->index_data;
+	const unsigned char *end = start + p->index_size;
+	if (ptr < start)
+		die(_("offset before start of pack index for %s (corrupt index?)"),
+		    p->pack_name);
+	/* No need to check for underflow; .idx files must be at least 8 bytes */
+	if (ptr >= end - 8)
+		die(_("offset beyond end of pack index for %s (truncated index?)"),
+		    p->pack_name);
+}
+
+off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
+{
+	const unsigned char *index = p->index_data;
+	index += 4 * 256;
+	if (p->index_version == 1) {
+		return ntohl(*((uint32_t *)(index + 24 * n)));
+	} else {
+		uint32_t off;
+		index += 8 + p->num_objects * (20 + 4);
+		off = ntohl(*((uint32_t *)(index + 4 * n)));
+		if (!(off & 0x80000000))
+			return off;
+		index += p->num_objects * 4 + (off & 0x7fffffff) * 8;
+		check_pack_index_ptr(p, index);
+		return (((uint64_t)ntohl(*((uint32_t *)(index + 0)))) << 32) |
+				   ntohl(*((uint32_t *)(index + 4)));
+	}
+}
diff --git a/packfile.h b/packfile.h
index 56d70caa0..8deb84bd1 100644
--- a/packfile.h
+++ b/packfile.h
@@ -63,6 +63,16 @@ extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
+/*
+ * Make sure that a pointer access into an mmap'd index file is within bounds,
+ * and can provide at least 8 bytes of data.
+ *
+ * Note that this is only necessary for variable-length segments of the file
+ * (like the 64-bit extended offset table), as we compare the size to the
+ * fixed-length parts when we open the file.
+ */
+extern void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
+
 /*
  * Return the SHA-1 of the nth object within the specified packfile.
  * Open the index if it is not already open.  The return value points
@@ -77,6 +87,11 @@ extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t
  */
 extern const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
 
+/*
+ * Return the offset of the nth object within the specified packfile.
+ * The index must already be opened.
+ */
+extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
@@ -94,4 +109,5 @@ extern int packed_object_info(struct packed_git *pack, off_t offset, struct obje
 
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 34fbe8e51..2d22bc228 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1074,39 +1074,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
-{
-	const unsigned char *ptr = vptr;
-	const unsigned char *start = p->index_data;
-	const unsigned char *end = start + p->index_size;
-	if (ptr < start)
-		die(_("offset before start of pack index for %s (corrupt index?)"),
-		    p->pack_name);
-	/* No need to check for underflow; .idx files must be at least 8 bytes */
-	if (ptr >= end - 8)
-		die(_("offset beyond end of pack index for %s (truncated index?)"),
-		    p->pack_name);
-}
-
-off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
-{
-	const unsigned char *index = p->index_data;
-	index += 4 * 256;
-	if (p->index_version == 1) {
-		return ntohl(*((uint32_t *)(index + 24 * n)));
-	} else {
-		uint32_t off;
-		index += 8 + p->num_objects * (20 + 4);
-		off = ntohl(*((uint32_t *)(index + 4 * n)));
-		if (!(off & 0x80000000))
-			return off;
-		index += p->num_objects * 4 + (off & 0x7fffffff) * 8;
-		check_pack_index_ptr(p, index);
-		return (((uint64_t)ntohl(*((uint32_t *)(index + 0)))) << 32) |
-				   ntohl(*((uint32_t *)(index + 4)));
-	}
-}
-
 off_t find_pack_entry_one(const unsigned char *sha1,
 				  struct packed_git *p)
 {
-- 
2.14.1.480.gb18f417b89-goog

