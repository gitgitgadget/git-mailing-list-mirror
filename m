Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D4C19BB6
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyf9ZgHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F30CC433C8;
	Fri, 10 Nov 2023 13:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699623052;
	bh=2y/MLLlFtrWCnuC6U8tA4TgX5YkdlerQehcWAr4Iid4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyf9ZgHSgXyPQu+uTQKlyhaSzdsk485Ck1AWYCy5sCRpQsAeNqebCHfY6ukfZICLg
	 zSmU8wLBMuhDMFJgFXvA6XF8eHnEl8Vsni604zvFKJKRwlaoKjAMRh43E3tkjLtqCx
	 TO1ew/ZZBHQ+UgG0cY9Eb8KBbrYOSbulzsrYQ9xu+q5JAD6NMWE34XbY2IpwUtSYDT
	 pwRXJ9C4Br1oK7WfxhWwDAyHk5ZllySYTKGUe/VD329TXYFO43uRUtF5TTE2ZfTx8t
	 bjG2PhvxB7f1VWUisRxAiOdwiXyr/dPfheh6SNY5336euSqdcboZ+2h1M1GJ64jlJg
	 Jxo68olQx5crw==
Date: Fri, 10 Nov 2023 14:30:49 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <ZU4widBlHljjg9lL@debian>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
 <ZUqDwnmu9d1dD1tb@devuan>
 <20231107201655.GA507701@coredump.intra.peff.net>
 <ZUv3gjjmuqvCaJEd@debian>
 <20231108212702.GA1586965@coredump.intra.peff.net>
 <ZUz6H3IqRc1YGPZM@debian>
 <20231109180308.GA2711684@coredump.intra.peff.net>
 <ZU1-l4PwMU5H4_VN@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HnNnXcu8fVk243W4"
Content-Disposition: inline
In-Reply-To: <ZU1-l4PwMU5H4_VN@debian>


--HnNnXcu8fVk243W4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Nov 2023 14:30:49 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)

On Fri, Nov 10, 2023 at 01:51:34AM +0100, Alejandro Colomar wrote:
> Hi Jeff,
>=20
> On Thu, Nov 09, 2023 at 01:03:08PM -0500, Jeff King wrote:
> > On Thu, Nov 09, 2023 at 04:26:23PM +0100, Alejandro Colomar wrote:
> >=20
> > > I've tried something even simpler:
> > >=20
> > > ---8<---
> > > #!/bin/sh
> > >=20
> > > mutt -H -;
> > > --->8---
> > >=20
> > > I used it for sending a couple of patches to linux-man@, and it seems=
 to
> > > work.  I don't have much experience with mutt, so maybe I'm missing s=
ome
> > > corner cases.  Do you expect it to not work for some case?  Otherwise,
> > > we might have a winner.  :)
> >=20
> > Wow, I don't know how I missed that when I read the manual. That was
> > exactly the feature I was thinking that mutt would need. ;)
> >=20
> > So yeah, that is obviously better than the "postponed" hackery I showed.
> > I notice that "-H" even causes mutt to ignore "-i" (a sendmail flag that
> > Git adds to sendemail.sendmailcmd). So you can just invoke it directly
> > from your config like:
> >=20
> >   git config sendemail.sendmailcmd "mutt -H -"
>=20
> Having it directly in sendmailcmd causes some glitch: It repeats all CCs
> in TO.  See a log:
>=20
> 	Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
> 	OK. Log says:
> 	Sendmail: mutt -H - -i kevin@8t8.us mutt-dev@mutt.org alx@kernel.org e.s=
ovetkin@gmail.com neomutt-devel@neomutt.org
> 	From: Alejandro Colomar <alx@kernel.org>
> 	To: Kevin McCarthy <kevin@8t8.us>,
> 		mutt-dev@mutt.org
> 	Cc: Alejandro Colomar <alx@kernel.org>,
> 		Jenya Sovetkin <e.sovetkin@gmail.com>,
> 		neomutt-devel@neomutt.org
> 	Subject: [PATCH] send.c: Allow crypto operations in batch and mailx mode=
s.
> 	Date: Fri, 10 Nov 2023 01:41:24 +0100
> 	Message-ID: <20231110004128.5972-2-alx@kernel.org>
> 	X-Mailer: git-send-email 2.42.0
> 	MIME-Version: 1.0
> 	Content-Transfer-Encoding: 8bit
>=20
> 	Result: OK
>=20
> The sent mail ended up being
>=20
> 	From: Alejandro Colomar <alx@kernel.org>
> 	To: Kevin McCarthy <kevin@8t8.us>, mutt-dev@mutt.org, alx@kernel.org,
> 		e.sovetkin@gmail.com, neomutt-devel@neomutt.org
> 	Cc: Alejandro Colomar <alx@kernel.org>,
> 		Jenya Sovetkin <e.sovetkin@gmail.com>, neomutt-devel@neomutt.org
>=20
> So maybe we need the wrapper script to ignore the arguments.

Heh!  The following trick works as well, without needing a script:

[sendemail]
	sendmailcmd =3D mutt -H - && true

It probably relies too much on git-send-email(1)'s current
implementation, but it works.  :)

Cheers,
Alex

>=20
> Cheers,
> Alex
>=20
> >=20
> > Annoyingly, "-E" doesn't work when reading over stdin (I guess mutt
> > isn't willing to re-open the tty itself). But if you're happy with not
> > editing as they go through, then "-H" is then that's enough (in my
> > workflow, I do the final proofread via mutt).
> >=20
> > -Peff
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--HnNnXcu8fVk243W4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmVOMIkACgkQnowa+77/
2zLHAhAAk0VnLHsoV0eifSymtSJtB24/KG345daPwLygaCi71J0mazSImbUkZpLR
ueetYQ7+HYz2ZPb+s8GqcI0rtvihlkLlVGHzaIFCq6OsCzyEpcANF86gxwidg/c9
9t/qnPnR9JBRwxpitxvy63RlGNveNgKX0idejw6Gk/OZRiLV5db6pqaH13xGMma6
f8V8nVE0GJpNx9fAEpK3CFh++ksa5UJmMgxtLE3JsHHiDLeeuez2xb7AXtgGIay7
AtfUf/9bPoIJM2GwXC5dzd4Iv8W4pq2AzatevArUaqcneHdQSsKWfhVxXYMascFg
Z/18+Q05SIQEiSTbKqAPT5ha0CpWUIuNMw65ToJwVB1OnRRGlrxY4Exjs7S3cRvQ
lAGslwmV4FDsCz1PRs7eDCB4LG2kFcZIwOjg7onlkdVnfOgpj7yJs6htfXqV4oDW
6Ou/L4GrJeVUZ5ioZ5HvV7+Tb3SSrop/fX4K3e91meeOhtJ0hJRHIoI8zBO+yuMb
kAAM267BugUdL9D1/7X0BsM10j0o8bQiTo5x5akJfP8hq9Am29/gfPvZyqJc2jrS
DjvBFrNef0QbuiT8pfBi89dcCpmjso7YRk4WhOmbDbbY9o3pafejV7ijvGAfDlZ7
Y9vAOAAJUNLqFc2/lEJiQI7bSygs+prx+/WwtbX0Iz6AgqUqcvI=
=3pBd
-----END PGP SIGNATURE-----

--HnNnXcu8fVk243W4--
