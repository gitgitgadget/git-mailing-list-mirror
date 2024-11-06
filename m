Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0DF1CD2C
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853081; cv=none; b=TxGATkTf+JHvB55cJM/AIlzY+3D5jSmAlcYXOnYEneb5dYem9pcQsbYLLJlN2iRnncfzEsesX2pjrWWLgP6YW6Qiu+mD6TQyIwGe8eqrvHShK2esHMjoa2AycG8mfGTUVmmn9hhCsYAW4tq4a76KTKdVOsRvaFRIdivlhmS9jU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853081; c=relaxed/simple;
	bh=g+02nziRTEYwyHjp3sFBHxhK6/xc/qJ7NeEchivU+nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odd2ThQIDQcR7EH6Ru2wq+rUN+NWQenAVVSq9f63Bh4xuy4o3RWNVDJLAa/7i29MB3zUpF7sNVEbeSUXivajK0jJBAlbbDoip3xMOpAhaFePMaYLHRdAoFj6GrY/tsGhsCOrc4x2I21uEWK8vjMVAcLZ6ULSyJeofKoMJfq96/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iCltz7mP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iCltz7mP"
Received: (qmail 32281 invoked by uid 109); 6 Nov 2024 00:31:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=g+02nziRTEYwyHjp3sFBHxhK6/xc/qJ7NeEchivU+nY=; b=iCltz7mPvaLDrS/Lx3ugdw7rwoYuMOny4GS6CwYslBya54NZ6NtIyCv2xOe87ppRMgARmCM06JLq6LtrdxUhYIrKpcdjxuPHClAItnHWzDImKwhhkeuPeD2P0fBY1wqFbVmP0894+V9Y3NOQjzyz9K2OS2/5N/BIp4nLCmUkdr7ty9A3ALnraM08DQRxG9n6QoUFIictg7cIRZqgv0nCN3NFPSKYXEOYIH52y2DVZo2Whp05fghEyd2/C+UHpX4RaNh3JribCVQVfC/BssHRXjcvHuxJLiRJ4JrKM6t9AbDbuFFSzNzcQmOolblnnSWxdn1H48suMdSJP58djkkKxw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Nov 2024 00:31:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30405 invoked by uid 111); 6 Nov 2024 00:31:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Nov 2024 19:31:11 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 5 Nov 2024 19:31:10 -0500
From: Jeff King <peff@peff.net>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's so special about almalinux-8?
Message-ID: <20241106003110.GA814887@coredump.intra.peff.net>
References: <xmqqbjyuted3.fsf@gitster.g>
 <20241105185439.3230561-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105185439.3230561-1-jonathantanmy@google.com>

On Tue, Nov 05, 2024 at 10:54:39AM -0800, Jonathan Tan wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> > Everybody else seems to pass tests, but not this one
> > 
> >   https://github.com/git/git/actions/runs/11677884048/job/32516504151#step:6:1995
> > 
> > I am not (yet) so familiar with the topics in flight at this point,
> > but there are a few topics that deal with packing, lazy fetching,
> > and commit-graph and object database being out of sync, which were
> > handled by a few topics by Jonathan, so I am CC'ing this if it rings
> > bell for him.
> 
> That run refers to 95dcd58, so I fetched it and tried rerunning it on
> CI. It seems to pass:
> 
>   https://github.com/jonathantanmy/git/actions/runs/11690124087

I ran:

  ./t5616-partial-clone.sh --run=1-22  --stress

and got the same familiar, though it took a while (about 40 iterations).
So I think the test is just flaky and the almalinux CI just got unlucky.
As for what causes the race, I have no idea. I don't see anything
obviously timing oriented, so it could be something like
non-deterministic hashes. In my run this:

> >   ++ git -C dst rev-list --missing=error --objects main
> >   fatal: You are attempting to fetch 957c60b67968d2ab4144e7e2fbba99d6ad864e4e, which is in the commit graph file but not in the object database.
> >   This is probably due to repo corruption.
> >   If you are attempting to repair this repo corruption by refetching the missing object, use 'git fetch --refetch' with the missing object.
> >   fatal: could not fetch 3246c304205324149983025431c5211438f41931 from promisor remote
> >   error: last command exited with $?=128
> >   not ok 22 - use fsck before and after manually fetching a missing subtree

Had the same 957c60b679 for the first message, but the "could not fetch
$hash from promisor remote" was 3cbc3c292cd156cbe9693f32a935a42c92351583,
rather than what is shown above. So maybe relevant?

I'm not planning to dig further, but maybe that gives you an avenue for
reproducing.

-Peff
