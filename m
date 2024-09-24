Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277EA1474A5
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216386; cv=none; b=QbHHnj1j89lrxTe91A3hONlnPwG5tQYufwamKlJFDLyuJB5D42riuB9uRsK+NiryK7KuR5ivlrc6surFn/o4b7H7a1ilAYT1IZNiUf88AdPwLAYPlF1t0GOsS2nZ7vRptA0lSrq1Vnl9vfkqvP3b9N44hDLyfFwRdQ+kw2ZJMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216386; c=relaxed/simple;
	bh=3+DrK0MKfYUqkP+uS1SU95ObJu9DlBOAER28FExHc4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNu3EswNr8o1t/NEXtv1WuH1BEGr9FSiWTWYo0NMwn0MoDSbcC2jpYoRxYRadzMBFJDZtOABHashyJjE7NGfDi73UTzUhqnh2uP6oD5A9FCpPc6Sj84KPwmky9UCddJmXsV737oRxDHAW5WC7UeQNYF5LafqvbwiLIsm3eZMXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=oI47ndZY; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="oI47ndZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727216370; x=1727821170; i=l.s.r@web.de;
	bh=UnVeQuc6DZPG/8NbSGY5SBmzTczGrNzxv/CQy6MKlx8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oI47ndZYxqi6uAErbLrZ95AjoZFsQ9sqgk8tAoGnpwbQd1oyw3gSfc7gZqrI2kj/
	 Kw8HaR3uoHLoHjiyVw9fqFplRl09Q4h9dk3L991LeQDAbRHaiM5Q5prGLfCHQaipI
	 mX7L9UFAuhzwLQlltPGeV6h8JttvLy95OnfucfhkWEY7cckvIFXmRb5fqwALXr2Sb
	 iCtJMrnBLSGbLigXrG5jwtx8lLnDxbxl8uMNQI0IaviMdJm56Ms3gZhnwjHvNFa0b
	 +8yoZDyLqu0ZWge/ZeuBGrPlXizEP2gbBs5UqhqcoT8QstPh9C92l2PRUPxKTCHcd
	 0WbxF9MsLEds1RwNHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.135]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgiXO-1sJ2a619AK-00eHrz; Wed, 25
 Sep 2024 00:19:30 +0200
Message-ID: <1abdf814-e75e-499b-b5ed-094b52cfca35@web.de>
Date: Wed, 25 Sep 2024 00:19:29 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/22] reftable/basics: handle allocation failures in
 `parse_names()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
 Junio C Hamano <gitster@pobox.com>
References: <cover.1726489647.git.ps@pks.im> <cover.1727158127.git.ps@pks.im>
 <ad028020df717a57879cf3fdf5a3648bfebd2c78.1727158127.git.ps@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ad028020df717a57879cf3fdf5a3648bfebd2c78.1727158127.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A1e88yyqXweZ1IzkPb9IktFadmvxdHVYW1HTKPPK9mlMbpT3qUT
 2GI8KH5SFn0/GDEqkWvJE5pIKQckr/uXlo9x5RX+bZGw4O/KgSjn6rikuIaLR5uAXG0ZNmO
 SXE3ybb/E/zA+ee5PULwJIuWA/zTftWgAqpCRzNjpW4FPDXV2s/12JxT+mJsMxUqTPCT47z
 BdMZr2zJ2lrystvqADxiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zN506Xg5Ol8=;PvtG6oQk+PNqCEyljB1kTbtXfJR
 wFexwjQ5rXpYVAL0/GTu5i21E7SJ2EsEBc2Nu84R2n4Ky7IKapo14zcWhYbYe2d+YpDAAUlmz
 kFKTO0DQKJ4V2/cwun9okMisYo5RLFWRoj+KRl7HSazJLsqkhUi/wqTNVUVDSURwriVBjvjjO
 lhrrtfz3jBKd5O0IwgplN/2++7BChGHDk0GGKovrrHnl5m0dUYTVuOfSqeMO2sMX5vX5c0pQb
 Cev8pYfWagZxVd3YJPxQMzjHoWQs02cL402dKopbeKbHKIBN7HvztnhLMRmcQISSf653zKlpk
 702pBJ3HTcdPc3Ce2EvzGgleGIE8bwaUd0yxbZOsrGLr2Z5sceH14YV0SeG/eGkJpfN+uQG2w
 fDE3jn3bCmu/3Jy13J1RPw1R5Eh4One76QtFNmZFCzQGmr/tihQssn1Ssvndf17goWxLhgEpW
 R8POrb3LKtD73YSMLnjTrHVC5h7fcC/I2905GgNyBx06Ur9wT7P8yIdBAvlrzmdGAHqDkJdjT
 NMuxYS4YeCL/AWvXithraStqLDQ+f60Lwf0IAbj3LquWKytGMDV4HHvIjJE4qbDB/WMe7yVJ+
 b1m9LAz9B1Yb0K4RL34V2a8CnjAczVL7Cun3jPDXWcrbGy5p2v3/0qH3VX16D7TSAmBF+fOuK
 0Whn3nEvzGpgAMk1GTiAQoVlzdDEGiYNWsnRp8Ah05Dc1JOE3+zUAr1nSXyfdGTH/y8N6mJeL
 usYWk1WwIt+xDiRFrdcyDrVwBQLYRbrB4tfQMCj6+FaNHKXg5HJyL/BSkkiu/p3pSgcewLPvf
 jGVByhB9EKsNWET1hxzD5rlg==

Am 24.09.24 um 08:32 schrieb Patrick Steinhardt:
> diff --git a/reftable/basics.c b/reftable/basics.c
> index 3350bbffa23..82bfb807631 100644
> --- a/reftable/basics.c
> +++ b/reftable/basics.c
> @@ -152,14 +152,26 @@ void parse_names(char *buf, int size, char ***name=
sp)
>  		}
>  		if (p < next) {
>  			REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap);
> -			names[names_len++] =3D xstrdup(p);
> +			if (!names)
> +				goto err;
> +
> +			names[names_len] =3D strdup(p);
> +			if (!names[names_len++])
> +				goto err;
>  		}
>  		p =3D next + 1;
>  	}
>
>  	REFTABLE_REALLOC_ARRAY(names, names_len + 1);
>  	names[names_len] =3D NULL;
> -	*namesp =3D names;
> +
> +	return names;
> +
> +err:
> +	for (size_t i =3D 0; i < names_len; i++)
> +		free(names[i]);
> +	free(names);

These are allocated with reftable_realloc() under the hood, so they'd
better be passed to reftable_free() instead, no?

Ren=C3=A9

