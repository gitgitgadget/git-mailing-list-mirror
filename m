Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D2CC433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 19:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00F761208
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 19:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhKMTRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 14:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbhKMTRl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 14:17:41 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC63C061200
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 11:14:48 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v11so52223160edc.9
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Th5b5uEbVAClqQZKB40iBYxSoIX0RninCCu9L6PZkvQ=;
        b=gdORQZNcyLnT5FHqxDVdbiV0XvJnzs/yQjphexWwwHRnM6VsmOsWJbJaGu4crX3tAt
         yEdJa4ORZvokpeqdvTIKG8LRau7lS8+MGz95jq6CCczv6kkVN+X3dMobk5wZQyufTPiU
         0aXFtHYalFTxPnbb1riVAdfQyuXm6RcCJLeoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Th5b5uEbVAClqQZKB40iBYxSoIX0RninCCu9L6PZkvQ=;
        b=DacMVZyc6G43RP8BH0hLZwsSe6i3Od4e7LdgV6dMO3BiYUPQAAKZ0Mm+3lJgCnE06N
         jIf/xeo/Ts+IahPxhny9ylDnXsaGMU00ZT4YA0DT03o/2s5HDrAR6umn0S6Oz9Vv7YGU
         tdfCUw5I9dz3M3zHugmDQO79Dudh/pcsR4MFmtjyw8+19oAP2atmJvTO9sRRK6SkelBu
         MZur08m4RPg0ZtlkMW/Dh7OnqvIs/5/ioGBSp1G8+iQw0rN29p0nfyy9st8U88zpPXtQ
         hvQ1uQimMrUbkn/1cLUlv5LjcTGZ2Drng8dA+rnB5kPwKZCc/3fpYaewXA+rxHofwbzR
         9xuw==
X-Gm-Message-State: AOAM530j5mRUg/Z+ozvzLRdVCiMcMaoTJM2v9sqyjX+cLrjhie6aIvrS
        NKNIewBnQlenvDaWVTACNou+Rq3oty31OiC4vTA=
X-Google-Smtp-Source: ABdhPJwAva1/ASvejwP/nT8PxyfO9QmuYjc1e35A5jcj4zxeKPxzSX6TK1L/ZEPdfadSnVBZzzZNfg==
X-Received: by 2002:a17:906:5641:: with SMTP id v1mr31517882ejr.357.1636830886593;
        Sat, 13 Nov 2021 11:14:46 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id hc10sm4081673ejc.99.2021.11.13.11.14.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 11:14:45 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso9032523wmc.1
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 11:14:45 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr28153806wms.144.1636830885325;
 Sat, 13 Nov 2021 11:14:45 -0800 (PST)
MIME-Version: 1.0
References: <878ry512iv.fsf@disp2133> <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
 <871r3uy2vw.fsf@disp2133>
In-Reply-To: <871r3uy2vw.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Nov 2021 11:14:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh8v4OC=9rjFs-QH0evVrGQu+wCVL5gE8Y-uTvqh42XNA@mail.gmail.com>
Message-ID: <CAHk-=wh8v4OC=9rjFs-QH0evVrGQu+wCVL5gE8Y-uTvqh42XNA@mail.gmail.com>
Subject: Re: [GIT PULL] per signal_struct coredumps
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Git List Mailing <git@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ Coming back to this email because I'm starting to see the light at
the end of the merge window tunnel .. ]

Adding the git list to see if somebody has suggestions, and
top-posting because the email from Eric is more of "explanation for
the issue" than anything else, so I'm quoting it at the end for
context.

The basic issue is how to sanely keep track of a cover letter when you
have a branch that you haven't sent out yet, but will ask somebody to
pull. It may still be seeing more testing and development before that
pull happens, though.

This very much smells of what the "branch description" is all about, but

 (a) I suspect "git branch --edit-description" is not very well known

 (b) it works well with "git request-pull", but not so much some other
things (like copying it into a signed tag)

 (c) it makes an unholy mess of your config file if you actually use
it for extensive explanations (branch descriptions _work_ for
multi-line messages, but it really was designed as a one-liner thing).

 (d) it doesn't work across repositories (ie multiple developers or
even just a single developer on multiple machines).

IOW, the "branch description" is _kind_ of the right thing, but not really.

The fake merge _does_ solve all these issues, it just then ends up
leaving that turd around in the history.

An empty commit would do it as well, but an empty commit very easily
gets lost (git rebase etc). The fake merge does have similar issues.

Both a fake merge, and an empty commit have the advantage that they
are easy to see and work with (ie "git log" and all the other git
workflows work very naturally).

Comments from git people?

                Linus

On Fri, Nov 5, 2021 at 9:38 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > On Wed, Nov 3, 2021 at 12:07 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > I've pulled it, but I'm not convinced about that odd extra merge
> > commit that contains the commentary.
> >
> > That's what signed tags are for, and they have that explanation that
> > then makes it into the merge - plus they have the crypto signature to
> > show it all comes from you.
> >
> > So that would have been the much better model than a fake extra merge.
> >
> > But at least that extra merge did have explanations, so at least it
> > doesn't trigger me on _that_ level.
>
> I have been creating those when I place a patchset with an interesting
> cover letter in a branch.  Now with the entire branch being just that
> patchset, it doesn't make a lot of sense (except as somewhere to store
> that cover letter so I don't loose it).  At other times when there are
> multiple sets of changes on a single branch I think it makes more sense.
>
> Am I missing a better way to preserve the cover letter for the
> changes when multiple sets of changes land in a single branch?
>
> Eric
