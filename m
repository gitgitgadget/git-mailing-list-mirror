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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC337C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E562071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0hSBFYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHYSg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgHYSgp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:36:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52C9C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:36:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id y3so13824933wrl.4
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gP7K0J21l7C2pLM+uo8QkaMPL8P7Jj3kMr0PqrCyVZY=;
        b=s0hSBFYDMAuCaZaTEKT0UlrYFgeIZilkBPjM8fUhyB7iMhQ2Z5OSUr2F/KVKt7Na3G
         ZyVbTeXWgiDCEf7X2mVLjb1h7sBsBQyIBZcGk8W9gwEkYeL4HMxh/caIciRK7ObESQOI
         vXmeXTorLyAhwHXZVl8DjePzU3kUWhMd5T2EvZKvFQY9cKMQG6u1JiHnQ3edZLmr5Dcv
         iEkE9VMWmfrbmayq7v41tjzzgmOOa99TumOV+5S05hl0kPVGA/cZgKpRIIO2uPi9Oyne
         UuYsoCvbb92D5QR5GNEhPnNBOnN5gYwvPsZPZ9tTdn0RfJ9XYVo5+GxDzT8Uwjq4T9hs
         9AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gP7K0J21l7C2pLM+uo8QkaMPL8P7Jj3kMr0PqrCyVZY=;
        b=L/0LZ/ehSQVZ6pqcNCQDzWXFNg8BTITdoxFNhrpCbhAPAs1d5055ojmTSXT5RuJcHL
         1jTglI4DwYyJjfa1vhC4W/4NPkJ6ZOBRtXt0KshXTxv2Pirgn55tQi0xhK7muLrDfaY5
         nwfjymKZfXo1xV+oDWBElAC+CR5FmKw3AtvlzZqFfxdnePFETRGJJfOXcClZMsjKXDFk
         pPQBA43zqOkXhQHiOgFQreIaoWKjRYS39aqYeD0B/E8x1IEIbmaaANlhddVZOZigCtpa
         BJfYk9xjRgYmeAnmLlz7xuKqYK5s10EVoBV7rBFWaiFGy6x3qilosZR0O7WGoQBsbS0p
         mY+w==
X-Gm-Message-State: AOAM531uM8O4rbAF65CkKlEy+xrTAASGGLvxWkiEdebJ+c+MVhIjlfBQ
        9wu42m13+VtIEtwoWEH9IiEGgksiMN0=
X-Google-Smtp-Source: ABdhPJwe6sEy/L6EkaIsP01+QDxGauIgcX8rMwJH82JU3We5ext6GxaqA3+kmOsmdJgdy/oJN3ifIw==
X-Received: by 2002:a5d:45c8:: with SMTP id b8mr7217869wrs.381.1598380603441;
        Tue, 25 Aug 2020 11:36:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8sm12498433wrs.22.2020.08.25.11.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:36:42 -0700 (PDT)
Message-Id: <d6e382c43effe063fb1137659f616d414ee52682.1598380599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
References: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
        <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:36:34 +0000
Subject: [PATCH v3 3/8] maintenance: create auto condition for loose-objects
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
index 248ccde3c3..25245bcc10 100644
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
index 2e9e369786..efda1cf69b 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -125,4 +125,29 @@ test_expect_success 'loose-objects task' '
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

