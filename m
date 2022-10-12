Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418C7C43219
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJLVDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJLVD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A11BF1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j7so27970174wrr.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMJ0ei29o3W92b760+HvZkT6k/ZhX31NK+F7yQCZdt4=;
        b=MSK0PC8M8p/SjZJ7f2OXgT5TeM9ZPAVWeXgSN6ZMywDduQ8O9CAZEGHJnTk8cWZm1Y
         vz9+Cu8BqBi1znltPje1eF9Vhkq2QHHOXOXfEyCG/Aijp3vgbOtXv/5PQPc+QpgV0vzo
         2RsQeCY66f1lXDsdVwCxbsEssXIl+8ajq5vkDjBeysLnwgHf60vghWbUnmAncDR+Ec/t
         cL5VW2dSc2WFSDW8lMIGw4BlW3K3wnr0lHQGDce3wzqcKsdIhTgrWHmIWTneXlPujdqO
         JdRxqiOHFlBYjjmqqMCVH2vpnIcRd1JbEvXBe+XVTrkoHu3T9bW0fpMrtP3tg8dYYKt5
         2reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMJ0ei29o3W92b760+HvZkT6k/ZhX31NK+F7yQCZdt4=;
        b=BsRWPivDjOPmG0FS1i6bHgkfeR6NmPazBgenjro/7rc2NAUZzWQIvSgFyyeordrDUS
         MJkyDB/PI7WZ+0FaP+Fy+Rb2p+v2v+iWKwvDC8O2Hu+kRUWV9wQsMRUdWoYHjsP2P2Po
         iZJdKTrtREC/MAMg+eOJScbxFZXjH9GxSGUKOfnb1Os9NFHchjX9XsQFeCDzj4ehGKpB
         L2SvRpIVzhjAzRU3EL+UCb5IALN1xeVJgIPM/KOW0QKEyH2v5rHDMZOgK5G3VpHdF8UL
         lWwNkP1NRSYfThIOEkXn03Z6xHXXgvCCxrYqvJibw8ZgZ1ac9h0PjgYMFUannBE0t5Ww
         5vRw==
X-Gm-Message-State: ACrzQf1h9VSXB8hkpaaMoFW8pSLXxahNVOefJThlLQnI3qfOQzeJHHmn
        q/+kxDKd6Vu+uaEbpMML3p0yFHSdIE7DXg==
X-Google-Smtp-Source: AMsMyM5aDAJIv0NivZUSl6IVJgEuyVST6ZMXnZ1IcgIHEjWqaDNytoThlITYig6wqE4A/hnUYI8YWg==
X-Received: by 2002:adf:ef43:0:b0:22d:c507:dd48 with SMTP id c3-20020adfef43000000b0022dc507dd48mr19383034wrp.416.1665608603682;
        Wed, 12 Oct 2022 14:03:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/15] run-command tests: use "return", not "exit"
Date:   Wed, 12 Oct 2022 23:02:22 +0200
Message-Id: <patch-v3-03.15-4a19de65783-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "run-command" test helper to "return" instead of calling
"exit", see 338abb0f045 (builtins + test helpers: use return instead
of exit() in cmd_*, 2021-06-08)

Because we'd previously gotten past the SANITIZE=leak check by using
exit() here we need to move to "goto cleanup" pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-run-command.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 30c474f3243..ee509aefa2f 100644
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
@@ -436,8 +443,12 @@ int cmd__run_command(int argc, const char **argv)
 		run_processes_parallel(jobs, no_job, NULL, task_finished,
 				       &proc);
 	} else {
+		ret = 1;
 		fprintf(stderr, "check usage\n");
-		return 1;
+		goto cleanup;
 	}
-	exit(0);
+	ret = 0;
+cleanup:
+	child_process_clear(&proc);
+	return ret;
 }
-- 
2.38.0.971.ge79ff6d20e7

