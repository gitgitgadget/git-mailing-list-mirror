Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D4142641
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627284; cv=none; b=jxXDMn4Mz13RDkEMpN/fVMRFJntKges4oW6PFbItMbKpCCeRnig+RXTUE6zk16KVYCPDACoo5hQlgLT0vBfc15MLdd/ICanny0XmLyLsPsPin2MRmd7Xvl3PH3uxPDGAJWRpDXaSihVdkynCJ9qN4VC8tuivvgOr1ZjidS8OShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627284; c=relaxed/simple;
	bh=93+RQJYayO6QtB2SIG++PbskPvQNTXnm9cDXaYoishk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YAsNVQN/000agMn76kAbud51/rw/iNqYPSoKC4ZxX3la2IPvId+j09sYTtGt0P/8RSIp+KgA59NnIh5m7fDRpysjR/1WpyqbAFeUkU0uLqmcb+aDFcIQ87rkYXnByvH7KXEL1ZkEvn42ZGpmjNV4E4AytpXoEdJ1WCfaHx6qFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YKPP85Sq; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YKPP85Sq"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F3271A79D;
	Thu, 22 Feb 2024 13:41:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=93+RQJYayO6QtB2SIG++PbskPvQNTXnm9cDXaY
	oishk=; b=YKPP85Sq8m5pF5bTG8V8U1lkslKFW8oRnC7f024Q6tM/S2urH4j8un
	sQcyQdAJkFF5vNkN+6kNiCxx9JMBL/nBZP1UpXU3rqvckEm8lfwIFdEgZUjbTvUg
	Z1JBDg9Nrb6eHP9vdklwsk+EFATaDah9kU3wDR1Y9GSDYibHj8u+o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 673931A79C;
	Thu, 22 Feb 2024 13:41:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E528F1A79B;
	Thu, 22 Feb 2024 13:41:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Brian Lyles <brianmlyles@gmail.com>,  git@vger.kernel.org,
  newren@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v2 6/8] cherry-pick: decouple `--allow-empty` and
 `--keep-redundant-commits`
In-Reply-To: <3f276e10-7b03-4480-a157-47a7648e7f19@gmail.com> (Phillip Wood's
	message of "Thu, 22 Feb 2024 16:35:29 +0000")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240210074859.552497-7-brianmlyles@gmail.com>
	<3f276e10-7b03-4480-a157-47a7648e7f19@gmail.com>
Date: Thu, 22 Feb 2024 10:41:16 -0800
Message-ID: <xmqqwmqwcpf7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F710BE34-D1B1-11EE-8ECD-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... I still tend to think the practical effect of implying
> --allow-empty with --keep-redundant-commits is largely beneficial as
> I'm skeptical that users want to keep commits that become empty but
> not the ones that started empty.

I share that feeling exactly.

There are good reasons to keep a commit that starts as empty (as
much as creating an empty commit in the first place), so if
anything, a more common workflow element would be to drop the ones
that have become unnecessary (e.g. because the upstream already
added a change that is equivalent to what is being picked) while
keeping the ones that are empty from the start (e.g. in some
workflows an empty commit can be used as a container of
metainfo---you can imagine that in an N-commit chain leading to the
tip of a topic branch forked from the master branch, the topmost
commit is an empty one with the cover letter being prepared, so that
the resulting topic branch can be either (1) made into a patch
series with an advanced version of "git format-patch" that knows how
to use such an empty top commit in the cover letter message, or (2)
merged to the mainline via a pull request, with an advanced version
of "git merge" that notices the empty commit at the tip, and makes a
merge with the commit topic~1 while using the empty top commit to
write the message for the merge commit.

I do not quite see a good reason to do the opposite, dropping
commits that started out as empty but keeping the ones that have
become empty.  Such a behaviour has additional downside that after
such a cherry-pick, when you cherry-pick the resulting history onto
yet another base, your precious "were not empty but have become so
during the initial cherry-pick" commits will appear as commits that
were empty from the start.  So I do not see much reason to allow the
decoupling, even with the new "empty=keep" thing that does not imply
"allow-empty".

Thanks.

