Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BBF22EE5
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377919; cv=none; b=pnTuPrpBhsGdBv4952oWEVEAr/ka/Jsg7Fx7iJPs2+9Nop8A4m5PuiKM9hdDqUpyeKZ9BDXlfDzZKviKNEGPL8sVAOpE//mvQD8fbBon/aVShB3do8En1kXKoJEzT4sSNRG/J8GPv+69uIa3gLjuWMw18ggBeyNCVm/jvNvSjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377919; c=relaxed/simple;
	bh=UDH08JAd/6tDqg/MoLvAZ0gb3m6vRfplWtcf73EUPxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aUI47taXE2GuhdvA7lvtFLOM8L6viGIyiQadt8utEJ5N4nUxzy4R6Aea8rAgiVUaDTiRrLN29KNCoYn/tbKYvGHYomK5d0a9nPGjt/RdN3NC2PzDQsv0pZDo6BimjRPyRJZjzwNm0/jv05CG9D69Q5N1iYpnvqsN8hYcmD7tYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ufzQ5JVV; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ufzQ5JVV"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B23B925C42;
	Tue,  3 Sep 2024 11:38:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UDH08JAd/6tDqg/MoLvAZ0gb3m6vRfplWtcf73
	EUPxQ=; b=ufzQ5JVV9YBnuSggD1nTiu0afKjh2QmVj9oGKdnqJJFG097oNTcUBE
	qWfLicXu5jopHkeNhF9bf9M/3NtuQo82Ka/tlL+TA75mG68wj8WSqCKlswHEjZcQ
	YeYN17FwyxI4Qm2VS9cEcjPHVWudM3dABMh6zYz0ekHc3m+JoGpp0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AADF925C41;
	Tue,  3 Sep 2024 11:38:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A0C025C40;
	Tue,  3 Sep 2024 11:38:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Han Jiang <jhcarl0814@gmail.com>,  git@vger.kernel.org
Subject: Re: `git rebase (--no-fork-point) --onto=<newbase> [<upstream>
 [<branch>]]` leaves HEAD detached and *HEAD not moved when <branch> is
 exactly `HEAD`
In-Reply-To: <981c8e52-e51d-4aab-a970-bb41315e02cb@gmail.com> (Phillip Wood's
	message of "Mon, 2 Sep 2024 10:04:24 +0100")
References: <CANrWfmSY1F4UB2QSjN8XKY7Kwx6FL8SOrz_OadZ4u8XYDpZfBg@mail.gmail.com>
	<61a4fcc1-1dd8-48a4-a1d4-0201232c9b26@gmail.com>
	<xmqq1q23pegz.fsf@gitster.g>
	<981c8e52-e51d-4aab-a970-bb41315e02cb@gmail.com>
Date: Tue, 03 Sep 2024 08:38:29 -0700
Message-ID: <xmqq4j6woih6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 92769BC8-6A0A-11EF-A01E-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I have a mild suspicion that the "rebase" command might have changed
>> its behaviour since the days back when it was implemented as a shell
>> script, when the "what to rebase" argument is HEAD, as the most
>> natural implementation to do this "optionally first switch to it
>> when the argument is given" in the scripted Porcelain is to actually
>> run "git checkout HEAD", which should be a somewhat noisy no-op.j
>
> It appears to have changed in 0cb06644a5 (rebase [--onto O] A B: omit
> needless checkout, 2008-03-15). That also changed the reflog messages
> written by "git rebase <upstream> <branch>" so that "git checkout
> @{n}" does not see the new branch being checked out.

Thanks for digging.  Even if we now know that it was a regression in
the early times of the current code, it is way too old to change it
now.

Unless we want to do so at a major version bump, but I do not know
if this is big enough to worth writing a release note entry for.
Users who do want to run a trial rebase of the current branch on a
detached HEAD have all been already using HEAD^0 as the <branch>
argument and they have been fine without complaints.

Making it consistent in the opposite direction by changinging "git
checkout HEAD" to detach HEAD is unthinkable.  So what we have is
fine, I would think.

Thanks.
