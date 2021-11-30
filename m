Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C85C433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 23:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241265AbhK3XiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 18:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240977AbhK3Xh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 18:37:59 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92B3C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 15:34:39 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j9so19679699qvm.10
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 15:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNAUDki3ChkD05D9nFe0g6T0W9sTU0K6gtsblFD+V5c=;
        b=IhQYmMqCBp5RcgtxP4gEKC83X6fJe6AN4QzNAFu4zLLcKtb6/Pi4yfCPfcBjboUSCG
         7eqca+8f5dR58VdHKdqNpfffrt+Cq29Vs0jMKOlnvu05VdCGtpEyBC4gKAIiwTWgUo1E
         ioLAd77bVqSLAyKyjZA7Drz979qkHorCp4aM/UMLgTPSfIG38cuU+5boxMPY3vhTzELi
         uVJPSVuvst88TO0jGFu700AkT981hF/ZFceL06J/7wZmtHslbTNAbzjHf9l4ohiWAZhH
         n+KjAR8p16TRmdgYTu8ROdRc1UifAMbbH6NFJc9HvzPbH/Fbdj9CnIIWgpPWBNYqT/R/
         k6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNAUDki3ChkD05D9nFe0g6T0W9sTU0K6gtsblFD+V5c=;
        b=k1U1i788MBbK3N8ikeRtrhUUfrBL3kdTTDfjEv4dIcMZ5lNHojyULQVfygIkxcXEXB
         uYmh0+IKLNQmUUE40MwYREk5ZN2TnwdmjKMz1pJSB283HeZljU6Hmomh8hIYkC5Hbgn9
         bENAIDmi7jXnxu/FiAeVUpV7UTsaYiP8L6d5jfV1ZYiWx2XEGnm3AfVUF2MVRSXojg7J
         The7WAS2Y2J2y14lHWIUaho3MbpeuQ/WzX016Nd2mFlNwoaU6RfRKp1WbcVh3uJO01cL
         qA9xg7oF0zLmr9olrYI9ebkL5OPntLG/4NuLtUlyGRrX/G+jQpAjqQLhyDJlgVamrQSh
         jh0g==
X-Gm-Message-State: AOAM530+TGfmybsQM3Vr2L4KZ9NBqJB4SDRnDVJBR08172HgAcyxcRlL
        fqwt06K78f+5Dj+eCOmSgAB1WuG1pUtjPHl5PT0=
X-Google-Smtp-Source: ABdhPJzoxrHe0Ab3zkWEL4jPsJ5Imz8Du0o1QO7deAR6ODM3+cbx5Pt6RtflcX5NBSebOhtp9GaxOU3WlRJdh1DqLAg=
X-Received: by 2002:a05:6214:5287:: with SMTP id kj7mr2488108qvb.9.1638315279072;
 Tue, 30 Nov 2021 15:34:39 -0800 (PST)
MIME-Version: 1.0
References: <CALa_nQ=Q1h9b_BZcg9AeJurLeRpGrpUFuyoMz-DYKB3bgFJj4Q@mail.gmail.com>
 <CAGyf7-Ea719UNEAQSTeeSYyCcsqMo5TWXR+dSr8sDqDfj+tLAA@mail.gmail.com>
In-Reply-To: <CAGyf7-Ea719UNEAQSTeeSYyCcsqMo5TWXR+dSr8sDqDfj+tLAA@mail.gmail.com>
From:   Noel Yap <noel.yap@gmail.com>
Date:   Tue, 30 Nov 2021 15:34:12 -0800
Message-ID: <CALa_nQmTeE9fDFN_=F4YwY-A=BQRpB_twh-X3Fw1ks=8UGNs9g@mail.gmail.com>
Subject: Re: `git diff` after `git checkout from-branch -- files` reports nothing
To:     bturner@atlassian.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I didn't know this about `git diff`. Thanks for the info!

On Tue, Nov 30, 2021 at 1:39 PM Bryan Turner <bturner@atlassian.com> wrote:
>
> On Tue, Nov 30, 2021 at 12:49 PM Noel Yap <noel.yap@gmail.com> wrote:
> >
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue)
> >
> > `git checkout -b to-branch; git checkout from-branch -- filenames; git
> > status; git diff`
>
> "git diff" as run here by default only shows _unstaged_ changes. Since
> you ran "git checkout from-branch -- filenames", those changes were
> _staged_. That means you'd need "git diff --cached" or "git diff
> --staged" to see them.
> >
> > What did you expect to happen? (Expected behavior)
> >
> > `git status` expected to show updated files and `git diff` expected to
> > show file changes.
> >
> > What happened instead? (Actual behavior)
> >
> > `git status` showed updated files but `git diff` showed no file changes.
>
> "git status" compares the working copy to the index, so it will always
> show the changes, but it has 2 different blocks, staged and unstaged
> changes. If your changes appear in the staged block, you need "git
> diff --cached" or "git diff --staged". If they're in the unstaged
> block, they'll be visible in "git diff".
>
> >
> > What's different between what you expected and what actually happened?
> >
> > `git diff` was expected to show file changes but it showed nothing instead.
> >
> > Anything else you want to add:
> >
> > If I `git reset -q HEAD -- filenames`, `git diff` starts showing file changes.
>
> This unstaged the changes, at which point they show in a plain "git
> diff". They also would move from the staged block to the unstaged
> block in your "git status" output.
>
> As far as I can tell everything is working as intended.
>
> Hope this helps,
> Bryan Turner
>
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
> > uname: Linux 5.11.0-36-generic #40~20.04.1-Ubuntu SMP Sat Sep 18
> > 02:14:19 UTC 2021 x86_64
> > compiler info: gnuc: 9.3
> > libc info: glibc: 2.31
> > $SHELL (typically, interactive shell): /bin/bash
> >
> >
> > [Enabled Hooks]
> > applypatch-msg
> > commit-msg
> > post-applypatch
> > post-checkout
> > post-commit
> > post-merge
> > post-receive
> > post-rewrite
> > post-update
> > pre-applypatch
> > pre-auto-gc
> > pre-commit
> > pre-merge-commit
> > pre-push
> > pre-rebase
> > pre-receive
> > prepare-commit-msg
> > push-to-checkout
> > sendemail-validate
> > update
