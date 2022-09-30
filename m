Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AAFC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiI3LgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiI3Lfm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:35:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D8613BCC5
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso4855669wmq.4
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2i7TQRTrahWXmAyLBN2Kd6ZWuqzTB6yrstY2x5lnttM=;
        b=OtdDDNO5qt9LgxaRnLEBgcW4c6g+0rIue6MCwgu0mF3UXz0rvUkc38tKUCTYXudGHR
         4tG9l1GxhV4FehFRaoV1FlycdQpwhTx1I4fWVcUvVWal8woVlHQhcsj1Yn/lRiVgPUJJ
         7Ah+lKU+H6IgJ0379Zt/jP/2pDAfFafqriVvAeWId7FLkLxh3gs1UHwUjHhIT68Sib9D
         22bfYQwYDh8GciYZlxes++TAnR3uXcl+M8uQMyXB/7tYNyMN1Ldh8qEXQ74eejgA9C85
         ckcw2Y1HVy3FQDKWIFGeKQF681QQcRdRDCMp88bYNTpC2EwJlTaXIFP2yAgBmenHUhCc
         R4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2i7TQRTrahWXmAyLBN2Kd6ZWuqzTB6yrstY2x5lnttM=;
        b=jnX2H+Wb240rTEi7PH3icvMDil3j9viq7ONphBLbsFhFvm1XDnBQ8POYxX6loQp92g
         OojuNZ1via1Sybk7lJR/gs2WWe6GHcPn9MThvFzT/xwYdDmrHsUdCs3Zt2z8I0CCvEX4
         eiSzFzLjJ3NODviI/BDYqP/n8dRXQ1/TXTClDR7PLVIowxsRuU1GDQd+1z+O2p81L9hf
         GmZl1v2exrcgt7KKIQGHdPyikDIsgd/7t3gr9hH5wgQR67n2HDaMD3Jr280PAyF+60lO
         2HzbQDpUvojp8Jd8BBULSU6tBzB3EPtDmXn+U3E48K/Ek9nSHw2SU8TH7va7IzxJC706
         RjRQ==
X-Gm-Message-State: ACrzQf2wB2V8Uz9sIjVK9CtOQRVnumNOiS1o8QSJPwr8U79p4lQW85AS
        MGSEsjGBrYNY15CcW2Of9fM4TcDPFUGiCQ==
X-Google-Smtp-Source: AMsMyM66UWCoXKlWZA5KlqOnrOC3I8fPJ521sMLQe1x9H7Gou/ITU+qErW3aNWFN57A4Nm1yPd07hA==
X-Received: by 2002:a7b:c01a:0:b0:3b4:a61c:52d1 with SMTP id c26-20020a7bc01a000000b003b4a61c52d1mr5653232wmb.146.1664537301215;
        Fri, 30 Sep 2022 04:28:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/15] run-command tests: use "return", not "exit"
Date:   Fri, 30 Sep 2022 13:28:02 +0200
Message-Id: <patch-05.15-4ebbf6207fe-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "run-command" test helper to "return" instead of calling
"exit", see 338abb0f045 (builtins + test helpers: use return instead of exit() in cmd_*, 2021-06-08)

Because we'd previously gotten past the SANITIZE=leak check by using
exit() here we need to move to "goto cleanup" pattern. See
fdc8f79f1f1 (leak tests: run various "test-tool" tests in t00*.sh
SANITIZE=leak, 2021-10-12) for prior art. for when this code was opted
into the "linux-leaks" job.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-run-command.c | 44 +++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 390fa4fb724..ebda2203408 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -381,13 +381,14 @@ int cmd__run_command(int argc, const char **argv)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
 	int jobs;
+	int ret;
 
 	if (argc > 1 && !strcmp(argv[1], "testsuite"))
-		exit(testsuite(argc - 1, argv + 1));
+		return testsuite(argc - 1, argv + 1);
 	if (!strcmp(argv[1], "inherited-handle"))
-		exit(inherit_handle(argv[0]));
+		return inherit_handle(argv[0]);
 	if (!strcmp(argv[1], "inherited-handle-child"))
-		exit(inherit_handle_child());
+		return inherit_handle_child();
 
 	if (argc >= 2 && !strcmp(argv[1], "quote-stress-test"))
 		return !!quote_stress_test(argc - 1, argv + 1);
@@ -404,18 +405,24 @@ int cmd__run_command(int argc, const char **argv)
 		argv += 2;
 		argc -= 2;
 	}
-	if (argc < 3)
-		return 1;
+	if (argc < 3) {
+		ret = 1;
+		goto cleanup;
+	}
 	strvec_pushv(&proc.args, (const char **)argv + 2);
 
 	if (!strcmp(argv[1], "start-command-ENOENT")) {
-		if (start_command(&proc) < 0 && errno == ENOENT)
-			return 0;
+		if (start_command(&proc) < 0 && errno == ENOENT) {
+			ret = 0;
+			goto cleanup;
+		}
 		fprintf(stderr, "FAIL %s\n", argv[1]);
 		return 1;
 	}
-	if (!strcmp(argv[1], "run-command"))
-		exit(run_command(&proc));
+	if (!strcmp(argv[1], "run-command")) {
+		ret = run_command(&proc);
+		goto cleanup;
+	}
 
 	if (!strcmp(argv[1], "--ungroup")) {
 		argv += 1;
@@ -428,16 +435,21 @@ int cmd__run_command(int argc, const char **argv)
 	strvec_pushv(&proc.args, (const char **)argv + 3);
 
 	if (!strcmp(argv[1], "run-command-parallel")) {
-		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, NULL, &proc));
+		run_processes_parallel(jobs, parallel_next, NULL, NULL,
+				       &proc);
 	} else if (!strcmp(argv[1], "run-command-abort")) {
-		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, task_finished, &proc));
+		run_processes_parallel(jobs, parallel_next, NULL,
+				       task_finished, &proc);
 	} else if (!strcmp(argv[1], "run-command-no-jobs")) {
-		exit(run_processes_parallel(jobs, no_job,
-					    NULL, task_finished, &proc));
+		run_processes_parallel(jobs, no_job, NULL, task_finished,
+				       &proc);
 	} else {
+		ret = 1;
 		fprintf(stderr, "check usage\n");
-		return 1;
+		goto cleanup;
 	}
+	ret = 0;
+cleanup:
+	child_process_clear(&proc);
+	return ret;
 }
-- 
2.38.0.rc2.935.g6b421ae1592

