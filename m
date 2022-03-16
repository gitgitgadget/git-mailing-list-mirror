Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD20C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 21:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357499AbiCPVlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 17:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358150AbiCPVld (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 17:41:33 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389AC39140
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 14:40:18 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 25E0B5A0CA;
        Wed, 16 Mar 2022 21:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1647466817;
        bh=yC5+r9uGhOTFSu4rk5/yOmRlTdeWvJWpS3RntnJqvks=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WWNA+nQhQdiRp379h6d6xLOMwVLPiOkXGYd9NCRMC8YXX/lPUCjd8QNpxDYeG8AE2
         oWvlUjcnMF3+N18H89Jq4yygRRpMTEAx681h51Mb0bOH/YPRkyuL/VLYsofI9dRp/t
         w53WbFeapmh6Fq7od9ff9qeE9T1xkWFQ6HOIVnB4jT1LipqoOOLKH1owo+v2New2Bw
         umG+ObdML4PUZGnDrE1fIcSKHynyGTluwMI+TF2KV9sBtGcUkoOdws9JpvGuRW5OUL
         yQH6czhUQF39GPi284UT9+mwN7rb0TFnAqrOX0MeidOlTPP2w5RTfDmtVS1A6zZpzq
         4eAgbwl0EfK/8EE4Mz3O4xu8LpAnw7Vdj75bvx7AgMs9v/7VCUu016PmnDNVZ/hx4F
         c98ieJ5oIPyX46kqD0FDV9ZxhXUMHFEf01pp3NNmJ4RXvlrG7HSWtIyf2/qzkpl6/Q
         2DkKh0XOYdkN0zrlwA0PFX7gemqgz3BlnU1UtTebGqpEOk2J3Oy
Date:   Wed, 16 Mar 2022 21:40:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 3/6] object-name: make get_oid quietly return an error
Message-ID: <YjJZPsxP1OwKtzXj@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220310173236.4165310-4-sandals@crustytoothpaste.net>
 <xmqqo825n8eh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cIoMv/1IQDqjYcGm"
Content-Disposition: inline
In-Reply-To: <xmqqo825n8eh.fsf@gitster.g>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cIoMv/1IQDqjYcGm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-16 at 16:56:22, Junio C Hamano wrote:
> > diff --git a/object-name.c b/object-name.c
> > index 92862eeb1a..daa3ef77ef 100644
> > --- a/object-name.c
> > +++ b/object-name.c
> > @@ -911,13 +911,17 @@ static int get_oid_basic(struct repository *r, co=
nst char *str, int len,
> >  						len, str,
> >  						show_date(co_time, co_tz, DATE_MODE(RFC2822)));
> >  				}
> > -			} else {
> > +			} else if (!(flags & GET_OID_RETURN_FAILURE)) {
> >  				if (flags & GET_OID_QUIETLY) {
> >  					exit(128);
> >  				}
> >  				die(_("log for '%.*s' only has %d entries"),
> >  				    len, str, co_cnt);
> >  			}
> > +			if (flags & GET_OID_RETURN_FAILURE) {
> > +				free(real_ref);
> > +				return -1;
> > +			}
> >  		}
>=20
> So, without the new bit, we used to die loudly or quietly.  The new
> bit allows us to return an error to the caller without dying
> ourselves.
>=20
> You can call the bit _RETURN_ERROR and not to worry about the
> right-alignment above ;-), but better yet, how about calling it
> _GENTLY, which is how we call such a variant of behaviour?

Sure, that works.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--cIoMv/1IQDqjYcGm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYjJZPQAKCRB8DEliiIei
gWukAQD4ztZvMmE89+dsRzJd+R+UiC4ngmggR1za52w9BEIDeQD/XpoO1INZhZFg
bvqe4nmRatUmdqqkGBG66AUECY4TAQ8=
=C0nx
-----END PGP SIGNATURE-----

--cIoMv/1IQDqjYcGm--
