Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DA4C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7A761247
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbhHXV0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhHXV0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:26:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC155C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:25:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g21so33747053edw.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qGimJ3oSvJhX4Azt9pq+XOeIrBpKE8cLbTfxN1SRqoM=;
        b=ULhQY6vQrjCEquVikTBkFqbcfTWkvxh0bneuggOaaVV1n4SHs06gUm3Ieyb/ohiGfq
         vG92Ga+oGWcMKZhDgLzEN+MIW3SFERFl/MzKXJy8UttUivqPWzJDWYE0QpRI3TnypPtf
         qUXVeSjZGmttWAqiWsdb8bS7Ol/jdSEp6OPhwM0I1HQUfy+awVyBKmxaDt4pCXEPV45+
         XP9t+/aTJ09eemfd62WZEGnH27JgXS2tQMsjNRRAC2lUzAJPzmbSEUc0HO7lDHUlND8R
         AXv4EpDuimvvYE6At6759sh0tqsAAWvt+nlWwUNDzxiX50zM352nOcpfON1mJb67VT58
         g0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qGimJ3oSvJhX4Azt9pq+XOeIrBpKE8cLbTfxN1SRqoM=;
        b=HUBNJV++c1smnIpyKIK8Avlh8pVBRtwdwjQMxwIdp628DRHozXQK7eEocDlG3CfR18
         v9pno6/rhf8Z5bNcbhfSiJ2QdJigzzeBhfnDAvfZBIKgWmyDghZmkN1KCUKfJUZDvuYy
         nvTJmIL42jg8koOy9QcJI4CWsGEWVhBRfii/aSkM42SCd4ZJQjV0b57Ze6saqW6Silfv
         kQLgQle/EjYX1o4mMibn9HJnOcEYykRd4kXo2+oLONMUx2WJCC+1EyhDHFxlBKei43cZ
         SA+kQX9Dr7i7Q2m6sz5PdlYiyWD818q/cwo3VHFNIJZ9l5G+mTiVdSeXUDVtd9HVsDbo
         2cWg==
X-Gm-Message-State: AOAM532hcIqLF5RnXkhX4QpQmTD95YyW+7GEuqnRfAJ/ivKuKUgyvfK/
        +SHuEXXkgJBgpJU8NwA4ruRSyiprS+xiJg==
X-Google-Smtp-Source: ABdhPJzhXlm+v0YUa+0oc8/lT7el6D3ez5lKBh5psJrpy30vh9vL8nsqa0xB/R6OTp4NYqy+IId+CA==
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr44662181edt.321.1629840314989;
        Tue, 24 Aug 2021 14:25:14 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b13sm9712464edu.27.2021.08.24.14.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:25:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/6] config-based hooks restarted
Date:   Tue, 24 Aug 2021 22:29:33 +0200
References: <20210812004258.74318-1-emilyshaffer@google.com>
 <20210819033450.3382652-1-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210819033450.3382652-1-emilyshaffer@google.com>
Message-ID: <87fsuyeds6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 18 2021, Emily Shaffer wrote:

> This is the config-based hooks topic rebased onto v4 of =C3=86var's
> branch[1]. There is a happy CI build of it on GitHub[2].
> [...]
> Right now I'm trying to focus on this series first and foremost, hence
> sending two rerolls based on the same version of =C3=86var's base restart.
> I'll try to perform a code review on =C3=86var's latest tomorrow.
> [...]

First thank for the review on the base topic at
https://lore.kernel.org/git/YR2jLdYQA5CVzX5h@google.com/ &
https://lore.kernel.org/git/YR7r3h1AG4Zyn7x7@google.com/ and related.

I'll re-roll it soon pending your feedback on comments I left on this
series that pertain to it. I.e. there's some things that I think are
better just fixed up in the base topic (from trivial things like
whitespace changes, to some behavior changes), makes for easier reading
rather than going back & forth between the two.

I've read this whole series through, as promised in
https://lore.kernel.org/git/87lf4qeh86.fsf@evledraar.gmail.com/:

    [I'll discuss my opinions on the new and revised config schema in
    another mail, just commenting on the patch here in terms of its stated
    goals].

I.e. here's some general comments, numbered for ease of reference:

0)

I think this is in much much better shape vis-as-vis the simplified
config schema that's now being proposed re our discussion starting
around https://lore.kernel.org/git/87bl6ttmlv.fsf@evledraar.gmail.com/

I.e. the main complexity of the "skip" mechanism is gone, and also the
conflation of hook names with hook commands (the "rm -rf /" as a
<name-or-cmd> discussed in the above).

So before going any further, I'll just say that I wouldn't object much
to this design going in as-is. What I'm about to mention here below is
much closer to bikeshedding in my mind than "this is really to complex
to go in-tree", which was my opinion of the config schema before.

1)

On the current config design: First, before going into any detail on
that, I think whatever anyone's opinion is on that that the
design-focused patches as they stand could really use more a more
extended discussion of the design.

I.e. talk about the previously considered config schema, why it evolved
into its current form. The trade-offs involved, and why the patch
proposed to implement the schema it's implementing over another earlier
or alternate design.

I.e. https://lore.kernel.org/git/20210819033450.3382652-6-emilyshaffer@goog=
le.com
is two very short paragraphs. We won't be able to summarize all our
month-long discussion on the config design in one commit message, but I
think at least discussing it somewhat / linking to relevant on-list
discussions would make future source spelunking easier.

2)

So that out of the way, a comment on the current config design, which
should be read in the context of what I noted in #0. I.e. I'm *much*
happier with this version.

That being said I'm still not convinced that the simple 1=3D1 mapping of
"hook.<name>.command" and its "value" should be followed by the 1=3Dmany
mapping of "hook.<name>.event" and its "value".

I.e. we're making the trade-off of saving the user from typing out or
specifying:
=20=20=20=20
    [hook "my-pre-commit"]
    command =3D ~/hooks/pre-commit-or-push
    event =3D pre-commit
    [hook "my-pre-push"]
    command =3D ~/hooks/pre-commit-or-push
    event =3D pre-push

And instead being able to do:

    [hook "my-pre-commit-or-push"]
    command =3D ~/hooks/pre-commit-or-push
    event =3D pre-commit
    event =3D pre-push

So for the very common case, saving two config lines. "Two" because as
we discussed[1] as there's currently no GIT_HOOK_TYPE env var. So this
form will work pretty much only for that case.

I.e. unlike with .git/hook/<name> the hook run via config can't
determine what <hook-type> it's being run at, so as it stands this is
only useful for those hooks listed in githooks(5) where someone would
want to do the exact same thing for one or more <hook-name> names. You
can't use it as a general routing mechanism for any hook type as it
stands.

I *think* that's only these two, perhaps "update" and "pre-receive",
with the hook seeing if it consume stdin/has arguments to disambiguate
the two.

But even with a GIT_HOOK_TYPE passed the trade-off, as discussed in [1],
and downthread in [2], is that by having it 1=3Dmany we're closing the
door on any future hook.<name>.<whatever>. I.e. config that would change
the behavior of that hook, but you'd want to change it in another way
for at least one of the N event types.

Well, "closing the door" as in if you'd want that you'd have to split up
the section from the "my-pre-commit-or-push" example above to the
"my-pre-commit" and "my-pre-push" example.

But again, on the "is the complexity worth it" we're then having to
explain to users that they can do it one way if the want no config other
than hook.<name>.{command,event*}, but another if they have another key
in that namespace.

You've said that you wanted to add something like a GIT_HOOK_TYPE
environment variable. Fair enough, and I guess we could add it in a
re-roll of this series. I'm mainly commenting on the end-state of *this*
series in particular. I.e. I think it leaves the user & implementation
with a config schema that still seems to be needlessly complex for the
very limited benefits that complexity brings us in what you're able to
do with it now.

But some of that goes back to the comments I had on 5/6[3], i.e. I'm
willing to be convinced, but I think that the current commit message &
added docs aren't really selling the idea of why it's worth it.

3)=20

As an extension to my comments on 5/6[3], I think this whole notion of
"git hook run <name>" as invoked by a user of git is just more confusing
the more I think about it.

I.e. 5/6[4] is apparently seeking to implement a way to just make that
facility a general way for users to run some command on their system to
do whatever, instead of say using /usr/bin/parallel or a shell alias.

But then we also use that command as our own dispatch mechanism for our
own known hooks, except mostly not, since we mostly use the C API
ourselves directly.

It's particularly confusing that if you say run "git hook run
pre-auto-gc" as a user to test your hook you'll have that hook run in
the same way that git-gc(1) would run it. So someone developing a hook
might think they can use "git hook run" for testing it.

But if you do the same with say "git hook run pre-receive" or anything
else that feeds arguments or stdin (e.g. "update", or "pre-receive"),
you'll have your hook happily being run by git, but in a way that's not
at all how such a hook will be run when it's run by git "for real".

So I wonder if we shouldn't just have the thing die() if you try to run
any hook that's in githooks(5) itself, except for sendemail-validate and
the p4 hooks, since we need to run those ourselves.

Or have those use an internal-only "git hook--helper", and start out
with "git hook" just supporting "git hook list", and then later on have
"git hook run" (or perhaps "git hook run-configured"?) be an entry point
for this facility of running some arbitrary script that's not a "real"
hook.

I don't know, maybe I'm the only one that finds this confusing...

1. https://lore.kernel.org/git/87bl6ttmlv.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/877dh0n1b3.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/87lf4qeh86.fsf@evledraar.gmail.com/
4. https://lore.kernel.org/git/20210819033450.3382652-6-emilyshaffer@google=
.com/
