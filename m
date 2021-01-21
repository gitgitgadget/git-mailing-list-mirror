Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7022C433E9
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 10:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E814235FF
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 10:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbhAUK1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 05:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbhAUK05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 05:26:57 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428F5C061575
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 02:26:16 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c2so1549685edr.11
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 02:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Sr4Du9jKiS0HAnfKRrwp7Ve2sKcEeguwYeV945xxzKc=;
        b=EDfW3Q0BGI/dn9lIrASEw20tptLDggoni52wZCyYa+mARhIdlDJ875fYFwKFzmeSO6
         BpLZKXoqQ/zYIvA7sEmKK/d3CxNjIMh77yJB1NQX1eJ6RlY9QJwueAEBsO0yHqAUrX+O
         Il86t9S0A4q/C+xhJagEjdBXzam+DVUGQJWJtGOQuncScM7GZHaCgr5SZJAwTOim4dS1
         NjWiHlCVbiTB8wi1tKhEbzo+FPzkaaoiSHyEJqLNlzCAO61tGVg7Kh/kh7WXUcrSggsu
         dmAB+o/VCsqIheohKjR4XWu2uzKW9jFZq3lnLV7z0HjD0V8Dedpwj2zwcvqFkk+XmzYY
         6VQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Sr4Du9jKiS0HAnfKRrwp7Ve2sKcEeguwYeV945xxzKc=;
        b=kC+p462kAcA1FsVYQb9pwfh8XotUlkVWSym3hxYF567FZEgX1zyEj0M83mcYHtk7x3
         xhj7b0lIpBfbNYzBLQF6MhLCPosw/L1yv3QoYvrWfvznQ7G19LjvzC4m7ztIMYK32CRa
         vyTrIG5nCS2lSZ/NUzVMoDG5KORwoIsdTe7NUdEaIKohtA5AaPVmhFSB0jTzTihqz8ZV
         iwaxgrjr99qbBrRiR72iklwVhsHo68/bAsuIZo6k6DEoKkFJO5nxo2ssO6dzPL0wO6sS
         fPkFE2bogbMRFJtsWFfFCjF3NYojsPPOC8Z7b143R9+x/MeK+i2+v4sdAhaxwfARF1g8
         M9Sg==
X-Gm-Message-State: AOAM532L98GkLPJCvret6S1sFBxT7NrmhpAW0pGiVobL7ic2sMCey6xD
        e+pID+VyEycYxlrPOHsgFQk=
X-Google-Smtp-Source: ABdhPJyt64rdwRV7r2vK5YAkGlHpxAtHbFSabjN9oFcqxUNCZZf9wOa4hV39o8jV8HaQcnqDfspq8g==
X-Received: by 2002:a05:6402:35ca:: with SMTP id z10mr10782651edc.174.1611224774888;
        Thu, 21 Jan 2021 02:26:14 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id bk2sm2051312ejb.98.2021.01.21.02.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 02:26:13 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] builtin/pack-objects.c: avoid iterating all refs
References: <20210119143348.27535-1-jacob@gitlab.com>
 <20210119143348.27535-2-jacob@gitlab.com>
 <87lfco801g.fsf@evledraar.gmail.com>
 <YAiKQ0M0/14Q13Ee@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <YAiKQ0M0/14Q13Ee@coredump.intra.peff.net>
Date:   Thu, 21 Jan 2021 11:26:13 +0100
Message-ID: <874kja8u2i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 20 2021, Jeff King wrote:

> On Wed, Jan 20, 2021 at 09:50:19AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> To elaborate on other things that aren't really your problem & Taylor's
>> E-Mail downthread we originally added this because:
>>=20
>>     If new annotated tags have been introduced then we can also include
>>     them in the packfile, saving the client from needing to request them
>>     through a second connection.
>>=20
>> I've barked up this whole tag fetch tree before 97716d217c (fetch: add a
>> --prune-tags option and fetch.pruneTags config, 2018-02-09) but really
>> not this specific area.
>>=20
>> I wonder if longer term simply moving this to be work the client does
>> wouldn't make more sense. I.e. if we just delete this for_each_ref()
>> loop.
>>=20=20=20=20=20
>> We're just saving a client from saying they "want" a tag. I.e. with the
>> whole thing removed we need this to make t5503-tagfollow.sh pass (see
>> [1] at the end for the dialog, the tag is 3253df4d...):
>
> Isn't this an ordering problem, though? The client cannot mention
> auto-followed tags in a "want", because they first need to "want" the
> main history, receive the pack, and then realize they want the others.
>
> So we are not just saving the client from sending a "want", but making a
> second full connection to do so. That seems to be an optimization worth
> continuing to have.

Correct. Suppose a history COMMIT(TAG) history like:

    mainline: A(X) -> B(Y) -> C
    topic:    A(X) -> B(Y) -> D(Z)

You only want the "mainline" history and its tags in your fetch. Now a
server will give you tags X & Y for free, ignoring Z.

The note in protocol-capabilities.txt supposes that you'll need to only
get A/B/C in one fetch, then do another one where you see from the OIDs
you have and advertised (peeled) OIDs for the tags and know you just
need X/Y, not Z.

So we could also just fetch Z, then do our own walk on the client to see
if it's reachable, and throw it away if not. Although I suppose that'll
need a list of "bad" tags on the client so we don't repeat the process
the next time around, hrm...

>>     diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
>>     index 6041a4dd32..1ddc430aef 100755
>>     --- a/t/t5503-tagfollow.sh
>>     +++ b/t/t5503-tagfollow.sh
>>     @@ -134,6 +134,7 @@ test_expect_success 'fetch B, S (commit and tag =
: 1 connection)' '
>>      test_expect_success 'setup expect' '
>>      cat - <<EOF >expect
>>      want $B
>>     +want $T
>>      want $S
>>      EOF
>>      '
>>     @@ -146,6 +147,7 @@ test_expect_success 'new clone fetch master and =
tags' '
>>                     cd clone2 &&
>>                     git init &&
>>                     git remote add origin .. &&
>>     +               git config --add remote.origin.fetch "+refs/tags/*:r=
efs/tags/*" &&
>>                     GIT_TRACE_PACKET=3D$UPATH git fetch &&
>>                     test $B =3D $(git rev-parse --verify origin/master) =
&&
>>                     test $S =3D $(git rev-parse --verify tag2) &&
>>=20
>> We're also saving the client the work of having to go through
>> refs/tags/* and figure out whether there are tags there that aren't on
>> our main history.
>
> You seem to be against auto-following at all. And certainly I can see an
> argument that it is not worth the trouble it causes. But it is the
> default behavior, and I suspect many people are relying on it. Fetching
> every tag indiscriminately is going to grab a bunch of extra unwanted
> objects in some repos. An obvious case is any time "clone
> --single-branch --depth" is used.

I wonder if the use-cases for --depth in the wild aren't 99.9%
--depth=3D1, in which case the peeled commit on the main branch being
advertised by a tag would alredy give you this information.

I.e. in the common case you don't get a tag, but if you happen to land
on a release you can see that the commit at the tip is tagged. I wonder
if doing that shortcut already in the client (so not send include-tag)
is a useful micro-optimization.

> Maybe I'm not quite understanding what you're proposing.

Not much really, just that looking deeper into this area might be a
useful exercise. I.e. it's a case of server<->client cooperation where
we offlod the work to one or the other based on an old design decision,
maybe that trade-off is not optimal in most cases anymore.
