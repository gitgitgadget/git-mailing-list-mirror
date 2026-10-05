Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C8D3793B0
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186452; cv=none; b=opdlF3WBt1XKddgo3mGQzW4k4sCyPMXYUDFm4m/tz7kHxri6nfQgR9ygUUwUqmW8HRn/Y34N54oF3eThvDZlCNpJnGX8cTViVIk6L2P14Q7EKRQ2B0jQGUIZLzrvZHbh1wPaNQv5G9tx9SmyLJOxi0SWZn/ryjNhpx2vxziuY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186452; c=relaxed/simple;
	bh=5034LZky409s7yvYPCJlKI4R/c6G/JB7ihyv16n+Mog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okrNShMMJhVXQDO/zwa9crWZU7obOWQvnJGqQV4mX8fxCPBwtK3esBwUpkhcfx6wVqvluyaFQeLJ77O1moYRaW3SReEyo3NdE5Ny6KWlj3New4cF8kQEkjLzoQl7VaU+imyvsEoJ87BZu2O9r6ZoPu60V5YAsT1MrHTDuSi2+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4hys1461KtzRpKh;
	Mon,  5 Oct 2026 09:47:20 +0200 (CEST)
Message-ID: <e1635b9c-bc03-4835-805f-5fa52f09364d@kdbg.org>
Date: Mon, 5 Oct 2026 09:47:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] git stash: add porcelain for sharing stashes through
 remotes
Content-Language: en-US
To: Hanan Arshad <hananarshad619@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net
References: <arw5XxJPNlUxU8TS@fruit.crustytoothpaste.net>
 <20261005055337.7579-1-hananarshad619@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20261005055337.7579-1-hananarshad619@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 05.10.26 um 07:53 schrieb Hanan Arshad:
> The revised interface I have in mind is:
> 
> Publish one stash to a user-selected remote ref:
> 
> git stash publish <remote> <remote-ref> [<stash>]

I am actually not very happy with such an interface. The premise to have
it is that stashes are something that can (and should) be shared with
other people. But this is not the case. Stashes are strictly personal,
short-lived, work-in-progress-not-worth-to-be-committed states. If you
use stashes for longer-lived, worth-to-be-committed, sharable project
states, then you are doing something wrong. You should be using branch
labels instead.

> 
> For example:
> 
> git stash publish origin refs/stashes/hanan/fix-login stash@{0}
> 
> If <stash> is omitted, stash@{0} would be used.
> 
> Internally this would reuse the existing stash export mechanism and
> normal push machinery. The original local stash would remain unchanged.

There you have it. If a stash is worth to be shown, then do take the
long way via `git stash export`, and push the ref. Or just do

  git push origin stash@{0}:refs/stashes/hanan/fix-login

There's no magic support needed (nor, IMHO, desired).

-- Hannes

