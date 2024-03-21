Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F91332B3
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711048808; cv=none; b=DIxgeHE8P+mudRWApJlKuUe9fsJdiM4aBX0WTSDgOC5c/ZBUmSGgg/S7yiQQ7SPx9HkA1BS52RWk5edmm6sGXNMdXb2djwa1V5edfZamG2g46h94/oMFuLMV98wV8uU7kut+00BAeU6WedaKWAK0DdhA9BsLmsVZJFa62FvVxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711048808; c=relaxed/simple;
	bh=uBkj6fQIBEYJvHcQsVHG7LpmpPTbxQLSeJw/Otw4/3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Id52DKnzudk8atEolnBT15Rn52Dgz6Zq0lB9IEYVIxQxbUSlyB397PsHSwSGSzgqY+eMiMbk+BVBjiAELvg17ZYK7DG+n0gYh4R6ObpRlBNJvOshyGcztmNebxwQ6hhb+pPergwCVcsvl4d7aqDifiOh+q3MFF7KwhGbmuwREho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BTxeS12j; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BTxeS12j"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D2D62D6C4;
	Thu, 21 Mar 2024 15:20:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uBkj6fQIBEYJvHcQsVHG7LpmpPTbxQLSeJw/Ot
	w4/3Y=; b=BTxeS12jylaqbf0mIxWTo0cQzNZX03RCrr6okSqqq4CDHPgHsKFB7g
	qKVeNxlYloIsrFnjr3kMz3bNuALLAF/gTUlIVQr3xZIjGFaxzZ/kDjie5keiyKMS
	bMOiegi3DfZ37wRCeR+peKCDzi192K0DeLcfPsL0GE3jDU/BPKTrM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 953062D6C3;
	Thu, 21 Mar 2024 15:20:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B20512D6C0;
	Thu, 21 Mar 2024 15:20:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: status could list ref names after "HEAD detached"
In-Reply-To: <CAGJzqs=ULaHwttY1jRaW4ZT0tGeSW2S_gcEw=tMrY+i26Jy1gA@mail.gmail.com>
	(M. Hickford's message of "Thu, 21 Mar 2024 08:00:00 +0000")
References: <CAGJzqs=ULaHwttY1jRaW4ZT0tGeSW2S_gcEw=tMrY+i26Jy1gA@mail.gmail.com>
Date: Thu, 21 Mar 2024 12:20:00 -0700
Message-ID: <xmqq5xxf8k9r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 03B77724-E7B8-11EE-B96A-A19503B9AAD1-77302942!pb-smtp21.pobox.com

M Hickford <mirth.hickford@gmail.com> writes:

> I frequently run `git status`. Sometimes HEAD is detached:
>
>     HEAD detached at ea601b57e
>
> It would be neat to include ref names here, similar to git log:
>
>     HEAD detached at ea601b57e (origin/main, origin/HEAD, main)
>
> This gives me more information before I create a new branch or switch branch.

This has already moved away from the original "I want to know on
which branch other worktrees are working" feature, but while we are
expanding the edges...

I wonder what you want to see when a detached HEAD deviated from its
initial position (i.e., when we say "HEAD detached from", not "HEAD
detached at", in "git status" output).  Would we still want to show
the "--decorate" list of existing refs for the original position?

    $ git checkout --detach master
    $ git status | head -n1
    HEAD detached at 3bd955d269
    $ git checkout --allow-empty -m empty
    $ git status | head -n1
    HEAD detached from 3bd955d269
    $ git reset --hard HEAD^
    $ git status | head -n1
    HEAD detached at 3bd955d269

If we add "(master)" after 3bd955d269 in the above illustration, I
wonder if it makes it too misleading.
