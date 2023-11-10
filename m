Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1AE627
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yr0endDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6500DC433C7;
	Fri, 10 Nov 2023 00:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699577498;
	bh=I0KIa/DvLzkq8vPV2OC6a1DLH+CbqGijB8sFkweXwx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yr0endDpMDjkxawVyeiXBmD+TBm7kUvjn11RWUzT/d/+3pPqcQdt/wcp5X3iecPHF
	 mmj59yIOYe5quGrJs1dLrKCKRYUVz6C55jTPYzdElQvhe4J1CyZ9M0GM1Fs6ILVCSE
	 nfTykHVBC3X+fw8XnaBqSfjTAi9aWdx1hpt2RsYBqHdnAsz0z0rgFzbMfp7QBQTZn9
	 Rd1cyEbk786J4N9UsOvYH/a4rw/HnT+B2UIXyfvb40zf66tsGJAPWhcnZZwsFuhLgA
	 87Kdd5vqC+jALARpTZ1Zq+7juJMeBagxLtZt3Z1wKx+m0fL+i+x18ZoRbC1L/elsJ4
	 enoGfLyLWUBmA==
Date: Fri, 10 Nov 2023 01:51:34 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <ZU1-l4PwMU5H4_VN@debian>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
 <ZUqDwnmu9d1dD1tb@devuan>
 <20231107201655.GA507701@coredump.intra.peff.net>
 <ZUv3gjjmuqvCaJEd@debian>
 <20231108212702.GA1586965@coredump.intra.peff.net>
 <ZUz6H3IqRc1YGPZM@debian>
 <20231109180308.GA2711684@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B/dlxDbQ0JnLLCsx"
Content-Disposition: inline
In-Reply-To: <20231109180308.GA2711684@coredump.intra.peff.net>


--B/dlxDbQ0JnLLCsx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Nov 2023 01:51:34 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)

Hi Jeff,

On Thu, Nov 09, 2023 at 01:03:08PM -0500, Jeff King wrote:
> On Thu, Nov 09, 2023 at 04:26:23PM +0100, Alejandro Colomar wrote:
>=20
> > I've tried something even simpler:
> >=20
> > ---8<---
> > #!/bin/sh
> >=20
> > mutt -H -;
> > --->8---
> >=20
> > I used it for sending a couple of patches to linux-man@, and it seems to
> > work.  I don't have much experience with mutt, so maybe I'm missing some
> > corner cases.  Do you expect it to not work for some case?  Otherwise,
> > we might have a winner.  :)
>=20
> Wow, I don't know how I missed that when I read the manual. That was
> exactly the feature I was thinking that mutt would need. ;)
>=20
> So yeah, that is obviously better than the "postponed" hackery I showed.
> I notice that "-H" even causes mutt to ignore "-i" (a sendmail flag that
> Git adds to sendemail.sendmailcmd). So you can just invoke it directly
> from your config like:
>=20
>   git config sendemail.sendmailcmd "mutt -H -"

Having it directly in sendmailcmd causes some glitch: It repeats all CCs
in TO.  See a log:

	Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
	OK. Log says:
	Sendmail: mutt -H - -i kevin@8t8.us mutt-dev@mutt.org alx@kernel.org e.sov=
etkin@gmail.com neomutt-devel@neomutt.org
	From: Alejandro Colomar <alx@kernel.org>
	To: Kevin McCarthy <kevin@8t8.us>,
		mutt-dev@mutt.org
	Cc: Alejandro Colomar <alx@kernel.org>,
		Jenya Sovetkin <e.sovetkin@gmail.com>,
		neomutt-devel@neomutt.org
	Subject: [PATCH] send.c: Allow crypto operations in batch and mailx modes.
	Date: Fri, 10 Nov 2023 01:41:24 +0100
	Message-ID: <20231110004128.5972-2-alx@kernel.org>
	X-Mailer: git-send-email 2.42.0
	MIME-Version: 1.0
	Content-Transfer-Encoding: 8bit

	Result: OK

The sent mail ended up being

	From: Alejandro Colomar <alx@kernel.org>
	To: Kevin McCarthy <kevin@8t8.us>, mutt-dev@mutt.org, alx@kernel.org,
		e.sovetkin@gmail.com, neomutt-devel@neomutt.org
	Cc: Alejandro Colomar <alx@kernel.org>,
		Jenya Sovetkin <e.sovetkin@gmail.com>, neomutt-devel@neomutt.org

So maybe we need the wrapper script to ignore the arguments.

Cheers,
Alex

>=20
> Annoyingly, "-E" doesn't work when reading over stdin (I guess mutt
> isn't willing to re-open the tty itself). But if you're happy with not
> editing as they go through, then "-H" is then that's enough (in my
> workflow, I do the final proofread via mutt).
>=20
> -Peff

--=20
<https://www.alejandro-colomar.es/>

--B/dlxDbQ0JnLLCsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmVNfpYACgkQnowa+77/
2zJr7Q/+MC148WU1fr3ltik7+V91BF0/rsnV7Dq7UzgxpfreIP73K3ZPk0dF6l1q
WnwUy+4utJT3rQ9mKe0QUWLyyovZ5VWNOfmcuQzKLdU9QfZlooqkAQiHrcdQ8DkU
c+hUIJPXrmiml5KLOUupBtht4LXq5QRbzUFkmWZYUdtu5FkuISMVi49NQ02RQUNb
+rcKL2opbktQnJynIUoMNqWp5WGGi0M/6znPwC6NAYSKV6f8Jn9JDZUimpAX3q3L
YxuMb6Pu6TXuO9Uz7b5Om/oGvKnOA8n2LZhse0/eae3QXbYgKc+k3chD36zpgAr6
FN6jPT0gxg2Air9TH9Z38V4s9uvMqAsrtkSq0g2TPknrTWMtv7NGKD+Y7uCwE1tW
EvRp2VvCwpJv4sPdmPWQADs539a22cY3VjZdRuXvwXEgD25xJyUhbdNXvjLyFVLP
IMVtSMXjtm5jnPAAO3O2TLeKFF8vCaSQaGvthWShF+Ncqc43bkWm7eUSgHBj9Ye8
e4tjBCK2x7FIR3Uisw6Gk0XW5ZEp++H2xFQfxiM+QnaScSikNycRqrq4gq9Brk3D
iMYBdgY5z2SCFmpT7dN2OEpnGXpBWzCKGypLHzwBzWJQJ+gdKOmriI1ZC2y8WaBr
hej+dnU6F9mFo4AUbXuoA3d/5G5s/AzplN20/K8seNYvg1YN0Mw=
=kU6p
-----END PGP SIGNATURE-----

--B/dlxDbQ0JnLLCsx--
