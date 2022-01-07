Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5296FC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 02:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbiAGCIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 21:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344622AbiAGCIg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 21:08:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCDCC061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 18:08:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o3so8218611wrh.10
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 18:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4ADlbHvMqXdop9dDHGL/nCEtr/iniJHbHzPap43tzr4=;
        b=iol/jFIIPwyprlRpzUgK+p77p9gwOq0JI9NyjsAKEp6as+nR25+8MOlG68LuB20Ule
         y5n0GciqD0wCbgZu08HSU7gJ8I1n3aIvbngtgxtRCJPfT6kM4q1JMQQxGrQ/KTOTavts
         g+wXH+V/iLf3B4uzDZAWULMUJmMiRVwx+yGqN4qr8vaaeuJ7Dud+tkIKXwvkCoAyGP9D
         tx15qw+9eUcYCsaeQtIxwcr0/IM5BFo13Sy+pEgQNwzR4ClPRE7hm6HhHXz+Lw/XD84C
         3jjfIZzIXYMm+YAdhSHMHfe9Yk4g1yYJf9+5/tnK7LWNg53ujau8rnfKnkZVxfs4nPKG
         tCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4ADlbHvMqXdop9dDHGL/nCEtr/iniJHbHzPap43tzr4=;
        b=s8IaGZB9DaLqPesB4WiqyMPF1tx6K83WxXeQscLBXHBUw0Yw2nVISuLX7Vn0LPYY0U
         3AwYM+hVobIA+udYVl8BAjcStXfIRGbwwuPQLiLeAcdXj1Dy9qLlTYaE8B+mEcJC76ai
         yBvQK0GtYcpEW4JXvhVRwbUxQriM//u2uXCZs7o8eCfnDM2SHAgn5A0+aHQfaa5228XD
         8zJzTU17DmHtF/U7ZF+EFGsfiihQWSBW2KM8AHajZaEI0ASEvOzDLAZ2D/pbCB426TNF
         JKKkgLDQ8/QE3i7jq/xulaiRNvgT6P9NYO+ktTK2vmCW5ZjR6VsldJ6G5u8Fcbdl3xx+
         /xig==
X-Gm-Message-State: AOAM533MyWSAXTYm9WXXq8d2c/It7fF+ed0GIUSSFN5JzjASuEdcFkwM
        EaFzCUHQ/ApDjRTYetejnX61Cap59M/2vOAQ
X-Google-Smtp-Source: ABdhPJwjQk4CnzW/jQImdLf4PqTn55diIwaxoK+YvEJ+eg/HXf4O4L77+MTvZdi1tM4DatHr6CyB3A==
X-Received: by 2002:adf:82d2:: with SMTP id 76mr52902603wrc.329.1641521314307;
        Thu, 06 Jan 2022 18:08:34 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id d18sm1484151wrn.102.2022.01.06.18.08.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jan 2022 18:08:33 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <Ydea3EO7wrYc9/Ij@camp.crustytoothpaste.net>
Date:   Fri, 7 Jan 2022 02:08:33 +0000
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8B73861-9095-47D2-AC4F-5EC8D7589401@jrtc27.com>
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <YddjJ+uIQM34Gedo@nand.local> <xmqqh7agbiuq.fsf@gitster.g>
 <97D2AB55-0F8F-4C38-A5C6-1AAA43EA064A@jrtc27.com>
 <xmqqfsq09ziq.fsf@gitster.g> <YdeJ8Ub2Q0/c9kO2@camp.crustytoothpaste.net>
 <4D8B32AE-8316-4907-98F6-097901EC3DC0@jrtc27.com>
 <Ydea3EO7wrYc9/Ij@camp.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 Jan 2022, at 01:43, brian m. carlson <sandals@crustytoothpaste.net> =
wrote:
>=20
> On 2022-01-07 at 00:39:59, Jessica Clarke wrote:
>> On 7 Jan 2022, at 00:31, brian m. carlson =
<sandals@crustytoothpaste.net> wrote:
>>> If you want to get really language-lawyer-y about it, you can =
actually
>>> argue that this is a compliant implementation of the C standard.
>>> Integer types are permitted to have padding bits, and some =
combinations
>>> of padding bits are allowed to be trap representations. Technically, =
in
>>> our representation, the metadata bits are padding bits, because they =
do
>>> not contribute to the precision like value bits. It is therefore the
>>> case that the *value* of a uintptr_t still fits into a uintmax_t, =
but
>>> the latter has no padding bits, and casting the latter to the former
>>> yields a trap representation when further cast back to a pointer. =
This
>>> may not the intent of the spec, and not how anyone thinks of it =
because
>>> CHERI is the first implementation that pushes the boundary here, but
>>> it=E2=80=99s technically legal under that interpretation. You may =
disagree with
>>> the interpretation, and I don=E2=80=99t like to use it most of the =
time because
>>> it=E2=80=99s complicated and involves yet more ill-defined parts of =
the spec
>>> (e.g. it says arithmetic operations on valid values (they mean =
objects,
>>> I assume, as the value only includes value bits, but the input could =
be
>>> a trap representation on some implementations) never generate a trap
>>> representation other than as part of an exceptional condition such =
as
>>> an overflow, but nowhere defines what counts as an arithmetic
>>> operation).
>>=20
>>=20
>> So, no, C does not actually require what you say. It requires that =
void
>> * -> uintptr_t -> void * give you a valid pointer. It requires that
>> uintptr_t -> uintmax_t preserves the *value* of the uintptr_t, which =
we
>> do, because the value is formed from only the value bits which
>> contribute to the precision, which is 64 bits in this case, and
>> uintmax_t is still 64-bit. It requires that uintmax_t -> uintptr_t,
>> since uintptr_t=E2=80=99s precision is the same as uintmax_t=E2=80=99s,=
 be always
>> valid, which is is. But it does not require that that uintptr_t has =
the
>> same representation as the original uintptr_t, which it does not for
>> us. And therefore it does not require that casting that uintptr_t =
back
>> to a void * yields a valid pointer. So if you want to really dig into
>> the details of the standard, we are technically compliant, even if =
some
>> might argue it=E2=80=99s not in the spirit of the standard.
>=20
> Sure, implementations are allowed to have padding bits.  They're also
> allowed, at the moment, to use signed-magnitude or ones' complement
> integers, have CHAR_BIT greater than 8, have sizeof(char) =3D=3D
> sizeof(short), not implement any of the customary sizes of intN_t or
> uintN_t, not provide uintptr_t, and use middle-endian numbers.
>=20
> However, if your ABI is only compliant in the face of those features
> (especially when it could have been written in a way which would have
> been compliant without the use of those features), it's intentionally
> hostile to real-world developers, and I don't think we should support
> it[0].  I'd be willing to revisit this if your ABI were defined in a
> reasonable, sane way, where sizeof(uintmax_t) >=3D sizeof(uintptr_t),
> without padding bits, where the alignment of pointers from malloc is
> suitable for all types, and where the alignment of a type is no =
greater
> than sizeof(type).
>=20
> I'm not opposed to a small amount of finagling for this case, but I am
> very much opposed to defining your C ABI in an intentionally difficult
> way.  128-bit integers in 64-bit Linux were not originally part of the =
C
> ABIs and if the ABI is ill defined now, that's a historical accident.
> But this is a new ABI for a new architecture and it could have been
> defined in a responsible way, but wasn't.

It=E2=80=99s not a choice. It is not possible to define uintmax_t as =
being able
to safely round-trip any uintptr_t in a way that preserves pointer
validity unless you want to outlaw 64-bit integers on 32-bit CHERI
implementations, and good luck with that one, for reasons I have
previously explained, so if you do not wish to support this C
implementation then upstream Git will not work on CHERI/Arm=E2=80=99s =
Morello.
Nothing in this patch causes additional burden on other architectures,
in fact it likely improves performance on some due to increased buffer
alignment, so this seems a rather unnecessary line to take. We have all
of our fork of FreeBSD, kernel and userland, built and working on
CHERI, as well as X11 and the core of a KDE desktop (KWin, Plasma,
Kate, Okular, Gwenview, Konsole; we would have more but up until
recently we=E2=80=99ve needed to cross-compile everything and that=E2=80=99=
s often a
pain to get things building), plus WebKit=E2=80=99s JavaScriptCore =
complete
with a working JIT, so Git would be a notable omission in the stack,
and rather important for developers to actually get work done on their
boards.

Note that C requires us to define those bits as padding bits; the range
of an integer type is defined to be 0 to 2^N-1, where N is the number
of value bits, so it would be impossible to have any metadata in a
uintptr_t.

So I take issue with =E2=80=9Cin a responsible way=E2=80=9D. CHERI has =
been in
development for over 10 years, it=E2=80=99s been done in collaboration =
with
Arm, with people intimately familiar with C semantics and with
extensive analysis of what real-world software expects of C in order to
come up with the most-compatible implementation we reasonably can
that=E2=80=99s still feasible to implement in hardware and provides the =
desired
protection properties. Declaring it broken/hostile/etc feels like
throwing the baby out with the bath water; for industry to move away
from the sorry state of affairs that we still see with C and C++ where
memory safety vulnerabilities are ubiquitous you cannot just restrict
new ABIs to the status quo, as you just won=E2=80=99t make any progress.

> As an aside, I was actually going to point out that you could propose =
a
> nice Rust or Go ABI with the status quo, but if your C ABI requires
> padding bits, then you're probably going to have a hard time doing so,
> since I don't believe those languages support padding bits and they =
need
> to support the C ABI.

There is no such restriction in Rust that I can see. It=E2=80=99s true =
you=E2=80=99d
need to slightly tweak Go=E2=80=99s specification as uintptr is =
currently an
integer type and n-bit integer types are defined to be n-bit two=E2=80=99s=

complement values. I see no reason why that couldn=E2=80=99t be done =
though, I
doubt much cares. Rust only defines the representation of its
fixed-width integer types. There=E2=80=99s no reason you couldn=E2=80=99t =
add an
additional integer type for a capability, like we do for C. The only
issue with Rust is that it conflates uintptr_t with size_t, for which
there are various discussion threads with Rust maintainers and a path
forward for making it work if someone has the time to invest in making
Rust work. Languages can evolve; there=E2=80=99s no reason they can=E2=80=99=
t for CHERI
like they do for anything else they want to add, change, deprecate or
remove.

But this is all irrelevant to discussions of C.

Jess

> [0] For the record, I care strongly about portability, and I would not
> accept a runtime having any of the qualities I mentioned in the first
> paragraph.
> --=20
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA

