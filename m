Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD83A5459
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808621; cv=none; b=rVtSY2epRoE5tBMNuthSI6QzXrhz4hZ/KH74qLk3wLp9kVgflUEvv6IAtcB6SK7YMvZBUlbUZnEf/mkOn9vga7UYDlA0XhxqeA460nRXDWhirclNfBQN0Zmn6FjIvjjI0kzIbb0lo63OeOKDDS/E+FDuBLUxhcSUA+g+f9jyWwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808621; c=relaxed/simple;
	bh=UCmcaPxbF0sjIDtOzE3mZsXyzo0K6exunJlyZuxt+Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Hsv5XgUHVjmlLZE+5lcMe/3QVX+8QhuEa2WlHls+Su4tM/NS+xuXLtZJlRByOr6tYgRIYTKjZSqHUgUzl2cCKiMFcU0wrmuTqxVAqX+y3IMu6MiWQBh83eihAVkZkjxtYBWzFdzEVCKaGl2OULRIvwGAqyXhQ0VlGqMMLwt2g9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4fsT9r4vzYz7S1YK
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 09:35:44 +0200 (CEST)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4fsT9f5FdXzRpLK;
	Fri, 10 Apr 2026 09:35:34 +0200 (CEST)
Message-ID: <1b4c3562-8501-433e-afaf-2cb3a295b4ac@kdbg.org>
Date: Fri, 10 Apr 2026 09:35:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
To: Patrick Steinhardt <ps@pks.im>
References: <011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
 <013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
 <20260408173949.GB2850002@coredump.intra.peff.net>
 <xmqq4illz5g9.fsf@gitster.g> <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
 <xmqqqzopxkxa.fsf@gitster.g> <016b01dcc79e$87472860$95d57920$@nexbridge.com>
 <xmqqcy09xh53.fsf@gitster.g>
 <20260408223233.GB2873736@coredump.intra.peff.net>
 <adbwyvQ-R2Ag1vox@fruit.crustytoothpaste.net> <addgkjiB80pgKw69@pks.im>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 rsbecker@nexbridge.com, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
In-Reply-To: <addgkjiB80pgKw69@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 09.04.26 um 10:17 schrieb Patrick Steinhardt:
> Yeah, agreed. I think we shouldn't make ourselves a hostage to platforms
> that don't have reasonable support for writev(3p), as it does buy us
> something on the majority of platforms that actually support it well.
> 
> That of course doesn't mean that we shouldn't support such platforms.

My take on this matter is that the use writev in Git's code gives POSIX
centered contributors a false sense of security. POSIX's writev offers a
number of guarantees that a compatibility implementation cannot provide.
If uses of writev proliferate, I forsee the time when someone reports a
problem on a compatibility platform, and one of us will point at POSIX
and say "but that cannot happen because we have this and that guarantee".

What did we gain with writev? There are half that many system calls. So
what? Have there been any hard numbers about better performance, for
example? Not even the call sites became simpler, see the commit that
introduced the only caller: 26986f4cbaf3 ("sideband: use writev(3p) to
send pktlines", 2026-03-13).

-- Hannes

