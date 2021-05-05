Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30711C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC43600D4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhEESHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 14:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhEESHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 14:07:25 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22715C061763
        for <git@vger.kernel.org>; Wed,  5 May 2021 11:06:27 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u16so2989079oiu.7
        for <git@vger.kernel.org>; Wed, 05 May 2021 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wVNSRxQ2fBj6+VbSdh7wlWq3DLWYWIcqOyJ3ZPxHTHM=;
        b=Cl7+I97S7oobTdCch3+YjWu6QnW5yaJ40+ndC/U2br8i9QSAfjHKtFmx7M5cBNnK/W
         /3LfZMkh6fI0EuGadP6ktDqxrHvz0U/2EpwWRzNV3hlij/1enMrYCVzdndKLjyXtn5r0
         e6y5/JmoP/ZS+bCvxQzDvm2ppPtm5ppv/hAUFZmLU6PuBIcsWEPAJQPbMbiQc4xZL6qw
         1SqbtsDC2IYzAN6sfNwghLfUpoKEVv68j10Kl3EXrS5tXK/H9xkWTD932DMkYRJiZhhu
         prV7Y0EY8Uqdl11Z/d7ZL9LdKUNfEVKvQGO7oWMBBanW8co9HG0tgw/E82H25KpjvLYY
         8yvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wVNSRxQ2fBj6+VbSdh7wlWq3DLWYWIcqOyJ3ZPxHTHM=;
        b=t8CihcpruafdI3UmASy+223FlslHJwBf7MT2sNrPa+mjLDafQ5hcIbNLr41huFk9EB
         zCs4fwVqPEmvCOMzGjwRt6V3ca4/Uu/hWYfHOZAdFCaqgb9auLVpqP6KG55rrW1bPSPe
         iC8rhLg5dGhVvUoibhyS/YCtV8Ttrq7ibpoDbVWMvBCKvLbao6B+Yhn+gi+wg6lBuLBq
         x7BP8M8CxB34jbXulkyP+hMNvGRupa1sB3Wp0H5YhhsbbIrh0ob8he8MYKuiK7qXz1ey
         p+Q+NuaMUlqG3xR8cDywvEPvLt4cbyrs6ql3NrwyD0CNzek991QmaHyiahFbAx637V4w
         cJww==
X-Gm-Message-State: AOAM531btdfX1/iApqcKJTEv/dGmG4m2JQ5ubzQNuNXwBwz0C/MmyJXv
        lCHrI0j8cTcVInYavqpWq1Sic1DHrWGdhcH3LuEKCirG6pl64g==
X-Google-Smtp-Source: ABdhPJwmCEcTv8qN+m7SPw8XzfxHuF69ucldXEkFdUFzRz6A0JpUMjLRMcFC0kgKC4IaAuQtyN1rfAqxPcR46bLfags=
X-Received: by 2002:a05:6808:1392:: with SMTP id c18mr7997694oiw.176.1620237987132;
 Wed, 05 May 2021 11:06:27 -0700 (PDT)
MIME-Version: 1.0
From:   Theodor Negrescu <theodor.negrescu@gmail.com>
Date:   Wed, 5 May 2021 21:06:12 +0300
Message-ID: <CAEumJaDRvU8LP=q3PQ1z6-cg75DmbHE_7OXZVA+nm=-77pVLEg@mail.gmail.com>
Subject: BUG: Git path --config doesn't work with ~ symbol
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I ran the command "git config --file ~/git-settings/.gitconfig -l"
(git-settings is a repo where I keep my config, the global one is just
an include)

What did you expect to happen? (Expected behavior)

It would list the settings in the file.

What happened instead? (Actual behavior)

fatal: unable to read config file '~/git-settings/.gitconfig': No such
file or directory

What's different between what you expected and what actually happened?

The ~ symbol should point to my home folder.

Anything else you want to add:

"git config --file ~/.gitconfig -l" doesn't work either so the ~
symbol is the problem.
fatal: unable to read config file '~/.gitconfig': No such file or directory
"git config --file .gitconfig -l" works when I run it from my home
folder or from git-settings so the --file argument is working.

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
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
not run from a git repository - no hooks to show
