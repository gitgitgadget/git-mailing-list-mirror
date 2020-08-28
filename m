Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD89C2BB4D
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304732073A
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uinY7JYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgH1Ppo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbgH1PpY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 11:45:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79CC061233
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:45:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so1725759wrl.4
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5lURrJo2phQFyTaCa9VzL15Edu5uwyU3aVspJO/+d8Q=;
        b=uinY7JYbaY5qhsJzxeD53kTjWzC4RQ5JhFQPuoEWRCZWaO/JrfKvo+K4jNGhtAyFz8
         opuJsXlBVAuBEpNhO+HQlUlyWRuP7Gxn1ZE1CxyNDpv7uzVe/VVGTdqPzH5jRiZ6jyIZ
         ogbfEMqh+epX0raXZwRJgboD8YLD5+Vu+VirZLxFS+F3DrAu1FFkpKunA1fDN1uwDnIb
         2jg/TOA52uQsRmjEh87mxzsOgiJS8WNUFt5IudULJHmwSdK+j6UM0xLved7b5EPVGGFj
         QYNdpwkroary8IipZDZa507zN+fyceFji0UAjJhOMnSguEbnvHnITQjsK/72778UwPBX
         Pzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5lURrJo2phQFyTaCa9VzL15Edu5uwyU3aVspJO/+d8Q=;
        b=lHOvy/oW86QqDPctpUaPNNRrv53qkp7hSFAVtxZNdII0yc3y3xfXQA4lh7mbdZs/bs
         ciKdVbvOKAXbNbr0J19ufaoH6WpwCanbIE23atz9bD1yG5OBc50e9zQ2E5q7aNPkDl5C
         3o6SsrmnQqO8jEkXZWi6asMoGc9AG6pBPzUpOC5IC+EvaWIQm+/CYqsFHw7k2DdsXoMu
         xhnXVXF3I0+NtQpoYrC02bUhrw2m5LWk6hJzcGu+zGHubSZDF8dN7DanrJcxG2Zirtr3
         k277jZand4uXq11hZ5unzZYm4KrbONqHos2aDacevk+zutblHdZ4eMm8QplDthFSdB3y
         nLAg==
X-Gm-Message-State: AOAM533XYvT6f+lDZatvW99q/AO3/CJEPZ83X0DN5y/2HDyU7lX7FG1p
        L57NQNF9JfHFv6M7k5QNdF1Oc+61BtA=
X-Google-Smtp-Source: ABdhPJwWLAgN4fY2Il0NiBbHmUW5w4n07FynN/a2NjyuTyPKKC+ztHDnNMyJ5uBNXVfldCkQhV3k5g==
X-Received: by 2002:adf:b602:: with SMTP id f2mr2010860wre.186.1598629519588;
        Fri, 28 Aug 2020 08:45:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm2820854wmh.15.2020.08.28.08.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:45:19 -0700 (PDT)
Message-Id: <5fdd8188b1d9b6efc2803b557b3ba344e184d22e.1598629517.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.v3.git.1598629517.gitgitgadget@gmail.com>
References: <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
        <pull.680.v3.git.1598629517.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Aug 2020 15:45:12 +0000
Subject: [PATCH v3 1/6] maintenance: optionally skip --auto process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
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

