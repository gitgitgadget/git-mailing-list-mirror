Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3357875
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193387; cv=none; b=LR3kJrbdNB425LnUmTmYMWc/sZfON9eYqn60QeZv2sDgmaS6OpQ2PFY74KHbnTgaCX6yQV3p26bhSwOXrqfbhXliPH0k4sy4scs3nBvpYZiLRxfLgwwI/CkqdDTgwDMg4mna9CHuDHumuqi3AszQoNJ6Hlh/waPgo8x0F+RFftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193387; c=relaxed/simple;
	bh=poecH1OBAHO/jOlfJliwjsXT0P4PBZBbliyfP/g0If8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gGl0PKcW0r+Pn+fXMT9xD1Mlt9YXmn7iVh1gDgU7mAV+NxAOLPXkYpKRrSWqpT52ttA+f5l/J+6yVkNJzGvBBK24IXwnSuUdebIqJ+TU+3csAFsYsASTwpOqAq6kiL912gEnFlEAYVK3r+v2kcUzb/aVjw0+yvYJGzYkbysRLLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WLktKj3B; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WLktKj3B"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C48B2EEA5;
	Mon, 11 Mar 2024 17:43:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=poecH1OBAHO/jOlfJliwjsXT0P4PBZBbliyfP/
	g0If8=; b=WLktKj3BqA3a3EIqrV3EPXOPfoY3v3zsCJwclC7jt+I3QXoqYLUIie
	vdSU7sM62CRd0jL+yibqcsGcUyDKoOhYz46RurXYdlJr+QImK1ZTTnErOeflQ2ad
	i9sctFbmNlXs7ObU5xKMJjJZhZ9DRYMdUhKQfoHSWyTm8Fj4Um9ng=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3233A2EEA4;
	Mon, 11 Mar 2024 17:43:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B37C92EEA0;
	Mon, 11 Mar 2024 17:43:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] cat-file: add %(objectmode) avoid verifying
 submodules' OIDs
In-Reply-To: <pull.1689.git.1710183362.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 11 Mar 2024 18:55:59
	+0000")
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
Date: Mon, 11 Mar 2024 14:43:00 -0700
Message-ID: <xmqqwmq8o36j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 55AB6C68-DFF0-11EE-A5CF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The cat-file --batch command is very valuable in server settings, but so far
> it is missing a bit of functionality that would come in handy there.
>
> For example, it is sometimes necessary to determine the object mode of a
> batch of tree objects' children.

OK.

It is somewhat unsatisfying that --batch/--batch-check lacks so
much.  Even with %(objectmode) its nature of one-object-at-a-time
makes querying children of a large tree a chore, when you compare it
with something like "cat-file -p HEAD:" that allows you to grab the
needed information for all children with a single invocation.

This is orthogonal to what the patch wants to do, which is to enrich
the output side with more formatting, bit I wonder if we want to
consider enriching the input side?  e.g. instead of feeding just a
single object name from the standard input of "cat-file
--batch/--batch-check", perhaps a syntax can say "Here I have the
object name for a tree-ish object, but please pretend that I gave
you all the objects contained within it", or something?

Thanks, will queue.
