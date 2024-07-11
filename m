Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2535477A
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710731; cv=none; b=qKIW+TGfmjVWwFnwG7BHYOFDd7TNLp+OusA5ZUIE/503SO8FNP0Qa0Hx+xXnYnU4oUAsoRNmwzsUkboTDSEKH3K6it3uaSWri0LFVy1HH9qqG040nxYd/uX0P60y0L45Uf1Pnv1wSw9xQ1YE+OOL6c1g/OGGmdAqOAaMhZIrFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710731; c=relaxed/simple;
	bh=+TArri9zBCGjnA51bKS+ZDPwDfeMambtazpQRcWvtlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Idk0XrHFmcIkIjtbFaKqDfAKSd+v7aHUy6tMoOtPps4q9meF3qOlceTqC/dn+DbIE+0mIP+WGoW1+i32KdBnn1usDkQLF2Bi2LCX3DPqNDKPBBCmE5PX6dL9M6GM9shmVb8apdmh14frmb7XSKyj0w8HoTP2UCRAqE9IPgsEEMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BvtQ+5wp; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BvtQ+5wp"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDC6C2798B;
	Thu, 11 Jul 2024 11:12:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+TArri9zBCGj
	nA51bKS+ZDPwDfeMambtazpQRcWvtlE=; b=BvtQ+5wpymjR9LB/Ih4br6y2fH6u
	f83quFgKtkSOmZ1rrKIBx7Rva3Tq2nOeMYzJB9bgPd7BlsgWFE76ryGEG+SM8si9
	2qYIE+VUyezLrKQYcSDq8wmr64yyQRG3DePKvzR2xTZbXfAnstSccMLBCHYA9btT
	evi89jC8l3IbW90=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C34682798A;
	Thu, 11 Jul 2024 11:12:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EA8F27988;
	Thu, 11 Jul 2024 11:12:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Git List <git@vger.kernel.org>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 0/6] unit-tests: add and use TEST_RUN to simplify tests
In-Reply-To: <38c962cd-2691-4664-b262-6eb78b8a61b5@gmail.com> (Phillip Wood's
	message of "Thu, 11 Jul 2024 11:05:34 +0100")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
	<xmqqy168uc8i.fsf@gitster.g>
	<38c962cd-2691-4664-b262-6eb78b8a61b5@gmail.com>
Date: Thu, 11 Jul 2024 08:12:06 -0700
Message-ID: <xmqqikxcnet5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F0A0CFA4-3F97-11EF-BD28-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 10/07/2024 23:13, Junio C Hamano wrote:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>> So, looking back the discussion list on
>>    https://lore.kernel.org/git/85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@we=
b.de/
>> any loose ends still need to be addressed?  I didn't spot any
>> myself, so I am willing to merge it to 'next' soonish, but please
>> stop me if there were something I missed.
>
> I thought Ren=C3=A9 was planning a re-roll to avoid using xstrfmt() in
> Patch 2 c.f <97390954-49bc-48c4-bab1-95be10717aca@web.de>. Also I'm
> not sure we've reached a conclusion on whether to include the "if" in
> the macro or require the user to write "if(TEST_RUN(...))". My
> impression is that there is a consensus building around having the
> macro include the "if" but we haven't decided what to call it
> c.f. <62d221cc-532a-4a6d-8e96-b5a246ddeb1b@web.de>
>
> Best Wishes

Thanks.  Very much appreciated.

