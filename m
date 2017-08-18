Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FFFF208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbdHRWVL (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:11 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33642 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdHRWVA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:21:00 -0400
Received: by mail-pg0-f52.google.com with SMTP id t3so44140064pgt.0
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=y1/ZEyr78b4kUHWBSKE7YrAgV1isx7PefPIcHcfxiTc=;
        b=OnRcb/mfpY45uLWEjX1w1TFEWcNR3hqRva9Znu91J4yVIAOAYtLh4c3dTJE3+bzgm7
         g/6Vo503QMyz0PqbvyDObyJi1hmgtkXYsVIOlSITEmiQtujffohSfPjp4buLBjVGHfnn
         sSnWwGHsuG5TcyStd17d+l+RRYhd4olimkTaR2ywG0owdZY+mBwCMXxyC4YIMbs+rN7w
         ZaM1bOy3c5HJxMEeVs8vwzjFXO3bij5F02kyyIacGH2LBhvr77qPmdFlht6dco+8eeQV
         Z8g8AOL2bB/aprONQYTXpENjtHpKHVEb/yUb6uK9yUDobliZ6fJ/Cyk1plH0j5wNTPm9
         ZO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=y1/ZEyr78b4kUHWBSKE7YrAgV1isx7PefPIcHcfxiTc=;
        b=Zl0+UdB2v/6Kng28ZeIkSB2XfYk/30JWdkozCrupp/cGZydC6Mf/5l2cIF/6NANa1n
         nXSh+GI5cr1fkUbd7EhrbDW5zWAG0D8C5s+ZCCg3d8c3a+I+3QovEEI03ugvYKk9DsDK
         5hWi/cfS1nNjNH50eUm26yeHp4q+kQCz+8NcNxj/kESEMP0HCzc8O6h0hM0mI0p/3DsE
         eukZ8hMld774k/ypO0M8fJiX8hGHPX8MLa+2RX83bmNovLBZLWxy5XGq6CL3npxhLE3p
         f6GXq6evhw/ldf9hI63bTraOe/GE2Cj/4natzid0VkQugbZh9RyuXgPyQ25HpRJLlyya
         iuBA==
X-Gm-Message-State: AHYfb5hwGJNAKcxfiNbbDPhxb9c0M7wa9jIA32FYgvZOp3icWpho9HI2
        vXwTWaUrEP6z3uuJkq3tFg==
X-Received: by 10.84.215.205 with SMTP id g13mr11270696plj.8.1503094859547;
        Fri, 18 Aug 2017 15:20:59 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:58 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 13/23] pack: move get_size_from_delta()
Date:   Fri, 18 Aug 2017 15:20:28 -0700
Message-Id: <d9f1dba4357ef883d6425b6a51d57ba27c3e98ab.1503094448.git.jonathantanmy@google.com>
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
 cache.h     |  1 -
 packfile.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 packfile.h  |  1 +
 sha1_file.c | 39 ---------------------------------------
 4 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/cache.h b/cache.h
index 75cc0c497..87f65aeea 100644
--- a/cache.h
+++ b/cache.h
@@ -1669,7 +1669,6 @@ extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *)
 
 extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
 /*
diff --git a/packfile.c b/packfile.c
index 43b708812..fa90b643e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -4,6 +4,7 @@
 #include "dir.h"
 #include "mergesort.h"
 #include "packfile.h"
+#include "delta.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -909,3 +910,42 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	*sizep = size;
 	return used;
 }
+
+unsigned long get_size_from_delta(struct packed_git *p,
+				  struct pack_window **w_curs,
+			          off_t curpos)
+{
+	const unsigned char *data;
+	unsigned char delta_head[20], *in;
+	git_zstream stream;
+	int st;
+
+	memset(&stream, 0, sizeof(stream));
+	stream.next_out = delta_head;
+	stream.avail_out = sizeof(delta_head);
+
+	git_inflate_init(&stream);
+	do {
+		in = use_pack(p, w_curs, curpos, &stream.avail_in);
+		stream.next_in = in;
+		st = git_inflate(&stream, Z_FINISH);
+		curpos += stream.next_in - in;
+	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
+		 stream.total_out < sizeof(delta_head));
+	git_inflate_end(&stream);
+	if ((st != Z_STREAM_END) && stream.total_out != sizeof(delta_head)) {
+		error("delta data unpack-initial failed");
+		return 0;
+	}
+
+	/* Examine the initial part of the delta to figure out
+	 * the result size.
+	 */
+	data = delta_head;
+
+	/* ignore base size */
+	get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
+
+	/* Read the result size */
+	return get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
+}
diff --git a/packfile.h b/packfile.h
index 9f36e0112..9c3bce6b2 100644
--- a/packfile.h
+++ b/packfile.h
@@ -63,6 +63,7 @@ extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 
 extern void release_pack_memory(size_t);
 
diff --git a/sha1_file.c b/sha1_file.c
index b999957b0..5d016ad6b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1100,45 +1100,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-unsigned long get_size_from_delta(struct packed_git *p,
-				  struct pack_window **w_curs,
-			          off_t curpos)
-{
-	const unsigned char *data;
-	unsigned char delta_head[20], *in;
-	git_zstream stream;
-	int st;
-
-	memset(&stream, 0, sizeof(stream));
-	stream.next_out = delta_head;
-	stream.avail_out = sizeof(delta_head);
-
-	git_inflate_init(&stream);
-	do {
-		in = use_pack(p, w_curs, curpos, &stream.avail_in);
-		stream.next_in = in;
-		st = git_inflate(&stream, Z_FINISH);
-		curpos += stream.next_in - in;
-	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
-		 stream.total_out < sizeof(delta_head));
-	git_inflate_end(&stream);
-	if ((st != Z_STREAM_END) && stream.total_out != sizeof(delta_head)) {
-		error("delta data unpack-initial failed");
-		return 0;
-	}
-
-	/* Examine the initial part of the delta to figure out
-	 * the result size.
-	 */
-	data = delta_head;
-
-	/* ignore base size */
-	get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
-
-	/* Read the result size */
-	return get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
-}
-
 static off_t get_delta_base(struct packed_git *p,
 				    struct pack_window **w_curs,
 				    off_t *curpos,
-- 
2.14.1.480.gb18f417b89-goog

