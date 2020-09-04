Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4095C43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0AD2206F2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ra0eBoqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgIDNKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbgIDNJo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 09:09:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A561C06125F
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 06:09:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so6674222wrm.9
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vM0TuBEUY0vrapOf9Ut/0RUxanAqe66yuP0tCUJZssI=;
        b=ra0eBoqDvpwpl4l0/WutvwI/Co4gIEAl+omM2rqmUZorvLAg8Cyii7PNyQdnGjFPhx
         TLPm9VQWAZxGecor6BzRVpXL2PdqR4XThS4lWH7XCByl2xqV7kD+BqAqR+6xIrQxySmt
         B45RI4Flma59LBpSy9nbA8VkGnb9dj4NXC0ZJgmWAjVr/JUeqFOvYqKjL0Z9Y0pUY0mt
         h/jQQ82xUAFCgLB+jsOViwD1qsayARlP0DiC81tBnGu1It8MrXW6okN29UwqwoTIXzNP
         vnmU70BdMGmYlSbIO1gbZs6KsIK273MgjSmfzXck+3k3XR6SGcsjZJ7EdMCdUq6Avwn7
         1uNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vM0TuBEUY0vrapOf9Ut/0RUxanAqe66yuP0tCUJZssI=;
        b=pt3Ma0oZcRwIFb9fnWaemSnsS768UtI+QLZdAsQ3ija+bmQeFlH/RwON2wuf1+S0Lf
         qslWveB8OF1SsxjZVbloYUHvPV0Voj47fXsdJvDn9bIT6kYdotSbT1wv1k4TCbnoBuy0
         i0jE9tT4kB2GBEd6X5XLsGmCFEU92zTVznUkdgw/9TKrT0YX4nSKI3wdAf6h4bzzEvTr
         5qMtxWzqxnf/NLAWqyVgvSqyL1lCRroxtQA6xEJtMthaE/vfSGy2JGdOAKwxTv7wpe0H
         75HMZQDgRi1t9c2ddFrJqxNlQyCm9IlEJySsm461SQlHfQmFbFf75rQLtoNl/zCsZguT
         85Yg==
X-Gm-Message-State: AOAM533TpV6xD0FL1cd//kHpP9dRkv8ssjLEnaFvGfRj8CYJum/nhXUX
        8qEi6Is1IAvWwVdVw7Hcjwn3XIckAtU=
X-Google-Smtp-Source: ABdhPJw+QThH6BxVlt2GdMQWXXo79+3VJw6/AVrTIxaIUqBCiSoj2SqJHXdKeorh4FFWRwVBOC8KNA==
X-Received: by 2002:a5d:69cd:: with SMTP id s13mr7320907wrw.379.1599224965005;
        Fri, 04 Sep 2020 06:09:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm11413855wrt.80.2020.09.04.06.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:09:24 -0700 (PDT)
Message-Id: <f5f1e85b030a0ed5774bc115f90fbd8209bdf17d.1599224956.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
References: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
        <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Sep 2020 13:09:13 +0000
Subject: [PATCH v4 09/11] maintenance: use pointers to check --auto
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git maintenance run' command has an '--auto' option. This is used
by other Git commands such as 'git commit' or 'git fetch' to check if
maintenance should be run after adding data to the repository.

Previously, this --auto option was only used to add the argument to the
'git gc' command as part of the 'gc' task. We will be expanding the
other tasks to perform a check to see if they should do work as part of
the --auto flag, when they are enabled by config.

First, update the 'gc' task to perform the auto check inside the
maintenance process. This prevents running an extra 'git gc --auto'
command when not needed. It also shows a model for other tasks.

Second, use the 'auto_condition' function pointer as a signal for
whether we enable the maintenance task under '--auto'. For instance, we
do not want to enable the 'fetch' task in '--auto' mode, so that
function pointer will remain NULL.

Now that we are not automatically calling 'git gc', a test in
t5514-fetch-multiple.sh must be changed to watch for 'git maintenance'
instead.

We continue to pass the '--auto' option to the 'git gc' command when
necessary, because of the gc.autoDetach config option changes behavior.
Likely, we will want to absorb the daemonizing behavior implied by
gc.autoDetach as a maintenance.autoDetach config option.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c              | 16 ++++++++++++++++
 t/t5514-fetch-multiple.sh |  2 +-
 t/t7900-maintenance.sh    |  2 +-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 67a8d405a1..709d13553b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -755,9 +755,17 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts)
 
 typedef int maintenance_task_fn(struct maintenance_run_opts *opts);
 
+/*
+ * An auto condition function returns 1 if the task should run
+ * and 0 if the task should NOT run. See needs_to_gc() for an
+ * example.
+ */
+typedef int maintenance_auto_fn(void);
+
 struct maintenance_task {
 	const char *name;
 	maintenance_task_fn *fn;
+	maintenance_auto_fn *auto_condition;
 	unsigned enabled:1;
 
 	/* -1 if not selected. */
@@ -776,6 +784,7 @@ static struct maintenance_task tasks[] = {
 	[TASK_GC] = {
 		"gc",
 		maintenance_task_gc,
+		need_to_gc,
 		1,
 	},
 	[TASK_COMMIT_GRAPH] = {
@@ -831,6 +840,11 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 		if (!found_selected && !tasks[i].enabled)
 			continue;
 
+		if (opts->auto_flag &&
+		    (!tasks[i].auto_condition ||
+		     !tasks[i].auto_condition()))
+			continue;
+
 		if (tasks[i].fn(opts)) {
 			error(_("task '%s' failed"), tasks[i].name);
 			result = 1;
@@ -845,6 +859,8 @@ static void initialize_task_config(void)
 {
 	int i;
 	struct strbuf config_name = STRBUF_INIT;
+	gc_config();
+
 	for (i = 0; i < TASK__COUNT; i++) {
 		int config_value;
 
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index de8e2f1531..bd202ec6f3 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -108,7 +108,7 @@ test_expect_success 'git fetch --multiple (two remotes)' '
 	 GIT_TRACE=1 git fetch --multiple one two 2>trace &&
 	 git branch -r > output &&
 	 test_cmp ../expect output &&
-	 grep "built-in: git gc" trace >gc &&
+	 grep "built-in: git maintenance" trace >gc &&
 	 test_line_count = 1 gc
 	)
 '
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 290abb7832..4f6a04ddb1 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -21,7 +21,7 @@ test_expect_success 'run [--auto|--quiet]' '
 	GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
 		git maintenance run --no-quiet 2>/dev/null &&
 	test_subcommand git gc --quiet <run-no-auto.txt &&
-	test_subcommand git gc --auto --quiet <run-auto.txt &&
+	test_subcommand ! git gc --auto --quiet <run-auto.txt &&
 	test_subcommand git gc --no-quiet <run-no-quiet.txt
 '
 
-- 
gitgitgadget

