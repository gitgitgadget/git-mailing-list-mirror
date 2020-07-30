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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A9EC433E8
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2274820829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIW4BSx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgG3WZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730479AbgG3WY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F24C06179E
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r4so23321702wrx.9
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aRS2hQwnkKs6hP12JwyT9uf97Wjde3hMJnedVnVLB04=;
        b=mIW4BSx67g6xL3rMAlf1cVM62z1o4Bf6qolC46V24ivV7aP0/0iOSXSxZhLthuvgvh
         OysN9Oz1VzY3tvcswTKtlXIHVoEmwYAujvTQD7NimoIK93zUMlWZ9A4XG0QNzvxmOF4G
         WP+dvRcTfEev/szn/LCyHK+BoRcPrTxVpYgwf+7IuBl4AXRejF1zj4LD6v9FqtjrL7Nc
         TdL3FMkp/iT7NzSHRzFktguHPleRzybZfEZ5hnlmEdMNuge1W/QRWabQ78iqjiJn15Jh
         ickg07GBsO1lM5NKt0fqDMwO8sKjL09guJn6t85b/6y225IHWm2FbE69tmfj3dVtyRjj
         vPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aRS2hQwnkKs6hP12JwyT9uf97Wjde3hMJnedVnVLB04=;
        b=djAmvjjdx4goWrAJoW/Ezejn4B/qw45u2jjBNNMIGtPWL49LdQW0g8lBnyWL5GDyfX
         T7Vl7eMSYGXsD5EROzcDB07tnRsllfIVlPmtWbnt4G30K4JT8j9LMy0xzS7T7dU+2ssc
         5AImhU6volxXULyqK04T3lYWSB9jpXM+6R4hD1Dg3e/zekTOVSCtJbNwYdfUQLjc3FCd
         5poeJxXPHx9VFLyM+u4dAg+KbMGJIB/MVsWmisR4r96q+IuR8FGeDNHsqcz8Ar2l99cG
         7X/OkK8BM1b7l6/KGE+wU11nIpzEXwHUCJHb1v0Hw82SWELm1MjecJjAXIJ7fbS6yAeh
         X0Pw==
X-Gm-Message-State: AOAM532VwmEK4UE8Vs2Bmpg94n4l7A+ACwFWrZAMUAioHePM4NEbK/QF
        Opo2BHZGxnTwFHnEE1m7eqFDqn0f
X-Google-Smtp-Source: ABdhPJx7acHK0MDXzKIDfuw8w5HJIb1SXjDb6g30/gQ8YXg3juPle0CVc0qK8Y83aCIIn6mLXKLtfA==
X-Received: by 2002:adf:f8d0:: with SMTP id f16mr777422wrq.66.1596147893905;
        Thu, 30 Jul 2020 15:24:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8sm10624941wro.75.2020.07.30.15.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:53 -0700 (PDT)
Message-Id: <6ac3a58f2fa1b7456cb80867fd62c3c462c5c858.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:23 +0000
Subject: [PATCH v3 17/20] maintenance: create auto condition for loose-objects
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
index c85813fffe..3b27dc7e7f 100644
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
@@ -1184,6 +1213,7 @@ static struct maintenance_task tasks[] = {
 	[TASK_LOOSE_OBJECTS] = {
 		"loose-objects",
 		maintenance_task_loose_objects,
+		loose_object_auto_condition,
 	},
 	[TASK_INCREMENTAL_REPACK] = {
 		"incremental-repack",
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 19494e6c43..32ac5c9fb7 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -119,6 +119,31 @@ test_expect_success 'loose-objects task' '
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
 test_expect_success 'incremental-repack task' '
 	packDir=.git/objects/pack &&
 	for i in $(test_seq 1 5)
-- 
gitgitgadget

