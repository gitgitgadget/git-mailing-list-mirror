Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD81C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C95F221EB
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0mdkj4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgIKRtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgIKRtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 13:49:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDDEC061757
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 10:49:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so12298546wrn.6
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5lURrJo2phQFyTaCa9VzL15Edu5uwyU3aVspJO/+d8Q=;
        b=S0mdkj4icxI/IlHI3SoKrFpcSKZafuE87/Rrr85kmWGuENq6tCxGyoXDZF0Xx3a50L
         LCOHfU8EGN52rDlabB1FiB2Q9Ftko2vpGi3upchbgg/jQEEWZwZed/ygvzlzKzWsXYqI
         zLuIHtQc6L4uot6yZZcuI1LEUlcr9u1929/LwES02frqGrFz4kj9NlWitM6x13GqjeTG
         SVapSO4d9qBrSEiJULHHmz5IkTRXb5N3mtVMgc5UxihADBVn7I1FbLkdt0e0mKziTkci
         NSwnqeACykktpkpHqNrDomLLa0EekrFFJW6g9uSif2qAqdF1tgMus9lFZvVffJIXHOWR
         9VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5lURrJo2phQFyTaCa9VzL15Edu5uwyU3aVspJO/+d8Q=;
        b=I1wE8zi5asgNV0M6Q/HeYIpnAHaj6lj6I7kQah1lUx5+N6aPxWm0AQ4p4Aiatg1/XV
         kk0fVRyQE+t6oH4fAROMPKv8UCZZJox2/xR+tDB5j6crCNB/j98APVPBcb3x3fsiiQhP
         SWlUXZthoojh+5UoUxIuRbTKzGe9UpuUqUj2XP33d+lzSII8hzKLSopyO3TxuXIZMO/d
         MCjTq4fMN2HVFxsY68C3LQf8ktGnV2kvntiNMwFWItBUxCQzsCAFtM5xKUlKyo/GHBib
         x0QKNidZc1rVAuU+hIjs/V5agrCQ/FaXoZ06/7n/w6QaS7LjQI8LoMR8puNKgoplz7Nz
         oUYg==
X-Gm-Message-State: AOAM531p3VRp1CUT1prmSiACSbtbK3greKNHRZyGrWDo6xaxLcYOWUKn
        kgL+BPYKQh+NYay6u+4fFjvpF0+lupM=
X-Google-Smtp-Source: ABdhPJwI01Y6I3aGwIvcgEHhn8bo8qIlvn3RpVDo6NeMcXHktNPvhKs6QyiYWUulvxgwYyco0mb7Qg==
X-Received: by 2002:adf:ab57:: with SMTP id r23mr3254688wrc.386.1599846563179;
        Fri, 11 Sep 2020 10:49:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm5793528wrv.86.2020.09.11.10.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:49:22 -0700 (PDT)
Message-Id: <b21cd68c905904914224960145999ab2017235b9.1599846560.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
        <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 17:49:14 +0000
Subject: [PATCH v2 1/7] maintenance: optionally skip --auto process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
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

