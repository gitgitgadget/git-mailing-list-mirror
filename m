Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C272920899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbdHHTcu (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:32:50 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:37981 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbdHHTcs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:32:48 -0400
Received: by mail-pg0-f43.google.com with SMTP id l64so18548991pge.5
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pWvguxU3eSyxgm5KK2LlNZHVqfSSWmVcmTTsuJM7vT8=;
        b=D9mG/vpQqHtd7ssZ4lH+hJ99uUt/YbbF/JF1I993c+lT1zErPuZy/Dwo2HpraWmev6
         m6AeoePFcqQXkhZkgW29UqNV1bHSwrK26YwpGturCpyV7fNQrpy981Jxq8VXJwDVQ73b
         gTOYJfXM3uDW+QOc5yrs77ZyQyYCH61NhpG7rTdaFNU6zmpmtXNyv34DykUDz/ak9GFU
         AvbYRFLPPMZLqUKk8Pw+xl8VO9IKBbF7V5uQuhXa86LwykLGZtZvF4qWKptPb9c5Ocv1
         dFe76i7VWi3VpnS+TbwWa6Z8sedqgKk++w/v0388hnXSOgrgelQPIzoJrFDAzYaBOPkt
         uxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pWvguxU3eSyxgm5KK2LlNZHVqfSSWmVcmTTsuJM7vT8=;
        b=ZgAVqiZ8y/cIFv1nKcWnHsJ2OghFQIBTQ3UVQe3p7jwn3IeH5TZH/CoUOu8qeQI19y
         TUbOMI4KCcDRj2AZEunu6yAKv3E5mRkXKajVSnd94PucK+SoscGkgQX8UlCdB1NV8A0F
         fWtIG9CfQn3YhA5bu6MTbwLRt9WMXZ5qcwJGioQqfXaLcqOX1XC5cKOfeZ9hs6S6uHgl
         6g+6MgBMZPxM7DeNXhVhGgBEaBt+YYICakDsXal2plNRUCoYME0ZVaQ5OOHIz3ocySf8
         zDVTlOYOPMCcfHzNr3e4EhZsOkY27Ofm/QH5eVgn9WOKqHdYdEkEYKRQlHjjzVITrXQ5
         qU4w==
X-Gm-Message-State: AHYfb5h8Srwi6vzna98vEtIw2g6Lkf8epYXTTEOfv+aNGv63fU7qqwX5
        i41tDmEJjd765O64fBJJyw==
X-Received: by 10.84.214.2 with SMTP id h2mr520337pli.436.1502220767470;
        Tue, 08 Aug 2017 12:32:47 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k186sm4332547pfc.173.2017.08.08.12.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 12:32:46 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 01/10] pack: move pack name-related functions
Date:   Tue,  8 Aug 2017 12:32:31 -0700
Message-Id: <368a1095557aa5f68cebd4d4e08628351c03b843.1502220307.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, sha1_file.c and cache.h contain many functions, both related
to and unrelated to packfiles. This makes both files very large and
causes an unclear separation of concerns.

Create a new file, pack.c, to hold all packfile-related functions
currently in sha1_file.c, and designate pack.h to hold these
packfile-related functions.

In this commit, the pack name-related functions are moved. Subsequent
commits will move the other functions.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile                 |  1 +
 builtin/pack-redundant.c |  1 +
 cache.h                  | 23 -----------------------
 pack.c                   | 23 +++++++++++++++++++++++
 pack.h                   | 23 +++++++++++++++++++++++
 sha1_file.c              | 22 ----------------------
 6 files changed, 48 insertions(+), 45 deletions(-)
 create mode 100644 pack.c

diff --git a/Makefile b/Makefile
index 461c845d3..a7b901a18 100644
--- a/Makefile
+++ b/Makefile
@@ -816,6 +816,7 @@ LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
 LIB_OBJS += oidset.o
+LIB_OBJS += pack.o
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
diff --git a/pack.c b/pack.c
new file mode 100644
index 000000000..0d191dfd6
--- /dev/null
+++ b/pack.c
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

