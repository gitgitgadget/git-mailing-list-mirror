Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA4AC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED062071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyUeLqRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHYSkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHYSkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:40:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77D6C061755
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so13838926wrl.4
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5lURrJo2phQFyTaCa9VzL15Edu5uwyU3aVspJO/+d8Q=;
        b=IyUeLqRzNxy08lQGHSiYrY/oykI2rKIKiWeApAdD7YzlwENc9tFNTed8jQeB+mijpZ
         qQDPjVting8zlQH5NbL4M/COmn5BIXxF2dcqTzqGmxau1atVd11W1GmSU/IF2EfPr2Ln
         WLcHi+BwAR11jbHqyNj5KdciZluxTh10kYmw5C0Tm8oIYrQx36Mk2zIShBD9h+UG6oza
         QhGzHcXIKqnfGesz/bDN5b5gvJbL4iN2P7bCauGV1qAeDBQsozl0IoZPoqtyliOQfzxE
         AhvSlWJjfxUwBZF/eAfzvPr4RfzOVpsiNA12x0yGRTYMs6ddoCIFD+X27id2cIITmQ8u
         iJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5lURrJo2phQFyTaCa9VzL15Edu5uwyU3aVspJO/+d8Q=;
        b=RbKtnK4eCiElCaRk1QPEgNB9+WyxnFUvvL8ItylX6c9UzB7M3faH6qFsBx79+5KuVy
         NkW+D2gieJVm3/LSDS13gamNnnmPR6snLssLfFkyjjuIGm25olxdbzC29rbhqVIMlWL7
         XHI50Nzp9pNn8ADDYMnaTX2hfSrJI14RBitYBoVjfshIYJz2VH3LeNuVhkpzxWXEMVVO
         rooERC+nlG3ggqGvV2epGZmR6HhU6RUvLZF7LQRaS2MhEj8NMsARh7vnZ1/S0dnjSmno
         sQFWVAl3zCCp7jTggUcju5kn3a/FpHwN2Gbk2BTC/Jj2qXhnKVwvbm1gOSoKbfkDXIoW
         7pWA==
X-Gm-Message-State: AOAM531XXDuNz5USnvBp8AlGO2v0b1sqjIumPltxBQWhoiOzi8AFqa/M
        LNfxbvMgfV0wSM+kJRv/Owh0jwHMaOg=
X-Google-Smtp-Source: ABdhPJxV/zLJ3mmoZFyHwzGEZXYCD/2EE2QlHgxH/t/QppCyC4g1t/31HcUMr3Lgxj/DxBJeb7CBAQ==
X-Received: by 2002:adf:c182:: with SMTP id x2mr375124wre.400.1598380807024;
        Tue, 25 Aug 2020 11:40:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n21sm7138855wmc.11.2020.08.25.11.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:40:06 -0700 (PDT)
Message-Id: <5fdd8188b1d9b6efc2803b557b3ba344e184d22e.1598380805.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
        <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:39:58 +0000
Subject: [PATCH v2 1/7] maintenance: optionally skip --auto process
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

