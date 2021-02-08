Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1138C433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 14:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A99464E0B
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 14:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhBHOxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 09:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhBHOxI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 09:53:08 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D80C06178C
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 06:52:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o24so5772882wmh.5
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 06:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LeW2Dv4F9yqfmR2IEn382ThJmEt3sKRdHOhfsp+M7Ks=;
        b=KIlAoBCTGgvWWnPzP6ET9bvaRkkdjCUKDxT31rSvlty1eZWOrMBlU6ou5FTiMt5le5
         /3bUzeRSajeywS8HbB1ey7gUQ+/sFdg5dYkZxben9LQZE9CSoe/mTU2rSgaBzAM44TIV
         QbdiIq4k32gGxHq+u8G7kF99zmxOAnCSXkeoxcLC1UUdNqVStp0w6HONvSZLKEw6qDXR
         bAO+Ra//HIHlSYx7vOms0KB8OjTKjw4IzjLsF1Gl6P5sIHHSAMmrLkNo8Jkas4mRIwJb
         tWL3xEsv8ur+jh+shGlxonWgFnvVmUMHFkwJtZ7UtbM72eJ88twBg7BxCVEsRdgGvs9k
         nACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LeW2Dv4F9yqfmR2IEn382ThJmEt3sKRdHOhfsp+M7Ks=;
        b=j6qd0RG9k81t/wd7TsXIvNo5a0Z3pSdZcYeiHyCtmFBTkxj7B7rwMtg75KCFRQjFFP
         uKAuG+g2C1/S3RSALIM3E8bdMr4WzKt2U3v7WgDMp3yCmxlpIalWPsT1oCfzjLvHdBK0
         7eMPUwZkq+rsK00SK3mQm2QMRb63ICxcvALwHpC/AaEbDVfxco24wO72RaVsSlhV/ZLR
         uY4nk1eDwFFGtq9GD/2cC5AwZiAzq1TPsz/VdJXRd5jZgTsn4AI5rtsnzTBBtLnpWp2q
         c6QoLyvOpStVy0FkTPFAdbsAldRhRY92DazbuuJSeqrvH8wUMfiz4phwuuXFYLjcDzh3
         prXw==
X-Gm-Message-State: AOAM533xJG15XX7iFg8XmpeikgSE65GPDuU80/7he2/wyJPdmUugcCjf
        o5g3ksalZNAaXt95iSVxfLy5oq6piu4=
X-Google-Smtp-Source: ABdhPJxskQrn2yMoPvDeTXAkAP81blTNqvruZRsd5u1fHKxi9mqXaxCL93fgG9Zlnd6PhbXK9bWDLg==
X-Received: by 2002:a1c:2e04:: with SMTP id u4mr15003717wmu.79.1612795947261;
        Mon, 08 Feb 2021 06:52:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18sm12993278wmp.19.2021.02.08.06.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:52:26 -0800 (PST)
Message-Id: <8012d2dc1420b71404b8db23a88474b5fabaed83.1612795943.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.871.git.1612795943.gitgitgadget@gmail.com>
References: <pull.871.git.1612795943.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Feb 2021 14:52:23 +0000
Subject: [PATCH 2/2] maintenance: incremental strategy runs pack-refs weekly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sluongng@gmail.com, martin.agren@gmail.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When the 'maintenance.strategy' config option is set to 'incremental',
a default maintenance schedule is enabled. Add the 'pack-refs' task to
that strategy at the weekly cadence.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/maintenance.txt |  5 +++--
 builtin/gc.c                         |  2 ++
 t/t7900-maintenance.sh               | 14 ++++++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index a5ead09e4bc2..18f056213145 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -15,8 +15,9 @@ maintenance.strategy::
 * `none`: This default setting implies no task are run at any schedule.
 * `incremental`: This setting optimizes for performing small maintenance
   activities that do not delete any data. This does not schedule the `gc`
-  task, but runs the `prefetch` and `commit-graph` tasks hourly and the
-  `loose-objects` and `incremental-repack` tasks daily.
+  task, but runs the `prefetch` and `commit-graph` tasks hourly, the
+  `loose-objects` and `incremental-repack` tasks daily, and the `pack-refs`
+  task weekly.
 
 maintenance.<task>.enabled::
 	This boolean config option controls whether the maintenance task
diff --git a/builtin/gc.c b/builtin/gc.c
index 8f13c3bb8607..8d365a59d027 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1352,6 +1352,8 @@ static void initialize_maintenance_strategy(void)
 		tasks[TASK_INCREMENTAL_REPACK].schedule = SCHEDULE_DAILY;
 		tasks[TASK_LOOSE_OBJECTS].enabled = 1;
 		tasks[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY;
+		tasks[TASK_PACK_REFS].enabled = 1;
+		tasks[TASK_PACK_REFS].schedule = SCHEDULE_WEEKLY;
 	}
 }
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ef4527823d29..fa92e01fb2c5 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -406,18 +406,32 @@ test_expect_success 'maintenance.strategy inheritance' '
 		git maintenance run --schedule=hourly --quiet &&
 	GIT_TRACE2_EVENT="$(pwd)/incremental-daily.txt" \
 		git maintenance run --schedule=daily --quiet &&
+	GIT_TRACE2_EVENT="$(pwd)/incremental-weekly.txt" \
+		git maintenance run --schedule=weekly --quiet &&
 
 	test_subcommand git commit-graph write --split --reachable \
 		--no-progress <incremental-hourly.txt &&
 	test_subcommand ! git prune-packed --quiet <incremental-hourly.txt &&
 	test_subcommand ! git multi-pack-index write --no-progress \
 		<incremental-hourly.txt &&
+	test_subcommand ! git pack-refs --all --prune \
+		<incremental-hourly.txt &&
 
 	test_subcommand git commit-graph write --split --reachable \
 		--no-progress <incremental-daily.txt &&
 	test_subcommand git prune-packed --quiet <incremental-daily.txt &&
 	test_subcommand git multi-pack-index write --no-progress \
 		<incremental-daily.txt &&
+	test_subcommand ! git pack-refs --all --prune \
+		<incremental-daily.txt &&
+
+	test_subcommand git commit-graph write --split --reachable \
+		--no-progress <incremental-weekly.txt &&
+	test_subcommand git prune-packed --quiet <incremental-weekly.txt &&
+	test_subcommand git multi-pack-index write --no-progress \
+		<incremental-weekly.txt &&
+	test_subcommand git pack-refs --all --prune \
+		<incremental-weekly.txt &&
 
 	# Modify defaults
 	git config maintenance.commit-graph.schedule daily &&
-- 
gitgitgadget
