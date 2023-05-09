Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56566C77B7F
	for <git@archiver.kernel.org>; Tue,  9 May 2023 01:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjEIBzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 21:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjEIBzn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 21:55:43 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F1D1FC3
        for <git@vger.kernel.org>; Mon,  8 May 2023 18:55:35 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-190d4f2f943so4283021fac.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 18:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683597334; x=1686189334;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5jQPFNtGlOpmXgBKUDn4o19MQ+qXcTBAocZQQEF0rA=;
        b=n6X9qrFXCIJeAOozXFS2XGDkamIXNP2y2grJUNE42NmqV/eHmfsB/GOmthGaj4YXSh
         FUMsuKcVpvFp6fv16m7rDiqjHkRtcuzzzLQGRGrRZjTtkHHXpXLN7Marml/WPDI5TJ2h
         9Em67qtjZRlpaeuTOi1QRH85+QpfgGzqYlbVdJbpTAJpdDPJxE81IBgueWvZxwBv4WHp
         84uZCWji/8Kgz4Kzrf57775QOYrac4oEXCOxz4CZUf4GpfYrXayfkIe82udsKTJdukON
         qjilOJGnIIpwLgPA0gXp9j/VXRbqONUaKWme+AaH5ffDHfdn0IpbityD4sEe1ukCFhGT
         OBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683597334; x=1686189334;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t5jQPFNtGlOpmXgBKUDn4o19MQ+qXcTBAocZQQEF0rA=;
        b=gAXpnTGnBfBx5s/14pBPFIZ1auQzRTO6oMc5SmXkMw3bIRN+S5HL34mRIvuKdPJlAk
         sD4Yj0buvGWItAPqm2d/HKsaRQK+o+3pIuMKT1+x4q5aW8b4iUk/EiS5sEFOMvARFCyk
         eiXmoKf2oSlcN21F7D87PI4hbueOcEHV8fEKjZF/IJWWhFMlNvQ9WVAUh2MKWUTXEQo3
         R1Pp9zUdFxBinsuahaNRQti56qbBBnVJ+pS4yvFC2qO8Gb0nCDz/IG+H1cf/AbNwTVtS
         pKo2vUnu/sp8M7o/OD62HqerPkvb/Gk2vHePvKGEo/O5OJtdtm5LJaMoxf13Jf0ev1h/
         EQCg==
X-Gm-Message-State: AC+VfDwYtXiem/Iq+ccsccJsd07Cm6PncuwRDUkluQCRWb8x1QEKgGHP
        oMPGMfZVWo8kyPfqgTUq9PpcMoYuYO0=
X-Google-Smtp-Source: ACHHUZ6Q5VVe9+mad3UG40idwVBDkULAjCNlZ6Cau8AXzOarF0b3N4oZ9X9QnYlv+QnpVb/XAICiBA==
X-Received: by 2002:a05:6870:172c:b0:196:12ec:110a with SMTP id h44-20020a056870172c00b0019612ec110amr2502998oae.48.1683597334280;
        Mon, 08 May 2023 18:55:34 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e18-20020a9d5612000000b006a1287ccce6sm4732383oti.31.2023.05.08.18.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:55:33 -0700 (PDT)
Date:   Mon, 08 May 2023 19:55:32 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Tao Klerks <tao@klerks.biz>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Message-ID: <6459a814ee378_7c682949e@chronos.notmuch>
In-Reply-To: <CAPMMpoi74RFBptKkv23FSK-fQsnuan9EK5HodUBRLNtxLYdr_w@mail.gmail.com>
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
 <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com>
 <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com>
 <CABPp-BGmPKyNcDa-wUh-oisTvvux+X=6BvGxSNQC2O7uodpFrA@mail.gmail.com>
 <64581fc358ede_4e6129442@chronos.notmuch>
 <CAPMMpojTjFn7JCo8QsDcOJf6NoJYASbV1bL_JxDhUr7DS12DJg@mail.gmail.com>
 <64591fbddaf2d_7c6829457@chronos.notmuch>
 <CAPMMpoi74RFBptKkv23FSK-fQsnuan9EK5HodUBRLNtxLYdr_w@mail.gmail.com>
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
> On Mon, May 8, 2023 at 6:13=E2=80=AFPM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Tao Klerks wrote:
> > > On Mon, May 8, 2023 at 12:01=E2=80=AFAM Felipe Contreras
> > > <felipe.contreras@gmail.com> wrote:
> > > > Elijah Newren wrote:
> > > > > On Wed, May 3, 2023 at 10:01=E2=80=AFPM Tao Klerks <tao@klerks.=
biz> wrote:
> > > >
> > > > > > If we are comfortable changing the behavior of branch checkou=
t to be
> > > > > > safe-and-limiting like switch, then that should be almost as =
simple as
> > > > > > removing that condition.
> > > > >
> > > > > I've never heard a dissenting vote against this
> > > >
> > > > Here is my dissenting vote: I'm against this change.
> > > >
> > > > If I want to use a high-level command meant for novices, I use `g=
it switch`. If
> > > > instead I simply want to switch to a different commit and I want =
git to shut up
> > > > about it, then I use `git checkout`.
> > >
> > > Thank you for your perspective on the relationship between these co=
mmands.
> > >
> > > I don't fully share this perspective, in two ways:
> > > - In my experience most novices don't see or know about "git switch=
"
> > > at all - the vast majority of the internet is still stuck on "git
> > > checkout", as are existing users. Google search result counts are o=
f
> > > course a poor metric of anything, but compare 100k for "git switch"=
 to
> > > 2.4M for "git checkout".
> >
> > Yes, but that's something for the Git community to fix.
> >
> > Why can't the git developers communicate effectively with the user ba=
se?
> =

> Emm... I'm going to take that as a rhetorical question, since you've
> been around these parts for a lot longer than I have :)
> =

> (I have opinions, but they are not pertinent to this thread, and I
> don't have meaningful solutions)

Yes, it was rhetorical.

That being said, if you feel like sharing that opinion off the record,
I'm interested in hearing it.

> > > - As far as I can tell, "git switch" and "git restore" have exactly=

> > > the same power and expressiveness (except specifically the lack of
> > > "git switch --force" support for bulldozing ongoing merges) - they =
are
> > > just as much "expert" tools as "git checkout"; the main way they
> > > differ is that they are clearer about what they're doing / what
> > > they're for.
> >
> > That is not true, you can't do `git switch master^0` because that wou=
ld be
> > potentially confusing to new users, but you can do the same with `git=

> > checkout`.
> =

> Ah, I see your point - git switch requires you to be more verbose in
> this case, specifying an extra --detach.

Yes, because it's meant for more novice users.

> > > > If there was a way of doing:
> > > >
> > > >   git -c core.iknowwhatimdoing=3Dtrue checkout $whatever
> > > >
> > > > Then I wouldn't oppose such change.
> > >
> > > I know I keep wavering back and forth on this, my apologies for my
> > > inconstancy: *I once again think adding support for "--force" (to
> > > checkout and switch) with ongoing operations makes sense.*
> > >
> > > This does not achieve exactly what you seem to be suggesting above,=

> > > for two reasons:
> > > 1. It could not be implicit in config, but rather would need to be
> > > explicit in the command
> > > 2. The outcome of using --force is not exactly the same as "git
> > > checkout" without it (but that's a good thing)
> > >
> > > I would (and will) argue that not achieving exactly what you propos=
e
> > > *is OK* because the behavior of "git checkout", without "--force",
> > > when there is a (merge, rebase, cherry-pick, am, bisect) operation =
in
> > > course, especially the way that behavior differs from when "--force=
"
> > > is specified, is *not useful* - even to expert users.
> >
> > OK. That may be the case.
> >
> > But it wouldn't be the first time some operation is considered not
> > useful, and then it turns out people did in fact use it.
> >
> > I would be much more confortable if there was a way to retain the
> > current behavior, but if we are 99.99% positive nobody is actually
> > relying on this behavior, we could chose to roll the die and see what=

> > happens (hopefully nobody will shout).
> =

> It sounds like you're distinguishing here between "options for
> experts" (which should be valuable to warrant influencing the
> long-term design) and "behavior that users and systems may have come
> to rely on".

Sure, they are different, but they are related.

If somebody has only one week of expertice with git, I think it's safe
to say they don't rely on the current behavior that much.

On the other hand somebody who has 15 years of experience with git has a
higher chance of relying on the current behavior.

> As I've argued here, I believe that the current behavior
> is not *useful*, and thus a "but the expert users" argument doesn't
> sway me at all...

And you may be right, I'm not going to argue against such claim.

But this is an argument from ignorance fallacy. The last time I argued
"I cannot imagine how X might be the case" turned out X was the case.

> I can't imagine this pattern being used in real-life automation, but
> like anyone my imagination is limited.

Indeed.

Once again: I'm not saying this is going to break user expectations,
because it might not. I'm saying this *might* break user expectations,
but we could still roll the dice and find out.

Ultimately this is not my decision, it's the decision of the maintainer.

> Here is precisely where I don't know how to judge "breakage risk and
> value of being able to revert behavior without downgrading git" vs
> "complexity of implementation and communication". Obviously I would
> prefer not to do a bunch of valueless work implementing and supporting
> an option that no-one would ever use, and removing it a couple months
> later.

Agreed, which is why I'm not suggesting this work has to be done, but
the maintainer might (I've often done what I consider unnecessary work
just because of that reason).

All I'm saying is that because the git project puts a premium on
preserving backwards compatibility (as any decent software project
should), then:

> > But if that's the case, I think this is something that should be a
> > conscious decision that is extremely clear in the commit message.

Cheers.

-- =

Felipe Contreras=
