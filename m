Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E13C1F404
	for <e@80x24.org>; Thu, 18 Jan 2018 10:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755275AbeARKJP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 05:09:15 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46092 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeARKJM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 05:09:12 -0500
Received: by mail-wr0-f195.google.com with SMTP id g21so21898881wrb.13
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 02:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C5kLOUAsmnYxIU0QXri35ZK3B27pRBmi83jb5w/IdcA=;
        b=dn7G7vqFxZyLgLwdw2C15opdEWrOaE4u8zEaKH9zbEujA3ztPAgHSWFAC8ABd2H5Em
         pT+HIRvaKXPdeJ+1QkSP3jQ9Vx8wGyW14aat8TJ4VR1EKFy33ay5q0t+/Pjt6xzIze5Q
         5/7eWQ58i7HlJUCX4OLMok0vlRV1thJtLHTJ5M8zRzLjZGK+uQ3gXM0j0Qyf/uS/aDVQ
         nI2HEqJSghMzn0Oz9FRiNDApxHhGcmPHHHJIAGwz64+lJAVT1GEYXiGlg7xgqmE02J4q
         n9c03b1JOALGAsH+7fwtfejYcxN1GVfCbEqg0yclPANXbvQ7blhjryxdy9abHk1PYLmk
         SUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C5kLOUAsmnYxIU0QXri35ZK3B27pRBmi83jb5w/IdcA=;
        b=CabTC4hKt5wW8uY2T7fgBhzYu6N57lGUfGcQh0/2eOvN1XLJru9wL2vYFkKO/PBYGs
         /pvOZWWRZ/TdAk5TWSweWGKHgaZFZ/Y+PdoMIMKD/1XbZe21gFpDQ+ajAmtSmdVpGPgp
         3INdQGdirKQd7yl2nrFZCuf8SSAOr39sDU0LWgvz0c6T8TsLvKf0q1BoEPUSaVAaJTJK
         ZPROvFEIWZgcdXBRQQe8nGZuR+wKStCjFGyiQ8yh3ggssuuPUE4+TWU1dfuCIMcU+CLi
         jn8u6wf4br8tdg7VLJgGHZK+BXN72p+DvyZXzAPqHRqtPrWujFK9kmn8pwzr6NInoYdd
         uI2Q==
X-Gm-Message-State: AKwxytceT3OPqjY3lHP4ZMM6PWppEF9eg5laMNEZsVgdh+xJ2S30/bDF
        b5vNTZpYElmqk8M8R8pUmOMdIK9P
X-Google-Smtp-Source: ACJfBovTrggCZcYy2LPLe6aTQLNTwy8qIBgkaBJ0xSBK4AmiGG/tXLEBifybNvpzPuGVO0jBLcknZg==
X-Received: by 10.223.130.196 with SMTP id 62mr5684343wrc.145.1516270150609;
        Thu, 18 Jan 2018 02:09:10 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id q7sm6332969wrf.31.2018.01.18.02.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 02:09:09 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, Kevin Daudt <me@ikke.info>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/2] sha1_file: remove static strbuf from sha1_file_name()
Date:   Thu, 18 Jan 2018 11:08:53 +0100
Message-Id: <20180118100854.22467-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc2.3.g7330290b09
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using a static buffer in sha1_file_name() is error prone
and the performance improvements it gives are not needed
in many of the callers.

So let's get rid of this static buffer and, if necessary
or helpful, let's use one in the caller.

Suggested-by: Jeff Hostetler <git@jeffhostetler.com>
Helped-by: Kevin Daudt <me@ikke.info>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h       |  8 +++-----
 http-walker.c |  6 ++++--
 http.c        | 16 ++++++++++------
 sha1_file.c   | 38 +++++++++++++++++++++++++-------------
 4 files changed, 42 insertions(+), 26 deletions(-)

This patch is the same as v2.

diff --git a/cache.h b/cache.h
index d8b975a571..6db565408e 100644
--- a/cache.h
+++ b/cache.h
@@ -957,12 +957,10 @@ extern void check_repository_format(void);
 #define TYPE_CHANGED    0x0040
 
 /*
- * Return the name of the file in the local object database that would
- * be used to store a loose object with the specified sha1.  The
- * return value is a pointer to a statically allocated buffer that is
- * overwritten each time the function is called.
+ * Put in `buf` the name of the file in the local object database that
+ * would be used to store a loose object with the specified sha1.
  */
-extern const char *sha1_file_name(const unsigned char *sha1);
+extern void sha1_file_name(struct strbuf *buf, const unsigned char *sha1);
 
 /*
  * Return an abbreviated sha1 unique within this repository's object database.
diff --git a/http-walker.c b/http-walker.c
index 1ae8363de2..07c2b1af82 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -544,8 +544,10 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 	} else if (hashcmp(obj_req->sha1, req->real_sha1)) {
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
-		ret = error("unable to write sha1 filename %s",
-			    sha1_file_name(req->sha1));
+		struct strbuf buf = STRBUF_INIT;
+		sha1_file_name(&buf, req->sha1);
+		ret = error("unable to write sha1 filename %s", buf.buf);
+		strbuf_release(&buf);
 	}
 
 	release_http_object_request(req);
diff --git a/http.c b/http.c
index 5977712712..5979305bc9 100644
--- a/http.c
+++ b/http.c
@@ -2168,7 +2168,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
-	const char *filename;
+	struct strbuf filename = STRBUF_INIT;
 	char prevfile[PATH_MAX];
 	int prevlocal;
 	char prev_buf[PREV_BUF_SIZE];
@@ -2180,14 +2180,15 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	hashcpy(freq->sha1, sha1);
 	freq->localfile = -1;
 
-	filename = sha1_file_name(sha1);
+	sha1_file_name(&filename, sha1);
 	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
-		 "%s.temp", filename);
+		 "%s.temp", filename.buf);
 
-	snprintf(prevfile, sizeof(prevfile), "%s.prev", filename);
+	snprintf(prevfile, sizeof(prevfile), "%s.prev", filename.buf);
 	unlink_or_warn(prevfile);
 	rename(freq->tmpfile, prevfile);
 	unlink_or_warn(freq->tmpfile);
+	strbuf_release(&filename);
 
 	if (freq->localfile != -1)
 		error("fd leakage in start: %d", freq->localfile);
@@ -2302,6 +2303,7 @@ void process_http_object_request(struct http_object_request *freq)
 int finish_http_object_request(struct http_object_request *freq)
 {
 	struct stat st;
+	struct strbuf filename = STRBUF_INIT;
 
 	close(freq->localfile);
 	freq->localfile = -1;
@@ -2327,8 +2329,10 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile);
 		return -1;
 	}
-	freq->rename =
-		finalize_object_file(freq->tmpfile, sha1_file_name(freq->sha1));
+
+	sha1_file_name(&filename, freq->sha1);
+	freq->rename = finalize_object_file(freq->tmpfile, filename.buf);
+	strbuf_release(&filename);
 
 	return freq->rename;
 }
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac650..f66c21b2da 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -321,15 +321,11 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-const char *sha1_file_name(const unsigned char *sha1)
+void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
 {
-	static struct strbuf buf = STRBUF_INIT;
-
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "%s/", get_object_directory());
+	strbuf_addf(buf, "%s/", get_object_directory());
 
-	fill_sha1_path(&buf, sha1);
-	return buf.buf;
+	fill_sha1_path(buf, sha1);
 }
 
 struct strbuf *alt_scratch_buf(struct alternate_object_database *alt)
@@ -710,7 +706,12 @@ int check_and_freshen_file(const char *fn, int freshen)
 
 static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 {
-	return check_and_freshen_file(sha1_file_name(sha1), freshen);
+	static struct strbuf buf = STRBUF_INIT;
+
+	strbuf_reset(&buf);
+	sha1_file_name(&buf, sha1);
+
+	return check_and_freshen_file(buf.buf, freshen);
 }
 
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
@@ -866,8 +867,12 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 			  const char **path)
 {
 	struct alternate_object_database *alt;
+	static struct strbuf buf = STRBUF_INIT;
+
+	strbuf_reset(&buf);
+	sha1_file_name(&buf, sha1);
+	*path = buf.buf;
 
-	*path = sha1_file_name(sha1);
 	if (!lstat(*path, st))
 		return 0;
 
@@ -891,8 +896,12 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	int fd;
 	struct alternate_object_database *alt;
 	int most_interesting_errno;
+	static struct strbuf buf = STRBUF_INIT;
+
+	strbuf_reset(&buf);
+	sha1_file_name(&buf, sha1);
+	*path = buf.buf;
 
-	*path = sha1_file_name(sha1);
 	fd = git_open(*path);
 	if (fd >= 0)
 		return fd;
@@ -1557,9 +1566,12 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	git_SHA_CTX c;
 	unsigned char parano_sha1[20];
 	static struct strbuf tmp_file = STRBUF_INIT;
-	const char *filename = sha1_file_name(sha1);
+	static struct strbuf filename = STRBUF_INIT;
+
+	strbuf_reset(&filename);
+	sha1_file_name(&filename, sha1);
 
-	fd = create_tmpfile(&tmp_file, filename);
+	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
 		if (errno == EACCES)
 			return error("insufficient permission for adding an object to repository database %s", get_object_directory());
@@ -1612,7 +1624,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 			warning_errno("failed utime() on %s", tmp_file.buf);
 	}
 
-	return finalize_object_file(tmp_file.buf, filename);
+	return finalize_object_file(tmp_file.buf, filename.buf);
 }
 
 static int freshen_loose_object(const unsigned char *sha1)
-- 
2.16.0.rc2.3.g7330290b09

