Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2B4F9D9
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577652; cv=none; b=Jvu/1bRFHRveYpNDNBn6UkIWjqQ0+5PtpeVn93NDXUuqZycYtmQP67GOUYuyk13NRuyAsVgGGkO5Ab/guhItQpOa9Z1MvRPZCyCyuUAZ+6rwP8TwQW2lOakz8ooaA0o3lMPQxPBzPECAhXoX0Hfa8GA9a9Fy5FAa5FExnfRcn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577652; c=relaxed/simple;
	bh=WkQs/iMnPBLbYssyrxoqWeAQx+QgQEh+omCmiD7NQcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GydUVfk7CDIBL5SoHeyTBEcusLm2vpxQx+sZfRd+fLi/OaluOWv6jrcJzZG04fWsOv0jRYY+pHIn3sYQLu7SbhqdKWg8pkjovTjJiQcF0KxJmqSAIrPUU417v40OqpYp6UV5ShlGc3hGhC+fWYvxHuXORtVxzU3I0lyJGazJ/gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=w+On/w9q; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="w+On/w9q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717577634; x=1718182434; i=l.s.r@web.de;
	bh=htB0mPlSl1YhcNwJzLxvU7X3QP8UddpQTJ7tDHD0GgA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=w+On/w9q2cImcywdl2nt1QpN2xuyM1rh9JSxwtUHATNqkYXqigFFwPcU06sYX4IR
	 GCEErckOj0O+kZ3qh9+4Wf+D855aNtiDnm87dnMtuBSik1K4yDpFHUgsyswT6cGb9
	 +3l7dNjHOE5Eql5HzAAxRbDrOJgKvL6ZncPPVdDGtyRU3JJNgefr+CQ7+pmClop1Z
	 /f3TBc6QllP4KEaEprgxma0EJKPHw8E46HZJd8QP/XJT+kREodqmqpn2mqig5bH/o
	 mdUqrhvGWtmgwICOVjnamx0afI1IOsP/F2zsTTF9Cq6OlD+ggbt5E8czXlFnl34c7
	 UunZccWBy9MDFrCSTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiuOk-1stcwA2wui-00iACM; Wed, 05
 Jun 2024 10:53:54 +0200
Message-ID: <f6951a8e-ab88-42f1-8c23-acc65d2d5646@web.de>
Date: Wed, 5 Jun 2024 10:53:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] dir.c: always copy input to add_pattern()
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <20240604100814.GA1304520@coredump.intra.peff.net>
 <20240604101322.GF1304593@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240604101322.GF1304593@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sS+4UWMm2mOvxeyDxw4jRsUzt8pDC9zvsWlRlTgo0zseq11Mg7h
 dFQqzzq4YRvuDLAHTMPNKkNlpQQ0lV3axNbqmT1qY4Hap5us97BM9m2g9UBz0bR+rvlaqSO
 caMWr5HQXmSK3KgDqhwdxb5W/b+AguQeYwkNwcpQWRO3PF5lSPIGwNscnh32zh01eKMWvCi
 dnLPaLY96mqwItDynghlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a8nNSuyJVeo=;JKpfGd+mDB+12jTpUSvAjdMrREY
 w37CP/r9Deqr1tVgamkS9iOwoDMY9juUPRnQzJ9BAJAKD4Xu6OU9H6eUnMmtYWW/XDByJSucF
 Jeer7HVoU6e4lfJrQOP6iMCiyx2U+nHKnUOqzQV5TaEDuknXxEfqrcKWYNEKGb8qbf/mpp3Sr
 2+alG+6TvbwJKk509HAS9LbCw3+53UWgHrpicNJ38LYD5aKnOh6Bh30DyqYSmnBpdK6YeeXx9
 XE6FHzNgngSnzdY1R/EJODfX8XRhMBtEKuFUsPEtjAfG6Xb4zlmb3OleNbWhwa95yst2o8TTJ
 yecbAV/uD0Uw5dhzDvK9hYDXMAchgNpHy7KXdWy61wEQksPiTMUNwRVtqCwsmKCLxO6szuhtG
 avhzYKXDRCC3DFDwkr6C0bnAEtuJl7NhsmNxgNu0dNaM2l7Zbrwwi20fyVcS/l2U4i4nwG6Pv
 cQRMBXazvP9WFzxoe6nZaOohMoesyO02cAs5cBhpIdWsKbUaD6e2JHLNM/v+iX5PrYx98l/fv
 ahRGEzgMRVTRwXjBKy6P2lZhOpOkwpPx2DgEigi1H9UL+DBux16Gy4f2GFutUsQCg8jlsK/JS
 8lzudwlvBHCYdiDvTX+qlGMT4gLkHEp0/JG/K05a8JWESIGB2sHwQEgy2sCRNIgG8YkdE1IPE
 0LLrXvkNk3PMKrsWVYZZyeIWYc8NcbCJkMblwq78EubH9K/K8U/r9HsgTYwip8Yuk2/6qa8U1
 eyJjFlRCsSk/yruaZCYW0Y6JsBq4B/897Gi0hqxZ5/CHxyF4u3hRo9fv1flmJDUbOumpbxge/
 yq19yU6IoIBosZk/eMlakZG7UL9gjjrnrGgH14F+CvGsk=

Am 04.06.24 um 12:13 schrieb Jeff King:
>   b. Now that we don't need the original string to hang around, we can
>      get rid of the "filebuf" mechanism entirely

Right.  This patch does remove its use from dir.c, but leaves it in dir.h:

> diff --git a/dir.h b/dir.h
> index b9e8e96128..c8ff308fae 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -62,7 +62,6 @@ struct path_pattern {
>  	 */
>  	struct pattern_list *pl;
>
> -	const char *pattern;
>  	int patternlen;
>  	int nowildcardlen;
>  	const char *base;
> @@ -74,6 +73,8 @@ struct path_pattern {
>  	 * and from -1 decrementing for patterns from CLI args.
>  	 */
>  	int srcpos;
> +
> +	char pattern[FLEX_ARRAY];
>  };
>
>  /* used for hashmaps for cone patterns */

It can be dropped from struct pattern_list now, for completeness' sake.

Ren=C3=A9

