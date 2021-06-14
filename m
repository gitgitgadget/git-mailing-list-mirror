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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A0AC4743C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044BF61448
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhFNKij (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhFNKg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:36:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D2CC061144
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso12675426wmi.3
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMSa6zLBMU4KYRnb5uZFshCsRnDXbbt0OVu+2+yx0lE=;
        b=LMTZ6zLwOhXETRfbeaUhE/nPMTTy3oVnDfL+DsXgtnuSFSg4dj6GDWwiIDOTP6HvSS
         U8JdeIjzk4rU50aDNukJrIlNwwIQNLbXj49f3s3W1+Zbr6KduzysUdN0xQ3WGbbBVRWm
         LJYupVpoxt8ksDtIG40Wo5yDbS1IX16qELR1gnzIKuQ7at8Kuir8do4Hlqti0pABI2Ag
         Xwr6GPbV9OXHx0gHz3NhN/3vj67d6PFBU0QLTetBRl3dZZ339iKAoJDQ9o9tT6A4ICrf
         AYmzDU1V9hh1nlCBFwcdxi/Cc909KIfIwpDMYGD8K6GuNGfoGoh4AT3SQJtSZwIUZI+O
         2now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMSa6zLBMU4KYRnb5uZFshCsRnDXbbt0OVu+2+yx0lE=;
        b=LleqyE5j9It8tC8Hkrx6K0cfgDB8+Di612xA+4LE6bEA/qLn4rt90XOt+samBuztt1
         wdoW/NHIrBAq5pTLHUjdF5dbD6xtX6Iip9O3RtIkLERkhqwC/Cu9Q/5LL9CVOTn/Vefv
         GKsPHqVfQU3zCRZBjC5Exw12Hq97T69ZpHGdN4XepUm/7t75LpA25ojpOcw0edXH0KEc
         l1ZmJHmak8e7e9vY8qfbcDHceOA6MBcN3pGXPRAUXU2oGzmq2Z7uUn8qYkv0mNUKqsbU
         zTF9/LfbtSgIis6qEcFSxT+Yy9mJD/G762WabZhtXM8+wJB1DESFzJE7CMexdmn67Wa7
         +MOw==
X-Gm-Message-State: AOAM530pupf+gPIKrY8i3ZMU5ybqVfvFxTPaddlAop8tINKGdl+HEbAJ
        ZVKL1QroBU8ByCmgsoMCsvmcNQAxr0WMfg==
X-Google-Smtp-Source: ABdhPJwFSch7Ma6SOtp/kNeSqGcqKqTuY1k4CEvSrEJJHfnCWMQSEmERpoy9y976qqniBwBKVVcBtw==
X-Received: by 2002:a05:600c:204:: with SMTP id 4mr32045654wmi.95.1623666832248;
        Mon, 14 Jun 2021 03:33:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:51 -0700 (PDT)
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
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/30] git hook run: add an --ignore-missing flag
Date:   Mon, 14 Jun 2021 12:32:58 +0200
Message-Id: <patch-09.30-8d8b2d26453-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
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
index f6ff6c4a493..714dfd08cd8 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -12,6 +12,11 @@ test_expect_success 'git hook run -- nonexistent hook' '
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
2.32.0.rc3.434.gd8aed1f08a7

