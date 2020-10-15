Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B71BC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35A522254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAaavqBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404930AbgJORW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404921AbgJORWO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:22:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC78AC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so4644224wmj.5
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HiSdWXPJhDQ+dA7XW/UjlmXQuV26h4Lnrh5TOwNR2zE=;
        b=jAaavqBO4+mOGGui66kgFxGvWxf2d58Ifx+cCK0X5iIuim4D60njYjQXgshnXV79B/
         sm8lGPDgvYOE4dwstIyHWlb7+RIWzSWKNhUiwJfaVZQnzToR8EdDQOpfctogaFG3GM+K
         xn9gJ9OX6ohd+2wk8o9ZNySa8Ap/NhHnB9N5tGmhcOyUPbQWU180tAW8uTDZEmHGT2jM
         mI94vG/G8PHHFFrHlNYRQJ7+wU8xJZIWxZRALrYBboxgCt+qGY+U0JNiqYFkmfPHzoyP
         aY6zegMmfzIABi1XRNUsWcXZnlWbZOksQwVZxVNJ2PDxdxxaoUVFYZf/gT06hkhdCmlj
         QA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HiSdWXPJhDQ+dA7XW/UjlmXQuV26h4Lnrh5TOwNR2zE=;
        b=WCi3dsDShkiTctIROqYX8eseZLqROzaoC8KH+2eYecC5GxqltJms1iQ9J6+cA4Mc+e
         bybOPNyDgzAoujR5WcbDP+mVtPYbpuA0r6ydZ/IsHn7QoTvL6IkSyNhFkq5lLvfVzQTB
         Q/S3VNlFuN62vI8VR4UihqHWk5LKAhVyPala29tg8jvxuhYUJe8JzNMPA6fF/hY0Qumb
         3JX1aolkQ2pVOfl1S4nCJEMO8MBdHpOKdVxiGXp0oWrgK0Y8LVBFamreuyngxZfQzcla
         9rqlULNO+Imch1a/KwBYJx2FONbnu3NJerJ1DxxzDv2RivfcDG6hu39PaKaOjtBBwg1x
         Udnw==
X-Gm-Message-State: AOAM530HTubVRGHDDfC5+/ZTKmfGcV6ydILKdFBgz7qHBFNZKb6pvDhI
        ikVcglZ7f13XqcOne+x5ONnM13Yo1NU=
X-Google-Smtp-Source: ABdhPJwR9XTWsbqIXp2LRsnER7/B8QIoioB5+z6BhLeBki9MxjoOK/ex/5QgfZSHPFrK2AZi8HBC6Q==
X-Received: by 2002:a1c:e283:: with SMTP id z125mr5396170wmg.154.1602782532318;
        Thu, 15 Oct 2020 10:22:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t7sm5482219wrx.42.2020.10.15.10.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:22:11 -0700 (PDT)
Message-Id: <ce0ced705fb48ef0afc62caa3c2325d3fd4c1d55.1602782524.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
        <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 17:22:04 +0000
Subject: [PATCH v4 8/8] maintenance: add troubleshooting guide to docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git maintenance run' subcommand takes a lock on the object database
to prevent concurrent processes from competing for resources. This is an
important safety measure to prevent possible repository corruption and
data loss.

This feature can lead to confusing behavior if a user is not aware of
it. Add a TROUBLESHOOTING section to the 'git maintenance' builtin
documentation that discusses these tradeoffs. The short version of this
section is that Git will not corrupt your repository, but if the list of
scheduled tasks takes longer than an hour then some scheduled tasks may
be dropped due to this object database collision. For example, a
long-running "daily" task at midnight might prevent an "hourly" task
from running at 1AM.

The opposite is also possible, but less likely as long as the "hourly"
tasks are much faster than the "daily" and "weekly" tasks.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index b5944b4c51..6fec1eb8dc 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -175,6 +175,50 @@ OPTIONS
 	`maintenance.<task>.enabled` configured as `true` are considered.
 	See the 'TASKS' section for the list of accepted `<task>` values.
 
+
+TROUBLESHOOTING
+---------------
+The `git maintenance` command is designed to simplify the repository
+maintenance patterns while minimizing user wait time during Git commands.
+A variety of configuration options are available to allow customizing this
+process. The default maintenance options focus on operations that complete
+quickly, even on large repositories.
+
+Users may find some cases where scheduled maintenance tasks do not run as
+frequently as intended. Each `git maintenance run` command takes a lock on
+the repository's object database, and this prevents other concurrent
+`git maintenance run` commands from running on the same repository. Without
+this safeguard, competing processes could leave the repository in an
+unpredictable state.
+
+The background maintenance schedule runs `git maintenance run` processes
+on an hourly basis. Each run executes the "hourly" tasks. At midnight,
+that process also executes the "daily" tasks. At midnight on the first day
+of the week, that process also executes the "weekly" tasks. A single
+process iterates over each registered repository, performing the scheduled
+tasks for that frequency. Depending on the number of registered
+repositories and their sizes, this process may take longer than an hour.
+In this case, multiple `git maintenance run` commands may run on the same
+repository at the same time, colliding on the object database lock. This
+results in one of the two tasks not running.
+
+If you find that some maintenance windows are taking longer than one hour
+to complete, then consider reducing the complexity of your maintenance
+tasks. For example, the `gc` task is much slower than the
+`incremental-repack` task. However, this comes at a cost of a slightly
+larger object database. Consider moving more expensive tasks to be run
+less frequently.
+
+Expert users may consider scheduling their own maintenance tasks using a
+different schedule than is available through `git maintenance start` and
+Git configuration options. These users should be aware of the object
+database lock and how concurrent `git maintenance run` commands behave.
+Further, the `git gc` command should not be combined with
+`git maintenance run` commands. `git gc` modifies the object database
+but does not take the lock in the same way as `git maintenance run`. If
+possible, use `git maintenance run --task=gc` instead of `git gc`.
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget
