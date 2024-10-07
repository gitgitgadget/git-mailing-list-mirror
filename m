Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A012E48
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728275471; cv=none; b=CvG0JRqSDxk6GC1BjxdfmeQDzfhDUXA1RGzep2i3qqU+EYoXUrXPWhL2sqNRsFT0x9ENAm6+eg2sibLDvcGBdTKNpU03Kjb/IflgZQoaG9jZXxYpRmij16YweUu2KX0qIFfWYa51AzFhKLnDlYdLWq/32LwMPBN+LlApbeEMVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728275471; c=relaxed/simple;
	bh=8Vb6Qw3hp00rZfFpZ7Rz9qsNKtBIHhUUWUhw8Ij0cMk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geCZhS6C0PWaYzBIp06E8WaQJLmhvegb9DL85mqfqC22VJoxbZXpa6CMZRA9zxpJdVKhKj2v+QV8Yr9jPLTdDb+6KTrEcuJc9yKmqf7IYBio/l926SqPGntCrWapyzMykc3AU/Lc4hNOxiXQGgYoyJiIW38mAC7dRfLHifiMQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=cv6id4lH; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="cv6id4lH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728275467; x=1728534667;
	bh=8Vb6Qw3hp00rZfFpZ7Rz9qsNKtBIHhUUWUhw8Ij0cMk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cv6id4lHEo6n4GJ/q3TLYU/X1QIp1ZPzhoyU3dfvzzzlIXk2PcdwKtZ2J4KhiLWJ4
	 zj8XbBuBCfacq6JpqRtwZd46A8G+NGwEfzQQjptCH2UW2Iz1NIc2CTAhllS3Iv4MGB
	 oMtd+OICKNKRRcWm9GJeEunbCVqQnD3lHXO9IvPvKb7yT7+yhvJTkkBsQ3ZUrIZ2k5
	 PZskKtb2PvjWgW8WWU70t1oKrl/CqC+gsJUfTXSuj4rimoh33Z75poQ5/LFl0yJIik
	 mZskmrDHfdlBoBjlvaEyhoRENr7NCRVr0tT2tywUY3hw8Q1IC6EN3JzwnM23yROCqF
	 ZbV+6GuMTAfGQ==
Date: Mon, 07 Oct 2024 04:31:04 +0000
To: shejialuo <shejialuo@gmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <vkneUltI5q9qajOYcG8GYE8FHCRIJbH1ExR58YoEm9pam2_L6LlchL4otU6jk6l7iIN0kjOWtknZx4aCxRjGTVicQ69RmOYt_RUghGlV4hA=@pm.me>
In-Reply-To: <ZwNjgvMbUKgpbP7O@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-2-cdwhite3@pm.me> <ZwKoNg-HYGaohvCd@ArchLinux> <CAPig+cQC45_Pofw31h2RSydj_CjqpfajLLa5O_sR9m0AQh5OVw@mail.gmail.com> <o7jQV4JUYr2iQtErKFhCrjCySiGn7_I18gmdInKbOC9TAsvqazG0O_fPUtiWZ5UfiGLr25OZ5xvqIhfOIwCG-s1RGgri-BJIdHqiokIw4z0=@pm.me> <ZwNfuLoVn4aU4mgQ@ArchLinux> <XzNC1BXk2OaIGmgas_MWKZ_ubpeR_kA19hNxmF76FLtgI_WfYrMOGEDEr5uqOETNPHTI_bA3qJE0R0eah4UTPXZUgeRjG7psN6ncDOdPXNA=@pm.me> <ZwNjgvMbUKgpbP7O@ArchLinux>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 3a2f0edea4fe348b5f2563e0603f8ab6acd6566a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------5ab04d7da822e5c23b78408ccff8b76badd350933e888a8bbadf287ab9746cb2"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------5ab04d7da822e5c23b78408ccff8b76badd350933e888a8bbadf287ab9746cb2
Content-Type: multipart/mixed;boundary=---------------------ae4346aa5f12c5a0c5dc7a275afdfb02

-----------------------ae4346aa5f12c5a0c5dc7a275afdfb02
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 23:28, shejialuo <shejialuo@gmail.com> wro=
te:
> > } else if (err) {
> > fn(1, realdotgit.buf, _("unable to locate repository; .git file broken=
"), cb_data);
> > goto done;
> > }
> =


> =


> Thanks, you are correct here. We cannot use "BUG" here. And I think
> currently this is OK.

Granted, that last `else if` could just become an `else` statement now,
I'll make that change.
-----------------------ae4346aa5f12c5a0c5dc7a275afdfb02--

--------5ab04d7da822e5c23b78408ccff8b76badd350933e888a8bbadf287ab9746cb2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnA2P5CZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADQmQf/Yu4big2l59CxkInaqoybJQNNGi0pWRf2xRWM46wWUZuhbZ9Y
Ccw1wk6CKQLXTUYXbwuMSyQBCyJrIlkXUgBdLpXn5+Hjzeto16Lsxcj7LWA2
j8hDOLju4Nii+krSzlPj1/J8b4nOteWlUMp6UdOnDPaR3JRlTeBk9zIDHW/6
EbgXAk5W6N3GbrGIlPRGebw5lAboODXcilW4MZG/CeJTgYjkKtJTck7rDIqR
ot59iNQ7XaYvKffkPPlMJhW8GQMjIPYGnl9HDMxaQnjq28Asl7n/bXG5NKRI
ODsxgrhgZZQ6qlGC9VXqjxhHxO9juvpLKKmFfDKOuKyAQomVpsOSzg==
=bueA
-----END PGP SIGNATURE-----


--------5ab04d7da822e5c23b78408ccff8b76badd350933e888a8bbadf287ab9746cb2--

