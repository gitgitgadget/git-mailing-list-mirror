Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E74C4741F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82D320739
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZS6u1eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgKDUGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730933AbgKDUGO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:06:14 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61B7C061A4A
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:06:12 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h22so3516885wmb.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=crAevSGeU87JXXQKVprQEEEipawYMwibuDxb+oIGOQY=;
        b=fZS6u1eqqIsRFidQv8NzgQZWn18v73MpBUGTVOVAsgqPBhULXNriqvI4fSf+BiS1Tz
         GyKihujx4e59xKa35bsYXf1OlvDqNs3nin3NMocOoSzxVni39ZeQoz5DW+QWlOb0oP32
         Z8tL0EelMCvBUL6O3DTNpesegkdJ5L1X4+HEHyX37FLi7VumdKon/LbWG3FqiX14qgqJ
         ver0zV08rq+ryDEY2yAdXvCCe+Wny1f3WF6LdKuJNtwnzH84o+rTmm349CdlcJpq8ApX
         DhTu90wiG8tfRzQL5Q8JEtdhfEARkE6n0VvilQVTJTKmW83pGWsZDdnb7UF7gwdSTHPd
         FkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=crAevSGeU87JXXQKVprQEEEipawYMwibuDxb+oIGOQY=;
        b=qR5SEotWREhmDF2jSOAmTJAdCLpVeCyG9DTAuuCXIXogtIpDFV8kLgWGZL8nN3Ek3K
         Mm8TNuZw71gZRs36btF40eUvvQHxIZVqccvSwBZddFzkczl5cwNSyj6gWDgZqZ27Q47m
         61pXici9OItwaoTEHIhAQx9ZSMNMi9YKnHlhSIk7A+YBWkuWtEhnuRMiPGjG/Er3eLnn
         n5ca0o8JSXuKhcytoAwapr58SyQ63POxojoSp0qkR4S028N/oUwHv40F+kF/5AwR1oST
         DZYsYT9NOe3tiCCUwuG2xXHUBgH3hzPsQsOqzwOLYEyLfmIIHmfx/QYPZgkmWrq1K4GN
         jT4w==
X-Gm-Message-State: AOAM533U8dnKRcM6bv5UUNfvxl4PY6zi4C9iy/j/wI+vBKwqu/t86AuV
        VvLFQvoA9r8qPHNd5LO2YqDvd0Yg2Bc=
X-Google-Smtp-Source: ABdhPJyZH7LBnaXmjxflcynIkgRhPkW/ulCuva9ck+M511fwT+EVHAiYHV47w09iTmoOzqtqDQ428w==
X-Received: by 2002:a1c:1d51:: with SMTP id d78mr6305619wmd.60.1604520371380;
        Wed, 04 Nov 2020 12:06:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm4448721wrm.27.2020.11.04.12.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:06:10 -0800 (PST)
Message-Id: <709a17372099351af3e3b9f2dddcd9ce220a9fcb.1604520368.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
        <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Nov 2020 20:06:06 +0000
Subject: [PATCH v2 2/4] maintenance: include 'cron' details in docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
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

