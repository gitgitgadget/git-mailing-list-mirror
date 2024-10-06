Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D142F2E
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 04:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728190757; cv=none; b=Cse+mcqbGeHFTMTD9tx2RsAcTV1CW+v2WvCHMqdDMu9uZ05D84dyhGGJi/eB44O2v+EvbKjY9lp7BvM04FDzpyC8xRVSMmWBSmDWh7E+wSuXrq0jc7J7/Jiv3esKEnQvb2UO0mPDTsx3NL8LqsxvTLK+mXCqDXRmdpWeZeYz+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728190757; c=relaxed/simple;
	bh=dcAJ1CiM/BKYEYfnXnlGlt5TslztNbj//SjKkVip+kw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WhwVSirP/IeXgwm9aiGvuOlOsPmxAjf6YGB87QSWyLynuAln6bnfCN1CVYk+EOsE+9fdwDcv+9vsaqM121rk82lYNiFl3NQfnxG+wtO827nk/CknBMwzCvQ6NcYCjv1MaVmXMpZG0YGrCPUqfvm+PIh4V3N7lau4ldILYZ3LlBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=A4pM7LhW; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="A4pM7LhW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728190747; x=1728449947;
	bh=5tMoLiuK3qyle62hAfsDjVPB0Rir6/SEz4pimkKdDKA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=A4pM7LhWDTAFZ28uVKv/0oyAEMkPjsRZ4my8mVXvg8r3HV2AZS9K+su+k+qqzOqmU
	 8d4Y/X4oOgMdz3PsGDS3psA4n07WtG6X8BD1PF0wIk5/4Vp5itQFogkh2vFZ5zg3w0
	 gBOMcp3Q/shXjI+MWts8yAOKNQGU8kkmFY8YjlJzcDBt5LbL+bdPLZaZX/eHDH2wdZ
	 cyLthI7+WtesvpgewF0Xf5uPKxjLwFNFwlMVXjQVQcqOQWHHfcHyu5Mgb1uj+S2JFF
	 fXf1eLaXcBo1ks74/ej8s4zApd0Dleci5FHvlw4KkPHY9lnqoPLe3hHvDjwfEYg0/Z
	 CBgm0WaHADBvQ==
Date: Sun, 06 Oct 2024 04:59:02 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH 0/4] Link worktrees with relative paths
Message-ID: <20241006045847.159937-1-cdwhite3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: d6ccc94b73e1d7e977aa8fd3cd27029a06ca52bc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------d5d14ea48598cb8d4e391ca1bc0281914d53b3e1512aab584a29e402766adaed"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------d5d14ea48598cb8d4e391ca1bc0281914d53b3e1512aab584a29e402766adaed
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Caleb White <cdwhite3@pm.me>
To: git@vger.kernel.org
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH 0/4] Link worktrees with relative paths
Date: Sat,  5 Oct 2024 23:58:38 -0500
Message-ID: <20241006045847.159937-1-cdwhite3@pm.me>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0

Hello,

This patch series modifies Git's handling of worktree linking to use
relative paths instead of absolute paths. The motivation behind this
change is to enhance the robustness of worktree links when the main
repository is moved, or when used in environments like containerized
development where absolute paths differ across systems.

Currently, Git stores absolute paths to both the main repository and
the linked worktrees. This causes issues when the repository is moved
because the hardcoded paths become invalid, leading to broken worktree
links. Developers are then required to manually repair the links by
running `git worktree repair`, which can be cumbersome.

By switching to relative paths for worktrees, this patch improves the
resilience of worktree links. For self-contained repositories (e.g.,
bare repositories with worktrees), the links will continue to function
properly when the repository is moved or mapped inside a containerized
environment. While relativ
e paths do not completely eliminate the need
for repairs (as links external to the repository can still break), the
likelihood is reduced, and Git continues to provide mechanisms to repair
broken links when needed.

I have included tests to verify that:
- worktree links are created with relative paths.
- moving the repository does not break worktree links.

Note that absolute paths are still supported, and the code handles both
types of paths. There should be no breaking changes introduced with this
patch. I considered adding a configuration option
(e.g., `worktree.useRelativePaths`) to control path type, but decided to
keep it simple. However, if there is interest, I can add this feature.

This series is based on top of 111e864d69.

Thanks!

Caleb

Caleb White (4):
  worktree: refactor infer_backlink() to use *strbuf
  worktree: link worktrees with relative paths
  worktree: sync worktree paths after gitdir move
  worktree: prevent null pointer dereference


 builtin/worktree.c           |  17 +--
 setup.c                      |   2 +-
 t/t2408-worktree-relative.sh |  39 ++++++
 worktree.c                   | 235 +++++++++++++++++++++++++++--------
 worktree.h                   |  10 ++
 5 files changed, 240 insertions(+), 63 deletions(-)
 create mode 100755 t/t2408-worktree-relative.sh

-- 
2.46.2


--------d5d14ea48598cb8d4e391ca1bc0281914d53b3e1512aab584a29e402766adaed
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBQJnAhkVCRAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAACCCggAuUEoAk4bHQ2dTBZEd7u60+McpQt9//6EFdargVtHhfpRD7k9
c/y9zE/sxZj+W2nZmOktkgrx0woL210l/rDSCZZ8YO9vXR9G1sxlOoPjiUIt
heyHhZjNn9BIpZyPoj0EuER/v1nnQlK8IuoKDwt+a2ZtwQd/HvrilFv4ROkn
mM0V974EyS6Xg+XCIyfOT5/AGJlJT9RPrJj4pCkaBIuPhI26ZMQ4N5pVY5dt
iBN4Jbqzbh08Nzhzwa/0HOiGl5Jfhxc/h6atYQpZlnXSAgYAFqCOdKGt8Rjt
9YCfqXVFzfIhK4bw2BFzfdYDFbLkOHwLC71L6rBCZ5fXKQuqHEYQ8A==
=xPo9
-----END PGP SIGNATURE-----


--------d5d14ea48598cb8d4e391ca1bc0281914d53b3e1512aab584a29e402766adaed--

