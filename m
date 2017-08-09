Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C6C20899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbdHIBXW (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:22 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36650 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbdHIBXS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:18 -0400
Received: by mail-pf0-f171.google.com with SMTP id c28so21284327pfe.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=x9HVBQlqmygGdNoAw2dnHHXl/+AlOdvGDxUfAsLg1nU=;
        b=OxGxyYG7k5Akt2t5lAG4vudXx2lntnaDr4i7o+wOi9EZXIq+4ng0/7WHqgEMDM/pQ9
         oNEYoytxG894hipdrgwZ8ED/NuonwTFnYV8Wp9oMD+wyfkAzo9BP9/AsHWbLBAPPEbsA
         +0KiDAKBp9CEMPXINwynJWepjkzhOiDJldUubGQkm1swQPhDTUBHrg+Cr8WRdDJzUTrC
         SkIHt27n8l9EznTGbzhJQMPFiXU88tQEmABebw7frrRPmb9RhtCA+QehA0EX711+qaEW
         EP83w+iQOwENajIohFz0FwcMrtodcsjLdrhRayJCrTVj17vpfBbYl6/Goof1o0GXLu//
         DIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=x9HVBQlqmygGdNoAw2dnHHXl/+AlOdvGDxUfAsLg1nU=;
        b=BgcB7TKmzCF8MdqvebH4h1W3OmfSl0a2d8Jx2ZVCNkz92e/oW1l56inkfHw5g5AA1E
         IVQXIY/yH3xyZhp3HyKb1M/ePgV2Lvirx8bRPQWNRbtGVjVRDe7LCCvFMeNAA6ybuTSo
         yLJwvMZSgxIclZWb5nhp0yX2vki9mUZhRHbeYCBKDQsn529+8xnmiGe992Ix69Y2RIlX
         9XA5R7F1rSu6EHLnMMS4ZCba4brQ2OE8W8f5RHc71hVWGP0mJ2UMjcrNIJ2lXnT61mPk
         UARj0onUrDePtiryI/laKCQP8U00vVE4NSoxLexa95YC0Ikz64OO33meRBI5nD63QX2W
         af/Q==
X-Gm-Message-State: AHYfb5j4XPNw2DOLSdwUVJ+iXpDfDVp8gLiZSYVwQjAkE7z3cDh7iwCg
        5mxjxDpphWmOx1TtgqLLYg==
X-Received: by 10.98.201.157 with SMTP id l29mr6388310pfk.235.1502241797147;
        Tue, 08 Aug 2017 18:23:17 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:16 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 13/25] pack: move get_size_from_delta()
Date:   Tue,  8 Aug 2017 18:22:45 -0700
Message-Id: <8e2e49b19ceb1f48d3d537edb3b3e4298f33424d.1502241234.git.jonathantanmy@google.com>
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
 cache.h     |  1 -
 pack.h      |  1 +
 packfile.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 sha1_file.c | 39 ---------------------------------------
 4 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/cache.h b/cache.h
index 9c70759a6..e29918c75 100644
--- a/cache.h
+++ b/cache.h
@@ -1661,7 +1661,6 @@ extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *)
 
 extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
 /*
diff --git a/pack.h b/pack.h
index 4a7f88a38..69c92d8d2 100644
--- a/pack.h
+++ b/pack.h
@@ -168,5 +168,6 @@ extern void reprepare_packed_git(void);
 unsigned long approximate_object_count(void);
 
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 
 #endif
diff --git a/packfile.c b/packfile.c
index 6e4f1c6e3..511afad85 100644
--- a/packfile.c
+++ b/packfile.c
@@ -3,6 +3,7 @@
 #include "pack.h"
 #include "dir.h"
 #include "mergesort.h"
+#include "delta.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -908,3 +909,42 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
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
diff --git a/sha1_file.c b/sha1_file.c
index 1f4b4ba2c..7d354d9b6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1099,45 +1099,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
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
2.14.0.434.g98096fd7a8-goog

