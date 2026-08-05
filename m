Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A313D4118
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785960066; cv=none; b=Z8vSN3+TAlvBmEwO9xPnJgdIYYlFvCJWIRxPcIxNvm6Nq+oTjcq4PeQc/LD1q5kmFj+drdTkaCV/B8MY6ZDVqAbszrjPxQzdRO7i8CGTMHw+FSZxzYc79IiaGlRwJWoCL/R0Uw/IZa3gT38tx5gIvjJeSIXoBvTgwiUVSZKm6OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785960066; c=relaxed/simple;
	bh=p6pPKY+bX6AdMP4zC7AR/J+wy5YzEPvuN5VkUCSmABg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgOfUNvMsoZBrTrvfTRprERqrmzYTNFpT5U/1yWUUhYxKwPLbYSBsmuvamKdzKy3m3xGOOyap6GtEqmYDmL2BjVHGg7ilCE0w7JvKhsFdED25j+EdBOS0+J+YJqh7azUPeukPdWhlZ4EdOljF0HiJkiwQTsTy2duWiCSXme51Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (unknown [89.144.223.124])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4hFh9c4tkSzRpWV;
	Wed,  5 Aug 2026 22:00:52 +0200 (CEST)
Message-ID: <8ff3c3ea-2604-4d65-8a7d-6acd6218b7c2@kdbg.org>
Date: Wed, 5 Aug 2026 22:00:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Reintroduce writev(3p)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>,
 Jeff King <peff@peff.net>, "brian m. carlson"
 <sandals@crustytoothpaste.net>,
 "Randall S. Becker" <randall.becker@nexbridge.ca>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
 <f8050598-392f-44c9-8d66-0454740a7a12@kdbg.org> <xmqqo6fso2s8.fsf@gitster.g>
 <anL0nIk6uzkYR9Oc@pks.im> <xmqqy0ekr0bm.fsf@gitster.g>
 <2952d9a7-c7c0-44c0-a321-7ddad6497a6e@kdbg.org> <xmqqpkzwpg1g.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqpkzwpg1g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 05.08.26 um 20:40 schrieb Junio C Hamano:
> I think it is OK to explicitly document that any writev(2) emulation
> is allowed to be non-atomic, and it is also OK to declare that using
> writev(2) in this application to allow competing writes to the same
> destination is a bug.

These are fine.

But I'm not worried about current uses of writev, I'm worried about
future uses: "Look, we already use writev elsewhere. Let's use it here,
too, where we can take adavantage of the atomicity of the write." It's
too easy to miss a note about non-atomic emulations when the function
name advertises more than can be guaranteed. For this reason, I strongly
suggest to use a different name.

-- Hannes

