Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF211C43217
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbhLVEAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbhLVD76 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1882C06175B
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i12so692589wmq.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+UOX0WuCe4CPTST0DJGyLS9XOBqaNw51sDUWCeNrbWE=;
        b=pkDAQ03a1xq9Sl5Dwnpi1R+E5Xl36eGkQekXtVj7Oj8R0ewG+/FCUkt2Ecq+bPE2WE
         yZZzjB8WN3p6STaMpr76jHi1UnwYFdgO9KDqvPa+B+9EhiodhIFHdHENSL6skvIRq2uV
         5ha+g8i2+z94lnS4QSeGTFAl9NmzH9PUppDdp45xVs30adzOVPEtC3HrFcqBhFW8Hs7l
         j9FdZ+NMy3aAqpV8a/wQ7ObSOaNhWMvS0/dk5O2QDZekfAWNIJs0aH8UzVqL1pejo2PI
         MKFcg6PU1TJy0Vbayfz1YsxETOF9YBibUpqckfHPYm+8CfALcEE9ER4n0Hhh8YTwvGQp
         YvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UOX0WuCe4CPTST0DJGyLS9XOBqaNw51sDUWCeNrbWE=;
        b=GKMdx0l6e6yLKkVbZC9Ygov+QI8w5AM18YvT5F+EwzmueL0mC30p37qu+HvbzWUzTT
         WOrY01Zc8TlPs6gKvk7VH9kY1hqhrExqOqrwEI5FLUZ5hziOKOWXBJJ8WBJmxeDVsun8
         ri2cmmjB9s1xtWlZCrqQxEMaxuGyDgatomm3Wh/RtOLv2n+QG8M5RvOujuaLRZPN88PG
         wuy0f+PjMVF7HFkMvug+FT74oe9ce8hC5Yp83c4IrRnag3E1AuhqV3LgW1dMIGuV0FC/
         wNXDUV3O7W8v4NpA695VJmB1gSco7hOj89zffSbCjK/5MTob0uZ+x4mfyw0XBmSdGN9N
         zepw==
X-Gm-Message-State: AOAM533nYOWyz3eo/oLs6oFQQGs6fCMT3j4px1mX64RlNoKAEE8h4xUQ
        6O+FNSsKOV4Fbeh80j0ViJ7G3xQkOE5Uiw==
X-Google-Smtp-Source: ABdhPJyVmU/OxqorfFiVS+mmDByOH61743Byr0WsZ59NNF1gY5XquXCl3PtvCTNC55sKRBBVtIEkhg==
X-Received: by 2002:a05:600c:3acd:: with SMTP id d13mr941730wms.37.1640145595328;
        Tue, 21 Dec 2021 19:59:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:54 -0800 (PST)
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
Subject: [PATCH v6 11/17] git hook run: add an --ignore-missing flag
Date:   Wed, 22 Dec 2021 04:59:37 +0100
Message-Id: <patch-v6-11.17-7d9c0a73568-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
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
2.34.1.1146.gb52885e7c44

