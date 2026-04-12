Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383ED3D994
	for <git@vger.kernel.org>; Sun, 12 Apr 2026 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776024071; cv=none; b=iNuvhvjW5CKSPQ67YAQ4wdfOHASYeM2JiMPknqM0Zz/+8PitJ9wtdkWBokRuY0yrExxtph5NKZ/h0Ahqt709petA1x4hwGdy0OG3lqyn3B69fY9tuU8boyC6Gm37Ap43R/dosDl2vwVf5T/Syb9pDfaP+ZfCMxD3EtXAgmsKp3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776024071; c=relaxed/simple;
	bh=KT/LdaJpia1OtlKETtHd9V7odY264kNwtDZUkiLibUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6Ao5N2BeLLIh//qo12gWbf8as44ghpd1Borzk8BptYduKRvYpiM3VqEPk6znefM4cA0Ga8WxFhocR82G7F1yr5FyofLHSZY0IPm5gix/EVLhGtC/MJ437CmxmSv6K+k1tqYmno17jcJg1nm5EioDlwFvMGbF8O7my5QR7WTeLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ahosdE8Y; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ahosdE8Y"
Received: (qmail 328875 invoked by uid 106); 12 Apr 2026 20:01:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KT/LdaJpia1OtlKETtHd9V7odY264kNwtDZUkiLibUA=; b=ahosdE8YztEQQqZkeThal9MFi/srG9u/FaQb+U8MIgwDOUvb5uRTsX/vGBOLxciTmncKjpO9fJIrhS0Wr/p+x+KamdG7TtBc6GIN7j1PF65rBrlyK7DtMVixb3JykXDygU0/mZZtHnvk4ORidh3fWbQJkhJTLNJsjGDhbE/NtlElnJD7OFWdIyG+NX/2bCfFaDo6YNjxUOF6UOmKN/kzxbkmw1ycohrFEiKAMQxOxKjgZ2CRWxhMU9LYtHU3xyIxe8gINJI4gUmoiPZsFeXZ821eaVGcow0sbU3x4J98y8I/ys/nrKMSxnynC/v7zMyInlju9/jhMuOhnbX+XXiEqA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 12 Apr 2026 20:01:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 544152 invoked by uid 111); 12 Apr 2026 20:01:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 12 Apr 2026 16:01:08 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 12 Apr 2026 16:01:07 -0400
From: Jeff King <peff@peff.net>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Chris Torek <chris.torek@gmail.com>,
	Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v10 0/4] checkout: 'autostash' for branch switching
Message-ID: <20260412200107.GB1691477@coredump.intra.peff.net>
References: <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
 <pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>

On Sun, Apr 12, 2026 at 11:51:41AM +0000, Harald Nordgren via GitGitGadget wrote:

>  4:  00e0b3196c ! 4:  b6e5546d74 checkout: -m (--merge) uses autostash when switching branches
>      @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
>        		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
>       +		if (ret && opts->merge) {
>       +			create_autostash_ref_silent(the_repository,
>      -+						   "CHECKOUT_AUTOSTASH");
>      ++						   "CHECKOUT_AUTOSTASH_HEAD");
> [...]

Thanks, I can confirm that this version is fine with the stricter
ref-syntax checks.

-Peff
