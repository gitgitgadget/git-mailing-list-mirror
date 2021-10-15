Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931CCC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEF461027
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhJOJqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbhJOJp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:45:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C35C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so25570150wrg.5
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=57JQ1c5spRdfNBvFd3oakRnKAfEUX2uIwV3YI1un3iY=;
        b=pNOiCwCBJ8TYTlqyvZLR2e/4iwC2UKbZBC/IN5basE6HGLin25EGOoLPwoqoZktqsg
         Yka1hmnGTF40ic1hVNbSWhbRacFSOZ1M1mQZUDLDX5wDiy4/yw9ZZ7GmO8+fyJaiJnUJ
         +zbP9ckUlqzLNMryS7uJ3O+qT/cSU1Q2+mFT8mqE9EFOAMbvijupH5Hnyt0yc5pSnBYv
         jIqMLHsxcMCnMEbgdZy0Qa+MtcBZ9ssY49mZPm+cy6fzX8SVm+roZjkFH7ToaGLGPXTV
         TVM1LzIUl7QzhjKXGswqehhv3yOgY7Gqo/uWwp5M50Jpxbi51pEXqpENjqyQHtw1tcnm
         DIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=57JQ1c5spRdfNBvFd3oakRnKAfEUX2uIwV3YI1un3iY=;
        b=fhsH3S/gaRrSnX0LE7xI5aRoJ3ZVXvptCI8sVBmet6xkvY/mcyPqllBKm6s5Mxk56U
         Z8JIzlq95yvDhivSKO7tO0Y4uYc19Ns1IZ2vtr+Nk70vN0oSwj5mIr8YJs5hjybwgGNJ
         bZJtcByXT5VseqaL6UkqXuExFnwzGF/OkgCEwwTBEs3Vv8Dl/bfCPYdHcMPYP8L96Ccb
         +tKiKvYELcgp6y3OUvvFJrwesNl4LSosrORm+a0/bL1VLnH+p5fhF93Zr0PFpA8z7CT8
         SW2ULYE06yYKWSfIHmdGnpYBXwpnjiw09geaJwJfl1xMwghYNQPPz2KQsAt2YxlpB12x
         z6Zw==
X-Gm-Message-State: AOAM531go0p6Xm9AXeKNpJlxds+6+l6KNwIYN9G6N10t+0urO5lbf90+
        QHY2Hlf4g929vI6E1XLx4LGOT4w9k2VyYQ==
X-Google-Smtp-Source: ABdhPJybzmS2xdja6cP/IwP7FzS8cMThqWSwpKUFbweGHzmay7W/vpXQP1yqZKN1DJRvksbY5OagFQ==
X-Received: by 2002:a05:6000:144c:: with SMTP id v12mr13089412wrx.142.1634291031256;
        Fri, 15 Oct 2021 02:43:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm5963648wrz.58.2021.10.15.02.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:43:50 -0700 (PDT)
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
Subject: [PATCH v2 07/13] git hook run: add an --ignore-missing flag
Date:   Fri, 15 Oct 2021 11:43:35 +0200
Message-Id: <patch-v2-07.13-328767015b1-20211015T093918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
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

