Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BC5C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7B061362
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhJVOSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhJVOSO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 10:18:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C05C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:15:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d3so2196829edp.3
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=G02g+tjgTKheT/909jtNBLmeh97xDWRIrkVy8upqxgM=;
        b=FqIti9hmQxPy6gTbeNKMNCowue7Bh5k6vX+GK8cI2wpbqi3cFjqQSDd81zpZDBAKJL
         lJoQ4UoZ9sxFJ5qWsO6LpBhf9tHC3o1sTYpTFd/DTMNa9X0ZdLLEokfK3l/yFCZq09kJ
         UwvHGBJpjo6KXJhero9zdat3UJnuu+q9X/VEpTTKMmt+MGvQU3JuNsJMHVX8VLqLG6xF
         qzu+AS3uJh6lox628FIpGPZztyzCh6MIIIFH39Zrw7Hn/rkD9XxPPSDh+/2aYI/KLd9Q
         /iw1dXsnhmDsuZtgXHF5pS1q+yeGU9lpCEZ5vF6vizCXF+9/ABnWpuSC+ZfqNulQucxt
         gR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=G02g+tjgTKheT/909jtNBLmeh97xDWRIrkVy8upqxgM=;
        b=bk597FfVkHj5YmsHPcw7ssbDswrfjugWoIL7sKnpXOMmYRIUJsZ/2zhKYFcjRifvZs
         6B/3gp1XLO8oGGd0QwIcPFj61OSwLvt3yQQrys8Akl7RRf/80DMe2TQ1l73/iF/TRrU7
         1cbNCYwQ0B9hXQ4fGlCoq5wrLItgvHX4hMYgYphucBI+ok81it0qRcwWvG5m2oqY08Rh
         Ov/G6GoNYi6JYrhNZurPnR6PgXFxbM4L8ajGz5t4Lia9o/PdrBqbQmgbctKjM/Ix1ks6
         +Er5i1NhmNAvbXhdzBw+F2H2FnrNgmAjnlou0iUdRomaDi2lCOMXlWRSAp+0PT0jWB7E
         n1cA==
X-Gm-Message-State: AOAM533WCSvT51xdVdqZXIg56hh7ED0XIGs3AqWaEEpaGYWhmcTNP4d8
        gA4XuCx0gXX8HiIbg4uJFQB2g8pzg07eHg==
X-Google-Smtp-Source: ABdhPJzA62wMotIl6BTb5zx+1HSCqP9uikQaWz39PjLil69rq8lkDkj3xb8Tg3LFC7YZCN276P8mHw==
X-Received: by 2002:a17:906:1848:: with SMTP id w8mr16177470eje.485.1634912153124;
        Fri, 22 Oct 2021 07:15:53 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hb12sm776118ejc.51.2021.10.22.07.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:15:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdvKq-001E6Q-8i;
        Fri, 22 Oct 2021 16:15:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/scalar, was Re: What's cooking in git.git (Oct 2021, #05;
 Mon, 18)
Date:   Fri, 22 Oct 2021 15:43:31 +0200
References: <xmqq1r4hv7bv.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2110191436250.56@tvgsbejvaqbjf.bet>
 <211020.86zgr3n698.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2110210947590.56@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <nycvar.QRO.7.76.6.2110210947590.56@tvgsbejvaqbjf.bet>
Message-ID: <211022.868rylkuw7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 21 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> tl;dr it isn't worth your nor my time for you to focus on the build
> process in contrib/scalar/ at this moment.
>
> Having said that, I do appreciate your interest in this patch series, and
> I have suggestions at the end of this mail how we could collaborate on it
> in a more fruitful manner.
>
> On Wed, 20 Oct 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, Oct 19 2021, Johannes Schindelin wrote:
>>
>> > On Mon, 18 Oct 2021, Junio C Hamano wrote:
>> >
>> >> * js/scalar (2021-10-07) 15 commits
>> >>  - scalar: accept -C and -c options before the subcommand
>> >>  - scalar: implement the `version` command
>> >>  - scalar: implement the `delete` command
>> >>  - scalar: teach 'reconfigure' to optionally handle all registered en=
listments
>> >>  - scalar: allow reconfiguring an existing enlistment
>> >>  - scalar: implement the `run` command
>> >>  - scalar: teach 'clone' to support the --single-branch option
>> >>  - scalar: implement the `clone` subcommand
>> >>  - scalar: implement 'scalar list'
>> >>  - scalar: let 'unregister' handle a deleted enlistment directory gra=
cefully
>> >>  - scalar: 'unregister' stops background maintenance
>> >>  - scalar: 'register' sets recommended config and starts maintenance
>> >>  - scalar: create test infrastructure
>> >>  - scalar: start documenting the command
>> >>  - scalar: create a rudimentary executable
>> >>
>> >>  Add pieces from "scalar" to contrib/.
>> >>
>> >>  What's the status of this thing?
>> >
>> > As far as I am concerned, the current status is: We agreed that this
>> > thing _can_ live in contrib/, and that the `scalar` command itself
>> > should not be integrated deeply into Git because the end game is for
>> > `git clone` (and maybe `git maintenance`) to learn Scalar's tricks.
>> >
>> > A concern was raised that `make -C contrib/scalar` does not rebuild
>> > `libgit.a` whenever any of `libgit.a`'s source files were modified. In
>> > light of the previous paragraph, I believe that my time would be
>> > better spent on designing a new `git clone` option, though, than to
>> > spend time on a build process that will be soon obsolete (except if I
>> > allow myself to be distracted by things like teaching `make -C
>> > contrib/scalar` to know about `libgit.a`'s prerequisites). In other
>> > words, it is a technical debt I firmly believe is worth accruing.
>> >
>> > Other than that, I heard no objections, therefore I believe that this
>> > is ready for `next`, to be cooked in the v2.34 cycle.
>>
>> Your patches as they stand don't implement a "make install{-doc,-man}"
>> for the new command.
>
> Right. They are just a start.
>
> I would like to direct your attention to
> https://github.com/microsoft/git/compare/vfs-2.33.0...dscho:vfs-with-scal=
ar,
> which has a more complete picture of what I have.

Okey, seems to be general scalar features from a quick glance...

> It is a thicket of 8 patch series. I would like to hold your horses until
> it is time for me to submit `include-scalar-in-build`, in particular
> https://github.com/dscho/git/commit/473ca8ae673.

...the patches I've got on top of your series are:

    9 files changed, 36 insertions(+), 162 deletions(-)

Which already do the installation step and fix dependency issues you
have etc. Then this linked patch above is:

    Showing with 51 additions and 0 deletions.

So we're ~200 lines in with Makefile logic that we could demonstrably
get in a much easier way, and this still doesn't address some of the
integration bugs.

>> I'm happy to help you make that work, but I don't think framing it as
>> some abstract objection about whether something lives in contrib or not
>> is accurate.
>
> Scalar is headed to contrib/ _specifically_ to make it clear that it is
> _not_ a core part of Git. I laid out the reasons before: the user
> interface of the Scalar executable is already in use, and hence
> non-negotiable.

This invariant that something must be in a given directory so that we
communicate that it's not a "core part" is, I think, something you or
Stolee came up with. My reading of Junio's messages on the matter is
that he'd be OK with it either way.

In any case, what I've also mentioned to you is that moving it it out of
contrib isn't necessary for the changes I'm proposing.

E.g. the build process could with a couple of more rules just symlink
those for the duration of the build, or all the wildcards involved could
be adjusted. It would still be simpler than your implementation.

But since all of that would be *indistinguishable to anyone using git*,
since the difference would go away with "make install" I really don't
see why you think it's necessary over say a comment at the top of each
file, naming the files contrib-scalar.c etc.

I.e. we're *only* talking about a difference seen by people who
contribute to git, which is a handful of people reading this ML for the
purposes of this discussion.

If those people know that scalar's integration & maintenance status is
so-and-so why does an implementation detail of the build system matter?
And if one way of doing that is demonstrably much simpler, why not go
for that?

Who are these people that will see some files in the top-level directory
as opposed to contrib/* and become confused?

> Since it won't be part of core Git, I fail to see the urgency to integrate
> its build process more closely into Git's build process, _right now_.

I think the diffstats make it evident that you're wrong about what
constitutes closer integration.

Just because two parts of a program live in different files or different
places on a filesystem doesn't mean that they're not more logically
entangled.

You already have a hard dependency on git's make process and dependency
logic for this subdirectory, the question is whether that needs to be
this complex. It doesn't.

Having to have the two communicate over 2+ Makefiles makes that
integration closer and more complex, not more detached.

>> For example in your just-sent[2] you say:
>>
>>     I would like to add a plug for Scalar here. Maybe we can link to this
>>     "opinionated tool based on Git" here? I wouldn't ask if I didn't _kn=
ow_
>>     that it helps monorepo users out there.
>>
>> I agree that would be useful, but currently our documentation build
>> would fail if you linked to the scalar from other git documentation.
>> Since we lint it and check if the linkgit:* crosslinks would be 404'd.
>
> The link I was implying was
> https://github.com/microsoft/git/blob/HEAD/contrib/scalar/docs/index.md.
> Sorry for not spelling it out clearly.

Yes, but that's dodging the issue. Will we never want to have a
"linkgit:scalar[1]" anywhere else in git's documentation referring to
it? Or to refer from scalar's documentation to git's?

You do have the latter already in your patches, it's just not lint'ed in
your version of the patches.

Just like the sources aren't run against "make coccicheck". Any such
problem is small in isolation, but we've got various "make" integrations
like that.

>> I don't see why wouldn't consider an up-front solution to that technical
>> debt, or why you're seemingly ignoring comments about aspects of your
>> patches that are broken or will cause that unnecessary technical debt.
>
> One of the many reasons why one might want to accrue technical debt, and
> it is my reason in this context, is the expectation that it won't need to
> be paid down at all because we will eventually just delete contrib/scalar/
> in a couple of years, when it has served its purpose.

That sounds good, and in my version of the Makefile integration that'll
be removing a line or two referring to "scalar" somewhere.

In yours it'll be a lot more lines, not counting any shimmying we accrue
in the meantime to e.g. make doc lints and the like work for this
special-case.

>> It would be a hassle to deal with when it comes to various build-system
>> integration we already have, or which I have WIP work to implement. I'm
>> also offering to fix it for you, so it wouldn't be much of a distraction
>> to your efforts.
>
> Unfortunately, it is very much a distraction of my efforts. Not only would
> your patches force me to spend more time to rework and adapt my patches to
> your changes, as they _specifically_ touch the same code that I am working
> on. It is also forcing me to spend time on reading all your mails, and on
> writing mails like this one.

Well, you and me both. The reason I hacked up this alternate
implementation for you is because your proposed patches semantically
conflicted with Makefile improvements I've got locally.

Aside from any problems I'd have with that it seems to me that you'd
benefit more from the version of the integration I hacked up,
specifically we'll always build and test scalar, we just won't install
unless asked. So you'll get CI etc. integration from day one.

I think (but I'm not sure as I write this) that in some earlier version
of your patches scalar was truly optional, but even in your v1 it's
added to "OBJECTS", but commit message of the 1st patch still says:

    The idea here is that you can (optionally) build Scalar via

        make -C contrib/scalar/Makefile

    This will build the `scalar` executable and put it into the
    contrib/scalar/ subdirectory.

Now, I think we should just build/test the thing unconditionally, and
make installation optional, regardless of any question of where it lives
in-tree.

But aside from that this integration of building it but not testing it
seemsl like the worst of both worlds. I.e. it's not "truly contrib" in
that anyone working in-tree can ignore it, and "upstream" needs to deal
with any changes, but if you break it you might not notice for a while,
as we don't run the tests.
