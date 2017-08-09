Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F15B020899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbdHIBXt (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:49 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36916 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbdHIBX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:26 -0400
Received: by mail-pg0-f53.google.com with SMTP id y129so21571437pgy.4
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=BJyyQZQ7w39eEpOFI1pf3Xf+8i572mVPxun/Z4dtKNo=;
        b=Hi5DiirHVzhEjrqo0yKKO0ifxUwiSYdd2iGr+0TRX8ESvOM0UiELvAmX8Rop3mYEGR
         8b+rVorDSFZh09h98i00UWsiGXAJjhk7K12BdCOxbzGDOwttVuFLCKx1h6jEOQeWJxWf
         C4EYPNH2q1RV3VuTQtAJhWmhsIZ0/y273cBhTaIGLUn9prAB9HT2EWjk9UjFJrXWTTKn
         gAzuTSCWzzKBtF8ljN4IWLMODEoGYIwXZtH79k9sihGee6ZGw4C/T98qlQ9qJqLuH60M
         rnTvPF0SGndM0com5jjawT8t4p0XTHgT2Z+zl8P7P/avIal6WfR3wad2ba9wNImTaySV
         suiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BJyyQZQ7w39eEpOFI1pf3Xf+8i572mVPxun/Z4dtKNo=;
        b=dxto1MIJVkzYNwYYFSfPG9+V93gNeNzPBT09fO/xcJoe+dEEvHl1PetTnzXVOVD9YB
         j1FsDjyRjtkQGzNpJVxuSTTUzicZUy1ksD2nfzUqKpf4XkDWxCIEQCQOcRVoWZS0Cl+Y
         x2Z9GETWjtCy55BjQ5QdVrWV/wYtxuqH/M4ZCQdUh8PwqUZvX7MvZy23tuiEAikUy0OR
         bSvMnLMi/HhpTSDnPaQp/+pTAidPctcpeA0JczX6xJ3E37Q2QJ2DDl8s7zEhbdbhzL39
         v4GIHonDCJTFe96tRDeRCmt+o4pZGA4TrgOhfYbRS2OVcdGx8PgT2pFir0BuOpajGwO7
         gYHA==
X-Gm-Message-State: AHYfb5gMovUsMNQzZcpipg5dcTt5u40aslEP5SPUgpdlcNP+ekgNhsIS
        GwkTfvcuZD7Lpz/56XtJTA==
X-Received: by 10.99.157.8 with SMTP id i8mr5944580pgd.101.1502241805276;
        Tue, 08 Aug 2017 18:23:25 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:24 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 20/25] pack: move find_pack_entry_one(), is_pack_valid()
Date:   Tue,  8 Aug 2017 18:22:52 -0700
Message-Id: <aac511b8028d5c6d0e31f1b173434af2c156c6a5.1502241234.git.jonathantanmy@google.com>
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
 cache.h     |  8 ------
 pack.h      | 10 ++++++--
 packfile.c  | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1_file.c | 84 ------------------------------------------------------------
 4 files changed, 93 insertions(+), 94 deletions(-)

diff --git a/cache.h b/cache.h
index 7686ccb30..b944aca69 100644
--- a/cache.h
+++ b/cache.h
@@ -1618,14 +1618,6 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
  */
 extern int odb_pack_keep(const char *name);
 
-/*
- * If the object named sha1 is present in the specified packfile,
- * return its offset within the packfile; otherwise, return 0.
- */
-extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
-
-extern int is_pack_valid(struct packed_git *);
-
 /*
  * Iterate over the files in the loose-object parts of the object
  * directory "path", triggering the following callbacks:
diff --git a/pack.h b/pack.h
index e0e206e3c..f5bd94813 100644
--- a/pack.h
+++ b/pack.h
@@ -144,8 +144,6 @@ extern void close_pack_windows(struct packed_git *);
 extern void close_pack_index(struct packed_git *);
 extern void close_all_packs(void);
 
-extern int open_packed_git(struct packed_git *p);
-
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
@@ -212,4 +210,12 @@ extern void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
  */
 extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 
+/*
+ * If the object named sha1 is present in the specified packfile,
+ * return its offset within the packfile; otherwise, return 0.
+ */
+extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
+
+extern int is_pack_valid(struct packed_git *);
+
 #endif
diff --git a/packfile.c b/packfile.c
index 94c8af991..71017d2ec 100644
--- a/packfile.c
+++ b/packfile.c
@@ -6,6 +6,7 @@
 #include "delta.h"
 #include "list.h"
 #include "streaming.h"
+#include "sha1-lookup.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -1698,3 +1699,87 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 				   ntohl(*((uint32_t *)(index + 4)));
 	}
 }
+
+off_t find_pack_entry_one(const unsigned char *sha1,
+				  struct packed_git *p)
+{
+	const uint32_t *level1_ofs = p->index_data;
+	const unsigned char *index = p->index_data;
+	unsigned hi, lo, stride;
+	static int use_lookup = -1;
+	static int debug_lookup = -1;
+
+	if (debug_lookup < 0)
+		debug_lookup = !!getenv("GIT_DEBUG_LOOKUP");
+
+	if (!index) {
+		if (open_pack_index(p))
+			return 0;
+		level1_ofs = p->index_data;
+		index = p->index_data;
+	}
+	if (p->index_version > 1) {
+		level1_ofs += 2;
+		index += 8;
+	}
+	index += 4 * 256;
+	hi = ntohl(level1_ofs[*sha1]);
+	lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
+	if (p->index_version > 1) {
+		stride = 20;
+	} else {
+		stride = 24;
+		index += 4;
+	}
+
+	if (debug_lookup)
+		printf("%02x%02x%02x... lo %u hi %u nr %"PRIu32"\n",
+		       sha1[0], sha1[1], sha1[2], lo, hi, p->num_objects);
+
+	if (use_lookup < 0)
+		use_lookup = !!getenv("GIT_USE_LOOKUP");
+	if (use_lookup) {
+		int pos = sha1_entry_pos(index, stride, 0,
+					 lo, hi, p->num_objects, sha1);
+		if (pos < 0)
+			return 0;
+		return nth_packed_object_offset(p, pos);
+	}
+
+	do {
+		unsigned mi = (lo + hi) / 2;
+		int cmp = hashcmp(index + mi * stride, sha1);
+
+		if (debug_lookup)
+			printf("lo %u hi %u rg %u mi %u\n",
+			       lo, hi, hi - lo, mi);
+		if (!cmp)
+			return nth_packed_object_offset(p, mi);
+		if (cmp > 0)
+			hi = mi;
+		else
+			lo = mi+1;
+	} while (lo < hi);
+	return 0;
+}
+
+int is_pack_valid(struct packed_git *p)
+{
+	/* An already open pack is known to be valid. */
+	if (p->pack_fd != -1)
+		return 1;
+
+	/* If the pack has one window completely covering the
+	 * file size, the pack is known to be valid even if
+	 * the descriptor is not currently open.
+	 */
+	if (p->windows) {
+		struct pack_window *w = p->windows;
+
+		if (!w->offset && w->len == p->pack_size)
+			return 1;
+	}
+
+	/* Force the pack to open to prove its valid. */
+	return !open_packed_git(p);
+}
diff --git a/sha1_file.c b/sha1_file.c
index 0f4d68c5a..75b9ceb39 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1073,90 +1073,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-off_t find_pack_entry_one(const unsigned char *sha1,
-				  struct packed_git *p)
-{
-	const uint32_t *level1_ofs = p->index_data;
-	const unsigned char *index = p->index_data;
-	unsigned hi, lo, stride;
-	static int use_lookup = -1;
-	static int debug_lookup = -1;
-
-	if (debug_lookup < 0)
-		debug_lookup = !!getenv("GIT_DEBUG_LOOKUP");
-
-	if (!index) {
-		if (open_pack_index(p))
-			return 0;
-		level1_ofs = p->index_data;
-		index = p->index_data;
-	}
-	if (p->index_version > 1) {
-		level1_ofs += 2;
-		index += 8;
-	}
-	index += 4 * 256;
-	hi = ntohl(level1_ofs[*sha1]);
-	lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
-	if (p->index_version > 1) {
-		stride = 20;
-	} else {
-		stride = 24;
-		index += 4;
-	}
-
-	if (debug_lookup)
-		printf("%02x%02x%02x... lo %u hi %u nr %"PRIu32"\n",
-		       sha1[0], sha1[1], sha1[2], lo, hi, p->num_objects);
-
-	if (use_lookup < 0)
-		use_lookup = !!getenv("GIT_USE_LOOKUP");
-	if (use_lookup) {
-		int pos = sha1_entry_pos(index, stride, 0,
-					 lo, hi, p->num_objects, sha1);
-		if (pos < 0)
-			return 0;
-		return nth_packed_object_offset(p, pos);
-	}
-
-	do {
-		unsigned mi = (lo + hi) / 2;
-		int cmp = hashcmp(index + mi * stride, sha1);
-
-		if (debug_lookup)
-			printf("lo %u hi %u rg %u mi %u\n",
-			       lo, hi, hi - lo, mi);
-		if (!cmp)
-			return nth_packed_object_offset(p, mi);
-		if (cmp > 0)
-			hi = mi;
-		else
-			lo = mi+1;
-	} while (lo < hi);
-	return 0;
-}
-
-int is_pack_valid(struct packed_git *p)
-{
-	/* An already open pack is known to be valid. */
-	if (p->pack_fd != -1)
-		return 1;
-
-	/* If the pack has one window completely covering the
-	 * file size, the pack is known to be valid even if
-	 * the descriptor is not currently open.
-	 */
-	if (p->windows) {
-		struct pack_window *w = p->windows;
-
-		if (!w->offset && w->len == p->pack_size)
-			return 1;
-	}
-
-	/* Force the pack to open to prove its valid. */
-	return !open_packed_git(p);
-}
-
 static int fill_pack_entry(const unsigned char *sha1,
 			   struct pack_entry *e,
 			   struct packed_git *p)
-- 
2.14.0.434.g98096fd7a8-goog

