Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06683ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 07:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiIPH3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 03:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiIPH3S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 03:29:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1932ACC
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 00:29:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lh5so5700995ejb.10
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 00:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=yOZNr56JJkwPjS1BUxgwQOtJ5MoTxlWCMr864yXAZZs=;
        b=IyWQ+wPP4SsPaqmaD7gEHqndGw2Jlv6qY7q2A2Hhg/aEcrzDT6g3/ALxdBr9gUmQMx
         lCiu40PNQWNIUfAahgx9zNujLTKWkOGjANR2qTuMLRMFRWZeU7HBTtDf49/gS2txY5lw
         8gNp2C32t2c5QPfErPUnUQxjkVH82/sDOeRpL/LldMlMu5ER2E5jdL1LSKZcYNW/Y7j8
         l0zs49hRUFXjlnOfrEbmOuwl4mPnyBZG8ConWPMp+r3YiXJOMPsANXgNKAUFENnD/V3P
         lhhP9YzZ8MbRlvrdJIiZKpsqOtfBsR/GJUDKkZ4RRM+e3uvkkreUCrQbYuP0K7PtUxuz
         5fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=yOZNr56JJkwPjS1BUxgwQOtJ5MoTxlWCMr864yXAZZs=;
        b=MlFuOBooow8llaEGAWxU9jXSJL2xVthkARHgkdZmWPDMKdOZMvVo/emiRXgB/KpOB0
         XixoJ+Np7QLqynmMpTn2hIwbva7jv/ufr0k9gEUjnpLUBIQ2wLXyrtAOT/XHSQMqRumU
         lHpRnWei20vyORKEffPE4Ub/7PpbChskQ34SvLf25sPLGeiO4ErlhnfyJ7cxRX5sq61Q
         7IWD6dN/MWjmO6Rv6RI8Dinrpvj9kN9wZPma2YjA+91SYF5Dye9yh4azfsyuEFydR8Hp
         v1NaNGpwFgpnSHUkE0VqWj5sCLvzI2rYhd3i8LDX7E+V1KchsraHjxlkItcaQ3cYbKkt
         Vp9A==
X-Gm-Message-State: ACrzQf1t9txT2hfti5/n654ypBY8C5KTIQDPxjSpfvY1fnL67YS14aRs
        k9V+tbm6Wburbdj3Uq/HorqmcACpbAaswGaBDcV6efCizLZJcA==
X-Google-Smtp-Source: AMsMyM67Iv+xKgPh5utwfqlqntOWrOpssfxim5kgTq3+pE4UiN0+vf9C5/Fb8ZrFmeOBokeVuwxyNvCZDnDgu04HaFM=
X-Received: by 2002:a17:906:974d:b0:780:2c07:7617 with SMTP id
 o13-20020a170906974d00b007802c077617mr2724383ejy.707.1663313354589; Fri, 16
 Sep 2022 00:29:14 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5ZGo5bCR5Z2k?= <zhoushaokunixx@gmail.com>
Date:   Fri, 16 Sep 2022 15:29:03 +0800
Message-ID: <CAGxGspHE2o5KgBWLF6cM56bWgbw8tDZwM+RuFmxGDZ+Vn466Bw@mail.gmail.com>
Subject: git fetch --unshallow does not work as expected to remove all the
 limitations imposed by shallow repositories
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

I just can't figure out the effect of the command `git fetch --unshallow`.

What did you do before the bug happened? (Steps to reproduce your issue)

I downloaded a repo with a shallow clone. Then in my repo's $GIT_DIR,
I get a file named 'shallow' which I found its description in website
'https://git-scm.com/docs/shallow':
> $GIT_DIR/shallow lists commit object names and tells Git to pretend as if they are root commits
> (e.g. "git log" traversal stops after showing them; "git fsck" does not complain saying the commits listed on their "parent" lines do not exist).
When I execute 'git fetch --depth=x' to fetch more history. There is
no doubt that the $GIT_DIR/shallow file exists and lists some commit
objects.
All of the above steps act as expected.
Next, as the doc of 'git fetch --unshallow' described in website
'https://git-scm.com/docs/git-fetch#Documentation/git-fetch.txt---unshallow':
> If the source repository is complete, convert a shallow repository to a complete one, removing all the limitations imposed by shallow repositories.
> If the source repository is shallow, fetch as much as possible so that the current repository has the same history as the source repository.
so I execute the command of 'git fetch --unshallow' in my repository
to fetch all commit history.
However, the strange thing is that the shallow file still exists in $GIT_DIR.

What did you expect to happen? (Expected behavior)
As the document says: "If the source repository is complete, convert a
shallow repository to a complete one, removing all the limitations
imposed by shallow repositories."
So, I think the '$GIT_DIR/shallow' file will be deleted after
executing 'git fetch --unshallow' which corresponds to 'removing all
the limitations imposed by shallow repositories.'

What happened instead? (Actual behavior)
And when I execute 'git fetch --unshallow' again, the
'$GIT_DIR/shallow' file is not removed.
What's different between what you expected and what actually happened?
The '$GIT_DIR/shallow' is whether it exists or not after executing
'git fetch --unshallow'.
In my developing application, I use the existence of the
'$GIT_DIR/shallow' file to mark whether a repo's commit history is
completely fetched from a remote source which is really important for
me.
I also tried adding the '--update-shallow' argument which all commands
are 'git fetch --unshallow --update-shallow'. But the
'$GIT_DIR/shallow' file still existed.
But when I try 'git fetch --unshallow --update-shallow' again, the
file will be removed.
So for now, I just execute 'git fetch --unshallow --update-shallow',
and check if '$GIT_DIR/shallow' exists.
If not, the program will return.
If it exists, I execute 'git fetch --unshallow --update-shallow' again
to make sure the  '$GIT_DIR/shallow' file is deleted.

Anything else you want to add:
Maybe it's a bug of 'git fetch'.
If not, I will appreciate it if any guys can give me some ways to
check whether the commit history of one repository which was shallowly
cloned earlier is completely fetched.
Thanks for your reply.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.36.1.windows.1
cpu: x86_64
built from commit: e2ff68a2d1426758c78d023f863bfa1e03cbc768
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19042
compiler info: gnuc: 11.3
libc info: no libc information available
$SHELL (typically, interactive shell):
E:\projects\ugit\ugit\dist\UGit-dev-win32-x64\resources\app\git\usr\bin\bash.exe


[Enabled Hooks]
