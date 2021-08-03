Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B25C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978BA61040
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbhHCTjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbhHCTjh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E5DC061764
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p5so26514332wro.7
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WheNg16LOu9InUSvAJw7ZkDJjrGCqhlbjJkBY7xOGU=;
        b=OZb+dB8kJCfKnXQzEHRwKUmPGpuPDTxcsIzBam62mufY0CB7ky4MrS9y5kHKxuyRzj
         5h0f3ONRg5ysKY62qRYolG5edl47da6ROoZLZJEOngjgMLSqiNSnbLtM6sLMeGVlSZTp
         U3z9i9BRa1B1LZaxf9SQXzf76PJuw3ZZvnv9YosdsnrnU9RbB04kwwm/uxDAakG/tIxW
         3eXBZ3kpG1ry4W37cv6BUlqx7Y0orypsfK1pkfDd6AirUbYyp2Qn9f/olwm4TXaucu3m
         hxNmFdf1I/z+GKBNCQV2cBsSz4kuGQj8KxqbGdcGxpIPu+FTTGsh4aYlL1Fi9J+NDooB
         inOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WheNg16LOu9InUSvAJw7ZkDJjrGCqhlbjJkBY7xOGU=;
        b=cQ26C5qQGSBETreQTSmyjYN/VMtesQkHYeJjArOpVttKFnWCJU6/+NgX60m1PzRIrE
         IOuZZl8BODetaZNcCR+wljmt7m6NmEn7JknecIuJgH2tSDSivj+0/zXfDXqtv0yeq+f3
         3Q7xvz/5Kdcec7iGl6kU3QL8SMgL2PI88bESjhlGn33OX0s/zFcFktnbiBMgFnvNHUBG
         9/bWrZPVxL3QeBD45V3wIBsn6dH16kiHR7iIsa/Y9BqwFCNakisVHWhWeQY8Q9ssQ3Oz
         ovMpU0qSm7pRi8P9PDmdMwGYifDDT6nLwLXJ74T+f9ZLp26/pqij6QTHLgeXIPuUjHb5
         pfww==
X-Gm-Message-State: AOAM530vQwZrPD7u463AXKuFGk1Pt6pcY7fidAJ/lVhcK01aJBI56jST
        oRKktUlQMRx6395PYrLP2GRTyBVn7dk9VQ==
X-Google-Smtp-Source: ABdhPJz36Z5FY2KjnaHMyZdI4Dux5pNkJ7TZOJazoaug5gJ76YaAIFEh4MmM1a8AOpJv0nIAYhsq2A==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr23998368wrs.178.1628019564724;
        Tue, 03 Aug 2021 12:39:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:24 -0700 (PDT)
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
Subject: [PATCH v4 14/36] git hook run: add an --ignore-missing flag
Date:   Tue,  3 Aug 2021 21:38:40 +0200
Message-Id: <patch-v4-14.36-2ca1ca1b8e4-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
index 660d6a992a0..097fb9de63b 100644
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
@@ -29,6 +29,14 @@ optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
 arguments (if any) differ by hook name, see linkgit:githooks[5] for
 what those are.
 
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
index 41dd15550cf..f33db9953c7 100644
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
+			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
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
index 644df0a583c..49df5a2cdfb 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -25,6 +25,11 @@ test_expect_success 'git hook run: nonexistent hook' '
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
2.33.0.rc0.595.ge31e012651d

