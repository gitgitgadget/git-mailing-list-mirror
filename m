Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A649BC3DA7A
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 17:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLYR1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 12:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLYR1J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 12:27:09 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3A25F72
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 09:27:06 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r18so6104659pgr.12
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 09:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dR0cu5Zu5pk6FWJlXK24ZcM4XhH9x+DfrazC8qk/+VY=;
        b=M60+yqXPwtAhEjb7SU0C2giuO/joItwyrd6LKqfWcyfUhrdY5hYLIwl0GBuNlh/M81
         2/VrAdvJ32DxYDRO2OnhGXpzFEA+Kei+cBhVR0/M90rx3Kfbz4NAvceMVke6aiREcQfy
         flan9lpue5AukPkMwT+ZUhh/4B0RwhyzeaJXH6dtI9gBxn+lDpsCb8XINJRHTw0xH/sg
         I+JjcgVN6aYpgBK2h6jk16yXcz3JpK0CI8C/lzzCCmcL++HyMXAMCQNNJOMBS9K0uNxW
         K1u5p/oiiuhNKiST/2K6wt0EECOOrPPQgRC+Z7oFe6YZp5pAotW6e2TTJVFkX2CacLL9
         7iOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dR0cu5Zu5pk6FWJlXK24ZcM4XhH9x+DfrazC8qk/+VY=;
        b=XNnxZH3U0BJATQzOJnAVFRN8c/h/QjNarDx6ShoY9JPk1FmClXd4SENgus+y8qiFen
         0mOH+h5E+x5BLc4NgLqgaaiHO0wgBT7YBgb8tCqR/yccWp1CTcSxyY1umDqZJaCKCmY6
         yEyCxpphnW4Ix0r+Ur9oAz1RenWA17OHXtnCpeQ/5P86xWc/dSuxAYJAMnkyYFeCt+sF
         0C2hJ9NpV/iepN6ijt6RXm+acM6wXHaSJWY2GAG58I3Iu5dfNm9P+UAQmXYJ9t+hgx4c
         B4n5w1Ef8h/fegvPFHyetqg25/zWPzJjnML9NL2s/6OLi++MS4NpfV2Qj8Q3CI97X61X
         /MYA==
X-Gm-Message-State: AFqh2koPJrksK+9B45Yom15iNzlVaW6KK/xJwTqMpuVILUqE0BtAAF9I
        k1yl7eg4GWdKFYm/Xuz83ZrDqD8Zl+oaO2KHIgCO1xeJrGo=
X-Google-Smtp-Source: AMrXdXsUBjlMNw5zZE/6Yw2eUoYVrmsF6UmUD2Lck70uVfMrJOcqkxVqm0eWmlXTUkBl4TS4q0NOvpmeZHE3imohs4c=
X-Received: by 2002:aa7:9216:0:b0:576:f9e2:a968 with SMTP id
 22-20020aa79216000000b00576f9e2a968mr1249121pfo.84.1671989225864; Sun, 25 Dec
 2022 09:27:05 -0800 (PST)
MIME-Version: 1.0
From:   Eyal Post <eyalpost@gmail.com>
Date:   Sun, 25 Dec 2022 19:26:54 +0200
Message-ID: <CAL_N1vv1KqojvaS7TSeJ1JnUfO=cSzfUNMhGzgLi2pLUrmMWxQ@mail.gmail.com>
Subject: bug report
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
1. I have a script which creates a git worktree and checks out a few
files from the master branch
2. When this script runs "stand alone" - everything works fine
3. When this script runs from a "pre-commit" hook it fails with an
error: "fatal: Unable to create '/tmp/wt-1/.git/index.lock': Not a
directory"

The content of the script is (simplified example):
git worktree add /tmp/wt-1 master --no-checkout --detach
cd /tmp/wt-1
git checkout master .


What did you expect to happen? (Expected behavior)
I would expect the script to run just fine as part of the pre-commit hook

What happened instead? (Actual behavior)
An error about .git not being a directory is shown

What's different between what you expected and what actually happened?
An error instead of completing successfully

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Wed Aug 10 14:25:27
PDT 2022; root:xnu-8020.141.5~2/RELEASE_X86_64 x86_64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
pre-commit
