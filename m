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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44AFC43446
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844D0206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmuJ+aH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgGWR5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbgGWR45 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:56:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71628C0619E2
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so6012157wra.5
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tN02UvhulprvTzUPsFR91Vc5X1kfR4B2eBxD5sAVaKo=;
        b=qmuJ+aH1QYlDT0L6vz66tnYUUhKoB23Xwh+qmimc2meg+Crg1EwfaxJMsR702wsCbx
         +Vlue2xhLgLAu376dIx/4Ciuuss3tH774WL3T36ZVqEl359/kjQHgg9zTw1Y0YyIfu3y
         475Mj9652MkOzmpVl+zIOBTeOnar0z2+Gyv4HMF2Lx/Sut6dMUlzZuB3Jz/584NwF1v3
         HjeQORH1VubnEi9VWFIs9GZT/MRZaMY12PyGlv5I21boYX7Xy3qgNzgg1kXHlFdBiSOV
         Q7W3Cem8Y7TVdlplqb3SpkPOzK8YW2HeI2Kyg9F951JEtVaQP4i8i72QFjkSnGayfd04
         wCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tN02UvhulprvTzUPsFR91Vc5X1kfR4B2eBxD5sAVaKo=;
        b=PzeqGzwAIsuBui1z4YWiWMSbx26sgAH0dWIQWSbi4FfQ00++hK4TZ8eR8psTE0qWs1
         Rn2de+u1Apsr3mvGVgH97hTvCFolNiwZUARr1g5FH1sJ/mhoV335j8LGNFtoLtRuHTtT
         W0JS582RbHjnYaCPeeaRMlkIzPV/rf92Dtv94qg8eVSbq/8Zd2nOohsVO2Bxqq5aYkya
         k8FbpoNZav6lL9mw429WlR9i8SZrBDPHNtggX9pM35u4/dFNHoKob7iJDBehiDWLB8Zp
         /L8q+qGL91RobjpobhHR9O6ljwzS2wVPIfbzyh32UNpE0TWFGkeZ783mf3v56Ukj5VFD
         SOkg==
X-Gm-Message-State: AOAM533m8J5i0q7DHchhur82yLzL1xQhK2gTtO1rEui2+IoD1H7HZJyp
        sLMszfIGhoX8DD7pZEqSO286/gy3
X-Google-Smtp-Source: ABdhPJyu4MXJxrW+WPoYhIL+iXR9KySOEwgtBVW+s4itHQnrU+OpjGe2xhD3jVLsZfRqDlosoXwHhw==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr5084234wrs.368.1595527015962;
        Thu, 23 Jul 2020 10:56:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15sm4355957wrx.91.2020.07.23.10.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:55 -0700 (PDT)
Message-Id: <42e316ca5851992f29fa2658e38a08ebb7dd3e31.1595527000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:37 +0000
Subject: [PATCH v2 15/18] maintenance: create auto condition for loose-objects
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
index 84ad360d17..ae59a28203 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -951,6 +951,35 @@ struct write_loose_object_data {
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
 static int loose_object_exists(const struct object_id *oid,
 			       const char *path,
 			       void *data)
@@ -1285,6 +1314,7 @@ static void initialize_tasks(void)
 
 	tasks[num_tasks]->name = "loose-objects";
 	tasks[num_tasks]->fn = maintenance_task_loose_objects;
+	tasks[num_tasks]->auto_condition = loose_object_auto_condition;
 	num_tasks++;
 
 	tasks[num_tasks]->name = "incremental-repack";
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 373b8dbe04..e4244d7c3c 100755
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
 test_expect_success 'incremental-repack task' '
 	packDir=.git/objects/pack &&
 	for i in $(test_seq 1 5)
-- 
gitgitgadget

