Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF25C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 13:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCB261445
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 13:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhGCNK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhGCNK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 09:10:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D66C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 06:07:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h2so17132541edt.3
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Hu2MnfyUmHqpCxlKGkcl/Gi8e3CjQsHewA76GhHMpU4=;
        b=EHa109x0kOvQEOA1pHLMOcauiKtdQLeXrCtf7OsBTWZRA5NQVGjBRnAzUYq/ttQchg
         v+/u2sfAfJoCVICIlJP16j5ly9hEafYWyUkNo+HrkpiflYcvpaR5Xf96cBBDuK4iVI3k
         N3iBo6j8z9tMV1f8+SbEeoPiG/tivytEzETrPVlHvEgX41mH3QqjIF0TKeALbS+eG/8m
         mFFy6+ajJr8WpYRVamkoZQXAY/EA/350QhDFyIvxX17+0roNIeK7NF2Av9viVmTr4XHS
         TY/My2x/LdoTASV0Wd55JbbwxC8jdzMh8fK9vDRW1ZfWZHaOEDZXpa2J9yzNkwEAZvXq
         mTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Hu2MnfyUmHqpCxlKGkcl/Gi8e3CjQsHewA76GhHMpU4=;
        b=LXYYm3ubuhebPJ9leyHWyNnkjngJkZW8CA0q1tXlrtpxQtj9WOWleyoxWra0xhrZok
         Qk90hh0RHsLq9Hh9imB1vwq9HGzWE2q24m9h7bXzX8bF71xKBGOiVJQEi9oyiUmaIG7j
         BmCPFU8w6x46MzIyLCuN+D/ctO9DLVv6DoZB5ZDi9IIXjPuRJ4+w3f7b9dWp7QCmm7wZ
         X4m/fM9GJqGYkEyePx8d07T9r4iWF1q8H7H2uNY4fLA7spdopo/wR3Z7KesppDgfydeC
         o0GvKH+4VYnxW/mFfVKRsZ3nLRCZfwPOisFWEo0f+8BszsNvsX99nsPRN+2O0ni9PpTp
         vJCw==
X-Gm-Message-State: AOAM531an9kuRLVXc+lOERBulhALAWn0lK9vLG4xdxOMZ+ADmBCRKxKW
        n1xXdBhtBMtxg5ipsK6l7p8=
X-Google-Smtp-Source: ABdhPJwctQN8hWffUiiJE9W0WiwZI8UGlvym82WlmHwxXK+mnPDHeatDq9lqgUi+al+ZHE88klMM1A==
X-Received: by 2002:aa7:cf91:: with SMTP id z17mr5247629edx.112.1625317672755;
        Sat, 03 Jul 2021 06:07:52 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b25sm2648698edv.9.2021.07.03.06.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 06:07:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH] khash: clarify that allocations never fail
Date:   Sat, 03 Jul 2021 15:05:28 +0200
References: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
 <YOA+IibZw6C9mkdF@coredump.intra.peff.net>
 <87v95r8w86.fsf@evledraar.gmail.com>
 <5cc24582-ed96-453a-fbad-d3fb83c8f949@web.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <5cc24582-ed96-453a-fbad-d3fb83c8f949@web.de>
Message-ID: <87h7hb8s0o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 03 2021, Ren=C3=A9 Scharfe wrote:

> Am 03.07.21 um 13:35 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Sat, Jul 03 2021, Jeff King wrote:
>>
>>> On Sat, Jul 03, 2021 at 12:05:46PM +0200, Ren=C3=A9 Scharfe wrote:
>>>
>>>> We use our standard allocation functions and macros (xcalloc,
>>>> ALLOC_ARRAY, REALLOC_ARRAY) in our version of khash.h.  They terminate
>>>> the program on error, so code that's using them doesn't have to handle
>>>> allocation failures.  Make this behavior explicit by replacing the code
>>>> that handles allocation errors in kh_resize_ and kh_put_ with BUG call=
s.
>>>
>>> Seems like a good idea.
>>>
>>> We're very sloppy about checking the "ret" field from kh_put_* for
>>> errors (it's a tri-state for "already existed", "newly added", or
>>> "error"). I think that's not a problem because as you show here, we
>>> can't actually hit the error case. This makes that much more obvious.
>>>
>>> Two nits if we wanted to go further:
>>>
>>>> diff --git a/khash.h b/khash.h
>>>> index 21c2095216..84ff7230b6 100644
>>>> --- a/khash.h
>>>> +++ b/khash.h
>>>> @@ -126,7 +126,7 @@ static const double __ac_HASH_UPPER =3D 0.77;
>>>>  			if (h->size >=3D (khint_t)(new_n_buckets * __ac_HASH_UPPER + 0.5))=
 j =3D 0;	/* requested size is too small */ \
>>>>  			else { /* hash table size to be changed (shrink or expand); rehash=
 */ \
>>>>  				ALLOC_ARRAY(new_flags, __ac_fsize(new_n_buckets)); \
>>>> -				if (!new_flags) return -1;								\
>>>> +				if (!new_flags) BUG("ALLOC_ARRAY failed");				\
>>>
>>> I converted this in b32fa95fd8 (convert trivial cases to ALLOC_ARRAY,
>>> 2016-02-22), but left the now-obsolete error-check.
>>>
>>> But a few lines below...
>>>
>>>>  				memset(new_flags, 0xaa, __ac_fsize(new_n_buckets) * sizeof(khint3=
2_t)); \
>>>>  				if (h->n_buckets < new_n_buckets) {	/* expand */		\
>>>>  					REALLOC_ARRAY(h->keys, new_n_buckets); \
>>>
>>> These REALLOC_ARRAY() calls are in the same boat. You dropped the error
>>> check in 2756ca4347 (use REALLOC_ARRAY for changing the allocation size
>>> of arrays, 2014-09-16).
>>>
>>> Should we make the two match? I'd probably do so by making the former
>>> match the latter, and just drop the conditional and BUG entirely.
>>
>> Yes, I don't see why we should be guarding theis anymore than we do
>> xmalloc() or other x*() functions in various places (which is what it
>> resolves to).
>
> Agreed.
>
>> If anything we might consider renaming it via coccinelle to
>> XALLOC_ARRAY(), XREALLOC_ARRAY() etc. to make it clear that they handle
>> any errors themselves.
>
> I don't think there's any confusion in our internal code about the macros'
> handling of allocation errors.
>
> The following semantic patch finds a leery xmalloc() caller in
> compat/mmap.c, though:
>
> @@
> expression PTR, SIZE, SIZE2;
> @@
> (
>   PTR =3D xmalloc(SIZE);
> |
>   PTR =3D xcalloc(SIZE, SIZE2);
> |
>   PTR =3D xrealloc(SIZE);
> |
>   ALLOC_ARRAY(PTR, SIZE);
> |
>   CALLOC_ARRAY(PTR, SIZE);
> |
>   REALLOC_ARRAY(PTR, SIZE);
> )
>   if (
> - PTR =3D=3D NULL
> + 0
>   ) {...}
>
> Ren=C3=A9

Good catch, a bug as old as 730d48a2ef8 ([PATCH] If NO_MMAP is defined,
fake mmap() and munmap(), 2005-10-08).

It would be nice to have that coccinelle patch as a follow-up
patch. Perhaps along with changing that "0" to something that's simply a
syntax error, or just:

    if (0 /* always false due to (implicit?) x*() function call above */)
