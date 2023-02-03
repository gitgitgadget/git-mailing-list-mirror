Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4E3C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 12:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjBCMQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 07:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjBCMQe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 07:16:34 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C712095D1D
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 04:16:26 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gr7so14809159ejb.5
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 04:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQ3OfThxAa3aEdV1n9p+/L7BjJm1v1y5Uq3UaqGckfM=;
        b=O8P1oguLbcur4uLYZ4Mxlz7TgBmvdzPtcbnJ4KAZ89YaRY9SmDLUFLKvIFy2dwnm3V
         kvsEMfj8nKNyHtYStFLh+ObHgD0PIkqp3CRfb6anQMEJ5oUT71rMz0zFjgkptCKlI+Sw
         Hzv8RRfacpIljQpcMHNrxwdLy+e9R5MKwIR7c+1Yqg5vfsLKii9ujruagraP4TaOP2JA
         4wGtVbOv/y0x8ov8PqAH2Qw7UVPPrGZ6nCbIWZhIXsTK/aBPQ48GDW8+K+vtkEeetwGT
         AqYj1IsonbcJy3oyT9QkUh7B/SSGI+DrBuRsFdpV/XS1ngn7vyEr7ufaRV8yqlB8Woe8
         X/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQ3OfThxAa3aEdV1n9p+/L7BjJm1v1y5Uq3UaqGckfM=;
        b=aeKUVrxvN4FY76On65kNGICdBH5CUgA/NJp5W2Q9mF05I8IuTrFQ07IF1fPWE2rhfL
         iEH10DJAvn/rTr+fne98PXQlX+q7YB0TMGnesrOYcl2kLdBuJj04OUePftTF+/vNROaj
         GKyW2lptcF8DsuKFDMrV/HNigSRsdcEEobpnBB6bC9UTCGy86Ta25c/OVioVTaGfujL2
         tDdwouIt9frg5iW03/BET0/x4AGFLCRkj1Wl+koRrIs6ObbVgXPTyj0Pk+dpbrqKTlya
         tbnI2ET6byfmJgUw2srpQcOMcCXKI7qseqfvgLPI9400oqbaEUEkse5TO+eB9j5iI2kN
         Va1Q==
X-Gm-Message-State: AO0yUKVKC5gkWSrwiE6zUqAalmD89TljDU91Q0FBjicy6o7KMMfPyoLP
        E31Y5O8qfC/3XTXRXtBcuh1MgsfnWurQrYe4
X-Google-Smtp-Source: AK7set+eeUsE+8rJESqxjr0lOTutEnro3VjgbVoRvfwBHehNrDGV8wLqBOoDWceQXZCgiGKdF4NsoA==
X-Received: by 2002:a17:906:4713:b0:87b:d597:1fd5 with SMTP id y19-20020a170906471300b0087bd5971fd5mr10830021ejq.75.1675426584967;
        Fri, 03 Feb 2023 04:16:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906849800b0088b24b3aff8sm1286313ejx.183.2023.02.03.04.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 04:16:24 -0800 (PST)
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
Date:   Fri,  3 Feb 2023 13:15:35 +0100
Message-Id: <patch-v2-5.5-b4e02f41194-20230203T104319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.gbe42486b8a4
In-Reply-To: <cover-v2-0.5-00000000000-20230203T104319Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20230203T104319Z-avarab@gmail.com>
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
2.39.1.1397.g8c8c074958d

