Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA2481F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162430AbeBPRrL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:47:11 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45008 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162385AbeBPRqv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:51 -0500
Received: by mail-pl0-f66.google.com with SMTP id w21so2039321plp.11
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O2diRDv8Aaiq0mDwWvmae+DL6uOX+6OAlQGjq2E+MOw=;
        b=gWMra1tGbzyzJ9nzIpvlgHVIUdOvmmtuTYdOqB+i+RHYD/U05KH7pojHkZ81lG17D3
         FCVmzCfIUukEoDBnb/R6F1DeS1ErVU6Yx3uzT0+BbEr2NcOvk1etg5KiPyUmFbpuQktJ
         550pMC5g2pcuDneKu97Jdx3L48VeRisuZFfy0sm+NeLpNL5gtLiatzYV1zpWuztpKfx5
         XIWLMf2aH0jN+11rtiaoxFd/g5QLsqgUvo1Vgx3k4zckexqRzGs2jYPnJWojcqfovrJm
         luozpQNuFKBKCWF7ZTAdMUL8XviU2aB4A53/PhFkmu7Ew6QjsJ6K7grDFCOoBLHC3uTH
         LFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O2diRDv8Aaiq0mDwWvmae+DL6uOX+6OAlQGjq2E+MOw=;
        b=R3GqZMm0b50JtH5gxRDdvBmyuancdzqv0zSh4WkdjcSBLbLKKCK/fpQ4K/xjjh2sqK
         HfNaeApmUEa9d04hyd3v4nqjIQLohfl5SqS2dME6oW5waC3lpTDXfZGRaICteCybe7pz
         DFBJYSKaMz87aLj5fKrz/bYcqSL0SmInfwq2HvDfmJe4bc3cqhsqZyDjj1BJTddIuhXG
         Qg2kb+ZWmEx0WXFH8hyUHrLP8NR38Qf4nYBEqyKahs97OV6u+OVh//mUVb2URmj4/u2U
         cwvifdt9m81B2pQx4K0MtkkFHGmycPWlpvhtiBBY6SmyHs8RVrVH4wrgdXlCN1misO48
         PB0Q==
X-Gm-Message-State: APf1xPBD/Bo9WbAQGgg7pvCsPMwGl8SpgLljgeEBgk7i3QyDVEosyVDx
        nCiC2kMaAKMFmD1vb+zNKTiKGw==
X-Google-Smtp-Source: AH8x227cW4yA+C/OQj2FKbfDu9IBII4sTw0rQGx0jpPMcJdcnL/mAFAifH1RnvNMKNmbmxFJKA2l4A==
X-Received: by 2002:a17:902:b942:: with SMTP id h2-v6mr6531377pls.45.1518803210653;
        Fri, 16 Feb 2018 09:46:50 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id d64sm45311383pfa.91.2018.02.16.09.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:49 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/16] sha1_file: allow sha1_file_name to handle arbitrary object stores
Date:   Fri, 16 Feb 2018 09:46:21 -0800
Message-Id: <20180216174626.24677-12-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at it, move the declaration to object-store.h, where it should
be easier to find.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h        |  6 ------
 http-walker.c  |  3 ++-
 http.c         |  5 ++---
 object-store.h |  6 ++++++
 sha1_file.c    | 12 ++++++------
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index d0c1a533c5..2495c7081d 100644
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
index 8bb5d991bb..59bc0417d2 100644
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
+		sha1_file_name(&the_repository->objects, &buf, req->sha1);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index a4a9e583c7..058436d9d3 100644
--- a/http.c
+++ b/http.c
@@ -2247,7 +2247,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	hashcpy(freq->sha1, sha1);
 	freq->localfile = -1;
 
-	sha1_file_name(&filename, sha1);
+	sha1_file_name(&the_repository->objects, &filename, sha1);
 	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
 		 "%s.temp", filename.buf);
 
@@ -2396,8 +2396,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile);
 		return -1;
 	}
-
-	sha1_file_name(&filename, freq->sha1);
+	sha1_file_name(&the_repository->objects, &filename, freq->sha1);
 	freq->rename = finalize_object_file(freq->tmpfile, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/object-store.h b/object-store.h
index 280e8e16ad..5f6beb9d91 100644
--- a/object-store.h
+++ b/object-store.h
@@ -67,6 +67,12 @@ extern struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 } *packed_git;
 
+/*
+ * Put in `buf` the name of the file in the local object database that
+ * would be used to store a loose object with the specified sha1.
+ */
+void sha1_file_name(struct raw_object_store *o, struct strbuf *buf, const unsigned char *sha1);
+
 void prepare_alt_odb(struct raw_object_store *o);
 
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index 04a81e29f2..d64cdbb494 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -323,9 +323,9 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
+void sha1_file_name(struct raw_object_store *o, struct strbuf *buf, const unsigned char *sha1)
 {
-	strbuf_addstr(buf, get_object_directory());
+	strbuf_addstr(buf, o->objectdir);
 	strbuf_addch(buf, '/');
 	fill_sha1_path(buf, sha1);
 }
@@ -717,7 +717,7 @@ static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&buf, sha1);
+	sha1_file_name(&the_repository->objects, &buf, sha1);
 
 	return check_and_freshen_file(buf.buf, freshen);
 }
@@ -878,7 +878,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&buf, sha1);
+	sha1_file_name(&the_repository->objects, &buf, sha1);
 	*path = buf.buf;
 
 	if (!lstat(*path, st))
@@ -907,7 +907,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&buf, sha1);
+	sha1_file_name(&the_repository->objects, &buf, sha1);
 	*path = buf.buf;
 
 	fd = git_open(*path);
@@ -1592,7 +1592,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	static struct strbuf filename = STRBUF_INIT;
 
 	strbuf_reset(&filename);
-	sha1_file_name(&filename, sha1);
+	sha1_file_name(&the_repository->objects, &filename, sha1);
 
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
-- 
2.16.1.291.g4437f3f132-goog

