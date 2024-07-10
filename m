Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E69135A65
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720647650; cv=none; b=uV7SjOj7IXVmUYOp6JQBwCC9v5ipSPIET+vS/ulT5RVrqoFJSufEvhDyES9g9RrQh0rQ85Ha0PHbi30/0BtsfDoPwoJCyBT/prMru+HGr/oeRBc1XW6PqKJslF+MzgKqkwng7yaqI2xg0BnvtsInetblX3JwwLqJa7EF3hjTUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720647650; c=relaxed/simple;
	bh=8ZLLBSsqSHL4xZo4UZG9hJBgdZMBvvcKPNQ75C8iyac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jsR4IwM4dORB1N4Asq1+gGZTv6WQa5HLG57JE0pqIKzsiYkomPXigwSFHn0AW8SfgLLNrKoPsa+y8w9xlAurcD3kyA+RoYxXg5AjzCBpVSdyZ2HbsHm938q7t112OXLfsd1K1eyiiMR7cnY556Yoiku0KwhBBChx4d48g9bV+eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nklt+vIR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nklt+vIR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FF6736AF7;
	Wed, 10 Jul 2024 17:40:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8ZLLBSsqSHL4xZo4UZG9hJBgdZMBvvcKPNQ75C
	8iyac=; b=nklt+vIRYoFRFyAkF/LYTkKblGdGkPFiEhnN2FcsJ1rTWVHfveyFz6
	BfsWI2W02babSMa/U1eOWZ7X8ED0hEaaWDib/sxsdwXFP2IJAcFc52RDyhDkb4TS
	nfg00xbwKBQfg3cE19WhWS+j9VtxGyUHTDQ9QS5ya4bPwk6QAH8Qg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 473A436AF6;
	Wed, 10 Jul 2024 17:40:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3A6F36AF5;
	Wed, 10 Jul 2024 17:40:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Patrick Steinhardt <ps@pks.im>,  Victoria Dye
 <vdye@github.com>
Subject: Re: [PATCH v2 00/17] mktree: support more flexible usage
In-Reply-To: <xmqqzfr861un.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	25 Jun 2024 16:26:24 -0700")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
	<xmqqzfr861un.fsf@gitster.g>
Date: Wed, 10 Jul 2024 14:40:46 -0700
Message-ID: <xmqq34ohudr5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 11BF3876-3F05-11EF-81DB-965B910A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> The goal of this series is to make 'git mktree' a much more flexible and
>> powerful tool for constructing arbitrary trees in memory without the use of
>> an index or worktree.
>
> I've read earlier parts of this series carefully (but didn't manage
> to get to the end of it), and I saw Patrick and Eric gave reviews on
> the earlier round, but otherwise this topic seems to have stalled.
>
> https://lore.kernel.org/git/pull.1746.v2.git.1718834285.gitgitgadget@gmail.com/
>
> Any more comments?
>
> Otherwise, if I find time to read through 13-17/17 and did not find
> anything glaringly wrong, I am planning to mark the topic ready for
> 'next'.  Thanks.

And I had a few review comments myself.  Then the topic stalled.  I
am not ready to mark the topic ready for 'next' in this state.

THanks.
