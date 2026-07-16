Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1F2EEE82
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784228175; cv=none; b=OIhZaNp3gxcf6CIue0WBb4kUYUM49oHmYRaIJ2MqcYBI48ltGRcHcDLCBatzl/kt51ax12d7GElVWtgbYTY+cU5oXf4UOUrSXs+b00NRBaKQIvTIx66COmO81M58shghPFpeKnZXrWdWCi+mu79wAnESCRQ7nkuIPTIIqpAdvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784228175; c=relaxed/simple;
	bh=vfdTra887plfg35RIICaCTEEcm8ih8qERE/KkG0lK1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvtCbGSjUrpnvTA1R+8QEqxHXpMXoUrcGuuTBM48hz2lcpd+nLH3eD/yx+fcoq7ApT2WC9Y7yn6zf+/jrrx9+kEcHGRomnSGA4wACp+UFUDAVGMy6gAlQpk8+cOOl7qe3BKRUGBAEtF/bbSGc8aZwf0pGqG8Skry7qkk8ATccVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (213-147-165-249.nat.highway.webapn.at [213.147.165.249])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4h1Mh72MBkzRpWQ;
	Thu, 16 Jul 2026 20:56:07 +0200 (CEST)
Message-ID: <f8050598-392f-44c9-8d66-0454740a7a12@kdbg.org>
Date: Thu, 16 Jul 2026 20:56:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Reintroduce writev(3p)
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, "brian m. carlson"
 <sandals@crustytoothpaste.net>,
 "Randall S. Becker" <randall.becker@nexbridge.ca>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 16.07.26 um 09:52 schrieb Patrick Steinhardt:
> this patch series reintroduces the writev(3p) wrapper. This wrapper was
> originally introduced as part of Git 2.54 [1], but was ejected due to
> issues on NonStop [2].

Please don't call the function "writev" so that nobody associates it
with the guarantees that only POSIX provides, but none of the
emulations. Call it "write_gather", for example.

Also, clearly document that its only purpose is to reduce sequences of
write() calls to a single function call, but that the additional writev
guarantees are not needed.

A range-diff to the earlier round would have been very helpful.

-- Hannes

