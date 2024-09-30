Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3F0198E92
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718066; cv=none; b=U8N7S0bALWYVurvwvAsHKOhdicWK0l71xWftS7jWf16gCLF+5IyoOKKKx2QOJfLdVE29VOuH84pxAV21BheCs30w6DXE5TT4dAMcQ3CSw9v1/SjS/z3ZowthE5n8Ky5a+5ZGtFobME0He3D+WiGAQoMsAO8shBFkWhwKM1Jx0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718066; c=relaxed/simple;
	bh=cATAyVPcAYoV/j1ZUTljnB+1UzILrpBREEXTlvs6vvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvPwf2+qpP6KuCdM46f8wRbqpdYmm5VfgVxt72DEo01BGkAxFlnBEaDDqcfVhLvt02o0ikZbJ4CICq+UtER7/g0rdlvBRA5Uo1rKhkiPnCk8Eoqu+U24oENMvp+fxNFrZd8J+sV2bY6gBw40eFFO5TIE8xs23Y0H4GuWfTDVVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Y7JopSgx; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Y7JopSgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727718049; x=1728322849; i=l.s.r@web.de;
	bh=Zc3y352IgDgC8udLydYaw2wuTPqqssbm19COHXrxyCE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y7JopSgxT8/kKWXzl48kyFnhPaEV09+StVq0IbiPmz+qqdCgAWXpp3r8RBR52QQ1
	 xMzW6JT/v4aaq/C18rzMzDid+YKF+8GFjqAKR06oqTTibuBACJ3s4QpZ4C8G4k222
	 ZQPuQj/1le078NBN5YKBxpPtjtSneGDoUALNZkS8/qX9vamZqcfyr5EGWH8DiP2uD
	 kiFc9bY6CVKxMnHvJXmO9mVUIXdxhf+2LAYq0LtTfEUj60DOsdl2AXEYo1sQO062b
	 fox4Usfn5ytK/hGYXjfwkd9usSZRMC7glMJnr2mlaM5H+qw1jZEt0P5ttGnipQ/Za
	 JcNGoDA1vbELGOEV9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.148]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZMQ-1s8m9Z0tBg-00qP0k; Mon, 30
 Sep 2024 19:40:49 +0200
Message-ID: <64253c71-915d-4862-8fa2-555ca2fc63cc@web.de>
Date: Mon, 30 Sep 2024 19:40:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/22] reftable/writer: handle allocation failures in
 `reftable_new_writer()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
 Junio C Hamano <gitster@pobox.com>
References: <cover.1726489647.git.ps@pks.im> <cover.1727680272.git.ps@pks.im>
 <9edd1d84cdbd53d966ff5cfe9b75281dd5966b07.1727680272.git.ps@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <9edd1d84cdbd53d966ff5cfe9b75281dd5966b07.1727680272.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5SDpq9E5vJLOFKe1y0zaQN3/+p2dNg/HLCmOAELCY/CjiqzQ4pT
 QZLaQCi4QnO4IscO4CEMeKmS/L7mCM2JMmnp6Tw+1r6YxcbGT4ARaNFTrDKjwzqicabhD0m
 JxOwbaZkb42br2RuFZZTAc4eKpuZFBInzqdliaUqc+lzmTND01EoJ9D9Bee7Ce86WDJ+KKp
 88eAHc+066uB2g5RsNt0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PFRksLMKM1Q=;GYHHk59LqPQHTcBz1xvCEpTNrfJ
 oFPUoS6iloCGURRFpioPvGiSlN+dRJ6Vk4xFeNjNF435k6cD5xbtfEzP2nSk0p6WUAzTo1U7w
 iuzBT3rl/z5g1Q/bm0Z5l+W6fDY86iHep+8d5TVYXIdnwzZCqhre9jEHFES9fX+2kZsZFDKeZ
 tWpaLYcefCxIQHKAidqNxcVAu6MtIysW2TTPCkT28uNQUDwnWLBgk5fBmnMaYbfi2+KutyFh7
 tJW14OGHqsioMj3wW51kivWVN8QkOjm6gPV+5wsmHUYMiYR3Jon2y1+zi+xBgnt0BdUJLbHiQ
 x7RosRM8DaM7ZUSaAHqK2ISfOk6Omxk6+N0jnZQm8fuLvvHc211c33bqvB9kLrTMOt1A4flOv
 HPtjkhfJa11oS89r18/2/uIZXLq8os6tHHc15I4fhZb/lv8pi1XOpLNtQuqd4l5cqZC4ZASU4
 Y4OrBsxQ2Dqo77uPcyL7SGbvi7Ik7esDqcsfTT560wAJcYSN7bvN9FcUrIZmlIVdgG4mbhFJi
 tInO19zfl5aGlmL5jhnkUM1dQME4VogsEVwL3oeDP/uz/tBLl1OPFhBHXgAl/dXfTgezgk0Xo
 eNHUHqxChkgItgF/UgoZcX7EEYq+wdBEgqwoET0gXHFlnKuH7ESfY7Nwf3jGuz4Xr5PQwZPWq
 /z6yiWswXS9LMGy5OrDajGxkHMiBjhGODT9YlkZQ2001IFpV7BPUPM/Gwdtiec9LkUdT8GnNe
 ePiW5GdB3DBnhMHliDdvaRh4PjTvi1p2T/+f9ewnjag192NFUiFenY1EgfAVHdjUTmG8+YRyu
 VG+y5EDzg0uTbtiFnmEOyW+g==

Am 30.09.24 um 10:08 schrieb Patrick Steinhardt:
> diff --git a/reftable/writer.c b/reftable/writer.c
> index ed61aaf59c..54ec822e1c 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -117,13 +117,17 @@ static void writer_reinit_block_writer(struct reft=
able_writer *w, uint8_t typ)
>  	w->block_writer->restart_interval =3D w->opts.restart_interval;
>  }
>
> -struct reftable_writer *
> -reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t=
),
> -		    int (*flush_func)(void *),
> -		    void *writer_arg, const struct reftable_write_options *_opts)
> +int reftable_writer_new(struct reftable_writer **out,
> +			ssize_t (*writer_func)(void *, const void *, size_t),
> +			int (*flush_func)(void *),
> +			void *writer_arg, const struct reftable_write_options *_opts)
>  {
> -	struct reftable_writer *wp =3D reftable_calloc(1, sizeof(*wp));
>  	struct reftable_write_options opts =3D {0};
> +	struct reftable_writer *wp;
> +
> +	wp =3D reftable_calloc(1, sizeof(*wp));
> +	if (!wp)
> +		return REFTABLE_OUT_OF_MEMORY_ERROR;
>
>  	if (_opts)
>  		opts =3D *_opts;
> @@ -134,13 +138,19 @@ reftable_new_writer(ssize_t (*writer_func)(void *,=
 const void *, size_t),
>  	strbuf_init(&wp->block_writer_data.last_key, 0);
>  	strbuf_init(&wp->last_key, 0);
>  	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
> +	if (!wp->block) {
> +		free(wp);

Better use reftable_free() to free it, since you use reftable_calloc()
to allocate it above.

Perhaps ban free(3), strdup(3) etc. at the end of reftable/basics.h,
banned.h style?

Ren=C3=A9

