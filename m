Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4E01BC44
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821972; cv=none; b=Oc+n0NP90TfvhDk0V5igCb8xwkWv5X4muIcromLovNPl6Q8h+N0MKUJOzPnmW0Bsq+SxPYznUzK1OVFk1E/TfjCdVZCKgfTFRe4ZZKptPtVRUfiuWqaWGfohejLrYhrXHJqaDE+bDtFD9xjDT9nZJiQVQQCntJ4nCsc03swsdIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821972; c=relaxed/simple;
	bh=LxaYgEFVZoLXZFNYN710k6JzwZ9z+wqpvS18JBoya/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=od8+VFZa6U00+vlh8Y2XWuUTk7nYf/bHwRTX/51PZD4NJ5qIrQp+/lvC0bMxifMX7BADVX0/HxCvuFXANzLnN3u/jsjNxjfsrPNmcWOzbkuuoNYcOdoQAE6VKjSS2sbJn9atd0Ct5TTtAtovA9B+bpuZaig+/26SCKuth2jm7jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kLgHKAda; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kLgHKAda"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7816F2B9A5;
	Mon, 22 Apr 2024 17:39:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LxaYgEFVZoLXZFNYN710k6JzwZ9z+wqpvS18JB
	oya/Q=; b=kLgHKAdaoFfzc3W1Lur+DmGJHZLirHBDq0zr987CMLaQ86ZkV2Wvam
	+8fUfuqjGI9suRYhTmTDxclo/TCrnvf3PhRhlQwBQTs2zjmPNx0/G9UJ6DO1r/I6
	0ZVYuTiJfjju0DyMCWgSS3noa7SAOub6hRpGstnpaDpKC0VhsiDhM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FEA22B9A4;
	Mon, 22 Apr 2024 17:39:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28FA42B9A3;
	Mon, 22 Apr 2024 17:39:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] for-each-repo: optionally keep going on an error
In-Reply-To: <20240419175621.GB14309@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 19 Apr 2024 13:56:21 -0400")
References: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
	<pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
	<abd796894c857fc9ad96b9942089474df01f0506.1713444783.git.gitgitgadget@gmail.com>
	<ZiHyGFRPm_pwdGgC@tanuki> <xmqqy199l4qf.fsf@gitster.g>
	<20240419175621.GB14309@coredump.intra.peff.net>
Date: Mon, 22 Apr 2024 14:39:23 -0700
Message-ID: <xmqqr0ext6us.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C9EF4470-00F0-11EF-BB75-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> run_command() may also return the exit code of the program run. So
> imagine a setup like:
>
>   git init
>   git config alias.foo '!exit 123'
>   git config repo.paths "$PWD"
>   git for-each-repo --config=repo.paths foo
>   echo $?
>
> Before the patch we see "123" and after we see "1".

True, or when the process receives a signal, etc.  With this change,
we do lose information.

> I do agree that passing -1 to exit is bad; we maybe should normalize to
> 127 for not found, though I think we could also see -1 for system errors
> like fork() failing.

True, but I think that is a separate issue.

So, let's have a (hopefully final reroll to fix the error code when
stopping at the first error and merge it to 'next'?

Thanks.
