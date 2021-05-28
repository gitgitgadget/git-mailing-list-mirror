Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345B6C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 19:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086F36139A
	for <git@archiver.kernel.org>; Fri, 28 May 2021 19:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhE1Tzb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 28 May 2021 15:55:31 -0400
Received: from kautler.net ([85.214.242.4]:45105 "EHLO kautler.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhE1Tzb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 15:55:31 -0400
X-Greylist: delayed 2750 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2021 15:55:30 EDT
Received: from mail-yb1-f176.google.com ([209.85.219.176])
        by h1362875.stratoserver.net with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.69)
        (envelope-from <Bjoern@kautler.net>)
        id 1lmhnx-0000ls-Eq
        for git@vger.kernel.org; Fri, 28 May 2021 21:05:57 +0200
Received: by mail-yb1-f176.google.com with SMTP id w1so6937601ybt.1
        for <git@vger.kernel.org>; Fri, 28 May 2021 12:05:57 -0700 (PDT)
X-Gm-Message-State: AOAM532gb5+ts9sOVh5HfHehs/9CnWJ4sCCHcGEI7jkk+tM83dFGdTje
        xrQuyvkaeUUtl5QP4GeV/TAjq4AuL4DwISUXRbg=
X-Google-Smtp-Source: ABdhPJwV4NCDMquLFIelGI17QiixMnloVx7CmEK2RMiwILABuvg1a+E7dEYDLsn51EfIcxqfwcgZsy5z31uMv5S1QyE=
X-Received: by 2002:a25:db09:: with SMTP id g9mr14302421ybf.261.1622228751113;
 Fri, 28 May 2021 12:05:51 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Bj=C3=B6rn_Kautler?= <Bjoern@kautler.net>
Date:   Fri, 28 May 2021 21:05:40 +0200
X-Gmail-Original-Message-ID: <CAKChYSqgGRfBh68oj=Gt7q4uyS7D879aQZQiZ1RsyqaDToV+0g@mail.gmail.com>
Message-ID: <CAKChYSqgGRfBh68oj=Gt7q4uyS7D879aQZQiZ1RsyqaDToV+0g@mail.gmail.com>
Subject: Bug when cloning a repository with a default branch called HEAD
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm not right now sure why this repo is in this state or how it got
there, but that doesn't matter.
But if you clone it, everything is fine.
And if you then try to fetch it, Git goes havoc:

$ git clone https://gitlab.com/Vampire/whelk.git/ && cd whelk &&
GIT_TRACE=1 git fetch; echo $?
Cloning into 'whelk'...
remote: Enumerating objects: 525, done.
remote: Counting objects: 100% (525/525), done.
remote: Compressing objects: 100% (227/227), done.
remote: Total 525 (delta 280), reused 525 (delta 280), pack-reused 0
Receiving objects: 100% (525/525), 165.63 KiB | 3.52 MiB/s, done.
Resolving deltas: 100% (280/280), done.
21:04:15.761530 exec-cmd.c:237          trace: resolved executable
dir: C:/Program Files/Git/mingw64/bin
21:04:15.765532 git.c:447               trace: built-in: git fetch
warning: refname 'HEAD' is ambiguous.
21:04:15.769530 run-command.c:667       trace: run_command:
GIT_DIR=.git git remote-https origin
https://gitlab.com/Vampire/whelk.git/
21:04:15.795532 exec-cmd.c:237          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
21:04:15.799535 git.c:734               trace: exec: git-remote-https
origin https://gitlab.com/Vampire/whelk.git/
21:04:15.799535 run-command.c:667       trace: run_command:
git-remote-https origin https://gitlab.com/Vampire/whelk.git/
21:04:15.832533 exec-cmd.c:237          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
21:04:16.438060 run-command.c:667       trace: run_command: git
rev-list --objects --stdin --not --all --quiet --alternate-refs
21:04:16.461060 run-command.c:667       trace: run_command: git
rev-list --objects --stdin --not --all --quiet --alternate-refs
21:04:16.475738 exec-cmd.c:237          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
21:04:16.478705 git.c:447               trace: built-in: git rev-list
--objects --stdin --not --all --quiet --alternate-refs
error: multiple updates for 'refs/remotes/origin/HEAD' (including one
via symref 'refs/remotes/origin/HEAD') are not allowed
From https://gitlab.com/Vampire/whelk
 ! [new branch]      HEAD       -> origin/HEAD  (unable to update local ref)
error: some local refs could not be updated; try running
 'git remote prune origin' to remove any old, conflicting branches
21:04:16.496254 run-command.c:667       trace: run_command: git
maintenance run --auto --no-quiet
21:04:16.510254 exec-cmd.c:237          trace: resolved executable
dir: C:/Program Files/Git/mingw64/libexec/git-core
21:04:16.512256 git.c:447               trace: built-in: git
maintenance run --auto --no-quiet
1

Cheers
Björn
