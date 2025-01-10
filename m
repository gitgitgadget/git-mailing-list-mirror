Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95CE20B7FA
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513971; cv=none; b=li9ZknW+RQXy/9AmheC0ecCvA7rUPwT1SJ7toAcwJJt5b9v0tJASxBhD7hfxQULLo8kyNc5cAmC6YIJewtsCLgPfqsdu3kycmvGNLHJZgVfsOebogF4hercy5ELdJwCYmhZDEisiAhRPIlIllOtGEet5XP47Nm+IgtHS/Mdn/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513971; c=relaxed/simple;
	bh=UfA0AyTirWhj4HDxzTrTcH2fnG+3cHI3U9wMBqk+KDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=odSnuM8hi8CurnyG+so3wMkoE+py1U/3rzjeOzydy5EpqTEAUX88TXSFYDzbJyCLNauQUXMVhLA85vC2k9jBgn5xK0R/NDacgIDhHau/iKTi6F8+tFRB4xQuBslpQzkHAhyNx0Qv2IM9+0Z5R7rnkRNceql0xAAgM74NfWXDZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4YV1vC6VhBz1syBc;
	Fri, 10 Jan 2025 13:59:19 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4YV1vC3ywjz1qqlW;
	Fri, 10 Jan 2025 13:59:19 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id YihCMokIyuUk; Fri, 10 Jan 2025 13:59:18 +0100 (CET)
X-Auth-Info: DE65F3ztyeSnAO/jSb5O48ie7R9tc1OUYbqrO5VuSZEx2oXf60JpevGJ6gL3HqED
Received: from igel.home (aftr-82-135-83-139.dynamic.mnet-online.de [82.135.83.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri, 10 Jan 2025 13:59:18 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 94BEB2C1996; Fri, 10 Jan 2025 13:59:18 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Jeff King <peff@peff.net>
Cc: Olly Betts <olly@survex.com>,  Junio C Hamano <gitster@pobox.com>,
  git@vger.kernel.org
Subject: Re: git grep: ^$ false match at end of file
In-Reply-To: <20250110120223.GC1014503@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 10 Jan 2025 07:02:23 -0500")
References: <20250109235255.GA3418@survex.com>
	<20250110114308.GB1014503@coredump.intra.peff.net>
	<20250110120223.GC1014503@coredump.intra.peff.net>
Date: Fri, 10 Jan 2025 13:59:18 +0100
Message-ID: <87r05ahljt.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jan 10 2025, Jeff King wrote:

> but it is weird to me that patmatch() will match "^$" to the end of the
> buffer at all. It is just calling regexec_buf() behind the scenes, so I
> guess this is just a weird special case there, and may even depend on
> the regex implementation.

Shouldn't the matcher be called with REG_NOTEOL in that case?

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
