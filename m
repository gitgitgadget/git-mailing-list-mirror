Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C88E1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 11:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfHIL0B (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 07:26:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57400 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbfHIL0B (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Aug 2019 07:26:01 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c831:5a62:6d5c:8da3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A4AFF60737;
        Fri,  9 Aug 2019 11:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565349958;
        bh=fPOAsdkQEe42I8wH1oj42WSXP8a/n4fZcGUwwnmyv34=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=H2lmEWbcCQgtEeZuIdvNpNcNb1d9osMTVQ2Usqvi6FResVkh4mua026XEVM2sR5WE
         R3jSOD/HZuS6Zs5YCp3gut44iv6ROk2lgz7LmFwbLIwt9Vuw6Fv5UAV1iZeeHll+4l
         EbxkGnU5cjiNFZccA+tyVSjAyqbn2sCKPYK/at8N4mXP3HGs3HJBlpqkay/NBnYD7V
         MZQ1G+tvgdrq73iwEHxjz6txRmRa2hzgm36TS7ejzNPCOY9CeXIVgcVDD7eLdHs7cG
         vXdWlW538Q5z0/PIHPT3eU/ec0tKrYcJpBT/KWGZHYsMrJaXnN5N+U5wd49UxKFQSn
         lZ+K7BekZrn6FgcuMUFqS78RoFGu+CqKhWJLRBuhCLpdz+KdK0VORSuP3cPQ5TyFBg
         H/B52dEJ2nOzvj48AdT4WgBkcSz34mgFNp04s1nR1JNRXIMl6jcVV09qlTEiePFuNe
         pt35hFdGkUEPyD+WhxfI2/G/EhvcHStp5FdLzWkK21CqdPA9Fe0
Date:   Fri, 9 Aug 2019 11:25:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: reload .gitattributes after patching it
Message-ID: <20190809112552.GM118825@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Stefan Beller <stefanbeller@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190809111452.GA93559@syl.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7a4X6VOqfbl9xMrG"
Content-Disposition: inline
In-Reply-To: <20190809111452.GA93559@syl.local>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7a4X6VOqfbl9xMrG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-09 at 11:14:52, Taylor Blau wrote:
> > diff --git a/apply.c b/apply.c
> > index cde95369bb..b959b88b8e 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -4643,6 +4643,7 @@ static int apply_patch(struct apply_state *state,
> >  	struct patch *list =3D NULL, **listp =3D &list;
> >  	int skipped_patch =3D 0;
> >  	int res =3D 0;
> > +	int flush_attributes =3D 0;
> >
> >  	state->patch_input_file =3D filename;
> >  	if (read_patch_file(&buf, fd) < 0)
> > @@ -4670,6 +4671,14 @@ static int apply_patch(struct apply_state *state,
> >  			patch_stats(state, patch);
> >  			*listp =3D patch;
> >  			listp =3D &patch->next;
> > +
> > +			if (!flush_attributes && patch->new_name) {
> > +				char *dummy =3D strip_path_suffix(patch->new_name, GITATTRIBUTES_F=
ILE);
>=20
> It's a shame that 'strip_path_suffix' doesn't take a 'char *out', and
> accept NULL for that (which would save us the assignment and subsequent
> 'free'). In either case, this is certainly the appropriate function.

Yeah, I felt the same way. We could refactor this out into two separate
functions, one which returns an ssize_t and one which actually
allocates, but I'm not sure it makes a huge amount of sense with just
one caller. The allocation is relatively small, and I've tried to make
sure it's called exactly once per patch so as not to be wasteful and
inefficient.

> But, I'm not sure if 'dummy' is the best name for this variable or not.
> My first thought was that I'd expect this to be named 'suffix' (or the
> less descriptive 'p'), but I don't know if the change is warranted.
> What *are* we supposed to call this variable?
> "path_after_gitattributes" ;-)?

I struggled with this variable name, as I'm sure you guessed. I could
call it "has_suffix" or something similar. I have mixed feelings about
naming pointer variables like booleans since it makes things prone to
misreading, but I think that might be the sanest thing to do here. I can
certainly do "p" as well.

I'll see if there are other comments about directions to take here, and
then reroll.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--7a4X6VOqfbl9xMrG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1NWEAACgkQv1NdgR9S
9ovVpA/+N3WsauJDf5zFZrtdLkakM2V/UmcILBISkuiBy+lrCoi4GZZegQFRtyIA
whpCAgXEHaMFRLh6W4+AGVdwX8CeuXOORw+LcS4TJu+Jm7v7HzRHWDemXsAxWJ4V
NTqCnTjg8QwcFw46/4iBsZlf6tpLH9W+S11trUt+dGZDQPH2kbNBydgvInUUXg0p
bfMjlU6pRKiVY5fggZK24nsj9aSvXFsKyeelyp0XtLV07vBmi4O/lhDIVuPcbUeY
kF73YGaOfiB2VHwPpgM9m/Mi/fA8ZHiR7YqU76e3efuwCw8BowPVMCFQPftYhURI
zJ0RN0d+0bIZgN+eiI9BH4juHlyg0RMnhppBWZoy9gO8qg4jXVbYLB5/3MgTIoqs
BZrrAX/zms8wUQV8yCZ2JjVLR0xOAEgmf1h+eckCb13lR9Br97lXgppsiBqGk7nr
tZiRb5/unuwsT27WukudgJ6hTX53dV3QG5xLAqwjuuPZjiZ2co7/8JFtarmZovFS
fgZBR6fC1/cqkmHeec68mVJVojVpfM3YhtBY+ki9H7Zxo3D//SL+Hu/hdk+hekIL
qWcAut7DLilt8Z22IeV/ep9nlgKdFD6iMahaubAGtHyu1DysdVNRaZ7/l8+LTd6t
P+j1r+CHq1DOn1D9Ll8pR16e7Ke+tlE4tgUy1TRSTYRo2gx4ojY=
=TTNt
-----END PGP SIGNATURE-----

--7a4X6VOqfbl9xMrG--
