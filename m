Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3773B208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdHRWUs (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:20:48 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35657 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbdHRWUr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:20:47 -0400
Received: by mail-pg0-f47.google.com with SMTP id q6so1091092pgs.2
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=altdSK0PwtyQIRVbjUMlpZF7o3UMfO4sCtfuHNHfQEQ=;
        b=VDyL8hMNDzOjpnI8XenLfJVvjWYVuEGhYTEkkGYiUBWDIL5zIPQahuEm3agdmcG+Jx
         PdYtEt7FI8q5XqCwYgZJkxDdAQ1WBmDYIdkOhecEmWVB7xSqMdY2LiKtd3Oba3fFKODN
         excJ1S82tOH0qQCVX6+JuBOBKywnJX0Z0kd4l0kq1yo7BbxXAPkBcoomnL3mJzGJBwGI
         sQoEmqT7Jz0ESVD1nR2zKDW6M0CIgvFcbBIZWTe8Vk2uSmWsw6sSUoADx2N4vhoxz98q
         MFVmNEgdwunHab/C01YXPwLHfcY6xQIYi/WNWxuxQoFalwGtrkAMmJ4nBEM+apM7semT
         U4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=altdSK0PwtyQIRVbjUMlpZF7o3UMfO4sCtfuHNHfQEQ=;
        b=X2TPTghW5yPfnYhio3xv3qOEgPudlD1k+5j4e7dlzdXFMPDKfPLYSujJB7Qx/kd9al
         XswBQ/JRvoq0CORSN0bx3JzQi06F4+nQYXpSyPq7vaj2p9/k8a32CrayCLE67J1965Eu
         MUVvNUyaMZtFik2HwxNN7yOvyWz2f9E4tjdU+r6ncRxaVBmOcyPHVT+1XvJDZxx0StuB
         TsbaTv3D1HCjw3HXzqtQAFGII+ZYHh4ip+rplYRWkM1N6QcwDuhXIffzv/2weiTKLLo5
         kYrNs5cjSsG9FKLAj55R6wt/xybKG87chNBgNSHSPaO7XFMxGx4Wo60SAP4hOuZUBKjH
         uEZQ==
X-Gm-Message-State: AHYfb5ji4Ssp/Kg87c1DjqSI4CEkzVGyagiq2qZ+hcV9MkYUT0Sx6LsL
        kCxj7iVBDSpeXoBtpQS8aw==
X-Received: by 10.84.231.9 with SMTP id f9mr10994875plk.257.1503094846063;
        Fri, 18 Aug 2017 15:20:46 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:44 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 01/23] pack: move pack name-related functions
Date:   Fri, 18 Aug 2017 15:20:16 -0700
Message-Id: <1470c0c23253b4a6de72292d8e8fcec5b78670f1.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, sha1_file.c and cache.h contain many functions, both related
to and unrelated to packfiles. This makes both files very large and
causes an unclear separation of concerns.

Create a new file, packfile.c, to hold all packfile-related functions
currently in sha1_file.c. It has a corresponding header packfile.h.

In this commit, the pack name-related functions are moved. Subsequent
commits will move the other functions.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile                 |  1 +
 builtin/index-pack.c     |  1 +
 builtin/pack-redundant.c |  1 +
 cache.h                  | 23 -----------------------
 fast-import.c            |  1 +
 http.c                   |  1 +
 outgoing/packfile.h      |  0
 packfile.c               | 23 +++++++++++++++++++++++
 packfile.h               | 27 +++++++++++++++++++++++++++
 sha1_file.c              | 23 +----------------------
 10 files changed, 56 insertions(+), 45 deletions(-)
 create mode 100644 outgoing/packfile.h
 create mode 100644 packfile.c
 create mode 100644 packfile.h

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
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 26828c1d8..f2be145e1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -12,6 +12,7 @@
 #include "exec_cmd.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "packfile.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index cb1df1c76..aaa813632 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -7,6 +7,7 @@
 */
 
 #include "builtin.h"
+#include "packfile.h"
 
 #define BLKSIZE 512
 
diff --git a/cache.h b/cache.h
index fcba87a69..aa2b4d390 100644
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
@@ -1656,15 +1642,6 @@ extern void pack_report(void);
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
diff --git a/fast-import.c b/fast-import.c
index a959161b4..49516d60e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -167,6 +167,7 @@ Format of STDIN stream:
 #include "quote.h"
 #include "dir.h"
 #include "run-command.h"
+#include "packfile.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
diff --git a/http.c b/http.c
index c6c010f88..1d1e4ab01 100644
--- a/http.c
+++ b/http.c
@@ -11,6 +11,7 @@
 #include "pkt-line.h"
 #include "gettext.h"
 #include "transport.h"
+#include "packfile.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 #if LIBCURL_VERSION_NUM >= 0x070a08
diff --git a/outgoing/packfile.h b/outgoing/packfile.h
new file mode 100644
index 000000000..e69de29bb
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
diff --git a/packfile.h b/packfile.h
new file mode 100644
index 000000000..3c4a0dbd7
--- /dev/null
+++ b/packfile.h
@@ -0,0 +1,27 @@
+#ifndef PACKFILE_H
+#define PACKFILE_H
+
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
+#endif
diff --git a/sha1_file.c b/sha1_file.c
index c888d7e5b..6e7a20b52 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -28,6 +28,7 @@
 #include "list.h"
 #include "mergesort.h"
 #include "quote.h"
+#include "packfile.h"
 
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
@@ -278,28 +279,6 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
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
2.14.1.480.gb18f417b89-goog

