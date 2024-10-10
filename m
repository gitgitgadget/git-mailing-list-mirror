Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626981D0E10
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591856; cv=none; b=Iz1xlHxCAICit03wDwT/csbjvINMDkdPUt8NeDgcHl8JR8pp0xyhdWVO5pcZoydi2JtUG1XzyL/wyaYrAmVi7KPQk3A657nKDE3dp4Cwv54fkePpN9a1iUjYskKXgBN2iZNYGmbJ7hDWwVzdwCqutwStfWT3BBsGZQEH2ZmwMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591856; c=relaxed/simple;
	bh=D89MNDOroh6cXhS28UOFcmNAWZztkyrlr3AV5kVQ/ho=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXN9U7GZ4B+CkxU8RPMIwgIK1e/AVMIvlugOgTuk9xwNwImYtLLM5HVscnjx6fg6gg6ogn/p+GT9GANGCbXAkpBvv/s5+J5bBc+9mPcTOp81mKf1fVDPMLyopLeRaMYjhPKEyQuRn71tgoJGobquEItO4t6j8fvIVDDWila9KY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Im09ATJE; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Im09ATJE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728591852; x=1728851052;
	bh=D89MNDOroh6cXhS28UOFcmNAWZztkyrlr3AV5kVQ/ho=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Im09ATJEh/+V2LqyWrhM4bNsvKskWfFRxvBLkfy9y9L3ES51V/LxnnenL+xlboNH+
	 dlLCvmp119MPl55IOftyta0rfKFNKMjXh2VSC6bBZwldUYMWM6GOB3LrzUhkha0dun
	 pX/DN0p/rTdyIKTwPToCjKSSfP/qJq7hr+iqZ3tQ7P5lCueyU2iZUSVvnSgNEKkXu5
	 Gja/6MFqw9tI5/AHAogI4nc6yeoGe70cGHv8s+R14QaLTXCsli2+jRAz5txXWIVA5L
	 YlVM6W0/urfcZhfwx0/oFo1026n5yrMkkCXrPxPf2b12p2XAZ3FQJfbRebjjqEWdqb
	 XiUVJYRo/TC0Q==
Date: Thu, 10 Oct 2024 20:24:07 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Caleb White <cdwhite3@pm.me>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <XUb4_NFTymdqM_NMxxIfI3YZdQXYu0zViporhB_GbnDFY1pjJNaM8usiQB68mu4RIM_ud9bt8lqq28fdeJhYs-J09YKma67O8kuC8rOGG-8=@pm.me>
In-Reply-To: <xmqqcyk7k9nx.fsf@gitster.g>
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me> <20241007-wt_relative_paths-v3-1-622cf18c45eb@pm.me> <Zwf4PT-vaLX35ELL@ArchLinux> <e1RptKNShhPZHXDhBkQBaCNCmKBKik4nQzRShqtgVfjcH7vBWpuLYV60PSHaJ0diX-oG3XiKHc7IebhIZM4eSkeYdQQZ_QYK2ixxsK-XwrE=@pm.me> <ZwgOURNkNhg8BsaU@ArchLinux> <J1frhnJqftB1IUvIGDnJiz6uYTDNl_Bc92NLj1gXJtgRxapI3Uy-fyFHYtv5_p8e7yzF0pegawV6NlHQTn0GHcXP8MZ_1X8CNkIvO3_MP9c=@pm.me> <xmqqcyk7k9nx.fsf@gitster.g>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: c0a90261b6a1410eb9203bd8b0a11bd6f77c4799
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------23d7c56ea45700c7a56f021bae8a9b951c11d7ee4d4249d82bd2e64db25b0562"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------23d7c56ea45700c7a56f021bae8a9b951c11d7ee4d4249d82bd2e64db25b0562
Content-Type: multipart/mixed;boundary=---------------------356e44b48968b5e14f6235667c03ab7a

-----------------------356e44b48968b5e14f6235667c03ab7a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Thursday, October 10th, 2024 at 15:03, Junio C Hamano <gitster@pobox.co=
m> wrote:

> That does not say what should be left in the strbuf when the request
> failed. If it is undefined, then using its .len (or .buf) is not
> quite right, without relying on too much implementation details of
> the called function.
> =


> Usually, this project uses 0 to signal a success, while errors are
> signalled by returning a negative value (and if there can be
> multiple ways to fail, such a design leaves different negative
> values as a possibility).
> =


> If the result the caller finds useful is always positive value (or
> non-negative value), however, it is perfectly fine and often more
> convenient if you used the "positive (or non-negative) value gives
> the intended result and signals a success, negative (or
> non-positive) value signals an error" convention. The caller can
> =


> if (0 < do_the_thing())
> ; /* success /
> =


> just fine, instead of the boolean "0 is success, negative values are
> various errors",
> =


> if (!do_the_thing())
> ; / success */
> =


> when it does not care how/why the thing failed.

That makes sense. I can update the function to return -1 on error
and the strbuf.len on success.
-----------------------356e44b48968b5e14f6235667c03ab7a--

--------23d7c56ea45700c7a56f021bae8a9b951c11d7ee4d4249d82bd2e64db25b0562
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnCDfaCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAABgIgf/dPG91nhfHwwmKcpC3/R69FtWVZ/YgbxT587bAm7exExOdDeY
cb8DJOw7IPlU8UBmFN6GTj2YMoi3sI1Q8BuI3sccE8EFJSZtjGKInvBCCtos
0Dg9LeUJgnsW/FQOBAFlWYfCAvDuaKWuZgby+2aL4pmRA4/+iSQXuPe82aqO
zdxsQtFvXXSHa4NuzogZUq8pjJ3kvusX0ZV269uKkU2g5kUWzY146uR1zPrw
IkHtrX66VA6hIQ4yR78bwbB48xtoyLSB+bKelUjn9QXP+UPMKSJ5S6HOTCPl
ai+ngluXIboSYvdi/DNBcx0vKwL0vmUMGPu6a/1m12SQqiqeQ+7SBQ==
=uwX/
-----END PGP SIGNATURE-----


--------23d7c56ea45700c7a56f021bae8a9b951c11d7ee4d4249d82bd2e64db25b0562--

