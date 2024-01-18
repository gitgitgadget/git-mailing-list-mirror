Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6102E838
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609174; cv=none; b=kIwpWyHz7V/4yH0QOwz0BOrhu5cT5ToD9Yv6v1jxd7NmeRaIg+5plLspMz5ETfW2J5b8+2p/oFpZoHCpWCXOoH3cR2rJe5rPB8UkB8CvA9C7NQxJJ4+mdNizhhKVEictxFmwrjj2LFBs0cgkJO2tIvMve1zLJrX/kyNN1JSQ0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609174; c=relaxed/simple;
	bh=Utsnbu/R9nvwtTtnw8jhOzvYDatE+woauTuX4dhbu6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gXy9pKZ0iOITAeydGLFsMlMOy1PW4UxiMwLzcyLw0VDd2jRbxxv+111Lm+Cv6wUGnzKlZQKNmHGwg3VxCnNPliJrj36ZcfkJTJ5cvXYrH+nEH0llRg1W0HmGZeM7BxXlAw7vASavGb0B9C3/OePz+3YjRGeBBBigXMUzrTV+wTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rL48GL+C; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rL48GL+C"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6821F1CC7EE;
	Thu, 18 Jan 2024 15:19:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Utsnbu/R9nvwtTtnw8jhOzvYDatE+woauTuX4d
	hbu6I=; b=rL48GL+CZWkXBe4Nj/4GqCdSUD0w8/8eX8dZPK7vfljyQkl9SWJ/SY
	2sqtW0hXfFvWzlp2ViLodNdPOecRYiMvNRlrserINyaXdWBelhlR+RnuIQZkEsNx
	mP2P01hzxb1+rQ334qShS/0OM6CtAZfyAR5OaY6WGCcL/65ikyarg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F4111CC7ED;
	Thu, 18 Jan 2024 15:19:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD9A41CC7EC;
	Thu, 18 Jan 2024 15:19:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jeff King <peff@peff.net>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <bfded0571f133ffc1612fcbca1811a43@manjaro.org> (Dragan Simic's
	message of "Thu, 18 Jan 2024 19:53:34 +0100")
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
	<d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
	<20240110110226.GC16674@coredump.intra.peff.net>
	<aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
	<97fdf6d4-1403-4fe9-b912-a85342a9fa56@gmail.com>
	<a97b03a305a7b8b95341b63af1de0271@manjaro.org>
	<xmqqil41duov.fsf@gitster.g>
	<d6d72ec5431ad1ca775e6e4e9921f94c@manjaro.org>
	<20240111080429.GG48154@coredump.intra.peff.net>
	<5f322b3e6053c27dda58ef1c1f025d11@manjaro.org>
	<xmqqil3qsdkv.fsf@gitster.g>
	<bfded0571f133ffc1612fcbca1811a43@manjaro.org>
Date: Thu, 18 Jan 2024 12:19:29 -0800
Message-ID: <xmqqwms6pf72.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E3038B62-B63E-11EE-A8D4-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> On 2024-01-18 19:26, Junio C Hamano wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> 
>>> Perhaps having both options available could be a good thing.  Though,
>>> adding quite a few knobs may end up confusing the users, so we should
>>> make sure to document it well.
>> I agree there is a need for documentation, but we are not increasing
>> the number of knobs, are we?
>
> Perhaps there would be one more knob if we end up deciding to implement
> support for both approaches, as previously discussed.

But that would be just one knob (which I personally do not quite see
the need for), not "quite a few knobs" as you said, no?
