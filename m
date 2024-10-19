Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A7191F62
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729372900; cv=none; b=kMdDuD7odpgtA3Nu+cwjvkZ64Jy4MBPPrbeAKMNGXlD/qGN74wAoh8zrN13phVtaiWlWMvlEtY+qJuMa2vK3ALLeMO1FH6ZAgfuTWK94dI32OdHW+qlBL53mHV6/HVgsElnXkwZKbrv8b0tONW1Wf8ovr4YCJspMaHLm2aw2IjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729372900; c=relaxed/simple;
	bh=1BA7cn5SOz26Vr2HAInhILOyHdl+D9wTvRBnNasaqLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVdTVd7IT2WEmOzVponGoT2rE3Y8kP0insYkrQfbg3WziK6gREPSOOFjZtDT7joKNzO/vED90r9UYv2WnXUN3s27aIuqmc49ZOdPy3E5eiYW6hR4iizTINhhGQ25Sckj/KDcxDJmStEdINtjjJXG4mtjflrlx/iLoI1tMAvbnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JBrKW74n; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JBrKW74n"
Received: (qmail 16359 invoked by uid 109); 19 Oct 2024 21:21:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=1BA7cn5SOz26Vr2HAInhILOyHdl+D9wTvRBnNasaqLc=; b=JBrKW74nSo/9wIScqpvy6rzHaGXyvtuTUtb+YPyWOZTM927Mms3LrynaF3RJZIA0H93/WD2hpCTZYuaZVdevqlEN3XwEUe8nwEZTK9Lu7E30qaLaQ07/7LFpu22nlJDOeS+hB8BIILiW/JVDMYzQzBM/g7i023KoHy570icAnHxdq/c0VNwhqQWIInZMs4Kdv8odBRbugK4VAFb/6bNSTxPyqk8jI7TVKXtnBKld6VckX9vk8MB6u1QZC6Y5H89S3oHEAzdwi0n/rAULUUjfviIxVo4ni5frOyO/1CVKlrlPXIa3Sj7AJx1abLf+0Osng/5kptBQ89I7N+dflDumlA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Oct 2024 21:21:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4557 invoked by uid 111); 19 Oct 2024 21:21:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Oct 2024 17:21:35 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Oct 2024 17:21:35 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Adam Dinwoodie <adam@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] credential-cache: treat ECONNABORTED like ECONNRESET
Message-ID: <20241019212135.GB589728@coredump.intra.peff.net>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <658fe4fa540a0a5316e11ed43f9139d5ef818ee5.1729226155.git.ps@pks.im>
 <20241018052952.GE2408674@coredump.intra.peff.net>
 <71e8e44e-dbf9-482e-a351-3a82aa1ca5dd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71e8e44e-dbf9-482e-a351-3a82aa1ca5dd@app.fastmail.com>

On Fri, Oct 18, 2024 at 11:27:50PM +0200, Kristoffer Haugsbakk wrote:

> On Fri, Oct 18, 2024, at 07:29, Jeff King wrote:
> > [jk: commit message]
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> 
> Just curious.  Why this bracket comment (non-trailer line or whatever it
> is called) and not a regular trailer?  All the bracket comments that
> I’ve seen give some comment, often about tweaking the patch or the
> commit message.  In this case though the whole commit message is written
> by one person.

I assigned authorship to Ramsay, so my name is not otherwise mentioned,
but appears in the signoff. So it was a way of mentioning what I
contributed (both for credit, but also in case anybody has questions
later).

I guess "Commit-message-by:" would work, too. ;) I guess you could
likewise argue that I'm a co-author.

I think in the usual trailer order, it would be:

  Signed-off-by: Ramsay
  [jk: add commit message]
  Signed-off-by: me

but I didn't want to forge his S-o-b without asking first.

-Peff
