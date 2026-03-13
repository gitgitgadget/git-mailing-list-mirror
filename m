Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15E396572
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405548; cv=none; b=FJq812dbxkVCYLFO9dZtcRNa8kjS4N47qRpe54YQrFZpAVxbCpwfrO+lqKndBk/xrpHFS2Xp7vU99GHOtJ2z3+0C+7v9BGH0ExEVPpebUrWw0eZV3CBMQ64saWRdWOvLr+MTp6gkloOWF+0dZqsysNRcShdxrenwpppFoa3LfcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405548; c=relaxed/simple;
	bh=AO9NkwzfP+Vl8HoPCFdP5uotWCfv/0Z1kFPrEsaKLmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnS2cGaeEQ9Hg2ALa2u5KMFjT4VijrwRHupOR6uR1+89c/gDbzXsGsM8E33noyDgr1QKet3ctcKwtBfPPS01r2K/b+uEi2qyD8D8bzNxd5Y9uD2EWhzGQFRmhVQgEUF6h/LsV1YqfxG8yPyaGXyVv1cGbkA7fZwft1b3IWA7Wo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4fXPDd5wZRzRpLH;
	Fri, 13 Mar 2026 13:38:57 +0100 (CET)
Message-ID: <7905c1d6-ae6e-4930-b4bf-d1129685d10f@kdbg.org>
Date: Fri, 13 Mar 2026 13:38:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] run auto maintenance in git-gui
To: Wolfgang Faust <contrib-git@wolfgangfaust.com>
Cc: Birger Skogeng Pedersen <birger.sp@gmail.com>,
 Pratyush Yadav <me@yadavpratyush.com>, Marc Branchaud
 <marcnarc@xiplink.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
References: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
 <e17f094f-f869-4cc9-b59c-091b7e61a021@kdbg.org> <xmqqms0jti24.fsf@gitster.g>
 <40ccd060-e6f7-4130-a25e-3c2f65df8eb7@kdbg.org>
 <876fd32d-3965-4587-b567-399787741247@app.fastmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <876fd32d-3965-4587-b567-399787741247@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 11.03.26 um 05:48 schrieb Wolfgang Faust:
> However, it seems to me that the conditions you outlined are very
> unlikely.

This was the whole point of my argument.

> In particular:
> 
>> - They configure maintenance.* to do more cleanups than the default
>> confituration (which is the same as `git gc --auto`, I think).
>>
>> - They never use `git maintenance run` through some other facility.
> 
> Are these not more or less mutually exclusive? Why would someone set
> up maintenance to do things, and then never run maintenance?

The system configuration could be set to non-default values.

But it would need quite some determination from a user to side-step any
and all explicit and implicit `git maintenance` calls on such a system
instead of countermanding the configuration in the personal (global or
local) settings.

My point is only that these conditions aren't mutually exclusive, but
still unlikely in practice.

> Given the above, I see two options:
> 
> 1. Assume that in practice everybody wants auto maintenance and
>    `gui.gcwarning` is set because they were annoyed by the dialog.
> 2. Assume that some people do *not* want auto maintenance, and if the
>    `gui.gcmaintenance` option is unset then show some kind of dialog
>    that tries to explain the situation to the user and encourages them
>    to set `gui.gcmaintenance=auto`.
> 
> #2 is the safer option, but is rather complicated and involves
> bothering every user for the sake of strict compatibility. I assume
> that git core itself had to make a similar tradeoff when deciding to
> enable automatic garbage collection, but I don't know where I'd find
> that discussion and perhaps it's far enough in the past that the
> rationales are no longer relevant anyway.

Let's just call `git maintenance` on every commit except when, for
legacy reasons, gui.gcwarning is false. No new configuration, please,
until there is proof that Git GUI users really do not want the standard
`git maintenance` behavior.

-- Hannes

