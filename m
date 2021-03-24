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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CC1C433EC
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C250A61A08
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhCXBtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbhCXBtW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:49:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813F9C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id 61so22753002wrm.12
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWtikGjuuVQovMXEyb53c5CWTA76npJiin+jNTR9+m4=;
        b=jJiGUmPalEqD1XgcE0ruJcixuScTdaZW8Vu/BHs1N+ZeVVALbYjAikOVVH4Jgva5Dp
         2TSHGPgqDiLh8adp2RAsryWMWV1fEq8t/3WXfjiZmSc8t7pj41uFsd7cmw0qOoPyFuQG
         TZqMAakWj6GxyotW98vZOQy8EYssrZrVVgMvZiu73vhpgVc5AmrJGtXz18Bozx5pILWV
         8OhShVu9z4/dpNwzJrCQzV4ip4nclfXPoEkBGBP0+YU7y4z6R383Bd7pDq2VVjCRN+sr
         M8uRTGQVLfCZstUHM8T+XRycX3sPeq/taHo6p7wzwoU+XAMCa+WJnJ+Fn6Cs+1O7zW+T
         l+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWtikGjuuVQovMXEyb53c5CWTA76npJiin+jNTR9+m4=;
        b=A20MSEA7kg/h4Wlae0BAXj+36oKNOQ3ehWLqax4R2DKoU+u5Ib444H76F1ttkTIpnw
         d/am/z34Wbnf1EoGrEmOIwhuaDFbltX642wDrYyFDROhaPVYq6YAOb781732hOHpo3Vy
         1rWzgCuL+GryBibAzussoKixgrmPiL0HPPAN0yLxmFGGXCGl1uiVyDRjJu0Qv159/axo
         e34I87giWOFELwiaO0D6nXV4+j5OemankyFGk7NleXpNNgUlQMyS6tlVuO4D3xyF5heO
         XHpMW2PHaWrzkFYLCojuYD6v5yD+u3d8u7dc9Z1gUUH+yMuXBi2or6aB6fLeVrBhA8Ma
         sRQw==
X-Gm-Message-State: AOAM531GssVsUmfTXcXUGnX+2X4tdCBTAhTgum4LJveMpmmstsxhG1SN
        kTnmkY/0DkeBaHRvk40STBuLUXZp8p+83g==
X-Google-Smtp-Source: ABdhPJxxj7rF00B0JAWlJdgiTSN0eW2zydp9b+gkDafOuEY33VOpqGutD8lVmIRAetYPFaKbaP6x5Q==
X-Received: by 2002:adf:a59a:: with SMTP id g26mr721252wrc.271.1616550559973;
        Tue, 23 Mar 2021 18:49:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y205sm598177wmc.18.2021.03.23.18.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:49:19 -0700 (PDT)
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
Subject: [PATCH v4 07/10] userdiff tests: list builtin drivers via test-tool
Date:   Wed, 24 Mar 2021 02:48:49 +0100
Message-Id: <patch-07.11-22a07591b76-20210324T014604Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.ga80606b22c1
In-Reply-To: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
References: <20210224195129.4004-1-avarab@gmail.com> <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
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
index f3dc2178324..3e2568d68da 100644
--- a/Makefile
+++ b/Makefile
@@ -744,6 +744,7 @@ TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
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
2.31.0.366.ga80606b22c1

