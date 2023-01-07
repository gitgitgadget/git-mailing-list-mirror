Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB84C46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 19:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjAGTAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 14:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjAGTAA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 14:00:00 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4687DF0B
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 10:59:58 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4c24993965eso57179497b3.12
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u8zTqqVscn/fL/yqkptyivrozVNZhkoQYh9xPFvrcsE=;
        b=SY8SmeGA12SWGWWpoPkGkX8Am05WV6KB9JaeqPdCMEF4wM8u0Us20j1Jr1X6H7PG1O
         Z/toeMEbAfc0RfaDnEPBaOCyXKiq0zD2y3SG6TajozT0UHVaNM8VH+5BSccWU0p4MedN
         HEg//dI+ZlYhDHTPBMxRAc1oqnIPWJXZ5EX3sWQsRgoaPqEUe6Xjf2IRDkej4oXIdfh3
         tRTAEv4g/6LpPXleT3ZILNuhOPJ/AdA5o3Eh6Kp9fCKav4HEpgxMAWUy6qBA/tM54GUY
         g+XM9/PGuMnLeRiAcYMnA5pPB2ZBmQXbkN2JakZ4/S+6ok3dd42dcjGzApF8zy9f+VTd
         oWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8zTqqVscn/fL/yqkptyivrozVNZhkoQYh9xPFvrcsE=;
        b=6vyA7Xb9FibRVb10y5ppleA/QHGvHIWDmJudN9/C17mYf/snkPIh+ezp31kwD/1Mi6
         t+Vqm56+CaL+XHoCZ/+g8lMYIXWV0df6o3cMy3Q4nUbNYgVhcDNTCSHw12uj5hBGD0OE
         qvr+ch7CsEIPGC1m8EyJIuIJWPSehA2KKX/2dpdX8p9rngXpKpUf4RLF5IFpVtaY+GVA
         nw2fPUEOyqtEyJmao6bIrlP30f7YXfsEJeTOriqdzkmbV94+9tWLBNHPkGXM0Mjqaqhs
         ifvy8rhVYlZzFpvGZ5ER3zE+op0yMmcTShFarTgxNXcUc+z83DZfd9lJsyNaEj51Pk3e
         gEIQ==
X-Gm-Message-State: AFqh2kok4i26PfJy+6Q4yTkI4MiotdsCrZFIU6NY3Ciw/9+8YtLI/bPq
        hQQSrQTzQD3RGbtktIFSVMITeTICFP9uMFE0Xj16JSfX0ds=
X-Google-Smtp-Source: AMrXdXv1sfpW3aVFwIBECGaEcw2acLTjz7wO9QvOE0/Cxh9CRwC+RRTaVa2RWG+qfzc7nkLmCTeN6FbrwceM6ehjmP0=
X-Received: by 2002:a81:1603:0:b0:494:9357:5bd1 with SMTP id
 3-20020a811603000000b0049493575bd1mr4176135yww.273.1673117997697; Sat, 07 Jan
 2023 10:59:57 -0800 (PST)
MIME-Version: 1.0
From:   Preston Tunnell Wilson <prestontunnellwilson@gmail.com>
Date:   Sat, 7 Jan 2023 12:59:46 -0600
Message-ID: <CAC-j02OVoFDFjeGUjcs0ZMwPSXKLL_GBme2m2-ttzGTbxXNP-w@mail.gmail.com>
Subject: Bug report between git hooks and git worktree
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

I ran into a strange issue using git-worktree with git-hooks. I have
attached the output of `git bugreport` below. More concrete steps to
reproduce are available in
https://github.com/prestontw/git_hook-git_worktree-minimal-repo. I've
run into this both in macOS and Fedora---I've included the system
information from both of these systems below.

What did you do before the bug happened? (Steps to reproduce your issue)

Add a git hook that executes git commands inside of another folder. Let's
call this other folder `FolderA`.
(This might sound weird, but `flutter` distributes itself through a `git`
folder in some circumstances and uses `git` commands to see which version
the user has installed, etc.).

Add a git worktree branch/folder, `cd` to it, and commit something there.
Let's call this git worktree folder `FolderW`.

(Steps are outlined in more detail with an example in
https://github.com/prestontw/git_hook-git_worktree-minimal-repo.)

What did you expect to happen? (Expected behavior)

The git command would report details from `FolderA`.

What happened instead? (Actual behavior)

The git command outputs details from `FolderW`.

What's different between what you expected and what actually happened?

I would expect the git command to output details from `FolderA`.
It's confusing to me that there is a difference in behavior between
the "main" branch and `FolderW` in git hooks.

Anything else you want to add:

I'm seeing this both in macOS and Fedora. I've added that system
info below.


[System Info]
git version:
git version 2.32.0 (Apple Git-132)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 21.4.0 Darwin Kernel Version 21.4.0: Mon Feb 21 20:35:58
PST 2022; root:xnu-8020.101.4~2/RELEASE_ARM64_T6000 arm64
compiler info: clang: 13.1.6 (clang-1316.0.21.2)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
pre-commit


[System Info]
git version:
git version 2.37.3
cpu: aarch64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.0.7-301.fc37.aarch64 #1 SMP PREEMPT_DYNAMIC Fri Nov 4 18:13:35 U>
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
pre-commit
