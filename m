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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136F2C64E75
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 04:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4442085B
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 04:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIp2eyl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgKXEQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 23:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgKXEQv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 23:16:51 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D69BC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 20:16:51 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so20866138wrc.8
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 20:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c3ckQj1fIW3U8Ln1uReV5M8x5QIwk6yY6Ii5rpTvUG4=;
        b=oIp2eyl0hpCXgR5GoFuDoGu4IENbZ48KmkF7lcRvjRd5Ua2hYi7o9jbXHOf+eO9lK6
         EDKYrDpwfANUoG3npR39tavIW3oD3qJwiox1y+bpKOCXYiubWWknU5Cuga29m+cabXOv
         Mp7ROC/Z8+FK/gP85bNNrzF0kzwiLNmwOCgKNkUCLTHAWTGVjgLt3548a3qjCwK4NrX2
         i1njBMy7nfzA0JxY5vIBVDK+YuBbAbI4z2U9ULSWg1OXNapfXGPvL1CSwhSqF3+6Elgx
         1Bc8buJdw8LmOzqQpB3MfWU/Q4SaBKaAOQhmLFBTnJYWkbdFhuy2hCleTsZT5eHHrasZ
         vzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c3ckQj1fIW3U8Ln1uReV5M8x5QIwk6yY6Ii5rpTvUG4=;
        b=puB5WgsaxhiD3fHdwNXH8qtdPvM52XwWcwbMSHrTcvlIU8/doySI+p3nMeLlh0yJ/d
         NF6w1EVFeoAm6kwtfUNWA2rTF5tE888HqcpXuC57jO43C5jd9a89Hba+mcZCbtmoS8PE
         2Q4nadyhZpBJ34A681+StrJTGatv90QR7NjJIB03myg+uzo8jIXGll73cBxWxMyRh/P9
         xaUV0Di1V7YpUfCVkQAcKGwH3BtwUjs81pGF29SBM8CqUBsjup5K8henCbblFSaj+jOS
         U9ZwajbNJ2Q1UHg99H9AERHEkY+kGET03U6mU9cyOUPO1HkcoAfMDb2sMqQQGQbYO2xL
         6Kkg==
X-Gm-Message-State: AOAM530sCIMoIvq6mnyAYKmYxw1at0MZtJQmUqz+X4bHBPAadhIgN9Nc
        s4vNx7KetKZ03ktsXkyTfGyqidiRRyM=
X-Google-Smtp-Source: ABdhPJx889nW0H7jtNZJEAKWg3NEnLZiRDtPSyZxs9YMYgOtSaGbj1X/SsCWB/WDXztgy8h7r8BMcA==
X-Received: by 2002:adf:f241:: with SMTP id b1mr2989968wrp.248.1606191409702;
        Mon, 23 Nov 2020 20:16:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm4104967wrr.89.2020.11.23.20.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 20:16:49 -0800 (PST)
Message-Id: <7cc70a8fe7bad92179961b31520147af39d5353c.1606191405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
References: <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
        <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Nov 2020 04:16:43 +0000
Subject: [PATCH v5 2/4] maintenance: include 'cron' details in docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Advanced and expert users may want to know how 'git maintenance start'
schedules background maintenance in order to customize their own
schedules beyond what the maintenance.* config values allow. Start a new
set of sections in git-maintenance.txt that describe how 'cron' is used
to run these tasks.

This is particularly valuable for users who want to inspect what Git is
doing or for users who want to customize the schedule further. Having a
baseline can provide a way forward for users who have never worked with
cron schedules.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt | 54 +++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 6fec1eb8dc..1aa1112418 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -218,6 +218,60 @@ Further, the `git gc` command should not be combined with
 but does not take the lock in the same way as `git maintenance run`. If
 possible, use `git maintenance run --task=gc` instead of `git gc`.
 
+The following sections describe the mechanisms put in place to run
+background maintenance by `git maintenance start` and how to customize
+them.
+
+BACKGROUND MAINTENANCE ON POSIX SYSTEMS
+---------------------------------------
+
+The standard mechanism for scheduling background tasks on POSIX systems
+is cron(8). This tool executes commands based on a given schedule. The
+current list of user-scheduled tasks can be found by running `crontab -l`.
+The schedule written by `git maintenance start` is similar to this:
+
+-----------------------------------------------------------------------
+# BEGIN GIT MAINTENANCE SCHEDULE
+# The following schedule was created by Git
+# Any edits made in this region might be
+# replaced in the future by a Git command.
+
+0 1-23 * * * "/<path>/git" --exec-path="/<path>" for-each-repo --config=maintenance.repo maintenance run --schedule=hourly
+0 0 * * 1-6 "/<path>/git" --exec-path="/<path>" for-each-repo --config=maintenance.repo maintenance run --schedule=daily
+0 0 * * 0 "/<path>/git" --exec-path="/<path>" for-each-repo --config=maintenance.repo maintenance run --schedule=weekly
+
+# END GIT MAINTENANCE SCHEDULE
+-----------------------------------------------------------------------
+
+The comments are used as a region to mark the schedule as written by Git.
+Any modifications within this region will be completely deleted by
+`git maintenance stop` or overwritten by `git maintenance start`.
+
+The `crontab` entry specifies the full path of the `git` executable to
+ensure that the executed `git` command is the same one with which
+`git maintenance start` was issued independent of `PATH`. If the same user
+runs `git maintenance start` with multiple Git executables, then only the
+latest executable is used.
+
+These commands use `git for-each-repo --config=maintenance.repo` to run
+`git maintenance run --schedule=<frequency>` on each repository listed in
+the multi-valued `maintenance.repo` config option. These are typically
+loaded from the user-specific global config. The `git maintenance` process
+then determines which maintenance tasks are configured to run on each
+repository with each `<frequency>` using the `maintenance.<task>.schedule`
+config options. These values are loaded from the global or repository
+config values.
+
+If the config values are insufficient to achieve your desired background
+maintenance schedule, then you can create your own schedule. If you run
+`crontab -e`, then an editor will load with your user-specific `cron`
+schedule. In that editor, you can add your own schedule lines. You could
+start by adapting the default schedule listed earlier, or you could read
+the crontab(5) documentation for advanced scheduling techniques. Please
+do use the full path and `--exec-path` techniques from the default
+schedule to ensure you are executing the correct binaries in your
+schedule.
+
 
 GIT
 ---
-- 
gitgitgadget

