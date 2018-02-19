Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B67C81F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeBSXBL (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 18:01:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33376 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932279AbeBSW7w (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 17:59:52 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5A59B60B47;
        Mon, 19 Feb 2018 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081190;
        bh=c0RgsoY6tSOq88ZbB6jV1r0ZIoecLC1NDplPS5VFc3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qPgxnbGCVGwIyFA8tNpZAvZua6wURfWravmkHsMEhTyStP2hVn3noddAcGZAXiBZ9
         J1ZKcAXpAOH9oKZ4ptw8ZoXq5iB74LdBWInuOvOJ/aTG0Gvs3DAB9MmDsbcuqFxeiy
         BP4l3qrrqx0kWgRHIVfmddzLN5Y0pR4fhs2+TAQFDNiiwmhF54KavyGadmtGXylSPk
         CFgyLJWg/eeyxYhkKX9aWZfcYf7sNSbLU2855/25IJ59MEVtNPUKu8HYThiFFklOdy
         P01xcHGdk6R9HyJUrnixAfu6f7bhiXcXTxomewHGOkYpCXl5tw/Dop7LKaACeAbS1S
         8M2rF9kvXLHlYMiAh5QqDhw0cYeLbIiDj5DM0Hm+0BPD7EMIDxe9OnwwcWpVJhXtBn
         eRvzVIahHyiVVtz1D2JlxsTSXvQvfRkkqGCzfX/lh98ZwXrJFmwZKcU4ToELbxQfQF
         HNxd7fsrPBOVCsVOqZaB4ydBpYfXrLdYRwIuGGmf0FtCz2SPWex
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 16/36] archive: convert sha1_file_to_archive to struct object_id
Date:   Mon, 19 Feb 2018 22:59:07 +0000
Message-Id: <20180219225927.386065-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert this function to take a pointer to struct object_id and rename
it object_file_to_archive.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive-tar.c |  2 +-
 archive-zip.c |  4 ++--
 archive.c     | 10 +++++-----
 archive.h     |  8 ++++----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 24b1ccef3a..fd622eacc0 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -281,7 +281,7 @@ static int write_tar_entry(struct archiver_args *args,
 		buffer = NULL;
 	else if (S_ISLNK(mode) || S_ISREG(mode)) {
 		enum object_type type;
-		buffer = sha1_file_to_archive(args, path, oid->hash, old_mode, &type, &size);
+		buffer = object_file_to_archive(args, path, oid, old_mode, &type, &size);
 		if (!buffer)
 			return error("cannot read %s", oid_to_hex(oid));
 	} else {
diff --git a/archive-zip.c b/archive-zip.c
index e2e5513c03..5841a6ceb6 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -344,8 +344,8 @@ static int write_zip_entry(struct archiver_args *args,
 			flags |= ZIP_STREAM;
 			out = buffer = NULL;
 		} else {
-			buffer = sha1_file_to_archive(args, path, oid->hash, mode,
-						      &type, &size);
+			buffer = object_file_to_archive(args, path, oid, mode,
+							&type, &size);
 			if (!buffer)
 				return error("cannot read %s",
 					     oid_to_hex(oid));
diff --git a/archive.c b/archive.c
index 4942b5632b..da62b2f541 100644
--- a/archive.c
+++ b/archive.c
@@ -63,16 +63,16 @@ static void format_subst(const struct commit *commit,
 	free(to_free);
 }
 
-void *sha1_file_to_archive(const struct archiver_args *args,
-			   const char *path, const unsigned char *sha1,
-			   unsigned int mode, enum object_type *type,
-			   unsigned long *sizep)
+void *object_file_to_archive(const struct archiver_args *args,
+			     const char *path, const struct object_id *oid,
+			     unsigned int mode, enum object_type *type,
+			     unsigned long *sizep)
 {
 	void *buffer;
 	const struct commit *commit = args->convert ? args->commit : NULL;
 
 	path += args->baselen;
-	buffer = read_sha1_file(sha1, type, sizep);
+	buffer = read_sha1_file(oid->hash, type, sizep);
 	if (buffer && S_ISREG(mode)) {
 		struct strbuf buf = STRBUF_INIT;
 		size_t size = 0;
diff --git a/archive.h b/archive.h
index 741991bfb6..1f9954f7cd 100644
--- a/archive.h
+++ b/archive.h
@@ -39,9 +39,9 @@ extern int write_archive_entries(struct archiver_args *args, write_archive_entry
 extern int write_archive(int argc, const char **argv, const char *prefix, const char *name_hint, int remote);
 
 const char *archive_format_from_filename(const char *filename);
-extern void *sha1_file_to_archive(const struct archiver_args *args,
-				  const char *path, const unsigned char *sha1,
-				  unsigned int mode, enum object_type *type,
-				  unsigned long *sizep);
+extern void *object_file_to_archive(const struct archiver_args *args,
+				    const char *path, const struct object_id *oid,
+				    unsigned int mode, enum object_type *type,
+				    unsigned long *sizep);
 
 #endif	/* ARCHIVE_H */
