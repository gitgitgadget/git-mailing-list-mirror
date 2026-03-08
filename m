Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038D1DF73A
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773010341; cv=none; b=Mhbur2GNiefPKRfPnH2Oo3f4XV4IU195+CClNvqbYMB8z+sU1OYT4Prgi+dbF3/pXZUHIlhyS4TqHwKX0V58Tt7V5fRwZmMoII2S0+qQHVDFi9WSPpzf+li+T6C3ZAN/M/oCMwVQq3XrfH2Y84JsGjKWKNSZRL3KRxIOElHOMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773010341; c=relaxed/simple;
	bh=0Orw0Bapjey9OFgXwzmMD4VFImJ45KiYw6J4W0gmkcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzSVKulRlKG12HX474JZMUIWkjT1jn3tAke9a8fHlW2haXDhhiOAQK026gxHK792ar1zTHL62h9qm4yhczve3rnuznuOKLzss74OWaGOmd4kZXh4urqfvfmUTwf+ECrrsJtuh28KpUXuXqoyx81XEL32aHdMc/wg2wnSquYMg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=tOYnJped; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tOYnJped"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1773010338;
	bh=0Orw0Bapjey9OFgXwzmMD4VFImJ45KiYw6J4W0gmkcw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=tOYnJpedPEPd7Q3PtkKdoeIturszWkfb+mjXIvcURX1GfVyjQltOpRUa4Z/a8niVy
	 QFRE6q+Uv1mwfXwTF6FIAUjko32Y+30T22VkMEo4TRc9mN5r7FDDF69GKxyCM51jK5
	 xgqIKFf1dDH/fBj8DuC1As0pXGoqRL6JF3vd2vVN73PsoWA2vSkuOut47bUegC3iJU
	 r2ygef4XZQqYPxbRYnGdnhs5Y1SgKzg2XOGA4bcH7tF521f6vRXFYhjTLhnYMUXbJM
	 nNERX445Ppd8I58LiFpPnGOVxRIEwVW3Bx3k93u0lYOnm2LQe3Z9ecuiMJUDCEJ8V6
	 p+2queSaH+TT1WH2REmLZ5ZY/lL05Z/XPBgfHV608zVYVniSUiqr5xH9erJ+OdKng7
	 2CydsvNFivroim+ttw3GQyMkCc/7Caw5rHzH0DKoXyXNCq2xWGDKq8t4CksX1H7n0X
	 +UG0y5XwSDsMlmKXjsp9T6uC8LJdSwvEVKcf/wwh6LpvENMfQob
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ef3a:e354:6606:ee24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8CBDA20107;
	Sun,  8 Mar 2026 22:52:18 +0000 (UTC)
Date: Sun, 8 Mar 2026 22:52:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "R. Diez" <rdiez-2006@rd10.de>
Cc: git@vger.kernel.org
Subject: Re: git-fetch takes forever on a slow network link. Can parallel
 mode help?
Message-ID: <aa39obsSbk9R1mqu@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"R. Diez" <rdiez-2006@rd10.de>, git@vger.kernel.org
References: <5c7c975e-2541-47e1-b789-fee1fdb77d2a@rd10.de>
 <aas--JZ-CCWN-o7O@fruit.crustytoothpaste.net>
 <1d6a8eec-20b3-4d6e-83f1-d18b7a3c0145@rd10.de>
 <aazUlMBj_IK41Ss2@fruit.crustytoothpaste.net>
 <0ebf757b-eab5-424a-a58b-e654b1a2942e@rd10.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UYAYfDwrlh6p4yWk"
Content-Disposition: inline
In-Reply-To: <0ebf757b-eab5-424a-a58b-e654b1a2942e@rd10.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--UYAYfDwrlh6p4yWk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-08 at 21:08:41, R. Diez wrote:
> My client computer has an SMB/CIFS connection to the remote file server. =
That means the client has mounted the file share with "mount.cifs", so in t=
his scenario nothing is happening on the server, as the connection is not H=
TTPS or SSH. No process will be spawned on the remote server.
>=20
> That is the reason why I am getting confused. From my point of view, my c=
lient computer is not "uploading" anything when doing a "git pull".
>=20
> But I guess Git is designed for all scenarios and will probably not use t=
he correct terminology in my case.

For an initial clone on a local file system, Git may shortcut spawning
an upload-pack helper and simply copy or hard link files, but otherwise,
all fetches require the use of upload-pack.

There are a couple reasons for this.  First, upload-pack is specifically
designed to deal with untrusted data without executing code or honouring
configuration values, which is important for security reasons.  Second,
when you're doing a fetch, Git wants to copy only the necessary objects
and it can only do that with a helper that can read the objects.  Simply
copying every pack and loose object would lead to enormous bloating of
your client repository because you'd end up with several copies of each
object.

> The log does not really say which operation is taking how long. It does n=
ot say when the listing of references starts or finishes, which files it is=
 reading and how many bytes it is reading from each file, or whether the fi=
les are read sequentially or in parallel.

The log includes timestamps, which allow us to infer that information.

> Thanks for your feedback. I know it is hard to help without the whole log=
, but I would have to ask for permission to upload a log with file paths, h=
ashes and tag names. Or clean them all manually.

I'm afraid that without more information, it's going to be difficult for
me or anyone else to give you accurate answers about how to improve
this.  The trace data is specifically designed to allow us to
troubleshoot problems and most forges and Git-adjacent projects would
require you to provide a full trace output before even investigating
further.

> OK, but there is no protocol here, Git is accessing the files over the mo=
unt.

As mentioned above, there is a protocol because Git always uses one for
fetches.

> I don't think that is the case. Git is accessing the remote repository ov=
er a mount (a file share), so there is no protocol or negotiation, although=
 I am guessing it is happening virtually with the current Git implementatio=
n.

`git fetch` from a remote repository on a file system spawns an
upload-pack process in the remote repository to handle the transfer.
`git fetch` then speaks to it over standard input and standard output.
So the normal protocol is being used.

> If I understand it correctly, without "packed references", Git will have =
to access a number of small files on the remote server. Even with packet re=
ferences, there will probably still be a few small files to access, in addi=
tion to some biggish packed references file.

Correct.

> In the past, on rotational hard disks, issuing many such read requests in=
 parallel wasn't beneficial to performance, because of the disk head seek t=
imes. That is, jumping around would thrash the disk instead of increasing p=
erformance.
>=20
> But that is not true anymore with SSDs, and especially with file mounts o=
ver a network connection with a high latency. In that scenario, issuing par=
allel requests (with multiple threads or async I/O) should actually increas=
e performance.

Git, like virtually every other Unix program, is not designed for high
latency file systems.  Yes, in theory it could be faster to issue
multiple requests, but that would increase the need to buffer large
amounts of data in memory, increasing memory usage, and in the general
case, the fact is that the file system is much lower latency and much
faster than the network connection over which data is being sent, so
that's the case that Git optimizes for.

rsync would also perform poorly in your case because it's again
optimized for sending less data over the network than it receives from
the file system.  Similarly with tar over a network pipe.

So it's certainly the case that Git could handle this case better, but
it also optimizes for the common case like virtually every other modern
Unix program.

If you think it might be faster, you could try rsyncing the remote
repository to a separate directory on your local machine and then
fetching from that.  That does require that both directories are
completely quiescent at the moment with no modification at all.

> Another question: Would it help if I only fetched the 'master' branch? So=
mething like "git fetch origin master". Most of the time, I am only interes=
ted in the main branch.

That would likely be faster.  You may also want `--no-tags`, which
prevents downloading tags that would point into the main branch.

> I am guessing that "git fetch" will download all other branches by defaul=
t, because of this:
>=20
> [remote "origin"]
> fetch =3D +refs/heads/*:refs/remotes/origin/*
>=20
> I read the "git fetch" documentation, but I didn't understand whether it =
will fetch by default everything or just the current branch.

A `git fetch origin` with that configuration will fetch every branch and
every tag that points into one of those branches.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--UYAYfDwrlh6p4yWk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaa39oAAKCRB8DEliiIei
gWc8AQD2t9bH8OhfQcKCtwa+hJOyK4EE/tt8iY/IchQhRyBfbwEA52yawvxQEOwG
e6WRRQEHFb2jXbBcdU9a5Jze1/eJVwQ=
=W1xm
-----END PGP SIGNATURE-----

--UYAYfDwrlh6p4yWk--
