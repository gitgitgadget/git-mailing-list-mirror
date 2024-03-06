Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70E137935
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744773; cv=none; b=EcTbVynk+41WEKO+PfL8qk+ELAao2cKerHMkkTYcQ8z49H9yEphat156xma+i0/Ywt3a5/IctoKoU+2ffOTF4HNnFbYmEGCQ/bOd9j8D5A+msucmLFXmVlbUuH7QLwaAxOvPz0pfQRpKbp7133f3mAwiVxpsmODe+yjPBtZME6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744773; c=relaxed/simple;
	bh=ZHTOs9NdQsysacYq7ivIWWJM884R8WUcnR4wdx10h/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uFUkwK5QfZStdyWkBrS6JYDIg0KsCMtLG+CVlWJZovbTAVrmSJqt1Kavz0L6EP6RNfJU0RvS9pMR9tAZvOJn+Ezijr/QohwtgJwFLXAxS1x6CnIf8cwmz6CnKhlNmfFmcWjVrohtHmfq3DrD6GY3KCDtkw0R4T+YJkXqQO3Rdag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ANqtWbXr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ANqtWbXr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CFAC11E3F88;
	Wed,  6 Mar 2024 12:06:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZHTOs9NdQsysacYq7ivIWWJM884R8WUcnR4wdx
	10h/o=; b=ANqtWbXrNOJ4b4XeKcHu0AuWeFDY7wJDWSR07INzVYITnEcZyb98Ap
	VFWVh/pKFokGwOlJyQNo4TXCrMHMN3ny2Yurc6UXDRagOyFbTRSVaU3XgwTFs/dF
	Yj+n6M3UIPb6Ij68CHbU3IX8gidnpQOPdb2GaC8HsLrTGprxixb68=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C6FCC1E3F87;
	Wed,  6 Mar 2024 12:06:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 323E71E3F86;
	Wed,  6 Mar 2024 12:06:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/8] builtin/config: introduce subcommands
In-Reply-To: <cover.1709724089.git.ps@pks.im> (Patrick Steinhardt's message of
	"Wed, 6 Mar 2024 12:31:30 +0100")
References: <cover.1709724089.git.ps@pks.im>
Date: Wed, 06 Mar 2024 09:06:08 -0800
Message-ID: <xmqqil1zs327.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D3C42BBC-DBDB-11EE-B392-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>   - `git config foo.bar` -> `git config get foo.bar`
>
>   - `git config foo.bar value` -> `git config set foo.bar value`

I actually have been perfectly OK with the above two, but I agree
that ...

>   - `git config foo.bar value value-pattern` -> `git config set-all
>     foo.bar value value-pattern`

... this was less than discoverable, and would be a good update.
This one ...

>   - `git config --get-urlmatch` -> `git config get-urlmatch`.

... is a Meh to me, personally.  I'd not actively push it
enthusiastically, but I'd passively accept its existence.

> Most importantly, this should help discoverability quite a lot by now
> also having a proper synopsis in both the manpage, but also in `git
> config -h`.
>
> Of course, backwards compatibility is a big concern. We don't want to
> just switch over to the new syntax and break all existing scripts and
> muscle memory. This patch series thus abuses the fact that the implicit
> modes (`git config foo.bar`, `git config foo.bar value` and `git config
> foo.bar value value-pattern`) all require a key as first argument. As
> keys _must_ have a dot, this allows us to unambiguously discern those
> from actual subcommands.

Clever ;-).
