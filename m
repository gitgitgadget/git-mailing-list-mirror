Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3602208B8
	for <e@80x24.org>; Thu,  3 Aug 2017 09:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbdHCJTx (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:19:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34873 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdHCJTu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id r77so1442930wmd.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SQX/ravUjqccQqiv5ch+TxBeGBKRcXAOu9HFQCHf/50=;
        b=jVX4aPfG3BCHCEemasD3g41lovrciUMjNFGELMXjLznt2mxTgg8rB+ttjbJMxKI4Lb
         J+L4VFinhCzG3j+jtzo5TqtCk4kB05klFQ1gHnFAiAQS+fAa/dL11xNUp2VbLyp58IeW
         bm03/UM6CHsC80Mw7OjIQHT89d4IOjB8fO7vVQ2SyxHxyDNoBvNLiXX8vMci4vioyg2s
         5vRRLTOlJ6olEoC2aCLzIQAlFQjmcjAaWl53BjGRwI21Oc87Lsp4M5qdtJaAkVuJ1ClO
         i+bq7OW+ooxkdMQ/SbiDZ2edwETJRlg7M5ARz6ycBYR6ADfYxZjg2ozf0y3tWHb6iyjc
         psLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SQX/ravUjqccQqiv5ch+TxBeGBKRcXAOu9HFQCHf/50=;
        b=obWQXMqDOnRWrGArDBneCashOJseSbUPzsO44lVL7esyoW2r2NfuU/FiGoW+FTBIsj
         4xpv5jhuXb+CLRVkp+L7GesiHAGGX7plf4RSFKTq9OOuJu7sPNkxyLsiMXZeu/tMmE6N
         QQAdat/K/m7ZNmBxQsw1THv4dSmHU1S0eYv68mX85Qg2aeD4SpLFEzE0u58UHAvc/iW+
         RMYBei4wE6dT3byDBGf463JT+eKnIi3F0n7NFY+BuZNwUfMeBwh9tDl0BknphmWxtZPO
         s9jWPGLqfU2fCKeT5v1+jWffAVX6GbDuhQMwFNHuqMA4n/v5PvndP7I34uhnOxK/8hzF
         bdHQ==
X-Gm-Message-State: AHYfb5hxccrSRfHnSta1OrCW8GuL3A/0Zwn0O/ut+Gbxcxwz8jZPoFEQ
        TCunea9Vykz/q2DW
X-Received: by 10.28.7.202 with SMTP id 193mr674116wmh.143.1501751988602;
        Thu, 03 Aug 2017 02:19:48 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:48 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 09/40] sha1_file: prepare for external odbs
Date:   Thu,  3 Aug 2017 11:18:55 +0200
Message-Id: <20170803091926.1755-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the following commits we will need some functions that were
internal to sha1_file.c, so let's first make them non static
and declare them in "cache.h". While at it, let's rename
'create_tmpfile()' to 'create_object_tmpfile()' to make its
name less generic.

Let's also split out 'sha1_file_name_alt()' from
'sha1_file_name()' and 'open_sha1_file_alt()' from
'open_sha1_file()', as we will need both of these new
functions too.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h     |  8 ++++++++
 sha1_file.c | 57 ++++++++++++++++++++++++++++++++++++---------------------
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index 71fe092644..06da3d8a3f 100644
--- a/cache.h
+++ b/cache.h
@@ -902,6 +902,12 @@ extern void check_repository_format(void);
  */
 extern const char *sha1_file_name(const unsigned char *sha1);
 
+/*
+ * Like sha1_file_name, but return the filename within a specific alternate
+ * object directory. Shares the same static buffer with sha1_file_name.
+ */
+extern const char *sha1_file_name_alt(const char *objdir, const unsigned char *sha1);
+
 /*
  * Return the name of the (local) packfile with the specified sha1 in
  * its name.  The return value is a pointer to memory that is
@@ -1205,6 +1211,8 @@ extern int do_check_packed_object_crc;
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
+extern int create_object_tmpfile(struct strbuf *tmp, const char *filename);
+extern void close_sha1_file(int fd);
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1);
diff --git a/sha1_file.c b/sha1_file.c
index b60ae15f70..d330996bc4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -253,12 +253,12 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-const char *sha1_file_name(const unsigned char *sha1)
+const char *sha1_file_name_alt(const char *objdir, const unsigned char *sha1)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	strbuf_addf(&buf, "%s/", get_object_directory());
+	strbuf_addf(&buf, "%s/", objdir);
 
 	fill_sha1_path(&buf, sha1);
 	return buf.buf;
@@ -278,9 +278,14 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 	return buf->buf;
 }
 
- char *odb_pack_name(struct strbuf *buf,
-		     const unsigned char *sha1,
-		     const char *ext)
+const char *sha1_file_name(const unsigned char *sha1)
+{
+	return sha1_file_name_alt(get_object_directory(), sha1);
+}
+
+char *odb_pack_name(struct strbuf *buf,
+		    const unsigned char *sha1,
+		    const char *ext)
 {
 	strbuf_reset(buf);
 	strbuf_addf(buf, "%s/pack/pack-%s.%s", get_object_directory(),
@@ -1727,24 +1732,14 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 	return -1;
 }
 
-/*
- * Like stat_sha1_file(), but actually open the object and return the
- * descriptor. See the caveats on the "path" parameter above.
- */
-static int open_sha1_file(const unsigned char *sha1, const char **path)
+static int open_sha1_file_alt(const unsigned char *sha1, const char **path)
 {
-	int fd;
 	struct alternate_object_database *alt;
-	int most_interesting_errno;
-
-	*path = sha1_file_name(sha1);
-	fd = git_open(*path);
-	if (fd >= 0)
-		return fd;
-	most_interesting_errno = errno;
+	int most_interesting_errno = errno;
 
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
+		int fd;
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
@@ -1756,6 +1751,26 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	return -1;
 }
 
+/*
+ * Like stat_sha1_file(), but actually open the object and return the
+ * descriptor. See the caveats on the "path" parameter above.
+ */
+static int open_sha1_file(const unsigned char *sha1, const char **path)
+{
+	int fd;
+
+	*path = sha1_file_name(sha1);
+	fd = git_open(*path);
+	if (fd >= 0)
+		return fd;
+
+	fd = open_sha1_file_alt(sha1, path);
+	if (fd >= 0)
+		return fd;
+
+	return fd;
+}
+
 /*
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
@@ -3284,7 +3299,7 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_sha1_file(int fd)
+void close_sha1_file(int fd)
 {
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
@@ -3308,7 +3323,7 @@ static inline int directory_size(const char *filename)
  * We want to avoid cross-directory filename renames, because those
  * can have problems on various filesystems (FAT, NFS, Coda).
  */
-static int create_tmpfile(struct strbuf *tmp, const char *filename)
+int create_object_tmpfile(struct strbuf *tmp, const char *filename)
 {
 	int fd, dirlen = directory_size(filename);
 
@@ -3348,7 +3363,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	const char *filename = sha1_file_name(sha1);
 
-	fd = create_tmpfile(&tmp_file, filename);
+	fd = create_object_tmpfile(&tmp_file, filename);
 	if (fd < 0) {
 		if (errno == EACCES)
 			return error("insufficient permission for adding an object to repository database %s", get_object_directory());
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

