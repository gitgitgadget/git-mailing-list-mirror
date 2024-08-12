Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3648183CD4
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478963; cv=none; b=VhIF5zsRtWW6XV6QVXjxBNsueeKLEYP2CUN6QAivVyz5K153ZP1O9M0cSrd/mpOOiYoJHdqLzqfIDJ0abYZl/TRE+5cqfB8drUX8mWvEr/m1lbRESWyfjuQkMnp8chEwieoEKNoYwzqgJFmU2IG2nBD1VbHb1/oRUrYlYLl/e7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478963; c=relaxed/simple;
	bh=1LMuuJLl9zW7nxI/iqWSiESC9rDw2Tdg3vAllPWpwmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B7Vwz9nHlSAhb/18x02P/KP6LZOxGMiWh1SVG2KfGeHtnAB94GFGSJl3qjR+Hzvi/WxmoSEsH4oQv+0hFrFYuJtc2wzOZS6wkiy5IA9nT8vjL1ASfFiMfoDlUQbCJX8/Jh28TnobNJ4mtCT6MSfQmeINUWQMua99F92O9SXTKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i4Pvvz/l; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i4Pvvz/l"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FB782B654;
	Mon, 12 Aug 2024 12:09:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1LMuuJLl9zW7
	nxI/iqWSiESC9rDw2Tdg3vAllPWpwmA=; b=i4Pvvz/lbIvAytOZei99bEIYsm45
	Me3rOaV1x1jMEefXDkjKLUkMWNbDamRl4I/Z7knHSfMTJoR4BR3eOuL0xI9woWE0
	eRYUiZq5brxq/YlSBCVGlBeOZXynFjeyfr2UZRcCqPR798p/b7JPiJ2xGUPYqCFj
	s1U+3XyphF45EVg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 63F6C2B653;
	Mon, 12 Aug 2024 12:09:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CCB1B2B652;
	Mon, 12 Aug 2024 12:09:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>,  =?utf-8?B?6Z+p5Luw?=
 <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [External] Re: [PATCH 1/1] revision: don't set parents as
 uninteresting if exclude promisor objects
In-Reply-To: <CAG1j3zEQh3xujrU3tGOftwvCZ+d9RjvMHw8v4W3dqd3DsiGCUQ@mail.gmail.com>
	(=?utf-8?B?IumfqeS7sCIncw==?= message of "Mon, 12 Aug 2024 20:34:27 +0800")
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
	<20240802073143.56731-2-hanyang.tony@bytedance.com>
	<xmqq4j82euvr.fsf@gitster.g>
	<CAG1j3zEQh3xujrU3tGOftwvCZ+d9RjvMHw8v4W3dqd3DsiGCUQ@mail.gmail.com>
Date: Mon, 12 Aug 2024 09:09:16 -0700
Message-ID: <xmqqo75x67v7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3A1CC4BC-58C5-11EF-915A-BF444491E1BC-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

=E9=9F=A9=E4=BB=B0 <hanyang.tony@bytedance.com> writes:

> Thanks, I agree process_parents() isn't the right place to fix the issu=
e.
>
>> It apepars to me that its approach to exclude the objects that
>> appear in the promisor packs may be sound, but the design and
>> implementation of it is dubious.  Shouldn't it be getting the list
>> of objects with get_object_list() WITHOUT paying any attention to
>> --exclude-promisor-objects flag, and then filtering objects that
>> appear in the promisor packs out of that list, without mucking with
>> the object and commit traversal in revision.c at all?
>
> The problem is --exclude-promisor-objects is an option in revision.c,
> and this option is used by pack-objects, prune, midx-write and rev-list=
.
> I see there are two ways to fix this issue, one is to remove the
> --exclude-promisor-objects from revision.c, and filter objects in show_=
commit
> or show_objects functions. The other place to filter objects is probabl=
y
> in revision walk, maybe in traverse_commit_list?

Perhaps another simpler approach may be to use is_promisor_object()
function and get rid of this initial marking of these objects in
prepare_revision_walk() with the for_each_packed_object() loop,
which abuses the UNINTERESTING bit.  The feature wants to exclude
objects contained in these packs, but does not want to exclude
objects that are referred to and outside of these packs, so
UNINTERESTING bit whose natural behaviour is to propagate down the
history is a very bad fit for it.  We may be able to lose a lot of
existing code paths that say "if exclude_promisor_objects then do
this", and filter objects out with "is_promisor_object()" at the
output phase near get_revision().

Jonathan, if I am not mistaken, this is almost all your code.  Any
insights to lend us, even though you may not be very active around
here lately?

Thanks.
