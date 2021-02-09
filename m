Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA3DC433E6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4D464ED2
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhBINpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhBINnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 08:43:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96A5C06178A
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 05:42:35 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so21874255wrz.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 05:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D+M6pr6oWKUqk3Ewhp2PVkO4UkRC3UrEK0yzXOdMM78=;
        b=s5RFiL+dSdUBm+scdk11SpOm7iehtoK3GLMbuZldc7ZknlCyMloiLiE6xYRoz9FHLj
         uC3niZurN1Rf+ltj4iFajYYC84w/oqo1DT1HvXLB7WJe4lpS6PZcHmerKeSw/V212O7d
         HqOVhIsqKmL8iH/mWru0rp4ny1aXia+kLcTqObjHd3/WU0+yGY/a8ARda/s2TGpqiXDj
         JRO17d1y5dKGIt39qR+e8sIiIXou9DQFIozm4zAsfRAZZQl8Es96gInm003VBKppP3kB
         i9JeRdyhRkDtng7RzQks9k6uvIXZdojV1u01FEWKwEbxQAEUoPt2KxITIlgNFOgoN05T
         jvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D+M6pr6oWKUqk3Ewhp2PVkO4UkRC3UrEK0yzXOdMM78=;
        b=TP6Ls3MjByiSkYK7TjpTL4TFglXC8+LONmZukns+9vEYtG2qAPHCHAtP6Wfj18HWLV
         RhLw1+pn69XyutwscmfPk66kANf6To8DV6g0KsuEpkw1CdJ9zaWvNMqb4ePk7NsWrwaT
         ImS50wse7Q0FZRBthS9l9fFbgtgRxFh6q6iMk/vEfmkQwS2ab0KkQ+g+kRBrw0ydE2H5
         +IXMJ4W3b55ov6Y/UPjos02pzWO3IG9wfVQ6qmfbdf5hX5Pfhsp1hX58ESF2QqHfI47P
         W9xICt5xo7D9+CFLfbqE7hIF2KuCuvruKqM3SDdYEdynBsoMUTHIh8ERY0b4sBTp6cLy
         mSRg==
X-Gm-Message-State: AOAM531QarbBHVaV34GmWPzQThbdpDW2+AxL/DfSyrGvF3LAHMqfImED
        Ed7S98NPrqRjFCxytAZYMzVGgGzfvvk=
X-Google-Smtp-Source: ABdhPJzcVxPmzHEQpVIJAX+TqajDQenNHrV0ja4zOvw2gtOt17/USNRsHZNl2R7b/8V6Y75RxPp9xg==
X-Received: by 2002:a5d:554a:: with SMTP id g10mr16428215wrw.383.1612878154489;
        Tue, 09 Feb 2021 05:42:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d23sm5003668wmd.11.2021.02.09.05.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 05:42:33 -0800 (PST)
Message-Id: <c38fc9a4170ee8fcc9be9d2a081138786847aff3.1612878149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.871.v2.git.1612878149.gitgitgadget@gmail.com>
References: <pull.871.git.1612795943.gitgitgadget@gmail.com>
        <pull.871.v2.git.1612878149.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 13:42:29 +0000
Subject: [PATCH v2 2/2] maintenance: incremental strategy runs pack-refs
 weekly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
index 41bec4f177b3..6db9cb39e679 100644
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
index 4a8a78769bd6..286b18db3cc2 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -408,18 +408,32 @@ test_expect_success 'maintenance.strategy inheritance' '
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
