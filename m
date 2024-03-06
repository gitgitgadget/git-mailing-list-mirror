Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D17605DC
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747370; cv=none; b=Xi834M2qjrm6ynt3CWnKYBnmB8aJBarRvPVDpItPbW4eheGVppKCB/Yqg/ytGVbF8GvV1b33Dxhv/fGoavliHaoUw1rFhH8pO9ftl5znbBVxBZNtMgxm6Qfqutxmw52lp7p+Zj0MpiLxTJpZ77S0OKDgv20wGGgtEnuVB2EhzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747370; c=relaxed/simple;
	bh=gMAHnFJVv0OEeUQbcboO/ye1AOi1wMZejV2iaktUmlw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C1cxraeysi0UQrKiz9V/TX8RUZ2yoB8zqo2Mz09z1B6EoRdAko++PzvWt4aTNxhKmtngN0HAq3/pWkzdYMDy0zoRZlTdJG9pGsZpbPcArsujhgwykW8QKimjBSQYkRXZ1A4LbWMuBrx4/ujgls1hLF1u0i2flcNJSFpz64o6l8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MySKYpyj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MySKYpyj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C1C3E1D9283;
	Wed,  6 Mar 2024 12:49:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gMAHnFJVv0OEeUQbcboO/ye1AOi1wMZejV2iak
	tUmlw=; b=MySKYpyjhXr/W75d36BXExOnbmTNaP0h5x523eHLSXVEX0WsNm4M40
	HL1lfsMGzD3L+mbV+jHP1meFH53XlmG91JyhxZiAO7RyR/FxVk4mtD+jZCdZviX1
	HzHkpxye0kxPQgSI4LvnXuRxeJgSNTsFFiHJakfQijnb8HY02M4FM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B9E971D9282;
	Wed,  6 Mar 2024 12:49:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 259051D9281;
	Wed,  6 Mar 2024 12:49:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/7] refs/reftable: reload correct stack when creating
 reflog iter
In-Reply-To: <CAOLa=ZRQ6sYLBqjWiMXGS7rcv8pJ7jSEneiJ8ZcHtALrrcwMeg@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 6 Mar 2024 08:13:39 -0800")
References: <cover.1709640322.git.ps@pks.im>
	<b0414221ecad1920c84f4ab498e55edec57f06b6.1709640322.git.ps@pks.im>
	<CAOLa=ZRQ6sYLBqjWiMXGS7rcv8pJ7jSEneiJ8ZcHtALrrcwMeg@mail.gmail.com>
Date: Wed, 06 Mar 2024 09:49:26 -0800
Message-ID: <xmqqr0gnqmhl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E043784C-DBE1-11EE-B66F-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> When creating a new reflog iterator, we first have to reload the stack
>> that the iterator is being created. This is done so that any concurrent
>
> Nit: s/created./created for.

Yeah, I couldn't grok that sentence while reviewing it.

Thanks.
