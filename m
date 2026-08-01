Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A372147E6
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785592404; cv=none; b=UKxgxv5jc7bNcHMB9q2qUiUkzbossCiQEvzKOLb0Keo2fSer9bMnZlMwhRVovy/gukj9elgSzyqE6kTJF5OJH0+rcS/GLYbtMWjL/JfhV25kQsvGzsOgoZbRvBUkprjzVwdauzxpQVUq60QTCZY3DPifCx69vNMQuSJu96NRuEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785592404; c=relaxed/simple;
	bh=xLZn3BXJPAWsh8eyKUPwTSvwxY7+Sj9RDpgj6iMG1Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLG4jiIkYkR0YIuQsHpd8iZENl0LWtOMQEIVtzr1uyZT8FxywlhzXMKUBKx+A3+ClTSofgFy7pxNkIJqp1He4j4bDZOICm9AXz/i0cUzaNbOffYhRAJ3XVILEI4jS5UnFo0I/N3Xwq/3x/W/zrW8YMfy6AvLTfva16gl4RvDzt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LCwhv5ZW; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LCwhv5ZW"
Received: (qmail 9524 invoked by uid 106); 1 Aug 2026 13:53:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xLZn3BXJPAWsh8eyKUPwTSvwxY7+Sj9RDpgj6iMG1Dc=; b=LCwhv5ZW9i9MogRvuqavp7Sj2mgZPlQqpuAP9SOrjV+jNlFVdSK6auYDMLwm4D4pQ/uLxntQHgJQWjIwq07mEKBS0ax02UrOpFxp7H9MxnTVFN8KGvX+NTnElNBOLQkn2ddUj/eFMq2RSkusQ6zfLoML2zt8oLhdoZ8UCxnuQ0teZFbjlJeQHWrBpwQda1lifvPA4iHi5lAi7CV3ZqqP1NeggUG6MeEIJ0qRuCvp9jaqwScI4AzTr+7EWNIJpmGaa+9/lqmgb9Irk0BeC5XSkIcBYqbyCnlUWWXbVuZT0AqDEEh4PPBUUJtcQH9cGlQUwUhJXoroaIdzlCpTiqBy0A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Aug 2026 13:53:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17172 invoked by uid 111); 1 Aug 2026 13:53:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Aug 2026 09:53:13 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 1 Aug 2026 09:53:13 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com, ps@pks.im,
	karthik.188@gmail.com, sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: Re: [PATCH v6 2/6] http: avoid closing index-pack input twice
Message-ID: <20260801135313.GA2041176@coredump.intra.peff.net>
References: <cover.1785047139.git.tnyman@openai.com>
 <cover.1785111375.git.tnyman@openai.com>
 <28662b0fd892ecf6246be185ccb2d4654fb780a5.1785111375.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28662b0fd892ecf6246be185ccb2d4654fb780a5.1785111375.git.tnyman@openai.com>

On Sun, Jul 26, 2026 at 05:28:39PM -0700, Ted Nyman wrote:

> finish_http_pack_request() passes its staging-file descriptor to
> index-pack through child_process.in. start_command() takes ownership
> of a supplied descriptor and closes it, even when starting the child
> fails.
> 
> Do not close the descriptor again after run_command() returns.

Thanks for splitting this out.

> @@ -2704,13 +2704,8 @@ int finish_http_pack_request(struct http_pack_request *preq)
>  	else
>  		ip.no_stdout = 1;
>  
> -	if (run_command(&ip)) {
> +	if (run_command(&ip))
>  		ret = -1;
> -		goto cleanup;
> -	}
> -
> -cleanup:
> -	close(tmpfile_fd);

The patch _could_ just be a one-liner dropping this close(). Removing
the cleanup label here is optional, but is a simplification that works
because nobody else jumps to it (which must be true because we'd fail to
compile otherwise).

I probably would have mentioned that in the commit message, but I think
there's diminishing returns in trying to polish further.

-Peff
