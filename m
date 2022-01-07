Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51F0C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 01:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbiAGBoB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 20:44:01 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:60176 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345224AbiAGBn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 20:43:59 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0E41F5B236;
        Fri,  7 Jan 2022 01:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641519838;
        bh=QC+oE5DfsUQ+Qkyr1VGbRrHC0uqpIjjnRNA78kp2DQw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zI5EScgJyAWbEn81H69ausWXTQTAI+zUcenQK2Lu8vv76gCOX/ajMGC6kmuWPACY9
         2YPF8vbEGvkY9n2x0Ju9me/CrNnCbl1OlbSWqnW/0ICKOljaTrBdaj9NAcRIJpnVDG
         HBRfDI1+I2pa2I4XALssUk0UMGHMnPyG9hcQeoVgmVa+J9+O0ncRALCDI0r5mxH83I
         FWM6GOokQhXB5XnXxQyGRSQuI9/CitjCvSJl/8pTH3KNO/sax/OHSxo3/T8tOvub4D
         23fSRe843E2PCCirfg5GZrYylJhMkhtw8rx48Q5KFurnYMTUiEH9X4Aj9XW2ieDvg5
         mCghImY11sq+/iVlj2a8uImrz4pUOorcSrMgx/53U0yTkc4CacjTMjCEK0cA/lSSwc
         P51RAjUBBM4H/tNvFhtGz7oJGaAqkGaYvoADMheuX9JmFfUuh2UKGM11ut+v+qC2Cu
         uKTyvmlAmosvhsHmMYXdBQpAXkn/Rc3UGiG3D5jxRVRAO+nMLJF
Date:   Fri, 7 Jan 2022 01:43:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
Message-ID: <Ydea3EO7wrYc9/Ij@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <YddjJ+uIQM34Gedo@nand.local>
 <xmqqh7agbiuq.fsf@gitster.g>
 <97D2AB55-0F8F-4C38-A5C6-1AAA43EA064A@jrtc27.com>
 <xmqqfsq09ziq.fsf@gitster.g>
 <YdeJ8Ub2Q0/c9kO2@camp.crustytoothpaste.net>
 <4D8B32AE-8316-4907-98F6-097901EC3DC0@jrtc27.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KLd/UTi74K9AopT9"
Content-Disposition: inline
In-Reply-To: <4D8B32AE-8316-4907-98F6-097901EC3DC0@jrtc27.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KLd/UTi74K9AopT9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-07 at 00:39:59, Jessica Clarke wrote:
> On 7 Jan 2022, at 00:31, brian m. carlson <sandals@crustytoothpaste.net> =
wrote:
> > If you want to get really language-lawyer-y about it, you can actually
> > argue that this is a compliant implementation of the C standard.
> > Integer types are permitted to have padding bits, and some combinations
> > of padding bits are allowed to be trap representations. Technically, in
> > our representation, the metadata bits are padding bits, because they do
> > not contribute to the precision like value bits. It is therefore the
> > case that the *value* of a uintptr_t still fits into a uintmax_t, but
> > the latter has no padding bits, and casting the latter to the former
> > yields a trap representation when further cast back to a pointer. This
> > may not the intent of the spec, and not how anyone thinks of it because
> > CHERI is the first implementation that pushes the boundary here, but
> > it=E2=80=99s technically legal under that interpretation. You may disag=
ree with
> > the interpretation, and I don=E2=80=99t like to use it most of the time=
 because
> > it=E2=80=99s complicated and involves yet more ill-defined parts of the=
 spec
> > (e.g. it says arithmetic operations on valid values (they mean objects,
> > I assume, as the value only includes value bits, but the input could be
> > a trap representation on some implementations) never generate a trap
> > representation other than as part of an exceptional condition such as
> > an overflow, but nowhere defines what counts as an arithmetic
> > operation).
>=20
>=20
> So, no, C does not actually require what you say. It requires that void
> * -> uintptr_t -> void * give you a valid pointer. It requires that
> uintptr_t -> uintmax_t preserves the *value* of the uintptr_t, which we
> do, because the value is formed from only the value bits which
> contribute to the precision, which is 64 bits in this case, and
> uintmax_t is still 64-bit. It requires that uintmax_t -> uintptr_t,
> since uintptr_t=E2=80=99s precision is the same as uintmax_t=E2=80=99s, b=
e always
> valid, which is is. But it does not require that that uintptr_t has the
> same representation as the original uintptr_t, which it does not for
> us. And therefore it does not require that casting that uintptr_t back
> to a void * yields a valid pointer. So if you want to really dig into
> the details of the standard, we are technically compliant, even if some
> might argue it=E2=80=99s not in the spirit of the standard.

Sure, implementations are allowed to have padding bits.  They're also
allowed, at the moment, to use signed-magnitude or ones' complement
integers, have CHAR_BIT greater than 8, have sizeof(char) =3D=3D
sizeof(short), not implement any of the customary sizes of intN_t or
uintN_t, not provide uintptr_t, and use middle-endian numbers.

However, if your ABI is only compliant in the face of those features
(especially when it could have been written in a way which would have
been compliant without the use of those features), it's intentionally
hostile to real-world developers, and I don't think we should support
it[0].  I'd be willing to revisit this if your ABI were defined in a
reasonable, sane way, where sizeof(uintmax_t) >=3D sizeof(uintptr_t),
without padding bits, where the alignment of pointers from malloc is
suitable for all types, and where the alignment of a type is no greater
than sizeof(type).

I'm not opposed to a small amount of finagling for this case, but I am
very much opposed to defining your C ABI in an intentionally difficult
way.  128-bit integers in 64-bit Linux were not originally part of the C
ABIs and if the ABI is ill defined now, that's a historical accident.
But this is a new ABI for a new architecture and it could have been
defined in a responsible way, but wasn't.

As an aside, I was actually going to point out that you could propose a
nice Rust or Go ABI with the status quo, but if your C ABI requires
padding bits, then you're probably going to have a hard time doing so,
since I don't believe those languages support padding bits and they need
to support the C ABI.

[0] For the record, I care strongly about portability, and I would not
accept a runtime having any of the qualities I mentioned in the first
paragraph.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--KLd/UTi74K9AopT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYdea2wAKCRB8DEliiIei
gV7PAQC4CzH2X3Ai+8iQF87sF38yxkXvHLBQLdm1kk44mG/i4QEAlyeO9Y0582dj
ZxxksW9KFolDzJ2Cu3hOa6y2WjRoIQc=
=rBK8
-----END PGP SIGNATURE-----

--KLd/UTi74K9AopT9--
