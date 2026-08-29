Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3BD19644B
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788003984; cv=none; b=JZhvBnt5r+4c5C40StQUXjis1bZte3ZXIw2CxRG7qiLBbZOFY9b+fDhjHyMt/6Kilj/kKktYfvn9QoXK3+QdIOdzxENEqsakH9PKnWHTPfkZXouTYsUwQDzHfMERAc58FrlClYqCu4eFP6c4VOk9HJizbrWSq6MQxfCJu5Y7W5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788003984; c=relaxed/simple;
	bh=DxdoPpe0jWmcn8WAlubEEJlbsDpfGDJrdiGNSAPyjWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHwI5UzPB9gFeJu9oBNs5u7/NtQ7ZAyeHbMNAv+GUlXpY3+twivGZ9s8v8M8S+l5CM39CB2yE1cO6V4Nd1GKSiZLLWcW1WSZMNFVWInyf+348VOQ69lHmRI/HZZVlPZLLkaCPSZJ7Dr9HSZkTOAP7w6+vygI5mUDSMZ3NJLmgaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fzlEHWYU; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fzlEHWYU"
Received: (qmail 46957 invoked by uid 106); 29 Aug 2026 11:46:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DxdoPpe0jWmcn8WAlubEEJlbsDpfGDJrdiGNSAPyjWU=; b=fzlEHWYUOxR+DGJ/4D0lS+xuTRPyCRBjcI5qbnLc/MwEx2+R7eQcri+0l57q9bEzuiuTMO36FNlSqeEXLiZI7JuEico4ZJmA82iqxjzuriZsYSabekXVN/NjVvY+H4h2z9sx5/FD6H3d5DgrN/RbHQZGTwm6KbUy8ttYVSkts7eVPm0agcOCkdGkyZ82sa5YmVnaG5vpW+q3SPpZ6Z/1p/nDMIgEwEOoUfHOqQGTDrwE85GaOgAPv/6IMJkIV0eSXRyi/godmRRO72QSwCk7ub5FYFocY6yJ3SSCPSoRxe7pfCfLc6NzdhB/wWKfUxgubQHL4Gg5m1UmLRcVfT9wIw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 29 Aug 2026 11:46:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 83906 invoked by uid 111); 29 Aug 2026 11:46:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 29 Aug 2026 07:46:21 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 29 Aug 2026 07:46:20 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 3/4] mktree: do not use OBJECT_INFO_QUICK when
 checking objects
Message-ID: <20260829114620.GE40814@coredump.intra.peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
 <79ce753c6849651cb7497c5e7716f0f1068df4ad.1787986831.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79ce753c6849651cb7497c5e7716f0f1068df4ad.1787986831.git.gitgitgadget@gmail.com>

On Sat, Aug 29, 2026 at 07:00:30AM +0000, Elijah Newren via GitGitGadget wrote:

> mktree_line() checks each referenced object's type with
> odb_read_object_info_extended() under OBJECT_INFO_QUICK.  QUICK skips the
> reprepare-and-retry that reloads the on-disk pack set, so a resident
> "git mktree --batch" reader reports an object that a concurrent repack
> just relocated into a new pack as missing, and rejects the entry.
> 
> QUICK entered this lookup in 817b0f602710 (mktree: do not check type of
> remote objects, 2022-06-21) only to avoid lazily fetching promisor
> objects; OBJECT_INFO_SKIP_FETCH_OBJECT already provides that.  Drop
> OBJECT_INFO_QUICK and keep OBJECT_INFO_SKIP_FETCH_OBJECT, so mktree still
> avoids a promisor fetch but recovers an object that was merely repacked.

I think this line of reasoning is fine.

We probably _could_ use QUICK when the caller specified --missing, which
would optimize out the SECOND_READ effort if the caller told us they
expect (or at least allow) some items to be missing. But:

  1. It's not clear how people use --missing. If you are just trying to
     be gentle with an occasional missing entry, then the optimization
     is not that interesting. If you run mktree all the time to make
     synthetic trees full of objects you don't have, then maybe you do
     care about the optimization. But if you are doing that then you
     probably are better off with an option that avoids the lookup
     entirely (i.e., we should just trust the type found in the input).

     So there's maybe room for a --yolo argument to mktree, though I
     guess in practice you could just use "hash-object" for that. But
     either way that is way out of scope for this patch.

  2. Prior to 817b0f602710 we were not QUICK either! And that commit was
     only trying to trigger SKIP_FETCH_OBJECT. So whether there is an
     argument for linking --missing and QUICK or not, it should be made
     separately. This patch is just fixing the extra flag that probably
     should not have been added by 817b0f602710.

> +test_expect_success PIPE 'mktree --batch survives a concurrent repack retiring a pack' '

OK. I was hoping we could test this without all of the PIPE complexity,
but I don't think we can. We really need a case where the first lookup
fails but SECOND_READ succeeds, which is inherently a race. Feeding one
entry at a time lets us implement that in a deterministic way, and I
think is the simplest we can get.

So the patch looks good to me overall.

-Peff
