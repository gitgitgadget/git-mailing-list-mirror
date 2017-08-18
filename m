Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF04208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbdHRWVc (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:32 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35731 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbdHRWVG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:21:06 -0400
Received: by mail-pg0-f52.google.com with SMTP id q6so1094587pgs.2
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qimqiG5b6LSz+lGe/L7MUVBK+LMiyr7WCKwv1u1ewTM=;
        b=uZYzH5udvZd/biHOKzgAMQNBTGVNmEkujl5gyykxRkTqlrqrdJuDTb3JENZ3I56kVX
         ICZcldw7mmHyrSdpV5EHat1JoEIcNQfvUP0SOmlpmFvF1HFw6cXNFBqGFp0IRn5WA0X3
         vR2nSUnlVXwI8WxC42U4RboQUqWAC9PJPjsHzfKwEvQVo1dstNuwcHCG58GVYVvPPBKF
         f0EaIJbyn8qxTgG2WsXAjcFjL4J/57u91XJ6FNTiv+b6djeaN61pK1OVZODfzCGnMgfM
         rzHfifZp/vkJUMNqvat8+SMEHR9RWGRuxnHQTgC4NcXdlW5QB1eorhuptqYHAnU3iCiN
         MOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qimqiG5b6LSz+lGe/L7MUVBK+LMiyr7WCKwv1u1ewTM=;
        b=ZxIPglwTfPSuugTWnSOIihO7lii80eBhPXW5wPWE4a6o8iFfkir92LjRQG7vRCxEJ5
         HpCv6OSbkYEsnOtnZqfpK3FlKkCNA82fksJo9FwQ60yGB6GeXYg+shSh6Q2uu99KqjK4
         ZDNyA38jzybA9ZvzluY/AxMNh09hAhUoIb+xU5C+tqLcicT6LlD6BuJgVNFnO0exUN62
         wApbgQWg8qAd1fXu95ZGQZQhSv+gVM17/tjqaxaH81gEHk3JBfgFmRXjumkDR8HU8ezu
         m6zNxFJID8RYpGY1mAdE6QCF9RoROostcag7CYv/8Ug+SXTEkSZvi5r8djdn0XmDQHyE
         A01w==
X-Gm-Message-State: AHYfb5gMTiflksmMQSjb2NtsJ6Zg2TLPfT+rT7rpww/ahnJN8pE3E1ay
        p/G5MaYU5NsCwzgvW3UcNQ==
X-Received: by 10.99.97.145 with SMTP id v139mr7307963pgb.200.1503094865352;
        Fri, 18 Aug 2017 15:21:05 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:21:03 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 18/23] pack: move find_pack_entry_one(), is_pack_valid()
Date:   Fri, 18 Aug 2017 15:20:33 -0700
Message-Id: <52471e0c5f65e24cac559c922825f0e23449eb32.1503094448.git.jonathantanmy@google.com>
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
 cache.h     |  8 -------
 packfile.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 packfile.h  |  9 ++++++--
 sha1_file.c | 73 ----------------------------------------------------------
 4 files changed, 82 insertions(+), 84 deletions(-)

diff --git a/cache.h b/cache.h
index ee75a4949..9297d078a 100644
--- a/cache.h
+++ b/cache.h
@@ -1626,14 +1626,6 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
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
diff --git a/packfile.c b/packfile.c
index e914422e9..ad7336594 100644
--- a/packfile.c
+++ b/packfile.c
@@ -7,6 +7,7 @@
 #include "delta.h"
 #include "list.h"
 #include "streaming.h"
+#include "sha1-lookup.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -509,7 +510,7 @@ static int open_packed_git_1(struct packed_git *p)
 	return 0;
 }
 
-int open_packed_git(struct packed_git *p)
+static int open_packed_git(struct packed_git *p)
 {
 	if (!open_packed_git_1(p))
 		return 0;
@@ -1700,3 +1701,76 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
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
+	while (lo < hi) {
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
+	}
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
diff --git a/packfile.h b/packfile.h
index 8deb84bd1..4fca6fb28 100644
--- a/packfile.h
+++ b/packfile.h
@@ -93,6 +93,13 @@ extern const struct object_id *nth_packed_object_oid(struct object_id *, struct
  */
 extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 
+/*
+ * If the object named sha1 is present in the specified packfile,
+ * return its offset within the packfile; otherwise, return 0.
+ */
+extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
+
+extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
@@ -100,8 +107,6 @@ extern int unpack_object_header(struct packed_git *, struct pack_window **, off_
 
 extern void release_pack_memory(size_t);
 
-extern int open_packed_git(struct packed_git *p);
-
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
 
diff --git a/sha1_file.c b/sha1_file.c
index 2d22bc228..27714f5e1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1074,79 +1074,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-off_t find_pack_entry_one(const unsigned char *sha1,
-				  struct packed_git *p)
-{
-	const uint32_t *level1_ofs = p->index_data;
-	const unsigned char *index = p->index_data;
-	unsigned hi, lo, stride;
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
-	while (lo < hi) {
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
-	}
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
2.14.1.480.gb18f417b89-goog

