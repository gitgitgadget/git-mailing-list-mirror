Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BA285C8D
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616006; cv=none; b=XFpK6KuN7dQnQxPCC1BvLg+PnNN3tHeAiDVMTw9+qWFnlp6SJS6w7cNEo31uWkvX6Jcqd1UVjbf0KJTJcmFyOjGrLKCtz/Rg9H41HytxL72t/EmDTincpiO+IAKpAYB7uB7WhpHsfyQnLRg/9neAn/guDxImcwTbRMnQ9zQ7Nys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616006; c=relaxed/simple;
	bh=dsvOp2AddY+raXsgYCaCgZ1R3qxmwyXC04DX9oXQcHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRyh7KHr4RPNxFqmTW5GAH/DSEPEh+x2EgzXV6lSZTaAxg/mwgNg7Uwx9atVzQm0oLCN7jTC8EPvmu+MfmwijaSQ3M/PEg7380r6+MZYXsdrVOp6xtrkR6eyefokYyctyb1EIW2eima0XHLFoF3LYHFqgQVbm+ZLAEuCGF9zcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4f1Rmq5ng5zRnlY;
	Wed, 28 Jan 2026 16:59:55 +0100 (CET)
Message-ID: <bf8e6231-e1c0-4c0c-b4d5-20f8d0044211@kdbg.org>
Date: Wed, 28 Jan 2026 16:59:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC v2 2/2] diff.tcl: call "apply_tab_size 1" to fix
 alignment instead of spaces.
To: GitHub Chris Idema <github_chris_idema@proton.me>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Michael Lutz <michi@icosahedron.de>,
 Pat Thoyts <patthoyts@users.sourceforge.net>,
 Chris Idema via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
 <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
 <e11aa6d811dcf868fd0f91b74cdceb8bc3f4229e.1769545996.git.gitgitgadget@gmail.com>
 <xmqqsebqem1n.fsf@gitster.g> <xmqqfr7qeixq.fsf@gitster.g>
 <71494127-c17d-4fd9-a69d-1f547205ac8f@kdbg.org>
 <Rrnh0ugGQ5ef_s-3W0Tive8HA9R0_9Cq6yK7K6SS6Jr3kPigHai3jzxvphTRNXXNhCnor2TMV8UjKEi5U27VOLBf-R4g6VbJBLq8PQH9kCI=@proton.me>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Rrnh0ugGQ5ef_s-3W0Tive8HA9R0_9Cq6yK7K6SS6Jr3kPigHai3jzxvphTRNXXNhCnor2TMV8UjKEi5U27VOLBf-R4g6VbJBLq8PQH9kCI=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.01.26 um 15:02 schrieb GitHub Chris Idema:
>> I concur. Also, "apply_tab_size 0" is needed when the contents of
>> an unstaged file are shown instead of patch text.
> 
> Can you explain why it's needed?
> The file in my example is unstaged and it's a patch text.
> ...
> Can you show me how to get content without patch text in the window?

Sorry, I meant "untracked file". When the text of an untracked file is
displayed, we do not want to offset the tabstops.

> 
>> +	if {$have_tk85 && $firsttab != 0} {
> 
> Gives me the error "can't read "have_tk85": no such variable"
> If I substitute 1 or 0 for have_tk85 it doesn't fix the alignment.

This was not a suggested fix, but a citation of the patch that
introduced the function. The variable has since been eliminated.

> I'm open for suggestions. My 1 line code change fixes the problem,
> but if it is not the official way to do it or if it introduces other
> problems feel free to suggest another fix.

It may fix the problem for regular patch text. But I doubt that it is a
correct fix for combined-diff text, because that needs offset 2.

> For us this bug is a show stopper that makes the diff in the
> git-gui window by default unreadable.

Earlier, I said that I'm not fond of such a change. But I changed my
mind. I hadn't noticed so far that Gitk applies customized tabstops. Git
GUI and Gitk need not emulate the behavor of terminal windows faithfully
and can be more clever as far as tabstops are concerned.

-- Hannes

