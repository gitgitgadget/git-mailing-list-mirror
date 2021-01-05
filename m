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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E7FC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 13:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437B922B37
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 13:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbhAENJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbhAENJO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 08:09:14 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8467C061795
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 05:08:33 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t16so36130341wra.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 05:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gtvdyGfTmRDfT1qs0ZCAbuyHuiIlM022mJ22jXXFyKo=;
        b=JWsFbt0D3BmnlP+luXS5F63pV6nhtIrLrJvY7940lR/g/XotHPjceFiPFOrhY90noK
         GPds+oVokLWfvgF6jfPP7nL+VU9YByoXlyWhn41FIFly92/mYj1a4YtR/cdg87EvJtKp
         no6r+qWPLz+TO02o3HeRkPQJS1W6oClT7e17U0qfvSeOlp2HtwTIzC9+mNh1OMdE3onu
         YW/mtwUv8h7/+iiPSr4V/FRC0VKaiNYXCZGtOmeBqBRQSMPJumnpSFRHoe+XxB5n5+Oj
         Mo+H/gvcaOuFhrFTpdniK2MLPt3SDgCLDl7BwAjEoIzROA2uUSwaRPHLDWICKSR01vID
         M9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gtvdyGfTmRDfT1qs0ZCAbuyHuiIlM022mJ22jXXFyKo=;
        b=X3/Oaj1wV8seuB4KxRhB7du1crQFhBhqPfz0SPh5j+thQeiFNTi0XXZ65uBR1iXvbA
         5yzQQvQuWOL+0tFNsTiXpqysj05hSR1nJPr3rZ91TkMNuwyhWjGKP4rLW4hg7dSeojrV
         KroXmcXuf+mWt+iriOdsIZqU+tQqNlkOqwPwz/fmdGLuMZ0103MtarrpWutMPBf9ZURd
         SMf6oWrsM8OVdAHkU+mQfj6z5BQJkwIhrJjg9OGDucRWgijl/gPmAPdQF+JItXXXOUkr
         tcLgGB3er/q6wIKKPauGWtWAG4Jy6vMC9qlskYlPwlaDrYg++YIEBdsNW8pTtK1vy7NN
         9qvg==
X-Gm-Message-State: AOAM531WA/aNUlBbSJQdr4RGyfIqJjAu7omh6zjQMLMekJlcq+Qy3tjZ
        6qbavucctTt2fql2wUBmg37adIfs3e0=
X-Google-Smtp-Source: ABdhPJxNzB2sjn3rkbpGsRxnSqa0SLDPK2KSuiAMO0zircyPCvu2DXmMZyi3ngUNlv2CnnuWY4MQoA==
X-Received: by 2002:adf:f707:: with SMTP id r7mr87713775wrp.113.1609852112478;
        Tue, 05 Jan 2021 05:08:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm3873600wmb.37.2021.01.05.05.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:08:31 -0800 (PST)
Message-Id: <7cc70a8fe7bad92179961b31520147af39d5353c.1609852109.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v7.git.1609852108.gitgitgadget@gmail.com>
References: <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
        <pull.776.v7.git.1609852108.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 13:08:26 +0000
Subject: [PATCH v7 2/4] maintenance: include 'cron' details in docs
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
index 6fec1eb8dc2..1aa11124186 100644
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

