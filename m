Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C209D2F5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722553618; cv=none; b=HFCaEqOwyJtqVy9s9CkVa4feuIPim4NVNAFBBWQHKm2fQu86JlB1jKgl1CyPNoeyxcpbvgdDTrdhl13qHbAEgi4XJoJ+SQvokZL7Gm0r2LTCnrRO4dzuytnWh9DIKIrbh2qP4PW+iQZ/OktqAc/uk+4DuIYdyI9lL67P1u2nk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722553618; c=relaxed/simple;
	bh=hzqh1zKCp/tlQz56XAQpH9YjCIgtiOk+3kB77fD0zwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AgzadbGQs+dRag/wecWpvdp4vpZasbWJ1Dzx20ix2fGkqSI963d4lzEZf0Y9ArNDE4YZW2Mk2dKT45Xa8oOH9QrcAeVjwsaxa9BB45fYYD8MiLpOsaqztyYW/yKy/g5zYaHl2VFMMKdj5iF7O97MMEKR2qKPCZw2JrXPihewhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tQamMhpL; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tQamMhpL"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E7AD22C628;
	Thu,  1 Aug 2024 19:06:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hzqh1zKCp/tlQz56XAQpH9YjCIgtiOk+3kB77f
	D0zwI=; b=tQamMhpLnrjf9QZmgjzbIlJgMJwVqX+VhPZKASxJ71+e8m7vHw6T6E
	yU78wRKElRwpx2AgWSVk+Xwl6vg4GLBCDf/jBIHv3y8EvuJcVa7+57B+fky5PRqY
	bRpOpDf4+4eTlVD89LC4PFOtoFuODo12F3DX0Wv41tGmjCDRLpUdo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E084E2C627;
	Thu,  1 Aug 2024 19:06:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C34202C626;
	Thu,  1 Aug 2024 19:06:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  vdye@github.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/3] git for-each-ref: is-base atom and base branches
In-Reply-To: <pull.1768.git.1722550226.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Thu, 01 Aug 2024 22:10:23 +0000")
References: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
Date: Thu, 01 Aug 2024 16:06:49 -0700
Message-ID: <xmqqmslvhmgm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BC4B8CF2-505A-11EF-B248-92D9AF168FA5-77302942!pb-smtp20.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Derrick Stolee (3):
>   commit-reach: add get_branch_base_for_tip
>   for-each-ref: add 'is-base' token
>   p1500: add is-base performance tests
>
>  commit-reach.c              | 118 ++++++++++++++++++++++++++++++++++++
>  commit-reach.h              |  17 ++++++
>  ref-filter.c                |  78 +++++++++++++++++++++++-
>  ref-filter.h                |  15 +++++
>  t/helper/test-reach.c       |   2 +
>  t/perf/p1500-graph-walks.sh |  31 ++++++++++
>  t/t6600-test-reach.sh       |  94 ++++++++++++++++++++++++++++
>  7 files changed, 354 insertions(+), 1 deletion(-)

I was expecting to see an documentation update to for-each-ref (and
probably branch and tag) so that what this new atom means.  Is it
that %(is-base:<commit>) interpolates to <commit> for a ref that is an
ancestor of <commit>, and interpolates to an empty string for a ref
that is not, or something?

Thanks.

