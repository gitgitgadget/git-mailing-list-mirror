Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F47A1CEABB
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347353; cv=none; b=My24tbdXqhoDCmwPo2GZzu05PS9R7sLMAlBfAYzK0vmtNrWUS2uGZz7u6Sfu5SXj7l46T8sFw0F1a0cGLa70XD8/9KOZg3pPp+c7dy08ds9gUOf4ajCHCH3lim++3EZvsA8NTmlpUnr9pZlDZDq5T+rpn1DFgVHtS1E8jbSRqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347353; c=relaxed/simple;
	bh=dHia1665KhvzWhe2Oh7+29ZS33ktSh8QhcdxAkjrO0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VCc3uldfO5mhlcIfJYotwHKz0FyvGxT6GeG7TgLMokvcTWqsHC41VXy5MVTsk0r2gfeQwShioV8OqAUdC+wyIz7G4DHzL135u/IhxCa6r/KQrHoFuIxGsn1+6vz5JP4ksOAWtj8J0evHQmmpszWa7Dxk7w1da6WHIKR04t8rSYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=s9xdIy/E; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s9xdIy/E"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 72E581FD89;
	Thu, 22 Aug 2024 13:22:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dHia1665KhvzWhe2Oh7+29ZS33ktSh8QhcdxAk
	jrO0U=; b=s9xdIy/EOTCalb5ztY0qDJdxn+S9fOLNpJ7n9aWPQwocDRCkt6zroS
	eMpEc8+4QwqwyUS/HWMGAd8f1JNgWT9gLaUTKgVsLCO+EllJLNA1gfZa8mrVNT9V
	paDnbzz/5aBL/9oJza5VYmHDnpbYLY3p/5+dlf80473VyX9dB7hTs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B2C81FD88;
	Thu, 22 Aug 2024 13:22:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EFDDC1FD87;
	Thu, 22 Aug 2024 13:22:27 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,  James Liu
 <james@jamesliu.io>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/3] t7900: exercise detaching via trace2 regions
In-Reply-To: <ZsbPiGJlgxWiM-t9@tanuki> (Patrick Steinhardt's message of "Thu,
	22 Aug 2024 07:41:34 +0200")
References: <ZsLjcjhgI8Wk2tIV@tanuki> <cover.1724053639.git.ps@pks.im>
	<9712aae82bcb51dd94fdc10f4156e9c78e4b6d8c.1724053639.git.ps@pks.im>
	<20240819085105.GC2955268@coredump.intra.peff.net>
	<ZsMIxmX2Ash9YtEU@tanuki> <xmqqfrqxyb5h.fsf@gitster.g>
	<ZsbPiGJlgxWiM-t9@tanuki>
Date: Thu, 22 Aug 2024 10:22:26 -0700
Message-ID: <xmqq34mwsca5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1AF958A0-60AB-11EF-A0A7-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 21, 2024 at 11:38:02AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> >> ...I think this "we have no better way..." comment is now out of date
>> >> (and can probably just be dropped).
>> >
>> > Oops, yes, that one is definitely stale. I'll drop it in the next
>> > version of this patch series.
>> 
>> I am not sure if there is a need for "the next version"; in the
>> meantime, let me do this.  I'd prefer to merge the main topic down
>> to 'master' soonish.
>> 
>> Thanks.
>
> Thanks, this looks good to me.

OK.  Let me merge the whole thing to 'next', cook it for a few days
and then merge it together with the base topic down to 'master',
then.

Thanks.
