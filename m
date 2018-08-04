Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F771F597
	for <e@80x24.org>; Sat,  4 Aug 2018 08:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeHDKoT (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 06:44:19 -0400
Received: from mail.nic.cz ([217.31.204.67]:44761 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeHDKoT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 06:44:19 -0400
Received: from localhost (unknown [37.221.248.236])
        by mail.nic.cz (Postfix) with ESMTPSA id E55F360852;
        Sat,  4 Aug 2018 10:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1533372262; bh=gptCE026I4Z0KaKECeQvynEK/Y+iSyFIYUUAfz61uNk=;
        h=Date:From:To;
        b=hUbjxTcpD4bnYI6oWK6rD+tl9ObBLGOuchUqRUaNFDM5HmFOEEPq8O5wja1shiuGo
         yaDslWp0e+g70drgXtnB9gzubYb478q1yOjhBdtBeHD2gqPKmhB0AnAc1ZF4NwDD3f
         eqiDIr763BNA7mYhRunb+f/HqfI0CtqpD+FprJFk=
Date:   Sat, 4 Aug 2018 10:43:46 +0200
From:   Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>
To:     Jeff King <peff@peff.net>
Cc:     Santiago Torres <santiago@nyu.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <20180804084346.fhte5wusbfb5baem@cynerd-laptop>
References: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
 <20180801001942.GC45452@genre.crustytoothpaste.net>
 <20180801002546.du52zkxjupzcw2p6@LykOS.localdomain>
 <20180803133630.32oxubwttealvhxk@work-pc>
 <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
 <20180803160634.GA19944@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s3nqi264eqj2j4lx"
Content-Disposition: inline
In-Reply-To: <20180803160634.GA19944@sigill.intra.peff.net>
User-Agent: NeoMutt/20180716
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--s3nqi264eqj2j4lx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2018 at 12:06:34PM -0400, Jeff King wrote:
> On Fri, Aug 03, 2018 at 11:43:44AM -0400, Santiago Torres wrote:
>=20
> > > This is not a deviation. GPG correctly recognizes difference between =
trusted,
> > > untrusted and unknown levels. git on the other hand does not. Well it=
 did until
> > > the commit a4cc18f29. That one removed GPG exit code propagation.
> >=20
> > Oh wow. Sorry my assumption parted from looking at the code back in the
> > day where this happens. I assumed git was quietly propagating the gpg
> > error code and took it from there.=20
> >=20
> > Now that I think about it though, verify tag can verify more than one
> > tag. I assume that this would make it difficult to propagate individual
> > errors in trusting. I honestly don't know what's the best way to modify
> > this behavior then.
>=20
> I think the only sensible thing is to err on the conservative side, and
> return non-zero if we saw _any_ invalid signature.
>=20
> I will note, though, that just checking the exit code of `verify-tag`
> isn't really that thorough. It shows that there was _a_ signature, but
> we don't know:
>=20
>   - if it was an identity the user would expect to be signing tags
>=20
>   - if it even matches the refname we used to find the tag
>=20
> So I'd argue that any real verification needs to either have a human in
> the loop, or implement a custom policy based on reading the full output.
>=20
> I know we (and you specifically Santiago) talked about this a while ago,
> and we ended up providing ways to get more information out of
> verify-tag, so that a tool could sit on top of that and implement more
> project-specific policy. I don't know offhand of any reusable tools that
> do so, though.

I think that it would be even legit to exit on first tag verification failu=
re. If
someone wants to really verify all tags then it can be done with simple for=
 loop.
git that way does not have to solve problem of error combination.

>   - if it was an identity the user would expect to be signing tags
That can be done just by using trust levels.

>   - if it even matches the refname we used to find the tag
Can you explain this more? You mean that string (such as v1.1) used to look=
up tag
object is not verified as part of that object?

OK I thing that it was enough of abstract concepts from me. Let me explain =
you
what am I trying to achieve. I am implementing feeds (in other words git
repositories with packages) and package sources verification for OpenWRT. We
(project Turris by CZ.NIC) are signing all our commits and all our tags. No=
w we
are using small script that is verifying our repositories just before we run
build. That is against keyring maintained on our server. I am trying to ext=
end
that to whole OpenWRT tree. That introduces problem of having a lot of keys=
 and a
lot of packages sharing same allowed keys. Fetching all allowed keys for ev=
ery
package from key servers is just slow because of that I have to share those
between packages. In general there are two options. First one is to have ca=
che of
already fetched keys in armor format. Second one is to have one keyring and=
 by
setting all keys explicitly as never trusted with package given exception.
Unfortunately first option can't be used because of one other request that =
is from
our team. We don't want to be forced to update list of allowed contributors=
 to our
projects every time we have new colleague. Solution we come up with is to h=
ave
central PGP key that signs our whole team and then verification is done by
allowing GPG to fetch additional keys with max-cert-depth 1. That brings me=
 to git
verify-commit/tag that won't exit with zero code when signature is not trus=
ted.

I have a solution for my problem (calling git verify-* twice and grep). Tha=
t is
not the point of this email nor this contribution. The point is that althou=
gh
GPG's behavior of exiting with 0 code when trust level is unknown is unexpe=
cted
but in the end understandable, git's behavior of exiting with 0 code even i=
f key
is explicitly untrusted is just counterintuitive. I think that few people a=
re
still going to get nasty surprise when I consider that this change was intr=
oduced
mid 2014 just after v2.4.0 and Ubuntu 14.04 lts (running even on part of our
infrastructure) still contains version 1.9.1 and in that release it was
acknowledging GPG exit code.

K.K.

--s3nqi264eqj2j4lx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERtcVoO0ODEM8v1lj2DvXMqwr2CgFAltlZz8ACgkQ2DvXMqwr
2CiwiBAAnx1GNR4ZtNv/azl3gehx6ljKX+285Cyk1RaQt975ZYeB9vOEW/gUX8nh
UXDUwdjayo4vMUePaVxlMUU934Rg+LxQfUDGWPwuuUepNwr7AupykkkM19UEQigk
Ey4FCLjj62wSp08XsLvOe6k+IkV6pBEs/PWMH2XjY5g4yTf4i34M3bOnmOdWAYv0
qcXFkCUiyNKGkbSnoN+XYw5p0rpn4vmJanov/BtZt4xFp6AqYBxIMFqvr5qHmdmE
Kg9rLYDOrY+Ocoe/EJ8inkM5TJtE9vT9HTmU6ZbfG8kxuHR99laEYpnCaz7Bmlzq
ZOrSF6UUcYW7hrXsfV7uUNld16XNcO3w93tPX0QAxUjNAjltQD2geWDvalJbqsFL
fkMcvHxaz+DvOxxxv0nL5JAdhfqyPmNgIOhj47XIwCFTTA6T3VEtLEEUXhAdlysE
rSEuP4E2r4RVoymFa7HLjcDijik6FvYfZV3rXj+gN27u8HYWby7CGOTFz7kDcP/y
B4384b5Xn6aS+lRxuQX5vs4riwlLr1RGGcEUNXXGQmlBZdLznTHxo7NSNqITYU9u
KsJZRBd/dEzHXWOlIKdYKxmJ4ezfenD/hfbZKKJYCCSL0AE5FojV8hCKAcOeKYXe
xmpAEBfPeGhJXYvimcozukdG+2qJpTlyH0AIzLDBAqKw8KdPU5I=
=0fjU
-----END PGP SIGNATURE-----

--s3nqi264eqj2j4lx--
