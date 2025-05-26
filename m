Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C620E03C
	for <git@vger.kernel.org>; Mon, 26 May 2025 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748288231; cv=none; b=H1ptoXLEI2eigZryn/LMUEmVrdSyPQvSoTcMZ5mHcT+EFiwqGZ/kw8KDPgOBfFYZYDcUubMubmjwYSZCa92OgRfBJPI8OljKRwjXmRKAbawKI0HCaSBlul4TzBo3wld0KlJsXspfVPdSm182gmdh6mEyh9yB4yoGX01nMfAg+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748288231; c=relaxed/simple;
	bh=+E7nbO6O/QkAvFamsVKwICe8KJh3IbGfFRPL3OJOwt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeRpc14iz6PRtKozm64r2F6T/EITA2qNPPOrZcbp//O05zX/cIjuqIMGFJNOmytEgBwGiGGhQYXuR+m5BWzH8xKqRENxlDALnE1Ghl4bQLQJkw5Gxu7tZWG73+LN7sRd4IYoBq7bS4QCakygQF51ujPSFWyLK8yrHSEdY4PshAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IOOUWl+s; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IOOUWl+s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1748288226;
	bh=+E7nbO6O/QkAvFamsVKwICe8KJh3IbGfFRPL3OJOwt4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=IOOUWl+s8hA8chOvMHicSrg13lW6WSJkkIuiPPcyn0ZEumvrmd0vEtvnIdd+pbHFf
	 erj2aR4u47KKu79bds/gNOS9FCKJy79W/pR10gHS1DcbS8An8B5LPdb7duI27aVseb
	 /hItXNaz68mLmvVtSGl679D9Nl0BfIQJYRC+glqDL+oGBaRAGbmHE93V4Qo2Xzef/x
	 WCthpWdGuMZA+Eg/DKh666Qi7mgYMUAdb8WMKNJ5HE6hD+By4nyvFttyYRYqUG65/V
	 SbnOWAJMaPAjj5CChVZ5KI3PRDxQU1IIC8ZuPHK2p6+qj1YFoTFgcz3UkfRZb3bFSL
	 KgjqeD3e0m42b4x7WIcG2Mk3TC45RnmLsm8fxpHn6jFI+FoC99iaRVmIHXPVjON2vw
	 Z++xdDCm3kj0FwQmTXzSu1ben6LNlgU8g9qCuO6BhmXZiIW0auag6u9Hiybtr2yYov
	 F5UzgsV8CJIhHyFw69h+vdyn28Avr6fnMGoG1FAgrv6Jm2oUAJQ
Received: from tapette.crustytoothpaste.net (unknown [204.148.157.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0AEBB20038;
	Mon, 26 May 2025 19:37:05 +0000 (UTC)
Date: Mon, 26 May 2025 19:36:55 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 3/5] builtin/stash: factor out revision parsing into a
 function
Message-ID: <aDTC10EF5JWvZsf0@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-5-sandals@crustytoothpaste.net>
 <xmqq1psg5qrb.fsf@gitster.g>
 <aDED4MrweIc0N51h@tapette.crustytoothpaste.net>
 <xmqqzff2uaad.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nfQa/Z4Eix6ki+P/"
Content-Disposition: inline
In-Reply-To: <xmqqzff2uaad.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--nfQa/Z4Eix6ki+P/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-24 at 00:23:06, Junio C Hamano wrote:
> Should git-send-email be able to (optionally) catch a typo like
> this?  E.g., we have an address without @ in it, and if we feed it
> to alias expansion, it comes back without a change.  It could be a
> local address but is more likely a typo if you are sending the
> message also to an external recipients with @ in their addresses.

That seems like it might be a good idea.  We could override it with a
command-line flag in the unlikely situation that the user really wanted
that.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--nfQa/Z4Eix6ki+P/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmg0wtYJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ85qdL3LYW9dTJxBWHIkCo47dJ42Msv//VyrEIfcoBzc
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJiZAP4rtdTGRgKtZHbRtiulqq4EhCCJ
Zb9mD9Im7yGBtZGQbgD/fc52aVx6k+c7rrdMH0Y4VYXXCbPz6aC78xT6eaWGaA4=
=6NTV
-----END PGP SIGNATURE-----

--nfQa/Z4Eix6ki+P/--
