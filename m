Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1D257848
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772934302; cv=none; b=Asa3pejFEL0mcSXVyTIWCm4ViLSRRNJlgDvLZNpk8o9iqphqsvr7zy9QG9njOAMlZa11SBg0WmZONrZUu+Qh7D7lbWoNUJ7JHrpT7pdtjs69dLEeB82oMs50K8d5jj56+jwAb95JD5XiFyYRCruaX5UPeciC0hOZVxsjuvu+VDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772934302; c=relaxed/simple;
	bh=syFyty2iQOv3n/TGrqZhRrOPHV71/wCSYWWMPlekZ8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8xZfeHnm2/pMb2Gcr65UF3XtKTeYKp30b7FDzAchAb/PUrOwBxTAzen/M7AP2WV5ngNzgqg/Ye9j541fMWS46vGpsmVaHla6ZLS+pqEqTTT39Yt3pRUaxX5Bcqk0HuPap80XpQKLB+phg7RQaIQwiSzx708jZpAnQTdd6jyHck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=W37zRReP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="W37zRReP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772934293;
	bh=syFyty2iQOv3n/TGrqZhRrOPHV71/wCSYWWMPlekZ8k=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=W37zRRePCXia+2ZZiyH3H9Tsm4oIqkDF6SlRX/4zjAsWgZ8h6MGdEXp3LLaDjF/yU
	 ZTilbKjBeu3e7tlHq8bAqFTb0Z1Ege3VV3VOe5ismVbnu5wck8nH3boS+OyBhsqpTY
	 /2aq28eGYhnnWSeczltG2AwK+6G337KtiI7poRoOW6V8OdJX0tSZHEVb6RKj6K5sK9
	 yPiK3kcfANioFZmh0msnMWNBxFTzRE2S8dMlcq80HfE8cj7VFKe1kO+IeITHkgccZx
	 El5eQblH4HG4QDur7VDiAil4b5SiIozD+7prbxVxXLLRmJyMdbDNQnMBCDNetAJbg8
	 FEVJLaEzj0Z6NAHkK2gqB8B9AdDP6Wy2XITiYnXethAjIr9suTBjevciCdPuiL22jq
	 nNinHuIT2SyqfApHtfcRq7TuF++NyXSSilbmks/wTCkYxwwoV00uls11DJFeVt1L6s
	 zqtAQdcU+SoDgQcNztY3YMwtaL1k8ZRc2CFy4D625fs9rrMycZ+
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:6b61:697a:7d33:f7c5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9079220109;
	Sun,  8 Mar 2026 01:44:53 +0000 (UTC)
Date: Sun, 8 Mar 2026 01:44:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "R. Diez" <rdiez-2006@rd10.de>
Cc: git@vger.kernel.org
Subject: Re: git-fetch takes forever on a slow network link. Can parallel
 mode help?
Message-ID: <aazUlMBj_IK41Ss2@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"R. Diez" <rdiez-2006@rd10.de>, git@vger.kernel.org
References: <5c7c975e-2541-47e1-b789-fee1fdb77d2a@rd10.de>
 <aas--JZ-CCWN-o7O@fruit.crustytoothpaste.net>
 <1d6a8eec-20b3-4d6e-83f1-d18b7a3c0145@rd10.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uKeRy4/5CPS3/4Ye"
Content-Disposition: inline
In-Reply-To: <1d6a8eec-20b3-4d6e-83f1-d18b7a3c0145@rd10.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--uKeRy4/5CPS3/4Ye
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-07 at 21:28:10, R. Diez wrote:
> Hallo Brian:

Hey,

> > This performance could be improved with `git pack-refs`
>=20
> After looking around, it turns out that the documentation of "git gc" say=
s that "packing refs" is one of the things it already does.
>=20
> I'll check when it was the last time I did a "git gc" on the remote bare =
repository, when I'm there again.

Yes, this is part of a gc.  However, packing refs is much lighter than a
full GC and will therefore be much faster to complete.

> > or by converting to the reftable backend, which will open fewer files.
>=20
> The documentation states: "reftable for the reftable format. This format =
is experimental and its internals are subject to change.". I am not ready t=
o risk it yet on my precious Git repository. 8-)

It will be the default on Git 3.0 and it's in use on major forges.  I
also use it on several of my development repositories.  It's stable and
functional.  I'll try to send a patch to fix that text.

I would definitely recommend at the very least Git 2.51 for this and
ideally the latest stable version, 2.53.  Git has had a lot of work on
this format to improve performance and stability over the past few
releases.

> That didn't help much. Most of the time (23.7 from 24 seconds) is spent i=
n a single child process:
> child_start[0] 'git-upload-pack '\''/home/rdiez/MountPoints/blah/blah'\'''
>=20
> The log talks about "upload pack", but I gather this is actually a downlo=
ad operation. It wouldn't be the first confusing item in Git. Or have I got=
 it wrong?

upload-pack refers to what's happening on the server.  If you contact a
Git server over something like HTTPS or SSH, then it will use
git-upload-pack to send data to you (a fetch or clone from your
perspective) or git-receive-pack to receive data from you (a push from
your perspective).

When you perform a local fetch, upload-pack is spawned in the remote
repository to serve data.

> I added "export GIT_TRACE_PACKET=3Dtrue", and then I got a more useful br=
eakdown:
>=20
> This takes around 13 seconds:
>=20
>   pkt-line.c:85           packet:  upload-pack< 0000

Is it just that line that takes 13 seconds or is the listing of
references altogether that takes 13 seconds?  That particular line
should not take 13 seconds because it's literally just writing and
flushing 4 bytes.

It would be helpful if you can to include the entire trace output so we
can see and analyze it ourselves.  It's very hard to analyze data from
the different sections in isolation if one is not intimately familiar
with the protocol.

> I don't know what 0000 means. All other similar "upload-pack" lines have =
a hash there.

Git uses a pkt-line format where each line or chunk of data is preceded
by the total length of the data (including the length itself) encoded as
four hex characters.  So a single byte of data with the value A plus a
newline would be `0006A\n` (four bytes for the length, plus two bytes of
data).  The special code 0000 is a flush packet and means that the end
of a command or a section has been reached.  That's how Git knows the
advertisement has finished.

`GIT_TRACE_PACKET` does not normally print the pkt-line unless it's a
flush (0000) packet or a delimiter (0001) packet, since it would just be
noise.

> About 2 seconds are spent here:
>=20
>  pkt-line.c:85           packet:  upload-pack> [some hash]  HEAD symref-t=
arget:refs/heads/master
>  pkt-line.c:85           packet:  upload-pack> [some hash]  refs/heads/ma=
ster

That's sending references, which is expected.

> 7 seconds are spent with "upload-pack" and "fetch" operations, mainly for=
 single "refs/tags". I'll check whether that improves after the next "git g=
c" on the server.

Okay, this is helpful.  You probably have the `peel` capability, which
means that when you have a tag, you get a line like this:

    4a76996b9c60ca3f21e644d78e1e5089a06c6fb3 refs/tags/v0.1.0 peeled:b4c993=
704e90881bec9c217749be813c70ae2bb6

That `peeled` directive tells us what object the tag points to, but it
means that the tag object has to be opened and read, which makes things
much more expensive.  Unfortunately, there's no way to turn that
capability off, since Git doesn't usually have capability control
options for the protocol.

_However_, if you pack references with `git pack-refs` or you use
reftable, then Git will store the references both peeled and unpeeled,
so it doesn't need to compute that.  reftable is better because _all_
tags are stored both peeled and unpeeled, but as long as you're writing
new references into a files-style repository, the new references are
unpacked (and therefore contain no peeling information).  reftable is
also a binary format which means that it's smaller than a packed-refs
file and since your read speed is the limiting factor, that should make
reads faster.

> > > However, the git-fetch documentation does not clearly state whether t=
he parallel mode only helps if you have multiple remotes and/or multiple su=
bmodules. In my case, I just have a single repository with a single origin =
and no submodules.
> >=20
> > Parallel mode does not help with a single remote.  All the data for a s=
ingle remote comes in one job.
>=20
> Is this due to a simple implementation in Git? Could Git download such "r=
efs/tags" files in parallel?

Git is already downloading them as efficiently as possible.  The
protocol has both sides advertise the references (branches, tags, etc.)
that they have and then, in a fetch or clone, the client sends a list of
what it has and what it wants, and the two sides negotiate to come to an
agreement on what needs to be sent.  This shared understanding includes
_all_ of the objects necessary for everything the client wants but
doesn't have, and then those are all sent as part of one pack.

Parallelization would not help here because the limiting factor is the
speed of the connection (and in your case, literally the speed of
reading data off the file system).  A different design with
parallelization might work if one had a very fast connection and the
speed of deltification and compression were slower than enough to max
out the connection, but that point is around 50 MB/s in a typical
situation and that wouldn't matter here because the server component is
on the same file systems as well.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--uKeRy4/5CPS3/4Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaazUkwAKCRB8DEliiIei
geCHAP9kAZMTfPCO9CQv+rngijPifHbFHdPvzH+bNtOEBW7rZQEA+3krgHgMlc2g
EuV+edbsC6GV+G9pb86SBOka0vpKnAI=
=gzI9
-----END PGP SIGNATURE-----

--uKeRy4/5CPS3/4Ye--
