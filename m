Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBC7C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 14:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EAD52312C
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 14:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbhALOBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 09:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbhALOBO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 09:01:14 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB64CC061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 06:00:33 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id t16so3602558ejf.13
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 06:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dOW6X2x4PK/bv3KiTRf2yPqQPcdMVAeBsnifWZRWDp4=;
        b=o8OrVKDbQhpGJDg9ihAzsyR/FXG9Je+W5Jj/DK7ZHGFwNusKSIKmE8m3/WfQTkR336
         py2mA2Bw741hTrjhr0DfW1PuMvL6V/nNMhn+nfGO7qifeXWizJRPork2EUr2lAGyNnx0
         KAw6+RopfwWCzEnU14WydvMlHSKjyw14A12ZLDKbMyz8Amz86NMcY3rVukcM4qyuyBHm
         1VG/Yec1U95pLV3kpUUoEdEgdKqcysPgdKdWrLS9tNtWmACKKr9oMOizpV95mz034ojv
         gTFzqTbB77MG2VJwTox0mIUe1seXc0jf5UnhWyd0GbM2NRfypNvBk8DD986de+8ngbKf
         iqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dOW6X2x4PK/bv3KiTRf2yPqQPcdMVAeBsnifWZRWDp4=;
        b=FIZuYd3ZChLNa1QGVu8oAcWJH2NfI8tLrDqNxwNTwN5kR6Ft1N0l16hpcJF2sgBi/h
         fQHwJFsXVeimC6foPX+KbYTU0WvZibBlVUTizOm6ErFGzWeTME0Gv+rmbhtlWpyec9k3
         ZF7ARa368ILtuBZK/NBDhVDZdyjVx6E3pbOykYYduS+rSCm3SMknMrkiipkrmhtShHrM
         UnnWeeGA8UMzCiK+E9HHa8JBp9pm1eoYpsNlRyMxtbk0HsFKv6AMoFZeQHzS5Ub4xoUU
         cmcUH2cyEDiEnc4hE6NTuYrPKnfcZHjSFw+Fgt2JR6sp3M3605T4GfaxxEZggR+rzEj+
         ET3A==
X-Gm-Message-State: AOAM532To1EgAiJ1nkjjAynmBHahAlzb+uAJX1AlBAjDqD+nB6NIsyPN
        0qoguS/hbaj3mYKas6lp5AjR/hU7TOpmwg==
X-Google-Smtp-Source: ABdhPJwoUKymZS8D5IkAsRZa37cvrn0W6UHVGeKR6AdFHpPfKM+XhuEWet2gGJU7isNYongwl7JhPg==
X-Received: by 2002:a17:906:90d6:: with SMTP id v22mr3379703ejw.88.1610460032418;
        Tue, 12 Jan 2021 06:00:32 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id h16sm287246edw.34.2021.01.12.06.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:00:31 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <871reu752k.fsf@evledraar.gmail.com>
 <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
 <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net>
 <xmqq4kjpelza.fsf@gitster.c.googlers.com>
 <X/uvhc5Hpu792qA/@camp.crustytoothpaste.net>
 <xmqqeeir8fdg.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <xmqqeeir8fdg.fsf@gitster.c.googlers.com>
Date:   Tue, 12 Jan 2021 15:00:30 +0100
Message-ID: <87k0si5k75.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 11 2021, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> On 2021-01-09 at 23:20:25, Junio C Hamano wrote:
>>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>>=20
>>> > On 2021-01-09 at 21:28:58, Junio C Hamano wrote:
>>> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>> >> > FWIW there was since a re-roll on 2021-01-03, but the discussion is
>>> >> > sort-of outstanding, so maybe that's intentional...
>>> >>=20
>>> >> I had an impression that those 4 or 5 patches haven't gained
>>> >> concensus that they are good as-is.
>>> >
>>> > There will be another reroll.  I'm hoping to get to it this weekend.
>>>=20
>>> Thanks.
>>
>> Having read =C3=86var's latest comment, I've decided instead to drop thi=
s, so
>> feel free to do so whenever it's convenient.
>
> That's kind of sad.

Agreed. I mean, I'm just one contributor with an opinion. I certainly
don't mean my "meh" on a patch to be some sort of veto.

If you follow this list you'll see that if you're going to take anyone's
opinion on whether a thing should make it into git as a matter of
empirical data on patches I submit that aren't changed meaningfully,
then, uh, maybe pick someone else :)

> I view that this is the kind of topic where perfect easily can
> become an enemy of good, as there is by definition no perfection
> available to us without breaking existing Git.
>
> I do not know about =C3=86var, but to me, my initial impression while
> reading the discussion from sideline was that the goal was to
> prevent a mechanical scan of a recent version of .mailmap from
> learning that Joe used to use Jane as his/her name, and that was the
> reason why I asked to be convinced why encoding for obfuscation was
> insufficient.  In the above, I meant "mechanical scan" as something
> like "a web search engine crawls and finds a .mailmap---a query for
> Joe produces a line with some garbage on it that is not Jane." and a
> casual attacker would stop there.
>
> But of course, a casual attacker who knows urlencode or whatever
> obfuscation in use can read that "garbage" once he/she knows that
> "garbage" is worth attacking (i.e. it is known to be associated to
> Joe, the person the attacker is interested in).
>
> If your goal is to make it harder than just urlencode, even though
> we all have to accept that scanning "git log --all" for all names
> that appear in the history and hashing them all to see what name
> hashes to the "garbage" in question, then @sha256:<hash> approach
> does make sense as a stopping point.  Perhaps we need to sell this
> with a clear definition of what kind of attackes we are protecting
> the name data from:
>
>     The attacker is required to obtain sufficient amount of history
>     in the project to uncover the obfuscation; a more casual
>     attackers will fail to uncover, and we declare that it is better
>     than nothing and it is good enough in practice.
>
> or something like that?  I am not sure if I drew the line at the
> level you intended to draw in the above, if I think that it is good
> enough in practice, or if I agree to a change that is better than
> nothing but not good enough in practice, but having such a statement
> would help to see where we agree or disagree.

My reading of the general thread & brian's reply at [1] is that the
difference in the minds of the users who want the feature (who're not
on-list, and we're getting brian's's summary of their views) is closer
to:

    We want the X-Y problem of "hide this data" solved with solution "Y"
    because git's current tooling to retrieve the data is currently
    rather tedious & obscure.

So when I asked whether those users would feel the same if the tooling
was less tedious and suggested that I might patch it to be so brian
replied with "[yes,] we do rely on this being inconvenient".

I do have a 20-something series patch to the mailmap code in my local
queue that in the light of this series's status I think I'll submit
soon.

It doesn't have anything to do with adding a "spew out a materialized
map" feature currently, nor do I really plan to do that any time soon. I
do genuinely think it would be a good addition to git for reasons that
have nothing to do with trying to make a point about this
series. E.g. you'd be able to more easily validate/check/fsck a mailmap
that way. Or e.g. use a git repository's .mailmap as a source to export
to your MTA rules or whatever.

The external tools I referred to which consume the exported .mailmap
data are something I worked on at a previous job, but I no longer have
that immediate itch to scratch personally.

The "march of history" point was rather that if the difference between
URI encoding and this solution is current tooling, it seems all but
inevitable that we'll bridge that gap sooner than later in a way that
makes that difference useless to some of the users that want this now.

And not even because some people don't like this feature in particular
and wish to submit patches to make it less useful. But just because we
continue implementing stuff that's been talked about for years & is
being generally slowly worked towards. E.g. more client<->server
cooperation for expensive queries over protocol v2, or a filter clone
mode where you get only commit objects.

It even seems like something brian's series itself could benefit
from. I.e. having the hashed values in the history is a performance hit
in some cases. The patch caches the computation.

Another way to do it would be to just save a
".git/objects/info/mailmap.{hash-of-original-file}". Either on the fly
or generated by "maintenance" or whatever. It would guarantee a 0%
performance hit. At that point we'd already have the plumbing to
materialize the file & would need to go out of our way to make it
inaccessible in porcelain.

1. https://lore.kernel.org/git/X%2FtxB8b3%2FqqbwbmC@camp.crustytoothpaste.n=
et/
