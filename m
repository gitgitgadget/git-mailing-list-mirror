Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12BA1C84B2
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628525; cv=none; b=LXX4UfzsuqjKdhoqD5ACuPIB1cNmOcwgRUHjgnfkLxuJcrYR/2TZFea766lns48J7eAlBW2d9ERQF6bOwlPGsP0J1464DdIrVgWvVimU9J/Mq0SOoUA8oEYoDLDJjD4GyENn/RIQS6D4iaUe8VscpcqCt9/dOpxAQYgmDSQIigc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628525; c=relaxed/simple;
	bh=K1l1g/wGLfMxJyyKld4po9wYkkPKECK+vHeCN617A4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNpuyESIAUfIGNtnX3VYYR2ZYVLa1zA+Wl6ixXmuOpiSPYGcPMnrPs5AmqQCm85uF16JB+8E3vXD5ttbeG6cnczvUPXXr/MmwlX4gPoj/bX0FwgDtASaDwpVKV+eLn+DSJh0YYQw2Dz7zsAhhk40iooUwX8uK2OKX9/CtVygZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4cnX0f1LpnzRmx2;
	Thu, 16 Oct 2025 17:28:33 +0200 (CEST)
Message-ID: <8b7df500-4ddd-4aa4-bc67-b1b345c806e6@kdbg.org>
Date: Thu, 16 Oct 2025 17:28:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <d17060d9b72.1759952528.git.code@khaugsbakk.name>
 <601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org>
 <52fd63c0-cd43-4ae8-af3e-f3fae02eaabf@app.fastmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <52fd63c0-cd43-4ae8-af3e-f3fae02eaabf@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 16.10.25 um 16:13 schrieb Kristoffer Haugsbakk:
> On Sat, Oct 11, 2025, at 11:15, Johannes Sixt wrote:
>> Am 08.10.25 um 21:45 schrieb kristofferhaugsbakk@fastmail.com:
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>
>>> This option has legitimate uses but could create a commit history which
>>> violates the assumption that commits are strictly increasing in terms of
>>> commit timestamps. Warn against that in both git-am(1) and git-rebase(1).
>>
>> I think that the discussion has meanwhile converged insofar that we do
>> not think that the option has a legitimate use case. Rather, it was
>> introduced to solve one particular problem case (that is cited below),
>> but with a solution that was misguided and not well thought through.
> 
> Okay if this was the cited example:
> 
> https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com/
> 
> Then we can clarify with two questions:
> 
> 1. Is the use case itself reasonable, i.e. abusing[1] git-am(1) to
>    pseudo-import commits (modulo the committer)?

The cited example talks about a set of patches and expects them to
create the same object IDs each time they are imported. This expectation
only makes sense when the import happens on the same base commit. But
then, why in the world would one want to import the same patches
multiple times??

A mailbox full of patches is not a suitable storage form for commits.
This particular use-case for git-am just does not make sense.

> Note: Not relevant here but in case there were more than one paragraph
> on this option already: should the WARNING be the final paragraph? Or in
> the second paragraph? (Like an imporant aside interruption after the
> introduction.) I think the final one but just clarifying.

It certainly depends on the case. I think I would begin by putting the
warning last and then judge whether a better place is warranted.

>> Perhaps insert "Do not use this option." as the the first sentence,
>> either before the description (my preference) or in the warning.
> 
> Regarding reading flow, this seems more back-and-forth than this patch.

Fair enough.

> Like this?
> 
>     Do not use this option. By default the command records the date from
>     the e-mail ...
> 
>     WARNING: ...
> 
> In that case I think parentheses makes it read better:
> 
>     (Do not use this option.) By default the command records the date from
>     the e-mail ...
> 
>     WARNING: ...
I do not like the latter. If you do not like the former, I wouldn't mind
not adding the sentence. The warning should be sufficient.

-- Hannes

