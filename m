Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93178C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7FB21D7A
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM171Njt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgIYMdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYMdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 08:33:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6E3C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 05:33:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z1so3440702wrt.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 05:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IFn8sXqu3y7CJ2B6xvw1fX294ScrkHS7U4HmAuCJPps=;
        b=HM171NjtP4NqinQ2QFQKPdTTI89w6TNxOqp2SWH4xYMUX5v9HYND6CVLXZwtBrc4UM
         tGx6CY2AdyXah99/50j/7CUUwvESyMPLYynLkc/zr1OF+rdlZKKfTxlBYx5lRrXlCL+Q
         YIG/NYece7dwIDUSnkXpvn5faywN1JzMWj99KMWekL9ZzZe4pFaZMlEcDTyU8fYBaG1r
         riPYsgWIcSfqWuSDqz7wQG5f6ONEMWSW5bDpiNoFVKk7PMn/fCRwPH4AV89xu1vGXkXy
         rffyFm7fXsUQqd+UFFA9pJ27VSVdpWXIilpcrxq22oZTGz9ea+FO6RlR0DyPsmibGnlj
         ypzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IFn8sXqu3y7CJ2B6xvw1fX294ScrkHS7U4HmAuCJPps=;
        b=K69NjghR3VKjHDG1Mr5hfeWtzmoAD90Hj0y1fzJEsgli26p5Kh9LG/S/x2UqFF1kC0
         ADzriPYx5O3tP7z3Zaik4pCEuLQ7KHBU5nSkO4Z9fLGvKCJct0Zu2TJ1p8wV7UG1tAa1
         yzL3QfzJobJ2xPmRbs5nY89fI+1mKbPrZYye86Gt9yXqQsqVhOnBqJxdyS+HgoMM6+W3
         5L/QfNKyaUItoCU67VfG/6j4WtaAEc5iKjMg55y69PgE0lWqTZm2JzYGpR8z0U+sgmZ1
         gs8OmSQGDJVinPWN+Sbpk2HbKx+wpk7resrT04l6cfrDhAJdb37zqGw6Q+uqWH1GYsxH
         l+Yg==
X-Gm-Message-State: AOAM533Ac0f3hCyL90BZEUCHEZccKmThQ8F6lZDiPTTOD8yoQcY/Q/8z
        dlZ/6merzY9wzDG2MizhZsDSvIDKgjs=
X-Google-Smtp-Source: ABdhPJySD/JIg788hqTl2j2DpgoXgIQgKAAU2ltg9xi/nmg2tZMl/wh5Jd/LKmgR+/44wCMK3gg2Ow==
X-Received: by 2002:adf:9b8b:: with SMTP id d11mr4562305wrc.71.1601037223168;
        Fri, 25 Sep 2020 05:33:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6sm2695494wmf.30.2020.09.25.05.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 05:33:42 -0700 (PDT)
Message-Id: <931fff4883a3da26a296af69a9c5ccc3a5037d71.1601037218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v4.git.1601037218.gitgitgadget@gmail.com>
References: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
        <pull.696.v4.git.1601037218.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 12:33:33 +0000
Subject: [PATCH v4 3/8] maintenance: create auto condition for loose-objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The loose-objects task deletes loose objects that already exist in a
pack-file, then place the remaining loose objects into a new pack-file.
If this step runs all the time, then we risk creating pack-files with
very few objects with every 'git commit' process. To prevent
overwhelming the packs directory with small pack-files, place a minimum
number of objects to justify the task.

The 'maintenance.loose-objects.auto' config option specifies a minimum
number of loose objects to justify the task to run under the '--auto'
option. This defaults to 100 loose objects. Setting the value to zero
will prevent the step from running under '--auto' while a negative value
will force it to run every time.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/maintenance.txt |  9 +++++++++
 builtin/gc.c                         | 30 ++++++++++++++++++++++++++++
 t/t7900-maintenance.sh               | 22 ++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index 7cc6700d57..c31613be62 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -14,3 +14,12 @@ maintenance.commit-graph.auto::
 	reachable commits that are not in the commit-graph file is at least
 	the value of `maintenance.commit-graph.auto`. The default value is
 	100.
+
+maintenance.loose-objects.auto::
+	This integer config option controls how often the `loose-objects` task
+	should be run as part of `git maintenance run --auto`. If zero, then
+	the `loose-objects` task will not run with the `--auto` option. A
+	negative value will force the task to run every time. Otherwise, a
+	positive value implies the command should run when the number of
+	loose objects is at least the value of `maintenance.loose-objects.auto`.
+	The default value is 100.
diff --git a/builtin/gc.c b/builtin/gc.c
index c9db8555b9..4403827481 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -899,6 +899,35 @@ struct write_loose_object_data {
 	int batch_size;
 };
 
+static int loose_object_auto_limit = 100;
+
+static int loose_object_count(const struct object_id *oid,
+			       const char *path,
+			       void *data)
+{
+	int *count = (int*)data;
+	if (++(*count) >= loose_object_auto_limit)
+		return 1;
+	return 0;
+}
+
+static int loose_object_auto_condition(void)
+{
+	int count = 0;
+
+	git_config_get_int("maintenance.loose-objects.auto",
+			   &loose_object_auto_limit);
+
+	if (!loose_object_auto_limit)
+		return 0;
+	if (loose_object_auto_limit < 0)
+		return 1;
+
+	return for_each_loose_file_in_objdir(the_repository->objects->odb->path,
+					     loose_object_count,
+					     NULL, NULL, &count);
+}
+
 static int bail_on_loose(const struct object_id *oid,
 			 const char *path,
 			 void *data)
@@ -1009,6 +1038,7 @@ static struct maintenance_task tasks[] = {
 	[TASK_LOOSE_OBJECTS] = {
 		"loose-objects",
 		maintenance_task_loose_objects,
+		loose_object_auto_condition,
 	},
 	[TASK_GC] = {
 		"gc",
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index b3fc7c8670..27565c55a2 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -127,4 +127,26 @@ test_expect_success 'loose-objects task' '
 	test_cmp packs-between packs-after
 '
 
+test_expect_success 'maintenance.loose-objects.auto' '
+	git repack -adk &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-lo1.txt" \
+		git -c maintenance.loose-objects.auto=1 maintenance \
+		run --auto --task=loose-objects 2>/dev/null &&
+	test_subcommand ! git prune-packed --quiet <trace-lo1.txt &&
+	printf data-A | git hash-object -t blob --stdin -w &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-loA" \
+		git -c maintenance.loose-objects.auto=2 \
+		maintenance run --auto --task=loose-objects 2>/dev/null &&
+	test_subcommand ! git prune-packed --quiet <trace-loA &&
+	printf data-B | git hash-object -t blob --stdin -w &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-loB" \
+		git -c maintenance.loose-objects.auto=2 \
+		maintenance run --auto --task=loose-objects 2>/dev/null &&
+	test_subcommand git prune-packed --quiet <trace-loB &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-loC" \
+		git -c maintenance.loose-objects.auto=2 \
+		maintenance run --auto --task=loose-objects 2>/dev/null &&
+	test_subcommand git prune-packed --quiet <trace-loC
+'
+
 test_done
-- 
gitgitgadget

