Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D2AC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF56D22254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rje8NCJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404907AbgJORWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390565AbgJORWH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:22:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC77C0613D2
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:07 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q5so4675481wmq.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i23re7jsKeggERrBXtJjshBZV8NteQPTfOTlXWmSBic=;
        b=rje8NCJ4nJTefjAe3yTDkoFuyZC7RinEzv9+FxQh7Z+P7sBQAyTngfmS8Hp75U14YJ
         pLkXN37QcdnDbEE6XZHg5MyekQ24H2FajZojv8X1+3lw2lug01dMGpBaR7rBuN/WrgUo
         KcvJGz/z9sSi4rPgePI0f1paBBTu73YX5QBCIUVRxeaYd4i2pRrr0pWd830usfRqRtHJ
         1hMlkcBcCw4ia7kjRrf+/akRKqWRRzz6rQiG10v8FKhrYenTOFBJVKbRMGpf9T5QzQJz
         eXx4LKjTo2mBG4fibbSfJeam0vW9h9DDwtk3QT1IpU98Byjz6pArlrUj8hS3dbGgfFgn
         pn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i23re7jsKeggERrBXtJjshBZV8NteQPTfOTlXWmSBic=;
        b=kjRhoUgSCd4//x7s50C5EiVOJZlF3sMfTLGje3t8InqaK9phEuE/Ggx+itBnuuOri+
         911egWa2pg3SjmKk50lczEkxUERWE3s2X1f4OqDxrtS/Y6JhNtJjOVJrXVtwyMkytC46
         n9s1tiE4E8cEqv1WocjICOwqADD3PNccigG16fCnHS0cbfWumAgonpR9GZKj8aYDWD5L
         KWOqZKcanicPpEr2pavYsbl15b4+Mwl2B9D661nYUy0aVZgCq/NRdY3Nm2B0TnZ3himM
         1zH6JlitpefunVXkoA9WZLF8Jg3fsvJrtYCEHsGsJbKd+1tViOGrW5kaWSriLZzire+3
         S63g==
X-Gm-Message-State: AOAM5308sxLHCmQpgY7nFuhzn1S9Oe8zF0ld16tJuhTGoIMHUmXxBFwb
        Bh69f28u0DLhSrQar20lrf4qdguYqwY=
X-Google-Smtp-Source: ABdhPJyEJVu6QdeYJ+UK1Ppxhhq0zUqDhQi8nxZvTw1GJPHcEHf0s01QcBEgrrifhm0q4qhymnKbRw==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr5037982wmj.109.1602782526119;
        Thu, 15 Oct 2020 10:22:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4sm6136944wrv.11.2020.10.15.10.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:22:05 -0700 (PDT)
Message-Id: <02e7286dba906f6cd729537d1f22e98ba4154c55.1602782524.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
        <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 17:21:57 +0000
Subject: [PATCH v4 1/8] maintenance: optionally skip --auto process
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
        <congdanhqx@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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

