Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C6BC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJLVD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJLVDY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD92195
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay36so11131301wmb.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23xuod5QxoIsDEcWCtQPm2IgVMfSQsPd7mQgv/Z9E1M=;
        b=diUADpYE46oF+ntgrcTNUE05zrVLwNEDaW7eP9e2qTQQKkwzzPQJ3/EDhT5eQsnT0I
         Gp06CcRkYwsvSuSWQXSjqam5tUlZIWfVcJRcJt34B9a1RMyftFRVPHTH9ir6PnXzdIUj
         lF9WB3l+MnPAZYxIVGf1Q7be3ickPjKzUAU9SyXdI0nHI7XcmsHo9llTJJ41M2s+3UXR
         MevIXdfxEVqhbu3X3BFrOXQD6RfWKeOWMMaRR2HcC1l/q78FMeq5XL7h+S2f0a1B61qz
         0JHzm4wdUAbho7ZTAXbHLi7g22kd4cDH6n2/0sOvjH0IqfK/LqHLRpmC1cnMpSj6GUpL
         6Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23xuod5QxoIsDEcWCtQPm2IgVMfSQsPd7mQgv/Z9E1M=;
        b=n6I8eaAoAlxUDZ5MbcolAR4L9J9umxIZ4tFezPbF24mA5I1qy6rIrqKnh1sK8mASqE
         KH5rZOD6DiVTIuavSxAfXVX69ufFM4379JxKAuLTWfgc2u3rY3hXNtQ08U7Cd9J23zO3
         JDuXXYuJn5XlUC16yAafrODm3LGu7YRBcN2/X9leatBcqI2s8Ibs0jazcLHgtyXKE22u
         XMs+OfbLRPTTbS5eBjUrpypvmm1PAarjUC5D88/HL6WyrZeFDFEEwXTizGkP/Xj1MCRF
         XUx4Kwds81OxUCByPMwflUDS6uWvarzXXNio/MgbKtqa+cN1hjfLU7E6MVb7NwsgyPzr
         4oFg==
X-Gm-Message-State: ACrzQf1fikw5k0/XBP9jLddaGBmsfGhug8kqBQ6lUomfmliGQe+3RIrH
        nZHSJIbCdNzo2uxvM/jyLDGzTUxOBPGeYQ==
X-Google-Smtp-Source: AMsMyM6q1FMQ7WML+4LhQTvIDKRpwQFyFcO1zW8iveGO4uOkZBzX+ICfacDUUFlJecwC7okB50S1DA==
X-Received: by 2002:a7b:c30a:0:b0:3c1:bf95:e17b with SMTP id k10-20020a7bc30a000000b003c1bf95e17bmr4184954wmj.31.1665608601548;
        Wed, 12 Oct 2022 14:03:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/15] run-command test helper: use "else if" pattern
Date:   Wed, 12 Oct 2022 23:02:20 +0200
Message-Id: <patch-v3-01.15-d3a2489d9b2-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the cmd__run_command() to use an "if/else if" chain rather than
mutually exclusive "if" statements. This non-functional change makes a
subsequent commit smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-run-command.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index c9283b47afa..390fa4fb724 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -427,18 +427,17 @@ int cmd__run_command(int argc, const char **argv)
 	strvec_clear(&proc.args);
 	strvec_pushv(&proc.args, (const char **)argv + 3);
 
-	if (!strcmp(argv[1], "run-command-parallel"))
+	if (!strcmp(argv[1], "run-command-parallel")) {
 		exit(run_processes_parallel(jobs, parallel_next,
 					    NULL, NULL, &proc));
-
-	if (!strcmp(argv[1], "run-command-abort"))
+	} else if (!strcmp(argv[1], "run-command-abort")) {
 		exit(run_processes_parallel(jobs, parallel_next,
 					    NULL, task_finished, &proc));
-
-	if (!strcmp(argv[1], "run-command-no-jobs"))
+	} else if (!strcmp(argv[1], "run-command-no-jobs")) {
 		exit(run_processes_parallel(jobs, no_job,
 					    NULL, task_finished, &proc));
-
-	fprintf(stderr, "check usage\n");
-	return 1;
+	} else {
+		fprintf(stderr, "check usage\n");
+		return 1;
+	}
 }
-- 
2.38.0.971.ge79ff6d20e7

