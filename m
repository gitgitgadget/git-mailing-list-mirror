Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EEBEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 19:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjF0TxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjF0TxL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 15:53:11 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC481FA
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:09 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-666ecb24eb3so2353981b3a.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687895589; x=1690487589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SG2lNsGTpCG7S67feE8zRGMcN1OLvtaAvYVrWUXtG2A=;
        b=r1366Tm1WZBOS8hpzdwHTqPklYoBFREWQcQXf89BAtbu23XgqFqwQaTz3UE9SF+shb
         cnSOAyM3sFriMWprzIahV7vFqa9tcZBi/Kbw8xK6lgZZ8g+2RpCof3ZWDebTKvuzKoZh
         6wA+gttglx9HBRNdfJqWHZi3E7wtdaOa4/djobGKpMKHpZpkCtdUTR0CyduZQtyFdEAY
         mF1pHB3G18dW27skm04HIy9nCpb04fnAe5O72CrBd4qeycIz26tfXXnsu1J5Igo00XYU
         mOfikAFV+h4ilfmVxJw8QU65K2S9Da44YCFC1E262gTbHxhm+IEtiiz6tZ2aWDAApGxf
         Wesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895589; x=1690487589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SG2lNsGTpCG7S67feE8zRGMcN1OLvtaAvYVrWUXtG2A=;
        b=XZWL1fVe3B4Le7IhIr7TORm9rQOlP2U5CO9/CUTTSCmWMJmoRi07OUHvfwp3RcfV3K
         XvZQ0m1uBDRdT+XpVZnNGjDHg/7FPiR1gCtuArnFK1Myx0ZvnXLIn+QvczavBLCvqLsW
         tej10RWuPql+a29ipUCmBg80w0gUcQfISwwW+s08kQcW/4m8wLeAzMfA306gOuI80h6L
         q73gW+eb780YoozGJ5sjnZSjUCKnpxXfWCGS8l9B7uqKXGT6fjWTOF//l/QDAyghLklx
         MOu3VP2ax5HRQTWD7BXdM5EriXTBK7bDjQZsB2+NkJMjJ3N1//DNX2yCD8vgLUDkpizk
         +ZfA==
X-Gm-Message-State: AC+VfDwnmHnRAfm51bujMnPwJPFq6gO2KMSuB7m86rN8HwE7j1G4tP1x
        7HercAeKvqG/gS5cLfzN9t2++hUoMBboh7lgidqTlFhG6uVileuJ1y0bI6/Osr4y3crOg4RAtsE
        11AAaYNNCyR0XEErjhI1MCq50Avk/tktkqUblzr5BtFRikAlIpqf3uWeeOkj9Mvt1Zg==
X-Google-Smtp-Source: ACHHUZ6wPnnb7obgrKoy1t/ewZa1vEyMBgGjkuOvcJo71ZEcvcXUqdakqhuKjzjKD57lVWCbZoWGA0kLfJExazk=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:24cd:b0:673:e4b4:fa35 with SMTP
 id d13-20020a056a0024cd00b00673e4b4fa35mr2293523pfv.2.1687895589227; Tue, 27
 Jun 2023 12:53:09 -0700 (PDT)
Date:   Tue, 27 Jun 2023 19:52:45 +0000
In-Reply-To: <20230627195251.1973421-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627195251.1973421-3-calvinwan@google.com>
Subject: [RFC PATCH 2/8] hex-ll: split out functionality from hex
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, johnathantanmy@google.com
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
2.41.0.162.gfafddb0af9-goog

