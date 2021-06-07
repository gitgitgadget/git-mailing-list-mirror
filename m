Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4835AC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A74361164
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFGPaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 11:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhFGPav (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 11:30:51 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1C4C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 08:28:47 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso4068044oto.12
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=c1RVCQNsZoGF1o1ZJa63lTbX3MXhzPrQ2k++EDevnFU=;
        b=C1d0TSANtQwZT2+IPquW/UalqszeIfRs76K9QD9haS3HoGpP+ryr6YUQXxMT95jp3m
         QvFG5O60QlVZUbQrQKvdHl03nZKZuGQaimPXuv0gNMgWQlDc+k8uHRXlmK3K4ZkP6KvJ
         JPOxTevNzQ5RZc9ZzvxsU03jlsdrC6tgCVoVdxNAIdjd4sDskdjcTPLqfA153jI46O45
         MTMdbO5lgsMJUGo0XOUgkxUYpWBagvj4yk5tP2UWi5gcfI/mlZyGxdILV/uAuEVw2xLc
         w40JtMrCAkI45Y3/scp1BaLx+gYHhoD1Pldai6cxhVBOtjwS9/P3FFy4eGYrQg5oF6Br
         qr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=c1RVCQNsZoGF1o1ZJa63lTbX3MXhzPrQ2k++EDevnFU=;
        b=mTns5WH4b9TembaKzdZCcYtZHEwaZfSWCIXSe2nrrrR5uu7S9zG6cdQ9jYl//h+/Yt
         hDkUuEstvJf5bDSzM8IK7SEoHyd5ATQHbT0bphf+pvcztQj/6Mt2XGDMnv1gtLH75eM6
         8H9+lajqbAbmGGb75tkzjiVO6iDNfJEOYK9r5L1JYUQnvNiGICgeKkt6DBb8u+Fp5UwI
         YK+hPa9n3Ixd01skQj8ukABAbLck7pS6/xJetHWy4mg7O4Yq/XYq6FJ+isMQXgzYcTtJ
         DdbDZKe8COOFmOi2Bai9fYVk2lLOE8wAE2EtYMM5+mbdIUoDQVHlKbAwuUP66K8W+Lxl
         8Maw==
X-Gm-Message-State: AOAM5330A8A4gYyeugHN7qStA9Yp/EpzN1e7a6CeKVgkwKS5bmaf4aoU
        p6Fr/c2rv1yw7FhgUZlLRbM=
X-Google-Smtp-Source: ABdhPJxsqHOxuYIOuQ0HdpsLOc4Znx1m//UAhY/kY66wcoraB+66wQy8f5Ye5w3RhsrS48hyOsfo1A==
X-Received: by 2002:a05:6830:1349:: with SMTP id r9mr2701614otq.147.1623079727228;
        Mon, 07 Jun 2021 08:28:47 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id f2sm2397609otp.77.2021.06.07.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:28:46 -0700 (PDT)
Date:   Mon, 07 Jun 2021 10:28:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60be3b2d6e1e6_39c0a20883@natae.notmuch>
In-Reply-To: <87czt059sn.fsf@evledraar.gmail.com>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] branch: make -v useful
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Jun 04 2021, Felipe Contreras wrote:
> =

> > Currently `git branch -v` shows something like "[ahead 10]", but ahea=
d
> > of what?
> >
> > We git experts know ahead of what, but not what that what is set to. =
Just
> > like "[@{upstream}: ahead 10]" would not be particularly useful to
> > anyone that doesn't know, or remembers, what @{upstream} is set to.
> >
> > On the other hand "[master: ahead 10]" is perfectly clear to anyone.
> >
> > This confusion only gets worse when you see "[ahead 10, behind 100]".=
 Is
> > it master? Is it next? Is it
> > john/experimental-feature-i-based-my-branch-on?
> >
> > Inevitably most users will need to know what @{upstream} is.
> >
> > So let's make `git branch -v` output what is most useful:
> >
> >   [master]
> >
> > Before:
> >
> >   * fc/branch/sane-colors b2489a3735 [ahead 1] branch: make -v useful=

> >
> > After:
> >
> >   * fc/branch/sane-colors b2489a3735 [master] branch: make -v useful
> >
> =

> Having applied this patch I find the description a bit confusing. The
> example led me to believe that you'd stripped the remote name, so the
> common case of "origin/master" would become "master", but instead the
> example is from a "fc/branch/sane-colors" branch where your "remote
> tracking branch" is actually tracking your *local* master, i.e. "remote=

> =3D ."?

Yes, in my particular setup I have a local "master" and many branches
based on it. A simply picked a real example.

But yeah, it would have been clearer with origin/master.

> Disambiguating that is one of the reasons we prefix with the remote
> name, but I'd say it makes for a confusing example in a commit message,=

> and also if instead of saying:
> =

>     branch: make -v useful
> =

> It said e.g.:
> =

>     branch: reverse the priority of what -v and -vv show

I guess that depends on what you consider this patch is doing, why, and h=
ow.

But I have no problem with your version.

> Or something similar to note that it's not "useful" now, but an
> opinionated change about what we should show on verbosity level 1 and 2=
.

I'm not sure I parsed that correctly, but that's the whole point:
verbosity level 1 is not very useful (I'd argue not useful at all).

> In any case, this proposed patch is missing a doc update, in
> git-branch.txt we say both:
> =

>     When in list mode, show sha1 and commit subject line for each head,=

>     along with relationship to upstream branch (if any). If given twice=
,
>     print the path of the linked worktree (if any) and the name of the
>     upstream branch, as well (see also git remote show <remote>).
> =

> And later, for the --track option:
> =

>     When creating a new branch, set up branch.<name>.remote and
>     branch.<name>.merge configuration entries to mark the start-point
>     branch as "upstream" from the new branch. This configuration will
>     tell git to show the relationship between the two branches in git
>     status and git branch -v.
> =

> Both of those need to be updated,

Sure, I missed that.

> and I think the commit messages should discuss whether we break this
> promise of having consistent output between "status" and "branch -v"
> now.

But we don't with "branch -vv".

> As for the proposal, I don't use "branch -v" all that much much, so I
> don't have strong knee-jerk feelings on it, but just considering it now=

> I'd think that the current default is a fundamentally better
> approximation of what most users would like as a default.
> =

> I.e. I think it's fair to say that to the extent that most users have
> topic branches they're part of some pull-request workflow where they're=

> always tracking the one upstream they always care about, usually
> origin/master.

Because git has poor support for triangular workflows users are forced
to pick between one of two approaches:

 1. If you rebase a lot you pick origin/master
 2. If you push a lot you pick github/my-pull-request

There's a reason `git push --set-upstream` exists.

A quick Google search shows these top results:

1. https://devconnected.com/how-to-set-upstream-branch-on-git/

 * git push --set-upstream <remote> <branch>
 * git branch -vv

The author doesn't even mention any other way to setup branches, and of
course doesn't bother himself with `git branch -v`, which is not useful
at all for his purposes.

2. https://git-scm.com/book/en/v2/Git-Branching-Remote-Branches

  If you want to see what tracking branches you have set up, you can use
  the -vv option to git branch. This will list out your local branches
  with more information including what each branch is tracking and if
  your local branch is ahead, behind or both.

Once again another author that doesn't bother himself with
`git branch -v`.

And the examples show why:

    iss53     7e424c3 [origin/iss53: ahead 2] Add forgotten brackets
    master    1ae2a45 [origin/master] Deploy index fix
  * serverfix f8674d9 [teamone/server-fix-good: ahead 3, behind 1] This s=
hould do it
    testing   5ea463a Try something new

In only one example is the upstream branch origin/master.

3. https://stackoverflow.com/questions/1783405/how-do-i-check-out-a-remot=
e-git-branch

The top answer to "How do I check out a remote Git branch?" mentions:

  git checkout -t <name of remote>/test

This most certainly will not create an origin/master upstream.

4. https://www.git-tower.com/learn/git/faq/track-remote-upstream-branch/

  git checkout --track origin/dev
  git push -u origin dev
  git branch -u origin/dev

Once again no sight of origin/master, which isn't even mentioned in the
whole article.


So no, I don't think it's accurate to say that most people would track
origin/master, in fact, I would say of the people that know how to set
upstream tracking branches, the minority would pick origin/master.

> The -v output showing the ahead/behind relationship to that branch

What branch?

If I show you the output of my `git branch -v` on git.git do you think yo=
u
would be able to figure out what branch is being tracked? Not even I
could figure that out.

> Whereas you are presumably tracking origin/master for some, building on=

> your own topic (or other people's topics) for another etc., I think tha=
t
> workflow is much rarer outside of linux.git and git.git, and even for
> those most people usually track origin/master with most of their topics=
.

That's an unsupported assumption.

As I showed above, most pople track the branch they push to, not
origin/master.

Google "git branch -v", and you will find mostly official documentation
and man pages.

Google "git branch -vv", and you will find mostly blog posts, Stack
Overflow questions, and cheat sheets.

I think the reason why is obvious.

Cheers.

-- =

Felipe Contreras=
