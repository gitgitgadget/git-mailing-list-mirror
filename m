Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B127643D508
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491544; cv=none; b=uLXq0hitBqywRZy3EOVprQFLLL0hmyHvDHRxc+k0No3LrXabFTTnjqlIaKZ8D56xiyjs5Ed+flhmbm/7ysqYC07OdXivFXXHiOYKRO7PlREID2lojT1Tsp6DFJ1yx9FgbkyKCwYaPFiUGjMBo2V5FYQHevqPugONJHbj/bEdryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491544; c=relaxed/simple;
	bh=fHK4eH3pUgQTcyQLg5Uk9HRB1gLr9lMYcUZYufYT/KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEn+Irzyea78VaUEDIAyrmaUSN0RIEfZDllZcaLvE7K/q7XssNbLxw/EYKTcLlXPHHsU6KPKuXSrOonpnWkMXppdbleGzjeId1WyAGbmwCYVNc1FmFszy6jsWx3WvcbiJSjEUIjHdqzxiwaQF5x/LVxXw3WTQuksOD3wV1DQrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gVnnv15FVzRnlX;
	Wed,  3 Jun 2026 14:58:59 +0200 (CEST)
Message-ID: <010c001d-e241-475d-99ba-f60f71d3365f@kdbg.org>
Date: Wed, 3 Jun 2026 14:58:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-gui: silence install recipes under "make -s"
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2318.git.git.1780477489662.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2318.git.git.1780477489662.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 03.06.26 um 11:04 schrieb Harald Nordgren via GitGitGadget:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> The split install/uninstall recipes embed "echo" calls that fire
> even under "make -s", so install still prints "DEST /path" and
> "INSTALL 644 about.tcl" banners. The existing "-s" block only
> clears QUIET_GEN.

Good catch.

> Wrap the whole "ifndef V" block in the canonical "-s" guard from
> shared.mak, and drop the now-redundant narrow block.

Can we please mention shared.mak in a way that doesn't assume that this
patch was made in the Git repository?

> +ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),s)
>  ifndef V
>  	QUIET          = @
>  	QUIET_GEN      = $(QUIET)echo '   ' GEN '$@' &&
> @@ -89,6 +90,7 @@ ifndef V
>  	REMOVE_F0 = dst=
>  	REMOVE_F1 = && echo '   ' REMOVE `basename "$$dst"` && $(RM_RF) "$$dst"
>  endif
> +endif

> -ifeq ($(findstring $(firstword -$(MAKEFLAGS)),s),s)

I would have expected that the old and the new condition expressions
only differ in the ifeq vs. ifneq, but they are different in more than
that. Assuming that the new expression is correct, was the old one
incorrect?

> -QUIET_GEN =
> -endif
-- Hannes

