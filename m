Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C93C433E3
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A3720786
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZUPcxjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHRO0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgHROZl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:25:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B60C061347
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k20so17194489wmi.5
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WVnIOoLMGi6G5xYG0eyG1pMO9RT/JNnNv7zeDSIugV0=;
        b=JZUPcxjGmdtlOVyslsR8BCA7siz7w1nNQs7pTZPfK37xMEtUHmw7O7/QrES9VGitEU
         JEELuPzf14EWDwTWW7U22DIxeWfvvMZjcAqr0qBdmz1MwgG74pA0qB3KJWdfZrt+BTvN
         uXlAPac/1S2Tl+/X49hgYjz3G5lFr/0Fv9P3Nu3TLyiNfJxcx0BTMyIgkpg0FV7+JZGq
         uCi83yg2yBtKkU080YXVaHyTXjuYv25FqanxdbNul64P/pFG/txsFk7axguq92djxijg
         EPpLsEUMC50SwWsPb584b4McJdedw83M1UFC5ZDb1ztkQccKXnPll2QJ46v0rZ+ga/Rn
         tvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WVnIOoLMGi6G5xYG0eyG1pMO9RT/JNnNv7zeDSIugV0=;
        b=RDdPAD/43xVKOu3fI6wSv21LIV/9qcdEVhZOT+07QeLz4DZSb1ny9Q22o5smFCATqL
         8DgVv/9onwyoK7eWgwtZEhfbEVUwIq07dhFLdOH504xGM1eYJw/D2Jz31/txResJB5k9
         +rce3o5ppx9tv6ZgkVapiJqu4tgzIUvBwR42ff1d3esib4ptPQJhWYe2tMbrvsAGugxF
         EVihXbKBYd+SdS4Yw6lYHT/c2mf2bk3+lvtjpDbP8lNmtqwA/rERsPCzCQEEEBmCwIKl
         XEbko+e5SVpeip4weeQPevP2WvrEDOR2dTF5+HlePN8iLAP0kdU2d4+gJHpO+hted7di
         Y4Ug==
X-Gm-Message-State: AOAM532JsmQUSXV17kfr78AcQlIwGsxl7VPAigpafBtBiISjhbO+1HjY
        eol1oglOlt7cfKiYOCho7jVVsMJPNnM=
X-Google-Smtp-Source: ABdhPJz80R0z/80CTjTzCJsIO/D1DJvG3LUZR+tfJyUarA0MVgYswB5XLcvcGpeBBGXvsQnNjvpk1Q==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr197368wmb.150.1597760736483;
        Tue, 18 Aug 2020 07:25:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm39838272wra.81.2020.08.18.07.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:25:35 -0700 (PDT)
Message-Id: <3432bc3167b2250ce4d02f8b81950c3b12b524d4.1597760730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
        <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:25:25 +0000
Subject: [PATCH v2 4/9] maintenance: create auto condition for loose-objects
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
index 39ea590b5a..61d5752af5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -926,6 +926,35 @@ struct write_loose_object_data {
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
@@ -1035,6 +1064,7 @@ static struct maintenance_task tasks[] = {
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

