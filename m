Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2A7C433E6
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D7E64EDD
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhBXTx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhBXTxR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CBBC061793
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:59 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e10so2824682wro.12
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/z8ZiwPZP8JdGwIWJFwe8vn0ba2X8OMmQ7T1QBzD4A=;
        b=hRFasAwDFYVaEbVcwBFoOOXHh5mNxS0IKE68O7S4/A0eZS3TA1osMeFu2Vo5gcg8FY
         rnDjPLHRKxbSonjbNdalTFQzD7DZcrQoj6FcdIpC0+BRAQhvz2prcp+cfWvMQ3aGG1Bs
         qiDz4rvJDdy9FmnbitI2O6nuzbaV3RmywJDaEgtYInq9QKfbubu/O1ZtpGhi/+dQH91E
         AokJCT5inmY3U5gUiE761Oq0AHMCL1pcLVk8M+4i8t4sYUubpmjxOBxpCVSk41ulh3lR
         OdAlKA6Sp1REULo/QdsGt4K4CH61uWajzaITo/3gZNKk9Sr9KfhDD5umZqkWgLW+9BcM
         rPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/z8ZiwPZP8JdGwIWJFwe8vn0ba2X8OMmQ7T1QBzD4A=;
        b=TIaoG0+u7Frk+Gh4uSsxlIOiVDS07JVDUvRtot+whp5gSyi0ckfG/F+IYj3YXq3nja
         VwMIWbFDuxX+cVRVG9t5okTnO70LQp1J6XDqN/2rHZ7kr7bkA5IsEPYxhZENLndFAuGR
         U4wSCeIaycf4AuNrt4HuygAvp03cxDmrPVv0h5gcQh92s3Rto6eatOzkwY4YwVZMF7Ao
         IuzvNj2sjwR5JUHEwG4x/Ni+uCV0BVfKtuGvxKfpkG7Q43paxCA4+jcaGOpdVfxfuj5l
         DUhqjkOSp8I94SBRhmFnbDYo8lmfL1+ZeHNedE299Rk6tFp6eJ+C3ylBKLUj4WQZJTyU
         krMw==
X-Gm-Message-State: AOAM532YBMzjE0MMBCy2k1vA9eD/YAhbxejD9bqTg4hU4nQLLiG+UsMN
        EigHDOm5x9awRWhFjfsLSEhjCsPjJMcnjw==
X-Google-Smtp-Source: ABdhPJwIP0JHucGBDoQFCL7X5dRsQ++bzSLco30Zf8qLEH2YHB6WrRu68QBDPVzhLTr/+PEyWJjaWQ==
X-Received: by 2002:a5d:4d03:: with SMTP id z3mr21037462wrt.211.1614196318409;
        Wed, 24 Feb 2021 11:51:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:51:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/35] userdiff tests: list builtin drivers via test-tool
Date:   Wed, 24 Feb 2021 20:51:01 +0100
Message-Id: <20210224195129.4004-8-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the userdiff test to list the builtin drivers via the
test-tool, using the new for_each_userdiff_driver() API function.

This gets rid of the need to modify this part of the test every time a
new pattern is added, see 2ff6c34612 (userdiff: support Bash,
2020-10-22) and 09dad9256a (userdiff: support Markdown, 2020-05-02)
for two recent examples.

I only need the "list-builtin-drivers "argument here, but let's add
"list-custom-drivers" and "list-drivers" too, just because it's easy.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                 |  1 +
 t/helper/test-tool.c     |  1 +
 t/helper/test-tool.h     |  1 +
 t/helper/test-userdiff.c | 31 +++++++++++++++++++++++++++++++
 t/t4018-diff-funcname.sh | 32 ++++++++------------------------
 5 files changed, 42 insertions(+), 24 deletions(-)
 create mode 100644 t/helper/test-userdiff.c

diff --git a/Makefile b/Makefile
index 5a239cac20e..710a0deaed0 100644
--- a/Makefile
+++ b/Makefile
@@ -741,6 +741,7 @@ TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-trace2.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
+TEST_BUILTINS_OBJS += test-userdiff.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f97cd9f48a6..dcb05ca6e5e 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -71,6 +71,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
 	{ "trace2", cmd__trace2 },
+	{ "userdiff", cmd__userdiff },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
 	{ "xml-encode", cmd__xml_encode },
 	{ "wildmatch", cmd__wildmatch },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 28072c0ad5a..589f2e8ac67 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -61,6 +61,7 @@ int cmd__submodule_config(int argc, const char **argv);
 int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
+int cmd__userdiff(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
 int cmd__xml_encode(int argc, const char **argv);
 int cmd__wildmatch(int argc, const char **argv);
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
new file mode 100644
index 00000000000..f173a4f18af
--- /dev/null
+++ b/t/helper/test-userdiff.c
@@ -0,0 +1,31 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "userdiff.h"
+
+static int driver_cb(struct userdiff_driver *driver,
+		     enum userdiff_driver_type type, void *priv)
+{
+	if (driver->funcname.pattern)
+		puts(driver->name);
+	return 0;
+}
+
+static int list_what(enum userdiff_driver_type type)
+{
+	return for_each_userdiff_driver(driver_cb, type, NULL);
+}
+
+int cmd__userdiff(int argc, const char **argv)
+{
+	if (argc != 2)
+		return 1;
+
+	if (!strcmp(argv[1], "list-drivers"))
+		return list_what(USERDIFF_DRIVER_TYPE_UNSPECIFIED);
+	else if (!strcmp(argv[1], "list-builtin-drivers"))
+		return list_what(USERDIFF_DRIVER_TYPE_BUILTIN);
+	else if (!strcmp(argv[1], "list-custom-drivers"))
+		return list_what(USERDIFF_DRIVER_TYPE_CUSTOM);
+	else
+		return error("unknown argument %s", argv[1]);
+}
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index cefe329aea7..5bd82e09ab3 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -8,6 +8,13 @@ test_description='Test custom diff function name patterns'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
+	# Make sure additions to builtin_drivers are sorted
+	test_when_finished "rm builtin-drivers.sorted" &&
+	test-tool userdiff list-builtin-drivers >builtin-drivers &&
+	test_file_not_empty builtin-drivers &&
+	sort <builtin-drivers >builtin-drivers.sorted &&
+	test_cmp builtin-drivers.sorted builtin-drivers &&
+
 	# a non-trivial custom pattern
 	git config diff.custom1.funcname "!static
 !String
@@ -26,30 +33,7 @@ test_expect_success 'setup' '
 '
 
 diffpatterns="
-	ada
-	bash
-	bibtex
-	cpp
-	csharp
-	css
-	dts
-	elixir
-	fortran
-	fountain
-	golang
-	html
-	java
-	markdown
-	matlab
-	objc
-	pascal
-	perl
-	php
-	python
-	ruby
-	rust
-	tex
-	default
+	$(cat builtin-drivers)
 	custom1
 	custom2
 	custom3
-- 
2.30.0.284.gd98b1dd5eaa7

