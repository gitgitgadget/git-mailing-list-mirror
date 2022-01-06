Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23428C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 21:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbiAFV4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244843AbiAFV4U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 16:56:20 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C609C061201
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 13:56:20 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q8so7379578wra.12
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 13:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xwVGIh8WNFZ/DDKKZ/x+/4s1YzeFhU2ygq1UBT4mCIA=;
        b=Vi3KB32xWproFHpFQPxwKK2XPXMAuhovlsNjJi4wcf7jfV4062lD3SngmFohgJKsQP
         CmBttLbGdVxGP+wCyGAvkLyneqLwuGr5Atv2VE/zVgb2rNzr5z4dxRfhRPKYNqKYjI5P
         vPWKwLgppWaVTcSaTnQAiRmj4WHpit7gjQ7RBQIARrSeR1QJkkl2BREG4004WDh/keQi
         0ckl5HAC7BBjvVO/Ia4OqBZlogCtRS1l5U/ZafcFYrI3zdmkLnttNMvYzf+AWlL3Fldr
         IGKMEYKJaCK51SBAfE1IzzNGOly8WazTylIu4roZnWF3qf8d73pkFZML1YpuyKjWkvbn
         rvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xwVGIh8WNFZ/DDKKZ/x+/4s1YzeFhU2ygq1UBT4mCIA=;
        b=E9Iij/vINFh0eD18LHpopXeSkjNA+BDeQhaoWVwpvXzQhciXFDf6vHqXmaozr+5AK0
         a9eQpo9ylTqALivqFKDCtDatwBvhq6asjVVyJ+K+VqsybFW0PWCE4IIRHmg+/rIdriLE
         /JOTltkAr8MV8UqMHFIWf21J9pnVyuo7qSuQ74V6v3eTNmlDWOXjPPvcPnHaWw1l/Zbc
         M3dwt+3PuaLulFxueLCp80ZZmfqBW1KyyFDvfWXC3BUA7UgRko6E4rL/EI67iob66coG
         x1EOwmPowhykgbDELU4RFZotqz3ujBZZnxistaXmJ7W9w1cUB1SH0OZY6QpZGEM/xqg5
         P4VA==
X-Gm-Message-State: AOAM532UEtOKGyMosB1GmF374B+G448yDHC0uphJGkooK1afVH7l/+ZX
        wnHNtzKUApdzwZF/pMcTPsZDjeCYxP1zBMJ6
X-Google-Smtp-Source: ABdhPJwFDkAbsWMET3CT5dZXvDTLtv5+V922XTNlIqoyw4L80TS/fP0OTcCRzcZKSNgw5kOZDc1y6Q==
X-Received: by 2002:a5d:6c63:: with SMTP id r3mr51813721wrz.678.1641506178977;
        Thu, 06 Jan 2022 13:56:18 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id w6sm2400476wro.114.2022.01.06.13.56.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jan 2022 13:56:18 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <YddjJ+uIQM34Gedo@nand.local>
Date:   Thu, 6 Jan 2022 21:56:18 +0000
Cc:     =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F022B78-5EC7-41D8-8AA6-99470019BB95@jrtc27.com>
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <YddjJ+uIQM34Gedo@nand.local>
To:     Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 Jan 2022, at 21:46, Taylor Blau <me@ttaylorr.com> wrote:
>=20
> (+cc Ren=C3=A9 as another possible reviewer)
>=20
> On Wed, Jan 05, 2022 at 01:23:24PM +0000, Jessica Clarke wrote:
>> Currently git_qsort_s allocates a buffer on the stack that has no
>> alignment, and mem_pool_alloc assumes uintmax_t's size is adequate
>> alignment for any type.
>>=20
>> On CHERI, and thus Arm's Morello prototype, pointers are implemented =
as
>> hardware capabilities which, as well as having a normal integer =
address,
>> have additional bounds, permissions and other metadata in a second =
word,
>> so on a 64-bit architecture they are 128-bit quantities, including =
their
>> alignment requirements. Despite being 128-bit, their integer =
component
>> is still only a 64-bit field, so uintmax_t remains 64-bit, and =
therefore
>> uintmax_t does not sufficiently align an allocation.
>>=20
>> Moreover, these capabilities have an additional "129th" tag bit, =
which
>> tracks the validity of the capability and is cleared on any invalid
>> operation that doesn't trap (e.g. partially overwriting a capability
>> will invalidate it) which, combined with the architecture's strict
>> checks on capability manipulation instructions, ensures it is
>> architecturally impossible to construct a capability that gives more
>> rights than those you were given in the first place. To store these =
tag
>> bits, each capability sized and aligned word in memory gains a single
>> tag bit that is stored in unaddressable (to the processor) memory. =
This
>> means that it is impossible to store a capability at an unaligned
>> address: a normal load or store of a capability will always take an
>> alignment fault even if the (micro)architecture supports unaligned
>> loads/stores for other data types, and a memcpy will, if the =
destination
>> is not appropriately aligned, copy the byte representation but lose =
the
>> tag, meaning that if it is eventually copied back and loaded from an
>> aligned location any attempt to dereference it will trap with a tag
>> fault. Thus, even char buffers that are memcpy'ed to or from must be
>> properly aligned on CHERI architectures if they are to hold pointers.
>>=20
>> Address both of these by introducing a new git_max_align type put in =
a
>> union with the on-stack buffer to force its alignment, as well as a =
new
>> GIT_MAX_ALIGNMENT macro whose value is the alignment of git_max_align
>> that gets used for mem_pool_alloc. As well as making the code work on
>> CHERI, the former change likely also improves performance on some
>> architectures by making memcpy faster (either because it can use =
larger
>> block sizes or because the microarchitecture has inefficient =
unaligned
>> accesses).
>>=20
>> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
>> ---
>> compat/qsort_s.c  | 11 +++++++----
>> git-compat-util.h | 11 +++++++++++
>> mem-pool.c        |  6 +++---
>> 3 files changed, 21 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/compat/qsort_s.c b/compat/qsort_s.c
>> index 52d1f0a73d..1ccdb87451 100644
>> --- a/compat/qsort_s.c
>> +++ b/compat/qsort_s.c
>> @@ -49,16 +49,19 @@ int git_qsort_s(void *b, size_t n, size_t s,
>> 		int (*cmp)(const void *, const void *, void *), void =
*ctx)
>> {
>> 	const size_t size =3D st_mult(n, s);
>> -	char buf[1024];
>> +	union {
>> +		char buf[1024];
>> +		git_max_align align;
>> +	} u;
>=20
> I'm not sure I understand. Clearly this union aligns buf along the =
width
> of git_max_align. But what about the preimage makes buf unaligned?

It=E2=80=99s a char array, so it can have any alignment. Its address =
could be
0x10007. And it doesn=E2=80=99t align to the width of git_max_align, it =
aligns
to the alignment of git_max_align. Those don=E2=80=99t need to be the =
same, the
alignment just needs to be a factor of the size.

(Technically if git_max_align has a size > 1024 then it=E2=80=99d also =
make the
union bigger, but that=E2=80=99s clearly absurd for any real C =
implementation)

>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 5fa54a7afe..28581a45c5 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -274,6 +274,17 @@ typedef unsigned long uintptr_t;
>> #define _ALL_SOURCE 1
>> #endif
>>=20
>> +typedef union {
>> +	uintmax_t max_align_uintmax;
>> +	void *max_align_pointer;
>> +} git_max_align;
>=20
> OK, the purpose of this union is to be as wide as the least common
> alignment between uintmax_t and void *, yes?

No, the purpose is for the union=E2=80=99s *alignment* to be the least =
common
alignment between uintmax_t and void *. The size doesn=E2=80=99t matter =
for
anything.

>> +
>> +typedef struct {
>> +	char unalign;
>> +	git_max_align aligned;
>> +} git_max_alignment;
>> +#define GIT_MAX_ALIGNMENT offsetof(git_max_alignment, aligned)
>=20
> ...then the offset of the aligned field within the git_max_alignment
> struct is going to be that common alignment? Could you not `#define
> GIT_MAX_ALIGNMENT` to be `sizeof(git_max_align)` directly, or is there
> something I'm missing?

You could, but that would over-align in cases where the alignment of
git_max_align is smaller than its size. For example, uint32_t and
uint64_t only require 2-byte alignment on m68k. Using offsetof ensures
we actually query the thing we care about, the alignment, and not the
size, which is guaranteed to be a multiple of the alignment, but not
necessarily equal to it.

> I suppose the way you wrote it here is done in order to prevent =
padding
> on the end of the git_max_align union from artificially increasing the
> value of GIT_MAX_ALIGNMENT.

So long as all those types have a size that is a power of two there
shouldn=E2=80=99t actually be any padding in the union, though it might =
be
legal for a hostile compiler to introduce it anyway for fun.

> In any case, I *think* what you wrote here is right. The typedef's are
> uncommon to our codebase, though. I wonder how much of this is all
> necessary.

If you=E2=80=99re willing to risk overaligning and wasting space then =
you can
just use sizeof the union. If you want it to be precise then I don=E2=80=99=
t
think you can cut any of it out (otherwise I would have done...).

Jess

