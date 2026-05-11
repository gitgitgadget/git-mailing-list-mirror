Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0D2F9C37
	for <git@vger.kernel.org>; Mon, 11 May 2026 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530683; cv=none; b=Km20TAIHWXm8hleABLiYT2WEJnlwoRRrbthPBpJYMJaAp1n4R9Yx2uDe0SNMnJTGOrPulN9kwzputc9AKNSsId7uSxqPBoRxQykpzxXdn3aaxar2Ev9zC+9vVaEAHOTUyC3Tall78zVpRW/0wim/A3tBQmn8G2ILRlfwX+O7NUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530683; c=relaxed/simple;
	bh=FyPMWdvpCFFtJ58dxGHyHmgW4lITwiSIa++jblqGjTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOh4mCeSMz5670dgS1r7lvUU7lV2Qatgma6eCOSawt2Gs+nBD5NsbLzDnjps2hGRRANr4CgUnHa4KMP7IhjcZnc6APXvbbExsjDB36AsjsAMJgfh7ujS1gAQLiz8rKPfbAJibIhIKcwCfs+kiLisUUJsAWLnidoE3/alSVF1O+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KAnuh+RZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KAnuh+RZ"
Received: (qmail 19405 invoked by uid 106); 11 May 2026 20:18:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FyPMWdvpCFFtJ58dxGHyHmgW4lITwiSIa++jblqGjTY=; b=KAnuh+RZnWJn1GavDJA24DbzVImTJ9KZsOqc4Nb4RwnUl6PKmgJvveNMPbSi/vVA+kg6NY2eDF2lJu5bgEt/jVNe3lr6tPSizKXe8SECLcOm46UnEWSo+aRXjVI8BHPdEAYOjt8YDIFj3PM8QjDL1guE7v1Fqus8uDx7gViZHLD7MlG4PnvhRtxngQGAtNgP0zl9Eot+TmxkjMIiWG/dGBNma2387Zd0DNkZuKdq/L8gEc3MkbzZdQgDNPJ3odXEezgnesfGaZJfZ2KQ0s4Yh+cdGI1rVJA0mfC7wB5sbXF/KLqNBF4I7jaAuFrICPcsKT5mef7OSFi99WpjmlfAdw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 May 2026 20:18:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34382 invoked by uid 111); 11 May 2026 20:18:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 May 2026 16:18:00 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 11 May 2026 16:18:00 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jean-Christophe Manciot <actionmystique@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] run-command: honor "gc.auto" for auto-maintenance
Message-ID: <20260511201800.GC22912@coredump.intra.peff.net>
References: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
 <20260511-pks-maintenance-fix-lock-with-detach-v1-2-ccd7d62c9a40@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511-pks-maintenance-fix-lock-with-detach-v1-2-ccd7d62c9a40@pks.im>

On Mon, May 11, 2026 at 02:29:56PM +0200, Patrick Steinhardt wrote:

> @@ -1946,8 +1946,10 @@ int prepare_auto_maintenance(struct repository *r, int quiet,
>  {
>  	int enabled, auto_detach;
>  
> -	if (!repo_config_get_bool(r, "maintenance.auto", &enabled) &&
> -	    !enabled)
> +	if (repo_config_get_bool(r, "maintenance.auto", &enabled) &&
> +	    repo_config_get_bool(r, "gc.auto", &enabled))
> +		enabled = 1;
> +	if (!enabled)
>  		return 0;

gc.auto isn't a bool; it's the count of loose objects after which to run
maintenance. So "0" works in both contexts, but will we complain if
gc.auto is set to 100? I think maybe not, because we fall back to
git_parse_int(), but it feels kind of fragile.

The gc code uses repo_config_get_int() here.

-Peff
