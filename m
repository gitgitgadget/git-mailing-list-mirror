Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188793E476
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BcfKDU+Z"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720AEBB
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 14:58:54 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9AA795B07A;
	Thu, 12 Oct 2023 21:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1697147933;
	bh=MHA8CcHzC3yD7VO4VAoyFJxx63dUI5oh+XoDSxRodwQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=BcfKDU+ZLtB6DsQYeQtCAyYRb4sTlgMeHOMhB2fmzilehZDNuN/+Ss/amieIFd7sg
	 QSiqGV0T3KiHSQagTlNrmf/NWe/WPAJty1cfDZ06rw/eRNAiyfSWqnR5D4rDKCn+yb
	 LrHdDa+b4MJTfXPpQ240nnuJQIWnuIbIoFCodZJeP2sJcn7FwTbr43S46aSoqclidU
	 n1ycPAOULfemhZJyx4Ie4iOUci9FQiKy+DXVYb32lzgy3S2CqJEfmEUIqVF1b/4rDu
	 NJpD7WxtBrffB32zHRErdcad2Y7UyDNOqOhqk2b3EYFA09V57F2l6mztLbcbureIZT
	 tQ3Dx9/Ocq6tnUGLBhFwR0sbxSgNUp9n+mGobLZrNRdUtf//4JokZhxXIo1tVp9MBQ
	 Db9u7ecgblThzgF/bfx7iFwPQ6kQwCg2Cn+iuWK7xpZ52LHKlYKwr7tg5HPNgcAJ7A
	 FsE7cSPYOU4Z16sbqOPr/+fxjXvaMvaF/NXoW+girYsJFt4IQZU
Date: Thu, 12 Oct 2023 21:58:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Jason Hatton <jhatton@globalfinishing.com>
Subject: Re: [PATCH v2 2/2] Prevent git from rehashing 4GiB files
Message-ID: <ZShsG1SKfrefsCtu@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>,
	Jason Hatton <jhatton@globalfinishing.com>
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
 <20231012160930.330618-3-sandals@crustytoothpaste.net>
 <xmqqpm1jn2nh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MkaNlvuUJr9cyEkg"
Content-Disposition: inline
In-Reply-To: <xmqqpm1jn2nh.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--MkaNlvuUJr9cyEkg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-12 at 17:58:42, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > An example would be to have a 2^32 sized file in the index of
> > patched git. Patched git would save the file as 2^31 in the cache.
> > An unpatched git would very much see the file has changed in size
> > and force it to rehash the file, which is safe.
>=20
> The reason why this is "safe" is because an older Git will would
> keep rehashing whether 2^31 or 0 is stored as its sd_size, so the
> change is not making things worse?  With older git, "git diff-files"
> will report that such a file is not up to date, and then the user
> will refresh the index, which will store 0 as its sd_file, so
> tentatively "git status" may give a wrong information, but we
> probalby do not care?  Is that how the reasoning goes?

Correct.  An older Git will rehash it either way, on every git status.
If you run git diff-files on an older Git, it will always show it as
modified (hence why I used that in the tests).  The git status will
rehash it and then realize that it isn't modified, not printing any
changes, so the behaviour is not wrong, it's just extremely slow (SHA-1
DC on 4 GiB of data).

If you use a new Git with an old index, git status will still rehash it
the first time and correctly determine that it isn't changed, then write
the 0x80000000 to the index.  It just won't rehash it on subsequent
calls to git status.

The only incorrect behaviour (assuming that slow is not incorrect) that
I'm aware of on older Git is that git diff-files marks it as modified
when it's not.  There is no incorrect behaviour on a fixed Git.

> > +/*
> > + * Munge st_size into an unsigned int.
> > + */
> > +static unsigned int munge_st_size(off_t st_size) {
> > +	unsigned int sd_size =3D st_size;
> > +
> > +	/*
> > +	 * If the file is an exact multiple of 4 GiB, modify the value so it
> > +	 * doesn't get marked as racily clean (zero).
> > +	 */
> > +	if (!sd_size && st_size)
> > +		return 0x80000000;
> > +	else
> > +		return sd_size;
> > +}
>=20
> This assumes typeof(sd_size) aka "unsigned int" is always 32-bit,
> which does not sound reasonable.  Reference to 4GiB, 2^32 and 2^31
> in the code and the proposed commit log message need to be qualified
> with "on a platform whose uint is 32-bit" or something, or better
> yet, phrased in a way that is agnostic to the integer size.  At
> the very least, the hardcoded 0x80000000 needs to be rethought, I
> am afraid.

unsigned int is 32-bit on every modern 32- or 64-bit platform known to
exist today.  I don't believe we support MS-DOS or systems of its era,
nor should we support 8- or 16-bit systems.  If you'd prefer "uint32_t",
I can do that.

Note that the problem is reproducible on a stock Ubuntu amd64 system, so
it is definitely a problem on all modern systems.

> Other than that, the workaround for the racy-git avoidance code does
> sound good.  I actually wonder if we should always use 1 regardless
> of integer size.

I think using 2^31 is better because it's far away from very small
values and very large values, which means that it's a hard to modify a
file which used to have its value as a multiple of 4 GiB and
accidentally make Git think it was unchanged.  Using 1 would make a
simple "echo > foo" possibly think things were unchanged in some cases,
which we should avoid.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--MkaNlvuUJr9cyEkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZShsGwAKCRB8DEliiIei
gQtAAQDO/KH7U5gRWl4aGuJ4H9y3QaWNSdzmp23fkr1zbdf1CAEAtAFulR8xJ7V/
KPrKGDprw7rS2y3g4o0mBh+dh2AN4A4=
=F5Pz
-----END PGP SIGNATURE-----

--MkaNlvuUJr9cyEkg--
