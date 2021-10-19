Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05F4C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49436115A
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhJSXX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhJSXXw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:23:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEA7C061769
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a140-20020a1c7f92000000b0030d8315b593so6261525wmd.5
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=57JQ1c5spRdfNBvFd3oakRnKAfEUX2uIwV3YI1un3iY=;
        b=klrY9I/rCCcPurNmwgSDajfdtZGy3EZbiqceA1dI+EaV1Q8wYAA3aAFbnKE02r67T/
         P7/E5DNhdjJERygaQ+/co4FqZBettFIBBviGdybOrcwqM3ieSTWcc8kzdOsYwNaB5h0B
         3q3CPE3cRxfCjddE2G1LcbOInN+pQlkvCEDsg94gbGPAcqwldeZTEzkhB1mjLpvArG5P
         1udfzCQniUZilKulkV16V4DtMYfITetA2VAT1KtX2MK5I4eT9TQryEZXHg3ub9OdMyQt
         ImQI6nOn13z7YG+ETT6w65QfeKQstcjjI51j/Kqhn5+v2PdbYoyYLFfvkgp/WCgV45w+
         AfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=57JQ1c5spRdfNBvFd3oakRnKAfEUX2uIwV3YI1un3iY=;
        b=qG3QH6RR8Z1RbMJnoPkH7G2UPlq2t6YHphQDKuPx8lfawkjYfGa2cVGAc7P8JfNnxd
         wo49MPX6SFaFQYJLEijY1pm7hIb13LFLuP/ylrfEa8F3LeYh1dS26uODWjnp+nG1J3nb
         F+okDBeN2/tyCyBMwJxkLAcC32JXo+L1kshliGhvSqtFXbMoO/rQzLCLkZtY3VhlzzP4
         BCixrO9EYlsWitEgVacj0020Q5ZuTOFb+5jULkHf1YhGVqhab+WO470dh4Fnn80XuIfo
         dvr2izdDHafRJaRP0CYRVZ5hjNL/FqJaniY9BKK8a83ACz+j3WfPYHS7RsIPGlfv6TW7
         CibA==
X-Gm-Message-State: AOAM533eUbo7KAZYjQmeeHWsvCVsnI9K7vw3lAaXXvYsdALD8fZYz8wi
        K7wLx77X6ljj0dje88MDiSIpcf2Vh0KfjQ==
X-Google-Smtp-Source: ABdhPJyBE4BBJY/A6jIxOc3byvkqCNg7xiZc93AzzPO/FqX/WUf6iE1fAhO1IxlIHkU+PHLtQUHfgg==
X-Received: by 2002:a05:600c:284b:: with SMTP id r11mr9493856wmb.179.1634685697477;
        Tue, 19 Oct 2021 16:21:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g25sm304644wrc.88.2021.10.19.16.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:21:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/13] git hook run: add an --ignore-missing flag
Date:   Wed, 20 Oct 2021 01:20:45 +0200
Message-Id: <patch-v3-07.13-840fb530df3-20211019T231647Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For certain one-shot hooks we'd like to optimistically run them, and
not complain if they don't exist. This will be used by send-email in a
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-hook.txt | 10 +++++++++-
 builtin/hook.c             |  7 ++++++-
 t/t1800-hook.sh            |  5 +++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index e39b1b5d069..77c3a8ad909 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,7 +8,7 @@ git-hook - Run git hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' run <hook-name> [-- <hook-args>]
+'git hook' run [--ignore-missing] <hook-name> [-- <hook-args>]
 
 DESCRIPTION
 -----------
@@ -28,6 +28,14 @@ Any positional arguments to the hook should be passed after a
 mandatory `--` (or `--end-of-options`, see linkgit:gitcli[7]). See
 linkgit:githooks[5] for arguments hooks might expect (if any).
 
+OPTIONS
+-------
+
+--ignore-missing::
+	Ignore any missing hook by quietly returning zero. Used for
+	tools that want to do a blind one-shot run of a hook that may
+	or may not be present.
+
 SEE ALSO
 --------
 linkgit:githooks[5]
diff --git a/builtin/hook.c b/builtin/hook.c
index 41dd15550cf..fa26454990d 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -7,7 +7,7 @@
 #include "strvec.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
-	N_("git hook run <hook-name> [-- <hook-args>]")
+	N_("git hook run [--ignore-missing] <hook-name> [-- <hook-args>]")
 
 static const char * const builtin_hook_usage[] = {
 	BUILTIN_HOOK_RUN_USAGE,
@@ -23,9 +23,12 @@ static int run(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	int ignore_missing = 0;
 	const char *hook_name;
 	const char *hook_path;
 	struct option run_options[] = {
+		OPT_BOOL(0, "ignore-missing", &ignore_missing,
+			 N_("silently ignore missing requested <hook-name>")),
 		OPT_END(),
 	};
 	int ret;
@@ -53,6 +56,8 @@ static int run(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	hook_name = argv[0];
+	if (ignore_missing)
+		return run_hooks_oneshot(hook_name, &opt);
 	hook_path = find_hook(hook_name);
 	if (!hook_path) {
 		error("cannot find a hook named %s", hook_name);
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 3aea1b105f0..29718aa9913 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -21,6 +21,11 @@ test_expect_success 'git hook run: nonexistent hook' '
 	test_cmp stderr.expect stderr.actual
 '
 
+test_expect_success 'git hook run: nonexistent hook with --ignore-missing' '
+	git hook run --ignore-missing does-not-exist 2>stderr.actual &&
+	test_must_be_empty stderr.actual
+'
+
 test_expect_success 'git hook run: basic' '
 	write_script .git/hooks/test-hook <<-EOF &&
 	echo Test hook
-- 
2.33.1.1338.g20da966911a

