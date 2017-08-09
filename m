Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68E420899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbdHIBXF (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:05 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36117 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbdHIBXE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:04 -0400
Received: by mail-pg0-f49.google.com with SMTP id v77so21517070pgb.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZdZRygXXqMVa4lVRXIBSoVvzd05CpiDCiIndzQhUEJQ=;
        b=bSBABNcE9BDdXyr/kbc4xAXgeP13B6EkoBWsI9uGjv6C1nlMQhcimiR77MqD6I6Gu9
         wEQl/xREBU2M+SneTMfg5Z76jV7mAMd22i15Q5/9veKhFrC6aRBkuFCqvAq9Hnmr91FZ
         xyMxoDQxb/NBmhHEyAHqtRwFV2+JSnPLKjepvh9arNdXyI0teOmt6FVb9eq2ciuSX/HO
         IEjRCu/voftpkDilV9kuHW9SNnHlU6ctybLOE24nNrflBv0akW9BUIEbDEPfS9MjWMGA
         Nuqx2dnjml8Ik14zg0MF1wdc3Y/UGvJN8RICjFFToKGP4kY+0AN8Sbk6NP7gYXVqx0eo
         gR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ZdZRygXXqMVa4lVRXIBSoVvzd05CpiDCiIndzQhUEJQ=;
        b=p7qcjOCydrZt/EXIc+olWM74jbRPMeVjmN8k9ZLO0xauZXngZ4a5gfLLGNg54h8ug9
         ZT/ut7eqz0auD3dLGT0ntweE+7v/7fMHKyr6IaFnqNU287iQThBPylns4UjM3l7TICLL
         oNdaRDS2E6Cc8omCtgqCINhyto0XCw4kIp159msxuGQPTXhxDAJELj+iZIH+brF9ugPH
         mQ67sIuUQDmFvEo5VHhEzJmbqhJcTCla5qAakIivcHCEJJG05qXidBSRQnACYWATS/9q
         8mvwX4Jr4lIxYKpvwSl2hd9tgzLs//5FxWvzQfJDRHQax+iy+UZlJEiR3fxxx1C4GygB
         yVSw==
X-Gm-Message-State: AHYfb5hGIDM2AfyAiXdRKX8OME6J4SJM1Ph63Q1DLSUL7dQPZnVlmWJR
        V/tlvQ5k4+jeZW/pnFF7xQ==
X-Received: by 10.84.224.142 with SMTP id s14mr6997903plj.353.1502241783010;
        Tue, 08 Aug 2017 18:23:03 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:01 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 01/25] pack: move pack name-related functions
Date:   Tue,  8 Aug 2017 18:22:33 -0700
Message-Id: <9158fe8cc87379a624b1b04d63c301ba54544af8.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, sha1_file.c and cache.h contain many functions, both related
to and unrelated to packfiles. This makes both files very large and
causes an unclear separation of concerns.

Create a new file, packfile.c, to hold all packfile-related functions
currently in sha1_file.c, and designate pack.h to hold these
packfile-related functions.

In this commit, the pack name-related functions are moved. Subsequent
commits will move the other functions.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile                 |  1 +
 builtin/pack-redundant.c |  1 +
 cache.h                  | 23 -----------------------
 pack.h                   | 23 +++++++++++++++++++++++
 packfile.c               | 23 +++++++++++++++++++++++
 sha1_file.c              | 22 ----------------------
 6 files changed, 48 insertions(+), 45 deletions(-)
 create mode 100644 packfile.c

diff --git a/Makefile b/Makefile
index 461c845d3..5cdecaa17 100644
--- a/Makefile
+++ b/Makefile
@@ -816,6 +816,7 @@ LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
 LIB_OBJS += oidset.o
+LIB_OBJS += packfile.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-check.o
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index cb1df1c76..df36d10e7 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -7,6 +7,7 @@
 */
 
 #include "builtin.h"
+#include "pack.h"
 
 #define BLKSIZE 512
 
diff --git a/cache.h b/cache.h
index 71fe09264..1f0f47819 100644
--- a/cache.h
+++ b/cache.h
@@ -902,20 +902,6 @@ extern void check_repository_format(void);
  */
 extern const char *sha1_file_name(const unsigned char *sha1);
 
-/*
- * Return the name of the (local) packfile with the specified sha1 in
- * its name.  The return value is a pointer to memory that is
- * overwritten each time this function is called.
- */
-extern char *sha1_pack_name(const unsigned char *sha1);
-
-/*
- * Return the name of the (local) pack index file with the specified
- * sha1 in its name.  The return value is a pointer to memory that is
- * overwritten each time this function is called.
- */
-extern char *sha1_pack_index_name(const unsigned char *sha1);
-
 /*
  * Return an abbreviated sha1 unique within this repository's object database.
  * The result will be at least `len` characters long, and will be NUL
@@ -1648,15 +1634,6 @@ extern void pack_report(void);
  */
 extern int odb_mkstemp(struct strbuf *template, const char *pattern);
 
-/*
- * Generate the filename to be used for a pack file with checksum "sha1" and
- * extension "ext". The result is written into the strbuf "buf", overwriting
- * any existing contents. A pointer to buf->buf is returned as a convenience.
- *
- * Example: odb_pack_name(out, sha1, "idx") => ".git/objects/pack/pack-1234..idx"
- */
-extern char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
-
 /*
  * Create a pack .keep file named "name" (which should generally be the output
  * of odb_pack_name). Returns a file descriptor opened for writing, or -1 on
diff --git a/pack.h b/pack.h
index 8294341af..63bfde00c 100644
--- a/pack.h
+++ b/pack.h
@@ -101,4 +101,27 @@ extern int read_pack_header(int fd, struct pack_header *);
 extern struct sha1file *create_tmp_packfile(char **pack_tmp_name);
 extern void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
 
+/*
+ * Generate the filename to be used for a pack file with checksum "sha1" and
+ * extension "ext". The result is written into the strbuf "buf", overwriting
+ * any existing contents. A pointer to buf->buf is returned as a convenience.
+ *
+ * Example: odb_pack_name(out, sha1, "idx") => ".git/objects/pack/pack-1234..idx"
+ */
+extern char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
+
+/*
+ * Return the name of the (local) packfile with the specified sha1 in
+ * its name.  The return value is a pointer to memory that is
+ * overwritten each time this function is called.
+ */
+extern char *sha1_pack_name(const unsigned char *sha1);
+
+/*
+ * Return the name of the (local) pack index file with the specified
+ * sha1 in its name.  The return value is a pointer to memory that is
+ * overwritten each time this function is called.
+ */
+extern char *sha1_pack_index_name(const unsigned char *sha1);
+
 #endif
diff --git a/packfile.c b/packfile.c
new file mode 100644
index 000000000..0d191dfd6
--- /dev/null
+++ b/packfile.c
@@ -0,0 +1,23 @@
+#include "cache.h"
+
+char *odb_pack_name(struct strbuf *buf,
+		    const unsigned char *sha1,
+		    const char *ext)
+{
+	strbuf_reset(buf);
+	strbuf_addf(buf, "%s/pack/pack-%s.%s", get_object_directory(),
+		    sha1_to_hex(sha1), ext);
+	return buf->buf;
+}
+
+char *sha1_pack_name(const unsigned char *sha1)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	return odb_pack_name(&buf, sha1, "pack");
+}
+
+char *sha1_pack_index_name(const unsigned char *sha1)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	return odb_pack_name(&buf, sha1, "idx");
+}
diff --git a/sha1_file.c b/sha1_file.c
index b60ae15f7..7e511ce9e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -278,28 +278,6 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 	return buf->buf;
 }
 
- char *odb_pack_name(struct strbuf *buf,
-		     const unsigned char *sha1,
-		     const char *ext)
-{
-	strbuf_reset(buf);
-	strbuf_addf(buf, "%s/pack/pack-%s.%s", get_object_directory(),
-		    sha1_to_hex(sha1), ext);
-	return buf->buf;
-}
-
-char *sha1_pack_name(const unsigned char *sha1)
-{
-	static struct strbuf buf = STRBUF_INIT;
-	return odb_pack_name(&buf, sha1, "pack");
-}
-
-char *sha1_pack_index_name(const unsigned char *sha1)
-{
-	static struct strbuf buf = STRBUF_INIT;
-	return odb_pack_name(&buf, sha1, "idx");
-}
-
 struct alternate_object_database *alt_odb_list;
 static struct alternate_object_database **alt_odb_tail;
 
-- 
2.14.0.434.g98096fd7a8-goog

