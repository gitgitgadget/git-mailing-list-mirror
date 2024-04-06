Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3922EF4
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395388; cv=none; b=I86pVtwCVYWvc424D3ZztCcY6hFMTI7qETDLLUJSkr84g4dJWQDQOT7CAwCafGF+4yCC6/Y1QvNMBneS1Rg9PBowqaXNinCRraTkkxPFTYYCR02AnE8rwA0u7GhYYpUwdvWiUEE2NWNpWgqsOSOLjUU6s1R9PPN6bArQn9IAtEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395388; c=relaxed/simple;
	bh=HsP1l+5HISfAzuqUZeDLkCv4dPG9/ojpT7rwWRrR0Lo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WIYnSZNO7veGpu73857o+FBLR1aI7ZvMGip8jRLuumUmQ/JSJuguFZuRsXLefriAbciDJrEiuEMstT9168/wFHt4/eO3w+uG/DkhstY8/YId0WPZJUaYKMMEuVTnXhiw8FfNw+7VZF3Ldbh0tNdyyRbC9N30BVUniySa1ft3KKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4VBV7l335yz1syCY;
	Sat,  6 Apr 2024 11:15:29 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4VBV7j5M8Rz1qqlW;
	Sat,  6 Apr 2024 11:15:29 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id ajxl5inBwdEg; Sat,  6 Apr 2024 11:15:28 +0200 (CEST)
X-Auth-Info: tI/gqynf4a9dG11C29xXCuEozVMAWU//C/t7mwa/FuWaGk9CAwU5qP+R9nSGVaJ9
Received: from tiger.home (aftr-62-216-202-57.dynamic.mnet-online.de [62.216.202.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sat,  6 Apr 2024 11:15:28 +0200 (CEST)
Received: by tiger.home (Postfix, from userid 1000)
	id 53C622736E7; Sat,  6 Apr 2024 11:15:28 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/6] CodingGuidelines: describe "export VAR=VAL" rule
In-Reply-To: <CAPig+cRjqe-rgYf5UZr9KXmfSw98ZoYjPo5PKhwzRaC-svwshA@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 6 Apr 2024 01:11:29 -0400")
References: <20240406000902.3082301-1-gitster@pobox.com>
	<20240406000902.3082301-2-gitster@pobox.com>
	<CAPig+cRjqe-rgYf5UZr9KXmfSw98ZoYjPo5PKhwzRaC-svwshA@mail.gmail.com>
X-Yow: I wish I was on a Cincinnati street corner holding a clean dog!
Date: Sat, 06 Apr 2024 11:15:28 +0200
Message-ID: <87bk6mc0nj.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Apr 06 2024, Eric Sunshine wrote:

> On Fri, Apr 5, 2024 at 8:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>> https://lore.kernel.org/git/201307081121.22769.tboegi@web.de/
>> resulted in 9968ffff (test-lint: detect 'export FOO=bar',
>> 2013-07-08) to add a rule to t/check-non-portable-shell.pl script to
>> reject
>>
>>         export VAR=VAL
>>
>> and suggest us to instead write it as "export VAR" followed by
>> "VAR=VAL".  This however was not spelled out in the CodingGuidelines
>> document.
>
> I suspect you meant:
>
>    ... and suggest us to instead write it as "VAR=VAL" followed by
>    "export VAR".

There is no difference between them.  The export command only marks the
variable for export, independent of the current or future value of the
variable.  The exported value is always the last assigned one.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
