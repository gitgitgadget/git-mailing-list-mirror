Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07309C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiG1QRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiG1QRY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:17:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D0070E7A
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h188-20020a1c21c5000000b003a34ac64bdfso1118519wmh.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bD4LQ5+wD0+0SzEz8PJDDkwvMCHWzGzS1eVdsphmsc0=;
        b=pMMBZX3oOtbpu2KuDh+Z31tFxXmOhrUt1+Du55MQQHbqjilcCgbNQpzAOclwJ7Fp8u
         M4UkVns2C6l426514utAmdFoK2xe5nnjHE7Q4i9jIfstr1vCi+pHykyBa8O1OJXT5yti
         l8+MtUSdoWS4bZMpn06k82xIHWfcpMQXqO2FI4hvavMLhQ0aEWD89OQbtVWraHL4BWv+
         icPyGfGszB06V/1dFwqgPkf0v/KWWnmxZBXg67NIX0smGpEYCY6Xjh1GS4ljdbSdlF0/
         CnpmCf7gQ3Sd068awONJOPRmbHCddq78u5zp0zz7es2pDvElAoS4u9R9VaIubSQKzHb0
         dYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bD4LQ5+wD0+0SzEz8PJDDkwvMCHWzGzS1eVdsphmsc0=;
        b=eC/Ad1SIcKh7Cq18TqC4HXrUUIbYmABsQT0kFpH2TXENzsAfMuJMbF0h1OHOKJu9/A
         d1Tq5w/pajfJEq0hOh97f9vkz2tPDCJOAa6rjuS0AStOGhlwpHkbYiPJHm6eftJChS/2
         cacJlFPBJnek9aNiwr4RTtQ/nVP5byDcMz1PUE/XiKltvMa9KZ/QMa/Vk+r4c8NnbBvc
         ZTTLWjoHjWKsWGacmZSCxGrK7ZjieZrhwGOD9ovFzDxmtJ1o/UFM9WPcAcBhuJhlPf+P
         YhmIhYYdjQ4S+4InwX8941A//e86bxxncSlIw5TU1ThZkZu9vexPuOeca4+5vxYO5Z/h
         J5yw==
X-Gm-Message-State: AJIora9MlBOyOH9Exax4uwdqW7hfLdGCu2/gEkedDS79it7O+P/iwa1P
        1zL43uO8X8952N8ewTvjBW1VYrMsL2S8uA==
X-Google-Smtp-Source: AGRyM1sV2qnafhtnYnXj76SVdmKRVYVIPJhCdrxkgYzyXHMDxv5y0PCeGdzbQH4KK+qxqUNOZEvzXA==
X-Received: by 2002:a05:600c:3510:b0:3a3:34e7:cfc8 with SMTP id h16-20020a05600c351000b003a334e7cfc8mr119162wmq.164.1659025040994;
        Thu, 28 Jul 2022 09:17:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:17:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/20] submodule--helper: move "resolve-relative-url-test" to a test-tool
Date:   Thu, 28 Jul 2022 18:16:53 +0200
Message-Id: <patch-08.20-8188657cdfa-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
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
2.37.1.1167.g38fda70d8c4

