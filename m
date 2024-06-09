Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3C46441
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717964633; cv=none; b=gDJup3gpewpHeH4foT8D57Dl/ThqQlT29KyAj1M04M9M72j/9lAXXpb9Ct05joQ9WLE1Vr59ae3X/x/QFZYiHZrXpRNjp2M0SfOaTY7NJ2kDW8/5fjQ/ReUoGY5lfQzg+MptUCC2lz4FPBLGQQxhYm+UYc1fYF+jt9u7XeLPo5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717964633; c=relaxed/simple;
	bh=fStI9Y90Klo4IAH92pTKW0HrUWlV4rOcrwuULiO8VZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tWD0OpepOArdDiw0JtgdfNQ7WnlBrZxm8K6VLgfjywBtoJcJUm4Ow4+GtdHRC784++7XIPCQg88+AzpJm2UjyaR35cSvN8s6V4/Uv6yxHd2mpGAS2v0i1mIfZbps9QNIu9m7GudvV1bqz6c7HodB5Q2T+S0K8SQjZAkfyr9Fwwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mgu0BxtU; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mgu0BxtU"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDD4A28D36;
	Sun,  9 Jun 2024 16:23:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fStI9Y90Klo4IAH92pTKW0HrUWlV4rOcrwuULi
	O8VZI=; b=Mgu0BxtUg23L/FXjs3vkH0UAZRtpH92WcGQPIOndGzjjKvyMgzk99F
	qgb15btIV1o34T3VrNcYsc9VC49fVjQwd0xDmbcJRb/lRHezjJQA1RKzNMImCRG+
	sDWp3+zNxvm+kzH0c0Bde18+mCxgWVcNlDPTIZFJ+FVsgXSwhIfZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B27CD28D35;
	Sun,  9 Jun 2024 16:23:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 394D728D34;
	Sun,  9 Jun 2024 16:23:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  Kyle Lippincott <spectral@google.com>,  Git
 Mailing List <git@vger.kernel.org>
Subject: Re: MSan failures in pack-bitmap
In-Reply-To: <ZmYJ+d3+j1E08Ms/@nand.local> (Taylor Blau's message of "Sun, 9
	Jun 2024 16:00:57 -0400")
References: <CAO_smVjSy6j7jpSxHNsxzJfxnHwjLphsqu5jwd8TBhMLp72XPw@mail.gmail.com>
	<20240608081855.GA2390433@coredump.intra.peff.net>
	<ZmXKzJ9CpbYTmTwC@nand.local> <xmqqmsnuaqus.fsf@gitster.g>
	<ZmYJ+d3+j1E08Ms/@nand.local>
Date: Sun, 09 Jun 2024 13:23:48 -0700
Message-ID: <xmqqh6e1c1bf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2E22DB14-269E-11EF-8E01-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> I don't think the issue here is a corrupt on-disk bitmap or MIDX. The
> regression that Kyle reported was a logic issue reading a
> ordinary/non-corrupt MIDX file, not a result of some on-disk corruption.
> ...
> But I do not think that repository corruption is a likely outcome here,

Yes, exactly.  What I was asking was how on-disk corruption that
would result from the logic issue of reading a correct MIDX file.

> A more likely outcome would be if a Git client who was using MIDX
> bitmaps, but only doing single-pack reuse tried to generate a pack
> to push to some remote (or vice-versa, replacing client and
> server/remote) which ended up being corrupt in some fashion. I
> haven't had enough of a chance to determine if this possible,
> though I suspect it is.

So, ...

>> > Unfortunately, the regression happened in 795006fff4, so this is in a
>> > released version of Git. But this is all behind a configuration option,
>> > so affected users can reasonably work around this issue.
>>
>> Can you elaborate a bit about "reasonably work around"?

... there is no reasonable work around here, is there?  We do not
even know exactly what kind of breakage this will cause (which is
expected, as we would be "reading" a garbage value and basing future
actions on it)?
