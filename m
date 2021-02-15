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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A81FC433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AE164DDA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhBOPsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhBOPpd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:45:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C65AC061356
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l12so9496864wry.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCwxaq9ckXkCjWhtYVsknM3Z2mwZx228D5CKPlo8I5w=;
        b=uPCM5YerdcbJN55Dt0XknncwS09x/7lTc71v+6P5+E5YuAsI6Z1Tc36+tUMVd0mfFm
         OkJui8A3dKRyHtaGBxAhdmwkyZLr5FNL05ZfLe7Wb5ShltbeacNTk2BmwUB88qLMTHl6
         359hqfkMm6YtkoJtxTA4Zm7WD+VDAMDUx4t4L2bRlPeKU98AHdTV5+BHHZkg3sG5U/t6
         tpnNwogrqoG1Fti6EiNyFNcTV13vSu8S2bUWnOGG1lFXRfXV/xk3hpL+c9tdLovTSWKa
         wbVnkuK+Z62oaWLsTaUCaB1XicYRM7blTpT6aYvdcZSCrgv1/nx/oJLz/EU459w+gx/4
         gbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCwxaq9ckXkCjWhtYVsknM3Z2mwZx228D5CKPlo8I5w=;
        b=KitRS3+gA6J/FCYs8ulVxJAyrPKIubQAJk3kyUHae2oF4hjpVwQ8jSNdTQnDQllb8G
         IKUBqO79YXdg0dt/H5rVrxReZ2djdM12DMqVkU8olfG1Cd17ZXZ4u9Ono/nyCeKsyrV0
         IhZ8Zvmr7+IGLbbTxRZWzxtsj31L/QDEdNMumjge1AkySAndHcWiXqaZBigxTOcugfNZ
         SVNPIvFUOJ6c4q20PTdUMT5efKRgcv7z44k43t4DbcvRf/RX7JXRJNko9uqTHLgGomHf
         LfdSo6wm6BTqZMQ0ZqAOmrJoZFKS+R7ldqggxkOc3y9yfFiAiahjZfb778QGPqnCcLdo
         H2Bw==
X-Gm-Message-State: AOAM530ZdX5syXSzD5PaoesyC86ZE32+Zd7bd7kHUNelT6Soir5rhgmr
        j1bLVaMf7p3xlWCrhH5nMkel+b2geZa0qQ==
X-Google-Smtp-Source: ABdhPJzdVvXdC0zyg6g+VGzrV9RFX/N+gXe79tvUBAAdi+5n94H4Vf0zSY7I+mESlaGr/f2VZg3C+Q==
X-Received: by 2002:a5d:4583:: with SMTP id p3mr19642189wrq.305.1613403891649;
        Mon, 15 Feb 2021 07:44:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:51 -0800 (PST)
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
Subject: [PATCH v2 07/27] userdiff tests: list builtin drivers via test-tool
Date:   Mon, 15 Feb 2021 16:44:07 +0100
Message-Id: <20210215154427.32693-8-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
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
 t/helper/test-userdiff.c | 30 ++++++++++++++++++++++++++++++
 t/t4018-diff-funcname.sh | 28 ++++------------------------
 5 files changed, 37 insertions(+), 24 deletions(-)
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
index 0000000000..1e17aeb265
--- /dev/null
+++ b/t/helper/test-userdiff.c
@@ -0,0 +1,30 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "userdiff.h"
+
+static int driver_cb(struct userdiff_driver *driver,
+		     enum userdiff_driver_type type, void *priv)
+{
+	puts(driver->name);
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
index cefe329aea..6faa719536 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -8,6 +8,9 @@ test_description='Test custom diff function name patterns'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
+	builtin_drivers=$(test-tool userdiff list-builtin-drivers) &&
+	test -n "$builtin_drivers" &&
+
 	# a non-trivial custom pattern
 	git config diff.custom1.funcname "!static
 !String
@@ -26,30 +29,7 @@ test_expect_success 'setup' '
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

