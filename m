Received: from mail-gateway-shared11.cyon.net (mail-gateway-shared11.cyon.net [194.126.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8884F4E50C5
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836025; cv=none; b=p/pXk4eWQUCkt01wtkdrEn5xV59b0wUvqs+gzVKUPvvZQLrrOMzPxz9+vZnp4ZE74WmL7gVL/tjf+2aN+ax5kfzDWkKg+e2preY0O4s4g6I66PgXy2BZM7INObcbWh3GxZRbPSkut3Kk+f0B+FTKbVATWO7egZjQq0qYGR8tuVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836025; c=relaxed/simple;
	bh=03HpPX/jKs6OIz3rGPsLPbJCJaWuxlczaJbyo3dXJU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+oVESLYeDY2sQE5eD7bKw2uZkz65Yvwf+LwOWFGnoHuGbxlEtSDGNyDngv3LRTCRaDaP+8i1pkPv3Uj/xbA0oAsImJwf6syLTv+Ux0oNtkOh+XxChQueo2QBAmV9quikOY8z9DdVvt3bw+V0FJElyX7pTejdvCryYEtcIZ+gys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared11.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1xGMKn-000gsk-37
	for git@vger.kernel.org;
	Mon, 12 Oct 2026 22:09:23 +0200
Received: from [10.20.10.51] (port=53414 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.100.1)
	(envelope-from <dev+git@drbeat.li>)
	id 1xGMKj-0000000DV1w-3p8m;
	Mon, 12 Oct 2026 22:09:16 +0200
Message-ID: <5d5dfa51-abc3-4a8f-badd-48ee398ad73f@drbeat.li>
Date: Mon, 12 Oct 2026 22:09:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imap-send: use ASN1_STRING_length
To: Junio C Hamano <gitster@pobox.com>,
 Aniket Gupta <aniketgupta3001@gmail.com>
Cc: Xiangfei Ding <xfding@google.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 davidben@google.com, dingxiangfei2009@protonmail.ch
References: <20261011210928.3900020-1-xfding@google.com>
 <20261012151748.62723-1-aniketgupta3001@gmail.com>
 <xmqqv77696sf.fsf@gitster.g>
Content-Language: de-CH
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <xmqqv77696sf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

On 12.10.2026 19:18, Junio C Hamano wrote:
> Aniket Gupta <aniketgupta3001@gmail.com> writes:
> 
>> Hello Xiangfei,
>>
>>> +	int pat_len = ASN1_STRING_length(asn1_str);
>>
>> It seems that with OpenSSL 4.1.0-beta2 this is deprecated
>> (ASN1_STRING_get_length() is the replacement), so it warns, and
>> fails with DEVELOPER=1. The patch adds a second use at the error
>> message. Beat Bolli has a series from 7 Sept ("imap-send: future
>> proofing and two correctness fixes") that also touches
>> host_matches(), maybe we can check how the two can fit together?
>>
>> Thanks,
>> Aniket
> 
> [jch: rewrapped long unreadable lines]
> 
> That topic also needs rework, unfortunately.
> 
>    https://lore.kernel.org/git/20260907211210.2621693-1-dev+git@drbeat.li/
> 
> I guess we can salvage the patches 1 and 2 with fairly trivial
> changes, namely with the style fix in [1/3], and pointer arithmetic
> that breaks later free() fix in [2/3].  I am not sure how involved
> it would be to fix [3/3] in such a way suggested by brian in the
> thread.
> 
> Thanks for reminding us of the old thread.
> 

I'm working on a new branch that uses OpenSSL's built-in hostname
verification. All this low level ASN.1 code will disappear as a result.

Best regards, Beat
