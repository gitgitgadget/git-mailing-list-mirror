Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1EA3C9ED4
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422688; cv=none; b=GBezyNw33Nue0uunfCzcmCysulf48BVpYO55KzsVeMzBJEpArdEAhmIbRICI5qXmBN7GPdVZhre1il0LYoAZ+4SLf5OTxJwm8NgyZvokZJuzvgoE+J8fHSn1i+MwQPlLx+0XjxaHH4Nqly6HE4LrhpMPCEMCrXsmhc1t5PUTiyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422688; c=relaxed/simple;
	bh=ACKUdbPkbhxZAMDAexUQNQPRWQiSaE2oGwqt4pV78Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIkb5RBbqEGjqfbjytO+WQF/ILpJjRVaLwnppDRtMURiw/37iKUm0gwgt3Nt5QNpDLf69VnfByUcNaOpBO7tQAu7WaJa+cDOL6oWBVI/GUPhrEfZBa/NyCv+GtLeq/n20zVnco59672TzN/7WUuRvOu3Q/2OiS7aYTJQR6tAq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 10F86A1A97;
	Fri, 13 Mar 2026 18:24:45 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dt0Uvdc5erJq; Fri, 13 Mar 2026 18:24:44 +0100 (CET)
Received: from end (aamiens-653-1-40-48.w83-192.abo.wanadoo.fr [83.192.199.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id D21E3A0405;
	Fri, 13 Mar 2026 18:24:44 +0100 (CET)
Received: from samy by end with local (Exim 4.99.1)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1w16Fg-00000007Yk1-1cYV;
	Fri, 13 Mar 2026 18:24:44 +0100
Date: Fri, 13 Mar 2026 18:24:44 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Fix GNU/Hurd build
Message-ID: <abRIXE2es5A-4VLv@end>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
References: <20260312191901.174808-1-samuel.thibault@ens-lyon.org>
 <xmqqbjgsdbr6.fsf@gitster.g>
 <abOxLFNGgZjo1dyi@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abOxLFNGgZjo1dyi@pks.im>
Organization: I am not organized

Patrick Steinhardt, le ven. 13 mars 2026 07:39:40 +0100, a ecrit:
> On Thu, Mar 12, 2026 at 01:38:21PM -0700, Junio C Hamano wrote:
> > Samuel Thibault <samuel.thibault@ens-lyon.org> writes:
> > 
> > > GNU/Hurd does not have a PATH_MAX limitation
> > 
> > Thanks.  clar folks might prefer to take it upstream and have us as
> > a downstream to import from them, so I'll forward it first before
> > taking it for ourselves.
> > 
> > It makes me wonder if an organization like this is easier to follow,
> > i.e., platform specific settings first and then catch-all default at
> > the end:
> > 
> > 	#if defined(CLAR_LONGPATHS)
> > 	#define CLAR_MAX_PATH 4096
> > 	#elif defined(PATH_MAX)
> > 	#define CLAR_MAX_PATH PATH_MAX
> > 	#elif deifned(MAX_PATH)
> > 	#define CLAR_MAX_PATH MAX_PATH
> > 	#fi
> > 
> > 	#if !defined(CLAR_MAX_PATH)
> > 	#define CLAR_MAX_PATH 4096
> > 	#fi
> > 
> > but that is a separate issue best handled by the clar folks.
> 
> Agreed, something like this would read better indeed.

Ah, actually Pino already contributed a fix in december:)

> Samuel, do you
> want to maybe create a pull request in [1] to fix this in clar itself?

> [1]: https://github.com/clar-test/clar

It would be useful to put this github url in the README, I have
submitted
https://github.com/clar-test/clar/pull/135
so it'll eventually end up in the git source for people to find out
where to send clar patches.

Samuel
