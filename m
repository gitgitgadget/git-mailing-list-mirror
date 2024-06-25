Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736617D88C
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357988; cv=none; b=DQUwOp/4Tly/W93PBAVLhzXaFxgeBZGFCCIMf8cnAYr5QUKUYHOVJ7dT/GkdQqoQJHDNB1fgsiLfZ1tbLsAEE7cqxeTOiiZkVwh+EFHlECsmTrc0k0KlOrFK1142+MZFAYT68BZGXKhyk0wEyYtpx5FG6FUC2OtRZZ/frqRebPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357988; c=relaxed/simple;
	bh=k98jzSCK4vAkjCTw7NiJqNJc0mT/fUU4RoqtTqT5d5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lxGoG6EngcbLti+slVRL6/UC4Bf4XLNa60UxGQ7gSe7bNnIt2Ft4AcZe0b7Jk35QLHvwqPPhbTaq25Oj3JYG8npi/hdGaa4BNFWIGXvcpAyhPcRW77rfkUvjomG08PE9RJR/iJBCsGhfCHRSRDJ7VCTa+A/u0bKDFh7KUkoeBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aUhwd5K0; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aUhwd5K0"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 723AF1D2FF;
	Tue, 25 Jun 2024 19:26:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=k98jzSCK4vAkjCTw7NiJqNJc0mT/fUU4RoqtTq
	T5d5U=; b=aUhwd5K0+rqrbXrlNYtutmigO3JlULGkjLvq7KFDUrTZC7GJBhWHRE
	Megy9v3LyBJyqBtZl91hXYp04pLAONt8l7Kl9X7nZts347W6F9ws8d1g24doqOyU
	DBUkfhc407E7fih551gyH/6pdahr5m4j8Bg2kKHMVfTWYSw1hUWNI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 69B891D2FE;
	Tue, 25 Jun 2024 19:26:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD01C1D2FD;
	Tue, 25 Jun 2024 19:26:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Patrick Steinhardt <ps@pks.im>,  Victoria Dye
 <vdye@github.com>
Subject: Re: [PATCH v2 00/17] mktree: support more flexible usage
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com> (Victoria
	Dye via GitGitGadget's message of "Wed, 19 Jun 2024 21:57:48 +0000")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
Date: Tue, 25 Jun 2024 16:26:24 -0700
Message-ID: <xmqqzfr861un.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 57652FF0-334A-11EF-B039-965B910A682E-77302942!pb-smtp2.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The goal of this series is to make 'git mktree' a much more flexible and
> powerful tool for constructing arbitrary trees in memory without the use of
> an index or worktree.

I've read earlier parts of this series carefully (but didn't manage
to get to the end of it), and I saw Patrick and Eric gave reviews on
the earlier round, but otherwise this topic seems to have stalled.

https://lore.kernel.org/git/pull.1746.v2.git.1718834285.gitgitgadget@gmail.com/

Any more comments?

Otherwise, if I find time to read through 13-17/17 and did not find
anything glaringly wrong, I am planning to mark the topic ready for
'next'.  Thanks.
