Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675D42D8384
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772197776; cv=none; b=DYlncf2lriuPpMT1n2EbZs/FsaQ6kDi85OV0l34ECGjR7ZV8lXAF8D3upCQOt+avbGcslc/jlw71JrjY/xodUY+YzytfzgkIHwID7/spb9FO5qT3NzNRC5658bLFc/onhc8OR7QnqAOmJ/I24zZyO5pBl5oMzVNq92ZD7nzgGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772197776; c=relaxed/simple;
	bh=mDNxiz8G7E+Mblk3Tib0mzYrb+75Qg3yjkRtmE/RzZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM6kHgw40CdRjiDnl9oX7/EKCONqEBtqBBzMJjzxeLh5SHoCZGC7k0GaMw9D1rCQ5NmdBwXfr1LAeL8tYXxahL4LmQBq0GDJea/4a9o7XxmMefocrd8WblJErFcILdPsMXbO4Rnw9YwHw8MSFEELNX8i9B8F/quVLUIeOah5iLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=OVWffhr+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OVWffhr+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772197446;
	bh=mDNxiz8G7E+Mblk3Tib0mzYrb+75Qg3yjkRtmE/RzZs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=OVWffhr+/o9BLmTA7WCuu1ZJR5W7431cHGgEbKA8eg0+Z5ntDczoDrWWaidXsvs1H
	 y3zkxIYWJGO07z6zCL63p5LakAenypMWDKPaxTpS2oS7dfTI9+yX+VMqWDlcYMlafn
	 m+GAPS8ETc0g9pXneDyxyEGW3/MsoekzNsuo0VK+QUi6CiFjss/vL8HGnPEKEwuHjC
	 i7MbelqJ29OD+37NbEnCxLOefwQXI6JB1CNDTEyd950FU3V5Ta/R5lvCzZf5pTYX2z
	 qIQFJtYiH1GJICy5rpm+gvt4a6l0fx5rvZynUMHNZl5KWj0PAwgJbooe8D7Tin03zK
	 AI+7cMlcGlNGp+b93SNN1RRRw5nVpJ6NSsHruHmZK8RltOdz2cLvLFX/bmTzOlINjZ
	 4Uok/VhzIT4Vy5wnn49gFwHZnXsXpzyLbfPmiJmzU5WmhAoiSUFaGVp2EEpPZKTpId
	 tYhG2EC0d8DFwRv1LEygQHuf7SWxF4eO6Uxsjh7ewHGuWoauXAR
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c4c5:ecfe:7f98:ebd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9F19620106;
	Fri, 27 Feb 2026 13:04:06 +0000 (UTC)
Date: Fri, 27 Feb 2026 13:04:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>
Subject: Re: [PATCH 2/2] upload-pack: reduce lock contention when writing
 packfile data
Message-ID: <aaGWRWcxEtLD1OlK@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Matt Smiley <msmiley@gitlab.com>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
 <20260227-pks-upload-pack-write-contention-v1-2-7166fe255704@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lqwArJJ4Rz9LsQDo"
Content-Disposition: inline
In-Reply-To: <20260227-pks-upload-pack-write-contention-v1-2-7166fe255704@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--lqwArJJ4Rz9LsQDo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-27 at 11:23:01, Patrick Steinhardt wrote:
> diff --git a/upload-pack.c b/upload-pack.c
> index c2643c0295..f8ba245616 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -270,6 +270,13 @@ static int relay_pack_data(int pack_objects_out, str=
uct output_state *os,
>  		}
>  	}
> =20
> +	/*
> +	 * Make sure that we buffer some data before sending it to the client.
> +	 * This significantly reduces the number of write(3p) syscalls.
> +	 */
> +	if (readsz && os->used < (LARGE_PACKET_DATA_MAX * 2 / 3))
> +		return readsz;
> +
>  	if (os->used > 1) {
>  		send_client_data(1, os->buffer, os->used - 1, use_sideband);
>  		os->buffer[0] =3D os->buffer[os->used - 1];

This seems mostly reasonable and well-explained.  The one question I
have is this: how does this work when packfile generation is actually
very slow (or when the connection is slow) and we need to send data
every so often to keep the connection alive?

I just want to make sure we're not breaking the keepalive sideband case
when that's necessary, but of course I have no objections to improving
performance and reducing overhead.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--lqwArJJ4Rz9LsQDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaaGWRAAKCRB8DEliiIei
gZqSAQCB3Gr8Uvq0d6BGUMArPM9tF4yg/SDehNI8nOWb8jWohwD9Guw6DttQ/LuZ
UNoB70SAZo0NOJhc2kNP0vIl1OZOVw4=
=lH6m
-----END PGP SIGNATURE-----

--lqwArJJ4Rz9LsQDo--
