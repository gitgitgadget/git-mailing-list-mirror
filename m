Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DEEC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 00:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbiAGAkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 19:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343865AbiAGAkC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 19:40:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9450CC061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 16:40:01 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v6so7957508wra.8
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 16:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0ZyhX0sqc6d51CXTDGQEqY4YqFGS6Yt+1gfUXrqEhVs=;
        b=P+WmQbFfZMqrnuK2qekg7UWUvMA24Qzj+eWctFrDvUn4Nxj1UN6OLPTZ6yC1JXX7zG
         RK/+oM2fdwFa4Ehw8a/DQAlTHVTgrPqEstbKM2KlZXTac0EndOjiRjkWSTa3F7FbyrYv
         1aw71C/cxsz6WwR4fyO4AeTz1LvSLtUZuVDS75wl+eEhoI12mpQ/YPQbFjX9yzAIX2J9
         uR8HUENCHDU5VifldstnytfONaF4JDibUQGJOCQ4YAQxf7JcdEUF6n91Neoco10zf/gc
         zbY7qOoXkjyxSyCpRgIzQz81EJDcNndCnFQGeH3IqlZUWc4Q/EOBFAlkktbY97TzN2uF
         iVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0ZyhX0sqc6d51CXTDGQEqY4YqFGS6Yt+1gfUXrqEhVs=;
        b=DydP902AayB7SEmmtEwfPMF7DTfhCjuObbwdDHcFMnsI1IEqhqbLJngUQfjquAABaD
         Pd1NrvdbLfvFOArPm0pmk8AcXvda+fEj/hfzeBw5JaKAS9zXz7xFgg/9pbF2Fxh+9r0Z
         VXcK+swrwmSIVIHQQdgXx7aCMooW7/9n0WEqLplw4BOyl4h1RONjs/3EL8V6d0SsAvxT
         b44S++L2V3Cpoo98PR1VDQiuRbq2DbQTTBG98A2JVA1avmQyW8D40ySff2r9VodSWeHO
         u85LLho1+cnCkiySQ0vcKctCDLjUp247AKzYPmP9JkC8Xqkp+rKIXicgf0rXchtaErfW
         fO9w==
X-Gm-Message-State: AOAM532rld372d0OxquSHbJrdEAVqNghG15nRXXHMKzRGBRr6EHeKfcj
        XuTmBZEsgw1ELK6qApWvMp2Saw==
X-Google-Smtp-Source: ABdhPJxda2cLRojlHoN7UQhVjB8uvpcsBTd+rgbJFz7d1CUXPxxL2ypSeMuAnf2VWLCkbes3js5bhQ==
X-Received: by 2002:adf:e40b:: with SMTP id g11mr4009718wrm.537.1641516000139;
        Thu, 06 Jan 2022 16:40:00 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id l26sm75822wms.24.2022.01.06.16.39.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jan 2022 16:39:59 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <YdeJ8Ub2Q0/c9kO2@camp.crustytoothpaste.net>
Date:   Fri, 7 Jan 2022 00:39:59 +0000
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D8B32AE-8316-4907-98F6-097901EC3DC0@jrtc27.com>
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <YddjJ+uIQM34Gedo@nand.local> <xmqqh7agbiuq.fsf@gitster.g>
 <97D2AB55-0F8F-4C38-A5C6-1AAA43EA064A@jrtc27.com>
 <xmqqfsq09ziq.fsf@gitster.g> <YdeJ8Ub2Q0/c9kO2@camp.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 Jan 2022, at 00:31, brian m. carlson <sandals@crustytoothpaste.net> =
wrote:
>=20
> On 2022-01-07 at 00:10:21, Junio C Hamano wrote:
>> Jessica Clarke <jrtc27@jrtc27.com> writes:
>>=20
>>> This is also true of uint128_t, it doesn=E2=80=99t fit in a =
uintmax_t either.
>=20
> I don't have this type from either GCC or Clang on my Debian amd64/sid
> system.  I know those compilers support 128-bit values because Rust =
uses
> them, but they are not exposed in standard C and therefore those
> compilers appear to be compliant when run in standards mode.

Ah, I should have said (un)(signed) __int128, there is no typedef for =
them even in GNU C.

__int128 exists as an integer type even with -std=3Dc99, not just
-std=3Dgnu99. -pedantic will warn that __int128 does not exist in ISO C,
but __int128__ still exists and works with no warnings even then. So it
very much exists in standards mode.

>> uintmax_t is supposed to be an unsigned integer type capable of
>> representing any value of any unsigned integer type, so if you have
>> 128-bit unsigned integer, your uintmax_t should be at last that
>> wide, or your uintmax_t is not uintmax_t as far as C standard is
>> concerned, no?
>>=20
>> uintptr_t is an unsigned integer type that any valid pointer to void
>> can be converted to this type, then converted back to pointer to
>> void, and the result will compare equal to the original pointer.  So
>> the value of uintptr_t cannot be represented by uintmax_t, there is
>> something wrong.
>=20
> Yes, this is the case.  The C standard mandates this behavior.
>=20
> Now, as far as I'm aware, the standard does not mandate that that
> uintmax_t have the strictest alignment requirements of any integral
> type.  It could be that other types have stricter requirements, for
> example, on some systems.  But it is required that conversion from =
void *
> to uintptr_t to uintmax_t to uintptr_t to void * preserve the
> functionality of the pointer.

To quote what I said to Junio in a futher reply:

> If you want to get really language-lawyer-y about it, you can actually
> argue that this is a compliant implementation of the C standard.
> Integer types are permitted to have padding bits, and some =
combinations
> of padding bits are allowed to be trap representations. Technically, =
in
> our representation, the metadata bits are padding bits, because they =
do
> not contribute to the precision like value bits. It is therefore the
> case that the *value* of a uintptr_t still fits into a uintmax_t, but
> the latter has no padding bits, and casting the latter to the former
> yields a trap representation when further cast back to a pointer. This
> may not the intent of the spec, and not how anyone thinks of it =
because
> CHERI is the first implementation that pushes the boundary here, but
> it=E2=80=99s technically legal under that interpretation. You may =
disagree with
> the interpretation, and I don=E2=80=99t like to use it most of the =
time because
> it=E2=80=99s complicated and involves yet more ill-defined parts of =
the spec
> (e.g. it says arithmetic operations on valid values (they mean =
objects,
> I assume, as the value only includes value bits, but the input could =
be
> a trap representation on some implementations) never generate a trap
> representation other than as part of an exceptional condition such as
> an overflow, but nowhere defines what counts as an arithmetic
> operation).


So, no, C does not actually require what you say. It requires that void
* -> uintptr_t -> void * give you a valid pointer. It requires that
uintptr_t -> uintmax_t preserves the *value* of the uintptr_t, which we
do, because the value is formed from only the value bits which
contribute to the precision, which is 64 bits in this case, and
uintmax_t is still 64-bit. It requires that uintmax_t -> uintptr_t,
since uintptr_t=E2=80=99s precision is the same as uintmax_t=E2=80=99s, =
be always
valid, which is is. But it does not require that that uintptr_t has the
same representation as the original uintptr_t, which it does not for
us. And therefore it does not require that casting that uintptr_t back
to a void * yields a valid pointer. So if you want to really dig into
the details of the standard, we are technically compliant, even if some
might argue it=E2=80=99s not in the spirit of the standard.

Jess

