Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5520329
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmIgvNGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93260C433CA;
	Thu,  9 Nov 2023 15:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699543586;
	bh=zqBezW53qOwXUGYOilQ/97/l10VBBf0LRJsscfnMNHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmIgvNGkynh3n/Jfk/l1Hdn5e2jvJlW4dDiclyZKz0pLSFkBaVPeSfEHEYvuxIqAU
	 nX27x8sen9tlouLMMCGasJ0YnDv+/q3LF+KBEd80D7iscstOO6iRVAEbhmKZawMmdB
	 sji7zlWac5kHV/g1jg7p6Ez9Z57vKI19mXYOwbSSDbBw5KXdp80GcOoc8PCQnStOok
	 TNeHCRPkqT5pctzyBtbnbbL+HZQkpfKa2KHctSXT/WmHF3zETOxWukxhzwN1M3AteN
	 OIVL+q19+EXoO1705Mp4JhaFQfWtmec8adG+Mszx6ApjkzpcloDNC0HmzeL7SmIjOt
	 O3d0zpMj8t21Q==
Date: Thu, 9 Nov 2023 16:26:23 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <ZUz6H3IqRc1YGPZM@debian>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
 <ZUqDwnmu9d1dD1tb@devuan>
 <20231107201655.GA507701@coredump.intra.peff.net>
 <ZUv3gjjmuqvCaJEd@debian>
 <20231108212702.GA1586965@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DDkGyusSfGKW9KrZ"
Content-Disposition: inline
In-Reply-To: <20231108212702.GA1586965@coredump.intra.peff.net>


--DDkGyusSfGKW9KrZ
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 9 Nov 2023 16:26:23 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)

Hi Jeff,

On Wed, Nov 08, 2023 at 04:27:02PM -0500, Jeff King wrote:
> > > # spool the message to a fake mbox; we need to add
> > > # a "From" line to make it look legit
> > > trap 'rm -f to-send' 0 &&
> > > {
> > >   echo "From whatever Mon Sep 17 00:00:00 2001" &&
> > >   cat
> > > } >to-send &&
> >=20
> > Would a named pipe work?  Or maybe we could use $(mktemp)?
>=20
> I suspect mutt wants it to be a real file. But yeah, mktemp would
> definitely work. I actually started to write it that way but switched to
> a static name for simplicity in demonstrating the idea. :)
>=20
> One note, though. Later we need to pass this filename to mutt config:
>=20
> > > mutt -p \
> > >   -e 'set postponed=3Dto-send' \
>=20
> so it's a potential worry if "mktemp" might use a path with spaces or
> funny characters (e.g., from $TMPDIR). Probably not much of a problem in
> practice, though.
>=20
> > Huh, this is magic sauce!  Works perfect for what I need.  This would
> > need to be packaged to the masses.  :-)
> >=20
> > I found a minor problem: If I ctrl+C within mutt(1), I expect it to
> > cancel the last action, but this script intercepts the signal and exits.
> > We would probably need to ignore SIGINT from mutt-as-mta.
>=20
> Yeah, that might make sense, and can be done with trap.

I've tried something even simpler:

---8<---
#!/bin/sh

mutt -H -;
--->8---

I used it for sending a couple of patches to linux-man@, and it seems to
work.  I don't have much experience with mutt, so maybe I'm missing some
corner cases.  Do you expect it to not work for some case?  Otherwise,
we might have a winner.  :)

>=20
> > Would you mind adding this as part of git?  Or should we suggest the
> > mutt project adding this script?
>=20
> IMHO it is a little too weird and user-specific to really make sense in
> either project. It's really glue-ing together two systems. And as it's
> not something I use myself, I don't plan it moving it further along. But
> you are welcome to take what I wrote and do what you will with it,
> including submitting it to mutt.

I'll start by creating a git repository in my own server, and will write
something about it to let the public know about it.  I'll also start
requiring contributors to linux-man@ to sign their patches, and
recommend them using this if they use mutt(1).

Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--DDkGyusSfGKW9KrZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmVM+h8ACgkQnowa+77/
2zIKUA/+PJxIHs8zogo66J54cquUjQTVnwVf/kpb23JkLZMoRd6o2zQpooZoyOoE
QFRQyE0XzzZlFIV9s789HPvir78YDeUUraXNE4AZStDUl+4reCoaMmKHkprLDmJQ
O354BhjBPZGk8B2xUxz2Zn4hiBx8PRZrFY6t6VBxiUi6/8aq570hRtXhwFhfnuPs
y9fnfMPL6o5oWATgfHdsVQMozXUXyUnCO5rDACCrT4Lb6kEZs3KXJK57ipnBFRHJ
FZBiC4yAKwMCyjSaaHN6X66GnCw70RxI+4IljX8557hIoZYp7xLT9sMG6qP5BU04
DlzgewUcWKPKZNO4dHwTQbrEga7sZjpt1NlEEfznoL/jnWQYR/gwTbu9uWpxvxXs
abE6zIHTqmozNzee82E7PUtKLV1KpY0+DbbGeTyp2P64nAsXE7xfSy0Tf1yPyVsk
txWJ0gLatjqjz52xCk1yMraiE8ngq1i3r7UJhKQeiYAoSzsSOZUeGeqnPdVygxDZ
gieLnkZ1NO5fr5kncL/40Q1+S4efhJ2PGuhQD5feW+afhR9qK0jeHDFyuCMWL+tG
LloUdGk0XMUo9IiNzkw8UZoOucLvpENiEUYP+6nUtc3aPZEppqvPpX6I0G3K91Yh
ApXYPltz2iYTJdYf2CVSdKt7HMWHdh2PsHRWeOuq3cKqBpQlaW4=
=PDmD
-----END PGP SIGNATURE-----

--DDkGyusSfGKW9KrZ--
