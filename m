Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB77C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B490E207BC
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTvPPHmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgJENE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgJENEK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 09:04:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D8DC0613B1
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:57:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 13so8512569wmf.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i23re7jsKeggERrBXtJjshBZV8NteQPTfOTlXWmSBic=;
        b=NTvPPHmmpRxX7aWhgH1sUI2QgK8hzK57FqAW0XKteFf30MgL2oGVSvRG1GUge2j5f/
         h3j9QBod64tbp+SzeyhIeJg7HQW1/mqmdsuMuPJM4KpMnyqnGrfMHhUR6LGJwyRA3LSI
         XO+Dl36LeBCfxu4F1MptXNMvW7YqGCpsyJzj0iHgX4uScErEQWhb9SV6ZnIukEJwE0A/
         tj+eWxN5wv220jGxNBNRgFDwSAqohjugPeDAb+FQk7LLAyqlacZE7vdpLJEuy575ZKFk
         0LNgnNoU0/wYjivyTLkAi8yQc6Up4+6ODEkFf3rHfSXeXM6jiJArY37ClSdBhkyatxs1
         LVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i23re7jsKeggERrBXtJjshBZV8NteQPTfOTlXWmSBic=;
        b=pzH4K+BB2S0PmIVoI+ymEDMDUDJKPOtfa6jgEQUiamt3PhmLIpO7cOd/ABe5HQ2Mkn
         MpcSRyxfNO12wGUl41pWbEjoSpKnq9PI5J8j2+FPV9FryeVnbUn1iZQOa0Y7iEgdOZrg
         +3J45dStOTdj1nEPGHREP16JjkJApTufoKzbEu7maSAcxoC6noAqKc255sTGM9g8CtT6
         m689+hJh5wnMBNFI07ObNKZBY/rBk86rRmhBqKuqAKIevHgG8/q83pQmGTzQF5T6Ac8H
         Ix3PeRGQuv2MQJvu4pLtYGd+BTUBb8u6weuZC21tCGJbnVNd9WQM5TsD6Rlbt+s6rew9
         zR3A==
X-Gm-Message-State: AOAM5303ZcA1YrzwKdJ4K1MdO+I/W1zHMDafrYwDWkwAf4DaIlnQ25W1
        vH3lMayNpWq4NI6/0Zk9AmbZy6uCSWA=
X-Google-Smtp-Source: ABdhPJzo+XQUkWYvy6FNmPbd8jVQ5LNsu8a+XEkNpyuXKAfhBZ0ErH0r8CC9MfafFxOYc8OaOObnNg==
X-Received: by 2002:a1c:dd0b:: with SMTP id u11mr16703577wmg.186.1601902637307;
        Mon, 05 Oct 2020 05:57:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d30sm6081569wrc.19.2020.10.05.05.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:57:16 -0700 (PDT)
Message-Id: <02e7286dba906f6cd729537d1f22e98ba4154c55.1601902635.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
References: <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
        <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Oct 2020 12:57:08 +0000
Subject: [PATCH v3 1/7] maintenance: optionally skip --auto process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Some commands run 'git maintenance run --auto --[no-]quiet' after doing
their normal work, as a way to keep repositories clean as they are used.
Currently, users who do not want this maintenance to occur would set the
'gc.auto' config option to 0 to avoid the 'gc' task from running.
However, this does not stop the extra process invocation. On Windows,
this extra process invocation can be more expensive than necessary.

Allow users to drop this extra process by setting 'maintenance.auto' to
'false'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/maintenance.txt |  5 +++++
 run-command.c                        |  6 ++++++
 t/t7900-maintenance.sh               | 13 +++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index a0706d8f09..06db758172 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -1,3 +1,8 @@
+maintenance.auto::
+	This boolean config option controls whether some commands run
+	`git maintenance run --auto` after doing their normal work. Defaults
+	to true.
+
 maintenance.<task>.enabled::
 	This boolean config option controls whether the maintenance task
 	with name `<task>` is run when no `--task` option is specified to
diff --git a/run-command.c b/run-command.c
index 2ee59acdc8..ea4d0fb4b1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "quote.h"
+#include "config.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -1868,8 +1869,13 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 
 int run_auto_maintenance(int quiet)
 {
+	int enabled;
 	struct child_process maint = CHILD_PROCESS_INIT;
 
+	if (!git_config_get_bool("maintenance.auto", &enabled) &&
+	    !enabled)
+		return 0;
+
 	maint.git_cmd = 1;
 	strvec_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
 	strvec_push(&maint.args, quiet ? "--quiet" : "--no-quiet");
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 55116c2f04..c7caaa7a55 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -28,6 +28,19 @@ test_expect_success 'run [--auto|--quiet]' '
 	test_subcommand git gc --no-quiet <run-no-quiet.txt
 '
 
+test_expect_success 'maintenance.auto config option' '
+	GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
+	test_subcommand git maintenance run --auto --quiet <default &&
+	GIT_TRACE2_EVENT="$(pwd)/true" \
+		git -c maintenance.auto=true \
+		commit --quiet --allow-empty -m 2 &&
+	test_subcommand git maintenance run --auto --quiet  <true &&
+	GIT_TRACE2_EVENT="$(pwd)/false" \
+		git -c maintenance.auto=false \
+		commit --quiet --allow-empty -m 3 &&
+	test_subcommand ! git maintenance run --auto --quiet  <false
+'
+
 test_expect_success 'maintenance.<task>.enabled' '
 	git config maintenance.gc.enabled false &&
 	git config maintenance.commit-graph.enabled true &&
-- 
gitgitgadget

