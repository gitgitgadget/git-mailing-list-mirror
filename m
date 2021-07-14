Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43FFC07E96
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA716136E
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbhGNAOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbhGNAOp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:14:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E71C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:11:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t5so850812wrw.12
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mtFbigT7lfXpGdB207Iw6imejJCXIm2nyRDW0W2CtMc=;
        b=Rpaa1s6+37A8PPel6L6SFLuliF4ov2GFh8slcc4AUS5UJQ4PHQk0tTQLgM1t/FRFfb
         l/qBxGVPUYykTHX1hxiSBdgNHDb1PJbyzmcxybOjZJ2MZcqoLSU0mZ1rJ7zTwty69Sf3
         aOt1iSf0UAyruO/kjtHgzUKF+i0xuaRr0mVqYhoOshlgi6G4aRxpJ+Ovp2btGu20/OSk
         pwdr3axVU7U2JCCbpUWsA1ehjqoCliEezSA6KtIx5knrPXdY90bwBlwGi8Gfgqt4nKY0
         wokyFomc11kQUBPcc9ZfqCNYhP/3G7cvWsggJ7GDYyVLr00QLGJ1I6UJKbui3vWWitBG
         V0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mtFbigT7lfXpGdB207Iw6imejJCXIm2nyRDW0W2CtMc=;
        b=XWMifFCPvYD2Efh8N4F/fJjac1ZsURgl4WY41vVfI5fQ7bp/FzBy8PP4oziIKWEDOk
         EjSeDGc3i3nVXpOqu/HGaWzgDm3dbwYigFLGVR+HHRNibr+rectNwJ+4VD4aLPnDBaor
         o+DSAsf5hG8CT90uaENVCU/Kyph8HqxMadE5MLm89RpsqApCbvYpPlb8J8CS8azsy+Uk
         K5kl6anBJ2QvJzekqh5Na0ZslL9M6u4zTxTS5IWD+mGeZStdbgFQ3U9+qKtXpRpYaf//
         QNCHzQFcRu5aGH4EPKO5akgIc9ov5pJ9V7IJY0xps82BGwGeL8NUYJamVMz84qZo5LPo
         tj/w==
X-Gm-Message-State: AOAM533KfJgQdz+Th5c879CBQhWk7ZUlklIHvTvbHTxXIphTito+XjKV
        T/toRFnJodMKwLdNm7VQ+5yEOsgDY2omrGyO
X-Google-Smtp-Source: ABdhPJzXRPizPEqeoiD4rYI7PjEZq3TUpjGDzvQThPLJMbhLIRD3j34zl0NcsZBfcRsgtr74VTbFwg==
X-Received: by 2002:a5d:6992:: with SMTP id g18mr9265583wru.118.1626221513559;
        Tue, 13 Jul 2021 17:11:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x1sm442382wmc.31.2021.07.13.17.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:11:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] SANITIZE tests: fix memory leaks in t13*config*, add to whitelist
Date:   Wed, 14 Jul 2021 02:11:47 +0200
Message-Id: <patch-2.4-f3a5f26366-20210714T001007Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
References: <87czsv2idy.fsf@evledraar.gmail.com> <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
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
2.32.0-dev

