Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B41EC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5278F6115C
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhEVN6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhEVN6k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B529C0613ED
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a4so23771771wrr.2
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=twSYMslETglXq2k4sozymNKhyot6vWiv7GZce15S1Ec=;
        b=LA4SOGuGxfPT8TQesKS+MBidL1/Fcfq469dyhMNgPk/rb5eTBiVexEpe9xXd8CUdhY
         G5V5lv5ktcS8GZTILPYomiHF/XIf/DtPviBLbgMjZniJI0LXLHQL7RoKMU10kA6F+K9m
         wsxsMiNGrcfgSSsR/UQSQCmKO0hUDoKrPPK7T3kY1rqZ51g9IEkiSCxuwp1UZgaQ+f5D
         zmg9wHy7R5U6Bk/UfwDoUwYUcI4MUCpxCjaHfJs0+D3INNtMVNb84D6/X2ph1V5oziov
         Gxo0DHG9HsoLKbov5yrBXchdbz/6Tv5VjskfPvih+2RANB7OAN6hyo+twX6k09Q9BLt1
         EdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=twSYMslETglXq2k4sozymNKhyot6vWiv7GZce15S1Ec=;
        b=f5y9hSi2Ce4wDZkqI1zRlLihOFgYCl9vFeCItaA3E8Gkf8vRK7xHKyHtNPrVxwpb2O
         rntguv6XLXUZEdlc6IyfeRW8pqDUxMkoMZ4ygarbCn9isr9pQHdOwl6Hw2thVwrdl9TP
         ViegszaJFvV6z4fYVmaXDvyKVSbAVot6gC+0PbJqkYw4sg+ELaWmUL/LLI3UnK9Ve11d
         mlypJWstOne7+7hhN4W4mWp5ddY3y0iEwwBrtx+1lS+uHVFf1IPJg7zn7Te4ZbLcOcRm
         ty/HZwhiKqSkiLYL5ljXS5Af2B5JDsGGs/y/36GBTO2oVBXlsIW6K3PcgaoHG53YlsD5
         cgUA==
X-Gm-Message-State: AOAM5323FZaUtMqQezDDoVuS28aQU2P+FcCgV93XwQDEjm/hSe/6sDNg
        2eeNLWnYguVxXZJ4LcaU0RicQQhs3kw=
X-Google-Smtp-Source: ABdhPJysfEMQNd7taRi8lQrtz7LtbkwyYWf8IkjP3k5Dix0WTquwHP2iAxEJc7pSlUsIIVMnakqHhQ==
X-Received: by 2002:a05:6000:18ad:: with SMTP id b13mr14428979wri.343.1621691832123;
        Sat, 22 May 2021 06:57:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm5412040wrt.97.2021.05.22.06.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:11 -0700 (PDT)
Message-Id: <fc180e8591bfaa41d31f8311c1fecb5f1c1be936.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:56:41 +0000
Subject: [PATCH v2 02/28] fsmonitor--daemon: man page
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
index 000000000000..154e7684daae
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

