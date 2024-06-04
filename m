Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B81487DC
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518575; cv=none; b=I1iYaF1No5DZGUPDSFZHR1F7VmCS8GwoEsBfklvmmufRIQ0lIBreAYCYy0tUr+bBFKpPSk5YfBi8dP/zs636ROIgfuSKOlVJVYuBV+erGR0uJJBivZaR1AZaWb4RYQwE11NgpKAkHOOJ5LbG/T2Wzs4U3rH3vGonS25cSGeAbqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518575; c=relaxed/simple;
	bh=wg4osjp8ORuVaW687V05/jEHxfzXvRkw/d+UWiwocQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hVrgEvJzUV+RskxN21KqiIlX+2OMzBly9EZqXBURn4ld8pDwkGHOKLpMckymlrlI5h5k1s8q00DGGUNmMClcNvD9DMb6Y/fLNUHUfqz/vsMsybvam0UHv9y9lr7bmmlUN4HAc4FSuXwCx+zv97PuDaCPWpmlZZII6BXHMH9gqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Owz6ok/e; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Owz6ok/e"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 86A0535436;
	Tue,  4 Jun 2024 12:29:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wg4osjp8ORuVaW687V05/jEHxfzXvRkw/d+UWi
	wocQI=; b=Owz6ok/eEyDwUw8S1QxWdesJoY95TjYKFLu9qYbQ5aN1vCXQSsDX6K
	2utRYTSLqs+dHkA3rju6bkam0FqPnEw5RG7zotjtz35HEG0XSPOXRTOFJHUTIFrz
	Z/CRttxlgJDhlUtSxtk17Tv9IwD7rBqMxdJOFhdbyqouOFb8LHQg4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7ECC135435;
	Tue,  4 Jun 2024 12:29:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF7AF35434;
	Tue,  4 Jun 2024 12:29:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Dragan
 Simic <dsimic@manjaro.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/6] pager: introduce wait_for_pager
In-Reply-To: <3f085795-79bd-4a56-9df8-659e32179925@gmail.com> (Phillip Wood's
	message of "Tue, 4 Jun 2024 11:00:37 +0100")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
	<76c725b4-1bc4-4916-81d8-98cad8fc4ca0@gmail.com>
	<3f085795-79bd-4a56-9df8-659e32179925@gmail.com>
Date: Tue, 04 Jun 2024 09:29:30 -0700
Message-ID: <xmqqo78gzn6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9F4161FC-228F-11EF-A14A-6488940A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   +void wait_for_pager(void)
>> +{
>> +	if (old_fd1 == -1)
>> +		return;
>
> Isn't it a bug to call this with old_fd1 == -1 or have I missed something?

Good point.

>> +	wait_for_pager_atexit();
>> +	unsetenv("GIT_PAGER_IN_USE");
>> +	dup2(old_fd1, 1);
>> +	old_fd1 = -1;
>> +	if (old_fd2 != -1) {
>> +		dup2(old_fd2, 2);
>> +		old_fd2 = -1;
>
> We're leaking old_fd1 and old_fd2 here. wait_for_pager_atexit()

Yeah, that needs fixing.

>> +	if (!once++) {
>
> We only need to increment "once" when we enter this block, not every
> time the code is run.

Running this 4 billion times and we'll be in a trouble ;-).

>> +		sigchain_push_common(wait_for_pager_signal);
>
> I think we should be calling this each time we setup the pager and pop
> it in wait_for_pager().

Good point.

