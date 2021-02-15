Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCF3C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595F764DDA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBOAyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhBOAyX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:54:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC423C06178A
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:04 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n4so4180468wrx.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RktGh6O14WVHOsBLAiLaHGbHF4JZjmy3JWuFrO7AtmI=;
        b=sB4IccALMUSpQ068/Mk1BTT9A8zjkYaBSHVlOwZ1ZhPb+ikStTrxd1/8fxNixOEWwn
         D03DAywFiZnU37p2oS+U2GUEVfXZYakdiACMcMtkTjiWk1swe9T0PQj8qDlRXgu9Rq6k
         KG+j5q2WnsnLzhAVM7swxTuDNrQRSeBFX25KB5d8v6j1n/Pw2rq2bPZ43sj9sx2u50Nl
         pkfZBiu9yiGQr+yBC4bShKuY72nQkynDY9css4HUFwTXDZGWoWuxDNmj+dgQHUGi+Hwh
         ftD+wWisjaErZMH054UUziNJQnMunGrLvNhhXNpzCyS4rQXkSUMgPY3h314XsrMBRlpo
         5iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RktGh6O14WVHOsBLAiLaHGbHF4JZjmy3JWuFrO7AtmI=;
        b=mYeGdp0y5EZmjUT5JkuiiuWg2rycxhIy0TNi4Gs+OHyVISXDv+Tf3EBLn9G26+srr+
         A+nq+EQBI4K//CrTD25qYCsPP5S8ih8UvlZyRc5vwcULYV+yhLhZvnVjF/0xZbvhyYsS
         b2JtCKLVklUNgTTVOxNS5Dk78JE9ZPEDwqvVv2j9UP9y6pECVRYFy3TIOv+Mtaxu34Ly
         3nnMgurEW/BrjQet4gh3yOLfdPXsSZH5r/Df6DAF/JIGnMboKPX6YykZ7mVWmevqC4K2
         mS4ergpCX2pydH0wtCOJ24FaP/ie4cvViVcOEvDiu5YhFDGUKWov7hHHpdOi77JA8F40
         RbeA==
X-Gm-Message-State: AOAM530+HSjz8kvZm0ohYkxNVMYRQTdWfEHyZOPxMWHG9r3Z3gC1epK2
        HpYAUGzW6rNV/q6kMEzP4Ash3lMjYmQwzQ==
X-Google-Smtp-Source: ABdhPJzisdXvR6Y1qos0Q/56nBUjx4aVVaLj9VOnnFYmlGcXYe9IeX7/7hguk+aBr9/01qGY6xVW7w==
X-Received: by 2002:adf:f285:: with SMTP id k5mr16254813wro.285.1613350383381;
        Sun, 14 Feb 2021 16:53:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/20] userdiff tests: list builtin drivers via test-tool
Date:   Mon, 15 Feb 2021 01:52:21 +0100
Message-Id: <20210215005236.11313-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
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
 t/helper/test-userdiff.c | 32 ++++++++++++++++++++++++++++++++
 t/t4018-diff-funcname.sh | 29 +++++------------------------
 5 files changed, 40 insertions(+), 24 deletions(-)
 create mode 100644 t/helper/test-userdiff.c

diff --git a/Makefile b/Makefile
index 5a239cac20..710a0deaed 100644
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
index f97cd9f48a..dcb05ca6e5 100644
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
index 28072c0ad5..589f2e8ac6 100644
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
index 0000000000..80de456287
--- /dev/null
+++ b/t/helper/test-userdiff.c
@@ -0,0 +1,32 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "userdiff.h"
+
+static int userdiff_list_builtin_drivers_cb(struct userdiff_driver *driver,
+					    enum userdiff_driver_type type,
+					    void *priv)
+{
+	puts(driver->name);
+	return 0;
+}
+
+static int list_what(enum userdiff_driver_type type)
+{
+	return for_each_userdiff_driver(userdiff_list_builtin_drivers_cb, type,
+					NULL);
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
index cefe329aea..11ac648451 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -8,6 +8,10 @@ test_description='Test custom diff function name patterns'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
+	test-tool userdiff list-builtin-drivers >builtin-drivers &&
+	test_file_not_empty builtin-drivers &&
+	builtin_drivers=$(cat builtin-drivers) &&
+
 	# a non-trivial custom pattern
 	git config diff.custom1.funcname "!static
 !String
@@ -26,30 +30,7 @@ test_expect_success 'setup' '
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
+	$builtin_drivers
 	custom1
 	custom2
 	custom3
-- 
2.30.0.284.gd98b1dd5eaa7

