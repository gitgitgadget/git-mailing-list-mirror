Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E91DDC15
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754214750; cv=none; b=aUhXdHUHicpycAt2zCCc680DzmYwtIl25KxJlcP8KuBO2RD9cXeDxIe9gjamrPvixObhA3YsC1qbvO8yNYYno73fIWpwF22m81SlEbThOxFMHZXItS++uRG+hwgqjZ2hJkMaEmKeix0QszUfC02sJ+pg06+1yyJMtTDTsK8d3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754214750; c=relaxed/simple;
	bh=s1z3G0MmCX/CzYrcRkLG63/cZudgQJva6hBsrNDtxYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLj+/b8aG5vnHQ99ShjPgelsbB/GqmZhYHArvKlNis+l0zJoFu2uptDAYaU1ihqCI5s9dKqoB+S/58pBBXvqVRTNG60oW07c8PDncvRbwMM3lxqfkVvkhTSqSriF5/FMP87iTQIi50+usrPpCRVp7V6EM6JA8x2jggwrT1i9qGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=JjimI/kV; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="JjimI/kV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754214740; x=1754819540; i=l.s.r@web.de;
	bh=flLTpywpjWPuAq7bVL2pXjaNIN0RAwxyDtmYWvTVq+I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JjimI/kVl4tpRrmLeqUZJbkiNKIbVyCv9mFgunief6ssksQIzn8a9ujWDid/gtvG
	 Q9E3DP3MoRhUiNXDxFLo1ONonNH9OsIdwdzRwW01gT/NkWK9c78Vz8g/KWncq+ew4
	 mxMcp41OG6PHI4nbNxHKkVpGfAiYMLPpCT2/zZrBAZCVJJ4jJjSnKVr4HOVWYVcIi
	 U+n7PaYeGX/bNFp57n8OWMzt4AROUN0qo5SRn3KcYyQty/JnW2qwKvPtTa6TxIhXP
	 uk34YCe+sBjTdVMmWhMM6qqUx9ryuaHE1WLnBmiMbF0544zoiC8/HeNpu0cGUNzHn
	 D7zLitfK2Wg1LFG4fQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Zi-1uID7z35do-00bKcS; Sun, 03
 Aug 2025 11:52:19 +0200
Message-ID: <5817e9ed-5b5c-4539-85ea-07c601c0ac7e@web.de>
Date: Sun, 3 Aug 2025 11:52:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] archive: flush deflate stream until Z_STREAM_END
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: toon@iotcl.com
References: <20250802220803.95137-1-jltobler@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250802220803.95137-1-jltobler@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jxpv1dX4ZclpeW1S7mpK7ICvg1tlGPxbJan1ETewxqZbslkGiNz
 bNGdR4Le4tAeKBQu3UT5xSMmA9joB5FOZtrLAW7I7KFLhvTmkjRVo+EfVGl1LgCHjvaAlJM
 fn3wTnap67CXxo8P0dxV8XYWMtBzvEAGyz4mcq9Nr7uUiFPk8P0iH+O5rLcl73G4hcRF+2a
 htJA2eiMhHGgmt9nMg5TQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VI/70jJFOnM=;FqOkGocxGoE63XBqAudwSodZYIC
 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
 03lIU2wlga2MbJHChCXr79Q=

On 8/3/25 12:08 AM, Justin Tobler wrote:
> In `archive-zip.c:write_zip_entry()` when using a stream as input for
> deflating a file, the call to `git_deflate()` with Z_FINISH always
> expects Z_STREAM_END to be returned. Per zlib documentation[1]:
>=20
>         If the parameter flush is set to Z_FINISH, pending input is
>         processed, pending output is flushed and deflate returns with
>         Z_STREAM_END if there was enough output space. If deflate
>         returns with Z_OK or Z_BUF_ERROR, this function must be called
>         again with Z_FINISH and more output space (updated avail_out)
>         but no more input data, until it returns with Z_STREAM_END or an
>         error. After deflate has returned Z_STREAM_END, the only
>         possible operations on the stream are deflateReset or
>         deflateEnd.
>=20
> In scenarios where the output buffer is not large enough to write all
> the compressed data, it is perfectly valid for the underlying
> `deflate()` to return Z_OK. Thus, expecting a single pass of `deflate()`
> here to always return Z_STREAM_END is a bug. Update the code to flush
> the deflate stream until Z_STREAM_END is returned.
>=20
> [1]: https://zlib.net/manual.html

Good find.  I guess back then I thought making the output buffer twice
as big as the input buffer was sufficient, as deflateBound() guarantees
compression is possible with a much lower ratio.  But this doesn't take
the internal state of a stream into account.  Oof!

> Helped-by: Toon Claes <toon@iotcl.com>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>=20
> Greetings,
>=20
> At GitLab, we received a report of a user getting the following error
> when generating a zip archive of their repository via git-archive(1):
>=20
>         fatal: deflate error (0)
>=20
> I've so far only been able to reproduce this issue in the chromium.git
> repository with a specific file:
>=20
>         git clone --depth=3D1 https://github.com/chromium/chromium.git
>         cd chromium
>         git -c core.bigFileThreshold=3D1 archive -o foo.zip --format=3Dz=
ip HEAD -- \
>                 ui/events/ozone/evdev/touch_filter/palm_model/onedevice_=
train_palm_detection_filter_inference.cc
>=20
> In the above example, `core.bigFileThreshold` is set to a low value to
> cause more files to use a stream as input while being deflated. This is
> the codepath that produces the specific error.
>=20
> I've tested the patch against this specific file, and it fixes the
> issue, but I'm uncertain how to reproduce and test this issue more
> generically. I'm open to suggestions if anyone has some ideas :)

Not sure how to fill up zlib's pending buffer most efficiently.
Reducing the size of the output buffer would make the bug easier to
trigger, though.

> Thanks,
> -Justin
>=20
> ---
>  archive-zip.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/archive-zip.c b/archive-zip.c
> index df8866d5bae..29e7c9f5e3f 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -492,14 +492,22 @@ static int write_zip_entry(struct archiver_args *a=
rgs,
> =20
>  		zstream.next_in =3D buf;
>  		zstream.avail_in =3D 0;
> -		result =3D git_deflate(&zstream, Z_FINISH);
> -		if (result !=3D Z_STREAM_END)
> -			die("deflate error (%d)", result);
> +
> +		do {
> +			result =3D git_deflate(&zstream, Z_FINISH);
> +			if (result !=3D Z_OK && result !=3D Z_STREAM_END)
> +				die("deflate error (%d)", result);
> +
> +			out_len =3D zstream.next_out - compressed;
> +			if (out_len > 0) {
> +				write_or_die(1, compressed, out_len);
> +				compressed_size +=3D out_len;
> +				zstream.next_out =3D compressed;
> +				zstream.avail_out =3D sizeof(compressed);
> +			}
> +		} while (result !=3D Z_STREAM_END);
> =20
>  		git_deflate_end(&zstream);
> -		out_len =3D zstream.next_out - compressed;
> -		write_or_die(1, compressed, out_len);
> -		compressed_size +=3D out_len;

Looks good.  Could probably rolled into the first loop, but that just
would make this fix more complicated.

>  		zip_offset +=3D compressed_size;
> =20
>  		write_zip_data_desc(size, compressed_size, crc);

