Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF730C19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiHBPqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiHBPqg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3C9165A5
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z17so13721343wrq.4
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=E/a/8QKRrQMyxQKtXn21MPc0x89nweVxpUw4fdGsMeg=;
        b=nRt1UuDL+5GUr5dmR0A1sbadJ9jbNCAB2q+/vvYOI4gl8L8wHo6VU4tTw+Wnto4kOz
         ezflDPlXbXv9lhzd3ALpREoR1jE36N1MmVG0sKotfjvD6CEShVjwxN2VIfERDs3M51uP
         mjlS19Gk6sMcsMRzqr+IAgeer+bpp/aqgReiFY5YQgZG24xCrpJvJoc1B7UpbUyh5UZX
         odvBlTS4xRSFmjo1emeRI6LtLZjmZiYxgQBuppZ+ztvOELSy38tfj8LiCV1JsfaE4NuY
         LI7l9ZbGE+u8VzyHEi4J/Vp8Jaj7RyvhPJXUxKAfKDT3aG0lL/guXMGZ7jL7d2fezkSS
         bE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=E/a/8QKRrQMyxQKtXn21MPc0x89nweVxpUw4fdGsMeg=;
        b=a3DGb4pf3+7M3eS7VoikYyhLqs/Obhgrp+Q3KXFvi6emeP4ZXtxmVdh41IbqZaodyI
         wEyEATR8G3BmAid73aIhyvMOHH6CD/Sv5quW317YqiJ5xnhALTKFSGEAhxIYeX8S7a+w
         LI5O8ipQJxs6rTSIZhpmtneSmgphFV9Y+43t2MBUBZetIFRoT/dzAkTuqvmLVdk8YbD6
         KuiaA7sAfVNCrRSzOdUzXLyYrZAB+wOMtAgs6WMNc6fRZny9vPBy0ktxPe235E2NBi2r
         NEQAXNXpfoj+/fe+9K8i+s/C4fvLjlV2YLItZM02DlmdaFg0mNHaWYJbqml6PaptNYvy
         HBGw==
X-Gm-Message-State: ACgBeo2Om9+n7djOtlHDeyCB0JaigeLGumA9gpBRexaIdp8blpaHc1k0
        ooHOcZn1KyVRFzXsHvq9DbBA8UKsqF6oZg==
X-Google-Smtp-Source: AA6agR6uKI11mnrGteYbIybfQ1d5Y5eYl0vEQrxf5SJnrUIzmrk+kq6ZpvqgEWOeGVnCLqfy+rLpQw==
X-Received: by 2002:a5d:6d85:0:b0:220:7084:35e9 with SMTP id l5-20020a5d6d85000000b00220708435e9mr2582660wrs.11.1659455184834;
        Tue, 02 Aug 2022 08:46:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/28] submodule--helper: move "resolve-relative-url-test" to a test-tool
Date:   Tue,  2 Aug 2022 17:45:52 +0200
Message-Id: <patch-v2-08.28-de49f31dab0-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As its name suggests the "resolve-relative-url-test" has never been
used outside of the test suite, see 63e95beb085 (submodule: port
resolve_relative_url from shell to C, 2016-04-15) for its original
addition.

Perhaps it would make sense to drop this code entirely, as we feel
that we've got enough indirect test coverage, but let's leave that
question to a possible follow-up change. For now let's keep the test
coverage this gives us.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 23 --------------------
 t/helper/test-submodule.c   | 42 +++++++++++++++++++++++++++++++++++++
 t/t0060-path-utils.sh       |  2 +-
 3 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 06307886080..246457ec2e9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -96,28 +96,6 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 	return resolved_url;
 }
 
-static int resolve_relative_url_test(int argc, const char **argv, const char *prefix)
-{
-	char *remoteurl, *res;
-	const char *up_path, *url;
-
-	if (argc != 4)
-		die("resolve-relative-url-test only accepts three arguments: <up_path> <remoteurl> <url>");
-
-	up_path = argv[1];
-	remoteurl = xstrdup(argv[2]);
-	url = argv[3];
-
-	if (!strcmp(up_path, "(null)"))
-		up_path = NULL;
-
-	res = relative_url(remoteurl, url, up_path);
-	puts(res);
-	free(res);
-	free(remoteurl);
-	return 0;
-}
-
 /* the result should be freed by the caller. */
 static char *get_submodule_displaypath(const char *path, const char *prefix)
 {
@@ -3273,7 +3251,6 @@ static struct cmd_struct commands[] = {
 	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
 	{"add", module_add, 0},
 	{"update", module_update, SUPPORT_SUPER_PREFIX},
-	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, 0},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 9f0eb440192..e0e0c53d386 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -2,6 +2,7 @@
 #include "test-tool-utils.h"
 #include "cache.h"
 #include "parse-options.h"
+#include "remote.h"
 #include "submodule-config.h"
 #include "submodule.h"
 
@@ -19,9 +20,17 @@ static const char *submodule_is_active_usage[] = {
 	NULL
 };
 
+#define TEST_TOOL_RESOLVE_RELATIVE_URL_USAGE \
+	"test-tool submodule resolve-relative-url <up_path> <remoteurl> <url>"
+static const char *submodule_resolve_relative_url_usage[] = {
+	TEST_TOOL_RESOLVE_RELATIVE_URL_USAGE,
+	NULL,
+};
+
 static const char *submodule_usage[] = {
 	TEST_TOOL_CHECK_NAME_USAGE,
 	TEST_TOOL_IS_ACTIVE_USAGE,
+	TEST_TOOL_RESOLVE_RELATIVE_URL_USAGE,
 	NULL
 };
 
@@ -76,9 +85,42 @@ static int cmd__submodule_is_active(int argc, const char **argv)
 	return !is_submodule_active(the_repository, argv[0]);
 }
 
+static int resolve_relative_url(int argc, const char **argv)
+{
+	char *remoteurl, *res;
+	const char *up_path, *url;
+
+	up_path = argv[0];
+	remoteurl = xstrdup(argv[1]);
+	url = argv[2];
+
+	if (!strcmp(up_path, "(null)"))
+		up_path = NULL;
+
+	res = relative_url(remoteurl, url, up_path);
+	puts(res);
+	free(res);
+	free(remoteurl);
+	return 0;
+}
+
+static int cmd__submodule_resolve_relative_url(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, "test-tools", options,
+			     submodule_resolve_relative_url_usage, 0);
+	if (argc != 3)
+		usage_with_options(submodule_resolve_relative_url_usage, options);
+
+	return resolve_relative_url(argc, argv);
+}
+
 static struct test_cmd cmds[] = {
 	{ "check-name", cmd__submodule_check_name },
 	{ "is-active", cmd__submodule_is_active },
+	{ "resolve-relative-url", cmd__submodule_resolve_relative_url},
 };
 
 int cmd__submodule(int argc, const char **argv)
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 1f2007e62b7..68e29c904a6 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -22,7 +22,7 @@ relative_path() {
 
 test_submodule_relative_url() {
 	test_expect_success "test_submodule_relative_url: $1 $2 $3 => $4" "
-		actual=\$(git submodule--helper resolve-relative-url-test '$1' '$2' '$3') &&
+		actual=\$(test-tool submodule resolve-relative-url '$1' '$2' '$3') &&
 		test \"\$actual\" = '$4'
 	"
 }
-- 
2.37.1.1233.ge8b09efaedc

