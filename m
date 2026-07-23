Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A763F0ABE
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793642; cv=none; b=Ku6AltRkwXHTkbIZODQYAqUhCSVRkq22LB8CrxdaMgJXqczQi0PrcgZUUiY/K5DfTQsv0v6mDWaasYjpP3wyewP+2II1rg5fJV8F0w+zq8UarcRvohFhlf3ZmeEYCwFwnJ/TgCpLHEkcKrRdUImXqOTBVI0qQJ/BOB2grodMBfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793642; c=relaxed/simple;
	bh=xlr/DCgrq1e8HuiZWoTYYA/09LJFzRh5IQogX33AeNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+WKgVhb8mfovh/3gxpgkun5x4dpsnU6ABKvzVnf2DuS7v2XoBTMqLUDhniZJ8/A60DKmKBM6VpY+s0XxC9wpAv8RQorNLl7Z/EREycbgmWzzLSok5XE9A4R+qUbUjH6W+QrB1LA9S0jSEAWHAvFe/3iiv9YKDuJQyUqunV8D50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (213-147-165-249.nat.highway.webapn.at [213.147.165.249])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4h5NpP201TzRnCw;
	Thu, 23 Jul 2026 10:00:28 +0200 (CEST)
Message-ID: <d3337806-f044-4571-90f2-aaebb2e295ce@kdbg.org>
Date: Thu, 23 Jul 2026 10:00:27 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] userdiff: add support for Swift
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org, "D . Ben Knoble" <ben.knoble@gmail.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Eric Sunshine <sunshine@sunshineco.com>,
 "Scott L . Burson" <Scott@sympoiesis.com>
References: <20260717140232.6722-1-diy2903@gmail.com>
 <20260721065736.8747-1-diy2903@gmail.com> <xmqqmrvkw31z.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqmrvkw31z.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 21.07.26 um 21:33 schrieb Junio C Hamano:
> Shlok Kulshreshtha <diy2903@gmail.com> writes:
> 
>> Add a built-in userdiff driver for the Swift programming language so that
>> diff hunk headers and word diffs work out of the box for ".swift" files.
>>
>> The funcname pattern is built for Swift's own declaration grammar: an
>> optional run of attributes ("@objc", "@available(iOS 13, *)", ...),
>> followed by an optional run of lowercase modifiers ("public", "static",
>> "final", ...), followed by a declaration keyword (func, class, struct,
>> enum, protocol, extension, actor, init, deinit, subscript). The keyword
>> is followed by a boundary that allows whitespace, "(" (init/subscript),
>> "?" or "!" (failable init), or "<" (generics), while still acting as a
>> word boundary so e.g. "initialize(" does not match.
>>
>> The word regex recognizes Swift identifiers, hexadecimal, octal, binary,
>> integer and floating-point literals, and the language's operators.
>>
>> Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
>> ---
>> v2, addressing Johannes Sixt's review of v1
>> (<2a3a73c5-5e90-44a3-bf6a-6e98ce5e5a59@kdbg.org>).  Changes since v1:
>>
>>  - t4018/swift-{init,failable-init,generic-subscript}: "RIGHT" now
>>    appears only once, on the declaration line, so the expected header is
>>    unambiguous.
>>  - word regex: dropped the redundant "?" after the single-character
>>    operator class.  Single characters are already covered by the
>>    "|[^[:space:]]" fallback that the PATTERNS macro appends, so only the
>>    two-character forms need to be spelled out.
>>
>> (A couple of Hannes's other suggestions I kept as-is; I have explained
>> the reasoning in a reply to his review.)
> 
> Thanks for an update.
> 
> Let's wait for a few days to see if we hear more comments and
> otherwise mark the topic for 'next'.

This round looks good to me.

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes

