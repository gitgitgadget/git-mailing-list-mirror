Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06CAC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 14:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD936044F
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 14:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbhDLO4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbhDLO4R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 10:56:17 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DD5C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 07:55:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w23so15450489edx.7
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=formlabs.com; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=35WHNKEn6H0dNGkUPbMYqJ/EXOUFsoT36dzLkTyC5Bs=;
        b=B101B4gYxMlElKgvj+aXuPvpCGIKqG5jV1Ak60YGIHGgcddM6U1z9Hh4/CvlLxCs7c
         gmAdybkW8J6o/TDhc0Tw+WXj9FQuyFvDY+87EaUGswX0xQGkOW7XbWkzGxzN649KDGH/
         mzPXr/LJKd/jlfuBEqw+vdMOzF45rcwV/1utM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=35WHNKEn6H0dNGkUPbMYqJ/EXOUFsoT36dzLkTyC5Bs=;
        b=hH1d38aih1ROPvdCRTLX0v699wNOzUJJ3DrUo9eDCa5GMLdkR2MErPBTyBZ5MnNGv0
         L9dhFhAzaxt4i6FhyZi92d2/OgMo+XXJu0dVhLd0ajMbzl+RFl6y11xtGYlp/erpfN6X
         pK94fYd0d1A9UcnvYKiNursGxUG5P0V2SZjQGwkuD/VotWMP79JIz/OnvjeY8V6/2YwS
         RE+e/xk5cGOybaWlvI34tTWDXfvmWYE+W6NlUeGY+fgU1NI11hLn00CS/AjTbLnXJIqK
         1tYhQ1Fp6NfLuTBYz9GdmGfdaDPlZ4hIV7drkPokGusGHqGVTUb3FanhxZXX5A60bikG
         CDLw==
X-Gm-Message-State: AOAM533bHhOB9CzMq7Swpw8VeXKnKvFQV0wkJnxhvo48ptyEyIngxor2
        ZK9XYze82ULgCWM6y/CfIOe6M9q5R5f61YMWt+9jDLwhkU+9cEVd
X-Google-Smtp-Source: ABdhPJzJFiUCrDsXaTbpGVsxH9YrDamnM/zOGa1z8ZKxHFZbDxWaH1kic8y+FBflzy+L3/9hvFCokHIFcKyUCyN/rH4=
X-Received: by 2002:aa7:c7da:: with SMTP id o26mr29887119eds.244.1618239357713;
 Mon, 12 Apr 2021 07:55:57 -0700 (PDT)
MIME-Version: 1.0
From:   Tamas Peregi <tamas.peregi@formlabs.com>
Date:   Mon, 12 Apr 2021 16:55:21 +0200
Message-ID: <CAKJ37DfivxL-2Sy0qa+M_1Pw0c9-CWsCJO5=VqP1UOB5zTSP_Q@mail.gmail.com>
Subject: Unexpected conflict during cherry-pick after moving submodule
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I ran into something that seems like a bug to me. I'm fairly new to
git, especially git submodules, so it's possible this is expected
behaviour, but if it is, please explain where I went wrong.

Thanks in advance: Tam=C3=A1s

What did you do before the bug happened? (Steps to reproduce your issue)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- I modified a file on one branch
- Then switched to another
- Moved a submodule to another directory
- Tried to cherry-pick my modification from the other branch

This script can be used to reproduce my steps (any submodule works, I
chose gsl-lite because I like it):
    git init

    echo hello > hello.txt
    git add hello.txt
    git commit -m "Add hello.txt"

    git submodule add https://github.com/gsl-lite/gsl-lite/ vendor/gsl
    git commit -a -m "Add submodule"

    git branch world
    git branch move

    git checkout world
    echo world >> hello.txt
    git commit -a -m "Expand hello.txt"

    git checkout move
    mkdir thirdparty
    git mv vendor/gsl thirdparty/gsl
    git commit -a -m "Move submodule"

    git cherry-pick world


What did you expect to happen? (Expected behavior)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I expected the cherry-pick to happen without conflicts.


What happened instead? (Actual behavior)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I ran into a conflict during the cherry-pick:
    Adding as thirdparty/gsl~HEAD instead
    error: could not apply 516d94f... Expand hello.txt
    hint: after resolving the conflicts, mark the corrected paths
    hint: with 'git add <paths>' or 'git rm <paths>'
    hint: and commit the result with 'git commit'


What's different between what you expected and what actually happened?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

As hello.txt has nothing to do with the submodule, I assumed the
cherry-pick would go through smoothly.


Anything else you want to add:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

- "git add thirdparty/gsl && git cherry-pick --continue" resolves the
issue as expected.
- If I change which commit in the submodule the superproject points
to, the problem disappears, but I don't necessarily want to do that.
- I'm using "Git for Windows", but the issue was reproduced by my
Mac-based colleagues too with the exact same results.

[System Info]
git version:
git version 2.31.1.windows.1
cpu: x86_64
built from commit: c5f0be26a7e3846e3b6268d1c6c4800d838c6bbb
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19042
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.ex=
e
