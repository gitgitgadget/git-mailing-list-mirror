Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620D5C433E5
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40FA6207DA
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhcaOkX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgHROXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgHROXY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:23:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE72C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so17199154wma.2
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xNVqN3VkYN9KqK6raUGF/QrF7C9o4aABkMukeCp8YFU=;
        b=OhcaOkX7c1Ns6kcXvyb/cBU/7VAs27Ar4LNMaOiMLZZm7e0tIABx8zZkmOvqkiWMBO
         oN98nzEJ3wB+8FGYZUmSqNHrpb1NeJdug9Msx10mP8mVH24XN6GOyh5MbSt+4bTlX4Jw
         a6jlJG8I72QYlp98+FsRN8DGq592CRXnYYf+zT06/aEuoE03AER0DjYPZW7fxyJtBLAS
         C/qKVdOBfAkdMBhv5LTyk261Q2xWWIVBhAz5yIz0V/WjyzyutNGHinsSgB9PWDbvD37y
         m8qnJQU24uBcZ+RfOlyhVkMFR5D4x2rmCd/V2gN+VtsiHUg9IdxWtoJ7f8n7RAJp7oY2
         PI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xNVqN3VkYN9KqK6raUGF/QrF7C9o4aABkMukeCp8YFU=;
        b=MPq4CSmu7XNxC44T2eNCIFu8AMvJPNPmZDc5UQnjaUguIUwj/lYp+tq086njjmf3ar
         DCVdhE7MA1jSp30Cgz4Mj2R6JNKtejEJHgnQ2nQ8DoKc2SL4PmW18Ll4ZSu2bR/9E84N
         Qbw+nXa4WTj4nQbMj6yk80D3qV92Q8+nVPTtdKWcRskiFMB3bmLfaq+0QujHe+3MdyEb
         xhVu6eo9TwhzyzbHif96vVJAiIIrnirPHkk7ZLmKGcNeylCyHbJqFwJtmM9XOOGTXJiY
         ORfrFYcnq1b7Qq551ATd2Rp+mP9iTfpn45Ia11VNlKodOLmMlVZEsuYbbe2lBFbUxdKk
         frhg==
X-Gm-Message-State: AOAM533pwOpa7PyKCfgVyliErJPxZvJFrcl/sXB4Kjah1wusWdDy8DuE
        jVazrQHLaKi+Jvn6u4PdrP/ByKNC5k8=
X-Google-Smtp-Source: ABdhPJwE2WgiAoteS3I1EI78DnkY0sKUZRqXRehTFJ2NEgRL+HWYa7DZcNl1GjOQP26Q3iAh/gMghg==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr158042wmb.57.1597760599052;
        Tue, 18 Aug 2020 07:23:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16sm31613734wrs.88.2020.08.18.07.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:23:18 -0700 (PDT)
Message-Id: <68bf5bef4bebea48234b6f5c75c7a07d38ca15c0.1597760589.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
        <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:23:06 +0000
Subject: [PATCH v2 09/11] maintenance: use pointers to check --auto
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
index e66326ede9..c54c3070b8 100644
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

