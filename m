Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D033FBB4D
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542614; cv=none; b=uUkoHlNyefo8xTI6VOnkea1mPu4rVIH09Ka5LF8Jza4IzRgehQ+wuU8HEd5TTNwl6buDAMLJKxP4pxiMcNF9GuCL41AP2CG1GugxQLo1D8olEZyv/EFU46O9mDoLHrxE2HXwkOzkLPhVji+uY/oxrhg/Hpww/Y9q5jkX3VVHRxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542614; c=relaxed/simple;
	bh=gg/Ft/v+89aC5YJi7Vnq+8agxkW6PHU7UHZV/G3kMf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSMsCrFrUYQ6q3SRNArzwuEQHtXCckjMSZaHAr1FbOJ6APPca2Xj7aOkqtAGULSYAmrQRzNFoYDRMjAqbJHsj6H7xf7JlAulkzNwaEpOGBlqQxZSU7pn/Z8GFeb9pDyk3WaZapV+n0Sw86q2irAiIBwu5LD993rgsPopC2IBaWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4hl94n05Fkz7RQvR
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 09:10:00 +0200 (CEST)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4hl94b4cTSzRnlV;
	Wed, 16 Sep 2026 09:09:51 +0200 (CEST)
Message-ID: <1e706ce8-bebd-4ac1-914a-a55195e7d253@kdbg.org>
Date: Wed, 16 Sep 2026 09:09:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] compat/winansi: fix die_lasterr() argument formatting
Content-Language: en-US
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Yongqiang Tian <yqtian668@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
 Johannes Schindelin <johannes.schindelin@gmx.de>, git@vger.kernel.org
References: <20260916042312.35891-1-yqtian668@gmail.com>
 <bf0351d8-05fe-4f77-958a-2ac59495029c@web.de>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <bf0351d8-05fe-4f77-958a-2ac59495029c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 16.09.26 um 08:33 schrieb René Scharfe:
> That all makes sense, but is quite complicated.  die_errno() itself uses
> a fixed-size buffer to avoid heap allocation, for robustness and to
> avoid changing errno.  How about turning die_lasterr() into a macro for
> the same reasons?
> 
> 	#define die_lasterr(...) do { \
> 		errno = err_win_to_posix(GetLastError()); \
> 		die_errno(__VA_ARGS__); \
> 	} while (0)

die_lasterr is used to diagnose errors of Windows functions. I dislike
that this degrades the exact error value of GetLastError() into an
errno. If this direction is persued, then we should remove die_errno
from the picture.

But as I hinted elsewhere in the thread, this is all overengineered for
no good reason.

-- Hannes

