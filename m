Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C65C2BB84
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 15:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D28A20772
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 15:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNPEmgeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIDPmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgIDPmX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 11:42:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FCDC061258
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 08:42:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so6460981wme.5
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Cf/9rLerrKy0dWPIT/MDxkaFTJmcOoY5Q1E+Hba6jjY=;
        b=CNPEmgeKMdEXyKBJbBWfsQ/h4T9nW8dF6tx5JuTZ95P6DhKJqOlzCcunyNbdKpDqtM
         O67pBPnCi0Nv7U9Nq0RzWutnxqhOn8j8VYO/uSgOYCUlon7YjjtebwUkxghGcuSrgZiH
         5z0rLyBCDNespLZWdKsBx56po9lxjFNY/3AStQz67loMKMPFSpOOxv11kUjZCcnfy5go
         AnW4J7ro8cQH3+KBZ+0/3Nqm7ALmp6ncMJ3q4eXB4pPTFUn6oguvUvqhZ4sZLAscV5nb
         uVtLZsikYFDEB5GDsWzLZxU3J0BFcM2Voh4WEJyY0MSw8ulVbYNC9NzYh/isRAuZFjzF
         Ru9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Cf/9rLerrKy0dWPIT/MDxkaFTJmcOoY5Q1E+Hba6jjY=;
        b=SQU3kF7jCmMGMkxSO+b+aMYqkr/objQ37Qzo6JFdlR936ZZU/YHoh9L8jIrYpvrQsV
         AbCMJztzAKmuMH3KC0Kzcy9p0jC3FVGoKrMbOigqN99ELzdq6GAe1yX94cOB1znUzQlm
         uDCnebTLRFgSMx1L5bvFxHZVfLZVJgBLIzhOMGENPlh31MBZlbv179WZf5TKaAqJOB40
         RQmZsCzlYvQOJKM0ym5P7IFeZ5sNpC0pTYj88It+XqRd/vVAf+YjGO11D3IAFYxRL4IA
         CV+rvoVg6ip5+LaO3pgp4r/RCDzh9RgNYcRxDokKgPK/TBq4XPQ6hJsoNMYRXhzdcOXA
         cjvw==
X-Gm-Message-State: AOAM531IXEqGEgiXTXAYxhMKd2lG+SjVTwZDjUFukKBh1Ul8s5uCRbxh
        CP3Gh2xCGofe15fkTvJkY/w7IykkndI=
X-Google-Smtp-Source: ABdhPJwZWPn5ClbLh875ywzAknf0tczTpWCCnPuUIC7KxLDxfpknnshuxs7RdeDMjBD7WBk559r6kQ==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr8276899wmg.178.1599234134105;
        Fri, 04 Sep 2020 08:42:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m185sm13085658wmf.5.2020.09.04.08.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:42:13 -0700 (PDT)
Message-Id: <c00de53906efd914b32995c7b5be989586faeda2.1599234127.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.git.1599234126.gitgitgadget@gmail.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Sep 2020 15:42:06 +0000
Subject: [PATCH 7/7] maintenance: add troubleshooting guide to docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
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
index 364b3e32bf..f58dd60e40 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -161,6 +161,50 @@ OPTIONS
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
