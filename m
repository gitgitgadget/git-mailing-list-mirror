Received: from smtp.smtpout.orange.fr (smtp-77.smtpout.orange.fr [80.12.242.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981F3A427E
	for <git@vger.kernel.org>; Fri, 22 May 2026 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470053; cv=none; b=Wl8WL5vpngER5JBq45qumGXnIhJtuOLGlyQMeasWiZqgDeYfTx98+KXcgpBwZwqPaXFY5Ia8NveOTQ4Fncoh1L700whp7ogd7DNY/2U1Pcy8VgaoQ3nAuw231E9fCdHE2WEmsgwlRuvRn1nC79h1FS8fLsdSouVSmBfxJK98O3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470053; c=relaxed/simple;
	bh=XM6LQKytISVEaVFYs/kR8Eb4ZLAwYPWHZbbZfwG6seA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jrcxofB7yQsFV6AHtGLRhvsq1+oy3nZ7K4xKDDVWf+KE6LHgYQglIQ632ePpR02dPFII2R4WefNFrTGSGmoeDxNovti1rqavrUj4BSdm0MHDYquQiVfFgBDRbisHnLlJdG9GnsI4xVGBUQTFskiyUpWOE5ejq5+uea1vUYoYxQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=orange.fr; spf=pass smtp.mailfrom=orange.fr; dkim=pass (2048-bit key) header.d=orange.fr header.i=@orange.fr header.b=r17Grs9j; arc=none smtp.client-ip=80.12.242.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=orange.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.fr header.i=@orange.fr header.b="r17Grs9j"
Received: from [192.168.1.16] ([10.65.86.66])
	by smtp.orange.fr with ESMTP
	id QTRiwVEV0kSdOQTRiwzfzG; Fri, 22 May 2026 19:14:02 +0200
Received: from [192.168.1.16] ([90.26.111.43])
	by smtp.orange.fr with ESMTPSA
	id QTRZwowPTBatQQTRZwOpwY; Fri, 22 May 2026 19:13:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
	s=t20230301; t=1779470034;
	bh=Gb/fuQ8+9xTeuSj+mQPpBrcqybZ8YDRXLQKM/dsUZ8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=r17Grs9jigbJ7U1KcG61wmC6pW9AYocBXVCM2OmPoObZdgfZApFzV4Yj/kWYUjSYZ
	 7NUQy3IkvHfuICJ19sUD8pApJpdbg5WLLTlXeCmAhrmrQLn65sfAuX0IgIPvt9BC82
	 V8KTHikkQ3CFFcCTa6gRNPCHU5lEERQvXKOGBnHzjkL9yUAStXD8DxaAxYUnGHh0YQ
	 eHBaPEL6V9CYFowHYFYzkqspmsxV8vSHOPEig3zcMLh/j1BHi7r7uh7lahfPYcGLVg
	 HFpcxTLicTCe9tdTXUkA2N3wwzkdv1C0qLZpyJk46kj3QoWKAFLbUFI6uocu4yZ16S
	 wfwBULPqVvkTw==
X-ME-Helo: [192.168.1.16]
X-ME-Auth: ZmFicmljZS5zYWx2YWlyZUBvcmFuZ2UuZnI=
X-ME-Date: Fri, 22 May 2026 19:13:54 +0200
X-ME-IP: 90.26.111.43
Message-ID: <9767f411-ce33-43a1-aafc-5ec4f7c04593@orange.fr>
Date: Fri, 22 May 2026 19:13:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why do we need to wait 1s between a git add and commit
Content-Language: en-US, fr-FR
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <36eec9c1-1d2b-4cd1-a64c-a02936d8a2ae@orange.fr>
 <b403477d-5587-4afc-bd02-dbd207c22e67@app.fastmail.com>
From: Fabrice SALVAIRE <fabrice.salvaire@orange.fr>
In-Reply-To: <b403477d-5587-4afc-bd02-dbd207c22e67@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Yes it throws 3000+ sequential subprocess calls at the speed of Python...

And the sleep time seems to be critical, 1s is ok but 100ms is not so ok.

I also have the feeling this is due to a git upgrade. But I didn't test 
to downgrade.

That is a major issue if we have to be slow while using Git...

It is not unusual to write a shell script with a sequence of add/commit.

Le 22/05/2026 à 17:12, Kristoffer Haugsbakk a écrit :
> Hi
>
> On Fri, May 22, 2026, at 14:28, Fabrice SALVAIRE wrote:
>> I wrote a Python tool to dump a wiki to a git repository, that does
>> basically a succession of subprocess calls to git add and commit.
>>
>> Recently, I discovered this tool doesn't work any longer and that git
>> commit (2.54 on Fedora 42 / 43) crashes randomly.
>>
>> I cannot explain this behavior since my code is trivial.
>>
>> I had the intuition to add a sleep time of 1s just after a git call, and
>> it solves the issue.
>>
>> I noticed for some cases that another call to git commit were
>> successful. For most cases, git fsck and gitk report issues.
>>
>> It looks like the state of the git repository was not yet completed
>> before the end of the git subprocess.
> This might be caused by git-maintenance(1) being run in the background
> without locking? That’s a new issue in Git 2.54.0. See:
>
> https://lore.kernel.org/git/20260509175249.GA2336928@coredump.intra.peff.net/
>
> The following script reproduces the issue on Git 2.53.0. I am guessing
> that your script does something similar? It depends on how many commits
> it creates in a short timeframe.
>
> https://lore.kernel.org/git/20260508180341.GB737125@coredump.intra.peff.net/
