Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B1EC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D62E610A6
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhIOSkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIOSkF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:40:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3B1C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:38:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i6so7127579edu.1
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=MRHVk2zBU22s3EeMZAT+DIG/SBqWWgFOEvq0go28E5o=;
        b=QlZOMtbu5vPQ/cXziJhFB2JHFMPSbG4miSMQbhhCbQdIvb81oSGY9nqtuyFSbufVI3
         8R+SiWsHgHD+yH60pCo6k+X6Lbr0/Gl4EG3xm6CHYwFdL3FxtDcQXMjfPM2hxaSIiVST
         wKOYINlPYOew8rsOGluUDi75mh5n6LJ40rzJRK/5iia8IQEUkJCML8pbFRCQbFLhG5p3
         fofeIqxSs9mJALe5mUaA28afyY5hLDiSwtSggYPrNU8QQJ4JTPd83zHPJg2ECosbH5iR
         Rq0p/hymnnB+cmShPvPHibRYISIElAHOmdnOku1ctnDaRn+coHe6GH5oYwmzs208ulVD
         8f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=MRHVk2zBU22s3EeMZAT+DIG/SBqWWgFOEvq0go28E5o=;
        b=l8dcXvXpauH9UX1GDwLkMNPozKmxgTLGQaI3OcByP2ALc30TBzBrCVWpjnAVHMBTO8
         Yllye5peiMJWBC9ZKhe7cr99kpq/ftVxNowTUdY+7dTkwNFrdJDrP87D2OuGtWQrsVmP
         FFGOO1ugaJ8SQ2khCzFp6bztPdL3DgVHRy06YAyUWe4nH3c7tymtewLUqmUwHVQcumpJ
         3/Kblc+XIUOqFvk7d1hE6H2IEwvYa1USu7NikfCQm8r6uZHfX50Rf0Y+KaUoSpqQCYZp
         7xo+EmDwxPBHknp9Jyz5/gzzCQqlCz+f1Jz0c4+K5LtTY7CZpVKzQDHDVIvA74dyRm+9
         CnOw==
X-Gm-Message-State: AOAM533CKULmDkkt4bvMU45zQS5pcQ2/F7uYrl3Pv+uU11sFHNDorPwY
        6p6Rgx6hEl/MZtC836RfRxLSUxx+2Ok=
X-Google-Smtp-Source: ABdhPJztwzDSlP6LIq3cGLIqdXw8ec0obZIPuZSx5oy8UQE2mn5vXlZI6gKb61YY002u88AxXykxPw==
X-Received: by 2002:a50:d713:: with SMTP id t19mr1578730edi.2.1631731123971;
        Wed, 15 Sep 2021 11:38:43 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b3sm329513ejb.7.2021.09.15.11.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:38:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: Train station analogy, was Re: [PATCH v3 00/15] [RFC]
 Upstreaming the Scalar command
Date:   Wed, 15 Sep 2021 19:51:04 +0200
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
 <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <87r1dydp4m.fsf@evledraar.gmail.com> <87ilz44kdk.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
 <87mtofnzv1.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet>
 <xmqqilz32hhr.fsf@gitster.g> <87ilz3nhfg.fsf@evledraar.gmail.com>
 <5ae0c3fe-52a4-49b2-32c2-17feab2dd2d5@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <5ae0c3fe-52a4-49b2-32c2-17feab2dd2d5@gmail.com>
Message-ID: <87k0jhn0p9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 14 2021, Derrick Stolee wrote:

> On 9/14/2021 2:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Sep 14 2021, Junio C Hamano wrote:
>>=20
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>
>>> At least to me, how this Makefile for Scalar should interact with
>>> the overall build process does not mesh well with the story about
>>> hwo direction to and history of the station are unrelated.  If we
>>> plan to start from contrib/ and eventually want to make it a part
>>> of the core Git (i.e. "git scalar <subcmd> ..." becomes just like
>>> "git bisect <subcmd> ..."), we would eventually need to see the
>>> recipe needed for including "bisect" and "scalar" work the same
>>> way, no?
>
> We should definitely work to find a better way to describe our
> vision for how _the ideas in Scalar_ can be adopted into Git proper.
>
> Before this series, we were adding functionality to Git that allowed
> Scalar to simplify to just a CLI that configures Git features. This
> submission allows that CLI to be available via an opt-in compile flag.
> This should allow more users to try out the ideas and perhaps we find
> the things that really work for people (and almost more importantly,
> the ideas that are _too_ opinionated).

Yeah that makes sense. I think it looks like a useful command & it's
already useful to users.

I haven't been suggesting any changes to what gets installed here, FWIW
I think we could be even more aggressive on that front, e.g. shipping it
unconditionally in libexec, maybe with an optional switch for
/usr/bin/scalar, or to ship "scalar" symlinked to "git" and have it
route to the top-level scalar command depending on argv.

I dabbled in that a bit locally, FWIW it seems if anything even easier
to do than the approaches we've discussed so far, but I wanted to focus
on providing the same behavior in terms of build system maintenance.

> But the way I see Scalar being fully incorporated into Git is not as
> a "git scalar <foo>" command or even having "scalar" be included by
> default. Instead, perhaps a new builtin would need to be created and
> its CLI would need to be presented and reviewed with significant
> attention to long-term support in the Git project. Having Scalar as
> a testing ground for these ideas seems like a positive way forward.

*Nod*

> This is a big reason why we think that contrib/ is a good place for
> it to exist.

Here's where you and Johannes lose me. There's some rationale in your
minds for why sticking it in contrib is the obvious way to go. So far
you've been describing how it'll look to users etc, how it's arranged in
our source tree only matters to git.git developers.

I think the actual reason is to carve in advance some subjective
ownership/apartness or whatever for this thing, if that's the case I
think documentation/commit messages would also work.

I really don't care much if something lives in contrib or not in the
abstract, but various integration around builds in Makefile makes that
much easier in practice, and if "make install" looks the same...

>>> I am getting the impression that such a unified build process is
>>> =C3=86var wants to see at the end, I am not even sure if you do from
>>> the above "analogy".  Cool down a bit, perhaps?
>
> I agree that the temperature of this thread has gotten a bit
> heated. I think there is something valuable to be gained from
> each perspective, but not in a way that either has presented it.

Thanks, hopefully we can keep it jovial going forward. If you've got any
(either on-list or off-list) feedback about how I can improve my side of
that it would be most welcome.

>>> The following assumes that you share the goal of making "git
>>> scalar" just like "git bisect"---another first class citizen of
>>> Git toolbox, the user can choose to use it or the user may not
>>> have a need to interact with it, but it exists there by default
>>> and is not an opt-in add-on component.
>>>
>>> I would understand it if your plan is to convert to a unified
>>> build procedure at the very end of the upstreaming process, and
>>> not while you populate contrib/ with more and more scalar stuff,
>>> because the Makefile bits for the entire scalar, while not yet
>>> upstreamed, has already been written as a separate procedure and
>>> having to convert the whole thing upfront before you can start
>>> trickle parts would mean you need to (re)start the process.  And
>>> I would even be sympathetic if you felt it like a distraction.
>>>
>>> But at least I view it as a step that needs to happen sometime
>>> between now and at the end.  I do not yet have an opinion on
>>> which one is more pleasant, between (1) having to deal with a
>>> single Makefile that needs to be aware of two different locations
>>> *.[ch] lives in, and (2) having to deal with two Makefiles that
>>> duplicates definitions and risks them needlessly diverging.
>
> Since we already need to modify the root Makefile, I think having
> the root Makefile add the files from contrib/scalar from an
> optional flag is a great way to reduce duplication across multiple
> Makefiles while also maintaining the Scalar is compiled optionally.
>
> One big goal is to minimize how often we need to update Scalar. I
> can see things like adjusting the recommended config once per
> release cycle based on which new features are available. I don't
> really want to be spending time updating the Makefile to match a
> contribution that was already carefully reviewed and tested. I
> also don't want to put the burden of updating contrib/scalar upon
> those contributors.

I'd think not having large parts of t/Makefile & Makefile should ease
that maintenance burden for you & others.

>> For what it's worth what I had on top of this is not (1) or (2), but a
>> (0): I.e. there isn't a contrib/scalar anymore, I moved:
>>=20
>>     contrib/scalar/scalar.c -> scalar>     contrib/scalar/scalar.txt -> =
Documentation/scalar.txt
>>     contrib/scalar/t9099-scalar.sh -> t/t9099-scalar.sh
>>=20
>> We build, test, and otherwise check (e.g. "make check-docs") it by
>> default, what we don't do is install it unless you ask. You need to run:
>>=20
>>     # Or any other install* target
>>     make install install-doc INSTALL_SCALAR=3DYesPlease
>>=20
>> It could be be kept in contrib/scalar/ even with that sort of approach,
>> and it would still be simpler than the two-Makefile approach.
>
> I think keeping it in contrib/scalar is best for now. But I do
> agree that a single Makefile has benefits.

I noted the "why contrib" above.

> One early suggestion from a while back was to modify git.c to
> handle the "scalar" executable as well as the "git" executable,
> specifically to reduce duplication handling options such as
>
>   -c config.key=3Dvalue
>   -C worktree
>   --exec-path
>
> and similar commands. While our duplication of the "-c" option
> does add similar code in a second place, these other options
> are less critical for Scalar, especially in its current version.
> I think refactoring the code in git.c to cater to the "scalar"
> executable is at least premature. If we want to pursue these
> other options in the future, then that refactoring could happen
> as a separate discussion after the rest of the build system and
> CLI have been figured out.

As noted above that seems like a sensible way forward, I hadn't noticed
how much of git.c's setup was copied into scalar.c.

It seems to me that it wouldn't be that hard, on the order of the
existing setup code or less. I.e. just make "git.c" learn that it may be
running some arbitrary command name, and do some options parsing, but
and finally dispatch to a cmd_scalar(). IOW mostly like a built-in.

> _Perhaps_ Johannes still had that level of integration in his
> head when responding to the single-Makefile recommendations.
>
>> But just moving the code, tests and documentation where everything else
>> lives cuts down an all sorts of special cases, file globs in various
>> places (e.g. doc lints) will just work and won't need adjustment.
>>=20
>>> I also would understand it if the reason why you want to keep the
>>> top-level Makefile as intact as possible because you sense a high
>>> probability that scalar will stay in contrib/ and even turn out
>>> to be a failure.  Keeping the build procedure separated certainly
>>> will keep it easier to yank it out later.  But I do not think
>>> such a case is quite likely.
>>=20
>> For what it's worth the WIP patch(es) I have on top of it will probably
>> make such a thing even easier, not that removing it from the tree would
>> be much of a problem in either case. It's mostly a few lines added to
>> lists in various places in the Makfile.
>
> Do you have a version of these patches available for adaptation
> into this series? I'd like to take a look and see what it would
> look like to squash them into this series. Forgive me if I just
> missed the link. (I see the diff you posted earlier in this thread.)

I've got it at
https://github.com/avar/git/tree/avar-dscho/scalar-the-beginning-normalize-=
Makefile

Not very ML-ready, and soft-depends on some other Makefile cleanups I
thought I'd do & still haven't untangled and submitted. Soft-depends as
in this can easily be done on master, but some of the variable names
etc. are quite confusing there.

But you should be able to check it out, it'll build, test and install if
you run "install" with "INSTALL_SCALAR=3DY".

You may run into on everly eager new (but unrelated to this, I just
merged it on top) Makefile assertion I'm experimenting with, just
comment out the relevant line in the Makefile if that happens,
i.e. something like this error:

    Makefile:3608: *** "please sort and de-duplicate BUILT_INS_EXTRA!".  St=
op.

>> If I were to clean this up properly most of the changes would be
>> teaching the Makefile that it can build N number of named top-level
>> "special" commands that get dropped into bin/, not just the "git" we
>> hardcode now.
>
> This is an interesting idea for revamping how adjacent tools are
> compiled and shipped with Git from contrib/ (or possibly elsewhere
> if we decided to start including more things as "blessed helpers".
>
> As a complete aside: I'm interested in using the sparse-checkout
> feature as I work on the Git codebase, just to make sure I hit
> pain points before any other user.
>
> This is the best that I could do for my purposes:
>
> $ git sparse-checkout list
> .github
> Documentation
> builtin
> compat
> contrib/scalar
> ewah
> git-gui
> gitk-git
> gitk-gui
> gitweb
> mergetools
> negotiator
> perl
> po
> refs
> sha1dc
> sha256
> t
> templates
> trace2
> xdiff
>
> And 'git status' reports that this includes 97% of the tracked
> files. Perhaps there are ways to make this be smaller by having
> make skip building things like git-gui if the directory doesn't
> exist. Another idea would be to skip any logic around translating
> messages if the 'po' directory is missing.

For git-gui in particular NO_TCLTK=3DY should do it.

> The reason I bring this up is that I'm interested in finding
> ways to make our build system be streamlined a bit using the
> presence of directories as a way to opt in/out of certain build
> outputs. Since Scalar is being added as a new component, this is
> a good opportunity to establish a pattern that works for this
> effort, too.

Sure, the hard part isn't that you can't grep out nonexisting files or
directories when building where we now use a glob.

It's that everything downstream of that, i.e. tests, installation
etc. is going to have to work properly in the face of arbitrary parts of
what the developer who tested the code expected going missing.

Which is why we've generally carved out very specific things, usually
along the boundaries of installed dependencies.
