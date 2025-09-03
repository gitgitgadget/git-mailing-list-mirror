Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F51E1C36
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917063; cv=none; b=elQs+a4ukDFcjVGNaG+YZiEuNWyPPEPxx2/HqIBqKf2rrzWS66ZNtDAaLSAnnMDquJ941La59W1S68Iqvj6YRo7IiddmzBqh86/0tTJQWuxlPd/LQFO50CnAmWhWDdNDm1Vv6+HwtiPNX+8KmNYz9tzSptw1QXsIZXPkGCrjCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917063; c=relaxed/simple;
	bh=jA6OdDmjG/A5VnBbQsBEw8V+lJKzzGSwyLMjMy2TF+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aC4jzEf94RtmF4CB3JkZokkDe+utiuqw8K2LAPCUhp2Gk3z5YsHH+mO+VCMINqtai2BQx0HzW2LnJ2GndgKREG5IXDimZvPiKvmGKIrOVYRlvqf7q86iM1xnd/cV58AF69/IGUYz9gmz32tlIoVeUNzxJvOxlDuSSbKIrzVWx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bjPSRNr6; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bjPSRNr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756917058; x=1757521858; i=l.s.r@web.de;
	bh=ODCJhVVgJTQ2yL4HMmZBG6L5Pn/GJkR3JyzTaUyQuXQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bjPSRNr6M/A7fvBUG4p1Sr6tj8dgybK5l+C5Phgj9bFuyR/fcb3pJwbTmyAY7Qqf
	 9T+gc7Q7swTNe7jxm0EiIN5XBpVbAQLn/nuWIumJkHTvMHJtgQzr09fulXgG9GLL1
	 W4Nig40Frf3rMotmjOckij9yVhBCXVIUgwdbhUp19cS20y/3aS7ydKuTSjfm+eaUK
	 saGmwLd1mvY+eEGTMjO/15/FA3pl0hQ3/8r+FSYz0H56cY7/4YKhQ5idSHTJuUt3z
	 cP0BHMiiV6CKIApZfxob5m45rLzKD+5obh8W9BURUQkc7EgNSCZQPdXaNzvDN03gE
	 48Su8YBlkPo7fqIg4g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.159.98]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOUtg-1v6QlI1BoU-00OEth; Wed, 03
 Sep 2025 18:30:58 +0200
Message-ID: <aeb6aa64-c2f8-4b28-a2cf-9662907b5feb@web.de>
Date: Wed, 3 Sep 2025 18:30:57 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
 <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
 <20250825073403.GA332447@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250825073403.GA332447@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FGxU7P/ZwWp7BUMUektVuekyPIO6oP3Pdh+R7AKud35gMLeecjo
 U0Y57GUQXiMd++/JHDDlrcxGiJbhvUoeAI2Q5BMQL2SqjB7KVYnKXdanMoeblJci62Lff09
 XdO6qGHDFEP5eAdN6vLIOykjy4x59D3JIa8FTnDL4I+LRJJU4rLF2HXhcoYf6dDNXJNqPsZ
 RzdZcgPFuzS7Ca/BQkZ3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ONXK1jakqDk=;AR+wGIoBOSTAPg7MsK/R+8aGWCA
 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
 UPGlrExUcZcCTScuDUd

On 8/25/25 9:34 AM, Jeff King wrote:
>=20
> [oidset instead of khash]
> But the bonus here is that we didn't need to define a new hash
> type, nor do any tricks with the commit->index field.

It took me a while to notice what's tricky, or rather inconsistent,
about the khash set of commit objects with commit index as hash: We
could just as well go all in and use an uint32_t khash set of commit
indexes.  That would reduce the memory footprint further.  No pointers
needed here.  Didn't measure a meaningful performance difference
though, so that's that..
Ren=C3=A9

