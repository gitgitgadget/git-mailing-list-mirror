Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149DFC04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjHJQho (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjHJQh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:37:26 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A2A3594
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:37:13 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-268113acd37so2583577a91.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691685432; x=1692290232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gvUy7Y4qaaLH7U9v1tJENsPpGvTJY0Uq1ZdI0IMvB/o=;
        b=pXosnucNH3DYRiGcPeH4fTStf5lavWjqx+g8HborWJvomw0+azcgsOoVxDOquiDunT
         sANjha8/jeDlTvGThswcz/l+tBkOJh/RXCGFn9fHZ/GPsJCfs01xOZG2iSFa8t9VGNgn
         NJIXgbPfIIaFOwy1sOqWfTfFk2DZ4WZ9YIfrdb+7O4sUktOiAPXmsO11C36D8H9e+nJW
         w2d0WSAALfwWMSzGFZUi2dnDns0hcPkP/PrLU0Fcu0lz+gDKBiwg2pOOYfTE19rIGXTd
         vd+vSODk30Tu6rowrKKXvRD2/BQJmX6sBtVz/ZMsDf0Fo4DgHAr675OpOA5tqELenao2
         clrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685432; x=1692290232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvUy7Y4qaaLH7U9v1tJENsPpGvTJY0Uq1ZdI0IMvB/o=;
        b=VBRLnv0MbVRDGP08pdtmVMwHOw7pRLKBq6b1CylK+qJDO+/+PLuV3KUqdQBdx+L1/z
         A4PwsT6UUeUi9VaQ4DhuaoD3iVuyFN5Xjo3L+u3EQhf9Hi8+Fp0jmaWF7DMiyK1DckRo
         LyxE7wcc9hOSnKzn1Q/R7NgOqSHx6ACAkGGxBhJK8xzn/YSExEbB1+OsrSIMtVmP7POv
         L8SR73OvQFRyr4siBGdg9cCRlFCS8r6CAeCETiGi5FuQ//mve+bhdKLAqZneCdRjGatj
         hvoTuavc7H9bDVELnwz7AuezKPSBNvVicFUG8bjFgbHRITiZ9a09nxXcNZNtCJTKgPB8
         ttEg==
X-Gm-Message-State: AOJu0YyfA7bvs2VaYuU7Mdli5Sxe6lFD4cgf6b05t1t5KQoq4IQElU52
        EQrlwB/jRhlcfHiugmp4NtxASN+6mxfYgngBL+EUbR9Xft9ZQ3K/1hfnVvcVvTle/owOSD/6GpW
        /xXhT6863hOHCBZ2iK+eEx7teCbToqjgc1P3/2v36A+6m+v1rpUx5PZNudD8or/KwlA==
X-Google-Smtp-Source: AGHT+IGk9Lc0AmXQsmJJt4ZBuyWk56nlGqROMlEj9y+ZfMiVDdw0P/Hv9LVRNz4c/3sbgmmjyCqfxHV/yC67b4U=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:1197:b0:269:32cb:3321 with SMTP
 id gk23-20020a17090b119700b0026932cb3321mr591843pjb.0.1691685432246; Thu, 10
 Aug 2023 09:37:12 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:36:48 +0000
In-Reply-To: <20230810163346.274132-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230810163346.274132-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810163654.275023-1-calvinwan@google.com>
Subject: [RFC PATCH v2 1/7] hex-ll: split out functionality from hex
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Separate out hex functionality that doesn't require a hash algo into
hex-ll.[ch]. Since the hash algo is currently a global that sits in
repository, this separation removes that dependency for files that only
need basic hex manipulation functions.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Makefile   |  1 +
 color.c    |  2 +-
 hex-ll.c   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 hex-ll.h   | 27 +++++++++++++++++++++++++++
 hex.c      | 47 -----------------------------------------------
 hex.h      | 24 +-----------------------
 mailinfo.c |  2 +-
 strbuf.c   |  2 +-
 url.c      |  2 +-
 urlmatch.c |  2 +-
 10 files changed, 83 insertions(+), 75 deletions(-)
 create mode 100644 hex-ll.c
 create mode 100644 hex-ll.h

diff --git a/Makefile b/Makefile
index 045e2187c4..83b385b0be 100644
--- a/Makefile
+++ b/Makefile
@@ -1040,6 +1040,7 @@ LIB_OBJS += hash-lookup.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hex-ll.o
 LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += json-writer.o
diff --git a/color.c b/color.c
index 83abb11eda..f3c0a4659b 100644
--- a/color.c
+++ b/color.c
@@ -3,7 +3,7 @@
 #include "color.h"
 #include "editor.h"
 #include "gettext.h"
-#include "hex.h"
+#include "hex-ll.h"
 #include "pager.h"
 #include "strbuf.h"
 
diff --git a/hex-ll.c b/hex-ll.c
new file mode 100644
index 0000000000..4d7ece1de5
--- /dev/null
+++ b/hex-ll.c
@@ -0,0 +1,49 @@
+#include "git-compat-util.h"
+#include "hex-ll.h"
+
+const signed char hexval_table[256] = {
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 10-17 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 18-1f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 20-27 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 28-2f */
+	  0,  1,  2,  3,  4,  5,  6,  7,		/* 30-37 */
+	  8,  9, -1, -1, -1, -1, -1, -1,		/* 38-3f */
+	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 40-47 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 48-4f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 50-57 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 58-5f */
+	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 60-67 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 68-67 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 70-77 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 78-7f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 80-87 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 88-8f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 90-97 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 98-9f */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a0-a7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a8-af */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b0-b7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b8-bf */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c0-c7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c8-cf */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d0-d7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d8-df */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e0-e7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e8-ef */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f0-f7 */
+	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f8-ff */
+};
+
+int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
+{
+	for (; len; len--, hex += 2) {
+		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
+
+		if (val & ~0xff)
+			return -1;
+		*binary++ = val;
+	}
+	return 0;
+}
diff --git a/hex-ll.h b/hex-ll.h
new file mode 100644
index 0000000000..a381fa8556
--- /dev/null
+++ b/hex-ll.h
@@ -0,0 +1,27 @@
+#ifndef HEX_LL_H
+#define HEX_LL_H
+
+extern const signed char hexval_table[256];
+static inline unsigned int hexval(unsigned char c)
+{
+	return hexval_table[c];
+}
+
+/*
+ * Convert two consecutive hexadecimal digits into a char.  Return a
+ * negative value on error.  Don't run over the end of short strings.
+ */
+static inline int hex2chr(const char *s)
+{
+	unsigned int val = hexval(s[0]);
+	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
+}
+
+/*
+ * Read `len` pairs of hexadecimal digits from `hex` and write the
+ * values to `binary` as `len` bytes. Return 0 on success, or -1 if
+ * the input does not consist of hex digits).
+ */
+int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
+
+#endif
diff --git a/hex.c b/hex.c
index 7bb440e794..03e55841ed 100644
--- a/hex.c
+++ b/hex.c
@@ -2,53 +2,6 @@
 #include "hash.h"
 #include "hex.h"
 
-const signed char hexval_table[256] = {
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 10-17 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 18-1f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 20-27 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 28-2f */
-	  0,  1,  2,  3,  4,  5,  6,  7,		/* 30-37 */
-	  8,  9, -1, -1, -1, -1, -1, -1,		/* 38-3f */
-	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 40-47 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 48-4f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 50-57 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 58-5f */
-	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 60-67 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 68-67 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 70-77 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 78-7f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 80-87 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 88-8f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 90-97 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 98-9f */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a0-a7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* a8-af */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b0-b7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* b8-bf */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c0-c7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* c8-cf */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d0-d7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* d8-df */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e0-e7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* e8-ef */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f0-f7 */
-	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f8-ff */
-};
-
-int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
-{
-	for (; len; len--, hex += 2) {
-		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
-
-		if (val & ~0xff)
-			return -1;
-		*binary++ = val;
-	}
-	return 0;
-}
-
 static int get_hash_hex_algop(const char *hex, unsigned char *hash,
 			      const struct git_hash_algo *algop)
 {
diff --git a/hex.h b/hex.h
index 7df4b3c460..c07c8b34c2 100644
--- a/hex.h
+++ b/hex.h
@@ -2,22 +2,7 @@
 #define HEX_H
 
 #include "hash-ll.h"
-
-extern const signed char hexval_table[256];
-static inline unsigned int hexval(unsigned char c)
-{
-	return hexval_table[c];
-}
-
-/*
- * Convert two consecutive hexadecimal digits into a char.  Return a
- * negative value on error.  Don't run over the end of short strings.
- */
-static inline int hex2chr(const char *s)
-{
-	unsigned int val = hexval(s[0]);
-	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
-}
+#include "hex-ll.h"
 
 /*
  * Try to read a SHA1 in hexadecimal format from the 40 characters
@@ -32,13 +17,6 @@ int get_oid_hex(const char *hex, struct object_id *sha1);
 /* Like get_oid_hex, but for an arbitrary hash algorithm. */
 int get_oid_hex_algop(const char *hex, struct object_id *oid, const struct git_hash_algo *algop);
 
-/*
- * Read `len` pairs of hexadecimal digits from `hex` and write the
- * values to `binary` as `len` bytes. Return 0 on success, or -1 if
- * the input does not consist of hex digits).
- */
-int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
-
 /*
  * Convert a binary hash in "unsigned char []" or an object name in
  * "struct object_id *" to its hex equivalent. The `_r` variant is reentrant,
diff --git a/mailinfo.c b/mailinfo.c
index 2aeb20e5e6..eb34c30be7 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
-#include "hex.h"
+#include "hex-ll.h"
 #include "utf8.h"
 #include "strbuf.h"
 #include "mailinfo.h"
diff --git a/strbuf.c b/strbuf.c
index 8dac52b919..a2a05fe168 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "hex.h"
+#include "hex-ll.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "utf8.h"
diff --git a/url.c b/url.c
index 2e1a9f6fee..282b12495a 100644
--- a/url.c
+++ b/url.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "hex.h"
+#include "hex-ll.h"
 #include "strbuf.h"
 #include "url.h"
 
diff --git a/urlmatch.c b/urlmatch.c
index eba0bdd77f..f1aa87d1dd 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "hex.h"
+#include "hex-ll.h"
 #include "strbuf.h"
 #include "urlmatch.h"
 
-- 
2.41.0.640.ga95def55d0-goog

