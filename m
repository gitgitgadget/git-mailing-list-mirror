Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC66CC433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 00:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344074AbiAGAWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 19:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbiAGAWh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 19:22:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B411C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 16:22:37 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso2073768wme.1
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 16:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J7hFkXST1pH7Bc9pVQiyGwvmA4VqIj7zjcMJRk0EBPk=;
        b=CM7nNhET+fAjJYoPKxw/72gB9Yv0U7r6v/iBwCg404EXFiX44erCizLvA3E7rY3QRN
         P2TAExX3Prqzx/xI/uJME3/RGaS206oi9ZRLUxC4H/PgfQG3UDPSIa82vfBB/Wv1jgPT
         AoqgfMDrhjPPFfkqdqb9F3ZoHv4xlEeQIlqiAEji3Kwz5j5FEDgByrvkxFP1VFwVk0h2
         L7O9wp1RVbqHju2lBzhtSlkpHxJzLQO0160AQEuhwsm0crV2H7R69hvpUfjqTWs7eMIh
         dQEt0cLqGpJqM/5vwTUxqSZYvnEnIhsQvGIN/yRfXX8RN1N5jt67aIfCRigVUDgHQzXi
         bkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J7hFkXST1pH7Bc9pVQiyGwvmA4VqIj7zjcMJRk0EBPk=;
        b=pbexqbcaQTcITIC/5aErv3PRlr7Jz+QlrFeMn/IZFXx8gMUPqMorRgmKUafwL4NmCs
         9rWnYzV0WjuXk46RNf1vdDhtKiivOZTVxvebak0Z8cff5eImkEMwWcfHfzbDzlfTQBdX
         yX0ohM2WTfyYv1uYL/Ph6Qjb6H7MrMhnk9kKS6xhY3ak+ro82ubd8xMdQ6P1WQxNXXiL
         tFS1PRKwP4kkFTIYwryVrvKRAT8vx1Ezd4uR/LEs+D9CxI6j+iTq9lkS9upC7hymzXJF
         xT6uR3x4U+Y0+WZC6J0fPGlM+hwG8lWlnaODvqht4JyenvJUY/WFMc0HwqTVLXhOsLjQ
         e1gQ==
X-Gm-Message-State: AOAM532hfFcdv/HH887Uemh9/Aw+LEzr7bifRJJNpKNiDcGcF7Usdnop
        2DXpWtmTiUNuKEgjbfmNH1XdfuDDJZuP4AVX
X-Google-Smtp-Source: ABdhPJwYwAHfH/B4bGjHEnoqlYpk11O19F5Ae6/J9OrI4HCN74CmAUe0zcJ65H2tzZJJlzSVD7irvA==
X-Received: by 2002:a1c:f01a:: with SMTP id a26mr8900613wmb.175.1641514955940;
        Thu, 06 Jan 2022 16:22:35 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id o12sm3660454wrc.69.2022.01.06.16.22.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jan 2022 16:22:35 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <xmqqfsq09ziq.fsf@gitster.g>
Date:   Fri, 7 Jan 2022 00:22:35 +0000
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <54D928E7-7BA2-4BD7-9C08-A4650712CEBF@jrtc27.com>
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <YddjJ+uIQM34Gedo@nand.local> <xmqqh7agbiuq.fsf@gitster.g>
 <97D2AB55-0F8F-4C38-A5C6-1AAA43EA064A@jrtc27.com>
 <xmqqfsq09ziq.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 Jan 2022, at 00:10, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Jessica Clarke <jrtc27@jrtc27.com> writes:
>=20
>> This is also true of uint128_t, it doesn=E2=80=99t fit in a uintmax_t =
either.
>=20
> uintmax_t is supposed to be an unsigned integer type capable of
> representing any value of any unsigned integer type, so if you have
> 128-bit unsigned integer, your uintmax_t should be at last that
> wide, or your uintmax_t is not uintmax_t as far as C standard is
> concerned, no?

Yes. Every 64-bit architecture implemented by GCC and Clang violates
this. This is why uintmax_t is a terrible idea, it gets baked into your
ABI and you can=E2=80=99t add new integer types. People decided for =
128-bit
integers it was better to add them than let uintmax_t constrain them.
We take the same approach for CHERI of not caring about uintmax_t. If
you want to hold this against CHERI, go file bugs against GCC and Clang
for violating the standard on x86_64, aarch64, mips64, powerpc64,
s390x, sparc64, and so on.

> uintptr_t is an unsigned integer type that any valid pointer to void
> can be converted to this type, then converted back to pointer to
> void, and the result will compare equal to the original pointer.  So
> the value of uintptr_t cannot be represented by uintmax_t, there is
> something wrong.
>=20
>> uintmax_t was a mistake as it becomes part of the ABI and can never =
be
>> revised even when new integer types come along. uintmax_t can hold =
any
>> valid address, but will strip the metadata.
>=20
> It is a flaw in the implementation of uintmax_t on the architecture
> that needs "the metadata", no?  If the implementation supports a
> notion of uintptr_t (i.e. there exists an unsigned integer type that
> can safely go back and forth from pointer to void), an unsigned
> integer type that is at least as wide as any unsigned integer type
> should certainly be able to hold what would fit in uintptr_t, no?

If you want to get really language-lawyer-y about it, you can actually
argue that this is a compliant implementation of the C standard.
Integer types are permitted to have padding bits, and some combinations
of padding bits are allowed to be trap representations. Technically, in
our representation, the metadata bits are padding bits, because they do
not contribute to the precision like value bits. It is therefore the
case that the *value* of a uintptr_t still fits into a uintmax_t, but
the latter has no padding bits, and casting the latter to the former
yields a trap representation when further cast back to a pointer. This
may not the intent of the spec, and not how anyone thinks of it because
CHERI is the first implementation that pushes the boundary here, but
it=E2=80=99s technically legal under that interpretation. You may =
disagree with
the interpretation, and I don=E2=80=99t like to use it most of the time =
because
it=E2=80=99s complicated and involves yet more ill-defined parts of the =
spec
(e.g. it says arithmetic operations on valid values (they mean objects,
I assume, as the value only includes value bits, but the input could be
a trap representation on some implementations) never generate a trap
representation other than as part of an exceptional condition such as
an overflow, but nowhere defines what counts as an arithmetic
operation).

Jess

> Puzzled.
>=20

