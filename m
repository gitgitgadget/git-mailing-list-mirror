Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E94CCDE5
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707507; cv=none; b=nXalJYDJbpFl87sSkamezsqO3CEFmJhPHcoXaQ76yB/YCSVGi3/fCpO0Jbu2yltjXY06p6ldYNyckTexhsIFKWBWMAuW8zI+wYYBJv96U5S2Gglk9N6DqLqSPvMWyRvLD2wvNyJiQuCe6LsYOwPrJHzGxhH+xbZnw5eq5Mrk0lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707507; c=relaxed/simple;
	bh=sPyvxjuDnXMbFVgehgj+7ehV0XJjiEQ7C+f+Qg/da8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym3eQKRXhNpZLta2BbvCz61a+xOc1WslOjw0QGjr1/cAiWPW+TMAnTjjI81/G1eqS8vn6V6vi1vQFXAeb1lZaPorFjnmZeqKMut/qMaMm1rmO6vntLfeSwqQRwgC3FDVNXGAnDoUMBQlJ91iqtpAbiP8ac0JXRSw9wa9kZtdZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RKieLuw1; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RKieLuw1"
Received: (qmail 22415 invoked by uid 106); 6 Sep 2026 15:11:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sPyvxjuDnXMbFVgehgj+7ehV0XJjiEQ7C+f+Qg/da8A=; b=RKieLuw1XLV5TSP6AJWwgb+Vp4ite9aO1gfyb/cRUHB/2L25+u5v8ahiVANXyDs3JoEfhb4msYFRdh1pUH6x51EysIGLCcJSTffUy3uz5iffjsEXwRTdIKBELysEU47itr0I/m5IX9ROyPzYzfIyLnQwqMlk0UpNG7ZP+agcDY6aEf3LvxRUTGIwO7d0NdrrDqJq0EuJ2K5YE6YumRORJqUpbm1l1gounoqIOeghdWV4tnrKjIq92Cc/Sv/yaiTzaVyrr5jvOkySgVjRKSzyhhbu8Lj5HaW9dWQ/wXp2JhFtjs6BzdC1/9hXxFd/Vzk9ibGyIhHP1mBGpr8GN2q5EQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 06 Sep 2026 15:11:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 105550 invoked by uid 111); 6 Sep 2026 15:11:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 06 Sep 2026 11:11:37 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 6 Sep 2026 11:11:37 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] ci: bump debian-11 job to debian-12
Message-ID: <20260906151137.GA328152@coredump.intra.peff.net>
References: <20260905135822.GA3914811@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260905135822.GA3914811@coredump.intra.peff.net>

On Sat, Sep 05, 2026 at 09:58:22AM -0400, Jeff King wrote:

> I started looking at this because I got an apt failure on a debian-11
> job today. It might have just been a transient mirror failure (although
> it reproduced for several minutes afterwards). But this seems like the
> right step forward anyway.

BTW, I noticed that the linux32 build is using ubuntu 20.04, which has
been out of LTS for a year. But bumping isn't really an option; they
dropped i386 platform support, and so has Debian.

I'm mostly inclined to leave it unless/until it starts creating
headaches. To some degree, if we cannot even find an image to test
again, it might not be an important enough platform to care about. But I
can also imagine there is a long tail of oddball 32-bit platforms that
Git does run on (like small ARM chips), and it's nice to at least have
some coverage. Possibly there's an ARM image we could use (looks like
armhf?).

We also seem to use 20.04 for linux-TEST-vars. On the surface there's no
reason it couldn't be using ubuntu-latest, though I think this may be
one of those cases where it's doing double duty as "test exotic configs"
and "test on an older platform". But might be worth bumping to the
oldest in-scope LTS.

All out of scope for this patch, and mostly I'm inclined to ignore it
for now until we hit problems (and then decide if it's worth
accommodating or if old systems are too old).

-Peff
