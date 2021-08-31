Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A248C4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D93D601FD
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhHaNJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhHaNJd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:09:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BF2C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:08:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q14so27621554wrp.3
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ebhPQlrbmXDNWn+SPkrIa+Ycyc95Ssqd7mR+5dsE4j0=;
        b=m5gKegFKOMu+mn5nuLsve/QdUBvRjiw1bipqR7xvIK8XQzWyIMzetDTqL1Djns9TbO
         K7Hc65/e7lrdTr67giZ1iyOYL/G7pcBtd+ZCXlNRz6MDdjWJFt6NR49fRCWM4NXdjJZF
         ++KHUUHONTk3/o7fT/jcUWW1MKL2ITmg4RzejlYvFx2cnvg+u8Mt/VbjNasaIPjC4u+D
         JHqYe1aKlxcF/ND9bUzt+6rgjVuPMqwUWZXz9BP4k/ROQ5bO1yzscA6dM7aA+jW67CcB
         T9xyEVmJ24BbYPJX2DW3gc57ZwQw7juMZb2Ua5gVvj8Sm0EBS6Oa7uPW+GFm2Jk8/m+W
         PnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ebhPQlrbmXDNWn+SPkrIa+Ycyc95Ssqd7mR+5dsE4j0=;
        b=DmD05IvnZf72/8Eola1qim//9vjFsQt15cM/yIUHTs3iMiZpuiT16n5yHz1ldihWFp
         g3PMC7FDRrwKOQxdGGlrO5Q3au9PQnu9pW8TOD8dpW+pjneWyN9nKQWMGdyS+QJXeFYp
         AILyMfIkHrcPPNvdPPtgzQNT6X9cv6CxtmCeV/Xqq6k2orjb4k/aUttw3zZ5a9cuzMVT
         PJlpyYb5vnWN9SeTsOkgPUqXg2lx2GN/GCb6KITF45cNBwwUV5EG36DI8crw/G8oBi/d
         vE29VCcAtpSCoso57GOajkyIUjhADRZNRhhwX4NAHDSPc22HDCvzfelbYEHZ93SHTfnv
         ezdw==
X-Gm-Message-State: AOAM5334PZJAvOMZ4WGfDFaozv2LzVxYCAeZyOn00lZjvpdPp1YIkoCb
        6brSzKIKy23dzXgkY/quw3U=
X-Google-Smtp-Source: ABdhPJwXwf2Hslp/HOgg82AFnud3n+gm3rBJORE7Zo1FsfwbGecF1csHzx2HoJ/fh5RLyGYehVnNfg==
X-Received: by 2002:adf:8102:: with SMTP id 2mr30226115wrm.89.1630415314775;
        Tue, 31 Aug 2021 06:08:34 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e13sm17806282wra.40.2021.08.31.06.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:08:34 -0700 (PDT)
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
Date:   Tue, 31 Aug 2021 14:47:01 +0200
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-2.4-867e8e9a6c-20210714T172251Z-avarab@gmail.com>
 <871ea493-e108-e748-0234-f929690ad2fd@ahunt.org>
 <YPCrvOce5qRWk6Rq@coredump.intra.peff.net>
 <87wnpqy8zd.fsf@evledraar.gmail.com>
 <YPH3OOOfK9RVebqZ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPH3OOOfK9RVebqZ@coredump.intra.peff.net>
Message-ID: <87y28hwylq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 16 2021, Jeff King wrote:

[Very late reply, just getting back to this thread]

> On Fri, Jul 16, 2021 at 09:46:33AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I can't say I _love_ any of that, but I think it would work (and
>> > probably we'd adapt our helpers like git_config_pathname() to take a
>> > def_string. Or I guess just have a def_string_free() which can be call=
ed
>> > before writing into them).
>> >
>> > But maybe there's a better solution I'm missing.
>>=20
>> Instead of: "int from_heap" in your "def_string" I think we should just
>> use "struct string_list_item". I.e. you want a void* here. Why?
>
> Yes, an equivalent way to write it is with a separate to_free buffer.
> But why would we want it to be void? And why would we want to use a
> string_list_item, which is otherwise unrelated?

We could factor "string_list_item" out into a "string_pair" or
whatever.

Sorry, I didn't mean to get into the naming/code location aspect of the
discussion, just the sensibility of using a "char */void * pair" for
these common memory management cases, v.s. your suggestion of having a
"char *, int from_heap" pair.

>> Well, tying this back to my clear() improvements for string-list.h I
>> thought a really neat solution to this was:
>>=20
>>     string_list_append(list, ptr)->util =3D on_heap_now_we_own_it;
>>     string_list_append(list, mydup)->util =3D mydup;
>>=20
>> I.e. by convention we store the pointer we need to free (if any) in the
>> "util" field.
>
> That works, but now "util" is not available for all the _other_ uses for
> which it was intended. And if we're not using it for those other uses,
> then why does it need to exist at all? If we are only using it to hold
> the allocated string pointer, then shouldn't it be "char *to_free"?

Because having it be "char *" doesn't cover the common case of
e.g. getting an already allocated "struct something *" which contains
your string, setting the "string" in "struct string_list_item" to some
string in that struct, and the "util" to the struct itself, as we now
own it and want to free() it later in its entirety.

That and the even more common case I mentioned upthread of wanting to
ferry around the truncated version of some char *, but still wanting to
account for the original for an eventual free().

But yes, if you want to account for freeing that data *and* have util
set to something else you'll need to have e.g. your own wrapper struct
and your own string_list_clear_func() callback.

I'm not suggesting that this handles every possible scenario, just that
having look at a lot of the code involved recently this seemed like a
neat solution for the common cases.

>> We're not in the habit of passing loose "string_list_item" around now,
>> but I don't see why we wouldn't (possibly with a change to extract that
>> bit out, so we could use it in other places).
>
> It seems unnecessarily confusing to me. It sounds like you have a struct
> which just _happens_ to have a "void *" in it you can re-use, so you
> start using it in lots of other places that are not in fact string lists
> at all. That is confusing to me on the face, but what happens when
> string_list needs a feature which requires adding more fields to it?
>
> If the point is to have a maybe-allocated string, why not make that a
> type itself? And then if we want string_list to use it, it can.

*nod*, covered above. My examples were unnecessarily confusing...

>> The neat thing about doing this is also that you're not left with every
>> API boundary needing to deal with your new "def_string", a lot of them
>> use string_list already, and hardly need to change anything, to the
>> extent that we do need to change anything having a "void *util" is a lot
>> more generally usable. You end up getting memory management for free as
>> you gain a feature to pass arbitrary data along with your items.
>
> I don't think most interfaces take a string_list_item now, so wouldn't
> they similarly need to be changed? Though the point is that all of these
> degrade to a regular C-string, so when you are just passing the value
> (and not ownership), you would just dereference at that point.

Sure, just like things would need to be changed to handle your proposed
"struct def_string".

By piggy-backing on an already used struct in our codebase we can get a
lot of that memory management pretty much for free without much
churn.

If you squint and pretend that "struct string_list_item" isn't called
something to do with that particular collections API (but it would make
use of it) then we've already set up most of the scaffolding and
management for this.
