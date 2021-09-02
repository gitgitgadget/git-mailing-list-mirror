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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3346AC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD33610D2
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbhIBNNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345103AbhIBNM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:12:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9BAC06129E
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:11:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x6so2834482wrv.13
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wDrE0FPvVH6LBUMt6J/72sA7CngBppk7QOSN1unW+bE=;
        b=GLwI3iFzq/GZGoJT1l/zK64ZdZxDAmylCsChsuQAs4OvzN9sF6LG7vYikv/NTcPDuu
         HW+9t09LTk6qKGUAQi+VdbO1qxLmsG39tWit2/jEGlB1aiMgz9CxOfQ2rrZ7PT6XsgJ9
         zMJq4gnwj3r8AmnGd0khcDOxqIvfkNwBwat8DB41Rfz+0BmiADk4QFib6f8aQPdy7tsN
         7M48GDCgr1+S6n0nGagk9yglQvIyJjkMApmN3VyA7I+EY1CVg6507stU+Hk32UYrJKdm
         YdZfbL6lF7tfC5tAJltL7d7xgtOEHtDUlME7l7u39jWx4AYq38RTIJK2Mxo7mA0edtC7
         6aMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wDrE0FPvVH6LBUMt6J/72sA7CngBppk7QOSN1unW+bE=;
        b=PfgRaA1fuRtZsrqCP5Weln9KISA4Jjro1zfTGNbWzLFUnVibNuYiMVTrIxsW9jJfhY
         MrjQshBFzjFBGbMAzVlQwpl8QoeeBqDn87Pq5pX6wyjQut9cJwbAYVP6JXoFcOgLeGWE
         IK13UYWqU3u1HnSzBm7/Ej7DNGLISPBUiM6CZ6zjgQcElFrjWhyVdgp5nhhmb9cSawCk
         bFXs29S57lEi+7y1Bh+DM4m0ofWH1kuMeNQMn0EDZ5MT0ru70xGkxqCLFgNtFUstUMsi
         ACT3BTd4Ck0O+kY2g4kEnPQRaJruiW/cODRktR1O3BK4VZlglCWmLrlR0LDmRgP7mNpI
         SamQ==
X-Gm-Message-State: AOAM5309UEpXTm0wQb1s10+xyzwRZhPxeiXGHL18TAw6RnOcSuUCqCWG
        GOgCz78HTIB5LA9Pg3I/+Pgu5KyO/tFQgw==
X-Google-Smtp-Source: ABdhPJxQNZOW2snnhx4toCByIWOMlltCeR1NF+hGmm5J/drp0t8Ljhsg/zzoyVwK8eNiBhAzKdnqVQ==
X-Received: by 2002:adf:ce85:: with SMTP id r5mr3594434wrn.323.1630588317027;
        Thu, 02 Sep 2021 06:11:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:56 -0700 (PDT)
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
Subject: [PATCH v5 14/36] git hook run: add an --ignore-missing flag
Date:   Thu,  2 Sep 2021 15:11:14 +0200
Message-Id: <patch-v5-14.36-d60827a2856-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
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
 builtin/hook.c             | 10 ++++++++--
 t/t1800-hook.sh            |  5 +++++
 3 files changed, 22 insertions(+), 3 deletions(-)

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
index 012a2973b38..76d49e672f4 100644
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
@@ -55,9 +58,12 @@ static int run(int argc, const char **argv, const char *prefix)
 	/*
 	 * We are not using a plain run_hooks() because we'd like to
 	 * detect missing hooks. Let's find it ourselves and call
-	 * run_hooks() instead.
+	 * run_hooks() instead...
 	 */
 	hook_name = argv[0];
+	if (ignore_missing)
+		/* ... act like a plain run_hooks() under --ignore-missing */
+		return run_hooks_oneshot(hook_name, &opt);
 	hook_path = find_hook(hook_name);
 	if (!hook_path) {
 		error("cannot find a hook named %s", hook_name);
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index d0a3796f28e..feb95b8fc8d 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -20,6 +20,11 @@ test_expect_success 'git hook run: nonexistent hook' '
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
2.33.0.816.g1ba32acadee

