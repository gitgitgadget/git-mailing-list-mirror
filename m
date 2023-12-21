Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753F79941
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fubh36uF"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a268836254aso158834966b.1
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 15:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703200560; x=1703805360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SjF9UJhysIGtR2S0v5x/YC2giY92YqwliwbkzwCgEEo=;
        b=Fubh36uF+gtr8G6dyI88lAxIuZ3v0b7qN8RXa3bMQwaounMmsL5P1Pgayuw/MDs4Ec
         aIrnAfs9k8Bb7BisJdoiak9H2AjfIb/jyQE5cmUxJ0piGx/QfuLYpgoUEH3sr2ous6aL
         4hak5LOPdaD74URZgTb4//GTqBIgtEg4HU4hfMV2fK8Ca0JoRH3g+5HokP4QmwqaTwsc
         3Ib4kz/2bo5zyOw4IjJDDT1rWx4UrN1TvvLKP8r2U7IOu8ZbQfpazFMhlMsD1bQI0bj0
         8/O+S3hEs+U+RXfsBSN3hYucSGZkFOTByZgFhsTErPCb6vlEsO6jxuCFZOe4TDNmtKMX
         Kkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703200560; x=1703805360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjF9UJhysIGtR2S0v5x/YC2giY92YqwliwbkzwCgEEo=;
        b=YsI429mIs9bt8ezl4jCe3iIUXVEiQIOmmSEytSyzsYtVtClv0DajLnCaEwtkmJOSLG
         3/fjZbdLcuiw3wz+LwUQM9SpARJ2bUKgEhfE/nXczl23zULmBFh/QZkFXeTDwSV1ZLAe
         oJehLhZ7/x0lf3kCXAEN2D3OZaSqiu6mi1bl+5WweTuKU9mp2RQdPFErPWVvWTbbJqDT
         OiQdzqIElQshPEVkQrI2u1vK6aO0Kgyby9Zjs++/vrKJv4lA7D9fAVT50OdSQkJ+tVmP
         zs4MQHL+dS1TL5NWC1kAL64Az6Scj7BR5djNR7REeVKfzI+u35Rs1Er8PJzxbcPTY4am
         4PCw==
X-Gm-Message-State: AOJu0YzUJebIsY1z6lD02e2rClXr18MS8W+8K3ApvNxOv1GCOfyd7M/p
	sl3KHlEqzDl40mXwULlEC2h4uKzH2hk0HQ==
X-Google-Smtp-Source: AGHT+IEBW4/t3tpotHxrgham0E8ZY05dFkF2nB82m6M1L7GkSWuQ8l8CNCSX1/dcXELYJY+OolAZLQ==
X-Received: by 2002:a17:906:c5:b0:a26:86af:f1bc with SMTP id 5-20020a17090600c500b00a2686aff1bcmr270565eji.18.1703200560215;
        Thu, 21 Dec 2023 15:16:00 -0800 (PST)
Received: from localhost.localdomain ([129.0.78.204])
        by smtp.gmail.com with ESMTPSA id p6-20020a170907910600b00a26a097d4bfsm1338989ejq.85.2023.12.21.15.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:15:59 -0800 (PST)
From: Achu Luma <ach.lumap@gmail.com>
To: christian.couder@gmail.com
Cc: git@vger.kernel.org,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Port helper/test-ctype.c to unit-tests/t-ctype.c
Date: Fri, 22 Dec 2023 00:15:27 +0100
Message-ID: <20231221231527.8130-1-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update (8bf6fbd00d (Merge branch
'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
merged, providing a standardized approach for testing C code. Prior to
this update, some unit tests relied on the test helper mechanism,
lacking a dedicated unit testing framework. It's more natural to perform
these unit tests using the new unit test framework.

This commit migrates the unit tests for C character classification
functions (isdigit(), isspace(), etc) from the legacy approach
using the test-tool command `test-tool ctype` in t/helper/test-ctype.c
to the new unit testing framework (t/unit-tests/test-lib.h).

The migration involves refactoring the tests to utilize the testing
macros provided by the framework (TEST() and check_*()).

Mentored-by: Christian Couder <chriscool@tuxfamily.org> 
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
---
 Makefile               |  2 +-
 t/helper/test-ctype.c  | 70 --------------------------------------
 t/helper/test-tool.c   |  1 -
 t/helper/test-tool.h   |  1 -
 t/t0070-fundamental.sh |  4 ---
 t/unit-tests/t-ctype.c | 76 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 77 insertions(+), 77 deletions(-)
 delete mode 100644 t/helper/test-ctype.c
 create mode 100644 t/unit-tests/t-ctype.c

diff --git a/Makefile b/Makefile
index 88ba7a3c51..a4df48ba65 100644
--- a/Makefile
+++ b/Makefile
@@ -792,7 +792,6 @@ TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-crontab.o
 TEST_BUILTINS_OBJS += test-csprng.o
-TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delta.o
 TEST_BUILTINS_OBJS += test-dir-iterator.o
@@ -1341,6 +1340,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 
 UNIT_TEST_PROGRAMS += t-basic
 UNIT_TEST_PROGRAMS += t-strbuf
+UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
deleted file mode 100644
index e5659df40b..0000000000
--- a/t/helper/test-ctype.c
+++ /dev/null
@@ -1,70 +0,0 @@
-#include "test-tool.h"
-
-static int rc;
-
-static void report_error(const char *class, int ch)
-{
-	printf("%s classifies char %d (0x%02x) wrongly\n", class, ch, ch);
-	rc = 1;
-}
-
-static int is_in(const char *s, int ch)
-{
-	/*
-	 * We can't find NUL using strchr. Accept it as the first
-	 * character in the spec -- there are no empty classes.
-	 */
-	if (ch == '\0')
-		return ch == *s;
-	if (*s == '\0')
-		s++;
-	return !!strchr(s, ch);
-}
-
-#define TEST_CLASS(t,s) {			\
-	int i;					\
-	for (i = 0; i < 256; i++) {		\
-		if (is_in(s, i) != t(i))	\
-			report_error(#t, i);	\
-	}					\
-	if (t(EOF))				\
-		report_error(#t, EOF);		\
-}
-
-#define DIGIT "0123456789"
-#define LOWER "abcdefghijklmnopqrstuvwxyz"
-#define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
-#define PUNCT "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
-#define ASCII \
-	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
-	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
-	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
-	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
-	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
-	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
-	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
-	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
-#define CNTRL \
-	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
-	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
-	"\x7f"
-
-int cmd__ctype(int argc UNUSED, const char **argv UNUSED)
-{
-	TEST_CLASS(isdigit, DIGIT);
-	TEST_CLASS(isspace, " \n\r\t");
-	TEST_CLASS(isalpha, LOWER UPPER);
-	TEST_CLASS(isalnum, LOWER UPPER DIGIT);
-	TEST_CLASS(is_glob_special, "*?[\\");
-	TEST_CLASS(is_regex_special, "$()*+.?[\\^{|");
-	TEST_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=>@_`~");
-	TEST_CLASS(isascii, ASCII);
-	TEST_CLASS(islower, LOWER);
-	TEST_CLASS(isupper, UPPER);
-	TEST_CLASS(iscntrl, CNTRL);
-	TEST_CLASS(ispunct, PUNCT);
-	TEST_CLASS(isxdigit, DIGIT "abcdefABCDEF");
-	TEST_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");
-
-	return rc;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 37ba996539..33b9501c21 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -19,7 +19,6 @@ static struct test_cmd cmds[] = {
 	{ "config", cmd__config },
 	{ "crontab", cmd__crontab },
 	{ "csprng", cmd__csprng },
-	{ "ctype", cmd__ctype },
 	{ "date", cmd__date },
 	{ "delta", cmd__delta },
 	{ "dir-iterator", cmd__dir_iterator },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 8a1a7c63da..b72f07ded9 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -12,7 +12,6 @@ int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__crontab(int argc, const char **argv);
 int cmd__csprng(int argc, const char **argv);
-int cmd__ctype(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
 int cmd__dir_iterator(int argc, const char **argv);
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 487bc8d905..a4756fbab9 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -9,10 +9,6 @@ Verify wrappers and compatibility functions.
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-test_expect_success 'character classes (isspace, isalpha etc.)' '
-	test-tool ctype
-'
-
 test_expect_success 'mktemp to nonexistent directory prints filename' '
 	test_must_fail test-tool mktemp doesnotexist/testXXXXXX 2>err &&
 	grep "doesnotexist/test" err
diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
new file mode 100644
index 0000000000..41189ba9f9
--- /dev/null
+++ b/t/unit-tests/t-ctype.c
@@ -0,0 +1,76 @@
+#include "test-lib.h"
+
+static int is_in(const char *s, int ch)
+{
+	/*
+	 * We can't find NUL using strchr. Accept it as the first
+	 * character in the spec -- there are no empty classes.
+	 */
+	if (ch == '\0')
+		return ch == *s;
+	if (*s == '\0')
+		s++;
+	return !!strchr(s, ch);
+}
+
+/* Macro to test a character type */
+#define TEST_CTYPE_FUNC(func, string)			\
+static void test_ctype_##func(void)				\
+{								\
+	int i;                                     	 	\
+	for (i = 0; i < 256; i++)                 		\
+		check_int(func(i), ==, is_in(string, i)); 	\
+}
+
+#define DIGIT "0123456789"
+#define LOWER "abcdefghijklmnopqrstuvwxyz"
+#define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+#define PUNCT "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
+#define ASCII \
+	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
+	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
+	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
+	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
+	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
+	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
+	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
+	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+#define CNTRL \
+	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
+	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
+	"\x7f"
+
+TEST_CTYPE_FUNC(isdigit, DIGIT)
+TEST_CTYPE_FUNC(isspace, " \n\r\t")
+TEST_CTYPE_FUNC(isalpha, LOWER UPPER)
+TEST_CTYPE_FUNC(isalnum, LOWER UPPER DIGIT)
+TEST_CTYPE_FUNC(is_glob_special, "*?[\\")
+TEST_CTYPE_FUNC(is_regex_special, "$()*+.?[\\^{|")
+TEST_CTYPE_FUNC(is_pathspec_magic, "!\"#%&',-/:;<=>@_`~")
+TEST_CTYPE_FUNC(isascii, ASCII)
+TEST_CTYPE_FUNC(islower, LOWER)
+TEST_CTYPE_FUNC(isupper, UPPER)
+TEST_CTYPE_FUNC(iscntrl, CNTRL)
+TEST_CTYPE_FUNC(ispunct, PUNCT)
+TEST_CTYPE_FUNC(isxdigit, DIGIT "abcdefABCDEF")
+TEST_CTYPE_FUNC(isprint, LOWER UPPER DIGIT PUNCT " ")
+
+int cmd_main(int argc, const char **argv) {
+	/* Run all character type tests */
+	TEST(test_ctype_isspace(), "isspace() works as we expect");
+	TEST(test_ctype_isdigit(), "isdigit() works as we expect");
+	TEST(test_ctype_isalpha(), "isalpha() works as we expect");
+	TEST(test_ctype_isalnum(), "isalnum() works as we expect");
+	TEST(test_ctype_is_glob_special(), "is_glob_special() works as we expect");
+	TEST(test_ctype_is_regex_special(), "is_regex_special() works as we expect");
+	TEST(test_ctype_is_pathspec_magic(), "is_pathspec_magic() works as we expect");
+	TEST(test_ctype_isascii(), "isascii() works as we expect");
+	TEST(test_ctype_islower(), "islower() works as we expect");
+	TEST(test_ctype_isupper(), "isupper() works as we expect");
+	TEST(test_ctype_iscntrl(), "iscntrl() works as we expect");
+	TEST(test_ctype_ispunct(), "ispunct() works as we expect");
+	TEST(test_ctype_isxdigit(), "isxdigit() works as we expect");
+	TEST(test_ctype_isprint(), "isprint() works as we expect");
+
+	return test_done();
+}

base-commit: 055bb6e9969085777b7fab83e3fee0017654f134
-- 
2.42.0.windows.2

