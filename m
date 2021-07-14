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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FF8C11F67
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212CB613B5
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbhGNR05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbhGNR0z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:26:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C0FC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:24:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d12so4132001wre.13
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rxcziaB04QiHLrU8L8ABGkV2c60dK90wSvkdoe3u8WM=;
        b=UWwg74IZii4MoYQ2l8+Dn+3I77LXzKUVz4g3syiZEnhuLGP76PryaGUZvl7JMx6NZi
         M/YrF5kftx3UHpIdx2GenLMeuBvUebat2+8eF1c1jvK4O1+motW5muJgF36iN8wmBolQ
         Xc03FOcJAQVdOF+bcNNENQ+IlcS0Z3hIMJhZTaYKP+MsItKDYtqr25CQNHvfsZW2Kgwv
         2sUquYH5YDq5BDHRtaPUlTbD5iynl+n6Y2Sxvysmh1IdyzYeevlmSM1xyn4i6y4YFIsD
         1WimhX5HqGRHApry5h96aBahtXi1+vBzvVAOnlCLlIbTb/ZEO8Ansc7+q6gKCnC20TUn
         Dkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxcziaB04QiHLrU8L8ABGkV2c60dK90wSvkdoe3u8WM=;
        b=M6qiAcy1DDVKMBe0EsM8tZHTQiGb3J7N++f6sJGopANOZX4s9npNb6rPdVz4QH2bNh
         dBUFcIVXN9YwRPqGM2B8VuLBAZth39dMaAmmkjkbSpndNidFL3vqiFqfhg7ukWZimHLo
         vr3GNmyAc9ASLuklLQ2+pFRgSWdUO2/uD2co4CgPv58jt95+NnLnobsM1oXKw+ep5wBn
         A+ygdgZ33BV3MMkcWWfHb/vMHPOSorSU11tAKbQXTSQTgjuBqSeP2ODRevkaw8hUsqfO
         PNHpsfp+u5nvDE6/bKxGVwikP+EKpEwVpOrzA+gy4qDP30geAKJbtylfyxLXaZ5Qx7zv
         KceQ==
X-Gm-Message-State: AOAM530jujMKxGSxJSJf/7kx0A06VCX7bbvF2F4MR0qW9XqEX8MEOsVQ
        EYTsv1McknsNUVlTD+xrhv7ifiQB0Z8Qr1BV
X-Google-Smtp-Source: ABdhPJye74bNdprTPKjsIoDtqNITsK1MVpZnbSFGzup6ymX3M3h/vghEWHI833QnOT7x8855AdgYZw==
X-Received: by 2002:a05:6000:1b02:: with SMTP id f2mr14295877wrz.315.1626283442197;
        Wed, 14 Jul 2021 10:24:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f5sm3823795wrg.67.2021.07.14.10.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:24:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/4] SANITIZE tests: fix memory leaks in t13*config*, add to whitelist
Date:   Wed, 14 Jul 2021 19:23:52 +0200
Message-Id: <patch-2.4-867e8e9a6c-20210714T172251Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.853.g5a570c9bf9
In-Reply-To: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com> <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a couple of trivial memory leaks introduced in 3efd0bedc6 (config:
add conditional include, 2017-03-01) and my own 867ad08a26 (hooks:
allow customizing where the hook directory is, 2016-05-04).

In the latter case the "fix" is UNLEAK() on the global variable. This
allows us to run all t13*config* tests under SANITIZE=leak.

With this change we can now run almost the whole set of config.c
tests (t13*config) under SANITIZE=leak, so let's do so, with a few
exceptions:

 * The test added in ce81b1da23 (config: add new way to pass config
   via `--config-env`, 2021-01-12), it fails in GitHub CI, but passes
   for me locally. Let's just skip it for now.

 * Ditto the split_cmdline and "aliases of builtins" tests, the former
   required splitting up an existing test, there an issue with the test
   that would have also been revealed by skipping it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c          | 17 ++++++++++++-----
 t/t1300-config.sh | 16 ++++++++++------
 t/test-lib.sh     |  1 +
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index f9c400ad30..38e132c0e2 100644
--- a/config.c
+++ b/config.c
@@ -138,8 +138,10 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		return config_error_nonbool("include.path");
 
 	expanded = expand_user_path(path, 0);
-	if (!expanded)
-		return error(_("could not expand include path '%s'"), path);
+	if (!expanded) {
+		ret = error(_("could not expand include path '%s'"), path);
+		goto cleanup;
+	}
 	path = expanded;
 
 	/*
@@ -149,8 +151,10 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	if (!is_absolute_path(path)) {
 		char *slash;
 
-		if (!cf || !cf->path)
-			return error(_("relative config includes must come from files"));
+		if (!cf || !cf->path) {
+			ret = error(_("relative config includes must come from files"));
+			goto cleanup;
+		}
 
 		slash = find_last_dir_sep(cf->path);
 		if (slash)
@@ -168,6 +172,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		ret = git_config_from_file(git_config_include, path, inc);
 		inc->depth--;
 	}
+cleanup:
 	strbuf_release(&buf);
 	free(expanded);
 	return ret;
@@ -1331,8 +1336,10 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "core.attributesfile"))
 		return git_config_pathname(&git_attributes_file, var, value);
 
-	if (!strcmp(var, "core.hookspath"))
+	if (!strcmp(var, "core.hookspath")) {
+		UNLEAK(git_hooks_path);
 		return git_config_pathname(&git_hooks_path, var, value);
+	}
 
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9ff46f3b04..93ad0f4887 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1050,12 +1050,16 @@ test_expect_success SYMLINKS 'symlink to nonexistent configuration' '
 	test_must_fail git config --file=linktolinktonada --list
 '
 
-test_expect_success 'check split_cmdline return' "
-	git config alias.split-cmdline-fix 'echo \"' &&
-	test_must_fail git split-cmdline-fix &&
+test_expect_success 'setup check split_cmdline return' "
 	echo foo > foo &&
 	git add foo &&
-	git commit -m 'initial commit' &&
+	git commit -m 'initial commit'
+"
+
+test_expect_success !SANITIZE_LEAK 'check split_cmdline return' "
+	git config alias.split-cmdline-fix 'echo \"' &&
+	test_must_fail git split-cmdline-fix &&
+
 	git config branch.main.mergeoptions 'echo \"' &&
 	test_must_fail git merge main
 "
@@ -1101,7 +1105,7 @@ test_expect_success 'key sanity-checking' '
 	git config foo."ba =z".bar false
 '
 
-test_expect_success 'git -c works with aliases of builtins' '
+test_expect_success !SANITIZE_LEAK 'git -c works with aliases of builtins' '
 	git config alias.checkconfig "-c foo.check=bar config foo.check" &&
 	echo bar >expect &&
 	git checkconfig >actual &&
@@ -1397,7 +1401,7 @@ test_expect_success 'git --config-env with missing value' '
 	grep "invalid config format: config" error
 '
 
-test_expect_success 'git --config-env fails with invalid parameters' '
+test_expect_success !SANITIZE_LEAK 'git --config-env fails with invalid parameters' '
 	test_must_fail git --config-env=foo.flag config --bool foo.flag 2>error &&
 	test_i18ngrep "invalid config format: foo.flag" error &&
 	test_must_fail git --config-env=foo.flag= config --bool foo.flag 2>error &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9201510e16..98e20950c3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1370,6 +1370,7 @@ maybe_skip_all_sanitize_leak () {
 	add_sanitize_leak_true 't000*'
 	add_sanitize_leak_true 't001*'
 	add_sanitize_leak_true 't006*'
+	add_sanitize_leak_true 't13*config*'
 
 	# Blacklist patterns (overrides whitelist)
 	add_sanitize_leak_false 't000[469]*'
-- 
2.32.0.853.g5a570c9bf9

