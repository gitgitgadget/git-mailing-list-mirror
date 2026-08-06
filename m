Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0A447CC97
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030868; cv=none; b=LXCloVR3JTuapMFFhlloArHfCi1SRzKeV0Otx3hFqOjRAYK/Zpy86cgkIyf4P8pswos2Al73uiRlX/HEpE6Ms2urnJAvu3smVsgrEE96Gfl8WkEG9oqCeKObuQb1uXGUyj+h6jkt4IhGQ6oB3LGKmFXwomcjE37kWYxdC9K7xc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030868; c=relaxed/simple;
	bh=6sF5B4GWXsqkrm7UtELydMqr/bXv8iH6om0xNh03U6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKjJxb37DToaZ6KiKMJ1ImwrrAeN9ZN6PCTLwiSi+VUW+WQy8oNjGTrm8Z6wl52N8vIB9PwYl+Gq4yRM4j+29U5NK9TRFt3c1my8YW765P4gwTQrX4ICTqD+YLgb6AiVKukGtHZRWSqGPVNWoH+v07KOtiWVwgRnbvrlnMhqYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HizLWB8Z; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HizLWB8Z"
Received: (qmail 61420 invoked by uid 106); 6 Aug 2026 15:41:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6sF5B4GWXsqkrm7UtELydMqr/bXv8iH6om0xNh03U6k=; b=HizLWB8ZLvkFPnkBCxC2DxT5ql40H9xT9YqLl9hQeEDWuZuq8H+t7zou+24DkqkhY/kEmjBjMMI092B2MxgsFTH1y3VBubqRdBHJmDJH8h3pU/qC5yTa+rjEwJT7AiHCi9Gn21R+W+KBN/Y2vjM0QLFx/D6UwGdF6lLwWS6opjmKqbpg4BuWA4UyAd+xxhcC+b26SaYejcoNzvhULX/ue7s7rxyFIuxGJqB1oO/WB86nRzqVx6KirrOwaK5yf0ls+OSFk4wk7y6XvOGRLLk9Fc8ywaS+zkY92Bp8iK3HZUmYiJXXzF8ZwJjHJxeX3aCyIyf9bmNJo2ZdVwtVvGqK0A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Aug 2026 15:41:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 94753 invoked by uid 111); 6 Aug 2026 15:41:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Aug 2026 11:41:04 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Aug 2026 11:41:03 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 11/11] bisect: handle dup() failure when redirecting
 stdout
Message-ID: <20260806154103.GA1625706@coredump.intra.peff.net>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
 <pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
 <829cd82177a8e72e450d42db2af3166123c5b7c6.1785954661.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <829cd82177a8e72e450d42db2af3166123c5b7c6.1785954661.git.gitgitgadget@gmail.com>

On Wed, Aug 05, 2026 at 06:31:00PM +0000, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index ceb60b0626..733d28d377 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -1308,7 +1308,12 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>  
>  		fflush(stdout);
>  		saved_stdout = dup(1);
> -		dup2(temporary_stdout_fd, 1);
> +		if (saved_stdout < 0 ||
> +		    dup2(temporary_stdout_fd, 1) < 0) {
> +			res = error_errno(_("could not duplicate stdout"));
> +			close(temporary_stdout_fd);
> +			break;
> +		}

Ironically this produces a new Coverity complaint. ;)

If dup2() fails, then we break out of the loop, leaking saved_stdout.

-Peff
