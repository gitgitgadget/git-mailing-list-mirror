Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEA3C4708E
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139C6601FD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhE1MNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbhE1MN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318EBC061760
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso4428855wmh.4
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aapaffphkhfPAMBsSWwwx81dCQgErvJMkMMkU2qcqCM=;
        b=auGeOdCQ1YkWxmuFcIeAdNzo7Vtugk8TlnrdLHWCScd7Za8BMwo2b+c9ARinp7cErq
         pug/AIzW/2/1PD55cFFqgsV23LYO9d3a6X3PIFSQEcVV52rr+ISHiJA+MBWDpApKHdJE
         uNiwPcDrIVQT1ObbbIdtXxS7pPgA2HWpwjbANaoniBOqz4cLm8CVkcitpM6wTZ4qI5rH
         wXFKV/SD0IzSMoh64AyW3yGS4JAi13paoMhO9ZWNEFWc5ebpwKoJEKZoNRs6xWPrtwcb
         o35Ac4Vg80KwCnulHRDkxvDRN9Yz+sN7rq86IMZUDlCCVDMHc5uUDQtlSe908TNdB24Z
         RzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aapaffphkhfPAMBsSWwwx81dCQgErvJMkMMkU2qcqCM=;
        b=dz+LTYB4POXTSeOyUrMJ/4BEQsKtnkwgJ9YoCIkmDBes/BEsxAYkkU3xdWOjmMWocH
         NwDEPrZlYZ079wltWfMIWqwrzP/kJC53h15ghSG2DwAHPa/aPqC4pbKf6DnWfXPXxdj7
         gjQVZM9ZJgbjBd+iTDOSoXr9Pn90fKaNSXS2mxpbOSkwEiagQLWqFNYWOeCF1SL++UYK
         iUXT+ASRfVLhVRN65EOpCy0In3DeltQp8ri1+J5KNye5c+owsb+6b81gebclEUVVfynd
         +tHQd5TSaeQwrTAi8GyJY0Q3BEu8c6/DEl2Lvr+Bia/Pn/+4xYkN6GuZLe83iH+NpX5g
         9UuA==
X-Gm-Message-State: AOAM530fyuQ+RS97UjsiXdQt4PaElmCXOTKxFbe7+AM/Up3ZgoJ9NZsv
        hwAS1/tX6cY1tHhVHs97TGobIfSvDw33mA==
X-Google-Smtp-Source: ABdhPJz6NitH9dK2G8pqh+1TZ20TkPrkYTBVIK4UkBIrguPPil9e164QfWmcUgOo/npiSZJR08UJxg==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr8306958wmp.165.1622203910543;
        Fri, 28 May 2021 05:11:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/31] git hook run: add an --ignore-missing flag
Date:   Fri, 28 May 2021 14:11:13 +0200
Message-Id: <patch-11.31-e65d8bd6e6f-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
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
 builtin/hook.c             |  5 +++++
 t/t1800-hook.sh            |  5 +++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 902b9cffaef..1528c860cf1 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,7 +8,7 @@ git-hook - run git hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' run <hook-name> [-- <hook-args>]
+'git hook' run [--ignore-missing] <hook-name> [-- <hook-args>]
 
 DESCRIPTION
 -----------
@@ -27,6 +27,14 @@ run::
 	"--end-of-options"). See "OPTIONS" below for the arguments
 	this accepts.
 
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
index 1b1a594fd00..275dd5b0ed0 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -16,10 +16,13 @@ static int run(int argc, const char **argv, const char *prefix)
 	int i;
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	int rc = 0;
+	int ignore_missing = 0;
 	const char *hook_name;
 	const char *hook_path;
 
 	struct option run_options[] = {
+		OPT_BOOL(0, "ignore-missing", &ignore_missing,
+			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
 		OPT_END(),
 	};
 
@@ -42,6 +45,8 @@ static int run(int argc, const char **argv, const char *prefix)
 	hook_name = argv[1];
 	hook_path = find_hook(hook_name);
 	if (!hook_path) {
+		if (ignore_missing)
+			return 0;
 		error("cannot find a hook named %s", hook_name);
 		return 1;
 	}
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 7cacd27c748..9077afa1ed9 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -16,6 +16,11 @@ test_expect_success 'git hook run -- nonexistent hook' '
 	test_cmp stderr.expect stderr.actual
 '
 
+test_expect_success 'git hook run -- nonexistent hook with --ignore-missing' '
+	git hook run --ignore-missing does-not-exist 2>stderr.actual &&
+	test_must_be_empty stderr.actual
+'
+
 test_expect_success 'git hook run -- basic' '
 	write_script .git/hooks/test-hook <<-EOF &&
 	echo Test hook
-- 
2.32.0.rc1.458.gd885d4f985c

