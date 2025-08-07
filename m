Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64736155A4D
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596589; cv=none; b=cfPXfBJyTFJbKOIARchgwvIW8VdZglmMnS1QPbe8DaDkzi3YAvSy1z99Jj3Ypi6HFHmhafKGb4kq+J2O4D3aDjn93TAhD6dhy0csnZUXDmIUtnXM3/bXy7AIjyPxAO3L/JDhw+gGcaJ6KW782VC+HtRnx8eHWjuoNqwq17UBlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596589; c=relaxed/simple;
	bh=uekD5MNoHeP+++hjutcathiqZmFF7kQ/GVYYGh97qXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5PWSNFKX7P+sMHgX9uBbbKacykGkKlp3lnXaTK5NRYBUuakLoxf/IMbpioy4cHcnyT18h7XJ82wS4P+v2FU1RKz6mOd/DnPjLUXa0nSzpIgi+sLp1lHBCILsdTbJR928w6MPjKIXZZg2OLvsW4HdYsa/uv8chKHRATKjq33aGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=O21X/8DE; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="O21X/8DE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754596585; x=1755201385; i=l.s.r@web.de;
	bh=3mjqtil3wb+c81FDV/UVMyFjSo65OiaGvTM6dIHMlvg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=O21X/8DEvTCJsMb4yV3luo+TL0vQIbYtbxc7lj8V6BUCrVWGvPcXcCWq92+VndTu
	 9I9QtWmt/JTBUtQv5QueOJ+cFHhqhKqE5+WEjhLYQvxvTGwRGfYOhAg9AzWywayaC
	 sm+blkTX1eou2DdaqXf0j+gW5uM1rjk0nmKqSo+fvq/VWU7CJbpmdyhR3tm6+ClZz
	 5X/B6IXuBWWePgxxSuSYcNiDB01U4Clzcg1CrzvIrRQ1zYtJVmmFcDzWqk4CpRN3S
	 grHZT4kyII2ehWrZL7npphTcKXciaL/nnD46Ag+UNGZrPPzAbBn1WnnzOMd7uk+jL
	 KhqipwnfiCsAa12fDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFauo-1uqDZY39sU-002mkP; Thu, 07
 Aug 2025 21:51:10 +0200
Message-ID: <3858f1ef-7afc-471e-ae21-99b4587bafed@web.de>
Date: Thu, 7 Aug 2025 21:51:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] archive-zip: deduplicate code setting output buffer
 in write_zip_entry()
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
References: <20250804-toon-archive-zip-fix-v1-0-ca89858e5eaa@iotcl.com>
 <20250804-toon-archive-zip-fix-v1-1-ca89858e5eaa@iotcl.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250804-toon-archive-zip-fix-v1-1-ca89858e5eaa@iotcl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:icMH/d99z0bQtxOJqrHjXsJv+FhwTAn5WQezlFMZYpJvSkd3Kgs
 4yZzKmw0kviH+RuOZY4jpCE24spFHv3XSoaKikU1YeRSyGf3RI4SJNX2EzYOdMfpe41pa+M
 /zCnVLLAXLvqdoe9XXtuZPs/dZxnk6oVEkXdbNuRXB0fALizlWLGY8E47aI9F067ADTMHUs
 c2lxumo+n1Ei+Mo9QyF/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sPb3S7tu6l0=;ZpivJhM4yBwoydXoNXC5f6WNCIv
 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
 UfYb0OmAbRbL7ZATAIzQ==

On 8/4/25 6:56 PM, Toon Claes wrote:
> There were two callsites setting the size and address of the output
> buffer. Instead of setting them outside the loop and in the loop after
> calling git_deflate(). Set them once in the loop, right before the
> git_deflate() call.
>=20
> Co-authored-by: Justin Tobler <jltobler@gmail.com>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  archive-zip.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/archive-zip.c b/archive-zip.c
> index df8866d5ba..cc6d0cadd9 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -458,8 +458,6 @@ static int write_zip_entry(struct archiver_args *arg=
s,
>  		git_deflate_init_raw(&zstream, args->compression_level);
> =20
>  		compressed_size =3D 0;
> -		zstream.next_out =3D compressed;
> -		zstream.avail_out =3D sizeof(compressed);
> =20
>  		for (;;) {
>  			readlen =3D read_istream(stream, buf, sizeof(buf));
> @@ -473,6 +471,8 @@ static int write_zip_entry(struct archiver_args *arg=
s,
> =20
>  			zstream.next_in =3D buf;
>  			zstream.avail_in =3D readlen;
> +			zstream.next_out =3D compressed;
> +			zstream.avail_out =3D sizeof(compressed);
>  			result =3D git_deflate(&zstream, 0);
>  			if (result !=3D Z_OK)
>  				die(_("deflate error (%d)"), result);
> @@ -481,8 +481,6 @@ static int write_zip_entry(struct archiver_args *arg=
s,
>  			if (out_len > 0) {
>  				write_or_die(1, compressed, out_len);
>  				compressed_size +=3D out_len;
> -				zstream.next_out =3D compressed;
> -				zstream.avail_out =3D sizeof(compressed);
>  			}
> =20
>  		}
>=20

Less lines, great!  This works because for out_len =3D=3D 0 these
assignments are noops, and that condition so unlikely to be true that
we don't need to worry about the then unnecessary writes.

Ren=C3=A9

