Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFA7C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 23:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiFWXna (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFWXn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 19:43:28 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184A4D61C
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 16:43:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so1293431ejc.10
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 16:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zdS6zYQL8QmmnJ0MNPrukS9oOo1wjna8MTJ/lB693R0=;
        b=KlzUHJhkRybApYC3+y6FP/Ijz1IPrc7dh9HYwjag8HuKSL9i8KFaxY42GB7USmi38L
         w1qjhYTd3f5tyHcYTPvAFvl1SFSwl3mye2GCQU0zCoTPNU3Y5LGJwjhlhtKm8rIQaW7R
         Ccx1N/5lBvuOriA4uXBGi4EPR1U412PPyIpkKz0obr2+12mCmftoCkdZntgGFmvxxTPR
         clu5K2Tl5nh2pn6AKayvDbQ2CzQHOmGzwZODdkByP+r2eGph8Vsz0Rh8HB6p6DbRvz0f
         icC6m8ZeqiXojYgpy0doI5lY7AwgcbNfWXDjvfMAf6ka156XmWA5v9+HK2rz8qQRRDnz
         rShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zdS6zYQL8QmmnJ0MNPrukS9oOo1wjna8MTJ/lB693R0=;
        b=JkRH7zv8eZmZxvbSUgf5Bn0hunijjPlYN95togMAEAyB6QgQpQRtUMMptNhxuFRhBk
         SDiM5R9ayMpJSVqrUARctxG23LV5jjnY/5/MHoWzIb7Tz/krBhR0S3ldlONZOcDtW8ST
         kvOC9KEAoOygxunaZiYigS5NgFAXXswAAB6DWT8kw03cBst9KyVSGK87NtIpzObcY7k7
         6tmUxhR9ha2oZp+SJYn9WxcKj1/t4PB1GYUx1LWLRCmQDQKGM/uSqckQ2DRLAp3afnSu
         FQ5Xg812G9BBbnBCFPBC7mM72npHk2TEE/2BI+O2TvhbIwMfgh/rzKeWQ8TVLlftUc1b
         ckjw==
X-Gm-Message-State: AJIora/xaEBL9ix7vdhqSpaycU/u1/+DO83Q0pWml+b4I7yAPfzQjWbb
        iqjyU2x5cx+f2SJ5VrJXn+c=
X-Google-Smtp-Source: AGRyM1slfTxczYylzORCvWnUibggaIcEp6pj2mHFtydkcrweLvQNxwz7w+5SYTsbL0+yKFDmhgOBYg==
X-Received: by 2002:a17:907:8a20:b0:71e:bc93:4968 with SMTP id sc32-20020a1709078a2000b0071ebc934968mr10162729ejc.573.1656027805085;
        Thu, 23 Jun 2022 16:43:25 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p4-20020a056402154400b0042dcac2afc6sm638596edx.72.2022.06.23.16.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:43:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4WTr-0016Cm-Rb;
        Fri, 24 Jun 2022 01:43:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.org>, Kyle Meyer <kyle@kyleam.com>
Subject: Re: SHA-256 transition
Date:   Fri, 24 Jun 2022 00:21:05 +0200
References: <12011256.O9o76ZdvQC@thunderbird>
 <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
 <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
Message-ID: <220624.86fsjvj690.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 22 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-06-21 at 10:25:01, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> But the reason I'd still say "no" on the technical/UX side is:
>>=20
>>  * The inter-op between SHA-256 and SHA-1 repositories is still
>>    nonexistent, except for a one-off import. I.e. we don't have any
>>    graceful way to migrate an existing repository.
>
> True, but that doesn't meant that new repositories couldn't use SHA-256.

Indeed, and people who know enough about its state can (and in some
cases probably should) use it.

I took the start of the thread to be a question about the state of the
SHA-1 -> SHA-256 transition, and what we should be generally
recommending to users at this point.

>>  * For new repositories I think you'll probably want to eventually push
>>    it to one of the online git hosting providers, none of which (as far
>>    as I'm aware) support SHA-256 repos.
>
> This, in my view, is the only compelling reason not to use it for new
> repositories.

I think certainly the main one, given most people's workflows around Git
being heavily forge-based .

>>  * Even if not, any local git tooling that's not part of git.git is
>>    likely to break, often for trivial reasons like expecting SHA-1 sized
>>    hashes in the output, but if you start using it for your repositories
>>    and use such tools you're very likely to be the first person to run
>>    into bugs in those areas.
>
> It's my hope to see libgit2 working on SHA-256 repositories in the
> relatively near future.

I was referring to the very long tail of tooling here.

E.g. I use magit with Emacs, and last I checked it would puke on
SHA-256. But checking again it seems someone patched it in January of
this year to e.g. change "{40}" in regexes to "{40,}", so in theory it
should work now (but I didn't try actually using it in that mode).

We even still have UI code shipped as part of git.git itself that only
supports SHA-1, e.g. git-gui's "blame" feature. We were discussing some
patches for that late last year, but they didn't make it in:
https://lore.kernel.org/git/20211011121757.627-1-carenas@gmail.com/

Any individual tool like that isn't critical, but I'd think that a large
long tail of tooling git users are likely to interact with, which for
the most part isn't ready.

I looked at "tig"'s source now, which I only very occasionally use, and
it still has SHA-1 sized constants hardcoded etc...

Of course that's a chicken & egg problem, and at some point we'll need
more brave early adopters. I'm only trying to relay the ground truth of
what the state is now, for someone who might not be aware of the
potential trouble they're getting themselves into.

>> But more importantly (and note that these views are definitely *not*
>> shared by some other project members, so take it with a grain of salt):
>> There just isn't any compelling selling point to migrate to SHA-256 in
>> the near or foreseeable future for a given individual user of git.
>
> I wholly disagree.  SHA-1 is obsolete, and as soon as hosting providers
> support SHA-256, all new repositories should be SHA-256.  There is no
> other defensible reason to continue to use SHA-1 today.

I really don't think we disagree on the need to move away from SHA-1 to
SHA-256. I'm only attempting to summarize the practical threat, and how
users might rightly weight that against other concerns.

NIST deprecated SHA-1 in 2011. I think it's safe given Git's growth that
most people who've used Git started using it after that date, so clearly
there's a large disconnect between official hash algorithm
recommendations and how that translates to practical concerns.

>> The reason we started the SHA-1 -> $newhash (it wasn't known that it
>> would be SHA-256 at the time) was in response to https://shattered.io;
>> Although it had been discussed before, e.g. the thread starting at [1]
>> in 2012.
>>=20
>> We've since migrated our default hash function from SHA-1 to SHA-1DC
>> (except on vanilla OSX, see [2]). It's a variant SHA-1 that detects the
>> SHAttered attack implemented by the same researchers. I'm not aware of a
>> current viable SHA-1 collision against the variant of SHA-1 that we
>> actually use these days.
>
> That's true, but that still doesn't let you store the data.  There is
> some data that you can't store in a SHA-1 repository, [...]

I don't think that's come up before, that's correct, but has anyone
wanted to do that? I.e. people aren't generating these collisions
accidentally, they're crafted.

If we did want to store those we could change the hardcoded
-DSHA1DC_INIT_SAFE_HASH_DEFAULT=3D0 to "1", now it's set up to just die if
it finds a collision, but it could be made to return the "safe hash".

Of course doing so would mean going all-in on SHA1DC, i.e. such a
repository couldn't interop with our optional OpenSSL and other vanilla
SHA-1 backends.

> [...]and SHA-1DC is extremely slow.  Using SHA-256 can make things
> like indexing packs substantially faster.

Yeah, there's a lot of advantages. We could also safely use hardware
acceleration.

Really, I'm not meaning to poo-poo SHA-256 here, just to provide some
summary of the current state a user might expect.

I do think even this is mostly a fringe benefit in practice. I feel that
pain when I e.g. clone chromium.git, but once I pay that one-off cost
it's mostly not a bottleneck you notice on incremental push/fetch. You
pay for it on "repack", but that's in the background for most users.

It sure would make hosting providers happy though...

We have discussed having our cake here & eating it too in the
past. I.e. we could safely use say OpenSSL SHA-1 for "repack" on, as
long as we kept state and only did so for objects reachable from tips
that we'd already validated with SHA-1DC.

I think it's a datapoint that even those of us who've noticed the hash
slowdown have found it painful, but not *that* painful that we've
invested the effort in even relatively low-hanging-fruit workarounds for
the problem.

...

Finally, I'd really like to thank you for all your work on SHA-256 so
far, and really hope that none of what I've said here is discouraging in
any way. This thread has received some attention outside this ML (on
LWN), so I wanted to clarify some of the points above. Thanks!
