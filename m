Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 597BB1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeBUB4J (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:56:09 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:47097 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbeBUBzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:06 -0500
Received: by mail-pg0-f67.google.com with SMTP id m1so54424pgp.13
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r1/hsFkVmZXhPoU35If1YTRv4FhtCmEicmb4YpeAUVA=;
        b=WBZulD6WeqiRhPmOakbr5I+GqLBhp7qT5/z3zAon3FKSmz1jO571UNeFUNf7NUtJeq
         rvfpC5Ks+J2xGcGKksvp5o3Q/PvMx9/M0bM4/VEhbpyn9CkBFbjUVUphDCmnChzeDuU/
         2a5AopVxsZYAJfWVJGJyf1P4GumwvT9CWDeBf/6mRlhqosCQn7ZyBr950BJkDj4pIzjk
         8cgXg5IxP6cptdr0yv6YKPRK8XU//HnosX3yCsd/b631Rob7U4wN1lswOqqkgbeRROnb
         eKnp4TMCgwhjjeXiMSrgudw1Qzw2O4hroqufto+SM6/HZASu6u/DHWhCLoe54E9M1gBi
         jvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r1/hsFkVmZXhPoU35If1YTRv4FhtCmEicmb4YpeAUVA=;
        b=qQ7vj/R4nTxDRBmjCUmru4yU/efVexFAWQ2qIAOrP5dmBhJs2aGdEA2UFG08Q/G4+8
         0/TPh3i5pk2WmW6hskXyJSmiwrU21Wyp2/e198rhjgSHf8E1ro+k2XNzJ8o8iVi48NKt
         MJ23MEfMAaLdjxPZM3D271RcIGd9ntShiGG+pqRA7hOTysQnp+LJi91BKL5rGYpFn1GZ
         ic/SOa7uv8zA5JNDXryzNafOkJwPBRRhd/67VZDYop2y50kIYhJYbn5EgZfAD1QeRWjs
         n2izsWV1Jzk2UVBXptkRunZmtklbEGj3pvuKDkurbbMp9zx0c8VsJYBbh6ZWi4zdpZ9b
         +pHQ==
X-Gm-Message-State: APf1xPADb12m42XSnYKIVARjpKwcgOEYsYJR9X2k1hSd2Ka77BZiCz+S
        wH8ATEQDocQaKlK9VVWpWnFfbw==
X-Google-Smtp-Source: AH8x226H32O2ag+9Hv6xZgweVlrAnESTVnuTgFbKivmYkrQXt973yGj82cgo6B/epnnYDx7XJHvcPw==
X-Received: by 10.98.200.80 with SMTP id z77mr1552097pff.85.1519178105985;
        Tue, 20 Feb 2018 17:55:05 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id g90sm12262899pfe.20.2018.02.20.17.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:05 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 16/27] sha1_file: add repository argument to sha1_file_name
Date:   Tue, 20 Feb 2018 17:54:19 -0800
Message-Id: <20180221015430.96054-17-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow sha1_file_name callers to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

While at it, move the declaration to object-store.h, where it should
be easier to find.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h        |  6 ------
 http-walker.c  |  3 ++-
 http.c         |  5 ++---
 object-store.h |  7 +++++++
 sha1_file.c    | 10 +++++-----
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index 3fd9dc52cd..e641c23b0a 100644
--- a/cache.h
+++ b/cache.h
@@ -961,12 +961,6 @@ extern void check_repository_format(void);
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
 
-/*
- * Put in `buf` the name of the file in the local object database that
- * would be used to store a loose object with the specified sha1.
- */
-extern void sha1_file_name(struct strbuf *buf, const unsigned char *sha1);
-
 /*
  * Return an abbreviated sha1 unique within this repository's object database.
  * The result will be at least `len` characters long, and will be NUL
diff --git a/http-walker.c b/http-walker.c
index 8bb5d991bb..76bfdbca76 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "commit.h"
 #include "walker.h"
 #include "http.h"
@@ -546,7 +547,7 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
-		sha1_file_name(&buf, req->sha1);
+		sha1_file_name(the_repository, &buf, req->sha1);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index a4a9e583c7..afe2707e86 100644
--- a/http.c
+++ b/http.c
@@ -2247,7 +2247,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	hashcpy(freq->sha1, sha1);
 	freq->localfile = -1;
 
-	sha1_file_name(&filename, sha1);
+	sha1_file_name(the_repository, &filename, sha1);
 	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
 		 "%s.temp", filename.buf);
 
@@ -2396,8 +2396,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile);
 		return -1;
 	}
-
-	sha1_file_name(&filename, freq->sha1);
+	sha1_file_name(the_repository, &filename, freq->sha1);
 	freq->rename = finalize_object_file(freq->tmpfile, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/object-store.h b/object-store.h
index 873b341774..4f5060e768 100644
--- a/object-store.h
+++ b/object-store.h
@@ -123,4 +123,11 @@ struct raw_object_store {
 
 void raw_object_store_clear(struct raw_object_store *o);
 
+/*
+ * Put in `buf` the name of the file in the local object database that
+ * would be used to store a loose object with the specified sha1.
+ */
+#define sha1_file_name(r, b, s) sha1_file_name_##r(b, s)
+void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1);
+
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index 9cf3fffbeb..811ed9e53f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -323,7 +323,7 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
+void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1)
 {
 	strbuf_addstr(buf, get_object_directory());
 	strbuf_addch(buf, '/');
@@ -720,7 +720,7 @@ static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&buf, sha1);
+	sha1_file_name(the_repository, &buf, sha1);
 
 	return check_and_freshen_file(buf.buf, freshen);
 }
@@ -881,7 +881,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&buf, sha1);
+	sha1_file_name(the_repository, &buf, sha1);
 	*path = buf.buf;
 
 	if (!lstat(*path, st))
@@ -910,7 +910,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&buf, sha1);
+	sha1_file_name(the_repository, &buf, sha1);
 	*path = buf.buf;
 
 	fd = git_open(*path);
@@ -1595,7 +1595,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	static struct strbuf filename = STRBUF_INIT;
 
 	strbuf_reset(&filename);
-	sha1_file_name(&filename, sha1);
+	sha1_file_name(the_repository, &filename, sha1);
 
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
-- 
2.16.1.291.g4437f3f132-goog

