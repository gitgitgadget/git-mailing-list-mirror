Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CAAC38142
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 17:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjAWRQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 12:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjAWRPc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 12:15:32 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01B830E5
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:15:18 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ss4so32273225ejb.11
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CObrc47jsH1/VTaTtfLUTAmc+L7k4mYNPcUFl+dpBQ4=;
        b=h0v7vfG7IePzIHc/yyfenbI+3xEXLPMpRFaGtbbeacMuJMj8IOnax2cd5NF0t/w9px
         GMC8eBZq5xh+vUC3EEieON7eVjihQOW/wER24SEYbBbBaLaPrM6Lp1NEnvV+Y/lKOOlS
         c0E6KPEftN4Gu8Vtd5utpJ60OXPxrbUxVkGVGUlX021Ff4B3TBrBL3iNV4u8KDJDgV51
         WIWNMw7/+mq9UEKSNKMaapR6CfByLEBrc++SIBadfaiuqquwNGow0IBR5RA1q4z/1Zvo
         9zquLSPUHyGrUq9RZSrcDJDcGeZhJ6biVDr/ugBEwVppvA8/inYb48LtoVHL9Oyrrrf6
         czKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CObrc47jsH1/VTaTtfLUTAmc+L7k4mYNPcUFl+dpBQ4=;
        b=AfphbGNef1BuzcoEt3R9yYyOtaHVO7W2SrT/s+OPpXEJqC8yO0ZzvGISflPfUTMzXn
         Xyhm+VnrBl0gPsoipzw5lUYMjRZlFuYbSCs5hqRyOJGQskVTXX7ukSLN9ABo2PrOEiRJ
         K05tqUwj8ds8RtzKQI9AjKiTEvX6Vmgen674bDf78fFfnZ0C3EomCTqJspBePtSnSi2O
         HXWS65g0tLHC2X19sdN3dJj/8HAAChK3MiEX+z+2+g47Vr07T82c8AaZRpIgu3Vwqa3X
         I1yv33pRXmfxO3M4BvvLOc/DY6o6HWi5exymqQ3vaIr9TM8uMXKXucgR2PmyVkEV8OE8
         e+Xw==
X-Gm-Message-State: AFqh2kpIJavWCSff3D7TTWnG5WSKtGYCCdTlX1/LD9FrJ9qFEwfgJLi/
        SQwoK+HQ5tobBABYO5U1z1w6WLcg75PFaQ==
X-Google-Smtp-Source: AMrXdXsTBUrugCWN3TPbYS2PiVafqZ8wAGvg3RxY9xIS6Z/VjPaXFltimPoUJv6MiWzjfyKrwLZmqQ==
X-Received: by 2002:a17:906:5283:b0:84d:4be4:aa2b with SMTP id c3-20020a170906528300b0084d4be4aa2bmr39037865ejm.68.1674494117084;
        Mon, 23 Jan 2023 09:15:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906164400b007c11e5ac250sm22771754ejd.91.2023.01.23.09.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:15:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] hook: support a --to-stdin=<path> option for testing
Date:   Mon, 23 Jan 2023 18:15:09 +0100
Message-Id: <patch-5.5-cb9ef7a89c4-20230123T170551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1301.gffb37c08dee
In-Reply-To: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Expose the "path_to_stdin" API added in the preceding commit in the
"git hook run" command. For now we won't be using this command
interface outside of the tests, but exposing this functionality makes
it easier to test the hook API.

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
2.39.1.1301.gffb37c08dee

