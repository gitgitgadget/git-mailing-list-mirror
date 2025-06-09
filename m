Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886ABA3D
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500138; cv=none; b=lJXFPbK1JW7SzEXflVzAJxkIOiqrwV+7+0Y/k9nZ2isBRMIDiJc659NvyXAOXWMjx/eB+m1r7pFhqi2Qahp37I08isXOfZVek5gCTn81COREHPyPnZzLIyAr14prI4x3kFwfWRqJKM3DJ4tJ22bHHH468r7UE39Jm39ES3i+Pk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500138; c=relaxed/simple;
	bh=rxY+KFpIDyRMPhXYTcOMuD6l2VmJEqpGZgWzplF2tqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tnhOADTv/LjGdsjWqJz9N7YK6NrFvrEgSCN55FsvNmh/jqLlH1rDMfQmEOfFEI419ovNcrZsUoGPSEqxxx6M2oyubgNxha+zQNkf5f3sk6BYEykE+vr+bmYFkvdQ/SE5AGOaqS7sbH1T6jBJi5prPxU5VXtQWZoN3TfwQ3+9tAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4bGNT83NkVz1sG88;
	Mon,  9 Jun 2025 22:15:24 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4bGNT832ghz1qqlW;
	Mon,  9 Jun 2025 22:15:24 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id RRk1JrOgU0z1; Mon,  9 Jun 2025 22:15:14 +0200 (CEST)
X-Auth-Info: 67PxxHYEvKn6a6n4ixeAzzOhamd09j/a0NetKOj7kILY1h7pGb5nhbfNdCwvoIoR
Received: from igel.home (aftr-82-135-83-169.dynamic.mnet-online.de [82.135.83.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Mon,  9 Jun 2025 22:15:14 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 493C22C194F; Mon,  9 Jun 2025 22:15:14 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,  M Hickford
 <mirth.hickford@gmail.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: Suggestion: error "tag ... already exists" should distinguish
 between tagging different or same commit:
In-Reply-To: <CAE1pOi34+btHyV8GbjpFPcJ+2ixu59ce4eAE=Q7F4JEcuJyXnw@mail.gmail.com>
	(Hilco Wijbenga's message of "Mon, 9 Jun 2025 12:37:41 -0700")
References: <CAGJzqsnvTnp3k8Ab2exaBAw5pszQRz00UcucnK=ECtY5vhG+1A@mail.gmail.com>
	<xmqqcybcrc2u.fsf@gitster.g>
	<CAE1pOi34+btHyV8GbjpFPcJ+2ixu59ce4eAE=Q7F4JEcuJyXnw@mail.gmail.com>
Date: Mon, 09 Jun 2025 22:15:14 +0200
Message-ID: <87qzzsisdp.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jun 09 2025, Hilco Wijbenga wrote:

> Does it really make sense for that first example to fail, though? "git
> tag hello v1.9.5" is an idempotent operation, isn't it? The second
> attempt is a no-op?

That's not true if an annotated tag is replaced by a lightweight tag.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
