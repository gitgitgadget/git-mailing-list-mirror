Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6F2C433E8
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491C720829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doqO+rqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgG3WY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgG3WYx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95711C061756
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t14so2390719wmi.3
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y4rH2VOeRAt+L1lOlsRtWcRpEG/8wcm/V9DpTFxHn7c=;
        b=doqO+rqf4BqQfM08tiuCYkmAMS9jAzO3jAtJOu01UBuNTyZV3Opjgc36FV7Jrt+urI
         9ObgcVHK3WKP3L+/58QI6h072c52o1+aEEbmJE6XIR+HjSE/3vJoz9LlFUJ51RYu/t2w
         wFNGnq66Mz9XPl5OgsKVC75ZSwifvXsjZoTHwpYm2bZLQby1QCCxX7/hPqjX0xhQJsCz
         b49IAHBzGclMKVGsXaIMW7OYxMowjUGEvNBvwry+l14Lqeo81qFtdXIqbaNI0xpWwo3+
         bvtL2hFF0iqMCeLoR+94HzjdGmEU2pAuG+XHQSVmIBW7X0ysaPdYBghoHZy9G4sD5D5p
         6E1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y4rH2VOeRAt+L1lOlsRtWcRpEG/8wcm/V9DpTFxHn7c=;
        b=Dk/8hVgoYAJdUzomgARe0fGMNOkhRVoySDUJTpK0iLAadUtmjYrIWVBIRzlUOrGjV7
         D+GCLfw/bDEqT0/TvVcEqo/UEtDwrtKKOgUgNcdPqrwvznjzSn/yYF9+aTJx/1dDp49p
         vCUkD2nJZclTLWIhOtHbA4koELHQUfcyTy39Lsc3kghDj8PtrGFeMgjADRK5rSRkHmO2
         WwmLorF4LhcSCVZjUL6ppKhogJ/g+LWaHN3Ki2L7v0jbGPzeJK0FWIgoXhw0zbVhBeN0
         n0mVQ6djS4aSJ+XlB/mjZ4+c6ILek/FhRpu1/gg9QoXWJfCjlXpKnlt7wssq1UrRghgB
         fRKA==
X-Gm-Message-State: AOAM530hy63RtaxS8B7gXR3+PfGXhqbwa1mMi1J3Y3aI51GhmLWqn7xt
        ELNPADv2Pc718FVynYE78yZzXOJB
X-Google-Smtp-Source: ABdhPJxx/uIRokZXKaPj5Hcg7ObSwm323YmBFE80HLA5gp4XQH1+iXSD53+dhQjqdX0hLTnVSys0qg==
X-Received: by 2002:a1c:e908:: with SMTP id q8mr1165397wmc.59.1596147892124;
        Thu, 30 Jul 2020 15:24:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm10418459wrv.14.2020.07.30.15.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:51 -0700 (PDT)
Message-Id: <a087c63572a63bf1bcb6e002f214ccf1e2291771.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:21 +0000
Subject: [PATCH v3 15/20] maintenance: use pointers to check --auto
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
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
index c599690591..1c449b3776 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1074,9 +1074,17 @@ static int maintenance_task_incremental_repack(void)
 
 typedef int maintenance_task_fn(void);
 
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
@@ -1109,6 +1117,7 @@ static struct maintenance_task tasks[] = {
 	[TASK_GC] = {
 		"gc",
 		maintenance_task_gc,
+		need_to_gc,
 		1,
 	},
 	[TASK_COMMIT_GRAPH] = {
@@ -1161,6 +1170,11 @@ static int maintenance_run(void)
 		if (!opts.tasks_selected && !tasks[i].enabled)
 			continue;
 
+		if (opts.auto_flag &&
+		    (!tasks[i].auto_condition ||
+		     !tasks[i].auto_condition()))
+			continue;
+
 		if (tasks[i].fn()) {
 			error(_("task '%s' failed"), tasks[i].name);
 			result = 1;
@@ -1175,6 +1189,8 @@ static void initialize_task_config(void)
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
index affa268dec..19494e6c43 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -17,7 +17,7 @@ test_expect_success 'run [--auto|--quiet]' '
 	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
 	GIT_TRACE2_EVENT="$(pwd)/run-quiet.txt" git maintenance run --quiet &&
 	grep ",\"gc\"]" run-no-auto.txt  &&
-	grep ",\"gc\",\"--auto\"" run-auto.txt &&
+	! grep ",\"gc\",\"--auto\"" run-auto.txt &&
 	grep ",\"gc\",\"--quiet\"" run-quiet.txt
 '
 
-- 
gitgitgadget

