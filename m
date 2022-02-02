Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9C8C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 18:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346725AbiBBSwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 13:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346797AbiBBSuk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 13:50:40 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA83BC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 10:50:40 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id v67so46621oie.9
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 10:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=delphia.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=XPz1pWmYVcsUWr0feSulwWjOMXQ8hDC/A0EjAV14vLw=;
        b=DR+VKG2MCosWEYApkG8d3rh5ayPQV2Z7XTYvZ3gOaRNbzW18H5oX0p0cBvcod9ip/6
         KA3s0nkWcn6uC7xTw77TQ0BSu43MVKZsDNfkDXO6q59WIaWx18LT1hcWkUTQk+HXEwtu
         2VyK1LADfLczHmTurZsA7EKs/sL50CYzDu8zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XPz1pWmYVcsUWr0feSulwWjOMXQ8hDC/A0EjAV14vLw=;
        b=jDxEfnHLfzhu1A8InxAxx0EPWQZ0tJZ4KoXXCUzOKkl3PExgtJJHvp3KoBSq9Mpxrx
         8Qh860xIFRpCkE/PRNOYSOuP0qorDPUYHCRsrEg4tCjT5ncMtlAriH2LS337rRuGygzn
         wf8Ziyk3kGFYD/yaroGc3lfi+bbOaCN0iKq8cAOd5ggnxitPZyRDqY+lHwFuhGIboa2f
         Mg2hsFdE5wSZVX3eFcq7UKXY0xWwtLz54mM+jWLgUjavCk/HePUQLSm3A3Sg7d7RSPev
         +CYXLhTVe9t0f0cwHRsF5qnZcaFKlyVD4EwRlp/JaIJLu5ZDMLXnBmnxvcK/FdAZr8pg
         LY9g==
X-Gm-Message-State: AOAM532G8PdG1GCa03Yrg4DCU+m5DaB3QkhfxpVkwTkwwpKirfYfJZ3z
        slZEi8X/8083qrlsSdNAXwFGwnp7lzghAQ5kE+fystMPWS1r
X-Google-Smtp-Source: ABdhPJxcyXphhHfIfvZOCiVwSI2vzKwQ6lRacHulxfu8gMb7zn0OBKFIknMWJrKcfNEuU3dObm9zfXV9bAPLtia95tY=
X-Received: by 2002:a05:6808:a06:: with SMTP id n6mr5636824oij.45.1643827839842;
 Wed, 02 Feb 2022 10:50:39 -0800 (PST)
MIME-Version: 1.0
From:   Zhuo Cheng Du <zhuo@delphia.com>
Date:   Wed, 2 Feb 2022 13:50:29 -0500
Message-ID: <CA+RO+X6Lat5-AZ+BoHwW8xzhXuNOTjQewyNAvzOjWF_Md0x_yA@mail.gmail.com>
Subject: Git Bug Report: 'git stash pop' always put newly added files into
 staging area
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
1. Create a brand new file, e.g. 'touch a.py'
2. Add it to worktree with 'git add a.py'
3. stash the file with 'git stash'
4. pop the stashed change with 'git stash pop', WITHOUT the --index option

What did you expect to happen? (Expected behavior)
I expect the file 'a.py' to be in unstaged area since I did not pass
the '--index' option to 'git stash pop'

What happened instead? (Actual behavior)
The file is found in staged are are after 'git stash pop', potentially
causing merge-conflict in certain scenarios

What's different between what you expected and what actually happened?
I want the file to be found in unstaged area. The 'git stash
push'/'git stash pop' combo works as expected if the file is already
added to worktree prior to this maneuver. I think the behavior should
be consistent for brand new files as well.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.31.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 21.3.0 Darwin Kernel Version 21.3.0: Wed Jan  5 21:37:58
PST 2022; root:xnu-8019.80.24~20/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.29)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
