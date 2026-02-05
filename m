Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB935F8B2
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277520; cv=none; b=cBKaWdpV164+Esko9x1milw6WZHlFJS10cR3Cbli977CRjs/ssWj3maoXKnBaf+eRiNdePFJYR3WjjirMcVSj2ZTBOpMSbjW1tP8TQlta3NP4kZZf1msMz9Y0tYts79c/IC5U5bU9sb2Xo68J4SNEoDFBXFBE7py+lvB2HHMJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277520; c=relaxed/simple;
	bh=sIB5ybrGcxI8ugNmKC/tVTUP2+7gz4cpRJ3sSr9VTVA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Tdu+2/u3DUiSh4uLFosKchEHQz5lzXf3+nhVy88eC1YZSNppEL7eEqusPU2YpdlXU7xWZpvVann2Nm09edGywypCTivinpz5EQzX7f5D71PDbhbnKyl0855cE7kMEa6wyKvkxoRVdaF5JAoYYkq6IGgXu+H8mjB7YRaeJtMDFgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=dOxjmvEv; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="dOxjmvEv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1770277517; x=1770536717;
	bh=+3iFJCNjTwjoAr/B7ehbGMN4ZabzDOuF8p8C4p1N7Ck=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dOxjmvEvMUneB+YBM/TZSm4/zqbeKvJeOiJr38Ay0JzL3MNTeQOu9Mtq6VQy2k41a
	 5f1vM5XtsUpwICHbWO07w9MBk508yTdZAnO+Oy4sf6VnFblwwsz8rSPUQTDgbMJMhr
	 rOQQa/MXPZ8wwW54pz4LaYTczLq+ABEbH396R+CoJ4+yCzjkI9wu4yvPow9MmLFyJp
	 Bigy/ME5g/GExlRhStm9on38uvwAPmMd13aks6s4QC/wMBD42L2Pj3gGq7dUVm5W1H
	 97GUAIOlJwWhrXEBPioeAQPoGWVGeoZyjdD2omjpsGaaK3mGlEc4pSK557O851xFJe
	 6dhIo1kzlxmpA==
Date: Thu, 05 Feb 2026 07:45:14 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Seth McDonald <sethmcmail@pm.me>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Document that perf tests require GNU time
Message-ID: <WXxKFs_utzKHnZYkPTmI_Ewz1HmpkwsthhFwToulAYj6ZHlHizXkGELxquKLhQsJUx9aMxvIUhZEjknWNNGEH0zfDlRbD2FOy9Jz4JZNb8I=@pm.me>
Feedback-ID: 171233811:user:proton
X-Pm-Message-ID: 35f914d0c133bc242efb1da7737326c5fa689611
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------e3cdfe7e16a29a14c511e0c2697c4d7a3bddc446d538fc674620f47ef7df1a5f"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------e3cdfe7e16a29a14c511e0c2697c4d7a3bddc446d538fc674620f47ef7df1a5f
Content-Type: multipart/mixed;boundary=---------------------6f3361e356b2fdf9d92dae24da066b24

-----------------------6f3361e356b2fdf9d92dae24da066b24
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi all,

For context, this occurred on my Debian GNU/Linux 13 environment with
GNU bash 5.2.37.

I recently cloned the Git repo and began exploring it by first
attempting to compile and run Git and its tests.  Following the INSTALL
file, I ran `make profile` which showed all normal tests passing (sans
the expected failures), but *every* perf test failing.

I read any in-repo documentation I could find about the perf tests that
seemed relevant, but couldn't find any possible causes for the failures.
It was only after reading and following the perf tests' shell code that
I came across this in t/perf/perf-lib.sh (lines 206-208, master branch):

	$ sed -n '206,208p' t/perf/perf-lib.sh
	# Perf tests require GNU time
	case "$(uname -s)" in Darwin) GTIME=3D"${GTIME:-gtime}";; esac
	GTIME=3D"${GTIME:-/usr/bin/time}"

While I did have time(1), I didn't have the GNU implementation.  I
confirmed this was the issue by installing GNU time and again running
`make profile-fast`, which now showed all perf tests running
successfully.

So to prevent anyone from having the same experience, I would recommend
that either
- the perf tests' dependency on GNU time be more clearly documented.
  Places that seem reasonable for this include INSTALL, t/README, and
  t/perf/README (this file seems most apt IMO).  Or
- in the case that GNU time isn't found, the perf tests output an error
  message explicitly documenting this dependency.

(I would include a patch with this, but I'm certainly not yet familiar
enough with the Git repo to confidently do so.)

Take care,
	Seth McDonald.

-- =


On-list:  2336 E8D2 FEB1 5300 692C =C2=A062A9 5839 6AD8 9243 D369
Off-list: 82B9 620E 53D0 A1AE 2D69 =C2=A06111 C267 B002 0A90 0289
-----------------------6f3361e356b2fdf9d92dae24da066b24--

--------e3cdfe7e16a29a14c511e0c2697c4d7a3bddc446d538fc674620f47ef7df1a5f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmmESogJEFg5atiSQ9NpRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcXDh+gcM+as6Gb5NNC5CQd4nLOciSGHX+Gcoir
ClRKDBYhBCM26NL+sVMAaSxiqVg5atiSQ9NpAABFaQD/UYSfNtd2f/xaVUR/
4f1FhtE9d7VHDEpni4Iw5/DYXdEBAOQctHWjvdZWQykTbQgbhb5blZfF1ONI
B43UD26vpi0K
=rfpG
-----END PGP SIGNATURE-----


--------e3cdfe7e16a29a14c511e0c2697c4d7a3bddc446d538fc674620f47ef7df1a5f--

