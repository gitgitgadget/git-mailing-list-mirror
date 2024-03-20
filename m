Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3268329CFD
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945542; cv=none; b=etdS7T5z6dOgWiPWz9Mn8mN9LrHkesbrMKHQv+cccUsa2PDblHSNXiq2KyF1MXusEq6/jreSDdL7N/4JSz/PBrXQmAd5Dtw5oIzggIPR2RlEG5lqP+4XNMdPlmP9jMU2DUY55mdDISedGu/EWEnQ0sVJ5tmh7jX178tWEM4SNNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945542; c=relaxed/simple;
	bh=9ZGRkQLQUyTIbCwfnI77VR8lm/w6quMMD5CfJ/5j1Z8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z/9BQkYTO2gSKKS6D1p6aVQhg2Pwcbw42lYTg1ORFbYnlAJrDDarqMwcMKzZkyZPlWUx+Mys1UxmhwNcGujKrXMirlLW9hynuhckZ5HA/AH8kZdAQlB42C50UEgH93giDiOOAGrFkoImUECTnzTH7yrG9g4JZD2lDXy2NfJl+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oMA8lV2B; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oMA8lV2B"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E69D1E4245;
	Wed, 20 Mar 2024 10:38:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9ZGRkQLQUyTIbCwfnI77VR8lm/w6quMMD5CfJ/
	5j1Z8=; b=oMA8lV2BIziTFF3YQLmS9J8vzmPHPVBmeWJNQ4aM3PiZqt3Za3vj0g
	Rm0KyX5wQmfn3/YcVV8PYeW0+UVsOpFw6Xv7Xh86JBjRva5fNuri2fNk2bKKKRxF
	uCm3y/p3IFntJzv1DuFl4NvBA6zokYjvFJwyLzfvnLsWrPMzKSCbk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 16AF71E4244;
	Wed, 20 Mar 2024 10:38:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7F9751E4243;
	Wed, 20 Mar 2024 10:38:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Matt Hickford <matt.hickford@gmail.com>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: Feature request: highlight local worktree in `worktree list`
In-Reply-To: <20240320100232.GB2446185@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 20 Mar 2024 06:02:32 -0400")
References: <CAGJzqsmy9RcWJeFLkZjCrrhv_y5q_R3yYUMhcyafY3jOUJFxOg@mail.gmail.com>
	<20240320100232.GB2446185@coredump.intra.peff.net>
Date: Wed, 20 Mar 2024 07:38:57 -0700
Message-ID: <xmqqedc5hsse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 960CF14A-E6C7-11EE-8C81-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> I'm not sure if this is a dumb idea or not, but: what if git-branch
> learned to display branches associated with worktrees (just like "-r"
> lists remote branches, etc).

A branch usually, but not necessarily, is checked out in at most one
worktree, so the display may become a bit more cluttered when more
than one checks out the same branch, but it is similar to how a commit
pointed at by multiple refs are shown with --decorate, so I do not think
it is such a huge deal.

> I think the only thing it wouldn't do is show worktrees that are
> detached from any branch at all. I'm not sure if that's important to
> your workflow or not.

If such a mode in "git branch --list" were written, I would imagine
that the output from such a mode will include detached HEAD from
other worktrees as well.  Perhaps something like this?

    $ git branch --list --worktrees
      (HEAD detached from ffa877cd2f, checked out in worktree 'buildtest')
      jch (checked out in worktree 'integration')
      maint
    * master (checked out in the primary worktree)
      next
      seen
      jk/branch-list-with-worktree

