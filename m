Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EF5C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346014AbiFJCCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345944AbiFJCCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:02:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F8BDA1C
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:02:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k16so34649771wrg.7
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCR02URZY64Y9Y3s8i3sU/yXPz1Mnc40xeeiSkiJHKw=;
        b=Z+TyVpxgYBocPn3XEo7i6j5r65clDO3hWkVoIdbXwOkbGaaPNayYNmWWFnbIBoKe4x
         Ep0MLGUrjEvOvoc/yiZrcysc2o2rKrqd+LXo7ol43J+oQ/W0W5+iiinuiNJ4v72z9Pfk
         CDUg39He1+ugijqJ86bvgfESZk4CxMZP9ij/1tZh4jsg1d1FAB26oc+yf2U3XTyAH04s
         gCNyFugnUFwvnpPpiZQ9gjWvszPzQDi8ixLJAAiGvxIbtE595ZJLdGNbVVNx5TTxaeHT
         xz6mXpmD1ozmZe4TXU3DIMjDyQwBm4NzDNi4TnEmTKEQncbEZAL70zCze+/vYUKQ/Cp+
         Rjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCR02URZY64Y9Y3s8i3sU/yXPz1Mnc40xeeiSkiJHKw=;
        b=h+RwcSDZmYLMo7vq8WoQ96EQw06nzY9IMbmg8iVyoJga0qewB0ILXA9uUe877oRsK/
         iHud/pD4m8Y2YW8PhyXAf+cRkATrYOLYfqPVKtgmG5Jor+4eGNHUOnlH0Z12Of3G2QCP
         BYcB6EwC23vSlr5ik/1sTJitIDcaNM6YKulggXXxtQWJa5D2PEHtjvNUuZ61HPSR6jtu
         zA7d86Z21KQ8lElHjXr8xc4zhxOmisqcV2t1zKHBn5DfKXpb6VzXnDxUduGEvO74vvCB
         hdgniTlHDh9wa/zEQz7+PrEegbsAGvUBvCefJQ0UDEkMPT2qgSpU3axS0OBZ2J8wIOGg
         gQ3A==
X-Gm-Message-State: AOAM530vv4A1gyFnf5BqJilAqOZeK3ShsNdlvYjJjlNdkPtNeiygA0QS
        5sdjC2RQzH8+1NopRgqtZEbNBxfThI65+Q==
X-Google-Smtp-Source: ABdhPJzMyFiBSyYPLE3uqsuEUeJu327G2aSHWYjZ2z5rLy4VWpK6NmmrHHumTl7RrW1pT0so9iQuFQ==
X-Received: by 2002:adf:e54e:0:b0:218:3fee:b8eb with SMTP id z14-20020adfe54e000000b002183feeb8ebmr23182365wrm.253.1654826525700;
        Thu, 09 Jun 2022 19:02:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:02:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 20/20] submodule: add a subprocess-less submodule.useBuiltin setting
Date:   Fri, 10 Jun 2022 04:01:32 +0200
Message-Id: <RFC-patch-20.20-b2aaad5c008-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an experimental setting to avoid the subprocess invocation of "git
submodule--helper", instead we'll call cmd_submodule__helper()
directly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/submodule.txt |  4 ++++
 builtin/submodule.c                | 35 ++++++++++++++++++++++++++++--
 ci/run-build-and-tests.sh          |  1 +
 t/README                           |  4 ++++
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index 6490527b45b..aa761f331c9 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -79,6 +79,10 @@ setting.
 * `branch` is supported only if `submodule.propagateBranches` is
 enabled
 
+submodule.useBuiltin::
+	Set to `true` to use a faster but possibly less stable subprocess-less
+	implementation of linkgit:git-submodule[1]. Is `false` by default.
+
 submodule.propagateBranches::
 	[EXPERIMENTAL] A boolean that enables branching support when
 	using `--recurse-submodules` or `submodule.recurse=true`.
diff --git a/builtin/submodule.c b/builtin/submodule.c
index b777787169e..9bb731ce87a 100644
--- a/builtin/submodule.c
+++ b/builtin/submodule.c
@@ -6,6 +6,7 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "strvec.h"
+#include "config.h"
 
 #define BUILTIN_SUBMODULE_USAGE \
 	"git submodule [--quiet] [--cached]"
@@ -105,17 +106,33 @@ static void setup_helper_args(int argc, const char **argv, const char *prefix,
 	strvec_pushv(args, argv);
 }
 
+static int get_use_builtin(void)
+{
+	int v;
+
+	if (git_env_bool("GIT_TEST_SUBMODULE_USE_BUILTIN", 0))
+		v = 1;
+	else if (!git_config_get_bool("submodule.usebuiltin", &v))
+		;
+	else if (!git_config_get_bool("feature.experimental", &v))
+	      ;
+
+	return v;
+}
+
 int cmd_submodule(int argc, const char **argv, const char *prefix)
 {
 	int opt_quiet = 0;
 	int opt_cached = 0;
 	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strvec args = STRVEC_INIT;
 	struct option options[] = {
 		OPT__QUIET(&opt_quiet, N_("be quiet")),
 		OPT_BOOL(0, "cached", &opt_cached,
 			 N_("print the OID of submodules")),
 		OPT_END()
 	};
+	const int use_builtin = get_use_builtin();
 	int ret;
 
 	argc = parse_options(argc, argv, prefix, options, git_submodule_usage,
@@ -125,14 +142,28 @@ int cmd_submodule(int argc, const char **argv, const char *prefix)
 	 * Tell the rest of git that any URLs we get don't come
 	 * directly from the user, so it can apply policy as appropriate.
 	 */
-	strvec_push(&cp.env_array, "GIT_PROTOCOL_FROM_USER=0");
+	if (use_builtin)
+		xsetenv("GIT_PROTOCOL_FROM_USER", "0", 1);
+	else
+		strvec_push(&cp.env_array, "GIT_PROTOCOL_FROM_USER=0");
+
 	setup_helper_args(argc, argv, prefix, opt_quiet, opt_cached,
-			  &cp.args);
+			  use_builtin ? &args : &cp.args);
+
+	if (use_builtin) {
+		ret = cmd_submodule__helper(args.nr, args.v, prefix);
+		goto cleanup;
+	}
 
 	cp.git_cmd = 1;
 	cp.no_stdin = 0; /* for git submodule foreach */
 	cp.dir = startup_info->original_cwd;
 	ret = run_command(&cp);
 
+cleanup:
+	if (!use_builtin)
+		/* TODO: Double free? */
+		strvec_clear(&args);
+
 	return ret;
 }
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 8ebff425967..06d40fc94aa 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -27,6 +27,7 @@ linux-TEST-vars)
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
 	export GIT_TEST_ADD_I_USE_BUILTIN=0
+	export GIT_TEST_SUBMODULE_USE_BUILTIN=1
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
diff --git a/t/README b/t/README
index 309a31133c6..20c2e74723d 100644
--- a/t/README
+++ b/t/README
@@ -423,6 +423,10 @@ GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when false, disables the
 built-in version of git add -i. See 'add.interactive.useBuiltin' in
 git-config(1).
 
+GIT_TEST_SUBMODULE_USE_BUILTIN=<boolean>, when true, enables the
+built-in subprocess-less invocation of "git submodule--helper".
+See 'submodule.useBuiltin' in git-config(1).
+
 GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
 of the index for the whole test suite by bypassing the default number of
 cache entries and thread minimums. Setting this to 1 will make the
-- 
2.36.1.1178.gb5b1747c546

