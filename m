Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF7EC433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D6E60EBB
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhKATCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbhKATAk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:00:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2B7C061226
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso574855wme.3
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7p4btdGrtgBfGICmR2K2dIF+jcerZ3WaHrsukzFQpEM=;
        b=IqSaG9j3dbRjf5wjcNVgf0HC2luD/U7UImEhjuwmDLRsYD98yRLkmFfHo2tKyexfx6
         SzH+8DB6hhADo3R95IH5sWV/XXiap59FzCCiq1InWEhO951psmt3JHfEyKrfi9t2If1B
         Sd1xzxwIejQLhR76ol1TUJ4Kqw+nCHBq4JDKLEXFxT9Mr2AivPCAvb5+k9UW/lLdg3i3
         HJwTtWtjicKgVrwobwtzAHbpRMfWq3iLBL5WhBiCZ+TLRxuEBbFW0Gv24RBaNxxNWWVt
         vbuKvgWZWXB6y6MiO6jAvw8kLYVBOueCF3ZMF7CLt6ID/dUv6Pxb9HmfCJ9RBa8/2iNe
         G8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7p4btdGrtgBfGICmR2K2dIF+jcerZ3WaHrsukzFQpEM=;
        b=27t1yvYhhY2r5kRplm/H6Tazan+Fu3w7CRD0kfNSeCWMXDcJabxWr6/jEVY9y1DbAN
         6/vkBwU8Z/UIWvGD4Hdet9RCq+If2QxxjSmydJCL1W+Gyc9AfbL8+xSvZZMM536/a1df
         pY+iVhetfAim7PmWmI5YN5G1n63i8CC5EoU7sVWVQYynBi8lSpO+Uie242Oo59JUDsee
         pW2pF05fPbn2AbdyxBSr0Wi+ZLt1RS/JJYtxW5ctoYGPf9/uzmSzC2sUDqp1QuIHg0yj
         4aQnW5KBLKvS6wTtvwKt28G4yWJHsYGvtNEt3cO7OjZWW2eRw0KMXlUDPOKKIcg2OAKv
         y7pA==
X-Gm-Message-State: AOAM530f2jayjYZA0xPZ3zCwlOZkjCO5VtJWJ0rWdFdPV+i19eR2Bmbn
        na5+QX0j1r+oL1vnjkMlIOuGJF2EYe+e3oMo
X-Google-Smtp-Source: ABdhPJwsJzdSsxSUfve3cFxNMgjTeQpomVnSBt+vWxMSc1Piodqj4OscY8Ze3JsPicAtiNCrVAgnyA==
X-Received: by 2002:a1c:751a:: with SMTP id o26mr876829wmc.94.1635792993651;
        Mon, 01 Nov 2021 11:56:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:33 -0700 (PDT)
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
Subject: [PATCH v4 11/17] git hook run: add an --ignore-missing flag
Date:   Mon,  1 Nov 2021 19:56:16 +0100
Message-Id: <patch-v4-11.17-a0b6818c766-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For certain one-shot hooks we'd like to optimistically run them, and
not complain if they don't exist.

This was already supported by the underlying hook.c library, but had
not been exposed via "git hook run". The command version of this will
be used by send-email in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-hook.txt | 10 +++++++++-
 builtin/hook.c             |  8 ++++++--
 t/t1800-hook.sh            |  5 +++++
 3 files changed, 20 insertions(+), 3 deletions(-)

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
index 9b67ff50cef..54e5c6ec933 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -7,7 +7,7 @@
 #include "strvec.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
-	N_("git hook run <hook-name> [-- <hook-args>]")
+	N_("git hook run [--ignore-missing] <hook-name> [-- <hook-args>]")
 
 static const char * const builtin_hook_usage[] = {
 	BUILTIN_HOOK_RUN_USAGE,
@@ -23,8 +23,11 @@ static int run(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	int ignore_missing = 0;
 	const char *hook_name;
 	struct option run_options[] = {
+		OPT_BOOL(0, "ignore-missing", &ignore_missing,
+			 N_("silently ignore missing requested <hook-name>")),
 		OPT_END(),
 	};
 	int ret;
@@ -52,7 +55,8 @@ static int run(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	hook_name = argv[0];
-	opt.error_if_missing = 1;
+	if (!ignore_missing)
+		opt.error_if_missing = 1;
 	ret = run_hooks_opt(hook_name, &opt);
 	if (ret < 0) /* error() return */
 		ret = 1;
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
2.33.1.1570.g069344fdd45

