Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4374C433E5
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933F62073E
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idAONyhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgGGOVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgGGOVx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3B7C08C5F3
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so42922680wrp.10
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M8IcARBo6aX1u/3LBJaKarkhcBoRUac8i4yI1wk6DVQ=;
        b=idAONyhhZ8qN3pcTsNxs1z4sKU5K5Wa/uH+EpEAYA8vn6Q1vwSn++WA8gGZTDanDik
         2nzaRt5gneaknh7I7GSbPinJaBBHsDAMDLSCuLCCHrxd79+cMZlm/RnRJiy9eqJi1SxG
         9n1xlLsW9ZgbtcY8EaT501t+3JL5rbWwxzCevP3SsORjv02/p/mrHvbjEShxrl7yh+wH
         4BVLOuQmOqHePuT/LTBqMFpwosKvmIZV/PnVNTvohL/vUtunxEKAbjlvc6sqyle4i/TP
         mMS+JXNS3Y9EnXd9C0lntkANpmUvwwEim4B9CFLaScYXt94FWDIXXmFXzMkYkFKNuCtf
         zXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M8IcARBo6aX1u/3LBJaKarkhcBoRUac8i4yI1wk6DVQ=;
        b=SYDDuA/MmgAJQR9F1ytZK3VOr/ZeLc/Fzzw6CTf1FijLyzjfiwUc0/VuN0afp+OZCd
         moqBHvb0gpzSAyntgoifDpjjDMK/alNt+gNHFXLpJ7b/ikE1NYgc7T+MpE8W5B2Oz7RL
         EbLWfDXcjL7fLfEG/OE5cT4ANcjsdfDZkYOBOQTn7FrKUCXRJHjW5HyXPl7kqKHLlIke
         1oKw5vqKetdaimZmGyr4E1KkBOOnqUcNnsTWHO8/0pf8Apk0hpeYdGRlAigZzQlaIONi
         K0wHr+DYSFThme+Etgvf646ps023CI4Ty2rcXJOgoFF6WmR/TKID3jJBNArJIPJ7RoPG
         9iSA==
X-Gm-Message-State: AOAM531O8x9/6Pp8EtJTohzFGrmIO1OYwpphmV+MFX4+L8LeA7flnidb
        jbhfHdWZhUtOyPQgsvB4lLs+dv4+
X-Google-Smtp-Source: ABdhPJzXUdWTdDAoW1CS3+agYwzn10SYsaErgmNsL5H6oLaNO/iqalhVW9TB5fIeEfKuTBjNL1idfw==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr58330352wro.201.1594131710224;
        Tue, 07 Jul 2020 07:21:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm1237103wmc.1.2020.07.07.07.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:49 -0700 (PDT)
Message-Id: <130130b66293584f9f7aacae7d485b1acb6ed7e9.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:31 +0000
Subject: [PATCH 17/21] maintenance: use pointers to check --auto
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
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
index 6ffe2213b4..dd24026b41 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1132,10 +1132,18 @@ static int maintenance_task_pack_files(struct repository *r)
 
 typedef int maintenance_task_fn(struct repository *r);
 
+/*
+ * An auto condition function returns 1 if the task should run
+ * and 0 if the task should NOT run. See needs_to_gc() for an
+ * example.
+ */
+typedef int maintenance_auto_fn(struct repository *r);
+
 struct maintenance_task {
 	struct hashmap_entry ent;
 	const char *name;
 	maintenance_task_fn *fn;
+	maintenance_auto_fn *auto_condition;
 	int task_order;
 	unsigned enabled:1,
 		 selected:1;
@@ -1201,6 +1209,11 @@ static int maintenance_run(struct repository *r)
 		if (!opts.tasks_selected && !tasks[i]->enabled)
 			continue;
 
+		if (opts.auto_flag &&
+		    (!tasks[i]->auto_condition ||
+		     !tasks[i]->auto_condition(r)))
+			continue;
+
 		result = tasks[i]->fn(r);
 	}
 
@@ -1231,6 +1244,7 @@ static void initialize_tasks(struct repository *r)
 
 	tasks[num_tasks]->name = "gc";
 	tasks[num_tasks]->fn = maintenance_task_gc;
+	tasks[num_tasks]->auto_condition = need_to_gc;
 	tasks[num_tasks]->enabled = 1;
 	num_tasks++;
 
@@ -1315,6 +1329,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 				   builtin_maintenance_options);
 
 	opts.quiet = !isatty(2);
+	gc_config(r);
 	initialize_tasks(r);
 
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
index 08aa50a724..315bba2447 100755
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

