Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4197E1
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727030275; cv=none; b=u2kDKcglY6xucALH2vZnJ2pURQVFhwxIKIxEY6Wvxd2wauZF0w9fu4BntrVQh1FkuoM+JY+v2F9aP8Vlis0zsq8s3fMSQtrceYnUnoQRldQMcuIB80/R73U9snoC5gVWZR8vi97Q0WFrBk9Xm7PnU5wbqljAvzF1zglZOCdedpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727030275; c=relaxed/simple;
	bh=Q05QtrWl/ht0y+e0iGQhOBUxVASiL2dDOQR7S3AmxSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SJvI+7SDluaeB5+0J0AMiwsE0bDnyxP+HYsBqYLIcBnuSfFMyYFuXK7LKrthlKfQ4S3+r35Ci8srInrQ7RHo+xgzW9aJ+iV4EN6biGqSDuEPELxrWagSkHqi4SBCd91GrqYW5ziDwpypyRfNDaO5cbZODNKts72sKp+/vhEx1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bNo7cIyI; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bNo7cIyI"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3DF23944E;
	Sun, 22 Sep 2024 14:37:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Q05QtrWl/ht0y+e0iGQhOBUxVASiL2dDOQR7S3
	AmxSQ=; b=bNo7cIyIYO92Ikgut/XOhkIJEV371ZpE5LwSBrqUJ0X9Wm9B/9aT/5
	cqNuvu9YOMomq1SnY3yQs/LP+U5mQcyDDQMuFULMRIG2KjS9rCTAF5/kTCBYffLS
	oTNETq9oM93iccyBLl3TTGrLKPzRg3hGfHsHzGx57MLkFmzl+R0wg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AC033944D;
	Sun, 22 Sep 2024 14:37:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2A543944B;
	Sun, 22 Sep 2024 14:37:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  Derrick Stolee via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  johannes.schindelin@gmx.de,  peff@peff.net,  ps@pks.im,  me@ttaylorr.com,
  johncai86@gmail.com,  newren@gmail.com
Subject: Re: [PATCH 00/30] [RFC] Path-walk API and applications
In-Reply-To: <53dc17f8-82e5-40fa-81b7-af89f987928b@gmail.com> (Derrick
	Stolee's message of "Wed, 18 Sep 2024 19:18:27 -0400")
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
	<CAP8UFD0uyVk5WPX12sGhWWXkdQWGpBhG29Q-9EmBxHos1XQ_uQ@mail.gmail.com>
	<53dc17f8-82e5-40fa-81b7-af89f987928b@gmail.com>
Date: Sun, 22 Sep 2024 11:37:43 -0700
Message-ID: <xmqqplov7cw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C221A280-7911-11EF-831D-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> Combining the two features actually ends up with very similar performance
> to what `--full-name-hash` already does. It's actually important that the
> `--path-walk` option does a full pass of the objects via the standard
> name-hash after its first pass in groups based on the path.
> ...
> I was not clear about this, but the RFC is 30 patches so it's possible to see
> the big picture, but I will be breaking it into at least four series in
> sequence for actual review. They match the four sections described above, but
> will be in the opposite order:
>
>  A. `git repack --full-name-hash`
>  B. `git pack-objects --path-walk`
>  C. `git survey`
>  D. `git backfill`
>
> (It's possible that `git survey` and `git backfill` may be orthogonal enough
> that they could be under review at the same time. Alternatively, `git backfill`
> may jump the line because it's so simple to implement once the path-walk API
> is established.)

I actually was hoping to hear something like "since it turns out
that --path-walk gives a better performance and it does not regress
small incremental transfer like --full-name-hash does, the real
series drops --full-name hash", i.e. without part (A).  That reduces
things we need to worry about (like having to either keep track of
two "hashes" per object, or making small incremental transfer more
costly) greatly.

Thanks.
