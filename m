Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41053E316E
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873414; cv=none; b=iutyU+6WKy7IfnaeUaaWQuczZkcJ2iWe+JMmcsrtpqMH5Duj6CLHN6sgQ/ZB2T6K0MWIXckpme411N/WY2d4EK6tK2yp5DbnRkCugvTj8+Esfu8k4x7WLm8tW47POCOHiusEm5gUiyGWOaVxUFJDtnp1sPpDJi/qOVJuiLuGNJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873414; c=relaxed/simple;
	bh=dT+wz77LtvzfRScbKIfCMFxO7NiDdHDgFPkphhEpYq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTlqgItjpOvWD5LuDWkQfEvlxi9ZHUakTpyz6sZUBvtEMcLfTWrYw2f/Dxewd/JLDCBFfTFgTpw6w16BRnzgQ+Wv4hhjPwmcL1UqDReE4uXejg1EWJOJ+mmwjhvqtDSb3mj7X2HoLtH9lVqC08cRP7Oh0Q32ss+WIokGYeEuJ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elOhYWe2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elOhYWe2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5659D1F000FF;
	Thu,  1 Oct 2026 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790873412;
	bh=JeTIYpVcUdQJZOWjEcolmxVts4h6RnAC97W7J/EBIW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=elOhYWe2a/Q7fhpeN7Behjv3I85tSIMPCtOObLt8mbHO7SdN0E2SKN3J3rJb2C8oE
	 Q/UROtEorIBRMxxVyCg2u60M1KieQaYsKlDDYf53f78tTgvV0bPWKjWtS3/PO43MCU
	 z9TC8w7fVHW4Io2J+rB29Y9B4XRQbclaUR/hOdC14s6wLoQQkv1yMJ2p5cv1uktQMz
	 TIvcuTn7r7SRzSsYITgnpWEkpR35K/WSAgD+QH5c5ltvyvpScf4zJF3gu+CsL32528
	 PKrgFc0DqboZRoX50drWY9OBhnxV2ykJIN48Kxj3qYtzJ/8GrwdV2PRa0NmlQKITGa
	 OhKH7i00i2Tww==
Date: Thu, 1 Oct 2026 18:50:08 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar6LUeH3AjxbiMgd@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar6GExDLasWWFajm@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ptvjrsgm7ylcryf"
Content-Disposition: inline
In-Reply-To: <ar6GExDLasWWFajm@ubby>


--2ptvjrsgm7ylcryf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar6LUeH3AjxbiMgd@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar6GExDLasWWFajm@ubby>
MIME-Version: 1.0
In-Reply-To: <ar6GExDLasWWFajm@ubby>

Hi Nico,

> Date: 2026-10-01 11:10:59-0500
> From: Nico Williams <nico@cryptonector.com>
>
> On Thu, Oct 01, 2026 at 01:58:42PM +0200, Alejandro Colomar wrote:
> > I use this little command to apply iterative rebases, which are easier
> > to handle when there are large conflicts.  Are you interested in it?
> >=20
> > 	$ cat $(which git-rebase-walk)
> > 	#!/bin/bash
> >=20
> > 	set -Eeufo pipefail;
> >=20
> > 	git merge-base HEAD "$1" \
> > 	| xargs -I{} git log --oneline {}.."$1" \
> > 	| cut -f1 -d' ' \
> > 	| tac \
> > 	| while read -r c; do
> > 		git rebase "$c";
> > 	done;
>=20
> You could simplify this pipeline to:
>=20
>     git log --reverse --format=3D%H $(git merge-base HEAD "$1").."$1" |
>     while read c; do git rebase "$c"; done

Actually, I've simplified it to:

	$ cat $(which git-rebase-walk)
	#!/bin/bash

	set -Eeufo pipefail;

	git merge-base HEAD "$1" \
	| xargs -I{} git rev-list {}.."$1" \
	| tac \
	| while read -r c; do
		git rebase "$c";
	done;

since git-rev-list(1) is the plumbing command (IIUC).

I prefer the explicit tac(1) instead of --reverse.  It's simpler
conceptually (we don't need to know/remember that there exists a
--reverse flag to git-rev-parse(1) nor to understand its exact meaning).
tac(1) is well known.  The performance doesn't change much, IME
(sometimes better; sometimes worse).

I also prefer to use a pipe with xargs(1), since it keeps each command
short and readable, without nested commands inside arguments to other
commands.

>=20
> But:
>=20
>  - you need to add conflict handling
>  - this is very slow

I have it running on the background while doing other stuff, and when
it stops at a conflict, I look at it.

> I've tried this before, so I know it's very slow if you're rebasing
> across thousands of upstream commits!

Yes, it is.  When I did this manually before writing the tool, I did
roughly a binary search of the conflicts.  That'd be faster, and if
implemented as part of git(1), it would make sense to implement it that
way.  For my use case, I could live with a slow thing in the background,
which is why I chose to keep it robust.

I expect it wouldn't be that hard to do a binary search within a script.

> Also, you need some extra handling of conflicts.

No, that's the nice part.  It works as is.  When I see a conflict, I get
stopped at the rebase that caused the issue.  I solve that conflict, and
then can --continue that one rebase.  Or I can --abort that one rebase.

Once I've --continue'd, it ends at that one rebase, and doesn't continue
the walk.  I must run git-rebase-walk again for resuming the
rebase-walk, which allows me to see the status before doing it.

> > The source code is trivial, so I guess I don't need to explain much.
> > It behaves quite nicely, IME.
>=20
> It can be much too slow.  I've a better solution: bisect-rebase.sh:
>=20
> https://gist.github.com/nicowilliams/ea2fa2b445c2db50d2ee6509c3526297

Hmmm, 93 LoC is certainly more interesting than the 4k+ python script.
I'll have a look.  I'll also attempt at writing a bisect-rebase from
scratch myself, to compare.

> (The first revision of that gist is slow-rebase.sh, which is a linear
> rebase like the one you posted.)
>=20
> This script very efficiently finds the firts upstream commit that your
> branch conflicts with, asks the user to resolve conflicts, then resumes
> rebasing.

Indeed, this is what I did manually before writing my slow script, so it
seems you've had the same needs and line of thought that I had.  :)

> So let's say that your upstream has 1,000 commits you need to rebase
> across, and 10 of those introduce conflicts (assume there's no reverts
> of those for now), then this script will ask you to resolve conflicts 10
> times, and each time it's clear which pair of local and upstream commits
> conflict so you have the best possible context for conflict resolution.
>=20
> It's like git-imerge, but better in that it's specifically geared to
> rebase workflows.
>=20
> I've successfully used this bisect-rebase.sh script to rebase a
> postgresql fork across between 1,000 and 2,000 commits twice, each time
> with significant conflicts to resolve that were much too difficult to
> resolve with a plain rebase.  I.e., a plain `git rebase origin/master`
> produced large conflicts where I didn't have enough context, but
> bisect-rebase.sh let me resolve much smaller conflicts with a new base
> that immediately introduced those conflicts, so I always had the right
> context for resolving them.
>=20
> PG is a perfect test case for this sort of thing because it's so large
> and moves so fast.

I'll certainly try your script; thanks!

Out of curiosity, did you offer this script to git(1)?
If not, why not?
If yes, what happened?

This is something that would clearly be helpful to people solving rebase
conflicts in many projects.


Have a lovely night!
Alex

>=20
> Nico
> --=20

--=20
<https://www.alejandro-colomar.es>

--2ptvjrsgm7ylcryf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmq+jzUACgkQ64mZXMKQ
wqlxmQ//aA60vrla19dcC+Amq/dBWXU5KQnmBgunSzZ1MYohnwzMHOGn13ab2LWL
Es3FaDXWZ0njyUZ+g/pDp7poHPux2C7dUXH6qL0kUUZoBUgOYRMooyxdlmxpbKp7
lApay3K9kNULWIM4VOvyVSS8zvlVcG5TT0Yaft/B02v97UcB2IpAwwbNy9zjPvlz
KYbqAncHo+Q61bXPCr4ERRTz/a/9v6XRlTioba7HP6oi8Sf1l91rJDmZ0O3L1IMg
TETIl8z9p9GUcrvIqV2/eK8/PRX2SssTjrC5f7Vq8nRds5PegA3ukuI2aDCkOF/J
MUN5h6W6fq8AAwfWsEzQEh1rbAZlyD52Itf4+6TsaUEQBKHVD28WF4OwUrrATVmy
9ie5faEUQ5xNCt5r3ey5HEWHP60AbMtc0emQbPx3faCxwZ9HOipZjI4fftlA45pO
lHoL3HVOCG+kLCtnY8JQdk1fupkz8o00DiSAF7md3VCDwA8W1JAtqxI5n7/ureSF
JaysdWViMhskqPAv89/bobiTUOnHl3JOdJbmkXO8Ci0gAWmAxN5m7AlERVc4j5iQ
xxkypH07/yfm18x97S1ByEBKY7yD5ROSd4kvXXuaWZASAdBCbbHOrgb+AoT4KfYc
5kgeO4aKsfs+jnmDD5gIU4Uz0ik7cTeE6PiWtXAnviKgNztkuA4=
=qrgJ
-----END PGP SIGNATURE-----

--2ptvjrsgm7ylcryf--
