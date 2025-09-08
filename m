Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0361E500C
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358421; cv=none; b=cCEyL5UaFvcffvCTnqXVcT17bZvUcvpktKfo4aKsMyq9pDQEmPYV8TYVlcdCJKJbXnterqg4y3ccLA2eYCZ1H8228wiOjjn6XMgz7ZRtGDO5F/5qjK/mU000PZMOn//vR0hEovOuK+1s31rzRMDFULcvZUX/L5nF6giiMkSIprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358421; c=relaxed/simple;
	bh=JRdOKD5oGFpQkdNM8kZldB47PzsGkCtXujebir2jkdE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MKCArbZutKDTDv2AcFuliynOULxvvHFj27+sA0VdpaZeQeU8oCMOMnt6g4Kmb18UQ759ZrR6OXvZAc4ntOqnKNUJieVZOeURSSLQ4/j4rQGjWDcQA2ft0oH5UyO4gncFjRFlAenAzxvXlp3c/YQLO5UN88vsKU5fcXYwN/UbE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=FkIblyNq; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="FkIblyNq"
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7098040748C7;
	Mon,  8 Sep 2025 19:06:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7098040748C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1757358416;
	bh=mCRUdQv+I4T0KglIrAdMb/3RJgpHFTAQbQhdee6TliM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=FkIblyNqgQ2t0jN3LwIknLilNKLVnynXGlxixYZGQZveK3ROoeZ0ROu2fw6TDdWhC
	 PUJW2LTwfhkOl2UVRBpk60ZhTU26GkRkhTEDClYAZHDYxOKGw/fXcGDDSQtCBnDrzb
	 YojpeETux0WK9f1mB2fOpEcYOSKH6RiEVokNXI6w=
Date: Mon, 8 Sep 2025 22:06:56 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Junio C Hamano <gitster@pobox.com>
cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] xdiff: optimize xdl_hash_record_verbatim
In-Reply-To: <xmqq7byx8yo3.fsf@gitster.g>
Message-ID: <abb2bc1a-e68b-85a3-2562-53328fb502c6@ispras.ru>
References: <20250728190520.10962-1-amonakov@ispras.ru> <20250728190520.10962-3-amonakov@ispras.ru> <aedb1be1-3151-421e-94ce-27bc77d80b83@gmail.com> <353c7865-d9b5-2a1c-4d71-cd1136581f01@ispras.ru> <5cf47722-7073-4761-8698-090af840d0c4@gmail.com>
 <c2fe3b69-8436-af46-c47d-dde5bb037227@ispras.ru> <0379ba2d-837b-761e-9d5a-d65ca9d051d6@ispras.ru> <xmqq7byx8yo3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Wed, 20 Aug 2025, Junio C Hamano wrote:

> The thread has gone quiet.  I assume everybody is happy with the
> result?  Can we have a hopefully final v2 iteration of these
> patches, to address the updated to the table (this thread), to
> squelch the __asm__() issue [*asm*], and a reword you mentioned
> [*reword*] against Phillip's review?

I was expecting that Phillip would come back to the question of underwhelming
performance improvement he was seeing on his CPU. I was working on an
alternative approach to speed up that function, which I just sent in the v2
thread: https://lore.kernel.org/git/20250908184939.16338-4-amonakov@ispras.ru/
It does not depend on the performance of integer multiplication anymore,
so it should work better from architecture neutrality point of view.

I'm not sure what's the current status though, it seems nobody gave the original
two patches a Reviewed-by?

If the proposed changes in v2 are too sudden, what happens now?

Thanks.
Alexander
