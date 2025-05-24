Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45899225D7
	for <git@vger.kernel.org>; Sat, 24 May 2025 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748066259; cv=none; b=ULeoZcu+NRmMGnnCXIAm0J4EOd02RRTl5kcL7758kdHkyz5w/iAx5UoqEPNx0b3hZURR2OzhUB+wrmo0TbLK5lzi7zjlhdcmmPurN+gCO2R+nnbLzSS+UpM03W3wd/bbkJvQJ5GFtCKW/ZBaRFMFQtLM1Nnsw0ij+06vkPOUJPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748066259; c=relaxed/simple;
	bh=vSKy+oyZh/oNlSso+OsE9vP8WWGkz61bKPyjGH7fxJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCgWx7fuAYS6YMbLYInekOELQqdqbTDA9EwXQAQnsvrrjRLNt4eVWME4L+T3/EFYqSw8LhL15pPQEA7AG7ut49b4mp0GtPp/fm9ALx+BneF8azfuHbcpsLTM9nxUnLmjECGaT6/FvcvR4SC0sP6xPXM5H2RJCRo3SNsVdVHMWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=toTeTN8E; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="toTeTN8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1748066248; x=1748671048; i=l.s.r@web.de;
	bh=5Rvp6cc5mTW/LYckDI1AH60QmBz6ipWJsg5GzdYidrU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=toTeTN8ETUxTSCbzBJLp1P/IKTIOGu+J0jDhPeFOcL3gJncpQwnnglqbu1B9gIkZ
	 fCgrDTJa6wZN4LYPVvhdMteEJ3Jl/zBVnpzAvr9r1cSoQV2SOhEiKyyTBXDMpV7a0
	 k2rS4AvhQibFE4EPrcaG+TMR5O586AEpD2ZtjyChvbj5HqmK8oPnl3Dp9XeWWumkg
	 oDUfqMwMsmNrX85OwwBH4axDgfMd5Bt0bu+nRDRtg1k2gUHfVh/aE8eTLwzcqPRnr
	 YVXms4x7g9IJXtDIlNhgh1Cb/KEkGNE4OqD7tqlV1WSHbZLU8VYngBk6scsZKCD5R
	 oGMl/rafRja356LApA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.29.133]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOdf-1ugE8u3lP5-00djQq; Sat, 24
 May 2025 07:57:27 +0200
Message-ID: <037b4612-ea92-45bf-bacb-ba66204f941e@web.de>
Date: Sat, 24 May 2025 07:57:27 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix buffer underflow in xdl_build_script
To: Alex via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Alex <alexguo1023@gmail.com>, jinyaoguo <guo846@purdue.edu>
References: <pull.1976.git.git.1748033500935.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.1976.git.git.1748033500935.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4ngkdEtReZu6pDOyTRrxN03Qg49zzfn7AliYZNQQI9MzNRDyxPP
 LMKvaaeUo8hvr+bGK2rvtNCNKQ6HAgYhtgV7SO31+YFMAEN7DFPXthAW6PShsuhcdPeR3Lz
 lPgf3si08VuETgMkB6cs3jRhxECusneG8QOgsZdKHopdMpsygH7x55swNGU6o8JuBPiwEL2
 pwNh+mpOQewPMW16DbLEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cIc/OK4K/sw=;EqhbkLdN2UwcIJNAVlnsEcVRzxR
 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

Am 23.05.25 um 22:51 schrieb Alex via GitGitGadget:
> From: jinyaoguo <guo846@purdue.edu>
>=20
> The loop in xdl_build_script used `i1 >=3D 0 || i2 >=3D 0`, causing
> `i1` (or `i2`) to reach 0 and then access `rchg1[i1-1]` (or
> `rchg2[i2-1]`), which underflows the buffer.
> This commit adds explicit `i1 > 0` and `i2 > 0` checks around
> those array accesses to prevent invalid negative indexing.

xdl_prepare_ctx() in xdiff/xprepare.c allocates an extra entry at both
ends for rchg arrays, so an index of -1 should be within the bounds. =20

i1 and i2 are decreased in lockstep, though, so one of them can become
smaller than -1 if nrec is different between the files.  And that's how
this code run can indeed run off into the weeds.

Curiously, AddressSanitizer doesn't report anything, but if I add the
following line after the outer for, I can trigger it to report a
heap-buffer-overflow with e.g., git show 8613c2bb6c:

	if (i1 < 0 || i2 < 0) fprintf(stderr, "Oops: %ld %ld\n", i1, i2);

>=20
> Signed-off-by: Alex Guo <alexguo1023@gmail.com>
> ---
>     Fix buffer underflow in xdl_build_script
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-19=
76%2Fmugitya03%2Fbuf-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1976/=
mugitya03/buf-1-v1
> Pull-Request: https://github.com/git/git/pull/1976
>=20
>  xdiff/xdiffi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 5a96e36dfbe..2e983965328 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -951,9 +951,10 @@ int xdl_build_script(xdfenv_t *xe, xdchange_t **xsc=
r) {
>  	 * Trivial. Collects "groups" of changes and creates an edit script.
>  	 */
>  	for (i1 =3D xe->xdf1.nrec, i2 =3D xe->xdf2.nrec; i1 >=3D 0 || i2 >=3D =
0; i1--, i2--)

Should the || be a && instead?  From a birds-eye view I would assume we
can stop scanning for changes when we exhaust (reach the top) of either
side.  We just have to make sure everything from the other side is
accounted for in the last added change.

> -		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
> -			for (l1 =3D i1; rchg1[i1 - 1]; i1--);
> -			for (l2 =3D i2; rchg2[i2 - 1]; i2--);
> +		if ((i1 > 0 && rchg1[i1 - 1]) ||
> +			(i2 > 0 && rchg2[i2 - 1])) {
> +			for (l1 =3D i1; i1 > 0 && rchg1[i1 - 1]; i1--);
> +            for (l2 =3D i2; i2 > 0 && rchg2[i2 - 1]; i2--);

Nit: The indentation of that line is off.

> =20
>  			if (!(xch =3D xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
>  				xdl_free_script(cscr);
>=20
> base-commit: 8613c2bb6cd16ef530dc5dd74d3b818a1ccbf1c0

