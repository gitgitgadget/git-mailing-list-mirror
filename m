Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2CA92F
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220613; cv=none; b=DbXI+xnwk03V7FKH3EvKjyAhShADJ+GkjHH2S0snZgYga+oNLIgX8GBAufabciQPmncTb1KL2ZmiibILbxOkKywYp/SyAL545bqDJyaU1z5R6nalgkQ5ucf5vo7WCVqJ0HJmFS5cL1J9Ko9cOUji1VWWTWqRwGmB25W6So3XzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220613; c=relaxed/simple;
	bh=GK1cBk5hYbklJbuJncOqVkj0ixd2K619Vx2tfQphz5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBRdCqUM4kMB9UXWpvvCB+J7clnMHljwRXbT2As6PlBMM6b+3DbbWOZi6OxZE3ayB/J6pPkjnapgXj+cN1/D3SNRjtyaGaMLPCtHcKaSY+qVEQ9l5Ym3Ff44AwX5aXvZ5axYIe/1sXIUYl2JiJu2cRzzMPUmaVTR5QMmQy8EnTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=e9YffUn8; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="e9YffUn8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737220608; x=1737825408; i=l.s.r@web.de;
	bh=FnJSHtv5On3dHjpGrXe7nGSyxIFZWEiPI5yPDMmv4kM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=e9YffUn8AtpRQ6CUE8aOqHvAC/2dAXC8UvY2LJlHxJUy6fZbAKc61/8FhL+bC9tZ
	 13FsNv6eESxW9QIee+bFTftdtUG/oNrII8gcdnAh5qWPxw4VV40WORPZs5DqEH/gp
	 WXUjsfL3AalvnypysCT4f7kMtdn6KAsF/If9dzmYr+ZmJtd5bTFtUKHmX9DyBwc7e
	 Rj22PSrAHeyS7+1NtUDDE07sUcmV18/+sENVVmw45siIXEEirZoT8WNt19jkJ/1dH
	 gFIWihts1160kJzIQsz8+YElBdXvl9Y8ZjaqsdgWxqxE1o+/jfslVJhpNSljYjPZX
	 rlMVdtlkxC12MyTYaw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.126]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59nK-1taIob3XAi-008gUU; Sat, 18
 Jan 2025 18:11:25 +0100
Message-ID: <2fbe47c2-22c0-49ff-a211-057bd96ddbc9@web.de>
Date: Sat, 18 Jan 2025 18:11:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ref-filter: share bases and is_base_tips between
 formatting and sorting
To: Jeff King <peff@peff.net>
Cc: Ross Goldberg <ross.goldberg@gmail.com>, git@vger.kernel.org,
 Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
 <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
 <20250113051700.GA767856@coredump.intra.peff.net>
 <57066d48-ce68-42ec-8e94-4ef6c1eba920@web.de>
 <20250116095128.GA144555@coredump.intra.peff.net>
 <20250116100637.GB144555@coredump.intra.peff.net>
 <20250116102154.GA724126@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250116102154.GA724126@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ygFcdJKgKu2yBKNmX5JcmH7FPZObYUWCQy2ZxPtTwpoiinvheQ7
 30qoigqHpW2CK6bz+AfUJiqLieBNs8qVbxq/eaglzd6Bz7WFmbhxsyOn+OM8rhYNYWeAtf2
 w07/bUa7/y14/mg7OvaRw1/5j5ShhXWBfnFNd3OCWcLisRdIXzmttf2DP84LaB9XSOmTNgL
 Y3Mps9+1Moi0AurqxbAjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:31oHhAKrwcA=;BGZVX5Aye9oelram/3t7Dnl5TnH
 P+SETg0NINHjs8l5mBo4j60le2FPwwjWrP4dGvZLKfOgJXOBD39Os33FQ72nnDY9qtU0DnBdV
 M+D/pdLkgca3rtUYlfQf50MVzC8mU+yWm05aoAPiGDvPPBKsdPaTNxI1A3J0avhgyhbrSQzIu
 hSxIJZBNh26WjG6p8/DTzpkY4KqCKtcr3f79gIAoIS81hoTnfBHIM/Fd8waKK+THX0fb9Qn9R
 WUlol4SI2MSsLicfR/PSqqmI1JrZjj3QfFoKRQGqL/WB+k2e7Zcv74bY6ma1jMiwGqKFg1ssb
 XnTFSTbifKcQ9bGnm61TzvYmUaHe31MiOTnkoMVN5230eeQVOP0xTj2R8s+H64DP+GFLzm7pG
 /0L+PMnz/zy7hfOdAiN2SSfLbVjaYoBIvADN8WP9uldi3w/5JegRBSJ3uFdCl2AJ5rXhB9OUz
 weagPX2iXtO1FlQ9dhoNbUPTDbv6fJCVnBzImDqUnC5peefQVOS5zRo/A3GfGQR+B2lB+qfwL
 SWEDGiLALysYvPk2xOPzB6P9w32/0IEtHWm/H8xJ1djajG9c8Z3SEAa1XBZ2ET1m1TuxcNyq8
 MdsiiWaldORHw3ay4yr6gvOwIeAMcNejhQUonaezB85yL7sAVZ4UCenx+SYG/66scsnTpcxiq
 LqLzUfI/9lV7ySn5canXEajRZTyTMsJwls9flDSzBe4O43H9gfWSvT+57fm/x8mhcBecVLPdu
 4EIX6Lb2JM6fItply4zBo+T5G6y2SJzi85ol7jvo1Vyc9g+R0MOBkO6OauUpSncxU1+PWD4LV
 6AHrHKsa59INTyBlHqxpwrG5blNFiGcagYzu7zjTaf1+YkdoMcDY7T92g8XCo9IqKLRZnKocN
 P3RtloILgIM3xZvopq/ogZdsgeHdkSB9Kfc5akWmwsfFOFdl4gTEJkSK4j3CnKfnQmCu/xF9U
 FhRedckK7lJ1dKy6JC8IO5/KSRsRTfcW8kJbF9pqb6lG8gf6xsvXr2YVSa6QrGw2+QHBWSieI
 zZsu7j8+RZu+ymQBkIoLECVtz0h/tO3jVxlSHWcAi4EG5XR0UVaCOsQP/pcW+4HRF4AGPv4+i
 bogZXzrva2kCXFdlfq0ZG6l2lNNTamSjTM7YDCZicM0TFvXwRjt+yUStlJpQpEGevmVcH6IYU
 1fcKPiyy9Di369llrkNniticJzMwi5gxahQ6dxqcW2Q==

Am 16.01.25 um 11:21 schrieb Jeff King:
> And one final thought on this approach: if we do want to do it, perhaps
> it would make sense to build on top of the patch you sent. I think yours
> fixes the bug in a more direct and obvious way, and then my approach
> would merely be internal reorganization on top.

I think moving to the right place in one step requires less churn.  Let's
compare; v2 coming up.

Ren=C3=A9

