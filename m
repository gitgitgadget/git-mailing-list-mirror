Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D1D1FAED
	for <e@80x24.org>; Tue, 24 Oct 2017 23:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbdJXXpL (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 19:45:11 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:49160 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbdJXXpK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 19:45:10 -0400
Received: by mail-io0-f195.google.com with SMTP id n137so25777859iod.6
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 16:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nly64BDQtcxDMVxTU7Bz2uoO0KoyDqJmKByyu2ospXQ=;
        b=RM2/F3+81bjxE+awsdr84CtAwk32ZxtXM/1xYO2rJsMJ5+TkaQNO7mE/2AKKQO6M43
         ZPaMPi9qDElNldNzNMTQb4ghsbLllVWNEmCfwxzY5qw2/ovIT2iqJyhYYYJEhYRRs9jb
         TNMKC6pUyg6Qd+Y/Top2R+A+Ub9+NNu2EnRXwZWRwyouMgGn/Gmx0w8kbMx0YYFjkmjk
         dwqrvc7ARETqo8uRlakPPX8YVae0reK9B4pJjwnutXi7t9jn9JVsNYFAaq3lnn02uShQ
         QcO2cFLtc0Ue0IqCTLE5j74aCs8k0GjcAiQzd0sZFnilcXJieOdlPRy/gIijpBkQKHFG
         Zuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nly64BDQtcxDMVxTU7Bz2uoO0KoyDqJmKByyu2ospXQ=;
        b=VJyyJADSwlmv6CSpoiLlw7mEn/qdl9NSq20S0WFTqkGEEcg7OBsVyutFZEC8njNIFY
         DKVeWBafQSr82qE5aSaR2yK46NY/4wcAnOzI5Peek4Yw9bik4+8/KjMyeqStXBtPTR12
         q+Z5Z3Gp0uITga9A453eU7ESPFx1cEkphHQl9X2y9g1yGsj0dKHkAEyl1g7oxHlUvEXa
         ZPfF9f/924Dn6FpoqXdg3SJ5F8hby+QR7bvgU1PtobQRGWDQn6RibICo/ygoqyyO13H7
         nd6qsg2UJgSAi8vN9mrSOF0V0LYI9in/yM5x9W/VIlGI2Z8uVvz0Dz79NGMtu1kk/Bhh
         5GnA==
X-Gm-Message-State: AMCzsaVNUUggPUT+Cc1A9KWCGbyE+PVHbopLCAnBe65qmPG1b6c4QAm8
        Zb0lDGho3eF/+fLj7jNUkFNIoQ==
X-Google-Smtp-Source: ABhQp+QK1bdz3+LrT52CPdt6orc8p6wBPOUimQde7WFGcYTd1GmDWvpE7abFeOkOOU+Yi85ho/q1Lw==
X-Received: by 10.107.134.216 with SMTP id q85mr23207811ioi.197.1508888709170;
        Tue, 24 Oct 2017 16:45:09 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:24db:446:6fc5:b25b])
        by smtp.gmail.com with ESMTPSA id 23sm666929itj.15.2017.10.24.16.45.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Oct 2017 16:45:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, peff@peff.net, l.s.r@web.de
Subject: [PATCH 1/5] fnv: migrate code from hashmap to fnv
Date:   Tue, 24 Oct 2017 16:45:05 -0700
Message-Id: <20171024234505.11823-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <CAGZ79kZftQoP-Ht+VRakCZsQxh1tjfu=4DFJn_R6fiKD2MmzMA@mail.gmail.com>
References: <CAGZ79kZftQoP-Ht+VRakCZsQxh1tjfu=4DFJn_R6fiKD2MmzMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The functions regarding the Fowler–Noll–Vo hash function are put in a
separate compilation unit, as it is logically different from the hashmap
functionality.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This may still be an interesting cleanup on its own.

Thanks,
Stefan

 Makefile                |  1 +
 attr.c                  |  1 +
 builtin/fast-export.c   |  1 +
 diff.c                  |  1 +
 fnv.c                   | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 fnv.h                   | 20 ++++++++++++++++
 hashmap.c               | 64 +------------------------------------------------
 hashmap.h               | 15 ------------
 merge-recursive.c       |  1 +
 remote.c                |  1 +
 submodule-config.c      |  1 +
 t/helper/test-hashmap.c |  1 +
 12 files changed, 93 insertions(+), 78 deletions(-)
 create mode 100644 fnv.c
 create mode 100644 fnv.h

diff --git a/Makefile b/Makefile
index cd75985991..8e1c5988f3 100644
--- a/Makefile
+++ b/Makefile
@@ -793,6 +793,7 @@ LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec_cmd.o
 LIB_OBJS += fetch-pack.o
+LIB_OBJS += fnv.o
 LIB_OBJS += fsck.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
diff --git a/attr.c b/attr.c
index dfc3a558d8..2e4217c4f1 100644
--- a/attr.c
+++ b/attr.c
@@ -16,6 +16,7 @@
 #include "utf8.h"
 #include "quote.h"
 #include "thread-utils.h"
+#include "fnv.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 2fb60d6d48..62f4010510 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -21,6 +21,7 @@
 #include "quote.h"
 #include "remote.h"
 #include "blob.h"
+#include "fnv.h"
 
 static const char *fast_export_usage[] = {
 	N_("git fast-export [rev-list-opts]"),
diff --git a/diff.c b/diff.c
index c4a669ffa8..a23f4521fb 100644
--- a/diff.c
+++ b/diff.c
@@ -22,6 +22,7 @@
 #include "argv-array.h"
 #include "graph.h"
 #include "packfile.h"
+#include "fnv.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
diff --git a/fnv.c b/fnv.c
new file mode 100644
index 0000000000..b4cbf39f0a
--- /dev/null
+++ b/fnv.c
@@ -0,0 +1,64 @@
+#include "fnv.h"
+
+#define FNV32_BASE ((unsigned int) 0x811c9dc5)
+#define FNV32_PRIME ((unsigned int) 0x01000193)
+
+unsigned int strhash(const char *str)
+{
+	unsigned int c, hash = FNV32_BASE;
+	while ((c = (unsigned char) *str++))
+		hash = (hash * FNV32_PRIME) ^ c;
+	return hash;
+}
+
+unsigned int strihash(const char *str)
+{
+	unsigned int c, hash = FNV32_BASE;
+	while ((c = (unsigned char) *str++)) {
+		if (c >= 'a' && c <= 'z')
+			c -= 'a' - 'A';
+		hash = (hash * FNV32_PRIME) ^ c;
+	}
+	return hash;
+}
+
+unsigned int memhash(const void *buf, size_t len)
+{
+	unsigned int hash = FNV32_BASE;
+	unsigned char *ucbuf = (unsigned char *) buf;
+	while (len--) {
+		unsigned int c = *ucbuf++;
+		hash = (hash * FNV32_PRIME) ^ c;
+	}
+	return hash;
+}
+
+unsigned int memihash(const void *buf, size_t len)
+{
+	unsigned int hash = FNV32_BASE;
+	unsigned char *ucbuf = (unsigned char *) buf;
+	while (len--) {
+		unsigned int c = *ucbuf++;
+		if (c >= 'a' && c <= 'z')
+			c -= 'a' - 'A';
+		hash = (hash * FNV32_PRIME) ^ c;
+	}
+	return hash;
+}
+
+/*
+ * Incoporate another chunk of data into a memihash
+ * computation.
+ */
+unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len)
+{
+	unsigned int hash = hash_seed;
+	unsigned char *ucbuf = (unsigned char *) buf;
+	while (len--) {
+		unsigned int c = *ucbuf++;
+		if (c >= 'a' && c <= 'z')
+			c -= 'a' - 'A';
+		hash = (hash * FNV32_PRIME) ^ c;
+	}
+	return hash;
+}
diff --git a/fnv.h b/fnv.h
new file mode 100644
index 0000000000..b425c85c66
--- /dev/null
+++ b/fnv.h
@@ -0,0 +1,20 @@
+#ifndef FNV_H
+#define FNV_H
+
+#include <stdlib.h>
+/*
+ * Ready-to-use hash functions for strings, using the FNV-1 algorithm (see
+ * http://www.isthe.com/chongo/tech/comp/fnv).
+ * `strhash` and `strihash` take 0-terminated strings, while `memhash` and
+ * `memihash` operate on arbitrary-length memory.
+ * `strihash` and `memihash` are case insensitive versions.
+ * `memihash_cont` is a variant of `memihash` that allows a computation to be
+ * continued with another chunk of data.
+ */
+extern unsigned int strhash(const char *buf);
+extern unsigned int strihash(const char *buf);
+extern unsigned int memhash(const void *buf, size_t len);
+extern unsigned int memihash(const void *buf, size_t len);
+extern unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len);
+
+#endif
diff --git a/hashmap.c b/hashmap.c
index d42f01ff5a..1605edbbc3 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -3,69 +3,7 @@
  */
 #include "cache.h"
 #include "hashmap.h"
-
-#define FNV32_BASE ((unsigned int) 0x811c9dc5)
-#define FNV32_PRIME ((unsigned int) 0x01000193)
-
-unsigned int strhash(const char *str)
-{
-	unsigned int c, hash = FNV32_BASE;
-	while ((c = (unsigned char) *str++))
-		hash = (hash * FNV32_PRIME) ^ c;
-	return hash;
-}
-
-unsigned int strihash(const char *str)
-{
-	unsigned int c, hash = FNV32_BASE;
-	while ((c = (unsigned char) *str++)) {
-		if (c >= 'a' && c <= 'z')
-			c -= 'a' - 'A';
-		hash = (hash * FNV32_PRIME) ^ c;
-	}
-	return hash;
-}
-
-unsigned int memhash(const void *buf, size_t len)
-{
-	unsigned int hash = FNV32_BASE;
-	unsigned char *ucbuf = (unsigned char *) buf;
-	while (len--) {
-		unsigned int c = *ucbuf++;
-		hash = (hash * FNV32_PRIME) ^ c;
-	}
-	return hash;
-}
-
-unsigned int memihash(const void *buf, size_t len)
-{
-	unsigned int hash = FNV32_BASE;
-	unsigned char *ucbuf = (unsigned char *) buf;
-	while (len--) {
-		unsigned int c = *ucbuf++;
-		if (c >= 'a' && c <= 'z')
-			c -= 'a' - 'A';
-		hash = (hash * FNV32_PRIME) ^ c;
-	}
-	return hash;
-}
-
-/*
- * Incoporate another chunk of data into a memihash
- * computation.
- */
-unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len)
-{
-	unsigned int hash = hash_seed;
-	unsigned char *ucbuf = (unsigned char *) buf;
-	while (len--) {
-		unsigned int c = *ucbuf++;
-		if (c >= 'a' && c <= 'z')
-			c -= 'a' - 'A';
-		hash = (hash * FNV32_PRIME) ^ c;
-	}
-	return hash;
-}
+#include "fnv.h"
 
 #define HASHMAP_INITIAL_SIZE 64
 /* grow / shrink by 2^2 */
diff --git a/hashmap.h b/hashmap.h
index 7cb29a6aed..96176f7d8c 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -97,21 +97,6 @@
  * }
  */
 
-/*
- * Ready-to-use hash functions for strings, using the FNV-1 algorithm (see
- * http://www.isthe.com/chongo/tech/comp/fnv).
- * `strhash` and `strihash` take 0-terminated strings, while `memhash` and
- * `memihash` operate on arbitrary-length memory.
- * `strihash` and `memihash` are case insensitive versions.
- * `memihash_cont` is a variant of `memihash` that allows a computation to be
- * continued with another chunk of data.
- */
-extern unsigned int strhash(const char *buf);
-extern unsigned int strihash(const char *buf);
-extern unsigned int memhash(const void *buf, size_t len);
-extern unsigned int memihash(const void *buf, size_t len);
-extern unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len);
-
 /*
  * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
  * for use in hash tables. Cryptographic hashes are supposed to have
diff --git a/merge-recursive.c b/merge-recursive.c
index 1d3f8f0d22..d1fb2f5f3d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -22,6 +22,7 @@
 #include "attr.h"
 #include "merge-recursive.h"
 #include "dir.h"
+#include "fnv.h"
 #include "submodule.h"
 
 struct path_hashmap_entry {
diff --git a/remote.c b/remote.c
index b220f0dfc6..24957ba32c 100644
--- a/remote.c
+++ b/remote.c
@@ -10,6 +10,7 @@
 #include "string-list.h"
 #include "mergesort.h"
 #include "argv-array.h"
+#include "fnv.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
 
diff --git a/submodule-config.c b/submodule-config.c
index 2aa8a1747f..432423f876 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -5,6 +5,7 @@
 #include "submodule.h"
 #include "strbuf.h"
 #include "parse-options.h"
+#include "fnv.h"
 
 /*
  * submodule cache lookup structure
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 1145d51671..b5ac97886f 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "hashmap.h"
+#include "fnv.h"
 
 struct test_entry
 {
-- 
2.15.0.rc2.6.g953226eb5f

