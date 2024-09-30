Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA618EAB
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718059; cv=none; b=ZtVfHcaCLL8te1Zb8HqLBLbFrTaqLb6bQwUyf7U7qNrvgs6iI/nQU21E9nK/D1vdd8wzWHU+oSWrb5475WrF/xwTvhrdGp0nh5X5rshT5/XcYd6Z0s9bXfFk0c9gGE4pnwT99lj1PKAd8uQLMoPEy3j+74r9n/QxC97Vu76GqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718059; c=relaxed/simple;
	bh=gPF01ryZ49OsW0tUX3SXQwAGwPHS4TNHOolwoSLJlOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSqJBlS7rvg64rBDqNIRZGx6AQhK/9E9cQSi1cnf2ooFZWzyZrDkLanLOMVB1FMmJpFoFm9lRyy8iTRVMK7nyTmJkx1oqRGk8nfGDId/eGEQ9oiobzzo6dXpafgDo5BiajufX29/1TvTrPClDm+2+H46vPnnKX5anmDkQ7j3Qdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=R7cdOW00; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="R7cdOW00"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727718047; x=1728322847; i=l.s.r@web.de;
	bh=OhkAqkJRmYB6xcuz0dvNGBLQUdXsL+vJHwFuELRbuvQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R7cdOW00bgjLxT7r/DhYpG77zvvz3gTp+9t4KiXfR9tujrzzmWvbiF64Y78jB0BL
	 Ho+2/kpVV81ilj1iaiyoEwAETVrBceo63GEvnmx4nwvJTxu+AVkWZixow+4fzgptB
	 rI1XmskYqooNatDz0IjOioln10YEBskcFNun67qvyLJyWExXIOr4jKB7pNeu7F9pc
	 RK14JDvIpyyuzQ3dTdQzAbDSNOHoFA6149B2YriynWblmPgLo6hrSZhEyzTc4oAVj
	 H05k+/1dxVM9MNSKyXOlKH4OYfxoKkoFls7/qFcIQZ0BpqoHAY1WBbI1p3IpZmZaY
	 ngdOs5ai9FXdUsM2aQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.148]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrPV-1sZ0Au2iiB-00Ph8z; Mon, 30
 Sep 2024 19:40:47 +0200
Message-ID: <5d37ff9a-9fdd-49c5-b18e-7b49f9d9350b@web.de>
Date: Mon, 30 Sep 2024 19:40:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/22] reftable/basics: handle allocation failures in
 `parse_names()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
 Junio C Hamano <gitster@pobox.com>
References: <cover.1726489647.git.ps@pks.im> <cover.1727680272.git.ps@pks.im>
 <922783708def23c7e0c73db846076cf5e242154b.1727680272.git.ps@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <922783708def23c7e0c73db846076cf5e242154b.1727680272.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UWEVAbGJ5lj7uKpIxj8xFDV3FxO5JubCvnMSuV1E52uxoiXflsJ
 S+cKOJaJlsrrUBISM5G5tJR0vTNKnconUFScQdmga/oJFbwM53rf0JbWFminWGV+iNPKqKU
 wxdqM/YS/H3BQDc50AGf9Q8WQNIpuoflIr5y387YHHCLEoLXmENRGn9N2HXNZF7ChTASbbT
 YHLpuQ4QDPontpm9ZVLUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+eycczSLDtQ=;zMQeN8AySFByABmO+ICNmFWyOml
 RA5qrcVO38Ph5MUib97GG9ECphYkhUa9OBO13PuEVqZqPDFwwtzjS5tCAVal0pHitUe0Z/pZE
 MqE6h09uS5EHSZp57q0jLLPgHDWOctGIfeBdn31kUwUGpZCWlQIEWhv7MYbTkdKE6g/hd5pUy
 FcMgqaEJ2q5siKlMfYubjK6XriAxwou/bXrJpp6nP3eudZLE4tBI+aQdFmQFGTGfrcBXt1DJR
 Cl+BMiP1d+JSO8+MCFbPSaGRIVe/K68x1A69F+F6SAJtlSvt3rrJn1sRdi93cU6449+kyyjOp
 eYNDI0q0jv4tFyDL5yBIKr5dg2rVTRGgrOOspnOP/8Ia5SL6n3PpPR7MHvaeEbSavgkHrAXAl
 UZGK8W3caXa2K4LiXUm66JbISSxfeYjx88GLAvOk9o1FGQ+acfl+ZJPm21KST7+/YfTfbEHEf
 biXydPqnLSb6aBdueiZh2SQOKTyHO64GNGu2QyD8MtWKZwIJhVQzUVeEmHxizRkqEfuM1OdI1
 TCQAApkAHvxWLhf5cUxUZmVqI0zGa+DGIfkvqnHm/D1JDpI978JA6oo6myn4Oh4zoLdVVemag
 d2tlkg7Aw1tDGnjWw2mUp4YlhIjFZacvkc12wjWW+MG9rSsmxx7TxQnfehtEIVnaVyO41fveg
 4cwgSFLqqyWrKvnXct7IzPLuekcdxkjjn8OYFjcuaMKGzpBrleeFAXWAJboMHAXjs48ziTGDA
 k3bBvmUrwVhKhfhYbS1slhuSX+XzSWrO+gje/cTVb0xcRqzgzr4KmfEle1PYSOcWN+MnJEaDm
 VFwWf1HnuXwpguEe5FC8m87Q==

Am 30.09.24 um 10:08 schrieb Patrick Steinhardt:
> diff --git a/reftable/basics.c b/reftable/basics.c
> index 3350bbffa2..5ae6e6acdd 100644
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
> +		reftable_free(names[i]);

If you use reftable_free() here, you'd better use reftable_strdup()
instead of strdup(3) above.

Ren=C3=A9

