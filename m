Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FA891F461
	for <e@80x24.org>; Thu, 20 Jun 2019 21:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfFTVtI (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 17:49:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36788 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFTVtI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 17:49:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so4577989wmm.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 14:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FSudAaWGzX9YTW+5Eq2YMyKJJqTKeYoTZuWWQFbvpC0=;
        b=ErVyoIBECTvPszf/FYcBghEp2752P9d3I1tOd8spaRyw4C1IZrZTxlv7bdN4txP8Pd
         2zYM2agVn3lbhEVkjHLMQGffpKoF5FAOF8jzgV0cS5ayeebxVEVKQcMNxmYBhA30cRgC
         IIpNVyAGT6JlsiUHxHHBZM1P/boc2YTFX1eDOuztcnB4vBX8Aqpaw5JzAsv+a2dDbDdh
         VxiNjt28+yCW8L+mcr3Eqoy0icZrJe1ZXHmedwozC5Yi2yLrRQ6Nm/GNTGSYBJ94pXsI
         4CUzshuE+J/5Qj8OaKL6LaVOc0jnNgqDXD4/TpIpudHw2vsRT8qM8HCMqRcDedSKrX01
         0sYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=FSudAaWGzX9YTW+5Eq2YMyKJJqTKeYoTZuWWQFbvpC0=;
        b=iqlWpmK+9SyFkAq6LwmCOc2C6+i6NP/w7JF2A7yAfbGwkQcyVc7GBcPyhoeIxUYzaA
         jabjuJ8dDrdLqrdMrcFjmEidhHYEAqiuNlRKYjvDYVSawyt6oEVtMZNi5ZrtVuCjZs6h
         C6qLdqWoznClLeJH0krg8zKZtg4exIAL48rMIzyAhkD031dIAsbYSCo9bC8MEzvRMiK7
         smjzjifoIsf4p72Q9WBaXrXRINZ2W5J0p3Jof1cUA6ao/m6quCgAOLmZh8F1UxyoGQZq
         uWSfYQ4Utx8GZMSpyRqXbUa0sEKqp3XNT+P/a1YPWL5BYou/JukMnHnxMfKsBFxAevbn
         e5Jw==
X-Gm-Message-State: APjAAAXdLqe1wNx8Rr2fpR3B6Q/KqX5ZeMsbCtt4UtbV3r3Kawjkfa5r
        HOhJsped7+H3kmeeie0/s4E=
X-Google-Smtp-Source: APXvYqwm0xiBuh8bENNV56xnWfp4e1oiSDtTUzHYaqBD6YJ0NlXb9c2T1LWxuXn0xwNmwin1A7487A==
X-Received: by 2002:a1c:9ac9:: with SMTP id c192mr1116827wme.0.1561067344455;
        Thu, 20 Jun 2019 14:49:04 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id v27sm1568162wrv.45.2019.06.20.14.49.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 14:49:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] gc: run more pre-detach operations under lock
References: <20190619094630.32557-1-pclouds@gmail.com>
        <20190619102601.24913-1-avarab@gmail.com>
        <CACsJy8AqA3TmNP62ko4c5Et39jsADYf9nKQByz28y-YQjNyKag@mail.gmail.com>
        <87k1dh8ne4.fsf@evledraar.gmail.com>
        <20190619191037.GE28145@sigill.intra.peff.net>
        <87imt18a2r.fsf@evledraar.gmail.com>
        <CACsJy8AjXXOpcKrSV4z6kEM=eyFDWSyf==tJZzvDyEN591XdGw@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8AjXXOpcKrSV4z6kEM=eyFDWSyf==tJZzvDyEN591XdGw@mail.gmail.com>
Date:   Thu, 20 Jun 2019 23:49:02 +0200
Message-ID: <87ef3o7ws1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 20 2019, Duy Nguyen wrote:

> On Thu, Jun 20, 2019 at 5:49 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Wed, Jun 19 2019, Jeff King wrote:
>>
>> > On Wed, Jun 19, 2019 at 08:01:55PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >
>> >> > You could sort of avoid the problem here too with
>> >> >
>> >> > parallel 'git fetch --no-auto-gc {}' ::: $(git remote)
>> >> > git gc --auto
>> >> >
>> >> > It's definitely simpler, but of course we have to manually add
>> >> > --no-auto-gc in everywhere we need, so not quite as elegant.
>> >> >
>> >> > Actually you could already do that with 'git -c gc.auto=3Dfalse fet=
ch', I guess.
>> >>
>> >> The point of the 'parallel' example is to show disconnected git
>> >> commands, think trying to run 'git' in a terminal while your editor
>> >> asynchronously runs a polling 'fetch', or a server with multiple
>> >> concurrent clients running 'gc --auto'.
>> >>
>> >> That's the question my RFC patch raises. As far as I can tell the
>> >> approach in your patch is only needed because our locking for gc is
>> >> buggy, rather than introduce the caveat that an fetch(N) operation wo=
n't
>> >> do "gc" until it's finished (we may have hundreds, thousands of remot=
es,
>> >> I use that for some more obscure use-cases) shouldn't we just fix the
>> >> locking?
>> >
>> > I think there may be room for both approaches. Yours fixes the repeated
>> > message in the more general case, but Duy's suggestion is the most
>> > efficient thing.
>> >
>> > I agree that the "thousands of remotes" case means we might want to gc
>> > in the interim. But we probably ought to do that deterministically
>> > rather than hoping that the pattern of lock contention makes sense.
>>
>> We do it deterministically, when gc.auto thresholds et al are exceeded
>> we kick one off without waiting for other stuff, if we can get the lock.
>>
>> I don't think this desire to just wait a bit until all the fetches are
>> complete makes sense as a special-case.
>>
>> If, as you noted in <20190619190845.GD28145@sigill.intra.peff.net>, the
>> desire is to reduce GC CPU use then you're better off just tweaking the
>> limits upwards. Then you get that with everything, like when you run
>> "commit" in a for-loop, not just this one special case of "fetch".
>>
>> We have existing potentially long-running operations like "fetch",
>> "rebase" and "git svn fetch" that run "gc --auto" for their incremental
>> steps, and that's a feature.
>
> gc --auto is added at arbitrary points to help garbage collection. I
> don't think it's ever intended to "do gc at this and that exact
> moment", just "hey this command has taken a lot of time already (i.e.
> no instant response needed) and it may have added a bit more garbage,
> let's just check real quick".

I don't mean we can't ever change the algorithm, but that we've
documented:

    When common porcelain operations that create objects are run, they
    will check whether the repository has grown substantially since the
    last maintenance[...]

The "fetch" command is a common porcelain operation, when it fetches
from N remotes it just runs an invocation of itself, so thus far it's
both worked & been intuitive that if we needed (potentially multiple)
gc's while doing that we'd just go ahead and run it then, even if
something concurrent was happening.

No that's not optimal in many cases, but at least doesn't create caveats
we don't have now where we have runaway object growth.

>> It keeps "gc --auto" dumb enough to avoid a pathological case where
>> we'll have a ballooning objects dir because we figure we can run
>> something "at the end", when "the end" could be hours away, and we're
>> adding a new pack or hundreds of loose objects every second.
>
> Are we optimizing for a rare (large scale) case? Such setup requires
> tuning regardless to me.

At least for me it doesn't require custom tuning before this patch of
yours.

I.e. now "gc --auto" is dumb enough that you can run it on everything
from stuff that just does "commit" from cron, user's laptops, massive
rebases that take forever, and e.g. "stats" like jobs where for
<reasons> I'll add thousands of repos and "fetch --all" them (so e.g. I
can run "log --author=3D<x> --all").

Yeah of course I'm an advanced user and I can just grumble and manually
invoke fetch, actually I'll probably submit a follow-up patch to add a
gc.* config to disable this thing.

But I think even if the use-case is rather obscure it's important that
if at all possible we keep "gc" elastic enough to work for pretty much
all combinations of object-adding porcelain commands, and I think in
this case we're better off doing things differently...

>> So I don't think Duy's patch is a good way to go.
>
> This reminds me of being perfect is the enemy of the good. A normal
> user has a couple remotes at most, finishing fast (enough) and in such
> case it's a good idea to wait until everything is in before running
> gc.

Even a user with two remotes will run into issues with your patch where
"gc" will print things twice, or outright error due to concurrent access
by another process, which as has been discussed here on-list is *very*
common e.g. with editor integration.

So the extent of my complains about this is:

 1) The edge case with runaway object growth (obscure)

 2) It doesn't really fix the bug except for the narrow case of users
    who invoke things one-terminal-at-a-time and don't e.g. have an
    editor with "git" integration & a terminal (not obscure).

Maybe I should have led with #2 :)

Anyway, I'm not *just* complaining. I have patches too, but so far I'm
up to 8 patches on what's probably just the first one-third of
it. *Sigh*.

But the 2/3 of that if you want to dig through my crappy WIP code on
GitHub is instrumenting the test suite to demonstrate that with an
approach like what your patch does we still get these GC race
conditions, because our locking still sucks, which brings me to...

> Of course making git-gc more robust wrt. parallel access is great, but
> it's hard work. Dealing with locks is always tricky, especially when
> new locks can come up any time.

I've poked at it a bit now, and it's really not hard, I think it's just
that nobody looked at it hard enough before.

The issue is that currently we do:

    1. parent: do_we_need_gc();
    2. parent: say_way_will_gc();
    3. parent: lock();
    4. parent: do_a_bit_of_work();
    5. parent: unlock();
    6. parent: fork();
    7. child: lock();
    8. child: do_a_lot_of_work();
    9. child: unlock();

My RFC patch currently changes that to:

    1. parent: do_we_need_gc();
    2. parent: lock_or_silently_exit();
    3. parent: say_way_will_gc();
    4. parent: do_a_bit_of_work();
    5. parent: unlock();
    6. parent: fork();
    7. child: lock();
    8. child: do_a_lot_of_work();
    9. child: unlock();

I.e. we won't duplicate the message, but *do* introduce the caveat that
it's in principle possible nobody gc's, but in practice when we fail to
get the lock in lock_or_silently_exit() it's because we lost the race to
a sister process that's going to do the actual GC, so all is well.

But we are left with the brief race when we fork. My RFC patch proposed
some elaborate PID hand-over dance to deal with this. But having looked
at it again I think we can easily get rid of that race too with just:

    1. parent: do_we_need_gc();
    2. parent: lock_or_silently_exit();
    3. parent: say_way_will_gc();
    4. parent: do_a_bit_of_work();
    5. parent: fork();
    6. parent: <writes child pid to gc.lock>
    7. parent: <exits without unlocking gc.lock>
    8. child: do_a_lot_of_work();
    9. child: unlock();

Which can fail in cases where the child segfaults, or manages to exit
earlier than the parent etc, hence my earlier proposed elaborate pid
hand-over dance.

But looking at it again we only usurp an existing gc.lock if the mtime
is >12hrs, so it's OK if we have very rare cases where the PID info got
corrupted, we can still back ourselves out of it, which is what I was
paranoid about.

Furthermore the gc.lock contains the <hostname><pid> of the working
process, but we can in a backwards-compatible way add new entries to
that file, i.e. list both the child & parent pid. Older clients will
just read whichever one comes first, but if we make new versions check
both we can be more paranoid going forward.

> Having said that, I don't mind if my patch gets dropped. It was just a
> "hey that multiple gc output looks strange, hah the fix is quite
> simple" moment for me.
