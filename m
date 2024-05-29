Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC29C15884C
	for <git@vger.kernel.org>; Wed, 29 May 2024 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992975; cv=none; b=OX3ymUr5Bn3iBotKmUjP+HdPy62JlQ9AMzSJP7TRf1DpOkJwXcsVJplJklr7c7E2mr9irXyVtymSjnfPV8iSKhpgr0vNdY53JD/UjJOHqFAa8P0AHE4ubOiAQyq+dy3ZTAPxh2/IDzwM9gTUfSQGAEXJ76FJU6AgTAkplFrCGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992975; c=relaxed/simple;
	bh=eEyUv1kEuT1at+AHvY8a1CdMKskuIPmosUo4qPnWmts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0XL1/cYSg67UTyWhqhGtZF/q1sKA+sXdxtlskz4wX98y82ToL5K1X24jukjHVcP9VmdiKNCDffTMv+jxxa/KHTf4kcQCS01hnV6q/DHZFJqO8zW68yPO2V8o8f9AxuTVZm6P3BeVpAhjaG0wP+ImHxVPQDyg7fP6igA7i93u5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KfMp/Kiz; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KfMp/Kiz"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ADC2932040;
	Wed, 29 May 2024 10:29:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eEyUv1kEuT1at+AHvY8a1CdMKskuIPmosUo4qP
	nWmts=; b=KfMp/KizY4Ouqq3IFROEd5iC14eoORO7DDBPVZwlYY/hlYwt5iK6pR
	u5EoNvwnpW6LOF9iYKRLjj8r+bUG1HTCrK03+i9CRbevT09+4BqymScxctFP/lB/
	lsGIVxevHCEf9zbVAUINlBSVHhxMyyF7iF42XSYB3mlnhcCzfpa9Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A6CC83203F;
	Wed, 29 May 2024 10:29:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A5EF3203E;
	Wed, 29 May 2024 10:29:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: move range/inter diff at the end of a
 single patch output
In-Reply-To: <Zla-GJ6NpSNNVDXq@tanuki> (Patrick Steinhardt's message of "Wed,
	29 May 2024 07:33:12 +0200")
References: <20240523225007.2871766-1-gitster@pobox.com>
	<20240523225007.2871766-3-gitster@pobox.com> <ZlB2g5bTuBFz5m5_@tanuki>
	<xmqqo78ukhmk.fsf@gitster.g> <ZlQX0FmIsz2eFgsC@tanuki>
	<xmqqsey39mmt.fsf@gitster.g> <ZlXbxzFOJ8gVv7r5@tanuki>
	<xmqqv82x6fto.fsf@gitster.g> <Zla-GJ6NpSNNVDXq@tanuki>
Date: Wed, 29 May 2024 07:29:31 -0700
Message-ID: <xmqqplt41yk4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DD5B3C0A-1DC7-11EF-B226-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, May 28, 2024 at 09:50:43AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > Yeah, that's definitely better. Whether it's preferable over having it
>> > after the signature separator I don't know. I personally liked that
>> > version better, but can totally see why others may not like it.
>> 
>> I do not think anybody posted a version that writes inter/range diff
>> ater the signature mark.
>
> No, I'm talking about the version that you hand crafted initially and
> that kicked off this topic.

Ah, https://lore.kernel.org/git/xmqqh6ep1pwz.fsf_-_@gitster.g/ I
forgot all about it already ;-).

> ... I just don't have a strong preference between the old and
> new formats by now. If you or others feel strongly I don't mind at all
> if this patch lands.

Let's scrap it then.  I do not think a single-patch topic happens
all that often anyway.

