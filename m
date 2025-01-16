Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C0D19539F
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023783; cv=none; b=O6dn9/1Mf/1RHHUBqPc8G9RKtYXkakD/6DC/Rzu4CfxjPLj+iRp5lCwfuQ1/McLDIkmsmNLru3ZvsTMsBPdqL05tp9aWK5jAYuyKmXBHkJStfXS+g3hiBspjl1uW4rv5lxm8Zo2pg0FdJzIyjeKj7TZujMJTAIHHwiSEgDeetag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023783; c=relaxed/simple;
	bh=xQ5cO86AjqIofmu9h3CgBr6qlfK7lPdMzxno5ppLXgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlM2sEcGL7t/LlStjgd9RCWrJ8bYoSxenCZsqkYxPXuJCB/wFuk6bgg9HcSY+IZBRXTmZFuO/ojcQpstqFPLIARLKVfGya+He8/IUCwFlvCaoX7hp7ICEshnwJAsMUn8MEKDb8mP8805TJzqLLpbdZVMIcVEDa6fmo36X3sRHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y0d1sXzx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y0d1sXzx"
Received: (qmail 12316 invoked by uid 109); 16 Jan 2025 10:36:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xQ5cO86AjqIofmu9h3CgBr6qlfK7lPdMzxno5ppLXgk=; b=Y0d1sXzxZy+HA7WcKUQuxLWQSPtwP0HPdzhbZmXin2hTbWuWZeQ+U3okGgzvuJ9z/yFv+8q8sf5SCySpWvN2lCXl4RnThYmJ28r3l2rMSDjf/tzIxWh66nNLFRDP/Zz1CXJlO9wsJgBS8aW/XhoSEW4KSky+de3EssvMrMUiA6VM9S7UtDMrVCplhdRDbBL/qFP+mVxjGcvLStV1IvrKy6cjKRr0m0G+c9RMzqWh7yroDhzKlZVGSOkGQulxZhKBgCLBPl5JOrd9HrCxC36IdQdp84N4OaSj1q94pKA7HmMj/NKMbg4eAcxy3tf0QsXEK2rLxPxSn0kK80kLiHVDvw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jan 2025 10:36:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24105 invoked by uid 111); 16 Jan 2025 10:36:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2025 05:36:25 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jan 2025 05:36:20 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] usage: add show_usage_and_exit_if_asked()
Message-ID: <20250116103620.GB773990@coredump.intra.peff.net>
References: <20250116012524.1557441-1-gitster@pobox.com>
 <20250116012524.1557441-5-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116012524.1557441-5-gitster@pobox.com>

On Wed, Jan 15, 2025 at 05:25:21PM -0800, Junio C Hamano wrote:

> Introduce a helper function that captures the common pattern
> 
> 	if (argc == 2 && !strcmp(argv[1], "-h"))
> 		usage(usage);
> 
> and replaces it with
> 
> 	show_usage_and_exit_if_asked(argc, argv, usage);
> 
> to help correct these code paths.

I found the name hard to distinguish from the earlier helper,
show_usage_help_and_exit_if_asked(). The difference is that one takes
only a usage string, and the other takes the usage string along with
options. Maybe the other should be:

  show_usage_and_exit_if_asked_with_options();

? It just keeps getting longer and longer...

I think the "and_exit" could probably be implied, since showing the
usage is always a final thing (just like in usage() and
usage_with_options()). So:

  show_usage_if_asked();
  show_usage_with_options_if_asked();

? I dunno. We are in deep bikeshed territory. I otherwise like what the
patch is doing. ;)

> -static void vreportf(const char *prefix, const char *err, va_list params)
> +static void vfdreportf(int fd, const char *prefix, const char *err, va_list params)
>  {
>  	char msg[4096];
>  	char *p, *pend = msg + sizeof(msg);
> @@ -32,8 +32,14 @@ static void vreportf(const char *prefix, const char *err, va_list params)
>  	}
>  
>  	*(p++) = '\n'; /* we no longer need a NUL */
> -	fflush(stderr);
> -	write_in_full(2, msg, p - msg);
> +	if (fd == 2)
> +		fflush(stderr);
> +	write_in_full(fd, msg, p - msg);
> +}

Gross. :) I think the existing code is conceptually:

  write_in_full(fileno(stderr), msg, p - msg);

In which case vfreportf() could just take a FILE*, flush it and then
write.

My main motivation is being less ugly, but I think it would also
potentially prevent a bug. If there was unflushed data in stdout as we
go into vdreportf(), then we'd get an out of order write. That's why the
fflush() is there in the first place (it's of course weird that we are
using write() in the first place, but IIRC it's for avoiding sheared
writes of error messages).

-Peff
