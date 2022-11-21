Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04881C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 12:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKUMUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 07:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiKUMUB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 07:20:01 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC30920A1
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:20:00 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b8so5183953edf.11
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eBFZNZ+Cp0QkFSyKokfy5417mh8GJi0GVyijAWkqH+Q=;
        b=orbVil2RiyHaHXGlKDVu4BhogploneY93iOSmLzDvkOvG0NxvAm2xdDfDeT8B9FVs0
         CxJDH4gIkUCWCcGiWCaEWfx/xYyWGfHsyN8CwzB/tKmVf8XHIOUMvrNfBZWHEI3uII1m
         kUFQgmaEJeLxsYHudJ0PNs0KObMAt4x27b4VhcK8E+FcQGAwuGHwrvmRg0zGyIc19/b1
         fIeze/p+SGMfU+ph216zdWPMYcgJP9yAMqYsWZI+MS2LsyB/+s4yVpUfb9ZIJmhMpuqD
         rY7gVu5AZbdN/IISbrrIap5qtPFv8hnBdrfpdsOghVxzNomKfNsqfdBxaPHntsy/T8V0
         n1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBFZNZ+Cp0QkFSyKokfy5417mh8GJi0GVyijAWkqH+Q=;
        b=NU8VyaKVBEHEI6mWKF8GyHQvvyws9gBzeYAYa7PT09MnOVghLxYFtItXeNO2CF8YLt
         PfO9o5L6becg2NFaHAb8ZZNFu0oyVst0imCc0GhHBVlMNFfAurBDmJs6+uCZmWsGcDTe
         DLOHPljKNynYvoE30HQkaLbrQTf799lEeXwQNEC6hdDNHOp6bNaCw50WUL84eQjP22GU
         rgEtD0aU49kZENsduYxjmSmJrkAm0QXl1xugeOzvE5X1ppa23IU5Rns2OaVDaH8GI92J
         Px/L4wXyvfW02gH9dHlZomQwBbEONgJTzKr+Bx0USQrWtuV0Jnqn+i+kBwVj57qpT/Tp
         ge1g==
X-Gm-Message-State: ANoB5pkHm2KVsclr8Y9Xb3mSoEyccSQZqllcpkKJJqbFUbfZX5P8ydd8
        LYLAXVwTKlm3Vfmce+X3rSCWTQFjsmk=
X-Google-Smtp-Source: AA0mqf6E6zB2dYPNk8Cay7x4PPKN7D5JyPWhpGDIkVgLOsLO+g+gHafREnCHlpkXLeKLDuEsFtfSfg==
X-Received: by 2002:aa7:dd04:0:b0:457:d794:f5ee with SMTP id i4-20020aa7dd04000000b00457d794f5eemr4289200edv.227.1669033198916;
        Mon, 21 Nov 2022 04:19:58 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id s6-20020aa7cb06000000b0046353d6f454sm5087389edt.95.2022.11.21.04.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 04:19:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ox5mH-0006G3-2X;
        Mon, 21 Nov 2022 13:19:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 0/6] ls-tree: introduce '--pattern' option
Date:   Mon, 21 Nov 2022 13:12:08 +0100
References: <Y3ave2+kEwLTvtE6@nand.local>
 <20221121114150.3473-1-tenglong.tl@alibaba-inc.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221121114150.3473-1-tenglong.tl@alibaba-inc.com>
Message-ID: <221121.8635accxea.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 21 2022, Teng Long wrote:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> I think this falls into the same trap as the series on 'git show-ref
>> --count' that I worked on earlier this year [1].
>>
>> At the time, it seemed useful to me (since I was working in an
>> environment where counting the number of lines from 'show-ref' was more
>> cumbersome than teaching 'show-ref' how to perform the same task
>> itself).
>>
>> And I stand by that value judgement, but sharing the patches with the
>> Git mailing list under the intent to merge it in was wrong. Those
>> patches were too niche to be more generally useful, and would only serve
>> to clutter up the UI of show-ref for everybody else.
>>
>> So I was glad to drop that topic. Now, I'd be curious to hear from Teng
>> whether or not there *is* something that we're missing, since if so, I
>> definitely want to know what it is.
>>
>> But absent of that, I tend to agree with =C3=86var that I'm not compelle=
d by
>> replacing 'ls-tree | grep <pattern>' with 'ls-tree --pattern=3D<pattern>=
',
>> especially if the latter is slower than the former.
>>
>> Thanks,
>> Taylor
>>
>> [1]: https://lore.kernel.org/git/cover.1654552560.git.me@ttaylorr.com/
>
> honestly, I just think it's useful to me, but omit the performance recess=
ion of
> the option. I originally thought about it looks like the "git tag -l <pat=
tern>"
> or "git branch -l <pattern>" usage, but it seems not as a regex matching =
on
> them and it indeed executes faster than the pipe grep, because it seems l=
ike the
> former has the more restrictive matching conditions (because if I move the
> last aster=EF=BC=8C there is no output):
>
>
> =E2=9C=97 git branch -r --list "avar*" | wc -l
>     1498
>
> =E2=9C=97 hyperfine 'git branch -r --list "avar*"'
> Benchmark 1: git branch -r --list "avar*"
>   Time (mean =C2=B1 =CF=83):      69.8 ms =C2=B1   3.1 ms    [User: 25.8 =
ms, System: 42.7 ms]
>   Range (min =E2=80=A6 max):    66.6 ms =E2=80=A6  81.8 ms    35 runs
>
> =E2=9C=97 hyperfine 'git branch -r --list | grep "avar"'
> Benchmark 1: git branch -r --list | grep "avar"
>   Time (mean =C2=B1 =CF=83):      76.4 ms =C2=B1   3.7 ms    [User: 32.7 =
ms, System: 45.2 ms]
>   Range (min =E2=80=A6 max):    72.9 ms =E2=80=A6  85.5 ms    34 runs
>
> =E2=9E=9C  Documentation git:(tl/extra_bitmap_relative_path) =E2=9C=97 gi=
t branch -r --list "avar" | wc -l
>        0

Yeah, that's the built-in wildmatch() (as in wildmatch.c
in-tree)-powered matching we do, and support in pretty much anything
that takes a <path>.

I *thought* this feature was something like that that when I first
glanced at it, i.e. to regex match ls-tree entries, but e.g. a
--pattern=3Dabc would still match that in the OID, as it's just grepping
the line.

Which I think is one way to draw the "does this belong in git?"
line. I.e. a "grep" or your "--pattern" doesn't need to know anything
about sub-components of the line to be equivalent, whereas something
that just matches the path does.

Also, when you get into e.g. negative pathspecs and the like it becomes
even more compelling.

I do have some WIP patches somewhere to have our pathspecs support PCRE
regexes.

So I think it would be neat, or at least worth exploring. But just
having ls-tree or some random command support it isn't the righ way to
go about it IMO, it should be done via the pathspec API, if done at all.
