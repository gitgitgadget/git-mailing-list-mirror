Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC29FC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 05:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDRFyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 01:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDRFyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 01:54:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA08030E8
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 22:54:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a7b02615f1so18898401fa.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 22:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681797255; x=1684389255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pph6rPSJAwx+ad1NOgvSvq3Np8754S4oYKQ+UHMTGzk=;
        b=gApIYNBN7LEgNSMCjNMOFuakQ5j/iRFdPkjJytTmg86wEemWijcZdhkF/f3q556XNR
         +aEk2LZSC+aF9mrzERBXqZp25L2Eoubp6Puc/8jceT9dhDisoASsu+lsGoVo+bNHD5/w
         p47AvP/Xy3BL46EbGg+XGgm9qnh+G449dv5VPqFQK6W/EPjAjkbbJTx4K/etL5GysmHL
         B+0HYQCxsIZ9jdPLpXhF/wQJjXXrxPRwxsRjsIGPmyCVMZXHE4sWqVdMx+oJAWGieOcX
         k0Ixf4uirhxmcbIqeFsCtinl+wAwcWuVWPZLhXVPiO3l9gyezYQWi60yfz6y5wi/YgqF
         O9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681797255; x=1684389255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pph6rPSJAwx+ad1NOgvSvq3Np8754S4oYKQ+UHMTGzk=;
        b=SoKjq+lpWSS3OG5JRemGqK4NMjJwWvZYKaN7QH+USZVfAMhNB7MCLEnH2cVFmAJ+A9
         6yf6VCTF3x/mHPMbSKImRxB/toiU5sHVNHa8hwtWoqBJ4Y0StHv8u2v1G/arlqbVEk+X
         UL+JQzRd1aMDTEvW51Fttp07nmfhRcB8+8sg+uYOCqzP+TtFCrj0S4ebUmeGSiZ05iUf
         GcXR2qxkY2KU+GybFkpetVHME0GNC6kfq+9+OGy3XRxQ584TgrBr7ssS3yicde5TOuSJ
         myVqvGwxPm7Bvo1BRvAjPoy/cL1CAfXFjHFPvq/G8yQ40lMDYqRLrDvrFZjrbA9BkpK9
         FOZg==
X-Gm-Message-State: AAQBX9cwazyMOqU9SjoShz1gX8eW79+i1AVbFn2lR+SbSEQdQLmtAqt/
        +QIkSFxQt/+BprUUkA/wWs/BJNPhLqWlhrxu3QE=
X-Google-Smtp-Source: AKy350a4mtdJojUmEA5cGSbzY92FJCvA9H8i2sFSg9oYH2gPg9iIy1ywfMd6BMT7YtOtBffKNpZ36bzJUmLJYCTD1MU=
X-Received: by 2002:a19:7001:0:b0:4ec:4f58:f24d with SMTP id
 h1-20020a197001000000b004ec4f58f24dmr3012566lfc.7.1681797255022; Mon, 17 Apr
 2023 22:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com> <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
 <89c78da5-388a-e52b-b20b-e376ac90de14@github.com> <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
 <b9732826-5732-0f87-9527-f49c38514fd7@github.com>
In-Reply-To: <b9732826-5732-0f87-9527-f49c38514fd7@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Apr 2023 22:54:02 -0700
Message-ID: <CABPp-BG3xNmwbtu+tstLr8bT24rr0gG65ZvD1rEeus_V8OYk=Q@mail.gmail.com>
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 7:05=E2=80=AFAM Derrick Stolee <derrickstolee@githu=
b.com> wrote:
>
> On 4/15/2023 3:07 PM, Elijah Newren wrote:
> > On Fri, Apr 14, 2023 at 7:23=E2=80=AFAM Derrick Stolee <derrickstolee@g=
ithub.com> wrote:
>
> >> Sending arbitrary command-line arguments to setup_revisions()
> >> creates an opportunity for behavior you are not expecting.
>
> >> [unstated: and what about other similar options?]
> >
> > I'd really rather not have an allowlist of which revision options
> > should be allowed for use by git-replay.  A denylist might be okay, if
> > also implemented for fast-export, but I'm more of the opinion that we
> > just document that both commands only make sense with "contiguous"
> > history.
> >
> > Most importantly, though, at a minimum I do absolutely want to allow
> > several negative revisions to be specified, several positive revisions
> > to be specified, and special flags like --ancestry-path or
> > --first-parent to be specified.  There may well be additional flags,
> > both current and future, that should be allowed too.
> >
> > In short, I don't want another limited rebase; I want a more generic to=
ol.
>
> The primary value of git-replay (to me) is that we can do "simple" rebase=
s
> without a worktree or user interaction. To me, simple rebases mean apply =
a
> linear sequence of commits from a single branch onto another branch (and
> specifying an "old base" is simple enough to include here). It also means
> that we abort completely if there is a conflict (and handle conflict
> resolution in later changes).
>
> The sooner we can deliver that, the better we can deliver on its potentia=
l
> (and expand its functionality to be more generic).

Limiting the initial scope of this tool to a smaller set of features
is okay (and, in fact, Christian has already done that), but we really
need to avoid painting ourselves into a corner if we change the design
as part of that limiting.  As I stated previously[1], I'm worried this
is happening.

[1] https://lore.kernel.org/git/CABPp-BH7ZPBtV5Hu_-_yVdqVmiydW7_s_LYAtwbPuY=
SbRQiuQw@mail.gmail.com/,
under "from my view"

> And this is generally my preference, but we shouldn't get functionality
> "by accident"

All of the specific flags and cases you brought up so far were ones I
already carefully considered over a year ago, so the "by accident"
comment seems a little unfair.

> but instead do it with full intention

The intention is listed in the subject of the commit message of this
patch.  I've also explicitly stated my desire on this list to make a
tool which replays based on a general range expression multiple
times[2][3][4][5].  And there are tests for general range expressions
in this series being reviewed.  I don't understand why you might think
I didn't intend to use general range expressions.

[2] https://lore.kernel.org/git/CABPp-BEAqP7maTVw82Qr8mn-sxPzXmHnE_mTKf2pg6=
hVYAJSUw@mail.gmail.com/
[3] https://lore.kernel.org/git/CABPp-BHmj+QCBFDrH77iNfEU41V=3DUDu7nhBYkAbC=
sbXhshJzzw@mail.gmail.com/
[4] https://lore.kernel.org/git/CABPp-BHARfYcsEM7Daeb7+vYxeB9Awo8=3DqbrOMXG=
6BQ0gX1RiA@mail.gmail.com/
[5] https://lore.kernel.org/git/CABPp-BEOV53oBoBp4YjiRfksZMmAADanZUUemhxwn7=
Wor=3Dm-nA@mail.gmail.com/

> and strong testing.

The series as it stands already has some good testing for multiple
divergent branches, which already takes it beyond the simplistic cases
you were focusing on.

Yes, there should obviously be tests for even more cases, and yes I
did leave this series in a work-in-progress state nearly a year ago.
My Git time has been limited, and so I have tended to only work on
things that needed short bursts of attention, like responding to the
list, or the cache.h refactoring...

But I'm kind of at a loss trying to understand this paragraph.  Am I
misinterpreting what you are saying?

> I will always think that certain shortcuts should not be used. This
> includes passing arguments directly to setup_revisions() and using
> pathspec parsing when a path string will work just fine.
>
> If we have a need for a feature, then we should add it explicitly and
> carefully.  The surface area of setup_revisions() is far too large to hav=
e
> confidence that we are not exposing bugs for users to trip on later.

My original plan was to just extend rebase rather than create a new
command.  While it'd be an extraordinary amount of work to change
rebase to work without touching the working tree or index, it didn't
look completely insurmountable.  The first thing I found that did look
completely insurmountable was extending it to handle rebasing several
divergent branches possibly sharing some common history.  Since
handling possibly-divergent branches was one of my primary motivating
goals, I'm really rather unwilling to accept the suggestion that we
should strip the tool and copy rebase's broken design, since that
would prevent the tool from ever being extended to do what I want and
what I *already* implemented.  There may be some kind of middle ground
we can find, but the suggestion elsewhere in this thread (to make
git-replay take three commits as positional arguments, with one an
assumed negative ref) is copying that exact inflexible design flaw.

If you want to move git-replay away from setup_revisions(), at a
minimum I think we need a proposal that can be extended to the cases I
highlighted previously:
    * allow specifying several negative revisions (or maybe even zero of th=
em)
    * allow specifying several positive revisions
    * allow standard basic range syntax, i.e. A..B
    * allow --first-parent
    * allow --ancestry-path[=3D<commit>]
I think it should also be able to eventually support
    * --branches[=3D<pattern>]
    * --not
    * --tags[=3D<pattern>]
    * --remotes[=3D<pattern>]
    * --glob=3D<pattern>
    * --exclude=3D<glob-pattern>
    * --all
There may well be others I missed in glancing over the list.

That's a long list of things to parse, which setup_revisions() happens
to handle nicely.  You are right that setup_revisions() also has lots
of options for generating non-contiguous history that may make little
or no sense for replay (and makes no sense for fast-export either).
So, I am willing to consider other solutions if anyone has one, but
only alternative solutions which can eventually handle the above
requirements.  In particular, "three commits as positional arguments"
(with one implicitly being considered a negative ref) conflicts with
the first three bullet points above.
