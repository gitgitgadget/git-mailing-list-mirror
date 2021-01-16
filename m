Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC939C433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC6923730
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbhAPRGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbhAPQb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 11:31:29 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A25C061361
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 08:23:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u19so12963465edx.2
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 08:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KvW9emmrzaBpbwJi1FH4hreFZGYnjAWEO+vr/w5d1IE=;
        b=AJqmAdbGXOjY/TC4Hc/eO6/Tz+Z4YFTBeYzDtKrqSuxtoYrGfcSs6sN0qr1tqT7pZ7
         YyB+8IX8V5PGBVGxf01glXUOvRLvbA3ovsN7MpN+xLe5MdBjRbDQk/qD9tRFIzdYF+X7
         51TNowKeTPodqEnS9ipfcQrPaSityF+mVgLklKi/vX1Kuxd8cFXZdKoF8xtU6cIV4N9Q
         RCX66SnJYFe3s+1GTCXLbxj52U15WtABgmxVSrAKGY3a9BpSALA246m4Yo2zugcclAyi
         RHjmyc/vLByagc6IswQBj/QXkBD2mwS4FtL1keL7fCUMVLrXMLHMXbpWP9tpkLpl44bJ
         dz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=KvW9emmrzaBpbwJi1FH4hreFZGYnjAWEO+vr/w5d1IE=;
        b=rkjDxpkJcu/BXlSJq/U/HAqbOaw1T1YeLoLSLWVmOXzJEAMwc5/y26yhgW0UrhSTXt
         Y0t/YEj55LkgsvJkBetscgfo6Liq0Tuhjojg2SAQ4alOtYLR2vzAc/4jR8yG08Kh1zlS
         DOMop0K7AZ9BqGQggMpZyrZG+YA+9/LSOHNUSw5lxbxR8zLe/OHAox3VSW7NBtPToD+v
         XZD8BauiXnSFFIrXx4vfbcuzXeHXcVQT0vCW7dwTfycrDsBTwi5Nczvtif6HwhJrKK54
         l6HZemrC4kFMAfJKKKrsssaCGHUxwymPNAx6onEGbMqxBbM737eFVjepkaozxPIfIOUm
         OimQ==
X-Gm-Message-State: AOAM532io4m5WEr+C0+Cmlwpd2eKM2y5eKsl47T4B5JzRcmMDlXD19rB
        T+2JDWoIOOIM61/Kk4ohJnU=
X-Google-Smtp-Source: ABdhPJw7BUfwCLDiwEWOq0vbwAxBVGSbtvLZf0D2xPk5sUSOlng5LFp+8am8UaBQMFn/Bs4lo+c2cg==
X-Received: by 2002:a50:934a:: with SMTP id n10mr13651520eda.26.1610814220451;
        Sat, 16 Jan 2021 08:23:40 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id w17sm6755886ejk.124.2021.01.16.08.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 08:23:39 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <871reu752k.fsf@evledraar.gmail.com>
 <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
 <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net>
 <xmqq4kjpelza.fsf@gitster.c.googlers.com>
 <X/uvhc5Hpu792qA/@camp.crustytoothpaste.net>
 <xmqqeeir8fdg.fsf@gitster.c.googlers.com>
 <87k0si5k75.fsf@evledraar.gmail.com> <YADZSsVqyGnArF0n@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <YADZSsVqyGnArF0n@google.com>
Date:   Sat, 16 Jan 2021 17:23:38 +0100
Message-ID: <87im7w4zqt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 15 2021, Emily Shaffer wrote:

> On Tue, Jan 12, 2021 at 03:00:30PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>>=20
>> On Mon, Jan 11 2021, Junio C Hamano wrote:
>>=20
>> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> >
>> >> On 2021-01-09 at 23:20:25, Junio C Hamano wrote:
>> >>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> >>>=20
>> >>> > On 2021-01-09 at 21:28:58, Junio C Hamano wrote:
>> >>> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> >>> >> > FWIW there was since a re-roll on 2021-01-03, but the discussio=
n is
>> >>> >> > sort-of outstanding, so maybe that's intentional...
>> >>> >>=20
>> >>> >> I had an impression that those 4 or 5 patches haven't gained
>> >>> >> concensus that they are good as-is.
>> >>> >
>> >>> > There will be another reroll.  I'm hoping to get to it this weeken=
d.
>> >>>=20
>> >>> Thanks.
>> >>
>> >> Having read =C3=86var's latest comment, I've decided instead to drop =
this, so
>> >> feel free to do so whenever it's convenient.
>> >
>> > That's kind of sad.
>>=20
>> Agreed. I mean, I'm just one contributor with an opinion. I certainly
>> don't mean my "meh" on a patch to be some sort of veto.
>>=20
>> If you follow this list you'll see that if you're going to take anyone's
>> opinion on whether a thing should make it into git as a matter of
>> empirical data on patches I submit that aren't changed meaningfully,
>> then, uh, maybe pick someone else :)
>>=20
>> > I view that this is the kind of topic where perfect easily can
>> > become an enemy of good, as there is by definition no perfection
>> > available to us without breaking existing Git.
>> >
>> > I do not know about =C3=86var, but to me, my initial impression while
>> > reading the discussion from sideline was that the goal was to
>> > prevent a mechanical scan of a recent version of .mailmap from
>> > learning that Joe used to use Jane as his/her name, and that was the
>> > reason why I asked to be convinced why encoding for obfuscation was
>> > insufficient.  In the above, I meant "mechanical scan" as something
>> > like "a web search engine crawls and finds a .mailmap---a query for
>> > Joe produces a line with some garbage on it that is not Jane." and a
>> > casual attacker would stop there.
>> >
>> > But of course, a casual attacker who knows urlencode or whatever
>> > obfuscation in use can read that "garbage" once he/she knows that
>> > "garbage" is worth attacking (i.e. it is known to be associated to
>> > Joe, the person the attacker is interested in).
>> >
>> > If your goal is to make it harder than just urlencode, even though
>> > we all have to accept that scanning "git log --all" for all names
>> > that appear in the history and hashing them all to see what name
>> > hashes to the "garbage" in question, then @sha256:<hash> approach
>> > does make sense as a stopping point.  Perhaps we need to sell this
>> > with a clear definition of what kind of attackes we are protecting
>> > the name data from:
>> >
>> >     The attacker is required to obtain sufficient amount of history
>> >     in the project to uncover the obfuscation; a more casual
>> >     attackers will fail to uncover, and we declare that it is better
>> >     than nothing and it is good enough in practice.
>> >
>> > or something like that?  I am not sure if I drew the line at the
>> > level you intended to draw in the above, if I think that it is good
>> > enough in practice, or if I agree to a change that is better than
>> > nothing but not good enough in practice, but having such a statement
>> > would help to see where we agree or disagree.
>>=20
>> My reading of the general thread & brian's reply at [1] is that the
>> difference in the minds of the users who want the feature (who're not
>> on-list, and we're getting brian's's summary of their views) is closer
>> to:
>>=20
>>     We want the X-Y problem of "hide this data" solved with solution "Y"
>>     because git's current tooling to retrieve the data is currently
>>     rather tedious & obscure.
>>=20
>> So when I asked whether those users would feel the same if the tooling
>> was less tedious and suggested that I might patch it to be so brian
>> replied with "[yes,] we do rely on this being inconvenient".
>>=20
>> I do have a 20-something series patch to the mailmap code in my local
>> queue that in the light of this series's status I think I'll submit
>> soon.
>>=20
>> It doesn't have anything to do with adding a "spew out a materialized
>> map" feature currently, nor do I really plan to do that any time soon. I
>> do genuinely think it would be a good addition to git for reasons that
>> have nothing to do with trying to make a point about this
>> series. E.g. you'd be able to more easily validate/check/fsck a mailmap
>> that way. Or e.g. use a git repository's .mailmap as a source to export
>> to your MTA rules or whatever.
>>=20
>> The external tools I referred to which consume the exported .mailmap
>> data are something I worked on at a previous job, but I no longer have
>> that immediate itch to scratch personally.
>>=20
>> The "march of history" point was rather that if the difference between
>> URI encoding and this solution is current tooling, it seems all but
>> inevitable that we'll bridge that gap sooner than later in a way that
>> makes that difference useless to some of the users that want this now.
>>=20
>> And not even because some people don't like this feature in particular
>> and wish to submit patches to make it less useful. But just because we
>> continue implementing stuff that's been talked about for years & is
>> being generally slowly worked towards. E.g. more client<->server
>> cooperation for expensive queries over protocol v2, or a filter clone
>> mode where you get only commit objects.
>>=20
>> It even seems like something brian's series itself could benefit
>> from. I.e. having the hashed values in the history is a performance hit
>> in some cases. The patch caches the computation.
>>=20
>> Another way to do it would be to just save a
>> ".git/objects/info/mailmap.{hash-of-original-file}". Either on the fly
>> or generated by "maintenance" or whatever. It would guarantee a 0%
>> performance hit. At that point we'd already have the plumbing to
>> materialize the file & would need to go out of our way to make it
>> inaccessible in porcelain.
>
> I've got quite a few sporadic thoughts about this series and this
> discussion, so I'll braindump and hopefully it turns into something
> useful.
>
> Firstly: this design comes from a conversation amongst a pretty small (4
> people? 6 people?) group at the virtual inclusion summit some months
> ago.

As a brief aside I did attend that virtual inclusion summit, but had to
mostly not attend it in practice for timezone reasons. So this was one
of the discussions/groups I managed to miss entirely.

There's some small joke in there somewhere about the inclusivity of the
inclusion summit being a function of how close you are to California :)

> At that time, we discussed the ease of brute-force decoding the
> one-way-hashed mailmap and decided that, as long as Git didn't ship a
> tool to do this for you for free, it was better than the current
> solution for avoiding deadnames (i.e. "sorry"). I'm disappointed to see
> the larger list feel otherwise, but not terribly surprised, since the
> list contains more people than the group who came up with the design.

I think it has less to do with the list containing more people, and more
to do with no versions of the patch making any mention of this idea or
approach implicitly relying on a forward promise that there never be
such a tool shipped with git.

Having found that out in trying to help this topic along I still think
that's very questionable approach in the terms of helping the users
you're concerned about.

For one what most people think about as "I'm looking at the thing in
Git" isn't UI controlled by us, but probably some website or Git GUI. So
any commitment we make about not implementing something in git.git is at
best going to be rather ineffective in the grand scheme of things.

But at least stating that upfront doesn't require the rest of us to read
minds.

And let's be clear, I'm not putting any blame on anyone's shoulders
(least of all brian's) for that. Just pointing out that our patch review
process works best when stated aims, caveats, implicit assumptions
etc. with a given technical are all clearly stated.

> [...]
> Thirdly: As is stated elsewhere, I think this topic is falling victim to
> perfect vs. good. Git is gaining increasing notoriety in circles I can
> see about the ultimately crappy experience for people who change their
> names and don't want to hear the old names (and don't want to know the
> old names). [...]

> So I feel sad to see the topic dropped because of pushback[...]

The topic is currently dropped because the submitted requested it to be
dropped (see <X/uvhc5Hpu792qA/@camp.crustytoothpaste.net> upthread,
https://lore.kernel.org/git/X%2Fuvhc5Hpu792qA%2F@camp.crustytoothpaste.net/=
). When
a submitter asks Junio to drop a topic he'll usually just do it. So it's
convenient because of any pushback from me or anyone else.

I'm only replying to this part because...

> [...] especially when that pushback is "I'd like to write a tool to
> reverse this thing, because <vague reasons> - and I don't mean that
> tool maliciously so that should be OK."

... this point in particular seems to be an attempt to summarize my
views or motivations.

I don't see how you could read my E-Mails on the subject (especially
what you're replying to,
https://lore.kernel.org/git/87k0si5k75.fsf@evledraar.gmail.com/) and
think that in any way reflects my views on the matter.

In lieu of repeating much/any of that I'll just say that that doesn't in
any way reflect my views, and from having read all the rest of the
message traffic associated with this topic I don't see who else you
could be referring to with those comments.
