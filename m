Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35A182B9
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721165475; cv=none; b=TweozKX+ZXt7Aro077xOFGvfGY287BRsof80e27O2p6stGXDUlsAJ1UG0SYu5vOhIwZogE7hv0A2rAjeJQO5pKvXTyHqFsPFzCDSVk8jTpMFPPP5R8WldnUVQ23BGvxLf+XeH25Rzn9PUP/LtdMssJk/kbbDRdEHmdoZfHG8Um8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721165475; c=relaxed/simple;
	bh=4KZKalGbKRO7f9id8AnhlXMEDJV4nXntbxBM4/tfKWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SC6iHvrE6ZYhdFIaQ/bQRIAhJA5b7qMxfrPDTgltr/CMHWhfDpD6Z8rtvPNYN6YI5LkLjPh6eUqvTibz+LF0nIXTTwehrYQNNua8/msUF+UXm992+HEfp+93shdLD6CpHm6iNm5kBPO9TxxHyASK0Ql1fzF9YMy+9dummL+bECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4WNsgm15Syz1sBpn;
	Tue, 16 Jul 2024 23:31:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4WNsgm0Mmqz1qqlW;
	Tue, 16 Jul 2024 23:31:00 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 88qqxQX1WL8c; Tue, 16 Jul 2024 23:30:59 +0200 (CEST)
X-Auth-Info: zpPIm2dTXa98UezG2ivEIZwfvsqoJidSgkwSG1UncQradQg4ZmkRkutCKHMmHdry
Received: from igel.home (aftr-82-135-83-7.dynamic.mnet-online.de [82.135.83.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue, 16 Jul 2024 23:30:59 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 27BC22C21B4; Tue, 16 Jul 2024 23:30:59 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,  Scott Moser
 <scott.moser@chainguard.dev>,  git@vger.kernel.org
Subject: Re: Can dependency on /bin/sh be removed?
In-Reply-To: <20240716192307.GA12536@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 16 Jul 2024 15:23:07 -0400")
References: <CADaTQqDZ_6wORXOFc2CE90aizgHJ116NDHZhNeY4Nx7NH8DHJw@mail.gmail.com>
	<xmqq8qy21k9f.fsf@gitster.g>
	<20240715235212.GA628996@coredump.intra.peff.net>
	<20240716192307.GA12536@coredump.intra.peff.net>
X-Yow: Yow!  Is this sexual intercourse yet??  Is it, huh, is it??
Date: Tue, 16 Jul 2024 23:30:59 +0200
Message-ID: <87jzhlf2i4.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jul 16 2024, Jeff King wrote:

> Again, it's possible that we could detect that no shell metacharacters
> are in play and do the word-splitting ourselves. But at that point I
> think it should go into run-command's prepare_shell_cmd().

This is what GNU make does (see construct_command_argv_internal), for
performance reason.  But run_command is probably not performance
critical.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
