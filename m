Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DC5C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 12:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7DA61027
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 12:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243955AbhIAMCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 08:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243901AbhIAMCc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 08:02:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD4EC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 05:01:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q14so4136900wrp.3
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 05:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+zBFwGOkU20jrJOksH53gLtsOAqaPedQN0OvPUIViwc=;
        b=pt9c6VwXe8L2Xr55tY/p0/qybWQoyXg6shFSaF0SsVPMP6YYMJwWjnA+6jiE2pDewx
         FBsbaDvoCT42ZTUlvd7G10CYLxJsZRPnpOUjWKDKTcjLr2g+skcb8D2d1F1MIvrTAkEx
         q/4fcLOmRpoiooRL4D2mpS/JqZ3nLAzAv77Y/fJiQqwzAlfKMiQlIyM2fhPp84sXdWTS
         xjTEttY9IpFw8h+vJ0RP+H5n6GKJbynzzIiAsHQb/ulHxMbFD4ZbJupjPfPiIucwLxeP
         Wui9zrJTZlQWg2hcN1fAvAuBOEPNDXJyE+sBMIZeswv3YbSajfNNr9LzkKjVjTwIm0Uj
         9pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+zBFwGOkU20jrJOksH53gLtsOAqaPedQN0OvPUIViwc=;
        b=Nx6bM+CPfs8pDlsVkWgAyauwdbP2+xxDGZK1HskpO1XgkbbwlTu6GS10KfBqpx8i+g
         nyrxyMCyX/Cjm62A8LXtAeFKltSpsRovmFYVT9IXDcMFNme/w+UOaRnKFfJFdY2EHQn3
         YAr/68Z/t/Xa7nZdb//N8OgeVmuZK3pw9ScvvMOwuKCM2F1LyEdqTKhtU1PmNrt7uFo2
         Hi5q1S/NgytwNudq5TFZrHGS+n4TO1O61q2Mbj8EuYdo5W2C8KuSBn6qUYwFyasu5o2k
         lTondpuXWI39g2rNFAlvwsJ2N7a1KeSAjc2cJ9pV0strSrJgFRtImvlsSVk4rAUZOIn0
         HVaQ==
X-Gm-Message-State: AOAM532ufxphIwTdazsTEUTNxGYri6dhjZuK9c8ZeYG4VHDKv9NyOCx8
        kLiZgXZNkIzPC+OTJcYVdO8=
X-Google-Smtp-Source: ABdhPJzwAAv8oLuXRGG4P2LqNYzSakCP8nAq6FodzwMKjU9i+EfOJuYOki4mdkk7L86W2a+B7ZO//w==
X-Received: by 2002:a5d:6e91:: with SMTP id k17mr37352161wrz.77.1630497693483;
        Wed, 01 Sep 2021 05:01:33 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r12sm21732447wrv.96.2021.09.01.05.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 05:01:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrzej Hunt <andrzej@ahunt.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/4] SANITIZE tests: fix memory leaks in t13*config*,
 add to whitelist
Date:   Wed, 01 Sep 2021 13:45:15 +0200
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
        <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
        <patch-2.4-867e8e9a6c-20210714T172251Z-avarab@gmail.com>
        <871ea493-e108-e748-0234-f929690ad2fd@ahunt.org>
        <YPCrvOce5qRWk6Rq@coredump.intra.peff.net>
        <87wnpqy8zd.fsf@evledraar.gmail.com>
        <YPH3OOOfK9RVebqZ@coredump.intra.peff.net>
        <87y28hwylq.fsf@evledraar.gmail.com>
        <YS8xj9XtKqEEy/Bb@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YS8xj9XtKqEEy/Bb@coredump.intra.peff.net>
Message-ID: <875yvkwllw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 01 2021, Jeff King wrote:

> On Tue, Aug 31, 2021 at 02:47:01PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > That works, but now "util" is not available for all the _other_ uses f=
or
>> > which it was intended. And if we're not using it for those other uses,
>> > then why does it need to exist at all? If we are only using it to hold
>> > the allocated string pointer, then shouldn't it be "char *to_free"?
>>=20
>> Because having it be "char *" doesn't cover the common case of
>> e.g. getting an already allocated "struct something *" which contains
>> your string, setting the "string" in "struct string_list_item" to some
>> string in that struct, and the "util" to the struct itself, as we now
>> own it and want to free() it later in its entirety.
>
> OK. I buy that storing a void pointer makes it more flexible. I'm not
> altogether convinced this pattern is especially common, but it's not any
> harder to work with than a "need_to_free" flag, so there's no reason not
> to do that (and to be fair, I didn't look around for possible uses of
> the pattern; it's just not one I think of as common off the top of my
> head).
>
>> That and the even more common case I mentioned upthread of wanting to
>> ferry around the truncated version of some char *, but still wanting to
>> account for the original for an eventual free().
>>=20
>> But yes, if you want to account for freeing that data *and* have util
>> set to something else you'll need to have e.g. your own wrapper struct
>> and your own string_list_clear_func() callback.
>
> But stuffing it into the util field of string_list really feels like a
> stretch, and something that would make existing string_list use painful.
> There are tons of cases where util points to some totally unrelated (in
> terms of memory ownership) item. I'd venture to say most cases where
> string_list_clear() is called without free_util would count here.

For what it's worth I've got some WIP code that's part of my daily build
where I did end up going through all those callers, as part of general
string_list_clear() improvements mentioned offhand in
https://lore.kernel.org/git/87bl6kq631.fsf@evledraar.gmail.com/

This is just from fuzzy memory & I can't recall the specifics (and
haven't combed through that WIP code now), but it's something like that
in the ~100 uses of string_list in our codebase 60-70% are the simple
case where the "strdup_strings" and string_list_clear() is enough, maybe
another 10-20% have a "util" field they manage or not, 5%-ish have a
simple string_list_clear_func().

It was just 2-3 cases that leaked memory due to skipping a prefix and
sticking it in the list, and maybe another 1-2 where the void* to a
struct containing the string stuck into the string slot was something we
could use.

So it's not "common" in the sense of absolute numbers, but I did run
into a handful of them, and having them handled by having the
string_list take an arbitrary "util" was something I found neat.

I should probably have said "well known" (as in "well known technique"),
"idiomatic" or something...

>> > I don't think most interfaces take a string_list_item now, so wouldn't
>> > they similarly need to be changed? Though the point is that all of the=
se
>> > degrade to a regular C-string, so when you are just passing the value
>> > (and not ownership), you would just dereference at that point.
>>=20
>> Sure, just like things would need to be changed to handle your proposed
>> "struct def_string".
>>=20
>> By piggy-backing on an already used struct in our codebase we can get a
>> lot of that memory management pretty much for free without much
>> churn.
>>=20
>> If you squint and pretend that "struct string_list_item" isn't called
>> something to do with that particular collections API (but it would make
>> use of it) then we've already set up most of the scaffolding and
>> management for this.
>
> It's that squinting that bothers me. Sure, it's _kinda_ similar. And I
> don't have any problem with some kind of struct that says "this is a
> string, and when you are done with it, this is how you free it". And I
> don't have any problem with building the "dup" version of string_list
> with that struct as a primitive. But it seems to me to be orthogonal
> from the "util" pointer of a string_list, which is about creating a
> mapping from the string to some other thing (which may or may not
> contain the string, and may or may not be owned).

The "util" is whatever the user makes it. We could add a
"pointer_to_free" to every container type to solve this more
cleanly/generally at the API level, but just handing the problem to the
user seems better to me. I.e. an API like string_list has convenience
functions for freeing all the "util", if you only need it for memory
tracking use it as-is, if you need a "real util" *and* such tracking
just create a 2-member wrapper struct yourself & use that.

> TBH, I have always found the "util" field of string_list a bit ugly (and
> really most of string_list). I think most cases would be better off with
> a different data structure (a set or a hash table), but we didn't have
> convenient versions of those for a long time. I don't mind seeing
> conversions of string_list to other data structures. But that seems to
> be working against using string_list's string struct in more places.

If we followed my idle musings we'd be using string_list_item in more
places, not necessarily string_list, and would rename
s/string_list_item/string_and_util/ or something.

One way to look at this problem is that we're pretty close to just
re-inventing the sort of generalized refcounted container type that some
programming languages carry around. E.g. Perl has a "struct SV*" that a
$string maps to, but also hash and array values etc.

Those languages usually have a "refcount" or whatever, but since we're
using this in native C and it's usually (or at least should be) clear
who owns the memory just having something to point free() at will do.

I'm just saying that if we're going halfway there it would be
unfortunate if we'd end up with a "struct def_string" which wouldn't
handle this "borrowing a string from a struct" case.

Or maybe we should just use "struct strbuf" and do copying in even more
places...
