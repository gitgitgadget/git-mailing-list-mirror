Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9E1C64EC5
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 19:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjBHTVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjBHTVm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 14:21:42 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A8530C2
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 11:21:40 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hx15so53567274ejc.11
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 11:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kySIHZO26mFqMGbpAbUgN0QT4l0xqyf910mX7ROvzc=;
        b=l9latO6iEmcGAFRJC/1hE1iKPvRIBjzpQiDug6Frb/NinzV5fR83TSMP7rRqwUoO3M
         Zb0ejR4IZ+CMRo5MTgYmZR1rMyTSgffKJIQVh6bql8jvvxhE0o37V6vjpl+6MlgfFlLb
         EAGvRsUgAw+XxQMwUrdjAZGR1zV0pQiTzVtDrPb6uff/xs6gTduAz2qsYyqDvf25+cy1
         /8kF+45KZAZX4I9wDyk3WHqY9PEoA1Ld2c3nvwLkqagIZAwRVeTmQn81pvpUTx8H6aPH
         GAIsm2Rbx2YOtd6tWyNzFAztreuhUoCGcxzEQq5bWqC0vQzBB4xbZDqvQJlRmyJWAIur
         sS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kySIHZO26mFqMGbpAbUgN0QT4l0xqyf910mX7ROvzc=;
        b=qom0n0aYY62XwY3Y5awBBtdaqLBYKxtSkzcOQBUCxVBJjiWau7ebfdANmx70MuX2eB
         8IgUAnRNptJy/44/3GJ0Y1uNdqCBmWGfszFD+/QiDAHUY+1BcMTMegOTWW9qIDX0+PeR
         KseS7rKq8OCDobehrHmP5jObKVhbt25f5Y9y7KFmGHR9hoEcvWgnb+FLepfSYwyWfQ92
         D7DuwRZBljFSU7oAumTzNTGCwNXcdaYsBB3ioSx6pmP5NTuMObjo01+3ssKC90Uye6K9
         Y2LqGp0clJCJU7d/zQ26kR899hN109EvlNzt4I9TxtiTmyL1tYrbsByRAK3l7rEh+Uvf
         XsMw==
X-Gm-Message-State: AO0yUKV2614cpQNz5bbY/oJrKL8YgGT0RReBmzG+rHitHmw4in6UAOCm
        1SuFn5XJnaK5GiBu2s0u8dQpbw1qvRr0gRd1
X-Google-Smtp-Source: AK7set8JKjpff+nhkhLG7DQf+wzOqUGOV53Y1+Q3iTsSaCMlB/3gn/55CNomXaI0Hi6AMXw7M3yzBw==
X-Received: by 2002:a17:906:6951:b0:8a6:1020:8799 with SMTP id c17-20020a170906695100b008a610208799mr9075636ejs.56.1675884098508;
        Wed, 08 Feb 2023 11:21:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e15-20020a1709062c0f00b008964fdd5bbfsm6244227ejh.155.2023.02.08.11.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:21:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] hook: support a --to-stdin=<path> option
Date:   Wed,  8 Feb 2023 20:21:15 +0100
Message-Id: <patch-v2-5.5-b4e02f41194-20230208T191924Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Expose the "path_to_stdin" API added in the preceding commit in the
"git hook run" command.

For now we won't be using this command interface outside of the tests,
but exposing this functionality makes it easier to test the hook
API. The plan is to use this to extend the "sendemail-validate"
hook[1][2].

1. https://lore.kernel.org/git/ad152e25-4061-9955-d3e6-a2c8b1bd24e7@amd.com
2. https://lore.kernel.org/git/20230120012459.920932-1-michael.strawbridge@amd.com

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-hook.txt |  7 ++++++-
 builtin/hook.c             |  4 +++-
 t/t1800-hook.sh            | 18 ++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 77c3a8ad909..3407f3c2c07 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,7 +8,7 @@ git-hook - Run git hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' run [--ignore-missing] <hook-name> [-- <hook-args>]
+'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
 
 DESCRIPTION
 -----------
@@ -31,6 +31,11 @@ linkgit:githooks[5] for arguments hooks might expect (if any).
 OPTIONS
 -------
 
+--to-stdin::
+	For "run"; Specify a file which will be streamed into the
+	hook's stdin. The hook will receive the entire file from
+	beginning to EOF.
+
 --ignore-missing::
 	Ignore any missing hook by quietly returning zero. Used for
 	tools that want to do a blind one-shot run of a hook that may
diff --git a/builtin/hook.c b/builtin/hook.c
index b6530d189ad..f95b7965c58 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -7,7 +7,7 @@
 #include "strvec.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
-	N_("git hook run [--ignore-missing] <hook-name> [-- <hook-args>]")
+	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
 
 static const char * const builtin_hook_usage[] = {
 	BUILTIN_HOOK_RUN_USAGE,
@@ -28,6 +28,8 @@ static int run(int argc, const char **argv, const char *prefix)
 	struct option run_options[] = {
 		OPT_BOOL(0, "ignore-missing", &ignore_missing,
 			 N_("silently ignore missing requested <hook-name>")),
+		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
+			   N_("file to read into hooks' stdin")),
 		OPT_END(),
 	};
 	int ret;
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 2ef3579fa7c..3506f627b6c 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -177,4 +177,22 @@ test_expect_success 'git hook run a hook with a bad shebang' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stdin to hooks' '
+	write_script .git/hooks/test-hook <<-\EOF &&
+	echo BEGIN stdin
+	cat
+	echo END stdin
+	EOF
+
+	cat >expect <<-EOF &&
+	BEGIN stdin
+	hello
+	END stdin
+	EOF
+
+	echo hello >input &&
+	git hook run --to-stdin=input test-hook 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.39.1.1475.gc2542cdc5ef

