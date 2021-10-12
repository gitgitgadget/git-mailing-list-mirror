Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C00FC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72DFF60F23
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbhJLNdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbhJLNdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:33:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434F7C061745
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d9so57232636edh.5
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jGqs/XUnJ5Y7+xSjOqY9uHIYqZbTxjYJ79DPSRzb69c=;
        b=hmOrGlsmZ5pu4/rXMNhal1kXCwi3kLKC8OgrgPYZa2ltdLDClmsbi/JuhRDm/7lyS+
         i9A8FWgFt1vzipuv5EgpjRD2eaGsObfdpslJiHwjW9Y5fru/qJfeU2in86UI5NqD8BD5
         zJMvLGSOuNNbiqADVeQDz1xtHMb+ZI2EbezfZj6Ye80n/JnDPRhLMBM1XtV8HdgTF9eu
         rQT8W6hT/smrz6kW9gKotBvTVGp1IC9wylzNR0k1lNkLZ4ZZ40h/yc7LVFDTv/e/VBf9
         kLSS23AWxx9H3cFH+dpzcGgU5z3z2d2Upryqgy+FKiTmzW4uB1/eSG/HuBDO8zIRXSzh
         LoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGqs/XUnJ5Y7+xSjOqY9uHIYqZbTxjYJ79DPSRzb69c=;
        b=sdDnIqeb+CopQdIFYtBFyJC0rjjsfRZEaXOmlgJDU1YF5vUW6cMdMW9sHf6KaJrdQz
         TJ9UXEi4D7kMrdfp1ASLPSVXwSm8Dh0rGsYUE9yfjqZm9OEDZnQEXJKfCS2Z6eJlcYyh
         G15M5An17gmihu4Oz5eymfezWBQpvVoXqv/86ZwHY3eCbI7RPAjuggrO4PRlN4U+RNlV
         q68i2NZltYRvRPzRS00I9cSui2yyOXAJdV+ZbpMC4HjhpJepp8CO+kNbjILTFuVhodkA
         hDJHWBqhqBDRwCJCINffvd/7nl4AbUuTrgOQYlUMtCwzeK8q0vqnB4ErHOGu7MTPVvDQ
         d5BA==
X-Gm-Message-State: AOAM530Yn5whA2oiJrjSQl5WA6HP0ZbF6/kvmY1ZAOVIiR+cs5ZZ4+uD
        w06QHncAi4ke4hNBGyvY8NCZFaMu99dF8g==
X-Google-Smtp-Source: ABdhPJyNQWqZC9zEMJFRAF0uML8jD4/FdVl7TPUaX9LbupLY2qtTdH8+cLBIxP3qH5u/NLxWY4yxhw==
X-Received: by 2002:a17:906:5ac8:: with SMTP id x8mr33166591ejs.132.1634045463986;
        Tue, 12 Oct 2021 06:31:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:31:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/13] git hook run: add an --ignore-missing flag
Date:   Tue, 12 Oct 2021 15:30:32 +0200
Message-Id: <patch-07.13-107c14d740f-20211012T131934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
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
index 012a2973b38..e6b01a7f5c6 100644
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
2.33.0.1567.g7b23ce7ed9e

