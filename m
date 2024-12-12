Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892AE18643
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970631; cv=none; b=ZboeR5Rs8bPWORvDhmwTsBihuLnYlV/J+X+OHrMdSib7dlC3IukdqC426oQ5sXRu37r1Jh6GOCxL9Ss+4wEURPDKJGC2Srh3Te8j6fwmqY3rxR9NWkkM47uBZdxtzdDIWMhEvkXEwS6oCvQQ5c3MUuKZv54tTyX3xFLqBP0vxCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970631; c=relaxed/simple;
	bh=YO4/6XF6alF6yYpuSbcQqPeFdYlN7db8zStmhwyQ6UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NipeRT4rsJ/irsYp67UVW2RRfv4CeD3jhvNxKA3qjwAS6Q/ROG7wcy/wuc8RwV5QvxCR+d7E8DMaq9gdjayE3gC0TJi+ys9uG5J0Jn+v/tFQ3FR5Ha75JphMat6eM/Imz6fzIqsTIHT9o9sFujJouxM47qfL45VzNPQtrla/PQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XKv2JwSt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XKv2JwSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3862C4CED2;
	Thu, 12 Dec 2024 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733970631;
	bh=YO4/6XF6alF6yYpuSbcQqPeFdYlN7db8zStmhwyQ6UA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKv2JwSt2OQ+/kju3Y0NCdasimIn+F3lZVk40LL8FfASdlb8bxTYmPo9cmSLEfPCG
	 C2c1oNP7KTb8vVJ2jziuqdJT/yZpoijkZM9yk/D0/jXcPTqx9y2jzmkdSCdsCmGqqD
	 QIvWBj3F6DXF3E9KyFh07Tm2UPeQKR2Ee8lkETIA=
Date: Wed, 11 Dec 2024 21:30:29 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Subject: Re: branch description as a note?
Message-ID: <k2z27rszfw2zs3sz5f5rbxdsvv3h3b3ghrk4nbz2lgtec37wd3@tlelxyujzm5t>
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
 <xmqq4j3ai4it.fsf@gitster.g>
 <sem23vxg5c3xc62wvy5qn6gvoh6hc6m75mx35zgwsdyw36oexm@ayfez6uqghtt>
 <xmqqa5d1he7a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5d1he7a.fsf@gitster.g>

On Thu, Dec 12, 2024 at 10:39:37AM +0900, Junio C Hamano wrote:
> So, forgetting Bence's "branch description" for a while, let's see
> if we can summarize the assumptions the older discussion had.
> 
>  1. We want to summarize what is on the branch, to help the reviewers
>     and also the original developers.

Plus keep track of the history of the branch evolution (such as changelog
between different submissions).

>  2. When the branch gets accepted to another branch that is higher
>     in the food chain (e.g., an individual developer has a topic to
>     improve a kernel driver for one specific hardware, the developer
>     describes what they did and give the branch to the driver
>     maintainer, and the topic gets merged to the driver's tree. The
>     resulting merge may not yet be in Linus's tree, but from the
>     original developer's point of view, the topic is "done" for
>     now), a merge commit will use the "summary" created above in the
>     messages of the merge commit.

Correct, though this is a very Linux-specific example. Some of the other
projects have specific workflows restrictions that require that all commits
are linear (e.g. glibc/gcc) -- using merge commits wouldn't be suitable to
them. However, I think they are outliers in this regard.

>  3. Once that happens, as it is etched into the merge commit, you
>     cannot update the description anymore (unless you and your
>     maintainer arrange to discard the merge and take an updated
>     branch), and that limitation is acceptable.

Correct. Normally, once the maintainer accepts a patch series, no further
changes are made to its contents. The pull request set to the maintainer's
upstream (=Linus) will be accepted as-is or rejected as a whole, as a general
rule.

> The idea to use an empty commit is to make it easier to communicate
> the "topic description" between the author and the maintainer.
> During the development on the branch, the empty-commit that holds
> the description can be updated using the common "rebase -i"
> workflow.  If the empty commit were at the tip of the branch[*], we
> can teach "git merge B" (or "git pull") to notice that the topic
> description is in the commit B at the tip of the branch, create a
> merge with B~1 instead, and when recording the merge, offer the log
> message of B to help the maintainer write the log message for the
> merge commit.  The e-mail based tools would need some changes (like
> allowing "format-patch | am" pipeline to pass an empty commit), but
> the principle is the same.

Yes, and the commit would have two parents, one pointing at the previous
commit and the other pointing at the base commit, which would help the tools
identify where the series starts and ends.

> If Bence's "branch description" is for a use case where the
> description need to be updated even after the branch gets
> "concluded" by being merged to the upstream, that is not a use case
> the topic description stored in an empty commit on branch we
> discussed earlier would cover, I suspect, as the primary focus is to
> make it easier to maintain in point 1. above, and finalize it in the
> merge commit to describe what was merged in point 2. above.
> 
> 
> [Footnote]
> 
>  * IIRC, there were some who preferred to make the description empty
>    commit at the bottom of the series, and while it is possible to
>    arrange such layout, it makes the eventual "git merge B" a lot
>    more cumbersome (i.e. you'd need to rebase B onto the
>    maintainer's tree, except for the bottom of the branch, and use
>    the message from the now-discarded commit for the log message of
>    the merge commit), and it would force developer to rebase the
>    _entire_ branch every time they need to update the description.
>    So I strongly prefer "description at the tip" layout, but the
>    choice between bottom and tip does not affect the 3-point
>    assumptions above.

Right, this is what b4 does, but b4's use case is very specific in the sense
that the series will almost always be sent out to the list and then applied
from there, and never merged directly from the work branch. This *has*
happened before, notably, so this assumption does get broken.

Since the series is intended to be sent to the list, the fact that it is
continuously rebased doesn't really matter, because the commits themselves are
ephemeral and don't mean anything in the long term.

Additionally, keeping the tracking commit at the bottom of the series is just
the default strategy. There is also a way to make it live at the tip of the
series, but it has its own awkwardness that will almost certainly trip up more
newbies. If git does get a native way to use such cover letters, I will
certainly switch to that as the default.

-K
