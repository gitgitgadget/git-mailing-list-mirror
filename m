Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2FB278156
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591376; cv=pass; b=Vr1l/Y8lolttHjvlsHX6crDzlhytaxufJC8trhB3tgQyWatIwftSuW4tse1eYJBXGR74Bz7HguXdehS76zoTvMvUZA9+84SVHO0/4EmMGhmND8c7ZE5d0kpd+2adspDVGm1k3zeTloDGt6tS+umqq+yEUWcSYAPINWnqctyNta4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591376; c=relaxed/simple;
	bh=fQc8HU92JTzr/JGddqe68nIApt98fXioDuSn42mQClU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qm1F2WNbUD3B2Bd+MuvWNnNgX0g1jRkDOJckFgJabU+AueCGcIs1WiZbcNPH/vrTwGuo1OMl13ejEnis+8KBOduLigfuGNwB65XvkFF86AhG7D3mDcfXXxsYzmVqCAQInLdV3vHGPlouKunlIAToAFq/ix/TbJKO/GLKYII2tAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=WraXaQTM; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="WraXaQTM"
ARC-Seal: i=1; a=rsa-sha256; t=1771591355; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D01EH0oM03XTCw47+VnJlphgpiZRM7BbBZyNOXb6UBmBE8b6fuauMT5btOwmG+nSf55fWB2sTTSByMpGFXIqXzeKb/JNUl2pRCLjxOVubh8A6GW/rSL7A1BfvRTZzrBper6obVrJFx17+MkMLR2ZWH1P9l4n0be/nnuFnkCd8cU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771591355; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ODQ5K4/YUtMWiA1GiIFpxXllF7eD+//hnpD/A/Vc4Yc=; 
	b=J6UPUicMtOgXs0KMubhIvWsL6OOEXj2Ol4l+ivNGR7YC/2Gtay7NVgdC1K628WQFZ5/fo3lQfenjIAIQUJAmS09fu3cBaAzn0BLGc0rvA+ct1edzqnXujKlIK/vs9JPZmByAkgcM4PbA83MRnmQ/Vq4pkydyCPchu/0UkXu586E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771591355;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=ODQ5K4/YUtMWiA1GiIFpxXllF7eD+//hnpD/A/Vc4Yc=;
	b=WraXaQTMouAuWuDm6slaFXMWo8qyz/R0n7hV+/qHqb1uittObA+SahRvGdGpW33o
	ZLVqXs8B6OUalCa3aGICE46VuXfczW8PURf/4ZhqwIP9OW3PG20hPa365C70dH+ddq1
	f9uIUFc4g0QH7Frj0YaoO8Fi4IMple6nUpDV+iaA=
Received: by mx.zohomail.com with SMTPS id 1771591352615754.9238190912952;
	Fri, 20 Feb 2026 04:42:32 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/8] hook: add internal state alloc/free callbacks
In-Reply-To: <xmqq4inc2yom.fsf@gitster.g>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-2-adrian.ratiu@collabora.com>
 <xmqq4inc2yom.fsf@gitster.g>
Date: Fri, 20 Feb 2026 14:42:29 +0200
Message-ID: <87ikbry4ay.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Thu, 19 Feb 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
<snip>
>> -
>> -	strbuf_init(&feed_ctx.buf, 0);
>> +	opt.feed_pipe_cb_data_alloc = transaction_feed_cb_data_alloc;
>> +	opt.feed_pipe_cb_data_free = transaction_feed_cb_data_free;
>>  
>>  	ret = run_hooks_opt(transaction->ref_store->repo, "reference-transaction", &opt);
>>  
>> -	strbuf_release(&feed_ctx.buf);
>
> As the run_hooks_opt() machinery internally manages the
> feed_pipe_cb_data, starting from the call to the custom alloc
> function and concliding with the call to the custom free function,
> this function no longer need to manage resources.  Instead, the
> custom alloc/free functions take care of all the associated
> resources, like the feed_ctx.buf strbuf, as we have seen earlier.
>
> Nice.

Exactly, yes.

This reminds me: I need to verify the header files and the APIs to
remove/update any comments about callers having to manage the these
resources.

Will do in v3.
