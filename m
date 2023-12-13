Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hQLk9j6L"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E07F99
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 11:20:53 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA7811C8A7A;
	Wed, 13 Dec 2023 14:20:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0vdZFdv+lyylfQP+JcHJPN0PFgX++rAlNoZv5n
	bJ6T0=; b=hQLk9j6LFTTKCh/aZAgiuR40lSHEQLbPf/iLR6Og949NSndQzyvA8j
	TTRcvmuwk2+kYdZLrMHe9XFdI6j+10Fc2vF3KfItwcG4mq9h/oxOSNNhEwMy4DP/
	r2l+FrMZCDD+OLtCYvJpHth6uoHuUCcjxTpai5lBY1y3YfCDhDdIE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEDF41C8A79;
	Wed, 13 Dec 2023 14:20:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3693E1C8A78;
	Wed, 13 Dec 2023 14:20:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 05/24] midx: implement `DISP` chunk
In-Reply-To: <ZXn33HVBFqidAThn@nand.local> (Taylor Blau's message of "Wed, 13
	Dec 2023 13:28:44 -0500")
References: <cover.1701198172.git.me@ttaylorr.com>
	<c52d7e7b27a9add4f58b8334db4fe4498af1c90f.1701198172.git.me@ttaylorr.com>
	<xmqqjzpv4ecg.fsf@gitster.g> <ZW95WSErCXvkfrAG@nand.local>
	<xmqqlea4nofm.fsf@gitster.g> <ZXPRL5yCTQKr0k7e@nand.local>
	<20231212080332.GC1117953@coredump.intra.peff.net>
	<ZXn33HVBFqidAThn@nand.local>
Date: Wed, 13 Dec 2023 11:20:50 -0800
Message-ID: <xmqqwmthnc31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BAEBBE38-99EC-11EE-B942-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>   - Turn any cross-pack deltas (which are stored as OFS_DELTAs) into
>     REF_DELTAs. We already do this today when reusing an OFS_DELTA
>     without `--delta-base-offset` enabled, so it's not a huge stretch to
>     do the same for cross-pack deltas even when `--delta-base-offset` is
>     enabled.
>
>     This would work, but would obviously result in larger-than-necessary
>     packs, as we in theory *could* represent these cross-pack deltas by
>     patching an existing OFS_DELTA. But it's not clear how much that
>     would matter in practice. I suspect it would have a lot to do with
>     how you pack your repository in the first place.

I have to wonder if the cost of additional computation to see when
is safe to allow cross-pack delta can be kept reasonably low, as
you'd need to prove that you are not introducing a cycle by doing
so.  Compared to that, spending a dozen or so bytes for the offset
for rare cases of having to express such a cross-pack delta pair
would be much less worrisome to me.

> Thanks for the terrific suggestion. I'll clean up the results of trying
> to implement it, and share it with the list soon (ideally before the end
> of this week, after which I'm on vacation until the new year).

Good to hear that you'll be recharging soon.  Enjoy.
