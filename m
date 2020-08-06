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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB72EC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8D7206B2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy87dpTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgHFRxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgHFQbT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:31:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7650BC00217D
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 09:30:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g8so9390880wmk.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zzJdWhaTW/EqA4Z7zQFIb9cuPsIw1ufHfp0AAUO2wiw=;
        b=iy87dpTjzTl9oLzfQY4UBml+QEUmwBzQV7LjTZOaX4L9dJ7NAUEPL5lK05YS6GzIVD
         gOiK9dbOvGDkV6Vp31Nx2vDFcyZhTJZvZ00BQmc/Yn5SejqTDwbRwgL+rcn7JVM35EvL
         j+3fuF/y+mmyQRAcltipUzFsOBOAnf9JapOqvnFoAHB+Uc1kWLPMepIgkWbtq8ZY1D1L
         0Y7dnty8qQbJi3sHciQimxOBsDUYtHquAaU+CvjSRGG5/4hrGOf/EAXRyki5Rd/amd7A
         JmoLoHogl92UPf6hJEuvLePQpJqyRf7+6XXzESgjp0nEH1WnRgKcEMGz5dJUJULe6P7n
         tz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zzJdWhaTW/EqA4Z7zQFIb9cuPsIw1ufHfp0AAUO2wiw=;
        b=AD6g/yKStxG/qepjVHTmR1muFm0rPPevULtsgXXZrPUh+WIpNxHsTAl4SSde8dXwRk
         mQ7T5KcxJkLqO+MD88cvDs9so0PRBFK3K3UKfr6APMdzPhAEbQGx9Mt4ozxQh07pgHx9
         N/v3AKerc0F9l8P4TXRWsqrom8i42hH+5gUHr2pzLr3vWjcHpKRAhHMhVKXOhNedXmZ7
         BWia4nra2eHIHidCukn4T33fkmRfrY3zHl9wF8cViFmKOWumdigMgYyEYisoqv0i8tkT
         aNZ0AL4tEX/P8nXQFQpe9M1hCpNqjvh/2cNtepn1uRd1qPr9Fj3sGQDwY7muB+v0ECXt
         0orw==
X-Gm-Message-State: AOAM530VMuvhwG3bT87gPJlel4mNsiM+8JGnrBhZChkIwu9p/yAYxNSM
        lTjEQqFFvM3HPKT399X1buAQKvyG
X-Google-Smtp-Source: ABdhPJwhGW4LkYAtaZSjjQh5e0dx4SGDGOEDfrjVH5oQy236WFlUNsxgQKS9QdbLPj4ih9chMRif2A==
X-Received: by 2002:a05:600c:2157:: with SMTP id v23mr8355011wml.38.1596731429429;
        Thu, 06 Aug 2020 09:30:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm7325196wmb.15.2020.08.06.09.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:30:29 -0700 (PDT)
Message-Id: <e787403ea7e95dfeb30a0760fea4c56f64895d1e.1596731425.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.git.1596731424.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 16:30:19 +0000
Subject: [PATCH 4/9] maintenance: create auto condition for loose-objects
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
 t/t7900-maintenance.sh               | 25 +++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index 9bd69b9df3..a9442dd260 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -12,3 +12,12 @@ maintenance.commit-graph.auto::
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
index 60261d2647..23329b5652 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -927,6 +927,35 @@ struct write_loose_object_data {
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
@@ -1036,6 +1065,7 @@ static struct maintenance_task tasks[] = {
 	[TASK_LOOSE_OBJECTS] = {
 		"loose-objects",
 		maintenance_task_loose_objects,
+		loose_object_auto_condition,
 	},
 	[TASK_GC] = {
 		"gc",
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 8d54f93a10..71ac686c09 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -122,4 +122,29 @@ test_expect_success 'loose-objects task' '
 	test_cmp packs-between packs-after
 '
 
+test_expect_success 'maintenance.loose-objects.auto' '
+	git repack -adk &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-lo1.txt" \
+		git -c maintenance.loose-objects.auto=1 maintenance \
+		run --auto --task=loose-objects 2>/dev/null &&
+	test_subcommand ! git prune-packed --quiet <trace-lo1.txt &&
+	for i in 1 2
+	do
+		printf data-A-$i | git hash-object -t blob --stdin -w &&
+		GIT_TRACE2_EVENT="$(pwd)/trace-loA-$i" \
+			git -c maintenance.loose-objects.auto=2 \
+			maintenance run --auto --task=loose-objects 2>/dev/null &&
+		test_subcommand ! git prune-packed --quiet <trace-loA-$i &&
+		printf data-B-$i | git hash-object -t blob --stdin -w &&
+		GIT_TRACE2_EVENT="$(pwd)/trace-loB-$i" \
+			git -c maintenance.loose-objects.auto=2 \
+			maintenance run --auto --task=loose-objects 2>/dev/null &&
+		test_subcommand git prune-packed --quiet <trace-loB-$i &&
+		GIT_TRACE2_EVENT="$(pwd)/trace-loC-$i" \
+			git -c maintenance.loose-objects.auto=2 \
+			maintenance run --auto --task=loose-objects 2>/dev/null &&
+		test_subcommand git prune-packed --quiet <trace-loC-$i || return 1
+	done
+'
+
 test_done
-- 
gitgitgadget

