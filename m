Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAFDC433EF
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 19:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhLRTAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 14:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhLRTAz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 14:00:55 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D626C061574
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 11:00:55 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id f11so5070683pfc.9
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 11:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ffkC2xJ1PLex+hqVnZ4lQ9fd+sqb/04uMHWwgBYXb5s=;
        b=KgEbegmKVgUYouXR+PCXhnpub/2zuU9MeFmY0HDJJYmK0YsDzDzEcfNJDGPDiTvPWl
         wMCgLZVbtBKqyjyNi3tZOuQFKft34DNKf/BQBeGSuUvxUl/Ju1INLhy9YfsSx9DBXZqD
         Avt76IhrPtB/l7g9iG9SlIgUXKC+H0CKL6+wrLHZaqJm94nBaNWTbvOEzcqu+UbYRf+Q
         JXlYWiVJF2yQOp6GrXwDdc5pU0r8jwZYdxUtGOI52cV4KUYQuwt9ToHcIr+pEjs3og43
         QWwZjp9YO6i1s3SlH7fy1dIfnd1JFuTcrPq7gQ7+legf7wAUw7yDr/3cU9oNYbzVqXdk
         DAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ffkC2xJ1PLex+hqVnZ4lQ9fd+sqb/04uMHWwgBYXb5s=;
        b=YcxVPjBZ4FoAIEvUPE+GxxS0cKNRgB5exxZShVijdhAVwqL5+TlGIAPTTjDbU9Clwl
         SrYkt5t4APOV7BFEwVDGw2SjrMtg4yD2eoy+MqoVCFrqLKDCXZRLpwER7I59MnAi13CU
         RKCV0C78mbmonJMDCPFuqddDTqQQrpey98Zcxi7Aq13MVR8DpIwVDohpC4lXR1iN9wlO
         QkWAUbkRBTVtB4oSJc7fg6TJZ2tz+xAUBGrYjW7cuCwG9l/K9C62L1ovHamfNi2chsUp
         eQ2oPQh5jLTPJZ5VEKeAcX+2ldwXwRGOfviW4oCHjVvxg/8oVH46TLJOh4I57aQ4jPsd
         ql1Q==
X-Gm-Message-State: AOAM532DPd4l+ef5reGNsziiWyFPJHahV3xC/a+vbt5vRscmhfyzBsIq
        1TtJ+jEHyFu0H8TNzxdqci1IhdNjoAppse6qQnm+ewIjVmw=
X-Google-Smtp-Source: ABdhPJyV9VZAWKoSDB02thiOBbWzHPjNSSO64tHMp43uDMS1lMqsyvzPWt1DnvzZujd7+BkKawJLX3WyCxgyutrCHRE=
X-Received: by 2002:a05:6a00:2487:b0:4af:94c7:8aae with SMTP id
 c7-20020a056a00248700b004af94c78aaemr8683502pfv.31.1639854054545; Sat, 18 Dec
 2021 11:00:54 -0800 (PST)
MIME-Version: 1.0
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
 <014701d7f437$5ae45110$10acf330$@nexbridge.com>
In-Reply-To: <014701d7f437$5ae45110$10acf330$@nexbridge.com>
From:   Sean Allred <allred.sean@gmail.com>
Date:   Sat, 18 Dec 2021 13:00:43 -0600
Message-ID: <CABceR4Z+CoaUuGrJS+D1C9x+nR278S4ATWozz-ni2Y96FJc3cg@mail.gmail.com>
Subject: Re: Bug report - Can create worktrees from bare repo / such worktrees
 can fool is_bare_repository()
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> You ran is_bare_repository from next, which was in your worktree - not a =
bare repo, so that answer actually makes sense.

I'm not sure I follow. I did run is_bare_repository from the
next-worktree, but the return value was evidently dependent on the
value of extensions.worktreeconfig. When true, is_bare_repository
returned true -- even within the next-worktree. Unless I'm missing
something fairly fundamental here...

On Sat, Dec 18, 2021 at 11:47 AM <rsbecker@nexbridge.com> wrote:
>
> On December 18, 2021 11:47 AM, Sean Allred wrote:
> > Hi folks! See the following bug report. Let me know if anything is uncl=
ear -- in
> > all honesty, I neglectfully `git worktree remove --force`'d the first o=
ne I
> > wrote...
> >
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> >
> >     ~$ git clone --bare https://github.com/git/git.git
> >     ---clip---
> >
> >     ~/gitbare$ git config --list --show-origin
> >     file:config     core.repositoryformatversion=3D1
> >     file:config     core.filemode=3Dfalse
> >     file:config     core.bare=3Dtrue
> >     file:config     core.ignorecase=3Dtrue
> >     file:config     remote.origin.url=3Dhttps://github.com/git/git.git
> >
> >     ~/gitbare$ git worktree add --no-checkout ../next
> >     Preparing worktree (checking out 'next')
> >
> >     ~/gitbare$ git config --list --show-origin
> >     file:config     core.repositoryformatversion=3D1
> >     file:config     core.filemode=3Dfalse
> >     file:config     core.bare=3Dtrue
> >     file:config     core.ignorecase=3Dtrue
> >     file:config     remote.origin.url=3Dhttps://github.com/git/git.git
> >
> >     ~/gitbare$ cd ../next/
> >
> >     ~/next$ git config --list --show-origin
> >     file:../gitbare/config    core.repositoryformatversion=3D1
> >     file:../gitbare/config    core.filemode=3Dfalse
> >     file:../gitbare/config    core.bare=3Dtrue
> >     file:../gitbare/config    core.ignorecase=3Dtrue
> >     file:../gitbare/config    remote.origin.url=3Dhttps://github.com/gi=
t/git.git
> >
> >     ~/next$ git rev-parse --is-bare-repository
> >     false
> >
> >     ~/next$ git config extensions.worktreeconfig true
> >     ~/next$ git rev-parse --is-bare-repository
> >     true
> >
> >     ~/next$ git config --unset extensions.worktreeconfig
> >     ~/next$ git rev-parse --is-bare-repository
> >     false
> >
> > I actually found this situation (and narrowed it to the above) by tryin=
g to
> > perform a sparse-checkout in the worktree.  It appears sparse-checkout =
by
> > default uses a worktree-specific config (which does make sense).
> >
> > What did you expect to happen? (Expected behavior)
> >
> >     I expected one of the following to happen:
> >
> >     1. I should have been blocked from creating a worktree from a bare
> >     repository.
> >
> >     2. is_bare_repository() shouldn't be fooled by this situation,
> >     assuming it's valid.
> >
> >     All things being equal, I would more expect to have been blocked
> >     from creating a worktree from a bare repository.  Personally, this
> >     bare repo + worktree setup doesn't not align with my experience so
> >     far with how bare repos are normally used (i.e., as a convenience
> >     for centralized remotes that will never be doing a checkout).
> >
> > What happened instead? (Actual behavior)
> >
> >     is_bare_repository() is fooled and I'm prevented from performing
> >     any operation that requires a worktree (like performing a sparse
> >     checkout).
> >
> > What's different between what you expected and what actually happened?
> >
> >     is_bare_repository() is fooled into thinking the worktree is not a
> >     worktree / I'm able to create a worktree from a bare repo.
> >
> > Anything else you want to add:
> >
> > Please review the rest of the bug report below.
> > You can delete any lines you don't wish to share.
> >
> >
> > [System Info]
> > git version:
> > git version 2.34.1
> > cpu: x86_64
> > no commit associated with this build
> > sizeof-long: 8
> > sizeof-size_t: 8
> > shell-path: /bin/sh
> > uname: Linux 5.4.72-microsoft-standard-WSL2 #1 SMP Wed Oct 28 23:40:43
> > UTC 2020 x86_64 compiler info: gnuc: 9.3 libc info: glibc: 2.31 $SHELL =
(typically,
> > interactive shell): /bin/bash
> >
> >
> > [Enabled Hooks]
> > not run from a git repository - no hooks to show
>
> My thoughts:
>
> 1. I think it is legitimate to create a worktree from a bare repository. =
The worktree is using its own working directory/index and does not require =
anything from the bare repo.
> 2. You ran is_bare_repository from next, which was in your worktree - not=
 a bare repo, so that answer actually makes sense.
>
> I'm not sure whether this is an expected use case but it does make sense =
to be one. If you typically work in worktrees and write scripts under that =
assumption, not having to worry about being in the non-worktree part of a c=
lone makes sense. So creating a worktree off a bare repo is not a bad thing=
, assuming everything else is correct.
>
> Just my $0.02,
> -Randall
>


--=20
-Sean
