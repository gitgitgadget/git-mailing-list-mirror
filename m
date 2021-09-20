Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528ABC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3839B611ED
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348182AbhIUCXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbhIUBwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:52:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE86C0363F1
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:24:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c22so67185073edn.12
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8iYGFIkoB5Pygzwqo24Qu7XNy8ww7Gy0GAxE7NIZaSY=;
        b=QQkAlzqbClR0ZGnaEnIY1q+IdQTwZPpuB0uW8Nu+mZcbnub3WCxoY2BUJNV+dMkwGO
         bc0PMj9TeDTYxDGrxwJqe92C4xdYAAJdCaFs8u5gj9UfAmphALHaygRbdJ7cQeH3JrTK
         N+HNbjGbTPAKvbODJ2j3vovDpSnaIwp9eoDRpgtKpLzYb4stLl8top8YqhDxwzJaLQBp
         lExIjraPWHEd5iuWBHOMonP9o2Xdc1qJRr603MDQBKr1hHqNx+cUkiwn9GvgyhvcEKdy
         ofuHa/jm4luJ/BeZgnr7WhX/S19tIxR5RJ4di1lSAhCywNg2cuUo2Vsp4/k0EPQcaXoG
         cS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8iYGFIkoB5Pygzwqo24Qu7XNy8ww7Gy0GAxE7NIZaSY=;
        b=inwoyHNeNkp3FrDW6730bKPEie697gMPrTo0kED63ZjcBfQ0HkR8+a5POrDZQFOLe7
         B+ookVtuqDb+qGy+Zz/+5rrSXG6TI4KeLLnyWimsNHer7Tk8/hJN2PNSLYxs1aVsZ5f9
         8DFtJO7Xh8+bakRJ4Xbu+yKkGH9wHXeODfmq0UKZ737XVPy06lXN2A+l74fIeNWlbXrI
         YYX4lfoAJzUMDDpXL9pJwaSvm6UdItx9bT55Q2MjroHcxfF/zHA0Nddlizp/zdB7vMaX
         4LxnE33sP4p5OFMbu9NI8ZSXBju82kY3/ufEPTODEHvR6f/MDoDBhX6S0OGynBlTJEZ2
         iSzQ==
X-Gm-Message-State: AOAM531sY0yn8/Z4ktJbleR/TZCMFTd+OmX63e+us+FEwdsYlrPP3JpV
        x1Zq9Lq+soRyzGgi75TdjbP7v/g5rkpjxg==
X-Google-Smtp-Source: ABdhPJwyilOTrT9OuTfHzzmf5boOjraozw6M762AHz0t4uZA0DHA85+YUD/agzKcGczrprKQrAOYXw==
X-Received: by 2002:a05:6402:484:: with SMTP id k4mr31496168edv.303.1632180275284;
        Mon, 20 Sep 2021 16:24:35 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s26sm7643549edt.41.2021.09.20.16.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:24:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/5] wrapper.c: add x{un,}setenv(), and use xsetenv()
 in environment.c
Date:   Tue, 21 Sep 2021 01:17:35 +0200
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
 <patch-v3-1.5-4b320edc933-20210919T084703Z-avarab@gmail.com>
 <YUkC7RIDR7pQWsPh@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUkC7RIDR7pQWsPh@nand.local>
Message-ID: <87y27qakzx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Taylor Blau wrote:

> On Sun, Sep 19, 2021 at 10:47:15AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Add fatal wrappers for setenv() and unsetenv(). In d7ac12b25d3 (Add
>> set_git_dir() function, 2007-08-01) we started checking its return
>> value, and since 48988c4d0c3 (set_git_dir: die when setenv() fails,
>> 2018-03-30) we've had set_git_dir_1() die if we couldn't set it.
>>
>> Let's provide a wrapper for both, this will be useful in many other
>> places, a subsequent patch will make another use of xsetenv().
>
> Makes sense.
>
>> We could make these return "void" (as far as I can tell there's no
>> other x*() wrappers that needed to make that decision before),
>> i.e. our "return 0" is only to indicate that we didn't error, which we
>> would have died on. Let's return "int" instead to be consistent with
>> the C library function signatures, including for any future code that
>> expects a pointer to a setenv()-like function.
>
> This may be a little over-clever ;). It is cute, but returning an int
> makes xsetenv a drop-in replacement for setenv. Which is nice, but it
> makes it all too-easy to take code like:
>
>   if (setenv(...) < 0)
>     die(_("..."));
>
> and replace it with
>
>   if (xsetenv(...) < 0)
>
> which makes the whole conditional redundant, since the wrappers are
> guaranteed not to return an error.
>
> In other words, I like the idea that s/setenv/x&/ causes a compile-time
> error, and returning an int from these wrappers prevents that from
> happening.
>
> This may be a little too-theoretical, and you're certainly free to
> disagree, just my $0.02.

I'm fine with doing that in principle, I couldn't find any "x*()"
wrappers with different signatures. Yes, having the compiler complain
because you used a "void" return value would be nice.

I did have some vague notion that this might interact badly with
something in compat, i.e. if setenv() or unsetenv() was a fallback, but
I can't think now of why that wouldn't work...

>> I think it would be OK skip the NULL check of the "name" here for the
>> calls to die_errno(). Almost all of our setenv() callers are taking a
>> constant string hardcoded in the source as the first argument, and for
>> the rest we can probably assume they've done the NULL check
>> themselves. Even if they didn't, modern C libraries are forgiving
>> about it (e.g. glibc formatting it as "(null)"), on those that aren't,
>> well, we were about to die anyway. But let's include the check anyway
>> for good measure.
>
> This I think is a good call. I agree in practice that most times we'd be
> just fine to pass null to printf() (as we have seen from 88617d11f9
> (multi-pack-index: fix potential segfault without sub-command,
> 2021-07-19) ;)). But there's no reason to rely on risky assumptions when
> it's easy to avoid doing so.

*nod*

>> diff --git a/wrapper.c b/wrapper.c
>> index 7c6586af321..95f989260cd 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -145,6 +145,21 @@ void *xcalloc(size_t nmemb, size_t size)
>>  	return ret;
>>  }
>>
>> +int xsetenv(const char *name, const char *value, int overwrite)
>> +{
>> +	if (setenv(name, value, overwrite))
>> +		die_errno("setenv(%s, '%s', %d) failed", name ? name : "(null)",
>> +			  value, overwrite);
>> +	return 0;
>> +}
>> +
>> +int xunsetenv(const char *name)
>> +{
>> +	if (!unsetenv(name))
>> +		die_errno("unsetenv(%s) failed", name ? name : "(null)");
>> +	return 0;
>> +}
>> +
>
> For what it's worth, I find these new messages a little wordy. Maybe
> we should just sticky "could not (un)set %s"?

Sure, will change it.

I think I may have wanted to include the "overwrite" in the setenv() in
some way though, so you'd know if it failed because the libc call
"really" failed, v.s. we just had an existing value in the environment
and didn't set "overwrite".

But reading the docs again that won't work, since it'll succeed if it
can't write that key, i.e. the caller with overwrite=3D0 needs to
follow-up with a getenv() to see if their value or someone else's was
set (or more probably, they don't care, which is why they used
overwrite=3D0).

So it doesn't matter either way for xsetenv(), will make it less chatty.
