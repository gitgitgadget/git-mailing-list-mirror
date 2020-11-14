Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FEAC6369E
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C337222267
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgMLZzXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKNAew (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 19:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgKNAeu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 19:34:50 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCEFC0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:34:49 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id w24so13536689wmi.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tli/2DVPWhBZTlOxbzWYQvd2w5EWfJsrm0epbkKGYY4=;
        b=qgMLZzXdbiQiq2YcgKN9hE3+1czr/OFtlwQIBUnrECFLEwzW4gCXFFP9IMubpR2Ov/
         EziAy3qOAXnveqHpPehN5yIavzo9fCkE+Wf+RFmgVpLioMO2hYQrNbN5IuF5rJHIhe3X
         2fazC6hMkabUF8nzN7NnaK2X98QqxCPCMzOYEXggWGU5ejN3NPK2PRnsTtF2P2reVj8m
         xrOOV7R8jBa4oAIfA1laV13mXAVg4hROjiPs8V7ofdNVf3eWYVkFBoZmaebLaI0rcaxy
         I4POEVRW2mrz3ynIbgdScq5jjQQY9fLDsYJZERjx00t51HRNy6tGdw71VOuUGZagQ5N2
         Sagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tli/2DVPWhBZTlOxbzWYQvd2w5EWfJsrm0epbkKGYY4=;
        b=jylmrRmp4ntyYye4I6VTmBxMZ1NFt1vmupMr7chPh5MXS6SHeShJd+1GqsT5CakEAR
         0C7WMI78ktjUx1JQy+uVI002xi1ltu4bhUdmlB6tfJIbyuW+sgLAJEWa1hTcBYoK5olW
         TJCFfjWLqwOAXtseqMR0OpqUK3yG9bm97MhL6XtFNdCLFk99fLflvR8ziuV0dl5oU99f
         kLH8qiC90PGUwe2Ojf5VIAyLCM/Y4c14Db8Hrn3YlaGBfjl2QbW3RVI0LmGBPY8jtNxd
         BRhIvVGHENejjY22y0l9D8v6I3agbj61Mj3LGPkYTCxE5jX9qx9lumOl5c1doBbKx7VJ
         Mw0Q==
X-Gm-Message-State: AOAM5326TllOxPsDU9vmgol18Et9keskgsq3GYS7JE+5bGHnWbIqO7Zi
        xrhtfet5KPY8Olw9mJN2FoPMNyFDwQE=
X-Google-Smtp-Source: ABdhPJyQVJzCyJwCcqMMAzXnWYSW4I4O/fT3Mqpl9Sj+g1mRLlDJGhaIA7KqoQk/b4I9uhbjjdAKRg==
X-Received: by 2002:a1c:7d03:: with SMTP id y3mr4974827wmc.58.1605314088506;
        Fri, 13 Nov 2020 16:34:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 71sm13457195wrm.20.2020.11.13.16.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 16:34:48 -0800 (PST)
Message-Id: <4a124031400c38d7b44298a3328e4e81d756b637.1605314085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.789.git.1605314085.gitgitgadget@gmail.com>
References: <pull.789.git.1605314085.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Nov 2020 00:34:44 +0000
Subject: [PATCH 3/4] t5572: describe '--rebase' tests a little more
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Brice Goglin <bgoglin@free.fr>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

It can be hard at first glance to distinguish what is different between
the two tests 'recursive rebasing pull' and 'pull rebase recursing fails
with conflicts' in 't5572-pull-submodule.sh', and to understand how they
relate to the scenarios described in a6d7eb2c7a (pull: optionally rebase
submodules (remote submodule changes only), 2017-06-23), which
implemented '--recurse-submodules' for 'git pull' and added these tests.

Rename the tests to be more descriptive and add some bullet points
comments describing the different scenarios.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t5572-pull-submodule.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 7f658dba6d..7d9e12df4d 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -101,7 +101,12 @@ test_expect_success " --[no-]recurse-submodule and submodule.recurse" '
 	test_path_is_file super/sub/merge_strategy_4.t
 '
 
-test_expect_success 'recursive rebasing pull' '
+test_expect_success 'pull --rebase --recurse-submodules (remote superproject submodule changes, local submodule changes)' '
+	# This tests the following scenario :
+	# - local submodule has new commits
+	# - local superproject does not have new commits
+	# - upstream superproject has new commits that change the submodule pointer
+
 	# change upstream
 	test_commit -C child rebase_strategy &&
 	git -C parent submodule update --remote &&
@@ -116,7 +121,10 @@ test_expect_success 'recursive rebasing pull' '
 	test_path_is_file super/sub/local_stuff.t
 '
 
-test_expect_success 'pull rebase recursing fails with conflicts' '
+test_expect_success 'pull --rebase --recurse-submodules fails if both sides record submodule changes' '
+	# This tests the following scenario :
+	# - local superproject has new commits that change the submodule pointer
+	# - upstream superproject has new commits that change the submodule pointer
 
 	# local changes in submodule recorded in superproject:
 	test_commit -C super/sub local_stuff_2 &&
-- 
gitgitgadget

