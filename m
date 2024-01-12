Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0A16408
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="itKuOD8Z"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F1C31E4C08;
	Fri, 12 Jan 2024 15:21:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=153RsTQl5jlfWKX5Nx/veGpK6DfVekyWLCB6Nz
	Erj4k=; b=itKuOD8ZvXGBYp7xxDVYeAetDHGCGwPmA092yaxouF4ymNiB0foZMJ
	d8QwWckZ6wvX7Nu4LdHvMTsv+FsMTwasVpku8DDa0QluF5zHwW+OVK90+rkCaGxS
	gPXake2RcIgb0Y0vogUJv5cd8Hi7edQgTaD+Zsp3k6UvH3p6IUzbQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 477C71E4C07;
	Fri, 12 Jan 2024 15:21:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC6F31E4C06;
	Fri, 12 Jan 2024 15:21:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC PATCH] `log --merge` also for rebase/cherry pick/revert
In-Reply-To: <47a4418b-68bf-4850-ba8b-1a5264f923e4@gmail.com> (phillip's
	message of "Fri, 12 Jan 2024 11:01:21 +0000")
References: <20240111233311.64734-1-mi.al.lohmann@gmail.com>
	<47a4418b-68bf-4850-ba8b-1a5264f923e4@gmail.com>
Date: Fri, 12 Jan 2024 12:21:30 -0800
Message-ID: <xmqqr0im9ub9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2C9D31B2-B188-11EE-AA62-25B3960A682E-77302942!pb-smtp2.pobox.com

phillip.wood123@gmail.com writes:

> I should start by saying that I didn't know "git log --merge" existed
> before I saw this message so please correct me if I've misunderstood
> what this patch is doing. If I understand correctly it shows the
> commits from each side of the merge and is equivalent to
>
>     git log HEAD MERGE_HEAD ^$(git merge-base HEAD MERGE_HEAD)
>
> When a commit is cherry-picked the merge base used is
> CHERRY_PICK_HEAD^ [*] so I'm not sure what
>
>     git log HEAD CHERRY_PICK_HEAD ^$(git merge-base HEAD CHERRY_PICK_HEAD)
>
> tells us. Indeed there HEAD and CHERRY_PICK_HEAD may not share a
> common ancestor. As I say I've not used "git log --merge" so maybe I'm
> missing the reason why it would be useful when cherry-picking or
> rebasing.

Good question.  It is the whole point of cherry-pick that
CHERRY_PICK_HEAD and the current HEAD may not have any meaningful
ancestry relationship, so yes, it is questionable to use the same
logic for "log --merge" between HEAD...CHERRY_PICK_HEAD, while using
HEAD...MERGE_HEAD does make perfect sense.
