Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2B2B9CA
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707550987; cv=none; b=bJ5OZVuj655zDs36MlogimME9Zl5NjYVB7zwxgdaQLmT7PnQJn5xQ6ZoVPFcn6cHEoowaSg6tdi7cGFGlCnCHu7GrOpuct3lcNCIUd3zZRF1HPvaZW/jDtihkue2HT640IoNWokZMjjSSSYhMbWWTF2nAz42bzy0eVZZkKPJbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707550987; c=relaxed/simple;
	bh=WMqq+8aXCS3fWtllgBmMpJM2TTWRL3VgEhHTrVIaN4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjcPOHU+cHbvOAXsjPRjdF0qSyxSPsfYOt96EZXqySn+95ukf5GTeh1DS7Ij1ZKQmbhoSQMjk3Tfj3akHzJJJ8WcY0kzbdix6FDbLOJLNslXhXdW+VMFuKDWQCJ+/XaVaUenTbMVE2P4ohsBepa94e2rURS8PtINjIOuB/yAMAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=TvkDCV/y; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="TvkDCV/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707550969; x=1708155769; i=l.s.r@web.de;
	bh=WMqq+8aXCS3fWtllgBmMpJM2TTWRL3VgEhHTrVIaN4s=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=TvkDCV/y7oOQN4OMEJhFhbYV5os9VvZ6UX+TbgqiXrEMaxEmtb/SicBUMCf3kHuI
	 mdRKYMrgdx+19jKjtVqRBT1vtFTWDyocdqjQqxxGxtfU2pOANtR36EECPVot9rxdt
	 jaUr/xNqnklMvYCvRDiSmTzFvSYmKcejj81UTdtGHtjlLvpk3N0Ls+OvqiNB5b6X5
	 kW1UAeDCiflJ0sbYj4dsaqm73v1ou/8enzkPU0UldX7kGO3lCZ7uW5Mijs3UXTXF2
	 1V3wWDqJ6mQlQIGr4D+udvOxFiENMH5CtXRM/DIiXyf2S6eZ/SwoJTyT4h7UAAQMm
	 HVM8NEodp6p8m/ytcQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.17.81]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS17h-1rRJSc1bSN-00TQsB; Sat, 10
 Feb 2024 08:42:49 +0100
Message-ID: <7b0a87f1-4693-480e-90d4-14675e9a5f01@web.de>
Date: Sat, 10 Feb 2024 08:42:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] receive-pack: use find_commit_header() in
 check_cert_push_options()
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>,
 Chandra Pratap <chandrapratap376@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>, Jeff King <peff@peff.net>,
 Kyle Lippincott <spectral@google.com>, John Cai <johncai86@gmail.com>
References: <ff0db7e3-abce-44ea-a1e3-16e1fdaf4c75@web.de>
 <xmqqsf21cmp4.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqsf21cmp4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OmOyvyOmr7JAmsdbyhY+81d9ic0uLbf3SQ3HmfIzI2tuZiHjdvw
 ntt6n9MtVWa6eE2qjrjZWvbkhSfDMc4NKv70pVe6J9ImqeboyGJsKQOaIBDLNwBcOf/zVuG
 M7dplnb5rHWk0a3hgGjXd+lvw5kWPkV11Q/e0KuF1JctX1Bk1Jdr9Wuip1/0R6W9dpe24mN
 TxnHsz2rr3lnm58DdQIgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VJa/YsfO3Oc=;fJZBkluXQVOTKqOU/i8UxfPLb69
 EYQgD3cGgHaceTeeQS9iguIxn9GCNpNklYGhz4mqYVOZsuXx9Kob0prVC7w7ZGv/TzvFB5vxQ
 FLvimRKHSIb8sKU/6auwrMMvDVcR0CQlg8WsYEu51JicRjxCSzvWKSoZZz+VDAH9tOaabLfoV
 8ooiPrH0VdgBJKvA8AGqbSei7iaR/+BZJWv2edZLLrUY2jKWJxwAGlFcsXVYt15FDOBc0vAg2
 3LEt0T1TINO3Gt4FncMEzOyFotyi9/HmD0u5AM0+QAjJYMikQlGEhu/GDaRh/83TAGqziT/9F
 dwU2N9+NH3fGEwqT4vX6o1h7BFX5jZ6jPwTlcNYlXiS0HhnHPeie/f3xVO/mUTkUyU204DWuT
 /JbQsA2hweoILHWKKiSBaQiTGEQTNKRvtiUcDrilgV9MdPaW/joh9aB4FpUhvpGwXulCI2tNU
 WJ65OzLzpSEg13NJNuAOLGxKrrxrkGIYyRIgw/QJzgPzs32Wh2k0EqdOF+QyoHtbmY+iw93MM
 vFs4M6i3ymel7BLHpr8AdrGwriOX7UOz9WxKNlHpXvAkmUPsW+U6VVCqZTu6/VlQdNS/2XRYM
 zOHfeJW+CQgGKZ7ZK/PQv0+K6IsxPxgDmSEzAMqX6lEQiQTxD2Ixi34qAqQp0vStzsUGuw0ms
 DxiLjzoKQS5Z00tkQaZNzylnqH5LR2azX8jqxgUJdfcmlrl8ozUwOjfEK+8oEADLKJePT0Wjx
 imgQ+ghaggkBcNnBZr8HfQPvZ+TuEa5qODpIrKJe4IpvcJBXfq8FBfDdxBAMD7SiaVT/qqRxd
 L1kBwDAY11gFFIjv7KgsuJrDhk7Eg3xEtQtxeS2+Pu7EA=

Am 09.02.24 um 23:11 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> The string comparison becomes more complicated because we need to check
>> for NUL explicitly after comparing the length-limited option, but on th=
e
>> flip side we don't need to clean up allocations or track the remaining
>> buffer length.
>
> Yeah, the strncmp() followed by the termination check indeed is
> trickier but not having to worry about allocation is nice.
>
>>  		if (options_seen > push_options->nr
>> -		    || strcmp(option,
>> -			      push_options->items[options_seen - 1].string)) {
>
> We used to allocate option[] with NUL termination, but ...
>
>> -			retval =3D 0;
>> -			goto leave;
>> -		}
>> -		free(option);
>> +		    || strncmp(push_options->items[options_seen - 1].string,
>> +			       option, optionlen)
>> +		    || push_options->items[options_seen - 1].string[optionlen])
>
> ... now option[] is a borrowed memory, option[optionlen] would have
> been NUL if we were allocating.  So to see if the last-seen string[]
> is different from option[], we have to see that they match up to
> optionlen and the last-seen string[] ends there.  Trickier than
> before, but is correct.

I just discovered 14570dc67d (wrapper: add function to compare strings
with different NUL termination, 2020-05-25).  Perhaps squash this in to
simplify?

=2D--
 builtin/receive-pack.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index dbee508775..db65607485 100644
=2D-- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -717,9 +717,8 @@ static int check_cert_push_options(const struct string=
_list *push_options)
 		buf =3D option + optionlen + 1;
 		options_seen++;
 		if (options_seen > push_options->nr
-		    || strncmp(push_options->items[options_seen - 1].string,
-			       option, optionlen)
-		    || push_options->items[options_seen - 1].string[optionlen])
+		    || xstrncmpz(push_options->items[options_seen - 1].string,
+				 option, optionlen))
 			return 0;
 	}

=2D-
2.43.0
