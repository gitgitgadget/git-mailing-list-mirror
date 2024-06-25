Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B2146A81
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306231; cv=none; b=MgLY5dKsijs7xvEKe1Pd5xQIfX1SBA0D3pIaXkL1eMF7mjmcPUutIb/xlz1gk/gn9w8NjbDX6R+Wmw9uCR3KWAdPkaC9VhdCn9oQb4wrnffMuZ6Mvw40fBowkd3Ewi450+ut+nZEVeJlpYxECxFo9tVSjZW2N9LE6aoCOUh2qGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306231; c=relaxed/simple;
	bh=D9Og2xD7l9fONO92u0Z3M1kw+M8Nnev0XnA8AWP7efU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ROCvf/RYXrnbB3fwbfpQK0lR/IA0TXVEJiW0t0IpIQnCN1iJFWqvzeVOPEunfy8NxpawTn4DhzM7s0mKhAW6XFRBEX/j69uIpUXPI8Tv8LtgyMGq9NQz77ACesALD7r7MR3OLEFgxlUK5f4nrekLHvoTRUWXPFHYQZ0so4gOoWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G52NJftN; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G52NJftN"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F1A83FE1F;
	Tue, 25 Jun 2024 05:03:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=D9Og2xD7l9fONO92u0Z3M1kw+M8Nnev0XnA8AW
	P7efU=; b=G52NJftN1o+XroygPhY/OlPGEHIMlaVcZR8tvlz8pCsHyy2Bd04SA6
	CjPKCKjSV2qRM04t8BJ8gnLqOSF2AjAYY+Y5pZQ7WwIMwNnvYvnAmorye8TTXByB
	dMeoht/IHo4b9GKR2fu/+jKehcXqtPNvxQsiGMk0F/6lOzb1MMwCw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 368FD3FE1E;
	Tue, 25 Jun 2024 05:03:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9ED2F3FE1D;
	Tue, 25 Jun 2024 05:03:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Noam Yorav-Raphael <noamraph@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Regarding howto/revert-a-faulty-merge.txt - another way to
 revert a merge
In-Reply-To: <CAO8o=D5womGcsVsGT4h2=3qry05mMrd9dFDkZHrLtPCDw0+2Tg@mail.gmail.com>
	(Noam Yorav-Raphael's message of "Mon, 24 Jun 2024 13:17:25 +0300")
References: <CAO8o=D5womGcsVsGT4h2=3qry05mMrd9dFDkZHrLtPCDw0+2Tg@mail.gmail.com>
Date: Tue, 25 Jun 2024 02:03:46 -0700
Message-ID: <xmqqo77p8kct.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D51C3EE4-32D1-11EF-9040-965B910A682E-77302942!pb-smtp2.pobox.com

Noam Yorav-Raphael <noamraph@gmail.com> writes:

> This is fine, but it means that you must remember to revert the revert
> before the next merge, which may be hard to remember. I thought of
> another solution: In the source branch, add a commit reverting all the
> changes since the previous merge, then merge again from that brange to
> the master branch, and then revert the revert. In a diagram:
>
> ----o---o---o---M---o---o------------W-------
>        /       /                    /
> ------o---A---B---C-------!C!B!A---o----ABC--
>
> (`!C!B!A` means a commit that reverts C, B and A, returning to `o`.
> `ABC` means a commit that applies A, B and C, thus returning to the
> tree after C.)

These, we definitely do not want them [*].

> Now the W commit really reverts the M commit, and you can forget about it.
>
> Would you be interested in a patch adding this to
> howto/revert-a-faulty-merge.txt?

What you have above is a moral equivalent to the "On the other hand"
senario.  In the picture in the existing document, the new
incarnation of A'-B'-C' chain folks from the commit after W, but it
does not have to (it could even be a fork from the original A^).
IOW, there is no need for the A'-B'-C' chain to be strict descendant
of the original C like the above picture.

What happens in practice (and I do this myself sometimes when I have
to revert out a topic out of 'next') is

 * Revert W of a merge M is made.

 * At the very same time, the original A--B--C chain is discarded,
   and the topic is rebased on some appropriate base (e.g. the
   parent of original A in your picture, for example, or the commit
   after W in the "On the other hand" part of the exicting document,
   exact base chosen does not matter all that much) to create an
   updated A'--B'--C' commits.  While this chain is being polished
   (without getting merged into the integration branch to become a
   descendant of W), you may rebase them again and again until they
   are polished enough.  And then you merge the result, which will
   lead to "If you reverted the revert in such a case" topology in
   the existing document.

So if you want to avoid "we can forget that we have reverted"
problem, not reverting the revert, but rebuilding the entire chain,
is a better approach that gives you cleanest history to work with,
and that is what we already offer as an alternative of "reverting a
revert", not "squashed revert and squashed reapply on the side
branch".

So, I dunno if we want to add yet another one.


[Footnote]

 * We do not want the squashed CBA!!! revert or ABC reapply, both of
   which are large balls of wax that interferes with bisectability.
