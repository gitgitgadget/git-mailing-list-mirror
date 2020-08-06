Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568EDC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D81206C3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/7XwcrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgHFR4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgHFQRX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:17:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EA7C002147
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:48:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a5so34506752wrm.6
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YMZSxoX6uVDMUjg146cWLxHkPLGIA7mmqY6I5YeqTsw=;
        b=O/7XwcrEV+N1HBZWwepgS0mAiOp5WLLHQoA5YZnMaC9mLJZNb56NRq4jvCkXJ4yNMb
         qvM6J+ucvf4sqhPZUdwyHKLoNVmJ7pmMjhKbuUBhrGGa4YcDeh9KxDJvo3fimohmS2S2
         g2FVQgGLFXL3iP0NhxFXSO2YEEXXkZIQMGA54SlXFW45M7bXMDaNqXY/xJ8fsgwqPF/f
         GhPbVBgWpByyJ/dYTORTqvts+bhRhxoGmHzN7B9JgEflr0aM0iKXP1xC9xnqgUlRcnKI
         bpodeqrKV8pWeVtMZea/1KKxO4n5zAG5igwGppEiImAYpMB1jaZABTQdXiDe6Az/LESp
         WRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YMZSxoX6uVDMUjg146cWLxHkPLGIA7mmqY6I5YeqTsw=;
        b=OQe3+DoRJdgTqmawDUHF4hlMZ4ok2wmn3LFSFW1MKEZ6WyvPEW+LoIkMCqSklrAZny
         g0oMS3IdBO4A0cBrICdI9PM4aEXVn7q0kOAhjqE0WwJDYmjeAe4L3dmWEVMkwEuLnT9Z
         xcskEvDLqQG1MZaRYDb6zTrTunUINK6tHvfoeXw4ujj1P9SY3ado1bCnR1sLPi97z3Qk
         TvyFjVyo201lHzVuQYVAybKJ/kPWKsGw5dTJ1ip1zAp1d24ekO0Z/OXxp2ggFiFSlPCz
         AP+kUmUY/FV9GJDs5viY/bACbp4H/B4yChT5wMoqL9f48SITs6h2qlFK5sQbQyhbUPQC
         gWCQ==
X-Gm-Message-State: AOAM530RFz165iB4sUq58iiRxf4X1Rg5tMrO7uGJbNpIkBHRiG6m4ws2
        Cjjx2U4/vvsPbBNYqJdlb/F25W3q
X-Google-Smtp-Source: ABdhPJwIZyIV7tVdSdsUGhYW0y8htvB9qZRN9cjmgrAUimA1/mhqceQb4JFhK+/d8BP6bJw7M+r9ww==
X-Received: by 2002:a5d:5710:: with SMTP id a16mr8593487wrv.217.1596728931654;
        Thu, 06 Aug 2020 08:48:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm6479115wmc.28.2020.08.06.08.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:48:51 -0700 (PDT)
Message-Id: <df21bbb0005c0fa39917e326213423a9399308ab.1596728921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.git.1596728921.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:48:39 +0000
Subject: [PATCH 09/11] maintenance: use pointers to check --auto
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
index dc1d260858..2b3e45eb71 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -788,9 +788,17 @@ static int maintenance_task_gc(struct maintenance_opts *opts)
 
 typedef int maintenance_task_fn(struct maintenance_opts *opts);
 
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
 	unsigned enabled:1,
 		 selected:1;
 	int selected_order;
@@ -808,6 +816,7 @@ static struct maintenance_task tasks[] = {
 	[TASK_GC] = {
 		"gc",
 		maintenance_task_gc,
+		need_to_gc,
 		1,
 	},
 	[TASK_COMMIT_GRAPH] = {
@@ -863,6 +872,11 @@ static int maintenance_run(struct maintenance_opts *opts)
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
@@ -877,6 +891,8 @@ static void initialize_task_config(void)
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
index cdf0bf2e60..406dc7c303 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -19,7 +19,7 @@ test_expect_success 'run [--auto|--quiet]' '
 	GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
 		git maintenance run --no-quiet 2>/dev/null &&
 	test_subcommand git gc --quiet <run-no-auto.txt &&
-	test_subcommand git gc --auto --quiet <run-auto.txt &&
+	test_subcommand ! git gc --auto --quiet <run-auto.txt &&
 	test_subcommand git gc --no-quiet <run-no-quiet.txt
 '
 
-- 
gitgitgadget

