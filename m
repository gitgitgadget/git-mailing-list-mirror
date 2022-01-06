Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9E3C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 23:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245559AbiAFXb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 18:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245549AbiAFXb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 18:31:58 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6A8C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 15:31:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w20so7753458wra.9
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 15:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=64oRBfgAVU6Gd/oYC+toYmqblaKfYkD8QK+e9TDUFdc=;
        b=TAbPOlGeWWyRTrfsuJNyHQIYxtua1YLAt7GYoj5tGAAG17Q1fr7pWSrZhIilAolQlh
         dIKTL0daS5P37oW7QlQ9H1miZMhWA9ZpLEPvE+1ZG7JtIgHpjQA2VPX068bIrLmHs32O
         mR//kOsV7usF2WB70MaLUuKTpoorJfX/WbrE0JOKLNZoIUwBfxlxqmfPlaRdBv6J1sUQ
         BNZKdQ+mRB/xESWpky5wOg5CtPA+Sp5zJMziapbfSSNh1dqywgLUpDCFnosTc80sIqc0
         XAQMYmoDajXA7OHin4JiygTot/8oFTe/FZgImeZkirbE3aCdeva+/7mClPj2dYkv66W5
         wsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=64oRBfgAVU6Gd/oYC+toYmqblaKfYkD8QK+e9TDUFdc=;
        b=Owf/xd0j25fYZSxTO8DBH2SnTaoOXeC5w1ViEJ/i8W6MP2tSWbdINtgfbXAAPBhOPS
         LxmCpaIsj3LKzjNCrHMcXPBH+yInjggTN6Gj+JEn0/7urJZLwx/WkyEh1NruiVBen1kh
         YAktwuKoOK4ta95U/Wgb6cKaNaIjrVYg7s/uPNAb4FBr9UMBsrIZ7zJlxIy8PwXVNvZg
         XlFEBoRhWxTC4UQ0nf9S6NdR0/hm0MjlYtnJbtLbZKZnTQexRShXpM4cD/Y2kH9KARwO
         rsiRCw68VkBTJ1uvAUH0lMYAeQa9db1DFxo6oWPyMj0M1lC72N0TYR9/tjmSM3YcTc5R
         MbXQ==
X-Gm-Message-State: AOAM533mRVUGdbYb0VecHd4w+0G8eeto9Piii+i83kKuvoI2wY70l3GY
        oo7E7HydLK9cOjz4Dg7Xf0XSMeRNotOj7iKg
X-Google-Smtp-Source: ABdhPJw6xr88osYmsfBdcMbaEhMvpE1V8ieswjvKTyKvvjUhZWh3d0116ksC65k1Uh1bPlk2bgsi4A==
X-Received: by 2002:a5d:6f11:: with SMTP id ay17mr14834660wrb.662.1641511916926;
        Thu, 06 Jan 2022 15:31:56 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id w18sm3222713wrs.26.2022.01.06.15.31.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jan 2022 15:31:56 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <Ydd50/BLKlbK+Wj4@camp.crustytoothpaste.net>
Date:   Thu, 6 Jan 2022 23:31:56 +0000
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5B62547-BC22-4EF8-87FE-70E195EC88B8@jrtc27.com>
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <Ydd50/BLKlbK+Wj4@camp.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 Jan 2022, at 23:22, brian m. carlson <sandals@crustytoothpaste.net> =
wrote:
>=20
> On 2022-01-05 at 13:23:24, Jessica Clarke wrote:
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
>=20
> I think this is going to be a problem in a lot of places, not just in
> Git.  I'm pretty sure that copying data this way is specifically =
allowed
> by C and POSIX, and thus this approach is going to break a whole lot =
of
> things.

The standard says you can copy anything to an unsigned char array to
get its object representation. This we support just fine. The standard
does not say you can copy that object representation back to an object
of the original type and get a valid object of the original type. We
only support that if the unsigned char array is aligned enough.

Technically git is already wrong here by using char not unsigned char,
though that doesn=E2=80=99t make a difference for CHERI, nor any =
implementation
I know of.

> For example, casting a void * to uintptr_t and back should produce two
> pointers that compare equal.  The C standard says that two pointers
> compare equal if they're both null, both point to the same object, or
> one points one past the end of an array and the other happens to point
> to the beginning of another object.  If the pointers aren't null and =
the
> original one points to valid data, then the resulting pointer (after =
the
> two casts) would point to the same object (since that's the only valid
> option that's left), and therefore could be used to access it, but =
that
> wouldn't necessarily work in this case.

All of this CHERI supports. Casting to uintptr_t and back works just =
fine.

> The CHERI paper I'm reading also specifically says it is not changing
> uintmax_t, which is a direct violation of the C standard.  If =
uintptr_t
> must be larger than 64 bits, then so must uintmax_t, even if that
> happens to be inconvenient (because it changes the ABI from the normal
> system ABI).  It sounds like, in fact, that you can't actually provide
> uintptr_t with the current architecture, because it can't be provided =
in
> a standard-compliant way.

Every C implementation that provides 128-bit integers violates this.
Nothing cares. As explained in my reply to Junio this thread it is not
possible to provide a uintmax_t that can hold a uintptr_t on CHERI in
general. So we don=E2=80=99t. And almost no software cares.

Not providing a uintptr_t breaks basically all systems code ever,
except the code that=E2=80=99s so old it assumes unsigned long is the =
right
type and is already broken for CHERI as a result.

> Is there something I'm missing here, or is it the case that CHERI's
> behavior isn't compliant with the C standard?

There are some cases where we=E2=80=99re slightly non-compliant. So is =
every
implementation that exists. We believe the few restrictions we add,
which can all be easily worked around, are vastly outweighed by the
benefit of having hardware that enforces fine-grained memory safety
efficiently, and the empirical evidence is that these restrictions are
not an issue for the vast majority of real-world C code.

Jess

