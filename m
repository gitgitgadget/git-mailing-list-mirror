Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC6CC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJLJB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiJLJBq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:01:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A51B8C0A
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bk15so25216800wrb.13
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23xuod5QxoIsDEcWCtQPm2IgVMfSQsPd7mQgv/Z9E1M=;
        b=f/9tYqYOKHiwkp+7+6teSZndk7N91LaySXfkbCUzmYfebg+YYbeKQNjbtVXSOpNxEW
         Lc4ZiVDz0SZaCG9jaBx6hkFqXN2qKknnR7+h0hf57+9XN13DHXQGEKsHC3js3h6U3iIo
         wZz74fWglYGLVSCtQoooCWXX2GLu9lv9wZmqO3Zd0Mozi6xP1ic4ugBMb773l1Q5CIVE
         0tdX6OBIVx+d/9DUEysiq6KUWteYY+1OgdfQ/rs5KEMoR5y3ijcCA1t65yu7MH3V/TZ5
         qkQxZ/6TXW5JqyPVZMVy6UHJrAI8i55iGF4AZznTLmpFXj5kb2DzKiIYjSDuXpmdDxSL
         o9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23xuod5QxoIsDEcWCtQPm2IgVMfSQsPd7mQgv/Z9E1M=;
        b=d66pihe5fvTq2jyNkdc2kC3HXuab6PqUSu1iMSoQ4YvNIrX2r3xz+x92Rf+Rou5ebZ
         tmE5mxrr+XJDTsqGQGj75D/zM9gEB4Ydlj/wk0EgJTcZC//Wdu1Vs4N0p5Lg9pBSV4Ib
         ijlDQhG1L/NeAqg99Ucy8F958+181Vjw+tVTY83tKo+TCHZPxLdxYmtGc3XpJ3ApmGql
         65J5uWvSSPSGy3AcON4POkQ/tQ2YjmAg7rpClNe//prDJuVxJprsjn3+Cgjj3+PoCbia
         e4PGuC8ph1WnMIJWZOr1Yx7DeEBFhp0Li31/xQINji/W6R3qJUCFooYz6AEUTK+q2MsA
         MZPQ==
X-Gm-Message-State: ACrzQf3nqtvjltPELkpQXgAEusj3zKBjg1tkLbqcBKiB3gUuw4LSS54T
        vf3JLTePkRf2ZJjLRqu01NXgjPHDqN3slg==
X-Google-Smtp-Source: AMsMyM7BW+32vjW0L0ZJSJ4bEWjkPgMbbv5qzGHtKd3Wr1WMFrW+i/wZFCn3JUsbvzNv0GWCCzpAeQ==
X-Received: by 2002:adf:dbc5:0:b0:22c:c605:3b81 with SMTP id e5-20020adfdbc5000000b0022cc6053b81mr17244279wrj.218.1665565300753;
        Wed, 12 Oct 2022 02:01:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/22] run-command test helper: use "else if" pattern
Date:   Wed, 12 Oct 2022 11:01:12 +0200
Message-Id: <patch-v2-04.22-26e28086252-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
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

