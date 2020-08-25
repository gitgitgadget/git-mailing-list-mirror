Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A02C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BCB52071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8xkz5E6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHYSkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgHYSkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:40:09 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A831C061756
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u18so3603537wmc.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ablqq3jT9ZyD0iEPR8c7GLfn5zx1HtHOn/rEKNsk8Lo=;
        b=Y8xkz5E6x73AuzfQIMJPHN9VXoiay1JLIhL8UJlDhiaV8WaULafdtMx0AN6k+PaOLN
         /hxLjRi5q8tnMWmW6jwcx5MRKbANiN3fJmnm6GCOUYhHSwiDV+6Vn3o/9SczV/fRg8w/
         oJFR9/x4OEeAIvMjY2zeEPAX+dwMSP3xCjvubEbPxLREl2FV1YPOgvBg1dAtGS4DOp0P
         Maq3TLf4dBD1gXMr66zC1VbhQCUk9EfVwjn5X3i5BGPzFUEKD79GFTv8V1NjwCbGNCxE
         BGkwKG2cSoeWfsNCt+/e60kvIBQvK8GAD4sfVEIinEFTPEW8U9Kg+18SWxp51oR0xSq+
         YoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ablqq3jT9ZyD0iEPR8c7GLfn5zx1HtHOn/rEKNsk8Lo=;
        b=TZ6/zV7KASb2lOC7j+aOyZviA5vqBUGrE9pUmcUhyHuom/suvGgZ6byjVSesv6ijNq
         BO1up2HFhmhUR1mIi3WkOz1Ae4LPzjUYM/idq0DSZDU7mz20aHDxPHr9D0Zd4X5gOQcJ
         uaanIFoP0NhTG51fBUQ9P3pVTSw2fnMYPNMkvxVhpppfPO88+PFlt0hmX+dntjvO9iPL
         G1u9OG2xCyXEs6d4KEPTMTMi1eNN7qmuHqP/jypp78rWMTNZVJybJ8vK37FUaVDDVjVd
         YeKCBr9iYsfyFF++2O+wfiTTbKjfxURJ+VP3vFJHnBzHbhhHG/wXVNNUZOTFbAhKHe+d
         lxBw==
X-Gm-Message-State: AOAM5330ZyUDEEdrfJKtYixwAeuDzV2gzN/qvY/AGHDCic0ONqnej6lM
        FKRQKXP4PPHStpwpjUgNbsEXaPBBs1M=
X-Google-Smtp-Source: ABdhPJyC9W9wFkEdRNwzQHoUi5fECqpiy93qWAPyiq5zr52/Zux3NLm+sV6RC59YQleCJ3bgPVvbkg==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr3440267wmb.5.1598380807846;
        Tue, 25 Aug 2020 11:40:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7sm7115641wmj.24.2020.08.25.11.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:40:07 -0700 (PDT)
Message-Id: <e3ef0b9bea4a31c72ce88841639e88355408f0c1.1598380805.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
        <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:39:59 +0000
Subject: [PATCH v2 2/7] maintenance: store the "last run" time in config
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

Users may want to run certain maintenance tasks only so often. Update
the local config with a new 'maintenance.<task>.lastRun' config option
that stores the timestamp just before running the maintenance task.

I selected the timestamp before the task, as opposed to after the task,
for a couple reasons:

 1. The time the task takes to execute should not contribute to the
    interval between running the tasks. If a daily task takes 10 minutes
    to run, then every day the execution will drift by at least 10
    minutes.

 2. If the task fails for some unforseen reason, it would be good to
    indicate that we _attempted_ the task at a certain timestamp. This
    will avoid spamming a repository that is in a bad state.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/maintenance.txt |  5 +++++
 builtin/gc.c                         | 16 ++++++++++++++++
 t/t7900-maintenance.sh               | 10 ++++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index 06db758172..8dd34169da 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -10,6 +10,11 @@ maintenance.<task>.enabled::
 	`--task` option exists. By default, only `maintenance.gc.enabled`
 	is true.
 
+maintenance.<task>.lastRun::
+	This config value is automatically updated by Git when the task
+	`<task>` is run. It stores a timestamp representing the most-recent
+	run of the `<task>`.
+
 maintenance.commit-graph.auto::
 	This integer config option controls how often the `commit-graph` task
 	should be run as part of `git maintenance run --auto`. If zero, then
diff --git a/builtin/gc.c b/builtin/gc.c
index f8459df04c..fb6f231a5c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1212,6 +1212,20 @@ static int compare_tasks_by_selection(const void *a_, const void *b_)
 	return b->selected_order - a->selected_order;
 }
 
+static void update_last_run(struct maintenance_task *task)
+{
+	timestamp_t now = approxidate("now");
+	struct strbuf config = STRBUF_INIT;
+	struct strbuf value = STRBUF_INIT;
+	strbuf_addf(&config, "maintenance.%s.lastrun", task->name);
+	strbuf_addf(&value, "%"PRItime"", now);
+
+	git_config_set(config.buf, value.buf);
+
+	strbuf_release(&config);
+	strbuf_release(&value);
+}
+
 static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 {
 	int i, found_selected = 0;
@@ -1254,6 +1268,8 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 		     !tasks[i].auto_condition()))
 			continue;
 
+		update_last_run(&tasks[i]);
+
 		trace2_region_enter("maintenance", tasks[i].name, r);
 		if (tasks[i].fn(opts)) {
 			error(_("task '%s' failed"), tasks[i].name);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index e0ba19e1ff..a985ce3674 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -264,4 +264,14 @@ test_expect_success 'maintenance.incremental-repack.auto' '
 	done
 '
 
+test_expect_success 'tasks update maintenance.<task>.lastRun' '
+	git config --unset maintenance.commit-graph.lastrun &&
+	GIT_TRACE2_EVENT="$(pwd)/run.txt" \
+		GIT_TEST_DATE_NOW=1595000000 \
+		git maintenance run --task=commit-graph 2>/dev/null &&
+	test_subcommand git commit-graph write --split --reachable \
+		--no-progress <run.txt &&
+	test_cmp_config 1595000000 maintenance.commit-graph.lastrun
+'
+
 test_done
-- 
gitgitgadget

