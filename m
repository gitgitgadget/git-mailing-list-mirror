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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70058C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BD52073E
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU8/Hy0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgGGOV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgGGOVx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38438C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so46740362wmf.5
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M//PvpiRz0M3YCXaxE+wnxlhxb1XhrHNSSmfNqI66o0=;
        b=EU8/Hy0/8jBOW8M3ygVFXy0Ci2cnl+RHSejdB+AuWPRKCG0lKMMgtt2fo1aYaraiyq
         WBjVf7WbiEps47bHFR1M4VEKG72im6lf3GJqaCxu1/y3MEKr9N8FRa6QlTtsrS6QIZ9h
         xvB7ovm+dUvJNy2LPUw6AWUNqyNEOOxI8HnQnCS7bjOONO9mfh6vpf8d+SvykkUSJqhB
         /0GCT55gedDQHjTAWmssUQvZbTWBbcM7FFnePMwhtKxmbfRhOMnqHVGNXYEeyQnWBG2E
         ihk0IEA1s8HDOeDOb6+Xyvq2SX5NINXuZ70LvFoA4JYe+EiOmiGZj22pZBL27EsYBEuT
         xnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M//PvpiRz0M3YCXaxE+wnxlhxb1XhrHNSSmfNqI66o0=;
        b=Q70aB9uL/4ry56Hv7HLp/VxEtJ8k4W0TLsdG+BJgMdjJLayPQtFlJzEICPUa+NXOQ8
         wcDf7aqpIe1sv3Gx+7uehAEEe4ZmSG5/4ANbMSgyHjm4Pic/jUv/kTTVih7OnQV0JXog
         4ewKCJZG46ixP9vQkyTYCjV3QX5I1WfxanZgq1qGSUrqapRjiBG03IV3YF7lmirEBDiT
         4ShkFpYvKYvp5q3rVdqgZBrvKawQ272WmZeNC5xmIO4im3m/TR+dbwFXGhpvUGNN2BF8
         7RNDkH2gohp2v7hcEqDaCPk/qS9hVyr6r25Y1BnFh+sHPkS9fTXrq3T15ReRJG0vjKX3
         QXLg==
X-Gm-Message-State: AOAM531nDZYM4hi0rc9OgD80xl05nKtOQdgNxJAS02Mpez9+AwwRYSHw
        jMaSf7dSG4HQSEbMPZnSBEbLWQMU
X-Google-Smtp-Source: ABdhPJxG5SmpuDNRgpaNGK2l1HweTba77JhtAg97EbQH65GdjIQbPC+cZFRdBviJ1vcpBY2zHHOrGg==
X-Received: by 2002:a1c:44e:: with SMTP id 75mr4531072wme.139.1594131711805;
        Tue, 07 Jul 2020 07:21:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm1156260wro.90.2020.07.07.07.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:51 -0700 (PDT)
Message-Id: <4744fdaae9771ef0c0a79edc09941e299b6a1682.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:33 +0000
Subject: [PATCH 19/21] maintenance: create auto condition for loose-objects
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
index 81b076b012..391e1e2121 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -960,6 +960,35 @@ struct write_loose_object_data {
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
+static int loose_object_auto_condition(struct repository *r)
+{
+	int count = 0;
+
+	repo_config_get_int(r, "maintenance.loose-objects.auto",
+			    &loose_object_auto_limit);
+
+	if (!loose_object_auto_limit)
+		return 0;
+	if (loose_object_auto_limit < 0)
+		return 1;
+
+	return for_each_loose_file_in_objdir(r->objects->odb->path,
+					     loose_object_count,
+					     NULL, NULL, &count);
+}
+
 static int loose_object_exists(const struct object_id *oid,
 			       const char *path,
 			       void *data)
@@ -1311,6 +1340,7 @@ static void initialize_tasks(struct repository *r)
 
 	tasks[num_tasks]->name = "loose-objects";
 	tasks[num_tasks]->fn = maintenance_task_loose_objects;
+	tasks[num_tasks]->auto_condition = loose_object_auto_condition;
 	num_tasks++;
 
 	tasks[num_tasks]->name = "pack-files";
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 315bba2447..a55c36d249 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -115,6 +115,31 @@ test_expect_success 'loose-objects task' '
 	test_cmp packs-between packs-after
 '
 
+test_expect_success 'maintenance.loose-objects.auto' '
+	git repack -adk &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-lo1.txt" \
+		git -c maintenance.loose-objects.auto=1 maintenance \
+		run --auto --task=loose-objects &&
+	! grep "\"prune-packed\"" trace-lo1.txt &&
+	for i in 1 2
+	do
+		printf data-A-$i | git hash-object -t blob --stdin -w &&
+		GIT_TRACE2_EVENT="$(pwd)/trace-loA-$i" \
+			git -c maintenance.loose-objects.auto=2 \
+			maintenance run --auto --task=loose-objects &&
+		! grep "\"prune-packed\"" trace-loA-$i &&
+		printf data-B-$i | git hash-object -t blob --stdin -w &&
+		GIT_TRACE2_EVENT="$(pwd)/trace-loB-$i" \
+			git -c maintenance.loose-objects.auto=2 \
+			maintenance run --auto --task=loose-objects &&
+		grep "\"prune-packed\"" trace-loB-$i &&
+		GIT_TRACE2_EVENT="$(pwd)/trace-loC-$i" \
+			git -c maintenance.loose-objects.auto=2 \
+			maintenance run --auto --task=loose-objects &&
+		grep "\"prune-packed\"" trace-loC-$i || return 1
+	done
+'
+
 test_expect_success 'pack-files task' '
 	packDir=.git/objects/pack &&
 	for i in $(test_seq 1 5)
-- 
gitgitgadget

