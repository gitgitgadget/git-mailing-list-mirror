Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5EC4A13B5
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522740; cv=none; b=g7o0JtGMZXd2injEKxVjbICLivdEkHsQpM5IMVoSt61q5/4U9Ycsc2ORgKMl0RHKh+K2XG5F0TCvDg09Z6t+3jw9IUBzTZ5Mp1EyRmC9CNuTciX5pZxrQYvlOw4SzmyRN1aPRQEL6coWDyhz8IhJOcUbo4+8v4ThIJnhkZipSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522740; c=relaxed/simple;
	bh=zq2ehSLCg/Le/sAaXatpfvfJqhA5lCQueM7i1p2Xs10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuIuBovXhFVu6pbMu0wUUW7UYSw5yyCbiIWPCpzBceaH2GWikIxznk6Y2iIyTEsP1FxlO4dcVrvv5RpeKgTRjdebJxEzubnan+RhB4uBeWTc7KpfsTyDWZFEMZu/6Fd3pVfygEfPJ7ltxB1dmeRva7G2YUOj3dvvjZ3Q4uCrTMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gW1Kh0RlCzRnCp;
	Wed,  3 Jun 2026 23:38:47 +0200 (CEST)
Message-ID: <5c0a5305-00c5-403f-a007-f5f3c163f8d1@kdbg.org>
Date: Wed, 3 Jun 2026 23:38:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] git-gui: silence install recipes under "make -s"
Content-Language: en-US
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2318.git.git.1780477489662.gitgitgadget@gmail.com>
 <pull.2318.v2.git.git.1780510415838.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2318.v2.git.git.1780510415838.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 03.06.26 um 20:13 schrieb Harald Nordgren via GitGitGadget:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Several install and uninstall recipes embed "echo" calls that fire as
> part of the recipe itself, so the install banners (DEST, INSTALL,
> LINK, REMOVE) were visible whenever the variables expand non-empty.
> 
> Guard the whole "ifndef V" block on "-s" so the loud variants are
> selected only when "-s" is absent and V=1 is unset.
> 
> Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>
> ---
>     git-gui: silence install recipes under "make -s"
>     
>      * Clarified commit message.

I appreciate that you made it more suitable to be used outside of the
Git repository, but it still does not explain why the change from ifeq
to ifneq is not sufficient to negate the condition.

In fact, the old version of the condition never worked as intended. The
parameters of findstring are in the order needle,haystack. The arguments
are -,s for normal `make` and -s,s for `make -s`. In no case is the
needle found in the haystack. The new version is correct. This is worth
to be mentioned.

> +ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),s)

> -ifeq ($(findstring $(firstword -$(MAKEFLAGS)),s),s)
-- Hannes

