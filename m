Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5111519B4
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046811; cv=none; b=gqvLkOO8P19HJizy0ha2/BtOm/w8VpeXxj5m1yyuUAErWj9KIq6c+D000rqb5UkmwBxKHQIN1Ckq2bexlOdax+Nb3XEQF+hWBLzmxfYEmyKf2pU7Ti9efriKuceCXkq4pySRiBMRCImgLd54hwqgK4puuPEXHH/SJ5fB5WZ8bpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046811; c=relaxed/simple;
	bh=1HeYCBh89w/lPtKtChuIKwfrmA7bWfUeRhL1qyH9n1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0X/KsQVqLv91D3QP7wYBBIyT99LpYrpEteJyTrRrJ+pVTFN1cZ1EENRDF41TnjQPd0IUWUXtlZl5hF+nb9rXA6c/wf9sbsMDkBmm9Q4pys19uQSNlRdTf4fHwKIIhhimblbm4U2jeBas1JftvNUrHSm2C998h4MQoMZL7u1S5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gjryt2BM9zRnlX;
	Sun, 21 Jun 2026 15:00:06 +0200 (CEST)
Message-ID: <98718401-9ff4-4b1a-97c7-71f8b6639fea@kdbg.org>
Date: Sun, 21 Jun 2026 15:00:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gitk, git-gui: drop msgfmt --statistics output
Content-Language: en-US
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
 <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 21.06.26 um 00:46 schrieb Harald Nordgren via GitGitGadget:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> The catalog rules ran msgfmt with --statistics, whose output went to
> stderr and so survived "make -s" (gitk also echoed "Generating
> catalog").
> 
> The statistics are not needed, as in 2f12b31b746c (Makefile: don't
> invoke msgfmt with --statistics, 2021-12-17), and the "Generating
> catalog" line is not needed either. Remove them so a quiet build stays
> quiet.
> diff --git a/gitk-git/Makefile b/gitk-git/Makefile
> index 41116d8a14..0ae083c1ca 100644
> --- a/gitk-git/Makefile
> +++ b/gitk-git/Makefile
> @@ -75,8 +75,7 @@ update-po:: $(PO_TEMPLATE)
>  	echo; \
>  	echo "	git config filter.gettext-no-location.clean \"msgcat --no-location -\""
>  $(ALL_MSGFILES): %.msg : %.po
> -	@echo Generating catalog $@
> -	$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
> +	$(MSGFMT) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
>  
>  .PHONY: all install uninstall clean update-po
>  .PHONY: FORCE
This Gitk part doesn't make the build silent, yet. It misses the "if -s
is in the flags" bracket.

It do not mind doing both (removing --statistics and make it silent) in
a single patch.

BTW, please write commit message in the usual style, in particular,
describe the status quo in present tense, not past tense.

Please bear in mind that Git, Gitk and Git GUI are tracked in different
repositories. Do not put changes to multiple of these into a single
commit/patch.

-- Hannes

