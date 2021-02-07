Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2D7C433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 22:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B4B64E35
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 22:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBGW3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 17:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhBGW3f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 17:29:35 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF97C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 14:28:55 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id a16so11075669ilq.5
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 14:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TBkRNPdpqCMR4Fe39DIXM75O3Rsbd8ZpliZJtFcDmVk=;
        b=MLFqhv3jVwwoehbApuwXIfPt4rRFp/t5utAv/T9QvgH3+1cT6cwMzqc5aR1w0VZCrT
         vc8iFIIL/GMrmlbe0SIiiBmArXJ0/zoLyo09Uk1/YLGM5salpyuZVb+saTCZoSTqZxKu
         +PqzJ3mM2yaqiktoLW1Ug7kKHdCpoUkYlLzVVR8XaMKmcl3uvH5Wi3i4fyTp3FdJdlno
         ZSZcshTQ7pQ0BG0AlGdS1gPV20Ln942t3r/ILDA8nVDFT19rKKGQljSQCzUUaC1oG8Rh
         zGaElZiDurK2Q3k9I2lN9+U5E/a55ZO1Y1ggHURLvkgQUlK5g3G39xKKZMZ/82MSHAIg
         K4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TBkRNPdpqCMR4Fe39DIXM75O3Rsbd8ZpliZJtFcDmVk=;
        b=lsUzHoOqemMyCN6KvLn/Q++YYfxK/dZlQgIe1PfpJh8vOkS9K48Wj10ukDqAsSJ4F+
         jkC3AaQpuach5Ea0PzxcpZ7nlaSE9oRLOBxld6DAxu19vzucdod27FRBwGoFpanwOTxF
         E+RbFJMlwMEvDOQz/fai+9QOMdT0vnPsKI2Y2fgfVIXR7MzeDkuNyn0UNHotxwYjw841
         2omXJ2mF5GmfCGj6Un7eynBSfBzEVPdqmqkfd0QqhKgPrKtopN0VjYtF2W99DGwNJXgU
         SI3bDQsett8BDC0QJukfinyNWAiKsedn7M3xt7gpN9hhPx+iUOgxY8MnQ0wgCSd8SWxx
         xR+w==
X-Gm-Message-State: AOAM532sd9EQ30NH196R+d7xt44UXQrw3Ox9zU7yF+ndx1Enx26hWblV
        MtwSFtMuk4amSw1pSM3dqRSk+IZi24mS09Xmj530gUMpbViXxA==
X-Google-Smtp-Source: ABdhPJzyBsshldOHUrFRBxmAT6pU7/kDEYRIXqy4ZjPJ9Tko56+wmk+G3G3XlReC/SALace1lqDqC0FXwb8qsvjemKo=
X-Received: by 2002:a05:6e02:10c:: with SMTP id t12mr13266266ilm.220.1612736934087;
 Sun, 07 Feb 2021 14:28:54 -0800 (PST)
MIME-Version: 1.0
From:   Filippo Valsorda <valsorda@google.com>
Date:   Sun, 7 Feb 2021 23:28:28 +0100
Message-ID: <CA+2K_KotVrV=rjE6fcd_FfxxS0sewkywvO0EMVZdoHbSiqJTQw@mail.gmail.com>
Subject: BUG: commit-reach.c:66: bad generation skip
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

$ git merge origin/master


What happened instead? (Actual behavior)

BUG: commit-reach.c:66: bad generation skip     ad18 >        7 at
be28e5abc5ddca0d6b2d8c91b7bb9c05717154e7


Anything else you want to add:

Running in a worktree of a clone of https://go.googlesource.com/go.
HEAD is 0d34d85dee216b62a4212d25de57e1119c1e7ee5, branch is
filippo/boringcrypto/16,
tracking and matching origin/dev.boringcrypto.
origin/master is 724d0720b3e110f64598bf789cbe2a6a1b3b0fd8.


[System Info]
git version:
git version 2.30.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.3.0 Darwin Kernel Version 20.3.0: Mon Dec  7 22:04:02
PST 2020; root:xnu-7195.80.16.111.1~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.28)
libc info: no libc information available
$SHELL (typically, interactive shell): /Users/valsorda/homebrew/bin/zsh


[Enabled Hooks]
pre-commit
commit-msg
