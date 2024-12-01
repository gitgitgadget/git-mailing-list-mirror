Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869F1863E
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733090835; cv=none; b=qNN0uxmYHU80PsLqrqHW4tvCcwXiFe7KKwq3zO8iG0hAoaTs5/1G5Ec4TX/aKVcs27kxaCjXn+c/edzJReH1Mm9r52QupMf/9IrMKnLTAsKL1uo8XFdGKmSOjHgBANZFHk7rm8d1TG36AyEWutMJ6c9fyEtT9g9L57ndyHrmQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733090835; c=relaxed/simple;
	bh=kAR1C5NnV/tO+LqXetki5mr6vYXYrMEmnaycgVY4650=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3F5TZmVmZygGwpjMoB+0vmLvBP1oIpNw6pZy0wlzV0EGMiNNWbdxxgMgIeqQo2IaC2icztDt31i/p4F2IkeMfbMwxIoK87YUhlYBa+D9RC/ck4OtMrpGl51vgSZhAqmfZi3jV6VU4gdmGyTuedMv0VGj4k4cZ6vsy7j0Jq1rTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VoatQNE9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VoatQNE9"
Received: (qmail 3889 invoked by uid 109); 1 Dec 2024 22:07:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kAR1C5NnV/tO+LqXetki5mr6vYXYrMEmnaycgVY4650=; b=VoatQNE9NoP6GWPuBqRbkPfYa7XftltywMVl3GcGwWUvIl39RI1CQ+kZvewF8q0w9haSMhNNZLmXzDW1aMvTWYb0DjB3kfCiTwlRDqlY2Ya05aYsYuILF9SXMW9Kp9OtDmTCxv0Yyip8XL7xpESkaJXgY/J8f7SVyQC+8iov8vV1zAcY65dA0TZ6hPkqPNneY+MP0QuU6B7myGQUmGYmxVWC+oI6L+OBKPoBLRgccBBl/YCHhcL4hx1z9lotiOM7DpqHE3yfiQTI15kftMgVGAqyWNncPdUO1MWogVVfeC0rXYoGpb9f27fitSxt63/baWS5LhPNGF5pOMQt246Sfw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 01 Dec 2024 22:07:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14444 invoked by uid 111); 1 Dec 2024 22:07:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 01 Dec 2024 17:07:12 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 1 Dec 2024 17:07:12 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/10] global: trivial conversions to fix
 `-Wsign-compare` warnings
Message-ID: <20241201220712.GE145938@coredump.intra.peff.net>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <20241129-pks-sign-compare-v1-8-fc406b984bc9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241129-pks-sign-compare-v1-8-fc406b984bc9@pks.im>

On Fri, Nov 29, 2024 at 02:13:29PM +0100, Patrick Steinhardt wrote:

> We have a bunch of loops all over the place which iterate through a
> signed integer with an unsigned index, which generates warnings. Address

I had trouble parsing this first sentence. Did you mean "max" or "bound"
instead of "index"? I'd have also thought that "with" is the iteration
variable, not the boundary. So:

  ...which iterate up to an unsigned boundary using a signed index (and
  thus comparing the signed and unsigned values in the loop condition).

or something?

> @@ -195,9 +192,7 @@ int git_default_advice_config(const char *var, const char *value)
>  
>  void list_config_advices(struct string_list *list, const char *prefix)
>  {
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(advice_setting); i++)
> +	for (size_t i = 0; i < ARRAY_SIZE(advice_setting); i++)
>  		list_config_item(list, prefix, advice_setting[i].key);
>  }
>  

I didn't exhaustively stare at each one, but skimmed through and they
all look like obvious improvements, like this.

I do note that you tend to move the declaration of the variable to scope
it to the loop. I think that's OK (and in general is a good practice),
but two thoughts:

  1. Are we all-in on C99 loop scoping like this? I wasn't sure if we
     were still in the weather-balloon period (but I admit I have not
     paid close attention, so this is really just double-checking).

  2. The compiler should mostly catch any cases where this is not
     correct to do (because any references to the variable outside the
     loop would now be errors). The exception is if "i" here were
     shadowing another variable. That seems pretty unlikely, though.

-Peff
