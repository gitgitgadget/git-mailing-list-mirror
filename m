Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41021DDCE
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711926866; cv=none; b=Q95xSt7uHp/kLSmKqOXGj9BBOXNTq1lMt2n98T8ffbElC16QoBPQRj+VVVhyEuvY8KcfniqPlqgcZ/3dpIapfgOAljQL76E5pAYqUSO98N7tBNvVwUFkIPec0hFGKK7bawZlF3HZde9NRR9DXbn7M56+CR+zzxsVbqQMYHkO9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711926866; c=relaxed/simple;
	bh=xZzRDlFSA3qCE01I+GHcTdXzickuXgcTWiqsOwbRCWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PUEoY7OH8YA+oi+Ent89VVQvjieesh94d8OV0qL4vfdjqgirdrZS8PZf6Uj6B5IQO5z/wvARZbDF/tY3+x+6ZemmehBj9zBwBOh2L+NSrsxYYbnb1frMpRuB56Ls5gcswdP6hwGJ8dedPqulHZA5WMo56VhefyLZVA6Fbn83+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JAM8D02S; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JAM8D02S"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 161891E0792;
	Sun, 31 Mar 2024 19:14:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xZzRDlFSA3qCE01I+GHcTdXzickuXgcTWiqsOw
	bRCWU=; b=JAM8D02SKOeBYOHVZqHfYUtzSBkwWAfq/zqHL1sg4piUsUg0vS1S8B
	pTzY2DV1bPN5oo8OXz9YRwLnQNlzBi6BQ+jRprK257GY62TnbGBmlfaaetlFdMRQ
	9+WHZnoG1ez9KiBXtxk84d6DXa5KnQj2JorbNZZ52kxTWIHv3dj1k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D3421E0791;
	Sun, 31 Mar 2024 19:14:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 676A51E0790;
	Sun, 31 Mar 2024 19:14:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
In-Reply-To: <CAPx1GvdXdH3OdY1nC2ijVSdpWfg8jn5=j0KB+Wgv70wWeCNH5g@mail.gmail.com>
	(Chris Torek's message of "Sun, 31 Mar 2024 15:27:24 -0700")
References: <20240330224623.579457-1-knayak@gitlab.com>
	<20240330224623.579457-8-knayak@gitlab.com>
	<xmqqy19yf40l.fsf@gitster.g>
	<CAPx1GvdXdH3OdY1nC2ijVSdpWfg8jn5=j0KB+Wgv70wWeCNH5g@mail.gmail.com>
Date: Sun, 31 Mar 2024 16:14:21 -0700
Message-ID: <xmqqplvadmeq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 68AD34D0-EFB4-11EE-8D23-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Chris Torek <chris.torek@gmail.com> writes:

> For these reasons, I'd suggest that the all-zero hash be officially
> deprecated in favor of create/delete and of course create-symref
> and delete-symref. Of course, compatibility requires some sort
> of support for the old system for some time.  As to whether that
> means something like the suggestion of ".missing" etc, I have no
> particular opinion -- but since the symref options are new, they
> would not *need* symmetric options, if we just say that "update-symref"
> cannot create or delete a symref.

I love that simplicity.

> If this (deleting the target of the symref when using "delete")
> is a bug, and I think it is, that's a separate topic of course...

"git blame" may find those who can give us answers, but my gut
feeling is that they weren't thinking too deeply about what should
happen, and the code does what it happens to do.

When you update, you'd want the update go through a symref (i.e.,
update-ref HEAD would update your current branch unless you are
detached), so they must have been aware of the fact that they need
to deal with symrefs.

But when you delete a symref, what do you want that deletion affect?
I do not have a good answer offhand, and they probably didn't even
think of the need to deal with symrefs, as the most common symref
you see, HEAD, is not something you'd ever want to delete anyway.
