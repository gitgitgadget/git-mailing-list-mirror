Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D68B19EEDC
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254632; cv=none; b=kgZpRuxeISK8svL0w0jI//Mvk2wR3R8RfulQhqI8sRtFRM9HR9QqEXmrO0+P4t9DdelB6BwnGFGq3q3UoDKlOhddFGDqx8KpGFKfQgZSdR4ewi5I40XfYcjnOBcRImzaiUPqQ0NOyIl2BFaUaKAu5GDmru1hblQab3rxRGdWD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254632; c=relaxed/simple;
	bh=/r4rJTuePMY8ecQMB8fzPR0TWtDok5VD5/iJYWf/CLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WwgPyTFyBG12AmTAUUUT8/kD4HbaP1pi80zP7ZDpoG1RRWrKrBtg4oLbWnPxq0pKvDTmNMo3ApyWiVgp/d/LkpTCHx1r0HQBXvj5B71g4MOSGY5Zq37fdQJzs53zfg4Hh1SENYCxJ/yxVGtuCk83P+rzn0LyelV8X/tVBh1kO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DEjbRK06; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DEjbRK06"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DB20F3060E;
	Mon, 24 Jun 2024 14:43:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/r4rJTuePMY8ecQMB8fzPR0TWtDok5VD5/iJYW
	f/CLA=; b=DEjbRK06XTmTSJ1w46SC/4HYaIUFRkjdA0FDiCW2i5aY48NCzSprmt
	Xc84PQRblA11CIxayqcG0sbHPZK9Pfp0oDok8L/govMPgNgUiigPAVkuKooHPqM1
	0UQhVNzm+rvbn9zTbAcrdVrvRJLYDgyq3JLd4tBI1g4BALdjaTEQ8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CFC013060D;
	Mon, 24 Jun 2024 14:43:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F22D63060C;
	Mon, 24 Jun 2024 14:43:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stefan Haller <lists@haller-berlin.de>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Git <git@vger.kernel.org>
Subject: Re: Thoughts about the -m option of cherry-pick and revert
In-Reply-To: <0a948acf-ebe9-407e-8899-d714b6fcb528@haller-berlin.de> (Stefan
	Haller's message of "Mon, 24 Jun 2024 09:33:24 +0200")
References: <e60a8b1a-98c8-4ac7-b966-ff9635bb781d@haller-berlin.de>
	<xmqqa5jfoxvh.fsf@gitster.g>
	<dd58a60d-a551-4726-85a7-f47b851914be@haller-berlin.de>
	<6e71b1f3-599f-49c3-be37-e499f28983cf@gmail.com>
	<xmqqv822ntkh.fsf@gitster.g>
	<0a948acf-ebe9-407e-8899-d714b6fcb528@haller-berlin.de>
Date: Mon, 24 Jun 2024 11:43:46 -0700
Message-ID: <xmqqmsnab2ql.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B15030BA-3259-11EF-B11D-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Stefan Haller <lists@haller-berlin.de> writes:

> And we prefer single-commit cherry-picks of the merge commits because it
> makes the history of the release branches easier to read.

I would have expected that "git log --first-parent" would give you
the same "easy-to-read" history as a run of squached cherry-picks.

It of course takes some discipline to ensure that the first-parent
chain is kept meaningful, but "never merge, always cherry-pick the
merges of topics" also already takes some discipline, so I do not
see either workflow has much upside with respect to this point.

> I'm not saying I'm very happy with this workflow, it wasn't my decision.
> And in particular I'm not trying to argue which workflow is better than
> the other; all I'm saying is that there are teams who decide they want
> to cherry-pick merge commits, so git should continue to allow it. This
> is only in response to your earlier "If I were simplifying this, I would
> probably [...] disallow cherry-picking a merge".

Sure. I thought it was fairly obvious to everybody that I was not
"simplifying this", at least unilaterally, so raising a concern like
you did was the right thing ;-).

> (Side note: my main gripe about cherry-picking in general is, of course,
> that it makes it impossible to use "git branch --contains" or "git tag
> --contains" to find out which releases contain a given bug fix; but
> that's a problem no matter whether you cherry-pick the merge commit, or
> replay the branch on maint and merge it there again.)

Correct for the "cherry-picking", but not necessarily for a "rebase
and merge".

You can have (1) a "fix" based on the "main", and (2) the backport
of the same "fix" rebased on the "maint", the latter of which has
likely been spawned after the former was merged to "main".  You can
merge the "rebased fix" to the "maint" *as well as* to the "main".

If we think about it, that is a natural thing to do.  By rebasing
"fix" to "maint" to create "rebased fix", we are "correcting" an
earlier mistake of basing the fix on a wrong (iow, too recent)
point, so after such a rebase, we treat the rebased result as the
primary thing.

After that, "contains" will do the right thing for the "rebased
fix", which is now the primary fix, and shows both "main" and
"maint" has it.

Of course, a project can choose to adopt a workflow that refuses to
obtain such a benefit (presumably for other reasons that gives
benefits that outweigh the "sigh, we cannot merge but have to
cherry-pick, with all the inconveniences").
