Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CE5190477
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735811182; cv=none; b=eyLsdI+Gm74dJsuZ2OSqp5CY8XnLpM6fA3OABh0FKUUaz7gvAVqSPMqqek/uPY7aPgMLunuJADbf1b6W0nPXt/X3mlFKBM5J/QdwZCQb1XQFRL9scDtiroAru+3S+sZReN/TZF4Mz/PJ6ZPi6s1kyV3/GzYODqi8JTsqW0nrZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735811182; c=relaxed/simple;
	bh=kNPKfjDJyM3K19KD5ECHd4s4cFXjD6/3945UIn0FHTI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dz08NRm/LDUTLgxkdWNlS4xV3FCi3q6RM307bcB42eXXnGfCsqNRYZJmySNA9NweCSN/npZI+TByzgaohIQsWYMcUwEnZ/sFLxV8PsSQnvcf11lNCHWnb8gxTwlGYePjizrmRwMyqkUDeVHp+C98DrVLNmcRq1PylLnAIb6GWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1tTHWy-009V4v-27
	for git@vger.kernel.org;
	Thu, 02 Jan 2025 10:30:16 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1tTHWx-00000000ZyT-46Py
	for git@vger.kernel.org;
	Thu, 02 Jan 2025 10:30:15 +0100
Date: Thu, 2 Jan 2025 10:30:15 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: git@vger.kernel.org
Subject: How to relocate common and workdir?
Message-ID: <h7zchkwkm7djm5qrxnwyh7jvzymrtuzlc4rllnllrcxlrvgtx7@jiu7eiekjit5>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gi66rdmrqfhzt7bc"
Content-Disposition: inline


--gi66rdmrqfhzt7bc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: How to relocate common and workdir?
MIME-Version: 1.0

Hello,

the KAS project currently discusses a patch [1] to relocate the common dir
and adjust the .git file in the worktree to match the new location. Is there
something else to adjust than just the .git file?

[1] https://groups.google.com/g/kas-devel/c/OM7bm-tjyLM

The background is that the git repository gets mounted inside a Docker
container at a fixed position /repo. This works fine for pure git
repositories, but with shared worktrees this fails, because the location in
the file /repo/.git is not inside the container.

Now, the idea is to mount $(git rev-parse --common-dir) at /repo-common
inside the container, and overlay /repo/.git (via bind-mount) with a new
file that refers to /repo-common: `sed "s|gitdir: ${git_com_dir}/|gitdir:
/repo-common/|" "${KAS_REPO_DIR}/.git"`.

I saw that there are also the files *commondir* and *gitdir* in
*.git/worktrees/=E2=80=A6*. I suspect there are circumstances these files n=
eed
adjustments, too.

Is it really that easy and safe to modify the .git file and point to a new
location of the common-dir, or has to be done more?


Thanks for your help.

Kind regards, J=C3=B6rg

--=20
Mit Statistik kann man alles zeigen =E2=80=93 sogar das Gegenteil.

--gi66rdmrqfhzt7bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCZ3ZcpgAKCRB9LJoj0a6j
dVBbAPibEKc4iUHZLN9zZivk705ntlZk/fBPwC7iJsOYeSihAP9kqA05ikQnmx50
g7miHCa0HK2jAqToE5HpkBDiU+Frlw==
=JywP
-----END PGP SIGNATURE-----

--gi66rdmrqfhzt7bc--
