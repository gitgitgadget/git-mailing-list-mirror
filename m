Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A176BEEB562
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 17:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245460AbjIHRpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 13:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244871AbjIHRo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 13:44:59 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0291FDF
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 10:44:52 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-573e1a0b355so2391129a12.3
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694195092; x=1694799892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wqVl59QBBEAuF7wpef8DmaKL3shAHLyBUSZYA8kCQng=;
        b=mX58Ogqjp+DYdlU6yJrBTvrDNU1pZkKVWAwagw6gsvWfkxCnxxdcBH+aGV3dQmTWj7
         d+3VU1rdxd7S/4x8w0MUk3X17W/u/t8F1vGbzYk3/plJNU1QjipTp60xr1gf3ppEBhNX
         3mkNL74xWJVSvBBxCaj5OHczzJRZGtyElxUC94vWKU/5guEz11oZJLwHY90F10cItbdK
         bWmRgEFmRuDuymhhbPyFUCImiCyMSxzfHT+gvCrVozS67uat6+zd26OO4EIwbWNUJrR/
         LKJgYbwszbmem9wZgM5bMuh/1F7vHN3T5gyKK2dLt2Ks6ES/nm2E7tAY10DYHf96roMW
         UdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195092; x=1694799892;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqVl59QBBEAuF7wpef8DmaKL3shAHLyBUSZYA8kCQng=;
        b=DnsBgXRic7PAAwq/1hAmdEncFrTi7si83K64xXCt6hHYRXGncXwDAL1j2vPzwv8th3
         KwEqxowDdtkLDChEDHs5NybYfc7jilPa34xhcYJfKqFb6Cz12px5JFyVqS8zgtBDRJSA
         XeF5gNbLwSCUe/OCmNLWzhXQJXMrvKkzIbHp1nKhUFFzQZFJpqtMyk4cbP0klGMYkxVp
         Ym1CBHiF2Gx7VcvTUzx5FD3NWQYQhYunfwHIm3Y2dT/N1Yn0by6Ayzw40n7czSnF9GXN
         9jCZX42BwTBktZjEA2aRaenaO3MA/OJtvzMFIR8YPeEQ0xAQhCnXXl+iek2OJFhXUJop
         4d0g==
X-Gm-Message-State: AOJu0Yx9dF4VnizZonZ9uSsaON/N3b69AGcsZ2ZXJiN3v/5y5ZxRLFvn
        FsbV1Ivi8xJia5OkyaUccAF09wpoZ70lJf0sTqOCxbw0mKOg/9UjDo4Xeud+jPdd271aUN0UCf6
        i4YicvNTS5IWyn3E+Dp/mKj8xh+vxwVcMD/RWphij277thNm3R2a4hFcTb0DPoXnZ3A==
X-Google-Smtp-Source: AGHT+IHw71OODATDSAyl5Xiy2CygjPGRLEYHt+9wxVW9EwhSEjH1ilqbt8NNDzC4H2ZY4ORvOwxPS2z/qN6+5kg=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:3688:0:b0:573:f74f:7df7 with SMTP id
 d130-20020a633688000000b00573f74f7df7mr568285pga.11.1694195091670; Fri, 08
 Sep 2023 10:44:51 -0700 (PDT)
Date:   Fri,  8 Sep 2023 17:44:38 +0000
In-Reply-To: <20230908174134.1026823-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230908174134.1026823-1-calvinwan@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908174443.1027716-1-calvinwan@google.com>
Subject: [PATCH v3 1/6] hex-ll: split out functionality from hex
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
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
index 5776309365..861e643708 100644
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
index b24b19566b..f663c06ac4 100644
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
index 01f17fe5c9..d42262bdca 100644
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
index 87abf66602..e0b83f776f 100644
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
  * Try to read a hash (specified by the_hash_algo) in hexadecimal
@@ -34,13 +19,6 @@ int get_oid_hex(const char *hex, struct object_id *oid);
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
index 931505363c..a07d2da16d 100644
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
index 4c9ac6dc5e..7827178d8e 100644
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
index 1c45f23adf..1d0254abac 100644
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
2.42.0.283.g2d96d420d3-goog

