Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364C3793BE
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655205; cv=none; b=HAb0r5kQeIUKaUAQCejNUFkadxelifbpcg1gQLsfXD27H/AsCLQVcg+3Kq2XPm8ts3zdt+AYQSMYfbv+3gRc2zC2WgXGsnIqCbBge2AxCav5b+XVPbWSdPbWxRRpH4lmfg3BmKa+kBwJdm9K+kAWdHD5WmT1pGyK5ieGB4F+dTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655205; c=relaxed/simple;
	bh=OFOLMPlvX0fvzmHZx3xuHEt809J6JKOaXpgCxctTqGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2hPAO06cMyLuOqMHMTmPvKncY9vOSyql40PkvEL521oJICBLHEuDbaFXEGtoh/uq3dNuA+P5QoGxhkYzYmHuEeQY2GPlF7MkVAiiaAxyw9njBqLec+3QANdl5+VUmGrGYr1nG4z7ZKI1KzmWLuUIQt61e7DOFsK5nGySdiDiDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4f8r5b0l9tz7QrZ9
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 17:40:03 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4f8r5Q0PxGzRnlL;
	Mon,  9 Feb 2026 17:39:52 +0100 (CET)
Message-ID: <5f64f9a1-fd1f-4683-b26e-76123b19554a@kdbg.org>
Date: Mon, 9 Feb 2026 17:39:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] graph: implement git-log(1) --untangle
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
References: <20260206-toon-log-graph-no-merge-base-v1-1-a6f983991a1d@iotcl.com>
 <ad776ca0-1038-43f7-860d-2f3a78a5db6d@kdbg.org> <87h5rqqv4y.fsf@iotcl.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <87h5rqqv4y.fsf@iotcl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 09.02.26 um 07:38 schrieb Toon Claes:
> ... Display in some way part of the
> history is missing, maybe by showing a '.' in the graph:
> 
>     *
>     |\
>     | *
>     | *
>     | .
>     *
>     |\
>     * *
>     |/
>     *
>     *
> 
> This indicates a piece of the history is truncated. I'm still on the
> fence about this

I like this. The line with the fullstop can then show a hint where the
graph continues, perhaps "(see 123abc456 below)" or something.

>     * main
>     |\
>     * | C
>     | * sync with main
>     | |\
>     | |/
>     |/|
>     * | B
>     | * A
>     |/
>     * initial
> 
> So here there merge-base isn't the first parent, so things get a little
> more complicated. Also when 'B' is ignored as merge-base, the merge-base
> needs to be recalculated to be 'initial'.
> 
> Anyhow, the idea is to show it like this:
> 
>     * main
>     |\
>     * | C
>     | * sync with main
>     * | B
>     | * A
>     * initial

If only the history leading up to 'sync with maint' is shown, it would
look like this:

    * sync with main
    |\
    | * B
    | .
    * A
    * initial

I would expect this sub-graph to occur when the full history is
displayed. IMO it's wrong to treat 'sync with main' differently just
because it is an ancestor of a another merge commit, as you suggested.

But, of course, the truncated connection between 'initial' and B
contradicts what would be expected for the full history (no truncation).
So, I don't know...

-- Hannes

