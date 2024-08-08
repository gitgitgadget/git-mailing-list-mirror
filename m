Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6BB18F2F4
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133286; cv=none; b=ZXm5pvqAd1OYOk6Y9yzzc7LEUZTERjirTaytw2gppNWY4A6Xm8oBPumkTuSHKIlKlUzI6Ff6adbsSRbkIUJ3v1pichkiV6AqctpI2sZAFw5S5JAnIax0Tfp5l/q7DfTN7THM1z1CrKlK4LUzQ4OYG2UQ14HKiqGQnvLzLlm4lK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133286; c=relaxed/simple;
	bh=qe5O7mKUyrCi0GYyIdjnKJzN0wJKGr0P76VzjyxWOqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gFvEiR7jpSTZjCcJnpDJ+IYKhinPJM1szB5tVB+3RD2Hasfq7E2657ltqDIdKD5nWR167D8DvjS97rSdVgKfyMI/AlprUvIpPUq2mlE89MtahP6VidoyXMrNhJhsMtmr+LBYcN8lK4se+hiev8RMwl31N7s44/zoIhWS2RFFtp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hi+OygDn; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hi+OygDn"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB26E2FE51;
	Thu,  8 Aug 2024 12:08:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qe5O7mKUyrCi0GYyIdjnKJzN0wJKGr0P76Vzjy
	xWOqE=; b=hi+OygDnEvVWVihh4KKkKcgBkVGBBiImJmbtfh+Yx9Is02CQ556Bvj
	pbr5zY1mGMlSp4K7pIFQLAEmYFRVG3KQaIkrJZcWWfbc2wrcrDY/S7Wby4fMZ2h8
	YrGvDog8hb07G09MCalv/LWx1IyKiqRSGvdknOEtAm+MJ6pJnPWzQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CFFA82FE50;
	Thu,  8 Aug 2024 12:08:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0EF3D2FE4F;
	Thu,  8 Aug 2024 12:08:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Jeppe
 =?utf-8?Q?=C3=98land?= <joland@gmail.com>
Subject: Re: [PATCH 1/6] builtin/submodule: allow cloning with different ref
 storage format
In-Reply-To: <ZrRtB46vu9rC000y@tanuki> (Patrick Steinhardt's message of "Thu,
	8 Aug 2024 09:00:23 +0200")
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
	<cover.1723032100.git.ps@pks.im>
	<a450759bd1e0d84192fd8b278b660fc8527369ca.1723032100.git.ps@pks.im>
	<xmqqwmkslz7m.fsf@gitster.g> <ZrRtB46vu9rC000y@tanuki>
Date: Thu, 08 Aug 2024 09:08:01 -0700
Message-ID: <xmqqsevfj8v2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 63E49040-55A0-11EF-81BB-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Presumably, if the named submodule has already been initialized, we
>> are not converting its ref backend with --ref-format=<format> option
>> when "git submodule update --ref-format=<format>" is run.  Would it
>> make sense to say it is an error to give it without "--init", I
>> wonder.  If so, we probably would need to see if other existing
>> options like "--filter" also need a similar sanity check, if not
>> already done.
>
> Well, even when "--init" was given it is not sure whether the ref
> storage format will actually end up being used, because that option only
> tells us to initialize uninitialized submodules. So if the submodule was
> initialized already, then the ref storage format won't be used.
>
> We probably could add such a sanity check. But as you say, other options
> like "--filter", "--depth", "--reference" and "--recommend-shallow"
> don't have that check, either, so it would feel a bit like opening a can
> of worms. So personally, I'd rather defer this to another day where we
> then implement the check for all of these options.

I am perfectly fine if we stopped by clearly documenting that these
options can be no-op when the submodule repository already exists.
Failing the operation in the name of "sanity check" at this point,
especially for existing options, does not sound like a sensible
change.

Thanks.
