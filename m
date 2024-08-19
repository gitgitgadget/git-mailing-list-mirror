Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A331836D9
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087428; cv=none; b=ddHnMYkUYsoyPVrL4PkLuifw0B3vQA9kbEnoAV05kzHyKrOfztgp7xnNxcyUN5EMThmgj/PORwF9316E8wjMsZeiljHYn/aPPwQQJH6LfNCZYvcTuYynrwwgjzUldMYccvYSZJJIXbkRPwFsFlG/VcgvDlaEkycfnjKzLKrYmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087428; c=relaxed/simple;
	bh=N7y++zmhXjQfO/6plQBqbQj47DgS7YIGBuE5Z/4I+Rs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U97porY6WLBzFjVEbyMzur0RlN3usDlwofHFKwmUR11bI/XKH/Ci3V4JM38SbXvhBQS6Q79GvhG72Q3F7lrtZZsPpFdQCTD/7KjGQlECrU+PmF+IOSyIvfQJiL2wtZl/K1RCgMo3U8PdHjxAxfpmD0TNMSdfg4/1o0aBLlY2ZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sITs7Ihw; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sITs7Ihw"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A3F2B1A425;
	Mon, 19 Aug 2024 13:05:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=N7y++zmhXjQfO/6plQBqbQj47DgS7YIGBuE5Z/
	4I+Rs=; b=sITs7IhwGShLzOLPIRAGR26xkpHFV/3H6Y9kdT/Q39LBx7wcIDr9Y2
	otDnliDSnEqMIhglDgXDfhl4p/83RBAXyfttcZm1DAkfjx6bM7FzhF+dk+nX7jBP
	pH+THQQP8h0ojt2WUtl70Ch2AX/tGrQen3xlxKe4FRpQp45gMSWbM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BF981A424;
	Mon, 19 Aug 2024 13:05:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1E8D11A423;
	Mon, 19 Aug 2024 13:05:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,  James Liu
 <james@jamesliu.io>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/3] builtin/maintenance: fix loose objects task
 emitting pack hash
In-Reply-To: <20240819091715.GB2958552@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 19 Aug 2024 05:17:15 -0400")
References: <ZsLjcjhgI8Wk2tIV@tanuki> <cover.1724053639.git.ps@pks.im>
	<c25b5333f60a5920c1fade06532e3379c6686908.1724053639.git.ps@pks.im>
	<20240819085522.GD2955268@coredump.intra.peff.net>
	<ZsMLZ3Tlhxsg6Qdr@tanuki>
	<20240819091715.GB2958552@coredump.intra.peff.net>
Date: Mon, 19 Aug 2024 10:05:07 -0700
Message-ID: <xmqqzfp8e94s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 30870FB0-5E4D-11EF-B8A6-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> On Mon, Aug 19, 2024 at 11:07:51AM +0200, Patrick Steinhardt wrote:
>
>> It mostly boils down to git-repack(1) doing a connectivity check,
>> whereas git-pack-objects(1) doesn't. We just soak up every single loose
>> object, and then eventually we expire them via git-multi-pack-index(1)'s
>> "expire" subcommand.
>
> Hmph. I'd have suggested that we should teach git-repack to do the more
> efficient thing. I'm a bit worried about having parallel universes of
> how maintenance works making it harder to reason about when or how
> things happen, and how various concurrent / racy behaviors work.

I'd suggest being careful before going there.

The above only explains why it is OK not to exclude unreachable
cruft, but does not address another thing we should be worried
about, which is the quality of the resulting pack.

Throwing a random set of object names at pack-objects in the order
that they are discovered by for_each_loose_file_in_objdir(), which
is what gc.c:pack_loose() does, would give no locality benefit that
walking the commits would.  If we assume that we will pack_loose()
often enough that we won't have huge number of objects in the
resulting pack, packing objects that are close in the history may
not matter much, but on the other hand, if we run pack_loose() too
often to produce a small pack, you would not have a great delta base
selection.

So we should probably monitor how much "badness" the pack_loose()
is causing, and if it turns out to be too much, we may need to
reconsider its design.  Being able to produce ultra-quickly a pack
whose layout and delta base choice would hurt runtime performance is
not a feature.

> But it's probably a bit late to re-open that (and certainly it's not
> part of your series).

True.

Thanks.
