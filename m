Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F747D959
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869924; cv=none; b=jC4Z7RUNiKjI8uYICP/8K4ib1BaGwxJaUSp0fRKjTqTyOxTmtCiIqLk+EltnNDDtBPm57km45uCQQipIbcJqnypOk7ez3VkFurrVvzg+VeLUgh7b4b1H3MIJzGZziSOF4djxkRWPhS1tUVghqrFFAiFCfW09TOSILm1adExtKyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869924; c=relaxed/simple;
	bh=AroOphIgBU+TTHSUi+Z4nXb1+iA5nQ1CAAPzPPG6TsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QihnMTaIZp0swW0fMKcHgdqAO8Pg59aC/fGMAd7cfQQNkXSt+o9ETGbQnqqDlyJF75JRsJFowWQZzqGw4wNdpo6t61Xi1rmwnmT/BhgdO3y4wxxhE+R5zkNe15XXlCmigT80rp5Z8DR8FSp2V9mNLSykDRqqn5zo39cB5BSlWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzL9PXGt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzL9PXGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBB21F000FF;
	Thu,  1 Oct 2026 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869923;
	bh=0DNo4OuGxSPBg55ZnfGIX6L98AeCI9vyiBd6Bjtvw/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LzL9PXGtApOtcmVBFixNXdZoefo+jl7j9HlSNcLZxtABmN3zTslb54B21UvGfwW03
	 Q1ZxmlreRiU4tUbZpdSXEJDXk8kzcK+Rjj0j6KFjZWr8qb8MshjXY/W3qYyc/H3R4O
	 Sn/FODw+GtbGMwd2Xo5nwzs24L3Jnv3pyLe0oXNjTvsSgHcK6MpDEIUmadG7T+DT7b
	 Qoff6s2uzJyfC59OsuWYn8rqGNXZHFTQwQcvDKHyqP7mm5+ikHP+K27rzoh2rhW+rJ
	 HRGEGdBkdijpTgdhwsuATvfAiqGkIk9cm2sUPcHHgHeA/CQA3MjlpsqUy2jamJQR5u
	 RGUCwKx+0BoRQ==
Date: Thu, 1 Oct 2026 17:51:58 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar5-7ZtM6C23H-8m@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g76bpcq7z7vjq4vf"
Content-Disposition: inline
In-Reply-To: <ar5eereSq91xldo-@pks.im>


--g76bpcq7z7vjq4vf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar5-7ZtM6C23H-8m@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
MIME-Version: 1.0
In-Reply-To: <ar5eereSq91xldo-@pks.im>

Hi Patrick,

> Date: 2026-10-01 15:22:02+0200
> From: Patrick Steinhardt <ps@pks.im>
>
> Hi,
>=20
> On Thu, Oct 01, 2026 at 01:58:42PM +0200, Alejandro Colomar wrote:
> > Hi!
> >=20
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
> >=20
> > The source code is trivial, so I guess I don't need to explain much.
> > It behaves quite nicely, IME.
> >=20
> > You may of course want to adapt it a little bit for merging in git(1).
> > I could help improve it a little bit.
>=20
> this reminds me a bit of git-imerge [1]. What this tool does is to
> basically perform a merge between two branches incrementally using a
> matrix. The tool tries to address exactly your use case, which is to
> "present the user with one pairwise conflict at a time for resolution".

Yup, from the description, it seems to do the same thing.  Thanks!
I've also seen at least one other tool that does the same thing.

> Maybe that tool is interesting to you.

Not much, because I prefer a 9-line shell script that's robust as a rock
vs. a 4k+ LoC python script for the same functionality.  :-)

> But it's certainly fallen a bit
> out of date, as it hasn't received any updates for more than 6 years by
> now. Chances are it stll works alright though.

My script I use it in shadow-utils and in the Linux man-pages project,
and is in use today.  I was wondering if there was interest in
integrating it to git(1).  If not, I will likely provide it in the
man-pages repository as a help tool (which might end up packed by
distros as part of manpages-utils).  Is that okay to you?  (I ask mainly
because it's using the git- namespace for commands, so you should at
lease be aware of it.)


Have a lovely day!
Alex

>=20
> Thanks!
>=20
> Patrick
>=20
> [1]: https://github.com/mhagger/git-imerge

--=20
<https://www.alejandro-colomar.es>

--g76bpcq7z7vjq4vf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmq+gZgACgkQ64mZXMKQ
wqm1OA/+IGOdvNEWuTiREdbApS77P90BuBZZ1hObWoRxld2VTULj17no8nqZTdwi
j1NsU8YM9b1kCCmYv0IM1H+r9XmxNDJIIoszVyujx/CudjZ2oRbNvMn0aHxc6YuA
pBiPyE2ajJLOeBZKViHo3XYDme2JijoGM0lwKit1D/jHNQDg8gFxhS6PrwVHUCAF
Fd7o/5vkPWY8+us+8i8oAk8IIJqM3bHJI1ldvroIb103kgSP1so3ILKs/S9aR52T
QIHWhOfRvv2rhi5srsLf9wHNX+nI2Y72aEKFr0TZMgMTg0IdTd33B1gB3ApO8u73
R4dpFXUHs3bqgK/IKyKNxVvF8gN6HiJudAdHK+/CLZrGFNbsoukeV+BM1EhTqeS8
Wkj1LjvmOeNKkcUL5MBPRAtVSLcir4c8LFD5Sq0cn8jBcjF0jCfKIhB9WgMVQna0
ECR71Eqyda68U/22KKLegob3soV8hIaIB8BhQeo3UtutVyE2E7EMPUAFo/CJB6Y/
h81WfQuhcBV486KL6rLak7UPMMC116WIKO/XA6kmvqyK13ti5nCyJ36CmC1x2IBX
PAyuFi59rZ4iqtN3PzGo5Lb6mGuIUIOyaHYFskrO7Y4d1ARaez/z0eTRwEE490fa
jetT3uu+PbOj5C3YtDMhB4II6kXiAdXleXofax+EVv8LOsmwSeI=
=hZr+
-----END PGP SIGNATURE-----

--g76bpcq7z7vjq4vf--
