Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAACFC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJLJCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJLJCI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4860273308
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u10so25265161wrq.2
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMJ0ei29o3W92b760+HvZkT6k/ZhX31NK+F7yQCZdt4=;
        b=pMPwnSIPSehnr7teV5g6COSm71kTnvhlFvNrMJzCZmYXm2wMX5gR8qNd1uKQ3h2iMC
         uaRXOGW3AibF5YwBcI5TPIXJB4tBYIuBgsUocPTBAq2VZSDePWBOLjpJXo2Efg9kTF5L
         uh7NzUM5lL1G8GKn5Dgf7Ew8r5Eu0AlEriPbBKCX9z6rlB6tCcdqthcSUxqkEuEpeIXR
         1SPilxGr7n6IzGZVYAOwauI736yojYUKaaM/Ss+qaW7SAr1HIxMDDkbXC/Zh0YVXT2UG
         SrrMHo6djZx8H9RKQp6I6lIR7US9mYAsAptpfJm3QyVBKLuhLsXt+oLBLmgsXJnnH61p
         m6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMJ0ei29o3W92b760+HvZkT6k/ZhX31NK+F7yQCZdt4=;
        b=SGzUSMehgZ2UiDhXYbdePOw/aQFRTmVnaRKiGhIbyf60hznQlB8ccAErdDNYTHqT4F
         0ymjLY2u8jdlLQVVc+Y96Qx0Na+nC1TA6gqaMjlc4ZSX4pzKlFd+osKaoT6wkL/7iWr4
         W9f0rD5myb0QEHXubdg8ETQS6glsIVcev95TgfTOhNkdjDeDhqtKiEGuTRwRyWIbbs+s
         RCTK9WhL80h6GVf3LWwFcltA/bQO2fl3cGnaJEHK+00Z/byGzdekdZEUdABeOH8wwdPo
         syv4j2w6DzuELv5FL/FdvBNcaas6jkY5gj3/suLthUOZJUWsa2+e1yTAfNQm8ruc2lXY
         z3FQ==
X-Gm-Message-State: ACrzQf32j4IzU8lIqAs/Ct2hFDPKD/eRhgigRUS75kvgVmPjhVrJf/fe
        42qdVjwkxZEXXHrBP80SvkNqFsBywQtaHA==
X-Google-Smtp-Source: AMsMyM5qRGxoACb8UU0ZguBU1MOUrl3g7G0dWCIHMeh5gSTe8TUMBTbpZdaD30p1nOiBJERY+hNxmA==
X-Received: by 2002:adf:efc5:0:b0:22e:4a6:2d5b with SMTP id i5-20020adfefc5000000b0022e04a62d5bmr17879037wrp.293.1665565303966;
        Wed, 12 Oct 2022 02:01:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/22] run-command tests: use "return", not "exit"
Date:   Wed, 12 Oct 2022 11:01:14 +0200
Message-Id: <patch-v2-06.22-e4e91dbbf9e-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
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

