Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEABDC433FE
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbhKWLuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbhKWLtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:40 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E583C06173E
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:32 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 133so18503810wme.0
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YdzO09LWQw2YVMbYTnsa4ZB9qjgOBMWPajyWs9V+LXc=;
        b=FiqIICu2sXcbAZi7GA+CG7v6+dG+1V0zlqsQxR1ptuXz/sQywotvos5YmqIjgH3Zxv
         9HM04dR+/bCrpnb5nt6OeEpDRmOp5ZX3S3jDUjDsymvEVoQkYXYf8wxjuUsJXfncxgSK
         n5BIwandng6lgMHHWenXduUOPUapmKlITc9jaTivlaNOwDWShRrGVpuD4pXRFYnpjNdK
         cr8K7ytRqoW74DlIXuoSdUeCdxU2l6bwsHE5aWCZEsZDb18BudflrYJ6avXt05M+nkUo
         CK8gqrlSXrTWtrpNHL4ZlZrJpoItZhVkF5DJAKfckXcrgtpYe5w97pE91Ry80xvAt0qC
         Z2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdzO09LWQw2YVMbYTnsa4ZB9qjgOBMWPajyWs9V+LXc=;
        b=cpQ9MRyRiYqeUKpb50X87j9Mh7vozAfMigVrqNV4LYuF+N3OaWiwycCo08/BRKPF+/
         XaPlawGzarS17U0J4DAFfZUxSmqQ2XGp+4iBukCQr8bRm5j5By2eXqAxYe0rhTYVMMiL
         jtX0V+Y8iT8Gr4NDD2f7u93VoWfYiRTqm3rendo1vWL35ZQvwqFxdLGNIY/P6lswH/dJ
         8Y+nxQ6llxDeRtDpPcmyuc1ogur2T3vQcAOGZaDJ+9Tz27Y6pIdv7WklHq3c37ZTYBTs
         Mv+aJowxOW+ar9F5RkTaxfsDRGzA5xFlpanohrXWDZGTUggUG9bq6/+yo3O6BChRdWvC
         Lh5g==
X-Gm-Message-State: AOAM530WyubcZNfs0LYW+bShxwNQ4b5ZJybrqj6DcpmF/okLeIJGBgm0
        TxI0yUlYZwKnOdOH5kFOwx8qOq3V206Haw==
X-Google-Smtp-Source: ABdhPJxxF80eb9IN4FhApj8RAYWkTFujPuLCQD9egfYY86PIOdX7/og1H6aZodvFzLw1U2FCl6BxcA==
X-Received: by 2002:a7b:c10a:: with SMTP id w10mr2207106wmi.183.1637667990452;
        Tue, 23 Nov 2021 03:46:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 11/17] git hook run: add an --ignore-missing flag
Date:   Tue, 23 Nov 2021 12:46:10 +0100
Message-Id: <patch-v5-11.17-f1c84d7f627-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
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
2.34.0.831.gd33babec0d1

