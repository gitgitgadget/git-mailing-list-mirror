Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68ADC43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B452220E
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXkXlgBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgIQSSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgIQSNS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:13:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472ECC0612F2
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:12:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so3030726wrn.13
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1b2P3nhbjiMTeaIEbQdOCW0yfrkSWrtCcHB2NWXqvU0=;
        b=vXkXlgBUfAnm2gs3IcDYPSfV+CxHk2APd2jMIDFGRGSosYw3SME2FtsSBVK05bBAI7
         rwGNXklIVy4Fs4I/27Hm9bfdtiJK/ehJ+il8V/YNffQojlrBennBdxAEhWRwCk5AFNWX
         qMu1TTf0gRoyCN0A3CFRM+8cgHU7ssQ0e9ZuyS5DPfL3F+36sC7X7w6xMx+gg0jgcN5j
         P31W1FvC/9KbNQ/kE15xvucazQ/kfuDUViOLvav4LB3QQRgfnW8oexQMQsQK8pe40u+X
         soXxIQ1BG+HBZEQLuzQIOxIT1QCmeg12b5zBZb3n8XPhzplWPFh7RJaR52TRzml3pWVJ
         qvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1b2P3nhbjiMTeaIEbQdOCW0yfrkSWrtCcHB2NWXqvU0=;
        b=jS1kn9JXBhPFEFqb3YKcpya0kl5DQudlF9gfsT0p4Z45bamQ/pFxisvG6jht8XJQ86
         fxh04F3HpRbpWMwVlZhH2z5xCvTLx2q50uQ3W66i+FFgExBaoAB3wW2pxhHSUNNV/eeF
         BnwudIV9UJs1yZsIPVCtynoGc6FLhRzSkbJY5Lo0gWw719IxFnxfhMErIpzpt3GiJ4/M
         iFHTiBeVmSz5R9rJ8d6RzscTuR74GIV9atk0nQFZYGWsrCDPeMclDxQRdcMknKpbQkcD
         VOhlCHPDsJzAMEfT3j5gqUfDWWxdLQ5qlLURWeExQWpvhNst6NCOxPBuPVWwZvY3jBSg
         T10Q==
X-Gm-Message-State: AOAM531p4xFtvYm2xtAJGYbZpyoPRY6trI8/jYzt5Dv6CE9FLdLAOjc0
        Y7k2WcVaEnLCAl4CORwjx30Y/rh/Wu4=
X-Google-Smtp-Source: ABdhPJxfVAMRoWvgUEZbTBgsRh5DryJV1IyE9UnFZU1b/bYtVBS62cZu1LaPOkjUX+UPcXa2HR4b6w==
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr33157018wrr.111.1600366321775;
        Thu, 17 Sep 2020 11:12:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d83sm405051wmf.23.2020.09.17.11.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 11:12:01 -0700 (PDT)
Message-Id: <d424cda058470e7419e587c9551f7eaef4a6a12b.1600366313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
        <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 18:11:50 +0000
Subject: [PATCH v5 09/11] maintenance: use pointers to check --auto
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/gc.c              | 16 ++++++++++++++++
 t/t5514-fetch-multiple.sh |  2 +-
 t/t7900-maintenance.sh    |  2 +-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 55a3d836f0..13c24bca7d 100644
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
index 8a162a18ba..53c883531e 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -23,7 +23,7 @@ test_expect_success 'run [--auto|--quiet]' '
 	GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
 		git maintenance run --no-quiet 2>/dev/null &&
 	test_subcommand git gc --quiet <run-no-auto.txt &&
-	test_subcommand git gc --auto --quiet <run-auto.txt &&
+	test_subcommand ! git gc --auto --quiet <run-auto.txt &&
 	test_subcommand git gc --no-quiet <run-no-quiet.txt
 '
 
-- 
gitgitgadget

