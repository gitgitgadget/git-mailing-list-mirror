Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E702C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 23:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhL0Xnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 18:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbhL0Xnu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 18:43:50 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A182BC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:43:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f5so67094189edq.6
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Zc5XmV9hk6XF6IWZO7De1wDhD8X3IvF39HGQ6LiCx+c=;
        b=oRmNTipYVOkbvDMhqnGMVLf7nx3a+UlJMd3xGkh0MhPo27gFKUJxeOdFEU9zF0JeYa
         Dgfi9wGvm1jPmLBSV6NiDIvM6Bh3VRK24JfskMn9hZoM0MYL3bvUzpleloEw5ZwQv33l
         a43d2hh/MeY1fhr2cKY5JvqlCz2YsZWgk4yzsW7GHhrxj9UtXdlt/2/5A47lCECMb0Fq
         BNcxuD1MWR6z3MaLRwoS3dtAPTfkiPBkbM02veOQ1BWZFGvCYnC5vw2NFYLTMKUb2pjc
         8EJShpTKqM4TwSa+k75IwZkfDFlR3dCSIuNxA5/q7gqxn7daZ+K2c6PDUkm2DEiefX84
         fspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Zc5XmV9hk6XF6IWZO7De1wDhD8X3IvF39HGQ6LiCx+c=;
        b=J2x3uIL+D2k9mMffqh8SM6R8jzsdN911n5pTEBu9bAmc8/bWdLdXs+poA8mlzkKRJa
         5SM0iafnEYOSEk2FCoE5egjxXyiUIOPwxPylqzVi1dNJAlVQfIqm/dDf+kW46EjUXjob
         ekhHuoqWQfsxGsjOneOLLxtyOYxdSRm/TYj7/Yyi9MuiMjSGrP6USdoYjTA90HjA0ic7
         eif+ktHdtGn9sirEUxf31aHdH4Ogn595HwsvMoBbveFyah2a8Uz6UnMX1dLIb5CW5e5I
         S9d8aksjqJUqcjj3SKnHDZbyyrrMThQxs7tyUZhmX9+2rOhXzjE0QB9EtTv1trMcS9g1
         QyxA==
X-Gm-Message-State: AOAM530IgjiYXe2Eur2D9EjZPL93yNJTHCMMdbk+K8nltjk0O64iYdz9
        pL5ScwI5/7AQvENrb0nKsxw=
X-Google-Smtp-Source: ABdhPJxVi0VbmCyg6J1Vqr8GZ4KEK4IVrYieTsePEFo7wi2qpcKlCIXrJfift9AXaaQsJx33HI6vWQ==
X-Received: by 2002:a17:907:7208:: with SMTP id dr8mr15814976ejc.697.1640648628096;
        Mon, 27 Dec 2021 15:43:48 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id zh8sm5452384ejb.1.2021.12.27.15.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 15:43:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n1zec-0006Wf-Pl;
        Tue, 28 Dec 2021 00:43:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 19/21] usage API: use C99 macros for
 {usage,usagef,die,error,warning,die}*()
Date:   Tue, 28 Dec 2021 00:01:58 +0100
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
        <RFC-patch-19.21-0bbca8cca8e-20211115T220831Z-avarab@gmail.com>
        <66b25f23-7349-1540-76b8-c9f0a64660ac@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <66b25f23-7349-1540-76b8-c9f0a64660ac@jeffhostetler.com>
Message-ID: <211228.861r1xk40d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 27 2021, Jeff Hostetler wrote:

> On 11/15/21 5:18 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> [...]
>> It might be a good change to remove the "fmt" key from the "error"
>> events as a follow-up change. As these few examples from running the
>> test suite show it's sometimes redundant (same as the "msg"), rather
>> useless (just a "%s"), or something we could now mostly aggregate by
>> file/line instead of the normalized printf format:
>>        1 file":"builtin/gc.c","line":1391,"msg":"'bogus' is not a
>> valid task","fmt":"'%s' is not a valid task"}
>>        1 file":"builtin/for-each-ref.c","line":89,"msg":"format: %(then)=
 atom used more than once","fmt":"%s"}
>>        1 file":"builtin/fast-import.c","line":411,"msg":"Garbage after m=
ark: N :202 :302x","fmt":"Garbage after mark: %s"}
>> "Mostly" here assumes that it would be OK if the aggregation changed
>> between git versions, which may be what all users of trace2 want. The
>> change that introduced the "fmt" code was ee4512ed481 (trace2: create
>> new combined trace facility, 2019-02-22), and the documentation change
>> was e544221d97a (trace2: Documentation/technical/api-trace2.txt,
>> 2019-02-22).
>> Both are rather vague on what problem "fmt" solved exactly, aside
>> from
>> the obvious one of it being impossible to do meaningful aggregations
>> due to the "file" and "line" being the same everywhere, which isn't
>> the case now.
>> In any case, let's leave "fmt" be for now, the above summary was
>> given
>> in case it's interesting to remove it in the future, e.g. to save
>> space in trace2 payloads.
>
> I added the "fmt" field so that we could do aggregations
> of error messages across multiple users without regard
> to what branch or filename or percentage or whatever was
> formatted into the actual "msg" written to stderr.
>
> The actual file:line wasn't useful (primarily because it
> was probably something in usage.c), but even if we fix that
> it might not be useful if we have users running 10 different
> versions of Git (because some people don't upgrade immediately).
>
> So I'd rather not kill it right now.

Thanks. I'm not trying to kill it, but just poking at what it was for
exactly.

Depending on the answer to that perhaps we didn't need it anymore, but
the explanation you provide (mostly) makes sense.

The "mostly" being because I'm assuming that you only need to deal with
LC_ALL=3DC users?

I.e. the documented promise that you can group things by "fmt" doesn't
hold if you're processing even streams from users who are using a
translated git, because we'll get the translated format string, not the
original.

For that we'd need to change the API from/to to:

    - error(_("some format %s"), ...)
    + error(N_("some format %s"), ...)

So being able to say "just group on file/line" would be simpler.

And also "mostly" because the "fmt" case also won't handle these and
other duplicate formats (but maybe you haven't run into them in
practice):

    $ git grep -E '\b(usage|die|error|warning)(_errno)?\("%s\"' -- '*.[ch]'=
 | wc -l
    90

So I was somewhat hoping for future work that you'd be OK with the new
file/line grouping.

Because keeping "fmt" would eventually need some massive coccinelle
search/replacement for "_(...)" -> "N_(...)" per the above, even then
consumers of the stream would get duplicate grouping for the likes of
"%s".

Do you think if as a follow-up we had "__func__"[1] along with
"file/line" that the "file/__func__" combination would be good enough?
The advantage of that would be that we could punt that "fmt"
change/complexity and document:

    If you'd like to group errors the "file/line" pair will be unique
    enough within a given git version to do so (sans a few codepaths that
    relay errors from elsewhere).

    If you'd like a semi-stable grouping across similar git versions the
    "file/func" pair should be Good Enough for most purposes. Some functions
    might emit multiple errors, but you'd probably want to group them as
    similar enough anyway.

But I realize that those things don't give you exactly the same things
that "fmt" does, but maybe they're good enough (or even better?), or
not.

1. https://gcc.gnu.org/onlinedocs/gcc/Function-Names.html
