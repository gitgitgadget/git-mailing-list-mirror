Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F467C6D
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 06:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372285; cv=none; b=bpwPZuX65p2Eck1gY/UrQ4oxljuBClUCWGJJY9Lor+4vR9gxDPvPZiHxYIojvIb4LTfE9rqPU657D5xKmd17xd7g9a0RwAtBuz8Tw+bkXWzPkhYNY3v4PqkotsMXqExG03Vh4upLqTppYg0GfpHqP8vBzW09GjPL3mGOVdpWbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372285; c=relaxed/simple;
	bh=dtsWeqZwgkW9MEFyhD1B2rHxM7osdvl/rU98YPLvmaI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WENKgFDoZWpX4dMKN6pXsmtx1n31nJbu/Vq/MTtM6PgI9FkZes8WohPX109LXmePPB+FZpEzb32wvDgkP9gX09J+y2CFXswVL9HQdXVqa9dqz240g20HRe3Junwwqr0E4+efnnUs935KazQJktwKv15DYQtWq8wTpkmQhNRQ5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZJEAkZz7; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZJEAkZz7"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5396A1E3635;
	Thu,  8 Feb 2024 01:04:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dtsWeqZwgkW9MEFyhD1B2rHxM7osdvl/rU98YP
	LvmaI=; b=ZJEAkZz7JRnH8BTDmN5Zp3UeqV0hz9Ico1Hpke7lEOtSCeoJUq9mwe
	7d6X3wyjAAfsUbPNc1Ekj677U9Kck8LCk6L3nu87/U0eq2PAvtfI4RhygMNcQK8c
	GHPC1AIZgq20a82KtceUPuV72CAtO7R4peHceKY1GPupXaC1vVShg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C2161E3634;
	Thu,  8 Feb 2024 01:04:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B16EF1E3633;
	Thu,  8 Feb 2024 01:04:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: [RFH] "git -C there add foo" completes, s/add/diff/ does not
In-Reply-To: <CAO_smVjnknv1ePTHhDNKK=C_iEg6+T0nNwaXqA67QuPd6tBkxw@mail.gmail.com>
	(Kyle Lippincott's message of "Wed, 7 Feb 2024 18:50:02 -0800")
References: <xmqqcyt89l7z.fsf@gitster.g>
	<CAO_smVjnknv1ePTHhDNKK=C_iEg6+T0nNwaXqA67QuPd6tBkxw@mail.gmail.com>
Date: Wed, 07 Feb 2024 22:04:40 -0800
Message-ID: <xmqqmssbpk3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F307A516-C647-11EE-A172-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Kyle Lippincott <spectral@google.com> writes:

>> ...
>> But the same does not work for the step before I can decide to
>> actually "add" the contents, which is to "diff", i.e.
>>
>>     $ git -C Meta diff whats-<TAB>
>>
>> does not complete.
>
> I'm not a completions expert, but I think what's happening is that the
> completions for `git diff` aren't producing anything, so it (where
> "it" here might be the shell?) falls back to just doing normal path
> completion.

Yes, that seems to be the case.

> For `git add`, it's checking the `git status` output to
> filter the list to things that need to be added,...

Not exactly, but a close enough description, I think.

__git_complete_index_file does not run `git status` but asks
ls-files the paths it knows about (including "--others" so that a
path that is untracked can become a candidate to be added), then
massages the list of paths with a custom awk script.

For "git diff", depending on what two sets of contents are being
compared, the source of possible paths may differ, but the list of
paths obtained from ls-files (without --others) would be appropriate
when comparing the index and the working tree files, or comparing a
tree-ish and the working tree files.  The necessary ingredient to do
so may be pretty much the same as what is used by _git_add completion.

When comparing two tree-ishes, the candidate would ideally come from
union of paths in these two tree-ishes, but I offhand do not know if
there already is a support for choosing from such a set.

Thanks.

