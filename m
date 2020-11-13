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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C67C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16402222F
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSwBBq08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgKMOAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 09:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgKMOAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 09:00:30 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D06C0617A6
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 06:00:30 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c9so8227999wml.5
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 06:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c3ckQj1fIW3U8Ln1uReV5M8x5QIwk6yY6Ii5rpTvUG4=;
        b=ZSwBBq08ZNRlLeb8PNHBWrfwn4rR4puzgjnl8g+UI0Velou0rZIIFbcu9aIHdbJqvn
         xGfUobRMjOPl7NGe5p6nKsnrzStf6JbX1DB1KSctX4TFBbMJ56utIEwr/rPn2NvbbeJX
         74JG4LOy+0gxW+xoSAPdHUndr6EhIERC2BlKybz7CVjmoZVFKxc79UcdbPrirV83Hrku
         aKWAvGCRTMaCvyxby7fXoVnElbjjCvaXkN7ZhG61eCuCNLyeHpqv8T6Fx7QtwEYm1kPU
         hi2FzU3FBVz15bg8vpY4DoyArlssYhcnGsZ/72UFvA7D/Zn9QppiDVynPaKQ/j3qSBP/
         iONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c3ckQj1fIW3U8Ln1uReV5M8x5QIwk6yY6Ii5rpTvUG4=;
        b=TCYct1glda7Nb5X733ML2YQiIJdN0VVbn0sNexQBFWuXLw36mFOY6S7Sib5sA67Lao
         DR4i6TfPqdvVGjvh9BSgzmnXzBzo9eS7tuRACEdGBtscJJF3JlAXtZ9muV93u5mAHMTD
         3VVmSaBgfoA1BTt+y1bhZzJ+x70fXOSRJa4wjK0ej2X0Go4f/obbXNkXXTkht0RsPA52
         a4Rurqq9BjkcCc0+Us/ajAzIIDPNQz26/rrEQeumNk3/36BPlRSbeFBhbjD01ApsoEmi
         RpOBpDys1H1QhONDH9pybOQSggYlqXzmCoP7zTIUsgo7Leqijc9BIv6ZFV5OrcE2ui6v
         hVrg==
X-Gm-Message-State: AOAM533eu1GaD7Z0jFdQtqw527WdeG1SlRhWgk1XOZJ41xHn88tWNAPI
        32UyOjrEkf8NTPongp5ABVpEANJnfGg=
X-Google-Smtp-Source: ABdhPJwoYR8oIh/Lkobp9FbCU/nm/nuCSOPZzjpPkliu2UmnrqzQby+utt0DypleA1H1fsIHIuewYg==
X-Received: by 2002:a1c:658b:: with SMTP id z133mr2604153wmb.1.1605276028829;
        Fri, 13 Nov 2020 06:00:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s188sm10450136wmf.45.2020.11.13.06.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 06:00:27 -0800 (PST)
Message-Id: <0dfe53092ea507e74260f2638c46c618fa554c94.1605276024.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
        <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Nov 2020 14:00:22 +0000
Subject: [PATCH v3 2/4] maintenance: include 'cron' details in docs
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

