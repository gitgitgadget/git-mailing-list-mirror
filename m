Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804F38DD1
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726417523; cv=none; b=IDi5booPQPWh/dsM4hgKkzvdD74XJgpVRWWG/Y03gYAk1YsfQCIDQM+Mblotu3dmO+RMUlRU3aJfgHFoMV4St39j2tjFfHiyB4HZuTsN4g/dUW3hNHn6e2sLiOmQzI+OzxCpjqUDpkGc06wf7NtG5v4D9IF2QiPi+kJmY726V9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726417523; c=relaxed/simple;
	bh=h6Tt9wGm9XMjspb2Ppi1hC0o6mogLyqE5Ye0Nrx46CQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eiXLvkx9TTKJs9TgurkGuBQOkjiAIVfdlsF77RW+jcBU8kVojFKxkZwKkrYngdCqeVu9nfImJkhew2Zkglnoal47v2aSx5dAAGSzY/C31bgXZ90srtvbfz1NGny7Gz56/FJtYudZj99OgnuzAcXRi7MjmHMYZ/Pd09T6hgc3uRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OesOfb3N; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OesOfb3N"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8C9622583;
	Sun, 15 Sep 2024 12:25:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=h6Tt9wGm9XMjspb2Ppi1hC0o6mogLyqE5Ye0Nr
	x46CQ=; b=OesOfb3NmtFC225KECvZC87V1AIC+7AN06OQDkc5Y3NRBSpeUQPQYV
	Pl913+c+oHSYAdEu4dDELhfQcEqim97vkKzQVXzASFrdPgpUtST1quAxsHXvaabs
	vPUUDO3m+qd/6UIdcfhyOi36fBtIQTZ8URPvN6IpOtks/K/0di28o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD77422582;
	Sun, 15 Sep 2024 12:25:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E49F22580;
	Sun, 15 Sep 2024 12:25:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(linux32): make Javascript Actions work in x86 mode
In-Reply-To: <20240915110706.GA2017642@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 15 Sep 2024 07:07:06 -0400")
References: <pull.1790.git.1726274559928.gitgitgadget@gmail.com>
	<20240914072932.GB1284567@coredump.intra.peff.net>
	<xmqq34m2tasj.fsf@gitster.g>
	<20240915110706.GA2017642@coredump.intra.peff.net>
Date: Sun, 15 Sep 2024 09:25:11 -0700
Message-ID: <xmqqr09krijc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 150935B4-737F-11EF-B5A9-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> On Sat, Sep 14, 2024 at 10:17:16AM -0700, Junio C Hamano wrote:
>
>> Each of these approaches may have its pros and cons, but I somehow
>> do not see that the newly proposed alternative is 10x better than
>> what was reviewed and queued already to be worth the effort to
>> replace it.
>
> That's my feeling, too, but I'd reserve final judgement to see Dscho's
> response; it's possible I am under-estimating the 32/64-bit confusion
> risk.

FWIW, what you said matches my recollection from years ago ;-) back
when I had to deal with that.

> I'd also note that his patch does not require bumping the distro
> version, which would let us continue testing that old version in GitHub
> Actions. That might be worth considering.

Yes, that is true.

Considering that 16.04 has passed its expiration date for standard
support a few years ago, I am not sure how many more years of
practical/unsupported use and testing we would be getting by giving
cycles for the release in CI, though.

Thanks.
