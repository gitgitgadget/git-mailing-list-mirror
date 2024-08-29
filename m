Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1ED15AAB6
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962795; cv=none; b=elWZxypjiGzu0t87+ofYLFGBn41bpLpPLP5SCx4gt/SkWf0M1ujNc4R25L1wm2u3/1OE7p2fjzl+vmondOaoqcs9xK1EdXKLK22nvTwKGKN12B3YPkpX1IHWQm8QPbEeMgm8B2vFEsIT4/mzcYaIgtbx2Z4vDMpmrYCGEl46cVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962795; c=relaxed/simple;
	bh=16M5vwlzutyklqJZno3KMQuQj8m9JHlZjuM/pzCgZ4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jPbKozVlhfiEZzo7w+wJO8ItSrfrbIbuOR8iakQOokOq42wtpFTfJj+4OMJsRuhx61J2x61+SFEfM8R5UcuOhe/aOk0kxMXAobOUZAGScDLDtWMiH6lXt3XZfvu4SijJETVGrXDQV7jS+B/aUvn6FnWqOnWECS05MffOtbHf3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iTvFVY90; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iTvFVY90"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D3F6734D03;
	Thu, 29 Aug 2024 16:19:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=16M5vwlzutyklqJZno3KMQuQj8m9JHlZjuM/pz
	CgZ4o=; b=iTvFVY90vGn7csIIyHIOmve3rj63og+DKxyux6CgvdL+dkxshRGzoW
	omUZJit/ABLXwCTdHcCQrHrN09VXwdUyKaoFcXrGxjKQ6Z81Tm0Cp77udCmxlXgL
	VUVlSaSdxcBthDIFvOtJqul2hYD46/27Ps1pl1i+2PwfqKUPWFm14=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CC2EE34D02;
	Thu, 29 Aug 2024 16:19:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 422E934D01;
	Thu, 29 Aug 2024 16:19:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 9/6] git-compat-util: guard definition of MAYBE_UNUSED
 with __GNUC__
In-Reply-To: <20240829194536.GD423429@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 29 Aug 2024 15:45:36 -0400")
References: <ZsIMc6cJ-kzMzW_8@ArchLinux> <Zs348uXMBdCuwF-2@ArchLinux>
	<xmqqbk1cz69c.fsf@gitster.g>
	<20240829040215.GA4054823@coredump.intra.peff.net>
	<xmqqseunxtks.fsf_-_@gitster.g>
	<20240829175215.GA415423@coredump.intra.peff.net>
	<xmqq8qwfw6e9.fsf@gitster.g> <xmqq4j73w5up.fsf_-_@gitster.g>
	<xmqqttf3uquc.fsf_-_@gitster.g>
	<20240829194536.GD423429@coredump.intra.peff.net>
Date: Thu, 29 Aug 2024 13:19:50 -0700
Message-ID: <xmqqcylrulnd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0BC2429A-6644-11EF-87FB-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Thu, Aug 29, 2024 at 11:27:39AM -0700, Junio C Hamano wrote:
>
>> Just like we only define UNUSED macro when __GNUC__ is defined,
>> and fall back to an empty definition otherwise, we should do the
>> same for MAYBE_UNUSED.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  * Before I forget that we have discussed this, just as a
>>    documentation (read: this is not a patch to be applied).
>> 
>>    I think this only matters when a compiler satisfies all three
>>    traits:
>> 
>>    - does not define __GNUC__
>>    - does have its own __attribute__() macro
>>    - barfs on __attribute__((__unused__))
>> 
>>    Otherwise we will define __attribute__(x) away to empty to cause
>>    no harm.
>> 
>>    Since we have survived without complaints without such a guard
>>    for quite some time, it may be a sign that no compiler that knows
>>    __attribute__() that people ever tried to compile Git with barfs
>>    with __attribute__((__unused__)).  I dunno.
>
> Yeah, I was surprised that this didn't have a guard and was not
> currently barfing on other compilers. And the answer is that we already
> turn __attribute__ into a noop on non-GNUC platforms.

Plus these non-GNUC platforms either

 (1) do not have their own __attribute__, which lets us turn
     __attribute__() into noop, or

 (2) have their own __attribute__, but they happen to support
     __attribute__((__unused__)).

If somebody has __attribute__() and does not support (__unused__) in
it, use of MAYBE_UNUSED would be broken (maybe their __attribute__()
supports other things but not unused).

> Which made me wonder if UNUSED really needs its guards. It does, because
> it is defined early in the file, before the __attribute__ handling. I
> don't think we want to move it down, since it needs to be available for
> use by inline'd compat wrappers. But arguably we should move the
> attribute macro earlier in the file?

And moving __attribute__ definition earlier in the file would not
help such a platform with broken __attribute__((__unused__))

> I don't know that it is really worth spending too much time futzing
> with, though.

I am inclined to think it is not.  So let's scrap the patch.  The
list archive will hopefully remember when it becomes necessary ;-)
