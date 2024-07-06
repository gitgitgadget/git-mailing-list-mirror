Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31B179BD
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720246194; cv=none; b=DF1xvsh2vtQ+kNBCPMiD/BM9Xg54OuS/yXVW02ioGC2K1oXt04T9IjCFwAYVYhQx9enMgVkMEaWd0HBpLIZhaGjQfhYCmbFnzcXx76FLhWaHzliJ9PKD96F712Ldl1cTRvonkpt5M6QGyxR3K5s/LtZ5i7FbP7JRQDCGz1nNrQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720246194; c=relaxed/simple;
	bh=1u2G6QGJJAmE3Iq3WCPecekur51CbswU8B0Hnx9IbQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMFsc3LUjDPxScwcNc/bRJ3FK9xScCyAhRmDc4w0RupOAA8vh5uY0fff4os2oM7L/vx/J8yRrzxq4kxJNbwn7E/q8yO9YwdbfrbisVIccBgle21sDdQ83dJSAg8rn24HJiAly7dCBbxzacx9Eoy1ghp6g0kqksWsk/y/qfiNoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23419 invoked by uid 109); 6 Jul 2024 06:09:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 06:09:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31192 invoked by uid 111); 6 Jul 2024 06:09:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 02:09:49 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 02:09:51 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] t/chainlint: add test_expect_success call to test
 snippets
Message-ID: <20240706060951.GA700433@coredump.intra.peff.net>
References: <20240706060143.GD698153@coredump.intra.peff.net>
 <20240706060639.GB700151@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240706060639.GB700151@coredump.intra.peff.net>

On Sat, Jul 06, 2024 at 02:06:39AM -0400, Jeff King wrote:

> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -109,9 +109,7 @@ clean-chainlint:
>  check-chainlint:
>  	@mkdir -p '$(CHAINLINTTMP_SQ)' && \
>  	for i in $(CHAINLINTTESTS); do \
> -		echo "test_expect_success '$$i' '" && \
> -		sed -e '/^# LINT: /d' chainlint/$$i.test && \
> -		echo "'"; \
> +		sed -e '/^# LINT: /d' chainlint/$$i.test; \
>  	done >'$(CHAINLINTTMP_SQ)'/tests && \
>  	{ \
>  		echo "# chainlint: $(CHAINLINTTMP_SQ)/tests" && \

BTW, not new in my patch, but I found it ironic that the shell snippet
here itself violates &&-chain rules. It should "|| exit 1" inside the
loop if a sed call fails.

-Peff
