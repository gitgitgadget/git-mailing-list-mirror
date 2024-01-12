Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5345DF25
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0Rca/ma"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a2a225e9449so686245566b.0
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 02:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705054915; x=1705659715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4xt15f0UAt6ry0ssrmy0EtXBVmPOVYuYOlijImqlv0=;
        b=Y0Rca/maVI8D82L7XkGZWp7UveZXUSwO/IeFuaJjk6Z97xFUXqj9NIhc8T2YODwsZF
         kUmfchR3exu0XttULQWFG585WV658XbqLhC53v6VbvsYWek5YcExHDtgAFPVxlXqhFZj
         Y+IZiD/6HfFWTFXMJVNmSZv1RQf7puHwaEYpGz3FFU3ezAUefGfFzgVD3OvoixaPU+bc
         TOjNKjmES/CyHWcl1wN7q6CYa9rH9V6dpwmx5j+l3toScl1LKOucwBPdFv9sH3gobOyK
         3m4a8J2/sr0Z+B7lBjL3krhGlD51r3rb89m4fY8WHjqHqn9OD0CCdOjQlTgYCpVaBsST
         +WdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705054915; x=1705659715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4xt15f0UAt6ry0ssrmy0EtXBVmPOVYuYOlijImqlv0=;
        b=MtDGAA/fViKZLbhdCCMLAkbcKwX0LfYLInEYM/HppO5PMmjcguD5jpZTiZonAqQGyz
         SOvKqc2ymK79rzoEy0c5zaVWYESHdx28YeUd3QGtZoTyZ9Y5WY0iqAozvKfxWuPeB1Iu
         UA+Dru1sU9WZy7BMmHS9Ph+pOYtIRrtV798EYOj4Q1ts5xzfGK1kkl9RTNDR0VWxDVot
         hl+BpLTshO/9XeWQ7m/XjtBBpob1KzsNahF/17pzzo2+Wb9WJC/j0xiGUzFiX58qB289
         OFz+XnE45t0BiPVyWgwmoBYvkteFRiSJapQSHezHStnpKddgEde+FVokUM7rB4Q0BTmF
         nxbg==
X-Gm-Message-State: AOJu0YyvxPTI0fo9Art8ORxJuCVptBOHUTzm7l5aS55bWi77Je4mRW0C
	svRm8g00CGWtjngIEdEfNLm6F8ZwN52phA==
X-Google-Smtp-Source: AGHT+IG6vE7bDIlHJb3pgoSM0Kecv4Znf18b6SbHYjBmRNh26T8N/BxTYqAZzKFQVzZF3nwc6niy3A==
X-Received: by 2002:a17:906:3893:b0:a23:36f7:4918 with SMTP id q19-20020a170906389300b00a2336f74918mr531499ejd.72.1705054915290;
        Fri, 12 Jan 2024 02:21:55 -0800 (PST)
Received: from localhost.localdomain ([102.244.37.37])
        by smtp.gmail.com with ESMTPSA id b4-20020a170906150400b00a2a37f63216sm1663329ejd.171.2024.01.12.02.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 02:21:54 -0800 (PST)
From: Achu Luma <ach.lumap@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [Outreachy][PATCH] Port helper/test-advise.c to unit-tests/t-advise.c
Date: Fri, 12 Jan 2024 11:21:22 +0100
Message-ID: <20240112102122.1422-1-ach.lumap@gmail.com>
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

This commit migrates the unit tests for advise_if_enabled functionality
from the legacy approach using the test-tool command `test-tool advise`
in t/helper/test-advise.c to the new unit testing framework
(t/unit-tests/test-lib.h).

The migration involves refactoring the tests to utilize the testing
macros provided by the framework (TEST() and check_*()).

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
---
 Makefile                |  2 +-
 t/helper/test-advise.c  | 22 -----------------
 t/helper/test-tool.c    |  1 -
 t/helper/test-tool.h    |  1 -
 t/t0018-advice.sh       | 33 -------------------------
 t/unit-tests/t-advise.c | 53 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 54 insertions(+), 58 deletions(-)
 delete mode 100644 t/helper/test-advise.c
 delete mode 100755 t/t0018-advice.sh
 create mode 100644 t/unit-tests/t-advise.c

diff --git a/Makefile b/Makefile
index 15990ff312..27916e4341 100644
--- a/Makefile
+++ b/Makefile
@@ -783,7 +783,6 @@ X =

 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))

-TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-bitmap.o
 TEST_BUILTINS_OBJS += test-bloom.o
 TEST_BUILTINS_OBJS += test-bundle-uri.o
@@ -1342,6 +1341,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 UNIT_TEST_PROGRAMS += t-basic
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-strbuf
+UNIT_TEST_PROGRAMS += t-advise
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
deleted file mode 100644
index 8a3fd0009a..0000000000
--- a/t/helper/test-advise.c
+++ /dev/null
@@ -1,22 +0,0 @@
-#include "test-tool.h"
-#include "advice.h"
-#include "config.h"
-#include "setup.h"
-
-int cmd__advise_if_enabled(int argc, const char **argv)
-{
-	if (argc != 2)
-		die("usage: %s <advice>", argv[0]);
-
-	setup_git_directory();
-	git_config(git_default_config, NULL);
-
-	/*
-	 * Any advice type can be used for testing, but NESTED_TAG was
-	 * selected here and in t0018 where this command is being
-	 * executed.
-	 */
-	advise_if_enabled(ADVICE_NESTED_TAG, "%s", argv[1]);
-
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 37ba996539..e7f7326ce6 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -10,7 +10,6 @@ static const char * const test_tool_usage[] = {
 };

 static struct test_cmd cmds[] = {
-	{ "advise", cmd__advise_if_enabled },
 	{ "bitmap", cmd__bitmap },
 	{ "bloom", cmd__bloom },
 	{ "bundle-uri", cmd__bundle_uri },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 8a1a7c63da..68751dda66 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -3,7 +3,6 @@

 #include "git-compat-util.h"

-int cmd__advise_if_enabled(int argc, const char **argv);
 int cmd__bitmap(int argc, const char **argv);
 int cmd__bloom(int argc, const char **argv);
 int cmd__bundle_uri(int argc, const char **argv);
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
deleted file mode 100755
index c13057a4ca..0000000000
--- a/t/t0018-advice.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-
-test_description='Test advise_if_enabled functionality'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-test_expect_success 'advice should be printed when config variable is unset' '
-	cat >expect <<-\EOF &&
-	hint: This is a piece of advice
-	hint: Disable this message with "git config advice.nestedTag false"
-	EOF
-	test-tool advise "This is a piece of advice" 2>actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'advice should be printed when config variable is set to true' '
-	cat >expect <<-\EOF &&
-	hint: This is a piece of advice
-	hint: Disable this message with "git config advice.nestedTag false"
-	EOF
-	test_config advice.nestedTag true &&
-	test-tool advise "This is a piece of advice" 2>actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'advice should not be printed when config variable is set to false' '
-	test_config advice.nestedTag false &&
-	test-tool advise "This is a piece of advice" 2>actual &&
-	test_must_be_empty actual
-'
-
-test_done
diff --git a/t/unit-tests/t-advise.c b/t/unit-tests/t-advise.c
new file mode 100644
index 0000000000..15df29c955
--- /dev/null
+++ b/t/unit-tests/t-advise.c
@@ -0,0 +1,53 @@
+#include "test-lib.h"
+#include "advice.h"
+#include "config.h"
+#include "setup.h"
+#include "strbuf.h"
+
+static const char expect_advice_msg[] = "hint: This is a piece of advice\n"
+					"hint: Disable this message with \"git config advice.nestedTag false\"\n";
+static const char advice_msg[] = "This is a piece of advice";
+static const char out_file[] = "./output.txt";
+
+
+static void check_advise_if_enabled(const char *argv, const char *conf_val, const char *expect) {
+	FILE *file;
+	struct strbuf actual = STRBUF_INIT;
+
+	if (conf_val)
+		git_default_advice_config("advice.nestedTag", conf_val);
+
+	file = freopen(out_file, "w", stderr);
+	if (!check(!!file)) {
+		test_msg("Error opening file %s", out_file);
+		return;
+	}
+
+	advise_if_enabled(ADVICE_NESTED_TAG, "%s", argv);
+	fclose(file);
+
+	if (!check(strbuf_read_file(&actual, out_file, 0) >= 0)) {
+		test_msg("Error reading file %s", out_file);
+		strbuf_release(&actual);
+		return;
+	}
+
+	check_str(actual.buf, expect);
+	strbuf_release(&actual);
+
+	if (!check(remove(out_file) == 0))
+		test_msg("Error deleting %s", out_file);
+}
+
+int cmd_main(int argc, const char **argv) {
+	setenv("TERM", "dumb", 1);
+
+	TEST(check_advise_if_enabled(advice_msg, NULL, expect_advice_msg),
+		"advice should be printed when config variable is unset");
+	TEST(check_advise_if_enabled(advice_msg, "true", expect_advice_msg),
+		"advice should be printed when config variable is set to true");
+	TEST(check_advise_if_enabled(advice_msg, "false", ""),
+		"advice should not be printed when config variable is set to false");
+
+	return test_done();
+}
--
2.42.0.windows.2

