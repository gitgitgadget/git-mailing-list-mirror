Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC800B673
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726708615; cv=none; b=BNJpuHxqrH9MSokmuuT8as0JkZUMPtHBw/7jb9Ujkw8ZhCfmIt2ClItiQNijwZCixd2E5ZxnBr1/LBEtdCGM9iC0lVKFfoiNAGdgLNvtXbtwRwUrX1bPiFa6TIcR+8WuRQlGhfyNR/aHFZMLrDJKco6gq4SX7vwpkcOOUIWsiIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726708615; c=relaxed/simple;
	bh=Upjkz1WwJyOVqC0/gZcrjT4gVVKcF1aKd/m6zhRSm+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l8oMCem0GMm95EIU8vnncs8WqvjafXXUn/myppd6Xz8IZi+v51gSFRlPwlcyomKeqBQXhGlclaciE/q53vh4FUjyVuzcTxbcJR8zwhMv3j3HjWvyW5UiVzYL1BWpY/DWMPYefWrXzBtYquVi6UpsRFAh/afuvTjUoP9nphZKV2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tpMyELFf; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tpMyELFf"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 706201CB70;
	Wed, 18 Sep 2024 21:16:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Upjkz1WwJyOVqC0/gZcrjT4gVVKcF1aKd/m6zh
	RSm+E=; b=tpMyELFfAubi9JJG8SARA8uZ5NsNrfQR2uND/yG44QCsyUezLoov3I
	mg7DvFOWdjbdDuRSR0FU/0mdqND2uyKEQc1gZ+j1pcVnRAHEhiZw2cxvKvpb6Sj/
	HEwxSNE44S3/CMh0AebKqCOErYdX9HfL0TvchxTKwOI8tsKlUOC/o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 678F71CB6F;
	Wed, 18 Sep 2024 21:16:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB3701CB6E;
	Wed, 18 Sep 2024 21:16:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Matt Liberty <mliberty@precisioninno.com>,  git@vger.kernel.org
Subject: Re: fatal from submodule status --recursive when used with grep -q
In-Reply-To: <7b4ce2fc-3763-4881-8459-e0c1f2cbc69d@gmail.com> (Phillip Wood's
	message of "Wed, 18 Sep 2024 11:05:08 +0100")
References: <CAKDm0rNaHbzoiPg=DeuCoxzooNAsxw2BJfc0wg7fC_-=o9uJ7w@mail.gmail.com>
	<7b4ce2fc-3763-4881-8459-e0c1f2cbc69d@gmail.com>
Date: Wed, 18 Sep 2024 18:16:50 -0700
Message-ID: <xmqq1q1ga1dp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D9E6FC52-7624-11EF-9A85-9B0F950A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 16/09/2024 16:08, Matt Liberty wrote:
>> If I try to grep the output I get a fatal error:
>> % git submodule status --recursive | grep -q "^+"
>> fatal: failed to recurse into submodule 'tools/OpenROAD'
>> I didn't expect any output but did want the return status (0).  I'm
>> guessing git is unhappy that grep -q exits on the first occurrence of
>> the pattern.  I don't feel fatal is appropriate here.
>
> I assume git is dying with SIGPIPE. As the only purpose of "git
> submodule status" is to write the status information to stdout that
> sounds reasonable. If you want to collect the exit status you need to
> consume the whole output so that the command runs to completion.

Yes, but isn't the main point of that complaint that "failed to
recurse into" is not a good way to say "because you closed the
reading end of the pipe, we are aborting the operation and not
decending into 'tools/OpenROAD' submodule", is it?

