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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A2EC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0282C6141C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhGAOuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhGAOuS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7FBC061765
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso4295634wmj.0
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qLUO8zfdh0xE1VlzgNb2Oce9n0gRtddKjmmxp+0Cu60=;
        b=MHtUXQf/Iz9bsRw8C3lvOKKbIWftuZgGkV8W9viNBmmiJ49hAXOj4uN6d4FI5MGGS9
         ncxPEw3JkQz0yHQHPOVobIp2yyTItQOejRlX2g70Er9biBIf/XrPm4bMlubxJaMTUDrQ
         SQ9BmfrG16Qag9RNnm5yQQRwOrfTejJkWWgv0kT/4gJHRtDZz7921rRsJf4pO4ZpgLAA
         36lZ3JNVwmuCniWpiDGnxu/ZJfQ48q8MXyGsKCuZoMpBpVCN6/Enbl/iPL2NKNsbq5nq
         9t2QtOi34uDulIYEsHMyk1tMMT2o8aXtcoR1apJKE39L3ZONQZswknknbf4ArXtdLiVI
         m72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qLUO8zfdh0xE1VlzgNb2Oce9n0gRtddKjmmxp+0Cu60=;
        b=S3O2SsnFNfvqDofGGHuYfXBexW3ZeVQWBRnpRwRiTim76J9vDmIfpVN/dSWYLuZgUU
         /aX/lT4e/UMcnn5iMIWLHiTnriI7A2NRWHY41RBwSkFIBYPJ2/Ju1GP2PIoKTzhHgQpW
         pwRyei5aSDkKu+VVVXgJ+SJ0cxJFCLhrIXkihnKzwnkjG1QS2A9+poVsQmD64j8ScgyS
         KAogACWnMafROFrwL3Tjo7JYEIpusy/xOnvOMMjQMTB4q95l5aYlMwo1O/O0QPF6NU/i
         ZQ0zG/VIQChNuIArF1ZSXlhyQxbYdQKQKVVHHIJzfKrJ+p6mGwwxNp2+HMCBRNTh4Esg
         TrlQ==
X-Gm-Message-State: AOAM531zIlCgHKfdozuRKK8+n/brSjvFMJTefbhXlFifAdbqFjMyzPey
        bbu4EFZsI7TwNyQD+121xzbvTwiwav8=
X-Google-Smtp-Source: ABdhPJx1Tv3b3iAYFlG/LhQP9griRMYWmAB7C15GGCGi2S+4TpYfjqjZPVGLqD7+7dcn6VQMSFF8OA==
X-Received: by 2002:a05:600c:4b99:: with SMTP id e25mr11042394wmp.176.1625150866926;
        Thu, 01 Jul 2021 07:47:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm121086wrt.86.2021.07.01.07.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:46 -0700 (PDT)
Message-Id: <5db2c0390a657d5790cf24404201505c4ec3a829.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:12 +0000
Subject: [PATCH v3 02/34] fsmonitor--daemon: man page
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a manual page describing the `git fsmonitor--daemon` feature.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-fsmonitor--daemon.txt | 75 +++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/git-fsmonitor--daemon.txt

diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
new file mode 100644
index 00000000000..154e7684daa
--- /dev/null
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -0,0 +1,75 @@
+git-fsmonitor--daemon(1)
+========================
+
+NAME
+----
+git-fsmonitor--daemon - A Built-in File System Monitor
+
+SYNOPSIS
+--------
+[verse]
+'git fsmonitor--daemon' start
+'git fsmonitor--daemon' run
+'git fsmonitor--daemon' stop
+'git fsmonitor--daemon' status
+
+DESCRIPTION
+-----------
+
+A daemon to watch the working directory for file and directory
+changes using platform-specific file system notification facilities.
+
+This daemon communicates directly with commands like `git status`
+using the link:technical/api-simple-ipc.html[simple IPC] interface
+instead of the slower linkgit:githooks[5] interface.
+
+This daemon is built into Git so that no third-party tools are
+required.
+
+OPTIONS
+-------
+
+start::
+	Starts a daemon in the background.
+
+run::
+	Runs a daemon in the foreground.
+
+stop::
+	Stops the daemon running in the current working
+	directory, if present.
+
+status::
+	Exits with zero status if a daemon is watching the
+	current working directory.
+
+REMARKS
+-------
+
+This daemon is a long running process used to watch a single working
+directory and maintain a list of the recently changed files and
+directories.  Performance of commands such as `git status` can be
+increased if they just ask for a summary of changes to the working
+directory and can avoid scanning the disk.
+
+When `core.useBuiltinFSMonitor` is set to `true` (see
+linkgit:git-config[1]) commands, such as `git status`, will ask the
+daemon for changes and automatically start it (if necessary).
+
+For more information see the "File System Monitor" section in
+linkgit:git-update-index[1].
+
+CAVEATS
+-------
+
+The fsmonitor daemon does not currently know about submodules and does
+not know to filter out file system events that happen within a
+submodule.  If fsmonitor daemon is watching a super repo and a file is
+modified within the working directory of a submodule, it will report
+the change (as happening against the super repo).  However, the client
+will properly ignore these extra events, so performance may be affected
+but it will not cause an incorrect result.
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
gitgitgadget

