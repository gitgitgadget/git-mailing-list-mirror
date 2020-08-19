Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0BAC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FA220885
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sigo3c3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHSRRD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSRQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:16:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A4AC061383
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:16:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p14so2832502wmg.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XENtOmnJI6XILr8KzgGQwXoUMksy7K+nexUxsFsywUU=;
        b=Sigo3c3GLSxjTN+L9jBePeikh+jRmH4C5wT1wf9o5JMtbFhp/2ZypFbBzpiTwwIKCq
         ++8QNOpKzb9JES1XaD+DKjGeI6cBi3Uae5l98rV2/cs0+5vw+CYHcPSvdgK/JC8w9wPU
         DDQAJz6px18pOj4N7yvQ+9CGH8c5VqHbHqvD03BYnngywfb92cQS2jFxDP1H38Z2oi4G
         Dc6sZembki15c19gIXaSjBGnRPItg+fYEFs40BhzqabN0prjzK32CHAI8ZCUX7k05rN4
         ZS5yRjtq6C3FThD6Qz+9qvkT6jXFDosm6jee2+zS/ILyvJWZM8E/1WQa9GQef46gdrGJ
         guFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XENtOmnJI6XILr8KzgGQwXoUMksy7K+nexUxsFsywUU=;
        b=D3YVqaro19GtUAw39lMs41bQmmg93F1T7T6uMOlgTZ0kuuN5eLYYI+/qHoYYKURzbb
         dNBwEDW2dKqZUuRHLRgB9Z6AThmPefFghHOX0P1Q5E9JT9M5FFwt8NdZsze3E8DOZl2O
         0dK4/4V5PUxwUW1N3poXp2MOd74VFceLVtb2QUnQZG3pd4xwuGc7ny+XoEmtYya/EVX8
         cmUPIL/WSyr4JvLQU52mrAB+7tvK+ZZQdQvXJC/q7LAkk+YEUarSeURnnawCz2hqF/Hv
         Br9/KL4Ls6SBuCT+CfdlgG/NNZ0g+RcmzU+v9pnt2XgCsAd0ugNbJjxcH4W0J9xepCvT
         XD1g==
X-Gm-Message-State: AOAM533iKD5Pz98FtJz7VQp1VVV7lPq/nBH0CxLs05TIGB3WDdQAhQk4
        njRdbz5yGSc7juG6Vb1GRQcBkWLlwAY=
X-Google-Smtp-Source: ABdhPJysMYJWLNS6NlIxh/zCbKKN3SLeOhIf7Pk72i2VfSinAyf4JiqJWSf01L+CHeiPgkFvN0fH0A==
X-Received: by 2002:a1c:9942:: with SMTP id b63mr5502726wme.12.1597857415061;
        Wed, 19 Aug 2020 10:16:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c194sm6900765wme.8.2020.08.19.10.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 10:16:54 -0700 (PDT)
Message-Id: <90de25d1287595fdedc9dcd194a2e0ac120d4aad.1597857409.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.git.1597857408.gitgitgadget@gmail.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 17:16:42 +0000
Subject: [PATCH 1/7] maintenance: optionally skip --auto process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
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
 run-command.c                        |  8 ++++++++
 t/t7900-maintenance.sh               | 13 +++++++++++++
 3 files changed, 26 insertions(+)

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
index 2ee59acdc8..9c9d5d7f98 100644
--- a/run-command.c
+++ b/run-command.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "quote.h"
+#include "config.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -1868,8 +1869,15 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 
 int run_auto_maintenance(int quiet)
 {
+	int enabled;
 	struct child_process maint = CHILD_PROCESS_INIT;
 
+	if (!git_config_get_bool("maintenance.auto", &enabled) &&
+	    !enabled) {
+		    fprintf(stderr, "enabled: %d\n", enabled);
+		return 0;
+	    }
+
 	maint.git_cmd = 1;
 	strvec_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
 	strvec_push(&maint.args, quiet ? "--quiet" : "--no-quiet");
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 6f878b0141..e0ba19e1ff 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -26,6 +26,19 @@ test_expect_success 'run [--auto|--quiet]' '
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

