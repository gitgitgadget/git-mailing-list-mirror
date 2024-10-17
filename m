Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31581D86C9
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205928; cv=none; b=arEN/NAHQdOr6qtdSpMyQeg7olwT0+DwVd4EJK1boKH2z8sg0upVcuIIG2dOT05O3e40szP8fVD4cnOvbwzwQ4qVgQM4d6K5bB6MEz/CpTIQmlD+2jHBg+heLrR3e/kq482p37MzAKkX82LxMlIm97a98uf1EVYrlJz1uHkqq3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205928; c=relaxed/simple;
	bh=5I71jSMCijmpH8G76NrMw8qeOfnT+W+cpVh6D0+SDDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxaNewx+iFwk13KN+A1wtU2x3jGJ35U2tfBVV2GAnKdFOKDamQGUbwLio1zAZIIHc4W55KOvXAOjSR6Ej/zLS9j09QQN9mExh5hSrPRe5lk1aXAoXHb1BuFE3toDwao1k3aDQbHiTAnJjvarW40/Hmnw/wlJZ9k4Cv1y266NX+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=QO64fh8D; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="QO64fh8D"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 1ZRxthdmqxile1ZRzt9V1u; Thu, 17 Oct 2024 23:58:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1729205916; bh=yAoji/5nzLRJDRb4r26ZOV6b6HKohh6KPPCbepANMFk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QO64fh8DV6Jir4Oq/e4pjStz4NofwJM3f2o5gWJWctoMPs4wjV/TcJ4mv3xdcaClD
	 r+ms42ZuBXwuf60veqn+MbEc0aO0/SZE2wKcS6+Xu2DA+M5ySOSN9cZxRubYgake/a
	 gW7XV10JXq16XnCC+suENPt4ZuWL/PqJYZaBPKLP0pvJbyk/TTr1mKApD1XEO3DUSK
	 wET0jw42SGnaEOHwh2g2jKzeLAsolS/cL+L9HBzR0CgdgIOydu9V6LlBtqViH5iu9J
	 vzGab8gI6KYRdKbZaysl7G8XsyUynTFHMU7vQlzFjZoZP5zX8E3dJp4TACOC0ybWsI
	 GkL6JmPkMPKtg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=VaJUP0p9 c=1 sm=1 tr=0 ts=6711969c
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8 a=e8xuOEgHkGoMoMpOaysA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <395cd934-f6a4-4f08-8bbc-f5a068ebfa39@ramsayjones.plus.com>
Date: Thu, 17 Oct 2024 23:58:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/credential-cache--daemon: fix error when
 "exit"ing on Cygwin
To: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
 Adam Dinwoodie <adam@dinwoodie.org>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <20241016145539.GA703747@coredump.intra.peff.net>
 <20241016150922.GA1848210@coredump.intra.peff.net>
 <ZxAiAUdtddwk5RS7@nand.local>
 <20241017023319.GA1858436@coredump.intra.peff.net> <ZxDOydD7kpSGchiQ@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <ZxDOydD7kpSGchiQ@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHhu7vWLEl3R5gqoIplcT2Twms5oQAukzV827DSj8Peo5SGrXhqA1j1UN6p95cZbGGLxWy1oQbvYKahJVr1IuBAdBpeQKFQ3RSXctjEnRcI62VqkQ+P/
 i6eMx7ytisH4x26IEKGhfRjDNw90uDsD70IOgF7xBlk+oV4Xh25XtRhBeut7/Cs52x8cNUJdmTF9CaBGUXoYqXw6MvcSfKXKd8M=



On 17/10/2024 09:46, Patrick Steinhardt wrote:
> On Wed, Oct 16, 2024 at 10:33:19PM -0400, Jeff King wrote:
>> On Wed, Oct 16, 2024 at 04:28:49PM -0400, Taylor Blau wrote:
>>
>>>> This all seemed eerily familiar. Try this thread:
>>>>
>>>>   https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/
>>>>
>>>> It looks like the conclusion was that we should adjust errno handling on
>>>> the client side, but nobody ever followed up with an actual patch.
>>>
>>> Thanks for digging. It would be great if you both and Ramsay could unify
>>> on an agreeable path forward here.
>>
>> I think the patch Ramsay posted elsewhere is the right way forward.
>> Hopefully he can fill out a commit message with the summary and then we
>> can proceed.
>>
>> (I'm happy to help with explaining the credential-cache side, but I
>> would just be hand-waving on the cygwin parts).
> 
> Sounds great to me -- in that case, let's just drop my patch. I was
> basically just trying to get somebody to have a look at the issue, and
> it very much seems like I succeeded :)
> 
> Ramsay, do you want to polish your patch with a commit message or shall
> I pick it up and iterate on it?

I can't get to it before the weekend, at the earliest, sorry! :(

If you fancy picking it up, please be my guest! :)

ATB,
Ramsay Jones


