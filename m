Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3022C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F89A221EF
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWJPSJft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgIKRtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgIKRta (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 13:49:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72169C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 10:49:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so12238404wrn.13
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Cf/9rLerrKy0dWPIT/MDxkaFTJmcOoY5Q1E+Hba6jjY=;
        b=NWJPSJft5pz54RQDzMIzGGWCt+Ka5wgq7iyLtF9WMDCFbeMz3q83qAY817/8i/2tYR
         qMFpNGTsmAMBiABFasX85zIpY90niix+k+TMhliMCqpzqulUbLaovPGs0gvR258Q5Igs
         bxaWzeZosR6i7jCQrLNZXcXC6W5Jl22HcHIY8jbU+PftdUrXGx0ZtYH7d+GSP4w29PQk
         vLjux4ApAPFsug1Dsv5ESytuS/YlXCB/lI/CSmdUt8IHZFnkNUSU3CDmgkeYqEPfhjVA
         N/7TuHL/2akMYhmoovOYHRfO7ZOQaQV7OWAl6oS09uke0Uckwa5n/RSxMVoU0ZjHBO9J
         QY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Cf/9rLerrKy0dWPIT/MDxkaFTJmcOoY5Q1E+Hba6jjY=;
        b=M+EhLLaNBYH6LN/Eult0FPUA+PxAsNBOMG6lv+opPFR2kndwhKA/k04lalkSe5mlrb
         gs4IcA6VVdo3x5IrDFxi9wYH9OPOeDNc5Ks9ECT2/a5TDyQ66WZNyrePwLM69gMklo+2
         iMa03XmAOiFTAo+0JXhRYwEncv6LPKsrPw5aOn5flzHawYFa8DjmS3B7yuar9SZYSqRR
         VzZFmFFAl43ogWLyqFF1XwIRkAkSIRwgYSjhFANA60GOxqsXJU/BbSbV/WcBpDR7ZETp
         NRmxfhmg23rZ5EVxqLlT+r1QAQdbMZtL2BgNnwfYVJvEpwvaf/xhNkfKupA/xrvra+3z
         GMBQ==
X-Gm-Message-State: AOAM530xyQMyp+10nIYql9+HshWspT7UlEsoOxn6s50bqAM14n6lRf+S
        4afZN6kLyVFjXjIL0kVO1W5q26NRT2I=
X-Google-Smtp-Source: ABdhPJyALAtQQO/Atv9dFK8IQDbyex7OvtTggF9oNFIo4dny0I2wmPaSfpEDumQx9EzJDgJ+/SI/4Q==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr3170721wrr.52.1599846567964;
        Fri, 11 Sep 2020 10:49:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t188sm6171588wmf.41.2020.09.11.10.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:49:27 -0700 (PDT)
Message-Id: <2344eff4ba3f4e1ae1532c1521748c743732f236.1599846561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
        <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 17:49:20 +0000
Subject: [PATCH v2 7/7] maintenance: add troubleshooting guide to docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
