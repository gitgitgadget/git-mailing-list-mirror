Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA9BC4363D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD89C20874
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3lBKu9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgJENEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgJENEK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 09:04:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85D9C0613B7
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 05:57:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n18so1633965wrs.5
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lHGs8NOv3ROvd3brhi9use7jNjcKsphiI2pW+nWzM4I=;
        b=A3lBKu9TK6DprEr3IGJeJLVc73KSHCwn9DWEVBiJ1z8sVb5C4yvdsI3nrnOkNysUaY
         /Zx0f4mn+OuOZH6oYFzZ8kyQImbgiveIkNjJoi/huEicKwq4ZwsOqY6mXPGCPlZYQQVO
         TFh5XCXAesXCgXJJaquskWCZycBIQ51EuFesVv16/Wpsq/Up4bP1044h0NIHMgetjgrz
         ulpkD/0SOrODJsRQ2LmSmaZFYAlS/mUCh960XMrVOulI/v8GaVHhqYJDS9cVgp/NaxDY
         3pzbL9lC6jaHlIKGQYH77ZL+b9+Q+bRIYpmhPJD6ct3ndsHIK2M1XrSwqdtP2eX15cq6
         1+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lHGs8NOv3ROvd3brhi9use7jNjcKsphiI2pW+nWzM4I=;
        b=ANpzzeyS5HrCCV/y1x9Sec1u4CyW2PeB6t1GF/+feOXOan75XCtk5YQ/fCUREjpjSl
         rGr/52xY6Yce5chCuXuYwr+aykaQXm/8RyMGE7qQCrbkh1jlzxtGmCNgfpF6az161Ref
         KrP1/mhA/bRpZ1XvCPg+VL8zo8te4QRfdgUVon2L+aaz2TRQ/rjhipW7HFmPKB/fXmCg
         rlcQ5pV1sxwC9A+6VRQGBXqaQRMylM/7AU7U0HGNj2SmsHqXQ+2Em8fNW9oEFtzs5ZnU
         I6r/Dx2mbc/SA2ysSZpHoxkNFJ8nA42QavNGPe+Tm70YCaDFkzbQ0ivMJQUwkTgW5xfs
         HyVw==
X-Gm-Message-State: AOAM533hgrXNncrLDsJZlgiEyBUcKlvvQATiwneccs9sEZUkWF9njHTP
        TR5ghEMFK4GWXWBDuZULCi3z9XNluYI=
X-Google-Smtp-Source: ABdhPJzAhubFu5eYcwbgUmJ28KLDHZ3+HPLIUw+B43Jt6+z7PFAymZnCJHyVvVL9zAvFu1Un9QQjmA==
X-Received: by 2002:a5d:4311:: with SMTP id h17mr18031541wrq.398.1601902642360;
        Mon, 05 Oct 2020 05:57:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z83sm13001757wmb.4.2020.10.05.05.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:57:21 -0700 (PDT)
Message-Id: <8e42ff44ce9b28a070648cf760f94e2543cf0812.1601902635.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
References: <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
        <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Oct 2020 12:57:14 +0000
Subject: [PATCH v3 7/7] maintenance: add troubleshooting guide to docs
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
        <congdanhqx@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
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
index 52fff86844..738a4c7ebd 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -173,6 +173,50 @@ OPTIONS
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
