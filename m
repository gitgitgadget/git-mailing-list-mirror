Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635F6C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 16:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjEHQOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 12:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjEHQOB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 12:14:01 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3453465A1
        for <git@vger.kernel.org>; Mon,  8 May 2023 09:13:53 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-19290ad942aso3635935fac.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683562432; x=1686154432;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwDVQnJnxO9KCQri0ZFnDNLnrnNLLOEXyzkUkDnxBoo=;
        b=JOvGVd8uCdLKwxwe18JBRoViTJjOvVpxloMe0SaPNsadWrz1zDczbMl+cZcDMzesJg
         CyWkvl10w8XxIP/cruxzb+zb5twYR8MbfhKfF4XFcFLE2r+0RLXLTsLkvP2ZnmoSshEq
         +BUACCvN50+KPd+tIEcVVrHQCt+1yc8xoaJq9sHuHW3+AawPH/1acVcsL/+ggXYLuqzY
         GXJ4tk6yNpGRSXtojUB+sKLPUE0+0VoLckVQvSvbz6OQO0uxhnFPSU/ZLZMM+k3hja54
         7wccl9DZFpVUPPDEC/i3qnQsfDEvIAufg5Ss+Pwh8xGYTu0jOxoEIzANLwv0ReBaZz/R
         74dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683562432; x=1686154432;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RwDVQnJnxO9KCQri0ZFnDNLnrnNLLOEXyzkUkDnxBoo=;
        b=cZin+ng0NlQ5WDyho9OwRSR1Coe9hNV7IxLUKdWT949mvlqTsnfay+xWrHB8kl5oUn
         BJG8maZIR4BjTdA73V+rSVrCJbGIB2uH1QPeHwKTXKGR1nrpEj+LE9w9QxH1UayihEtV
         1qV/D+tkUuKO1dSmQCGs7/H/gLScX5cdtHjNrpKK1cAWfJFHr64S4P8KJXr/n6eurOYG
         CiJI6M9++1yobhcSdvdPsriMKeBm6C28S0JOHEmgblH44cqLOKcC3grJiDxMcQ7DJQfx
         O29sQbd6JeIrlmFLPFh8VDxZa6BgGS/eDJsjdW4oKC3qS+ML7GiCBectVjFBD5RooGmE
         6X0w==
X-Gm-Message-State: AC+VfDyFKTSGaaGyZgP0exsblDaSEWz+QI16p2poicAFF9xzj0u2NwC+
        W3DnWNxR6tZOD9Ek5t3b6jo=
X-Google-Smtp-Source: ACHHUZ4GjaH8hpuuKEfcyRG2fAFSDhIt7JFOiUmccGKgoJPxnDS7lJUJRxkXVoCLmJVsB+1fdF9Hig==
X-Received: by 2002:a05:6870:a247:b0:184:57fb:6183 with SMTP id g7-20020a056870a24700b0018457fb6183mr4447348oai.17.1683562432379;
        Mon, 08 May 2023 09:13:52 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id p5-20020a056870868500b00172ac40356csm5065525oam.50.2023.05.08.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 09:13:50 -0700 (PDT)
Date:   Mon, 08 May 2023 10:13:49 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Tao Klerks <tao@klerks.biz>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Message-ID: <64591fbddaf2d_7c6829457@chronos.notmuch>
In-Reply-To: <CAPMMpojTjFn7JCo8QsDcOJf6NoJYASbV1bL_JxDhUr7DS12DJg@mail.gmail.com>
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
 <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com>
 <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com>
 <CABPp-BGmPKyNcDa-wUh-oisTvvux+X=6BvGxSNQC2O7uodpFrA@mail.gmail.com>
 <64581fc358ede_4e6129442@chronos.notmuch>
 <CAPMMpojTjFn7JCo8QsDcOJf6NoJYASbV1bL_JxDhUr7DS12DJg@mail.gmail.com>
Subject: Re: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks wrote:
> On Mon, May 8, 2023 at 12:01=E2=80=AFAM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Elijah Newren wrote:
> > > On Wed, May 3, 2023 at 10:01=E2=80=AFPM Tao Klerks <tao@klerks.biz>=
 wrote:
> >
> > > > If we are comfortable changing the behavior of branch checkout to=
 be
> > > > safe-and-limiting like switch, then that should be almost as simp=
le as
> > > > removing that condition.
> > >
> > > I've never heard a dissenting vote against this
> >
> > Here is my dissenting vote: I'm against this change.
> >
> > If I want to use a high-level command meant for novices, I use `git s=
witch`. If
> > instead I simply want to switch to a different commit and I want git =
to shut up
> > about it, then I use `git checkout`.
> =

> Thank you for your perspective on the relationship between these comman=
ds.
> =

> I don't fully share this perspective, in two ways:
> - In my experience most novices don't see or know about "git switch"
> at all - the vast majority of the internet is still stuck on "git
> checkout", as are existing users. Google search result counts are of
> course a poor metric of anything, but compare 100k for "git switch" to
> 2.4M for "git checkout".

Yes, but that's something for the Git community to fix.

Why can't the git developers communicate effectively with the user base?

> - As far as I can tell, "git switch" and "git restore" have exactly
> the same power and expressiveness (except specifically the lack of
> "git switch --force" support for bulldozing ongoing merges) - they are
> just as much "expert" tools as "git checkout"; the main way they
> differ is that they are clearer about what they're doing / what
> they're for.

That is not true, you can't do `git switch master^0` because that would b=
e
potentially confusing to new users, but you can do the same with `git
checkout`.

> I'd love to see "git checkout" deprecated one day, although I'm not
> sure I'll live to see it happen :)

But that's not an excuse to break user experience.

> > If there was a way of doing:
> >
> >   git -c core.iknowwhatimdoing=3Dtrue checkout $whatever
> >
> > Then I wouldn't oppose such change.
> =

> I know I keep wavering back and forth on this, my apologies for my
> inconstancy: *I once again think adding support for "--force" (to
> checkout and switch) with ongoing operations makes sense.*
> =

> This does not achieve exactly what you seem to be suggesting above,
> for two reasons:
> 1. It could not be implicit in config, but rather would need to be
> explicit in the command
> 2. The outcome of using --force is not exactly the same as "git
> checkout" without it (but that's a good thing)
> =

> I would (and will) argue that not achieving exactly what you propose
> *is OK* because the behavior of "git checkout", without "--force",
> when there is a (merge, rebase, cherry-pick, am, bisect) operation in
> course, especially the way that behavior differs from when "--force"
> is specified, is *not useful* - even to expert users.

OK. That may be the case.

But it wouldn't be the first time some operation is considered not
useful, and then it turns out people did in fact use it.

I would be much more confortable if there was a way to retain the
current behavior, but if we are 99.99% positive nobody is actually
relying on this behavior, we could chose to roll the die and see what
happens (hopefully nobody will shout).

But if that's the case, I think this is something that should be a
conscious decision that is extremely clear in the commit message.

Cheers.

-- =

Felipe Contreras=
