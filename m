Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84453FFF94
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570420; cv=none; b=HHWLs8ZXSF1AUn8PuMBHjLFrsIISiEmJbcYg1y18mrf+aLMgzF5xxfEIoP8gTdem35IrH8qlQnIBFkLMDbuDEI/P+OJ4KLWErJS+wyjUJguI1YUOSsH+iyUwFYQF7O0NPYOGYKR7VOZfPK7ZhONDyPJwu26SnsmOi5WUKG+J18I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570420; c=relaxed/simple;
	bh=k8LTTuNBJasBp0bbcWlRj7DkNE30RCURCox8M1NDTdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OD+/jTkumIGuxTG8+F1mAcegl+zAf7KqhQioLsbFGzGhAHoMSaONkYqvMTH7Yd4iYt0wTNnnicX31uzo7X6pN1vsxdBPl70IyXncJN4+Ke2Lb74Ic+skuSAaGehEVUYC+1xoMCVrAreejU0n275/+EWJ1SCB7q8qfsdZPUnrfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YC9fjpcE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YC9fjpcE"
Received: (qmail 44840 invoked by uid 106); 12 Aug 2026 21:33:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=k8LTTuNBJasBp0bbcWlRj7DkNE30RCURCox8M1NDTdg=; b=YC9fjpcERS0ZVbjDpIlnH/IxloUGZOwRPaYI67vP5Fb41cOQBs8kt0V1QSlW+Bl+EL1D39fb9w5vKWe4vDJX/MC6IuIVbnZfY/gHjh2Lj716IBXnGburCm3t40qtYv5ESTTRVp5lJxZPcvqaRc+fOuTYGk1eDB+o2csQwxD7RA+2HEP57BzeFd3R7t3YGAWjg7El/jVrI56/dRLMPLJBM146nbq9PXX+Jud+Cp9Q36S9bxhWhEsAC2OsfjbSV1Wys1g1/Zzdq+ekiUg0Q+gC0ZKTszTaVp7wcgu9X8iYLfvDJ5KTcPvr0yN9u4CufqvuruKhFvuSnTlMvA3kPeM6ZQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2026 21:33:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31411 invoked by uid 111); 12 Aug 2026 21:33:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2026 17:33:37 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Aug 2026 17:33:36 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 12/12] bisect: handle dup() failure when redirecting
 stdout
Message-ID: <20260812213336.GB152730@coredump.intra.peff.net>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
 <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
 <258dbb0fbda31ab0627f9da179c1c37cdd64666c.1786521801.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <258dbb0fbda31ab0627f9da179c1c37cdd64666c.1786521801.git.gitgitgadget@gmail.com>

On Wed, Aug 12, 2026 at 08:03:20AM +0000, Johannes Schindelin via GitGitGadget wrote:

> @@ -1308,7 +1308,14 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>  
>  		fflush(stdout);
>  		saved_stdout = dup(1);
> -		dup2(temporary_stdout_fd, 1);
> +		if (saved_stdout < 0 ||
> +		    dup2(temporary_stdout_fd, 1) < 0) {
> +			res = error_errno(_("could not duplicate stdout"));
> +			if (saved_stdout >= 0)
> +				close(saved_stdout);
> +			close(temporary_stdout_fd);
> +			break;
> +		}

OK. The extra "if (saved_stdout >= 0)" is not strictly necessary if we
are OK considering close(-1) as a noop, but it doesn't hurt too much.

It could also be avoided with two separate checks:

  saved_stdout = dup(1);
  if (saved_stdout < 0)
	...
  if (dup2_temporary_stdout_fd, 1) < 0)
	...

but that would involve a little bit of repetition of the other cleanup
lines (though it would also allow more specific error messages).

Probably not worth polishing this further, though. What you have here is
correct and I would be surprised if any user ever sees this error case.
It is mostly about covering all of the paths for leaks.

-Peff
