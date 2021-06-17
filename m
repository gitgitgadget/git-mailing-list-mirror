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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC91AC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF20361263
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhFQKZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhFQKZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53032C0617A8
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d7so3339385edx.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Es4wf1ATb0YeoWwa+zop/EEDuFJX675pSI+Mdm7uM9A=;
        b=H5Nv+/x98wVtJ4dKWgoPjZ91Klh4oWr0P3g9KwdoQ8k0CyzNl40Ealh7un62GyvqRR
         rn8gndRnoypXRfCSC41WHRfJDXuk9x5qjAvL5E9eeBjtMbeNJHwO04qsMjYAfbH8E1KO
         pUqktpMugZ89UfSl9LKiVqIeO3pK7rcG+vu0ZQ1upbaP7lYX0mswNITyGiFAo6HtpQ4g
         l278NpHT7MtKrryCk3kH8yKsjDz6EcVptMkPTWz1fMSxJmt3rbelkMkGzi7nkQRmb4nE
         NX6MME6Y0un7onJHm8DJs6OSbetPxDiY2xZ9U+Q/qjyha3yWQcuR9+gRnyIsxHKFgTsI
         EXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Es4wf1ATb0YeoWwa+zop/EEDuFJX675pSI+Mdm7uM9A=;
        b=HXxnnu/FF2cS56kUibg0weU0/T5WM+3juTNwr+TZmD/4D7sd0waG/Pnt65/WxE+Uqo
         188gJoxr2jQKCCVilQBwG4kKsfkgVl2TJK7/MGSgvER9zFbcKRttIpnD4Kz5lNU+MrXx
         R/Yo5xFJaPvhbuOvI0Y980vxZFhY7SqTZmBxlBtTzwMb/4rWKMVWb5eBEbLMhxOuFm7Y
         9Da8kGpIGnM2rHmSzsauu0glzgPPBn1Nig3MzJJ+FHD7tLFpaSpS+aNvu+To7GJyRt0D
         J3gWCuvZ+xyCRxIAISa1VNN5QIsDpqvgMeWn/dVhL9IelhaZGkeHL2OmCZMB1g3GU2Wg
         D37w==
X-Gm-Message-State: AOAM530albGPp51unax1Ja7wab/ofUthXb5sl1O9gD2XbYeWe6ehLALG
        6sKp3wTQS1MEbHhj7iP6+hv1T4xMimdDbg==
X-Google-Smtp-Source: ABdhPJxG9W93xkLY9Sn2KwcR6OpkVreJqpQorP7YylDJke71Rq1LlAnKDJLKUaYYcMpRSkVluB2Ivw==
X-Received: by 2002:a05:6402:151:: with SMTP id s17mr5405073edu.233.1623925394692;
        Thu, 17 Jun 2021 03:23:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:14 -0700 (PDT)
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
Subject: [PATCH 07/27] git hook run: add an --ignore-missing flag
Date:   Thu, 17 Jun 2021 12:22:41 +0200
Message-Id: <patch-07.27-12347d901b-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
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
 builtin/hook.c             |  8 +++++++-
 t/t1800-hook.sh            |  7 ++++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 660d6a992a..097fb9de63 100644
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
index 7714d31ef1..47e0de7bbc 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -22,10 +22,13 @@ static int run(int argc, const char **argv, const char *prefix)
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
 
@@ -49,11 +52,14 @@ static int run(int argc, const char **argv, const char *prefix)
 	/*
 	 * We are not using run_hooks() because we'd like to detect
 	 * missing hooks. Let's find it ourselves and call
-	 * run_found_hooks() instead.
+	 * run_found_hooks() instead...
 	 */
 	hook_name = argv[0];
 	hook_path = find_hook(hook_name);
 	if (!hook_path) {
+		/* ... act like run_hooks() under --ignore-missing */
+		if (ignore_missing)
+			return 0;
 		error("cannot find a hook named %s", hook_name);
 		return 1;
 	}
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index ecd517b162..542e551628 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -23,7 +23,12 @@ test_expect_success 'git hook run: nonexistent hook' '
 	test_cmp stderr.expect stderr.actual
 '
 
-test_expect_success 'git hook run: basic' '
+test_expect_success 'git hook run: nonexistent hook with --ignore-missing' '
+	git hook run --ignore-missing does-not-exist 2>stderr.actual &&
+	test_must_be_empty stderr.actual
+'
+
+test_expect_success 'git hook run -- basic' '
 	write_script .git/hooks/test-hook <<-EOF &&
 	echo Test hook
 	EOF
-- 
2.32.0.576.g59759b6ca7d

