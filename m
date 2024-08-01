Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E24172BD5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516895; cv=none; b=pfrHb8CxKiU6Mc3MWHxe2TzqbUCrzWXQFRwEt6fvIk7L53E10ADt1drO2ZrAKwj8Sx2r1Ml0g2dEOY+0n/W0vXCcf/qiWnB/OEnFkQ6ScCzRxvAJtdIl0/2qOfAx/G0fokSjll47cowK3+dPrxVsvjP1voAm4Y5PaeklxjAVKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516895; c=relaxed/simple;
	bh=ZXj9RlE0xH13etrSKfgAf2qriH1MYz5d/cSietCpqP0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vm6dg8WZ0wnkybVCgm/FYwczA0OnVWAoj88nOEiDCyQQmjgsZSsRNjgboMdFPYQFhWw1aGqFsvo1CNOZ2xZ416LDCp0xLZ0Wy9RDHRZRS1pSc3NfIHHitEj3ZlGP6H/vEt3ucRKTljxE8hYDvCMS4aYry85OHGU3XSxb8Qmgp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 471Csgq33432956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 12:54:42 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <rsbecker@nexbridge.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'Josh Steadmon'" <steadmon@google.com>, <git@vger.kernel.org>,
        "=?iso-8859-1?Q?'Ren=E9_Scharfe'?=" <l.s.r@web.de>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Kyle Lippincott'" <spectral@google.com>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>
References: <cover.1722415748.git.ps@pks.im> <b3db953e88ece99b441993c9248223cc0ecc6be8.1722415748.git.ps@pks.im> <463oz7j4btei57brq42zlnsydguu74n2n22rhdq7iwjk4y2bei@6r32nghurrmr> <00a801dae384$de2780d0$9a768270$@nexbridge.com> <ZqtWDtqkXzjz2A8u@tanuki> <01c201dae40c$821ab5e0$865021a0$@nexbridge.com>
In-Reply-To: <01c201dae40c$821ab5e0$865021a0$@nexbridge.com>
Subject: RE: [RFC PATCH 1/3] t: import the clar unit testing framework
Date: Thu, 1 Aug 2024 08:54:36 -0400
Organization: Nexbridge Inc.
Message-ID: <024601dae411$faab2cb0$f0018610$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQE2Q9x0fuag13GoRDOLG7kBaq5wcQE8qfSQAlNXoAsBzj75QwLkmT4KAVwZTGWzDqOXsA==

On Thursday, August 1, 2024 8:15 AM, I wrote:
>On Thursday, August 1, 2024 5:32 AM, Patrick Steinhardt wrote:
>>On Wed, Jul 31, 2024 at 04:04:29PM -0400, rsbecker@nexbridge.com wrote:
>>> On Wednesday, July 31, 2024 2:27 PM, Josh Steadmon wrote:
>>> >On 2024.07.31 11:04, Patrick Steinhardt wrote:
>>> >> Import the clar unit testing framework at commit faa8419 (Merge
>>> >> pull request #93 from clar-test/ethomson/fixtures, 2023-12-14).
>>> >> The framework will be wired up in subsequent commits.
>>> >
>>> >Rather than forking our own copy of clar, could we just add it as a
>>> submodule
>>> >instead?
>>>
>>> What are the requirements to build/use this?
>>
>>In its current form, Python is a dependency due to "generate.py". I
>mentioned
>>elsewhere though that I'd be happy to port it to our language of choice.
>>
>>Other than that it should only require a C89 compiler.
>
>Unfortunately, it needs gcc, but that is just because of its Makefile using
cc -Wall
>(not portable).

It looks like clar needs CC=c99 when running generate.py, which is fine. But
there is no current way to
suppress -Wall without hand-modifying clar/test/Makefile. The options like
that should either be in
CFLAGS?=... instead of CFLAGS=... or we could introduce CFLAGS_DBG?= and put
-Wall in there - it is
only for reporting warnings which is done different in the c99 I have.
Ideally, the CFLAGS should come
from ./git/config.mak.uname/

