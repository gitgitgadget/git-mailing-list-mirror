Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276CD223705
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596602; cv=none; b=ezSK0MzSXovTnfg+4Jw9PZbqndmJMhXA0EFj/nBYTHwWytEMvWjkcLZICXWarZsHKiS/jfpgmHGISlSFbZNOTfH8Z6+0vJPE5rm2NTlXXi1W7/EknzdkXiM27YF/g1Urs2S8IgrmP0tO1ZqQZNeqwD1sUCjsMnwM/n5w102jgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596602; c=relaxed/simple;
	bh=D+EjjO49Rfih7EQu/tt+fyyGQPdwmgnGPvS7cHbfGXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qv3RsfxW6o+rCrXPbsnyOZVI03joNNiRcVoJ25K2Y3HGMSS9zz2Qcp5SrlP2CrDjPOfjgNXferMOKf6nxKKt2vwFZzmcGeWh/l/wU2eJRPb0Se5jp1Xsk4zEVceyWuFJJzhFXyHE0DyvJpEBVe4V2vIohh89hr8I36KO9YXje6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=HQdW1MRd; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="HQdW1MRd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754596598; x=1755201398; i=l.s.r@web.de;
	bh=MrJdzenhdWGfeX9fvv0TsESL62UBb/pELszGvCRMF7c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HQdW1MRddY4tueAnxvLs7MxfX8kuNuPT+QWAKgjwu3lUqfwc7jKw03fvg3ZcqGwb
	 MDwJJGpK5MI5vHmo11oFxhODYUwkuuAYUVkYuhieaz0TpzqVlOj96/qSHFOSSrbYx
	 O/jeUWjmffGafexjxDLXpwaLDLslgRcVTZhc8JtgdEUnHhrZ5RJ7Q1uLxKz3ZihxN
	 kN3ys8LLSB4xQlkbLLCfpIIAsMn1bPzzWeqR8c9fxfIILf48JljRcHNgw+ihZZ8ey
	 Utn+LANY5S8F+0KA3Ai96fCJ/n3geJx9Saqq9l/5rj2ukERhP2iU1bRLtAfauJj3o
	 dw+RHcayaRxtlGikLg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzCEB-1uObPe0vSd-011k0W; Thu, 07
 Aug 2025 21:51:21 +0200
Message-ID: <da21879f-5a73-41e1-9fc9-1ab128d8717d@web.de>
Date: Thu, 7 Aug 2025 21:51:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] archive-zip: in write_zip_entry() call git_deflate()
 in a loop
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
References: <20250804-toon-archive-zip-fix-v1-0-ca89858e5eaa@iotcl.com>
 <20250804-toon-archive-zip-fix-v1-3-ca89858e5eaa@iotcl.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250804-toon-archive-zip-fix-v1-3-ca89858e5eaa@iotcl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WO6BEwTSOuLMcc9ZIt+JQjsGmZ3c6yg8ocyL+OxleRkvgkJjfai
 AkGdL9o9uka9ome94sFqi40Hrq7+aESGERUP4XPplI4yD3AFRldbhs1lqqLBCNUgO+jQePn
 CppfKvS7y9mBfkfKXdMhH9S0/oN1dAOX4eIBnWqIV2sQRFXPtYXBJfH+Fyp0V/UCBzldUDd
 5/5VPZuIqVB/aGVSziqnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n8ufADyTCKU=;TWBdq6nW29J/8ytDwINra1MXVlr
 ASsgsWaOpK8Q2rCf3z5p2shg9nrgEW9XqHn2VeLJA1E269PmIldYwil6OtW960Q2ehwWibtxx
 fsq1m56NZFb4dIYjhNj7UiS58+is9RpOHb/A0TAWHSA9OOYkUcgPNeEIG0pfo8LPSDIasv0FW
 1R+IBdLfjOkb7B7xYBGwuzSp/39J9Hv8deqgq9/rRPfcpqGfz40lAeKx9aZ0skj+/ZtE1klOX
 iUeTnMyFV4+Ztq/LJUXAT9LjiSW8TlET+19INObQIp43OhJUuP6l+Zwk4T7zxYyBRKyeYoO8/
 cL5ehQUVuwZqDySnik+wa3ek3xGJls6+2P/0oio4na7Ua5vQ+G4z2RHnPZ9S/OLIUieW+u2WN
 SE821SPyWMaSPoT5Kl0PoQlfrVCmrFsmUIk+r2gx6Q6whPl7bkQHd+cznzg/LkiT+wGG2N7xN
 JyMlLhMDFOLbEwlA2hv+o9mpjSChoEHFOQT5jsHYWVWsOpndqwewGPfgsxbyYeRmxg4g9hvM4
 stZGHRiqNWmFSQIlOWd3eecxyxRyMWrqCRALNz2ZLGiFOwbxkogKDVyb1xZeEkTTd8cnWw6R2
 Fho+Zbkzi5O038vZzoSSBkDHPJpwdbCUpE6WG69j0NWSIa1EOGSsV3eHMhBP1cGMlvPsYXsqa
 6XDf+3UEnk/D8nSSvDOd0Cpv4UAxuvAnGDH8LyMoiR59ord0qGttfLHwIKHI46pxz4NjE3x6h
 Zqdu925ekfXUp79rvXR1DL9HwzI/Eg/eN/dg4eWPPnVIG+JaOWnpioWR3t9ijOmjN4unS3q8y
 JNhm4wTdMdAOw1c7FSyh4D+69GIBcABD1mT+Tl4G/nqedPuuJ+0uGnWrAGpSg4pAfjSLLdk03
 avvBhLRgkHAz9udem2cNOkRCMya11HfAp/EuJkK1ZgeZSjHRebWDyPpCFOb6h51lA/++9Stdr
 6fGm1mUSGTb7n1Qi7yzJ/nYJ5h8juGpurdtAagl8DcXZtz/pJ4+5V9Z4qlZIqtf+zETdFBydG
 P63t1psw05LlMHD1B/Uw1Ul2FUpLgUYONrKXeZb3wd8eCfHui9DB2kVACBdBLm2kBNiIHjjAs
 fkXwj/3u3wY1JmECRz27AN9sBAi7+FJfqQyVIs+cqJYX8a7AUCGKwATXWF0YPYWYFQsqOb4HS
 MlrfU4J06IRDv2/UnmTubrHcPGKlitFMxsHzWtY14YYcMxri8W6UynP2SUzeP6He67kdT/xjN
 I6DeMqNYLZThEpZd/pPSgt7S5kLldM4j28WMH0Ylj6nk9J1H+Kzcqqp8cLb3SjXAkwAFPYsZX
 m/Ds63Fn69eW2q2llYtCdNypeGrjfUwHXoB2m+Ou8A+hpEdJ39709cmOFAtCLxq1TGua7vkBo
 z1nKTdW08bk9zDnjMN9NLWcxCxr8bsT4/dt4QaxSlkXwRg/ryZkFdgcSCfa184j8iYTvOoZyH
 dhjZYdzCuV6TCokbotjrprE2H+xZHHmGVAuF2xWpVYDoP6hyutxTvYw/ArZGtOsBQYi4Ym6IR
 N2o5A0tc24IBE3ng1pKNJfI29unnOPAsZ3YI7IDaFEga6MCgSAebucoV3kkPtFVQ+qSeELTpq
 unGCYMMrt4PoUQYz1dTF1H/nTL6Q+JLsQ4q99IyvcG6rn67lCK8WRL1jG0RNqGCeI6rACaY/j
 uZDNg4Ltcv6HHPr88d66MyEp3uY76D3IPLxO5ofKd1Qxzl4t/8l4XfRrBgRUi6KFzJrtnpw4C
 hyVOWVrRCTZrKh+seo2+7wZh3k1tR0uRARocozitlVi0H0w04IadENjPE3uzwYrLRzpu0tD2+
 fZpArlKA/WnNPgZ3TmtPBioISk/PH3PQqqsN38LBHlVioxfhcENxX3EGvvguDWe7sxKzG11Jn
 XOuX6xXt4hKfBcgQOR0iGJI5y/yDRapxObPO0Agfrt/m52wqeAkRQxl/140O4b9Ft9XhkdRH2
 V65l7RGa36Za4xhZo0lq8CkCLDOrxPfSdu9yv+eRyCi0/k4xrv0vVFV1QZtOXhYYJlNxMA7Vf
 /mHAo/O3+v2dAfBDM+nJtiUumkEBuytEwbyJiyB9hS6jkCAE7tG7EiasXdCpwpP2IiEJZAEFD
 rXAF3SxOY+n3/GRT+UIz21JgOXzQy3zT+G8aV6dRNmJwU9STmMnGAxnH/R4Y4TP6zeBFDkt16
 CPIEVIEQhNf7JKAYToEnN/h3Q3fgN+jgbVtN8a/oVu7jzKU7c6iJjvJwF+ENKpFLUz2r7LXeP
 3kWNaxXXHkPQS+X3wrJYtdN548Bno3wlOpGAsv7f1B99t6Qba8zPvtYKr52yCWIuvt0lFwWAq
 aet+2AdRYB+Dzo+Nk2pG0K6XKyOzYmenV35nJbqLFh2vGBly9Wy7fpz0WNW7GbJGnGrHL1YEp
 oe8SFx5CFDCIJr5PVhQn9sjxMwo/3EAbYg0P55R7+kmCVNdqk648eVrsyOD+Nam3vqIXRsJ0h
 rTgsoVc71FaAL+gUZPaZJtr46gq6mv7hTBf97I+6QLww2wag2oJN7GuVscfN7+Z3eLmMeVTB9
 CXLjqeknN4VE0Vuq7RYe8L299dKDKVymYDtnBe0YvdemhhTiNBzJ+3Uj3cvrwt19bXYpvaXCq
 k9weWs8htlYlt0AdcaOP86rVv2tDv+sbPRCQIyWCYBAabLMpFilM5uiObXnfJM6Q7hIi6StXw
 ox4NkrL65FNxVoab8Knpx2B89UFlpMjFLokv4DuKuJzRMaazI/332err0rAgF93Y+rarC6DmB
 TkFbUMKhVIJgRg8YsBjPvp3YutMQOxFJ1uLzunK1y2uKW2nuzxn07ZHDA91XCnqgFU/p9YEfh
 FVKLQy2+mlXBoGLaZPC7qqGTVoDF942ruZiNADyU28FOTAje1tkMYh7gcystEBEo09O2JiggA
 g917Ru/4VRiXTNUddquiY8Gtp1lHlb1MzVAJPqHOuZk+fDldisVP3WitraohulurshlhzpPrQ
 PClzGc2gr2E/5PA0fxhfekISMgUgoYgk+er4B2ahru23s6GpkFttdYuMzcoIe3NivKPTONKEp
 LXZOzWabKzA2YME/ICPE463C2lKsv0tDDRMjqGMXu0aB00yiycJIL5UxDxrCBGFOHOldeHnMR
 GtMwXVsgxwJATZxzooImUrCgQzpXjjppsC+4geaNm6L2epO8Ac/Eq3TNill0pzPj2vf3MTB5I
 VSC24jFRuNC9gIKfTM5sinFQ8Up3x6eFvpy4KDu/YSyWNn8eQDBeTUJTOzJln8aOQCY/GHI0j
 FuR3wmylgkXD7ESWeUmXMvnax/y24AFkBosUTd2l1Yj0OLUTmJEpSCOyb8zgdtWwySCCw74hx
 cThz+MwC8Xpb6A95tfVbO60ADkEUBEdx9LxAn3oyM4qMdGK0vKzzmNedCqov61r8m68B41V0R
 MJt6JEvbGWaKpeQyINDQ==

On 8/4/25 6:56 PM, Toon Claes wrote:
> The function git_deflate() might not complete to deflate all the input
> data in one go. While the function is already being called in a loop,
> every loop fresh data is read from the stream. This is not correct,
> because input data might get lost.
>=20
> As we see in many other callsites, git_deflate() should be called in a
> loop on the existing input to make it process all the input data.
>=20
> Add in a nested loop around git_deflate() to process the input buffer
> completely, before continuing the parent loop that reads from more data
> from the input stream.
>=20
> Co-authored-by: Justin Tobler <jltobler@gmail.com>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  archive-zip.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/archive-zip.c b/archive-zip.c
> index d41a12de5f..25a0224130 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -471,15 +471,17 @@ static int write_zip_entry(struct archiver_args *a=
rgs,
> =20
>  			zstream.next_in =3D buf;
>  			zstream.avail_in =3D readlen;
> -			zstream.next_out =3D compressed;
> -			zstream.avail_out =3D sizeof(compressed);
> -			result =3D git_deflate(&zstream, 0);
> -			if (result !=3D Z_OK)
> -				die(_("deflate error (%d)"), result);
> -			out_len =3D zstream.next_out - compressed;
> +			do {
> +				zstream.next_out =3D compressed;
> +				zstream.avail_out =3D sizeof(compressed);
> +				result =3D git_deflate(&zstream, 0);
> +				if (result !=3D Z_OK)
> +					die(_("deflate error (%d)"), result);
> +				out_len =3D zstream.next_out - compressed;
> =20
> -			write_or_die(1, compressed, out_len);
> -			compressed_size +=3D out_len;
> +				write_or_die(1, compressed, out_len);
> +				compressed_size +=3D out_len;
> +			} while (zstream.avail_out =3D=3D 0);
>  		}
>  		close_istream(stream);
>  		if (readlen)
>=20

Makes sense.  If deflate somehow fills the output buffer (with
internally pending data, I suppose -- the fresh input data alone is not
enough), this clears it and lets it go another round without feeding new
input.

The mistake was thinking that the existence of deflateBound(), which
gives a maximum deflated size for any given input, implies a similarly
tight limit on individual chunks of input, which makes no sense in
hindsight.

Ren=C3=A9

