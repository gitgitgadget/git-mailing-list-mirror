Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526D1AADA
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245254; cv=none; b=LKr5si2Jk5rk50CpOEHUxBA4NB02wMTtRUV4EI0Mr69FbX8+RQg2wuU3HMInEiiaPeggF9RyfS+FgLAR7K6Pm7A3q88gYIr5wakv2qXTAz/3JhFHNbXuDdU6Mo2RbOEPCCfpcrqg9Dm3mziqE3cGProg9iuoCeYKWtFmfaBTgkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245254; c=relaxed/simple;
	bh=EkFFNxb6FHFzMTEUr5sVDQ0Ahk0sBEtshxTBaee+oHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AwRHwjzo9BtMsXf3g8tYzqM+DA73SZ37GK4YXr1UzA8OI93VWpqcJfRpHyHeIvnCqLvchZVadVpduGW/YP4mKbBVZcs1Y38T+2Q/cJjYODYkLCpQcw6GRmXMNPwoxnKeq2Cm5IMNDGceC8iicClaSP7fuwHL9x4md/p3Bz7n+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=S6htPu8r; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S6htPu8r"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 219CE1D371F;
	Tue,  6 Feb 2024 13:47:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EkFFNxb6FHFzMTEUr5sVDQ0Ahk0sBEtshxTBae
	e+oHA=; b=S6htPu8r8BCu4xFXVg+JWVBwUO+Bd2Q+wJrxw/JWVV3OU9T9Vo17Y8
	GFLo4HcZdGQ9A32ZKf+yDzaq2xJeJaAdQwG40aL3yNi2VoasBSMW40RipTI6VO41
	nWT9tsUFGIIy0+yOFibhsQuKqU6s39jtyoWN8AV8mgOPKeL1ufZWw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A0B11D371D;
	Tue,  6 Feb 2024 13:47:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C4C21D371C;
	Tue,  6 Feb 2024 13:47:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
In-Reply-To: <xmqqle7xjzic.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	06 Feb 2024 09:03:55 -0800")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240129113527.607022-1-karthik.188@gmail.com>
	<20240129113527.607022-5-karthik.188@gmail.com>
	<98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
	<CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
	<92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com>
	<xmqqle7xjzic.fsf@gitster.g>
Date: Tue, 06 Feb 2024 10:47:29 -0800
Message-ID: <xmqqr0hph1ku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2E868158-C520-11EE-83A3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Thanks I'd missed that discussion. I see that at the end of that
>> discussion Junio was concerned that the proposed "" did not account
>> for "refs/worktrees/$worktree/*" [1] - how has that been resolved?
>
> Ah, that is an excellent point.
> ...
> The use of dashed-options to include hierachies that are by default
> excluded (e.g. "--include-root-refs" and "--include-worktree-refs")
> feels limiting, but should be sufficient for our needs, both current
> (i.e. I want to see HEAD and FETCH_HEAD) and in the immediate future
> (i.e. I want to see worktree refs from that worktree), and I can buy
> that as a good alternative solution, at least in the shorter term.
>
> I still worry that it may make introducing the negative ref patterns
> harder, though.  How does --include-worktree-refs=another to include
> the worktree refs from another worktree in refs/worktrees/another
> interact with a negative pattern that was given from the command
> line that overlaps with it?  Whatever interaction rules we define,
> can we easily explain it in the documentation?
>
> Just like "an empty string tells Git to include everything" is a
> perfectly reasonable approach if we plan to never allow
> refs/worktrees/ hierarchy, "dashed-options for selected hierarchies"
> is a perfectly reasonable approach if we plan to never allow
> negative limit patterns, I suspect.  We should stop complexity at
> some point, and the decision to never support negative limit
> patterns might be the place to draw that line.  I dunno.

For now, let's block the kn/for-all-refs topic until we figure out
the UI issue.  Which means this (and the reftable integration that
started to depend on it) will not be in the upcoming release.

FWIW, I am leaning towards "a set of narrowly targetted command line
options (like "--include-root-refs")" approach over "a empty string
defeats the built-in default of 'refs/' limit".

Thanks.
