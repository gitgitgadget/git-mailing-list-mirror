Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64798ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 11:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiIALHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 07:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiIALG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 07:06:56 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE58342ADB
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 04:06:54 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id m66so17340656vsm.12
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 04:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=kz2J8vZKorjvgmyRSSVamoh5UtpUOPpF8zhkbET7i1o=;
        b=XaDO5fEHvKhwODOrxhnprgYsXYr8klpu440AuWJmNUfy1GbNraKp5snupKR5Ri5Cnw
         7Vxa0oXJ4im9NfTWo7YYFuxUKzGg2UbKWg/P4ikaECJ0PbdjBU1F0IitifmdP+EPbMz2
         98kLbGUUGIf9vd72FzHeS3o+FLLh4buYWuOuK4ij4QCws83Y/UfGwzpyWZuI+ZqnTC1+
         6K7I2GoQe3rB4zFF/dJaJkVzlPflz8rnoMCySUgc6t6QLI8X2eRr8yo6h77zx/zoh3nr
         NZgRcav0OYk1QuuFDP1LQ5LO971K4AJ3JQtcEcoD0PgKSJwUed2PtOUWiQFv5aK9JRFU
         OrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=kz2J8vZKorjvgmyRSSVamoh5UtpUOPpF8zhkbET7i1o=;
        b=ap0H5r74cX9rPfXOJvPJt1XfUDR0UivrG3t4lxDY4Rl0Rvhp/FmhbdfMaz+5jEuwCS
         OqHV2sgOfs/3R5qpU9kHa4jS65+Ljd0VxWjKZzfhAhmJOOADHmwtpQB7ZLmg1zGgW2xL
         dJOoWzqa12pyr/MH5WVTEvQhNYMiea2XpjZJEKculnW9kbXp+5fpX76wxjdx9Dceun/O
         hS0FnubU2yYcBCNEUBi+hUbLQcD4SGhiW42JRg1MjOWz4YIvJ5RHOaksQm4tXPiH2EES
         wKGWF+17NYxQgj+WlNtBbxah9tI6vKhb/WFYRMnylnTddF3T9+74ekAeGnuB2fTFYJTg
         llLA==
X-Gm-Message-State: ACgBeo1/cz9L59//vlmjL1itmMGB8gnnVP8WGOK0RylOTlqrXXiMECgR
        /pk6B2oIC0Dt4Ky01XRhz02zlZc2oymRbTcHrDFIy6LewOBknw==
X-Google-Smtp-Source: AA6agR48frU2rkrJoxs7yx79cP1qmV5hy5UHVuDzGv0pMsgUnnjSSIj/YvjQNrYWITmOPGjia+5vi6/9NCp5cR0Q8gA=
X-Received: by 2002:a67:dd04:0:b0:392:96d5:37e with SMTP id
 y4-20020a67dd04000000b0039296d5037emr3945633vsj.44.1662030413908; Thu, 01 Sep
 2022 04:06:53 -0700 (PDT)
MIME-Version: 1.0
From:   Sunny Hoang <s7hoang@gmail.com>
Date:   Thu, 1 Sep 2022 07:06:43 -0400
Message-ID: <CAM+t+1aez80vs5939Td0emwqAhVHtKW0BZ412+RW8Tvm85W5eQ@mail.gmail.com>
Subject: possible bug: --bare vs --mirror with respect to remote-tracking branches
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
  git clone <url> --mirror
  git --git-dir=<dir> --work-tree=<working directory> branch -r

What did you expect to happen? (Expected behavior)
  Remote-tracking for branches is supposed to be included (and would show up in
  `git branch -r`)

What happened instead? (Actual behavior)
  No remote-tracking branches (`git branch -r` is empty)

What's different between what you expected and what actually happened?
  Should see `origin/HEAD`and so on...but it's still empty

Anything else you want to add:
  I found the solution here:

    https://stackoverflow.com/questions/38981470/git-clone-create-a-bare-clone-but-with-remote-tracking-branches-for-a-worktre

  `git config --local --add remote.origin.fetch
"+refs/heads/*:refs/remotes/origin/*"`  seems to do it.

  The original value was:
      [remote "origin"]
        ...
        fetch = +refs/*:refs/*

  Running that command added another line:
      [remote "origin"]
        ...
        fetch = +refs/*:refs/*
        fetch = +refs/heads/*:refs/remotes/origin/*

  Running `git remote update` afterwards gets me the desired remote-tracking.


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.37.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.18.14-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 23 Jul 2022
11:46:17 +0000 x86_64
compiler info: gnuc: 12.1
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
