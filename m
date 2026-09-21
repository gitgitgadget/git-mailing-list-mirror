Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830532B12C
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789963625; cv=none; b=vAi0rm7Ecu4NeHsMVs6/gicVwuA4/YZYSiaYrK2hyNh2JQ05qfPXQ3RNy8bUlgTAOZy1kNf2jJzlRGxHldEsOoSiYxKLiBatKu37zm9+ADUaOqpKuNoB3dTlRlj2jk04k/oP8IO+SIaXuSejGccjSRMwYN7zDICMsu60bUrA7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789963625; c=relaxed/simple;
	bh=hOJN7+2NQgGuVRLbA4n0CQRChtfocemFRzOFvTdmLhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2SiCiR1dkOTxNasG0bX7tWt4IuPh+642RkG7CguPYZ2Es7c3jMqJMtOLJkzmmVDiqtQ8cYcYRpGWTSfSyvNlv1600Wh00G2Dub2tmbMtjLh9NjX6FF8FHMFUtmAp3o98SkaatHgThH7S15myxmrLc9OIguuGOZTuL6TpQcgUfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4hp8n90wPHzRnlL;
	Mon, 21 Sep 2026 06:06:53 +0200 (CEST)
Message-ID: <9c1cde3d-92c4-4684-834e-bae97fd33f5f@kdbg.org>
Date: Mon, 21 Sep 2026 06:06:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] compat/winansi: fix die_lasterr() argument formatting
To: Yongqiang Tian <yqtian668@gmail.com>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Patrick Steinhardt <ps@pks.im>,
 Johannes Schindelin <johannes.schindelin@gmx.de>, git@vger.kernel.org
References: <20260916042312.35891-1-yqtian668@gmail.com>
 <bf0351d8-05fe-4f77-958a-2ac59495029c@web.de>
 <1e706ce8-bebd-4ac1-914a-a55195e7d253@kdbg.org>
 <CAEs0Zp4LK1ZHkL0tdi_k_=-u86HVm07FzyOJdO-=+DY9c3ZrYA@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAEs0Zp4LK1ZHkL0tdi_k_=-u86HVm07FzyOJdO-=+DY9c3ZrYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 21.09.26 um 05:00 schrieb Yongqiang Tian:
> 3. Remove die_lasterr() and report GetLastError() directly at those
>    call sites. This avoids the va_list forwarding, allocation, and
>    errno conversion altogether.
> 
> The third direction now seems the simplest to me. It also follows
> existing Windows-specific code in Git that reports GetLastError()
> directly, for example:
> 
> https://github.com/git/git/blob/9a0c4701dcd5725c4184599322b52933ff5005ca/compat/win32/syslog.c#L10-L13
> 
> and:
> 
> https://github.com/git/git/blob/9a0c4701dcd5725c4184599322b52933ff5005ca/compat/fsmonitor/fsm-listen-win32.c#L106-L109

Sounds reasonable to me.

> -               die_lasterr("DuplicateHandle(%li) failed",
> -                       (long) (intptr_t) hnd);
> +               die("DuplicateHandle(%p) failed: Windows error %lu",
> +                   (void *)hnd, GetLastError());
But please leave the conversion to %p for another time.

Concerning the text "Windows error", please follow existing practice.

-- Hannes

