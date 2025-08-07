Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65E122F76C
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596293; cv=none; b=OwshCXcG8lUWGADNFtj81abM2jukzSPsTg8Rombkrq2q5jro55qp9EN7fXrcK/1KCSCpbCSMDNsFnoLGKXGPpQwan2hLIa8cu3ifvHV+oh4AsS/eDO77M5HI5bs09BWsgijivOyGfTOni/KnvKqi5/le3UNHV5qvGy2VdbMu38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596293; c=relaxed/simple;
	bh=vDAtCcd2nSxgWOKf9lLr3Iahqfa92l5JH/io9Q+8gtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vrs77R1gdh/8Z7VinHuAI8AfdzjLvAE4H+ltr2Nm649wNGxKpkzbQbAJ6DKvOBC+93fKV3/q7kV+pJ/39/756mY/8PPTKuuS48cVGHtWSxjbSArii034EI0q2rt1rVlfOZQKy1R+PrTasUa5Xg4WpF2w4Ka5Lkr+H+BMtMXfDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=e1sC6ZbJ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="e1sC6ZbJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754596282; x=1755201082; i=l.s.r@web.de;
	bh=PYWhrp0JUbyipYusQO42/j3dk8yhYd2UPd5aLad12Hs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=e1sC6ZbJC08a6pUDLKSeRkg6dyKhwExYHb4d+QEYIpCg2BKUoMCsI2/YoZsMcMpC
	 Vne/V/WxUxzS9sfCHTJH8vqpdBRr7FTKQXdxsJXAy4SaiqbOZXhF+IXKT8+hMe9YT
	 nrp/evtFMqa8NN/2SkJ09IeZaF/CLXU90jpq7dLmMXFav9VDgKiPvwFeqmhDGZznb
	 FyK3GeTmycSh5UK9bkySnpNTeACnbnd2QYAkdzE67ojJZJb7WWtveBKM48eOO1Sdv
	 UsVE/ekAjI3NbBGsLlmodOofeEx10QEp21orYbBU5uD+hUIMf15BmUqJ4/WhssB7/
	 AXbEAkGoBGaQlk2Eug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwjFu-1uR5Rw25Bi-013ekj; Thu, 07
 Aug 2025 21:51:22 +0200
Message-ID: <2285e892-5177-42ef-b80d-552e4e39b80d@web.de>
Date: Thu, 7 Aug 2025 21:51:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] archive-zip: move git_deflate() with Z_FINISH into
 the loop
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
References: <20250804-toon-archive-zip-fix-v1-0-ca89858e5eaa@iotcl.com>
 <20250804-toon-archive-zip-fix-v1-4-ca89858e5eaa@iotcl.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250804-toon-archive-zip-fix-v1-4-ca89858e5eaa@iotcl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mLCHoM/aQHh5GJHQahUjGnyyvS3VaXXkKZ3zTzgn+m9SgXRPi45
 26uRFG+xLK9WNxTPLYoHsc2dKWrSM0Mnb/AdDyj7s/rRDb5ShNLzYIwc9uHL09QSzxmS72D
 MYpe4BRzG1xGoYzQTZpoFI2XjmvPydE+IA3lTgvVySM/m5Gd9whK8JovwSSQeGwjBInDeJR
 izcjl/d0Eywb602QkR3tA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Oq11fC393Dw=;V0F6xFnlkhxZppw3sFp6raOdnoe
 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
 UlDd14GwK+A==

On 8/4/25 6:56 PM, Toon Claes wrote:
> Instead duplicating code to do the final deflate (with `flush` value
> Z_FINISH), bring this call inside the loop that's deflate parts of the
> input stream. This causes also this final deflate to be wrapped in a
> loop to ensure the whole input is taken care of.
>=20
> This change makes crc32() to be called without checking if the `readlen`
> is greater than zero, but looking at the zlib manual[1] should be
> allowed.

Reading the manual is surely allowed, that's what it was written for.
Snarkiness aside, s/should/it should/

But if you're referring to the example with a zero length there:

	uLong crc =3D crc32(0L, Z_NULL, 0);

... then note that it's also giving a Z_NULL pointer, which crc32_z()
(https://github.com/madler/zlib/blob/develop/crc32.c#L585) has special
handling for; the length is ignored in this example.

>=20
> This patch concluded some refactoring, making the code more similar to
> the example usage of the official zlib docs[2].
>=20
> [1]: https://zlib.net/manual.html
> [2]: https://zlib.net/zlib_how.html
>=20
> Co-authored-by: Justin Tobler <jltobler@gmail.com>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  archive-zip.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>=20
> diff --git a/archive-zip.c b/archive-zip.c
> index 25a0224130..559ed267be 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -451,7 +451,7 @@ static int write_zip_entry(struct archiver_args *arg=
s,
>  		unsigned char buf[STREAM_BUFFER_SIZE];
>  		ssize_t readlen;
>  		git_zstream zstream;
> -		int result;
> +		int result, flush;
>  		size_t out_len;
>  		unsigned char compressed[STREAM_BUFFER_SIZE * 2];
> =20
> @@ -459,44 +459,37 @@ static int write_zip_entry(struct archiver_args *a=
rgs,
> =20
>  		compressed_size =3D 0;
> =20
> -		for (;;) {
> +		do {
>  			readlen =3D read_istream(stream, buf, sizeof(buf));
> -			if (readlen <=3D 0)
> +			if (readlen < 0)
>  				break;
>  			crc =3D crc32(crc, buf, readlen);
> -			if (is_binary =3D=3D -1)
> +			if ((is_binary =3D=3D -1) && readlen)

It's probably fine to call crc32 with zero length, but since you have the
readlen condition here anyway it would basically be free to extend it to
that call as well.

>  				is_binary =3D entry_is_binary(args->repo->index,
>  							    path_without_prefix,
>  							    buf, readlen);
> =20
> +			flush =3D readlen ? Z_NO_FLUSH : Z_FINISH;

... and setting Z_FINISH could be moved under there as well to avoid
setting Z_NO_FLUSH over and over.  I'm probably nitpicking here, though.

>  			zstream.next_in =3D buf;
>  			zstream.avail_in =3D readlen;
>  			do {
>  				zstream.next_out =3D compressed;
>  				zstream.avail_out =3D sizeof(compressed);
> -				result =3D git_deflate(&zstream, 0);
> -				if (result !=3D Z_OK)
> +				result =3D git_deflate(&zstream, flush);
> +				if ((result !=3D Z_OK) && (result !=3D Z_STREAM_END))
>  					die(_("deflate error (%d)"), result);
>  				out_len =3D zstream.next_out - compressed;
> =20
>  				write_or_die(1, compressed, out_len);
>  				compressed_size +=3D out_len;
>  			} while (zstream.avail_out =3D=3D 0);

Hmm, the manual says "After deflate has returned Z_STREAM_END, the only
possible operations on the stream are deflateReset or deflateEnd.".
Here we could have deflate fill the output buffer to the brim, be done
and return Z_STREAM_END and we'd go again, which would result in an
error, I suppose.  So the while loop above needs to end on Z_STREAM_END
as well, no?

Ren=C3=A9


> -		}
> +		} while (flush !=3D Z_FINISH);
> +
>  		close_istream(stream);
>  		if (readlen)
>  			return readlen;
> =20
> -		zstream.next_in =3D buf;
> -		zstream.avail_in =3D 0;
> -		result =3D git_deflate(&zstream, Z_FINISH);
> -		if (result !=3D Z_STREAM_END)
> -			die("deflate error (%d)", result);
> -
>  		git_deflate_end(&zstream);
> -		out_len =3D zstream.next_out - compressed;
> -		write_or_die(1, compressed, out_len);
> -		compressed_size +=3D out_len;
>  		zip_offset +=3D compressed_size;
> =20
>  		write_zip_data_desc(size, compressed_size, crc);
>=20


