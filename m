Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10085C433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E7464E9A
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhBHXoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 18:44:02 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44384 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230071AbhBHXns (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Feb 2021 18:43:48 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3D2BC60B19;
        Mon,  8 Feb 2021 23:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1612827786;
        bh=tQPDnp13Asvt9kqmCFfiMVxYUALlNrIBnuXkoFSAOpU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=x6nGlv8ptoFxC+FaSQ8oRkGfSEQMvT1Gyyb45p0nMbkJmaGUkKYBPtM6ZzTDmiGgn
         bvhOm0mGkjbBpY4ohUs/tTO60tYfaGTb8/TnoIgKropKFJ59+kRSa3a1mxruqFURUa
         DbTEexIl4w/FxLibvNrOyqxUCH2gBGvSCXdWsnPXuG22yzadsZIaYvvYrasfH2A2N7
         lrIfwgqyxFYSjnKjzgLdsgtoo/oCMYhhcLb2lqbvl9q4KncmwK3dh3AE+JzTCmnysD
         lK3ASaoP+fWonx8vzcNZO7x870tlHV1Jtxb/mlxzaTSm/dgikLEn8aSQt0mZLplrWb
         gxXAvVTsZgsmOiDhXxSW0yfwRGMydHaxwUsYQ+mdapP08zJWHj1AT1ZblD72ZIwDan
         /L8bKUZUJmp24osyYXWaLF/IqOas9+UV9zYHMaIDWjqgxb7V4D67g1WEcNAOQADTI8
         tuncobrlYRptyvTxNLLSRuPvYnlzrcbdb28OixbqNp/21Gfr8Bz
Date:   Mon, 8 Feb 2021 23:43:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom verma <hariom18599@gmail.com>,
        Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 3/3] ref-filter: use pretty.c logic for trailers
Message-ID: <YCHMhYLuFYZBWjQM@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
 <47d89f872314cad6dc6010ff3c8ade43a70bc540.1612602945.git.gitgitgadget@gmail.com>
 <xmqqpn1c8m7u.fsf@gitster.c.googlers.com>
 <CA+CkUQ9-OCiEkMDRTpyF3rp-g1mSSzn4s9MgqJZ2BJY=XJCoEw@mail.gmail.com>
 <xmqqh7mn91w2.fsf@gitster.c.googlers.com>
 <CA+CkUQ9kHhbDVMru=pRO90o+k7cc_ykxN9JRFGMvoG3hkeGJpA@mail.gmail.com>
 <xmqqlfbz7i7i.fsf@gitster.c.googlers.com>
 <CA+CkUQ_cdUmuP+_yUeCytn=6cc8SjMBE1aTLzWJL-U_V01uzog@mail.gmail.com>
 <xmqqv9b25s7f.fsf@gitster.c.googlers.com>
 <xmqqlfby5o9h.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zuqa7doNUBIYkQp+"
Content-Disposition: inline
In-Reply-To: <xmqqlfby5o9h.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Zuqa7doNUBIYkQp+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-08 at 19:54:18, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > By the way, when merged to 'seen' (you can try the above that shows
> > %(subject) followed by %(trailers) with the tip of 'seen'), it dies
> > like this:
> >
> >     $ git for-each-ref \
> > 	--format=3D"%(subject)%0a%(trailers:key=3DSigned-off-by:)" \
> > 	refs/heads/js/range-diff-wo-dotdot
> >     free(): double free detected in tcache 2
> >     Aborted
> >
> > There must be some interaction with another topic but I didn't dig
> > deeper.
>=20
> It seems brian's bc/signed-objects-with-both-hashes topic alone has
> the double-free issue, without the "trailers" topic.
>=20
>     $ git checkout --detach bc/signed-objects-with-both-hashes
>     $ make git
>     $ ./git for-each-ref --format=3D'%(subject)%(body)' refs/heads/maint
>     free(): double free detected in tcache 2
>     Aborted
>=20
> So for now, you do not have to worry about it in your topic.  Of
> course, you are very much welcome to help debugging and fixing it
> ;-)

I'll take a look.  Thanks for the heads up.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--Zuqa7doNUBIYkQp+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYCHMhQAKCRB8DEliiIei
gRSOAQDuakq723WitB3RKdurpVZBhRwbeSs130IJvYdjjx3kfgD9E4YZCaCB4+ps
SIqH/ud+7JHvyIm9JQteKke/VcZilwM=
=QIvZ
-----END PGP SIGNATURE-----

--Zuqa7doNUBIYkQp+--
