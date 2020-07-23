Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB431C433FC
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E08B206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVUcjt6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgGWR5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbgGWR44 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:56:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E09C0619DC
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so6008342wru.6
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z6kTm1PJVREFGVitIv2AsZneQRuyQdm7G67H8YL0WrY=;
        b=kVUcjt6ib5DCljaPd71d2S9LBHLkOtznQGuXs9PO3fzc/fjFKLyi2FBcKO+F+zssGW
         LUGb7tnDbJFHsWkmEnXN3xE2UjKyVaRfCtW/ycE0d7ellI/CwpdivUO4N8NVcU5KOsKg
         qDkA5D6YMuNNkDWK3dt7YErSfDiHzzYDc3QuCj7ldrYqs52SjxTg9V2cNL2mQWHiNYDJ
         mowLUV0vFjbaiCpdPvim/3i/rPiJTIR1W7pri+dDFOwbaNFCJoFXuLfc0tzyrI2+Lew8
         eurEvyW4+h/wBK89M+KHdLjYrCGnUPCtWZS9nZXIPPNuWiTTF2Dsk9nlcSRtNMElxvFx
         iE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z6kTm1PJVREFGVitIv2AsZneQRuyQdm7G67H8YL0WrY=;
        b=g68NOggOprg7+PZc6kjf8VEg7Rj3UqQ4sKjK9Wo4PW5ZQCFITZ5/2jRmHDZG88GKM8
         YPEud8aqIB8/Oj4vgj004Kxk9TRi6+vbAWp0U8sFsDeabV+uP5MYhy5LKoDHtqoCsgah
         nBdp79ec3Xggk98g+wcOHusp3DOlBzd2x/NYrqqgqCW0fk/bV5vIh73mxSXxdNTIiYu1
         YDn5LNfHOgUeSIPUL3eO4NFQu2vd2JD24tFESeVSu7FpVHEJk4vgJByO4CFsSAO1pPB9
         w+b1U1A4Nk2uYzmezE3neEazdKJmGolvCDXd/EI6kITHTfftOXBRTewwCvMC3viCSInj
         eYOw==
X-Gm-Message-State: AOAM532xGqOM/L9A/zhvCp77wlzrhxPksPAiHb00qOLQvQEJDd4vlyUa
        XGxFzOpS5cvLmr1joCNcYxRf+CXJ
X-Google-Smtp-Source: ABdhPJwDVLldbRmcd75v8UlbojYUJGNp6v47KPnz44TZYAlkzWCUdFpKPJyUzqXaraPjzphSMFlD4A==
X-Received: by 2002:a5d:6cd0:: with SMTP id c16mr5159187wrc.121.1595527014183;
        Thu, 23 Jul 2020 10:56:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s203sm4465678wms.32.2020.07.23.10.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:53 -0700 (PDT)
Message-Id: <dbacc2b76c79bfc874484bc2d1c11084569fd872.1595527000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:35 +0000
Subject: [PATCH v2 13/18] maintenance: use pointers to check --auto
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
 builtin/gc.c              | 15 +++++++++++++++
 t/t5514-fetch-multiple.sh |  2 +-
 t/t7900-maintenance.sh    |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index b6dc4b1832..31696a2595 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1121,9 +1121,17 @@ static int maintenance_task_incremental_repack(void)
 
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
 	int task_order;
 	unsigned enabled:1,
 		 selected:1;
@@ -1175,6 +1183,11 @@ static int maintenance_run(void)
 		if (!opts.tasks_selected && !tasks[i]->enabled)
 			continue;
 
+		if (opts.auto_flag &&
+		    (!tasks[i]->auto_condition ||
+		     !tasks[i]->auto_condition()))
+			continue;
+
 		result = tasks[i]->fn();
 	}
 
@@ -1205,6 +1218,7 @@ static void initialize_tasks(void)
 
 	tasks[num_tasks]->name = "gc";
 	tasks[num_tasks]->fn = maintenance_task_gc;
+	tasks[num_tasks]->auto_condition = need_to_gc;
 	tasks[num_tasks]->enabled = 1;
 	num_tasks++;
 
@@ -1283,6 +1297,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 				   builtin_maintenance_options);
 
 	opts.quiet = !isatty(2);
+	gc_config();
 	initialize_tasks();
 
 	argc = parse_options(argc, argv, prefix,
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
index 3ee51723e0..373b8dbe04 100755
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

