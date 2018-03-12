Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5811F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932600AbeCLC2j (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:28:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34398 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932577AbeCLC2h (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9392960CF3;
        Mon, 12 Mar 2018 02:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821716;
        bh=IIdW1FHNeYtMCHhc2OV++1AGFgTDUMAJf+G9+GBBkHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NITkdD+2AKNmqGtb1GQ0nNWm9i8+hjXuF6EUbZXLl4uFQoT3UKw+Vs5UDCFDucd3N
         sfLTreLW7R1WiNjWGB1ernTytt65yh9AM7O96BWseT6hrSW2ZQRZTDbAUfTZc7GIJ9
         Qs9Pxwpx7OY/pWFquQGeKdhFIGWXPZ/Db3x8TKOmjZ6pDwQDHDCfhshJ7BwjkK+QDX
         GYQqcKAskRV7951gIEIuTs856MUn3cjhaS3ZqNxyPmFEnDUb8LHS9LzOURrvmwKuOU
         HR4l0TjImpeVG31Hl5tRndAwrNRYwxXah2S9wmw5FyaB4fa45vM8EQS1LmAS4x09py
         yNlZvs13ToQr32SpNtVFDS9vdcc1g1kRAGGOzJ+Pw7HZtf0POq2154KAAzVjvHqrr5
         x+vhPVgSJHR1ojPKJAoOwhol/6kAE+daM9H/t0w06jsOvkWRhTcU4ARpDZRBWtn8DG
         bGyPYXmCPFF8s5Qc8cxUoOxV57JEhWB3sa7tdPEamD2/E780ZXY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 20/36] streaming: convert open_istream to use struct object_id
Date:   Mon, 12 Mar 2018 02:27:40 +0000
Message-Id: <20180312022756.483934-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive-tar.c          | 2 +-
 archive-zip.c          | 2 +-
 builtin/index-pack.c   | 2 +-
 builtin/pack-objects.c | 2 +-
 sha1_file.c            | 2 +-
 streaming.c            | 6 +++---
 streaming.h            | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index fd622eacc0..7a0d31d847 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -119,7 +119,7 @@ static int stream_blocked(const struct object_id *oid)
 	char buf[BLOCKSIZE];
 	ssize_t readlen;
 
-	st = open_istream(oid->hash, &type, &sz, NULL);
+	st = open_istream(oid, &type, &sz, NULL);
 	if (!st)
 		return error("cannot stream blob %s", oid_to_hex(oid));
 	for (;;) {
diff --git a/archive-zip.c b/archive-zip.c
index 5841a6ceb6..18b951b732 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -337,7 +337,7 @@ static int write_zip_entry(struct archiver_args *args,
 
 		if (S_ISREG(mode) && type == OBJ_BLOB && !args->convert &&
 		    size > big_file_threshold) {
-			stream = open_istream(oid->hash, &type, &size, NULL);
+			stream = open_istream(oid, &type, &size, NULL);
 			if (!stream)
 				return error("cannot stream blob %s",
 					     oid_to_hex(oid));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b28ebfadd4..ae11d2a610 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -771,7 +771,7 @@ static int check_collison(struct object_entry *entry)
 
 	memset(&data, 0, sizeof(data));
 	data.entry = entry;
-	data.st = open_istream(entry->idx.oid.hash, &type, &size, NULL);
+	data.st = open_istream(&entry->idx.oid, &type, &size, NULL);
 	if (!data.st)
 		return -1;
 	if (size != entry->size || type != entry->type)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a197926eaa..8307cc9b04 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -267,7 +267,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	if (!usable_delta) {
 		if (entry->type == OBJ_BLOB &&
 		    entry->size > big_file_threshold &&
-		    (st = open_istream(entry->idx.oid.hash, &type, &size, NULL)) != NULL)
+		    (st = open_istream(&entry->idx.oid, &type, &size, NULL)) != NULL)
 			buf = NULL;
 		else {
 			buf = read_sha1_file(entry->idx.oid.hash, &type,
diff --git a/sha1_file.c b/sha1_file.c
index e4cb840661..cdcba4483b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -799,7 +799,7 @@ int check_object_signature(const struct object_id *oid, void *map,
 		return oidcmp(oid, &real_oid) ? -1 : 0;
 	}
 
-	st = open_istream(oid->hash, &obj_type, &size, NULL);
+	st = open_istream(oid, &obj_type, &size, NULL);
 	if (!st)
 		return -1;
 
diff --git a/streaming.c b/streaming.c
index 5892b50bd8..be85507922 100644
--- a/streaming.c
+++ b/streaming.c
@@ -130,14 +130,14 @@ static enum input_source istream_source(const unsigned char *sha1,
 	}
 }
 
-struct git_istream *open_istream(const unsigned char *sha1,
+struct git_istream *open_istream(const struct object_id *oid,
 				 enum object_type *type,
 				 unsigned long *size,
 				 struct stream_filter *filter)
 {
 	struct git_istream *st;
 	struct object_info oi = OBJECT_INFO_INIT;
-	const unsigned char *real = lookup_replace_object(sha1);
+	const unsigned char *real = lookup_replace_object(oid->hash);
 	enum input_source src = istream_source(real, type, &oi);
 
 	if (src < 0)
@@ -507,7 +507,7 @@ int stream_blob_to_fd(int fd, const struct object_id *oid, struct stream_filter
 	ssize_t kept = 0;
 	int result = -1;
 
-	st = open_istream(oid->hash, &type, &sz, filter);
+	st = open_istream(oid, &type, &sz, filter);
 	if (!st) {
 		if (filter)
 			free_stream_filter(filter);
diff --git a/streaming.h b/streaming.h
index 73c1d156b3..32f4626771 100644
--- a/streaming.h
+++ b/streaming.h
@@ -8,7 +8,7 @@
 /* opaque */
 struct git_istream;
 
-extern struct git_istream *open_istream(const unsigned char *, enum object_type *, unsigned long *, struct stream_filter *);
+extern struct git_istream *open_istream(const struct object_id *, enum object_type *, unsigned long *, struct stream_filter *);
 extern int close_istream(struct git_istream *);
 extern ssize_t read_istream(struct git_istream *, void *, size_t);
 
