Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3391F462
	for <e@80x24.org>; Wed, 19 Jun 2019 22:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfFSWtg (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 18:49:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39370 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSWtg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 18:49:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so1607482edv.6
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 15:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=orYk4qSTigHqVTUtrk+SwibMNF0KjAXefQzuGnIoKas=;
        b=VgZuD4cquyHWZ5Zhad4WYZQ5rE30N08a7M34uYSY1TBrBmUx4TChOqDD+c763VX22u
         KnssuGasksk9EQAemv3GD12pqA9b7m3ikJef+t+/KG6FNO2F6s/wMzGjU31e2GvqSf8o
         d4oeBg3/dqBdkuuOg4Fj5YvcdoWJuilNaoVlstO0HfkbYe7kG+L4B4NrjEmAcCONMBHu
         M4d4Ef/eOREoc7kG71ezVIpLKewNbK7jd962CwnYitph5p0P+lfqJYNvAlMJxbTgjHba
         h/M2tTBRhq8ZO4DBmhzV4+mtfS6JtfcZ3iRDBRaky0bAIwzxUnADfQOQ4+hhNLKhwbh3
         g8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=orYk4qSTigHqVTUtrk+SwibMNF0KjAXefQzuGnIoKas=;
        b=aH+SQwAK0PBtJ69xBeUiHFDcrauZEN93cMLaWubQvvhwzbkzpn4aufS0X/HX/occvT
         0aJpxdImsGAM9fnjvFvY0jmpkwRCNjmdYYYpeI8U7SGdGe2jsMS7OuIWX0ol3zlnAa1S
         yW0LeC0+5wPAnPIUjBcLXkZfBn0cgB/VUbUKjJz6iKd/cCWzdFDwmRJIyzV6fzARjbF0
         6h5VpQRwEI3q54lwYo8XAP8WZt0k+2TrPXECq94Yl+RD+PCEEVQW1CJfPEzsgd0JvHGK
         FPOcecKhLYZWmCseV4W4OIwlHiZtpQwsyhsWl8wp0Svkbww12uxVe2RnyFr+0wu58xlK
         1Hqw==
X-Gm-Message-State: APjAAAUI1MJTUvFeXy2juBw9aHJoJrhSI31qnnMqSU8PgcbiqnWEOdGH
        /4zdjsrkxqHtTfuEdR0lV30=
X-Google-Smtp-Source: APXvYqznBQ1zrkCBaXVeuWcDFu5I8UiXvDxqltjYyvKhl/xJGfaHwjJMplanPyl+rCxVOg+94TFT3w==
X-Received: by 2002:a50:a5b7:: with SMTP id a52mr91312563edc.237.1560984573761;
        Wed, 19 Jun 2019 15:49:33 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id l50sm6333452edb.77.2019.06.19.15.49.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 15:49:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] gc: run more pre-detach operations under lock
References: <20190619094630.32557-1-pclouds@gmail.com> <20190619102601.24913-1-avarab@gmail.com> <CACsJy8AqA3TmNP62ko4c5Et39jsADYf9nKQByz28y-YQjNyKag@mail.gmail.com> <87k1dh8ne4.fsf@evledraar.gmail.com> <20190619191037.GE28145@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190619191037.GE28145@sigill.intra.peff.net>
Date:   Thu, 20 Jun 2019 00:49:32 +0200
Message-ID: <87imt18a2r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 19 2019, Jeff King wrote:

> On Wed, Jun 19, 2019 at 08:01:55PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > You could sort of avoid the problem here too with
>> >
>> > parallel 'git fetch --no-auto-gc {}' ::: $(git remote)
>> > git gc --auto
>> >
>> > It's definitely simpler, but of course we have to manually add
>> > --no-auto-gc in everywhere we need, so not quite as elegant.
>> >
>> > Actually you could already do that with 'git -c gc.auto=3Dfalse fetch'=
, I guess.
>>
>> The point of the 'parallel' example is to show disconnected git
>> commands, think trying to run 'git' in a terminal while your editor
>> asynchronously runs a polling 'fetch', or a server with multiple
>> concurrent clients running 'gc --auto'.
>>
>> That's the question my RFC patch raises. As far as I can tell the
>> approach in your patch is only needed because our locking for gc is
>> buggy, rather than introduce the caveat that an fetch(N) operation won't
>> do "gc" until it's finished (we may have hundreds, thousands of remotes,
>> I use that for some more obscure use-cases) shouldn't we just fix the
>> locking?
>
> I think there may be room for both approaches. Yours fixes the repeated
> message in the more general case, but Duy's suggestion is the most
> efficient thing.
>
> I agree that the "thousands of remotes" case means we might want to gc
> in the interim. But we probably ought to do that deterministically
> rather than hoping that the pattern of lock contention makes sense.

We do it deterministically, when gc.auto thresholds et al are exceeded
we kick one off without waiting for other stuff, if we can get the lock.

I don't think this desire to just wait a bit until all the fetches are
complete makes sense as a special-case.

If, as you noted in <20190619190845.GD28145@sigill.intra.peff.net>, the
desire is to reduce GC CPU use then you're better off just tweaking the
limits upwards. Then you get that with everything, like when you run
"commit" in a for-loop, not just this one special case of "fetch".

We have existing potentially long-running operations like "fetch",
"rebase" and "git svn fetch" that run "gc --auto" for their incremental
steps, and that's a feature.

It keeps "gc --auto" dumb enough to avoid a pathological case where
we'll have a ballooning objects dir because we figure we can run
something "at the end", when "the end" could be hours away, and we're
adding a new pack or hundreds of loose objects every second.

So I don't think Duy's patch is a good way to go.

The rationale in its commit message for including it can be better
addressed by something like my WIP for just fixing the locking
mechanism, since it fixes the stated problems of multiple "auto packing
in the background" messages and the "we may waste some resources" (we
take the lock earlier before doing 'real' work) without introducing its
own pathological case of deferring "gc --auto" too much as we have
unchecked object growth.

I think that's really important. It's OK if "gc --auto" isn't optimal,
but we should really avoid such pathological cases.

It's also important that it's easy to explain, i.e. if this patch goes
in I think it should update the second paragraph of the git-gc.txt
docs. I.e. now it's not just:

    When common porcelain operations that create objects are run, they
    will check whether the repository has grown substantially since the
    last maintenance[...]

But also something like:

    Except in cases where we're running porcelain commads that
    themselves might re-run aggregates of themselves, in which case we
    defer "gc" until the end. This currently only applies to "fetch",
    but other commands such as "rebase" etc. might learn to do this in
    the future. Note that if the sub-commands are numerous enough this
    might itself become pathological as "gc --auto" is deferred too
    much, so use option/config XYZ to ...

Or whatever...
