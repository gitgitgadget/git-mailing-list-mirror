Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96B7C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 20:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242222AbiERUFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 16:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiERUFd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 16:05:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DF02375DB
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso3823767wma.0
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9GHGCuef0MIhLayTjOT1f61qHmpj35gpO2QY+Eq3Fw=;
        b=oE1Pe0q35UX6/zR1xecstaoc2EO3Y8WF6cOnzOPR9/FU5mJuRj8sYmg2/nDzSBo5vy
         8HHMPWQ/CXjiSW3GIciwNeMKuFrSUWQoS5mLHK8p41vGYnNKv6cVPa/t2FTYDQEZHpHx
         dwY4Tm1SXVKhGCjf47MTu+kU1LrLq2gTmxOsQf8cTzp05N17r3VPhytiqUSC3DGv5Hl2
         UBSfRz2zPIp9+Nx3EwkUrY6+1Lno1ZEsbWvtnfrajOPvahTD6ZilrZsl3z5wPGYCFvmb
         3gNvVCrxcIq9yFeqFmCCGkmCwGFX9kiGOROoRj7RFgXPX8+eTlvRImnj+SMwre10slS7
         daiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9GHGCuef0MIhLayTjOT1f61qHmpj35gpO2QY+Eq3Fw=;
        b=pUYtRGWBGvme2VlywWRm/FrKqUo2RrKRAWUOHRQMF0PwWEYnerV+rO8quWVzkmdDwj
         lI5CbblyEoFVXakB6bftpwiEMgPxMSdN9yVf6ZwToB5ZKtH/IXhNrNCo9VzjlK3+Oyc3
         fR4z/PDf/VpJ66Q3EVhTQoQ9CVGrmH70hTHUOpgQCW+PVB4+RyJcx8xiEHTaNZKzRz9I
         3SzteMvEr8h+RnC8OEg4l1dTGVPg3zlVn2NcxOYvTXra9hAtvPqZi8ZrcQFCALR+Z/S9
         VLVeLBQk3geu/J8+6F6ZzJzGKV5Rgm3ptPYaiOWp8eP51OeUbTUj1TFpUPV+N7Q4+AYQ
         CX4g==
X-Gm-Message-State: AOAM531GEKYKPr5+ur/xmfriR/RNGuOUXLqIH8UM/VwEPsnR6T/C7KWH
        EY/i5yjCPPCWdmu5QtPK9Hxx4GOPB/gSNw==
X-Google-Smtp-Source: ABdhPJyc/Q+6KDBjRMU1pdFikJ7gX66uxko7nsFwaTyJoNqHlTMNzD9pNDUp18kVKKJIdbRbZDFvCA==
X-Received: by 2002:a05:600c:4e13:b0:394:797e:3358 with SMTP id b19-20020a05600c4e1300b00394797e3358mr1403858wmq.30.1652904330052;
        Wed, 18 May 2022 13:05:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b0020d00174eabsm2674441wre.94.2022.05.18.13.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:05:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/8] run-command tests: change if/if/... to if/else if/else
Date:   Wed, 18 May 2022 22:05:17 +0200
Message-Id: <patch-v2-1.8-26a81eff267-20220518T195858Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.952.g0ae626f6cd7
In-Reply-To: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the code in cmd__run_command() to make a subsequent changes
smaller by reducing duplication.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-run-command.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index f3b90aa834a..bd98dd9624b 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -371,6 +371,8 @@ int cmd__run_command(int argc, const char **argv)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
 	int jobs;
+	get_next_task_fn next_fn = NULL;
+	task_finished_fn finished_fn = NULL;
 
 	if (argc > 1 && !strcmp(argv[1], "testsuite"))
 		exit(testsuite(argc - 1, argv + 1));
@@ -411,18 +413,18 @@ int cmd__run_command(int argc, const char **argv)
 	strvec_clear(&proc.args);
 	strvec_pushv(&proc.args, (const char **)argv + 3);
 
-	if (!strcmp(argv[1], "run-command-parallel"))
-		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, NULL, &proc));
-
-	if (!strcmp(argv[1], "run-command-abort"))
-		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, task_finished, &proc));
-
-	if (!strcmp(argv[1], "run-command-no-jobs"))
-		exit(run_processes_parallel(jobs, no_job,
-					    NULL, task_finished, &proc));
+	if (!strcmp(argv[1], "run-command-parallel")) {
+		next_fn = parallel_next;
+	} else if (!strcmp(argv[1], "run-command-abort")) {
+		next_fn = parallel_next;
+		finished_fn = task_finished;
+	} else if (!strcmp(argv[1], "run-command-no-jobs")) {
+		next_fn = no_job;
+		finished_fn = task_finished;
+	} else {
+		fprintf(stderr, "check usage\n");
+		return 1;
+	}
 
-	fprintf(stderr, "check usage\n");
-	return 1;
+	exit(run_processes_parallel(jobs, next_fn, NULL, finished_fn, &proc));
 }
-- 
2.36.1.952.g0ae626f6cd7

