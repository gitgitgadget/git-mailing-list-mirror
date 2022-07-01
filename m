Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C126C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiGAKh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiGAKhw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:37:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C43796B9
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:37:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o4so2602737wrh.3
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81Rn7A/R0QG2zjasWzu0o83rpQw9RemPniBIh+bCI+A=;
        b=IBJuSGJInVZu+oVovvR+50oU/9vEpcbGePPobmNu/1jZV549E0QRn9E1HW/QUgBUa+
         aMX1iJoUGQpgECN8BBG/jQKTJZ7LHCRQxbAiF3iy/xjwRfWpzO32IkQUWIVy+55k9IpP
         8psyktPQeh888N4DFm6dwR5cRzI6VQkHVciK5jjXp0mmrLCT8Pc/mBJt2kUSVh0q73Hy
         duAHWaHGh8Gry72ro7fb88PZRgk0Anpejc1cqaokVr5ujcibl/KN8sEjEAAbDQC8CZdz
         bNI3V8JGmRGBP0XtwRRiEzAlvfTO/tDXPUQLJo0xl4IwGpQFvqcMhFKjnFSECJgtp9W3
         FOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81Rn7A/R0QG2zjasWzu0o83rpQw9RemPniBIh+bCI+A=;
        b=lBSAV3huiErdsC+1q0rFcyEcBPoRz6MuvTGck58Qmj3xc92CfJTYpoTplqr5lhTHb7
         /7OzaM6WyTzgosU4iWjySy86sl1tz03vjjq1o7GUNVtflt70rbAfy25SjGtn29U+dWP8
         7ZNv3h4txRKn9xIE/5pwFDRQ7rmgtabGJcPPe9hGA32DG2dVmO5AifwEBLIvm2Km8VKc
         WbhzYyQuT0WNcXQUiX2xkvKl58ePCVSxGpGjnkReuo6DfwAJ1/zU9d2iWlR7ApRNh0AU
         jEPM2NqmpTbbtB/BOrOtfKmUEuEUunMC9LOF7Y23rl3xbJdiMLMdDKVS3zxGW28t8+IJ
         akmA==
X-Gm-Message-State: AJIora+lcko/td80GtpgCc4YBWAJnj9I2+TumSqZT+1Q1VoKgnqZ3Ej0
        rWa4MXF3ZGYoVnR3WjPpM8XVHEtjzjkJlg==
X-Google-Smtp-Source: AGRyM1tmyyU1ccST76ZRZ93sCEByoZ6qhaM5lvCmcjYzpORK/q70tZq1XOzieE9Ix9gSc7WsNA5iug==
X-Received: by 2002:a05:6000:9:b0:21b:9ebf:54e4 with SMTP id h9-20020a056000000900b0021b9ebf54e4mr13378406wrx.658.1656671869634;
        Fri, 01 Jul 2022 03:37:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b00397393419e3sm6229871wmq.28.2022.07.01.03.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:37:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/9] test-tool path-utils: fix a memory leak
Date:   Fri,  1 Jul 2022 12:37:33 +0200
Message-Id: <patch-v2-2.9-050766e6fa2-20220701T103503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in "test-tool path-utils", as a result we can mark
the corresponding test as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-path-utils.c | 11 +++++++----
 t/t0060-path-utils.sh      |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 229ed416b0e..d20e1b7a18d 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -296,9 +296,8 @@ int cmd__path_utils(int argc, const char **argv)
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
 		char *buf = xmallocz(strlen(argv[2]));
 		int rv = normalize_path_copy(buf, argv[2]);
-		if (rv)
-			buf = "++failed++";
-		puts(buf);
+		puts(rv ? "++failed++" : buf);
+		free(buf);
 		return 0;
 	}
 
@@ -356,7 +355,10 @@ int cmd__path_utils(int argc, const char **argv)
 		int nongit_ok;
 		setup_git_directory_gently(&nongit_ok);
 		while (argc > 3) {
-			puts(prefix_path(prefix, prefix_len, argv[3]));
+			char *pfx = prefix_path(prefix, prefix_len, argv[3]);
+
+			puts(pfx);
+			free(pfx);
 			argc--;
 			argv++;
 		}
@@ -366,6 +368,7 @@ int cmd__path_utils(int argc, const char **argv)
 	if (argc == 4 && !strcmp(argv[1], "strip_path_suffix")) {
 		char *prefix = strip_path_suffix(argv[2], argv[3]);
 		printf("%s\n", prefix ? prefix : "(null)");
+		free(prefix);
 		return 0;
 	}
 
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index aa35350b6f3..1f2007e62b7 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -5,6 +5,7 @@
 
 test_description='Test various path utilities'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 norm_path() {
-- 
2.37.0.900.g4d0de1cceb2

