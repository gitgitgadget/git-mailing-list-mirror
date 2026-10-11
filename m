Received: from smtp118.ord1d.emailsrvr.com (smtp118.ord1d.emailsrvr.com [184.106.54.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3D15A85A
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 02:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791686507; cv=none; b=hyyJfSsrzrXStVUFKMU8D3HvP0p5s0wGm8Awd8vssnBZXuVltqBRATY0iV29Mk4+IN/qQ7StLyilhOeji3zY8n0TELVpj8LEpnTVxweAeiUM8tOhlGIydgLJD4//r6nHgmG5jshJDsElsYurZLMFX8s66QsHFWaoMAuX3Bd/FG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791686507; c=relaxed/simple;
	bh=FE3S7Rp/B14e9cn+ISA7WfpZSQ7B1nKvEYeI7SsgTdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Oc/hdCLp+02mXnJtdMhDSKrwVCRvO8/WwNals/5KV5wxLne7wDcXDoK9laFswMacS2jC3BxHsODk1JpKNeBC7mmm5H98ji4zR1tZoUqiMk8rM4icocGKJvHLE5MvtbU4lwxBtqCNDNHH5vku3e69cRUBt+N9ZnLdIv1Ch3ekbKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=SkLA1Xpa; arc=none smtp.client-ip=184.106.54.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="SkLA1Xpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791686134;
	bh=FE3S7Rp/B14e9cn+ISA7WfpZSQ7B1nKvEYeI7SsgTdo=;
	h=Date:Subject:To:From:From;
	b=SkLA1XpaAy37gvMxOAWbjq0gLd2EgaZMQKm7aIiiQhF5Gton2M5JWSzwvuLiCS/k2
	 4bm6+Z5jia392eED57j7k7pfBPKjl+ofgpVKEn/DNFQ055Q3w9AgMcAfR0tEkLqF7a
	 eekcJBsi0YZL18wtSIepaqoxJsEqxmXxo8qYEfA0=
X-Auth-ID: jon@jonsimons.org
Received: by smtp23.relay.ord1d.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id C997F20277;
	Sat, 10 Oct 2026 22:35:33 -0400 (EDT)
Message-ID: <f949a5fa-5485-4ae4-a7dc-75afaef798cc@jonsimons.org>
Date: Sat, 10 Oct 2026 22:35:33 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] push: speed up client-side refspec matching
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <20261009192953.81794-1-jon@jonsimons.org>
 <4fcdf05d-b558-4471-b696-bd7c285f49e2@app.fastmail.com>
Content-Language: en-US
From: Jon Simons <jon@jonsimons.org>
In-Reply-To: <4fcdf05d-b558-4471-b696-bd7c285f49e2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Classification-ID: 6767642c-c16b-41d2-903a-9b781f97de38-1-1

On 10/9/26 4:18 PM, Kristoffer Haugsbakk wrote:
> On Fri, Oct 9, 2026, at 21:29, Jon Simons wrote:
>> Guide to changes:
>>
>>  - Commits are ordered to introduce failing tests for behavioral
>>    changes and bugfixes, before the code change that fixes them
> 
> This project prefers introducing the 
> regression test and fix in the same commit.
> 

Thanks, I did not know this, and in searching I now find that this is a
common review feedback [1].  And the commit history also shows that it
is uncommon for a series to be merged that introduces a failing test
then fix in a subsequent commit.

I'll look at squashing the commits that introduce new test_expect_failure
cases up into the commits that toggles them passing, for v2, after first
letting the v1 soak for comments.


-Jon

[1] A couple examples of feedback and rationale to not to do this from
    August 2025 here:

    - https://lore.kernel.org/git/xmqqqzxpzo8b.fsf@gitster.g/
    - https://lore.kernel.org/git/xmqqfrdk3aqy.fsf@gitster.g/

