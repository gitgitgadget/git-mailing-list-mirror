Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B208FC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3952074D
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLqyi1zZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHYSei (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgHYSeA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:34:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C43C061796
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:34:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 83so3567962wme.4
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vM0TuBEUY0vrapOf9Ut/0RUxanAqe66yuP0tCUJZssI=;
        b=qLqyi1zZ93D0wuHFjTV+O6aArs2RPob3NsCrqEZQeAU6wasFLp5lRIVluZeLkiNZ0s
         OWVMlfcqj1qQPTTPLujvRZE3G1TaPwhZQjp4+oEKZg7KkMWsXt/tMSKVgUJEjhfyXMBH
         Ge+5iCVuvvbxffsu5SPyTMS1hWBsLrGConS+klqWX2XgVsqO3T5bAvYZANpQR1oOROSd
         de65bq0tH0EVJFIzIXzDKZYGNSasTcDY6Yp+GaIwiKW3Ul31wVaoCQiGv31L7w0r6nO6
         VHXepYv/tvsYrj9BYi/OhGcxtol3o9J7aQmWTqS8+xphbDk4xjkDDRHFos4C871bYpML
         VUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vM0TuBEUY0vrapOf9Ut/0RUxanAqe66yuP0tCUJZssI=;
        b=DEINnVtyrEJ6K4eRb/4HilJ1ow6bR21D0OC+I1bmfmMZXDWevyYsJpvbarOfwwZyMA
         hxDeVlJHtX5Udk0Gl8OJHhRe05HoyQaDJFhc9LW3Bu201e4CqTfGIicLOHYBEgqrLhMr
         OgzMAHxSWaYJ2KvZDWSAslhwdTWorWyMgGuWSGE6WAvSEUOlKCT7iR409HrqFDIxtFjG
         /eIJ304+6p6IuGnMfS+ZfZbf/GuB8tr2oMsRWNl4nu46oEuffCaBs3qxYDnotQNUBMGH
         el+i+gZM3HGBqb58JZ0TCKxg7/O2I7a2xj7OcYzq7jPv+7M9DL/wF34Gtfo/LlNqQ89L
         PBGA==
X-Gm-Message-State: AOAM532CVwrN1QZwHzAPdDs6nZPv/x3QMlqVPUBzvo9LQd0wMVNqGvYa
        j8uiLTmaiTgYuzKAbi5ruA5zLH7Kado=
X-Google-Smtp-Source: ABdhPJzXBTrkJ3CBg4i5ATBhFbbjhmnD77tcBYe/NnHNbOIZDd6ze3pCvjUNGvz3pkfK9bFc3nVixw==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr3486700wmb.54.1598380437045;
        Tue, 25 Aug 2020 11:33:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm10785252wme.32.2020.08.25.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:33:56 -0700 (PDT)
Message-Id: <69d3b48fd4474783579297d3d25f04dd8f1e7673.1598380427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
References: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
        <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:33:44 +0000
Subject: [PATCH v3 09/11] maintenance: use pointers to check --auto
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

