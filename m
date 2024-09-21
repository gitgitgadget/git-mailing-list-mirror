Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868128F5
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726882508; cv=none; b=jI9Y0inh0b+zVwEEzgyR3rpkpUWQEoIVMUHVkTMG1Fk/s8w8lFXO8qTuDWik9yih89PxIKyzQ5liNw5i/KTO0cx2nBvb0NX8EPfevggiU4P2XEW7E9yQMra29TR758L3eHy7EZ+6qcK5uKY4sgVEh4YMvOxn/+wJEelGVGlU3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726882508; c=relaxed/simple;
	bh=dvOjtOlHfuBaqe69ewImdM/Je9oNN0pWinreG1/fX50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mqCVC2qLbzT0eXJJp4uThY4dk7/pP6YHv26WnWHrTGq9tSDkjWvsj0qwb7pS019y2ZpE8RsHDGBome9tQZ7EG6kd7E16oqKbN+kraTG69mx646TrF5RF6gD44UDxnbVe533AfWYo3Lt8+XcTj4doR5lubvl/376OXTs9qg6Sb4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZIQ5QDNZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZIQ5QDNZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8089522D89;
	Fri, 20 Sep 2024 21:35:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dvOjtOlHfuBaqe69ewImdM/Je9oNN0pWinreG1
	/fX50=; b=ZIQ5QDNZ74AxgWzpaUhq3+AFqlMx04BsuBUZOi1W09QEPKqJMhivND
	QHrcW15uX95gFWfuVVVFJ1ovnhpsMepdcKi2riUhqeIO2wcbkL3skzPyDRflFc2m
	+yLCN+N+5YOPceq0U3xgSjVJVZugWDwVMmaVv8qK5nfDvwjtnXrzQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5429B22D87;
	Fri, 20 Sep 2024 21:35:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F5A322D86;
	Fri, 20 Sep 2024 21:35:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Francesco Guastella via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Francesco Guastella <guastella.francesco@gmail.com>
Subject: Re: [PATCH] builtin/worktree: support relative paths for worktrees
In-Reply-To: <pull.1783.git.git.1726880551891.gitgitgadget@gmail.com>
	(Francesco Guastella via GitGitGadget's message of "Sat, 21 Sep 2024
	01:02:31 +0000")
References: <pull.1783.git.git.1726880551891.gitgitgadget@gmail.com>
Date: Fri, 20 Sep 2024 18:35:02 -0700
Message-ID: <xmqqikupbxh5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B9CA26E2-77B9-11EF-96A9-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Francesco Guastella via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Francesco Guastella <guastella.francesco@gmail.com>
>
> Add a new configuration option, `worktree.useRelativePaths`, which allows
> users to choose between storing relative or absolute paths in the files
> Git uses to maintain links between the main worktree and any additional
> ones.

I may be misremembering things, but wasn't the use of absolute paths
a concious design decision?  

When the source repository and an attached worktree know each other
with relative location, moving merely one of them would make it
impossible to locate the other.

On the other hand, if they know the other peer's absolute location,
at least the one that was moved would still be able to locate the
one that did not move, which means that it is possible to find from
the one that moved the other one that did not move, and teach the
latter where the new location of the moved one is.

The only case where it may be an improvement to have them refer to
each other with relative locations is when both of them move in
unison without breaking their relative location.

There may be problems other than the design choice I mentioned above
in the resulting code after applying this huge patch, but as it
stands, the patch does a bit too many things at once to be sensibly
reviewable.  I cannot comment much on the implementation (at least
in this message) in its current form.

For example, the refactoring of t/t2400 into t/lib-worktree might be
an excellent thing to do, but it looks like that the change to the
tests alone deserves to be split into at least a few patches (one to
refactor the test script without changing any functionality, and one
or more patches to add or improve test helpers, and another that
comes with code and behaviour change that add tests for the new
behaviour when configured, or something like that).

I might be tempted to come back to it later, but style violations in
the t/lib-worktree.sh were annoying enough to discourage me from
reviewing it (if it followed Documentation/CodingGuidelines, it
wouldn't have repelled my eyes).

Thanks.
