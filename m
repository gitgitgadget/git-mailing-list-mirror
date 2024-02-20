Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394945942
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400654; cv=none; b=jiPB/o9ak9qKFrwTG/gyhx6Lc/nOLKtQ6sJ3Mvd26Tm2wVmhAuSLgSWieFqOI1fLQ+Qv0az6IubQo8pzkQJWonQYY7cZINLXy4lJbUVGDOv78opqeddEvt8hZyctP8hROkB5NxrO/KNHKQsb9j6yObz3hCh9GCDVy/TUoRcuh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400654; c=relaxed/simple;
	bh=Rf0T4vltT2iMRwymvWEgF3jZksASOby85tzNBa7FrCo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PSwf1kXKMohJOSwY1cRGcuQ7C6DcBgK7w2k9Hn9iLRZIidpbZ6vRaXzLATKAuKDWy2iYiBx+U0rQUi+NfQa0maAITq2xgE6oirl/UpMYrcd23vFpLE4UB6ZZD3/3q1fIaAJ5Kp7qumdSpN+Ia+aWROKwvqx53IG1u2lK9UeQMeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lYGutk2H; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lYGutk2H"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C1DB222B7E;
	Mon, 19 Feb 2024 22:44:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Rf0T4vltT2iMRwymvWEgF3jZksASOby85tzNBa
	7FrCo=; b=lYGutk2HmtmaZ8RzqhSYWbqK3L2lhaLcuKAmpqI8In7ABlxCXodNIq
	ZiAph8mRCPeXnjIkvcFnqhWTavSm5lq5/IQMoWhd5dNrjqNH4w7OqR7RwzeD/REQ
	Sg6tB7JgDiG6NKnSIcroKhezW9gPIi24VaBIm/3ovyI4APxRi5PLc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BA50322B7D;
	Mon, 19 Feb 2024 22:44:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 65BF022B7A;
	Mon, 19 Feb 2024 22:44:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ricardo C <rpc01234@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
In-Reply-To: <1d66eb0f-077a-4a63-8acf-f383538a41c7@gmail.com> (Ricardo C.'s
	message of "Mon, 19 Feb 2024 22:30:44 -0500")
References: <20240218033146.372727-2-rpc01234@gmail.com>
	<99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com>
	<xmqq34tnyhhf.fsf@gitster.g>
	<1d66eb0f-077a-4a63-8acf-f383538a41c7@gmail.com>
Date: Mon, 19 Feb 2024 19:44:07 -0800
Message-ID: <xmqq5xyjx0jc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4DF0774C-CFA2-11EE-B185-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ricardo C <rpc01234@gmail.com> writes:

> This is an issue I hadn't considered, and I'm not sure whether it can
> even be fixed. In some sense, the entire point of this patch is to
> allow the user to break that promise in their configuration. However,
> I'm not sure how big of a problem this is, as it is entirely opt-in
> (default behavior should be the same as current behavior),

Correct.

> and tools
> can be altered to pass `--no-keep-index --no-include-untracked` if
> they wish to force the current behavior.

This is not.

People expect a bit better from Git, and such a callous disregard to
backward compatibility that breaks other people's tools and scripts
is a non-starter.  

Users of such tools, whether they were written by themselves or
other people, do *not* want them to break only because they want to
use a shiny new feature that is advertised in a new version of Git.

The point of packaging a solution, the reason why they wroute such a
tool or script that happens to use "git stash" as an ingredient and
depends on the current behaviour of "git stash", is so that they do
not need to remember they even used "git stash" as a small part of
their solution.  And of course they do not want to remember that
they rely on how "git stash" behaves in such a solution.  They do
not even want to bother complaining loudly when such a change is
proposed before it hits a release and hurt them.  Saying "nobody
complained when these configuration variables were proposed" does
not help anybody later, after we already hurt them.
