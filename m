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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688B3C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384E123C31
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbgLITbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387736AbgLITbK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:31:10 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8913C0619E1
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:29:07 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 91so2994905wrj.7
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gtvdyGfTmRDfT1qs0ZCAbuyHuiIlM022mJ22jXXFyKo=;
        b=hpvs/3VL0qzTZ3sF9r+jDHgSG3QGUL1kU3jUe2oizlhOJCn34lwBMRltgewX8FnLnz
         pLfI3rao5Ytt8APLuJPMcJ7CXDdc27xJhXV4NMh/Gzo8mHbl+KdcHJ8MQTUD43sfsznJ
         0tgNZoCd2S1eF+FtwG7xTEprmIQzAq8W4fzsu1PmcxpJVfrZ2CEPfLQQX8B70thVbxZU
         3sl6pxFimTMC0QooCILxeuL47N6k5oScW+VoiQ1EyJ8qDnBS6qq3oth3fAayVi5/E1cm
         bSPTpycIZhb7Z5z8Nj6lfNKGprbgEgFlKDXDYvCJg1ySp7G7UMLsvUbVtJs4MK2zQl+o
         XG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gtvdyGfTmRDfT1qs0ZCAbuyHuiIlM022mJ22jXXFyKo=;
        b=JweWVeLxA78PPabj+kBnbKoRmO5/0bHSYNBSfvByNciW7gk8AkfgpYwOqeu69sF92S
         BWaRvVP/pFmP0hvvUS7/gs8YmKKotpLin9slOvzMkNAn1xa0PGOCWQirZbiT7Finxhus
         muxG7fbbWSDzkJavdL5XYMVH1Jj9/FddyxwYoR4JTXpAwRIJpgw6nkcd1EB36pINMEm9
         aVPvfkEDWRRmr8iroedxkdGpOaK7L4DmtUdYKDCflIaIv32vYi5Gn9zWXTrVcxVq2aHv
         RNrthNBV+cTZRQWAIqk7Nvt2dimM5cZ+g79HKMwFeMxO6rcnNZv0oOw1ph0bbJTGqEll
         hN6w==
X-Gm-Message-State: AOAM531ekC9CRoOibiDB0CK44CQPLCWAXKUyOwc7vXUQVRyY2cd+Fxwe
        ChpnDXHas3cL/h3Kbb02EKj1v+KajuI=
X-Google-Smtp-Source: ABdhPJxRWq6nu1b0VO7IRrsoWUwU4hIO4eDlmYdO1IWzSKNNREddOZkqKXu3TwIDacekCU6zCAzuxQ==
X-Received: by 2002:adf:a3ca:: with SMTP id m10mr4355747wrb.228.1607542146213;
        Wed, 09 Dec 2020 11:29:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z22sm4601692wml.1.2020.12.09.11.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:29:05 -0800 (PST)
Message-Id: <7cc70a8fe7bad92179961b31520147af39d5353c.1607542142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
References: <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
        <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:29:00 +0000
Subject: [PATCH v6 2/4] maintenance: include 'cron' details in docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
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

