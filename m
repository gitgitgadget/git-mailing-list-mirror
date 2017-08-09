Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B6BF20899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbdHIBXz (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:55 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35686 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdHIBXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:25 -0400
Received: by mail-pg0-f52.google.com with SMTP id v189so21580817pgd.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=m1xuYF2rqXQoSk4IqeAy/0dAzFKmB+f8Fru/flVUyiQ=;
        b=L3GRZ8DPRyRBSRSv+ykOjjNnVmLqIUrbVL0Nm6gTeL/aaL81powvnMYAG2ChhOjBYD
         RCmbBvkflEpaAwTdpwvWywazHlQWLY9pbfMLeNO5dT57IDadk3G0++ob0drMsMQ5lIgp
         nuCBkLQqCxEyC8/8tk+n/ibYqNtw77L4rzFW6uhmbDxFWxR8sXQRTG1JnwoQcry3j5pr
         Owcstmed3YUrJRpGtosccelPs/w31uiEMj9dXOHuOm09GZElTQ9Ny+aGHshMeS4IomqQ
         GVup4pFwmxERhTDpPZL/hIreYUCXr/fRuB38vhhXDywwKy0pSewU3DXhDvC9ArPxY1gX
         cpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=m1xuYF2rqXQoSk4IqeAy/0dAzFKmB+f8Fru/flVUyiQ=;
        b=PZTMCUYbznvisv/7qC1c08sqAq92FIdm3/yzPla7kK33ZkTL+GpqaXjhfE0Llfc0WW
         Hq8fxTDp24w1OkSGwv4aQHhJvo42Gy62Qp6MWnyQMjb5fX1gPDa5qx5YtE/+u5Tt9kyn
         f8y3mx+XEjRxDOgTCpbxzTSCWs0w7SYvWT4cNcyoodmyFSRsrymIfkKrl3o3EKipoJr8
         i+fFBwGlp9zUUICg03bUgJco2aNyKt7aaZfXgIxhBBh5kLPcQzBlVQcFYLMlEXJ4xbDq
         l93PvapaF8jhixtQVUtTHRLsAlQEy1ZI2mJ1K09GLDBCueJNLye2epRqjjeiMZY3Qv8l
         wnsw==
X-Gm-Message-State: AHYfb5gErfSh0oFSr24qo+fnbDKZmHdBaD5I+qIJaX+LT31aTSV7hJzL
        +VTaaNPqH3Gb5FuktzslDQ==
X-Received: by 10.99.234.69 with SMTP id l5mr5994053pgk.221.1502241804107;
        Tue, 08 Aug 2017 18:23:24 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:23 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 19/25] pack: move check_pack_index_ptr(), nth_packed_object_offset()
Date:   Tue,  8 Aug 2017 18:22:51 -0700
Message-Id: <69307129445c8fd0fc50f57bdce5d343770c5d70.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     | 16 ----------------
 pack.h      | 16 ++++++++++++++++
 packfile.c  | 33 +++++++++++++++++++++++++++++++++
 sha1_file.c | 33 ---------------------------------
 4 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/cache.h b/cache.h
index f083d532e..7686ccb30 100644
--- a/cache.h
+++ b/cache.h
@@ -1618,22 +1618,6 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
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
diff --git a/pack.h b/pack.h
index 023c97b37..e0e206e3c 100644
--- a/pack.h
+++ b/pack.h
@@ -196,4 +196,20 @@ extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t
  */
 extern const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
 
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
+/*
+ * Return the offset of the nth object within the specified packfile.
+ * The index must already be opened.
+ */
+extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
+
 #endif
diff --git a/packfile.c b/packfile.c
index b16cf648a..94c8af991 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1665,3 +1665,36 @@ const struct object_id *nth_packed_object_oid(struct object_id *oid,
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
diff --git a/sha1_file.c b/sha1_file.c
index 4cd2b1809..0f4d68c5a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1073,39 +1073,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
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
2.14.0.434.g98096fd7a8-goog

