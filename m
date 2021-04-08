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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AE6C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC2761130
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhDHPEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbhDHPEu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 11:04:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2359DC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 08:04:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e7so2809666edu.10
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ommvJluwKP5YpZ57gYrNfOqyoFWcKLD0RR/b5jTfGWQ=;
        b=eIHP6aQbjC/Mt1AARgtYlCjbHzgF5PNwzSbebyCN4NYTBC3U/X8IwDPWKX5mz5coiq
         QbWePsmXmvuou9TWwd9T90QAtUgSlkCfYssLqwCWjVD9XGHTcxHo/3C+QVAtx6EtiIYi
         tgMMuy+TLug7qu9lU8T9CFEjpdjXxQRYThhuE9A3jRLQk4t91MVzgxARYblOyTSzqWww
         8NEsO5cSQ+8/H9owUWKqeR0IaZGMRsIZ+S85Wm+XUhD71XVTE4ujb9eCmXIFio/0MtmU
         TcBTB77Ch8KN9KmtcqtkUFYj8MzZweV4ZapDkWpjkpUHtxh+GNbf2gyH0+NfTxMjqrTW
         JcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ommvJluwKP5YpZ57gYrNfOqyoFWcKLD0RR/b5jTfGWQ=;
        b=uCna0GX1+Jc9oxuTAOrnr+0lPu0QVgvYIbxIre+NFj5ZiT/khQo0Q4k7VHZiAdu1W0
         skNpqOQexcR7Mn+V/NQD0V3e69AQwq3RGcyozox51nvAFDuqcaw0wCYCe2esiwIzsWX4
         bOtUPVKKyQPXKxnYPEeh94eUZjppFFJgKlQ+6NC9XVpCDL5QzbfFhZP9DGzi3xPPjmt9
         EY2Ef7p/XEoZ3tlcjpmKAGbQ5v3b3OBL30OVI46HA/AYKhEZPNo3pdkPhLKDCfTzSw8y
         inXuqsOP258mq96jzVbdmV3GvjqZ8Py92GEn7hsmWhAYAWk/3ohKWVwL779Oz7j/Ahze
         4wHQ==
X-Gm-Message-State: AOAM531q8p6fZbgmWPM5O6nF2hI1FPL6DeWNK0ZREvgJwezvndSCZazu
        G0ksQmZqKQaqtsfNF9OM2Aq3grlASpwr4Q==
X-Google-Smtp-Source: ABdhPJy0l0IqwmrFcVTZSel7gKJyEIpAVSSgmZLQy/bnXpt6Fv1jbxtF7WQGCNepjJSn/g+dvDzjHg==
X-Received: by 2002:a05:6402:17af:: with SMTP id j15mr12163563edy.50.1617894277597;
        Thu, 08 Apr 2021 08:04:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h25sm2479253ejx.105.2021.04.08.08.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:04:37 -0700 (PDT)
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
Subject: [PATCH v5 6/9] userdiff tests: list builtin drivers via test-tool
Date:   Thu,  8 Apr 2021 17:04:21 +0200
Message-Id: <patch-06.10-e90758a978-20210408T145833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com> <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
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
 t/helper/test-userdiff.c | 46 ++++++++++++++++++++++++++++++++++++++++
 t/t4018-diff-funcname.sh | 46 +++++++++++++++++-----------------------
 5 files changed, 68 insertions(+), 27 deletions(-)
 create mode 100644 t/helper/test-userdiff.c

diff --git a/Makefile b/Makefile
index a6a73c5741..d2ba9bb402 100644
--- a/Makefile
+++ b/Makefile
@@ -752,6 +752,7 @@ TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-trace2.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
+TEST_BUILTINS_OBJS += test-userdiff.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 287aa60023..bf13b1f8c1 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -72,6 +72,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
 	{ "trace2", cmd__trace2 },
+	{ "userdiff", cmd__userdiff },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
 	{ "xml-encode", cmd__xml_encode },
 	{ "wildmatch", cmd__wildmatch },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 9ea4b31011..698f95bf46 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -62,6 +62,7 @@ int cmd__submodule_config(int argc, const char **argv);
 int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
+int cmd__userdiff(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
 int cmd__xml_encode(int argc, const char **argv);
 int cmd__wildmatch(int argc, const char **argv);
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
new file mode 100644
index 0000000000..f013f8a31e
--- /dev/null
+++ b/t/helper/test-userdiff.c
@@ -0,0 +1,46 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "userdiff.h"
+#include "config.h"
+
+static int driver_cb(struct userdiff_driver *driver,
+		     enum userdiff_driver_type type, void *priv)
+{
+	enum userdiff_driver_type *want_type = priv;
+	if (type & *want_type && driver->funcname.pattern)
+		puts(driver->name);
+	return 0;
+}
+
+static int cmd__userdiff_config(const char *var, const char *value, void *cb)
+{
+	if (userdiff_config(var, value) < 0)
+		return -1;
+	return 0;
+}
+
+int cmd__userdiff(int argc, const char **argv)
+{
+	enum userdiff_driver_type want = 0;
+	if (argc != 2)
+		return 1;
+
+	if (!strcmp(argv[1], "list-drivers"))
+		want = (USERDIFF_DRIVER_TYPE_BUILTIN |
+			USERDIFF_DRIVER_TYPE_CUSTOM);
+	else if (!strcmp(argv[1], "list-builtin-drivers"))
+		want = USERDIFF_DRIVER_TYPE_BUILTIN;
+	else if (!strcmp(argv[1], "list-custom-drivers"))
+		want = USERDIFF_DRIVER_TYPE_CUSTOM;
+	else
+		return error("unknown argument %s", argv[1]);
+
+	if (want & USERDIFF_DRIVER_TYPE_CUSTOM) {
+		setup_git_directory();
+		git_config(cmd__userdiff_config, NULL);
+	}
+
+	for_each_userdiff_driver(driver_cb, &want);
+
+	return 0;
+}
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index cefe329aea..409372f3a4 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -25,34 +25,26 @@ test_expect_success 'setup' '
 	echo B >B.java
 '
 
+test_expect_success 'setup: test-tool userdiff' '
+	# Make sure additions to builtin_drivers are sorted
+	test_when_finished "rm builtin-drivers.sorted" &&
+	test-tool userdiff list-builtin-drivers >builtin-drivers &&
+	test_file_not_empty builtin-drivers &&
+	sort <builtin-drivers >builtin-drivers.sorted &&
+	test_cmp builtin-drivers.sorted builtin-drivers &&
+
+	# Ditto, but "custom" requires the .git directory and config
+	# to be setup and read.
+	test_when_finished "rm custom-drivers.sorted" &&
+	test-tool userdiff list-custom-drivers >custom-drivers &&
+	test_file_not_empty custom-drivers &&
+	sort <custom-drivers >custom-drivers.sorted &&
+	test_cmp custom-drivers.sorted custom-drivers
+'
+
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
-	custom1
-	custom2
-	custom3
+	$(cat builtin-drivers)
+	$(cat custom-drivers)
 "
 
 for p in $diffpatterns
-- 
2.31.1.527.g9b8f7de2547

