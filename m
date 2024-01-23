Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B2180036
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031871; cv=none; b=e5oRUrMcK9Jqt5KfxxvUt72zAs1UV84Ylx/ONfAupja1jEEHi9oMZl+T+qXVLkai+W6pHWlKcl9p2ejbOlcq7s3yqA/CuAKg5ernSqW4l7YBhXEAl14kUhuoc9aHI3eeTnTDEEd7oexlClqTJDwsMkA+521W8VJpBaBmofhC258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031871; c=relaxed/simple;
	bh=2OgIVIBRtdcuFQr/gr58dxd7PkqjEa6xCoF5AtLMGv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eAwaxteHJE8b8HvRRnbTNwYgP9cxJJbcBEMpT/+iOPphmuTqqL1+kQU8Bw6ukLeZ5RAcif1rqH3ItKS24fjcOCITJKv4kijzlbmxrRKP4XYQwhVegpKhgAUDBGKasZRu638eetDcfJnFd/D1Bvn8D5Cix399GD+VXaTGhqjOCKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ExyZKuWX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ExyZKuWX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78DD21DB60D;
	Tue, 23 Jan 2024 12:44:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2OgIVIBRtdcuFQr/gr58dxd7PkqjEa6xCoF5At
	LMGv8=; b=ExyZKuWXraNjOouEAn0pXEQ5rM0gxZl/o1d2/3LAK4v2e0KuFp6bpu
	SiuY2osKtBodKDk9SCcolhUsMBoTRk51nxAohAwO35k5ocpjqxqDoYYWvO7sbXDh
	PBYXVXXpVeHUvcuFcvji0RhhuF3a1lTCCKJx0R4ii/Q5Tn7wt2lpI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F6B31DB60C;
	Tue, 23 Jan 2024 12:44:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD1BA1DB60B;
	Tue, 23 Jan 2024 12:44:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
In-Reply-To: <Za-gF_Hp_lXViGWw@tanuki> (Patrick Steinhardt's message of "Tue,
	23 Jan 2024 12:16:39 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240119142705.139374-3-karthik.188@gmail.com>
	<ee977173-bc6d-48f6-9bc8-e1d84fe3d95d@gmail.com>
	<xmqqplxtrucm.fsf@gitster.g> <Za-gF_Hp_lXViGWw@tanuki>
Date: Tue, 23 Jan 2024 09:44:21 -0800
Message-ID: <xmqqwms0ndvu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0B274B2A-BA17-11EE-8E2F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> My first hunch was to convert it so that it indeed always is a proper
> ref. But thinking about it a bit more I'm less convinced that this is
> sensible as it is deeply tied to the behaviour of git-bisect(1) and only
> represents its internal state. I thus came to the conclusion that it is
> more similar to the sequencer state that we have in ".git/rebase-merge"
> and ".git/rebase-apply" than anything else.

Fair enough.

> So if we wanted to rectify this, I think the most sensible way to
> address this would be to introduce a new ".git/bisect-state" directory
> that contains all of git-bisect(1)'s state:
>
>     - BISECT_TERMS -> bisect-state/terms
>     - BISECT_LOG -> bisect-state/log
>     - BISECT_START -> bisect-state/start
>     - BISECT_RUN -> bisect-state/run
>     - BISECT_FIRST_PARENT -> bisect-state/first-parent
>     - BISECT_ANCESTORS_OK -> bisect-state/ancestors-ok
>
> I think this would make for a much cleaner solution overall as things
> are neatly contained. Cleaning up after a bisect would thus only require
> a delete of ".git/bisect-state/" and we're done.

And bisect-state/ needs to be marked as per-worktree hierarchy, I suppose.

> Of course, this would be a backwards-incompatible change.

As long as we ignore folks who switches versions of Git in the
middle of their "git bisect" session, we should be OK.

If we really cared the backward compatibility, the new version of
Git that knows and uses this new layout could notice these old-style
filenames and move them over to the new place under new names.  From
there, everything should work (including things like "git bisect log").

Thanks.



