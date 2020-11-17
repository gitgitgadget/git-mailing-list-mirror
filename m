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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3F8C63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FFB2463D
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM+c03+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgKQVNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgKQVNX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:13:23 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD03C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:13:23 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p19so2839492wmg.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sp0JJOb8Xo2lvjjF5FxDXSrq7tug88l9uB9y6jDD9mM=;
        b=fM+c03+p8d8LYSQ1b49tICJ3Q5QlPpFbMgLBB9xtcnD9/83sXK97328DNSiaraUNAl
         SxbIjpbNxG/Mef3do75dfajCjrEA95P7xDNLMS16UUwarZi1ULT2GjQm25U0hSXoIjLG
         Fu6bNIccENrak4+5uZRYIO3PLkTgTH0iMbLB2YgcNIxeP5tN5IJVHyGfO5zfp6Qih8b3
         YWK7UJgMiay+yfxNVj/1lOi1Htjc8DabbFo9untoUIFEH4nrcltnOpNr1feuAxEnnE1r
         uZxXZvwpegCCPvpB2Br78dUBLnULbpgCFzjJg+pDpd4+Rj8e4SWP4RGynsSKZui3qZpP
         isiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sp0JJOb8Xo2lvjjF5FxDXSrq7tug88l9uB9y6jDD9mM=;
        b=PIRFrXuiyYyShqk/nFKLTPSnuTe5YoK3K40mtXOZfdo5YuAPuOnifkoR342f6uHRxy
         wSKkjRf57UCILYwuxw+P8TytLwF2qhIfkT4taUmpHmO5PpIb89IuuOZ7f9234oSMoVDw
         3rthsL5EI4RaErutvIGxhERU2kDRP/oMRQ2nPQjelKoEzkqvresoLfdiFKrYBXmE9WK/
         95WHirmaG0iIjPWs4iKe/F7Sny9Hb3LwqVaYTW/23mMb3dJMN6/TwnPD7z4bxUg5W5ZF
         4s/8pNkaP6wxXsxMJL2qXeAR0sMTTQhv/+LVwQttTxplcptGMnaTJ8wJNIN0DHuvacuh
         p8HQ==
X-Gm-Message-State: AOAM531rpToF4n1DDv18m+1+LfHZdW8jWw68ydRzQa7o1RPqlJtM0ySO
        2srLKtgY2W2I/779o+0g6ug2UFoBXd4=
X-Google-Smtp-Source: ABdhPJxdbuPMD/4aGf2o832/98UKvSo3IP0wGAeMEgpSdkhR1WMCw9B2AnB3oppizmeKxpVqbGL0LA==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr978326wml.174.1605647601622;
        Tue, 17 Nov 2020 13:13:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13sm30465628wru.67.2020.11.17.13.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:13:21 -0800 (PST)
Message-Id: <99170df4626544c1dc26d2e188b215a776140a32.1605647598.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
        <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 21:13:16 +0000
Subject: [PATCH v4 2/4] maintenance: include 'cron' details in docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
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
index 6fec1eb8dc..4c7aac877d 100644
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
+is `cron`. This tool executes commands based on a given schedule. The
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
+The `<path>` string is loaded to specifically use the location for the
+`git` executable used in the `git maintenance start` command. This allows
+for multiple versions to be compatible. However, if the same user runs
+`git maintenance start` with multiple Git executables, then only the
+latest executable will be used.
+
+These commands use `git for-each-repo --config=maintenance.repo` to run
+`git maintenance run --schedule=<frequency>` on each repository listed in
+the multi-valued `maintenance.repo` config option. These are typically
+loaded from the user-specific global config located at `~/.gitconfig`.
+The `git maintenance` process then determines which maintenance tasks
+are configured to run on each repository with each `<frequency>` using
+the `maintenance.<task>.schedule` config options. These values are loaded
+from the global or repository config values.
+
+If the config values are insufficient to achieve your desired background
+maintenance schedule, then you can create your own schedule. If you run
+`crontab -e`, then an editor will load with your user-specific `cron`
+schedule. In that editor, you can add your own schedule lines. You could
+start by adapting the default schedule listed earlier, or you could read
+https://man7.org/linux/man-pages/man5/crontab.5.html[the `crontab` documentation]
+for advanced scheduling techniques. Please do use the full path and
+`--exec-path` techniques from the default schedule to ensure you are
+executing the correct binaries in your schedule.
+
 
 GIT
 ---
-- 
gitgitgadget

