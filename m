Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080622CBD9
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771146727; cv=none; b=HFQzuUed2fX57EcVCZ3+OnOoKjJevocoQROJ4VhS6NFqeX8Igwd3H7TrDu9E7QznEE8swWopvgX35+IaNCG4JDV8bmydPPMIo/CSG2S41Ivf8u6J3TQr2tVfBbhaF/OFJvME8/+K5A/NONGZrpA+qgIXW2tohIXmI4Iu9GdVHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771146727; c=relaxed/simple;
	bh=V4w0EmozdacLebBnoalH7TwazT5FzwDSwNTloRbsKrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlWbzqDAYeZSdSR6mZ5lzXY1VqnTgoWS2LD0wSNANwFtQwYp6qPMyybBaGjeRIVVhpvNVh1RlGJz4pAn8D+BXRcRob3fO4g/Zxm2bDu2iVDqSOXzEBFbcpGmbJzogl/tfyUV7m5Y1Y7WZ2Ove41FAbieA+jAhHZ5duyNYtV0eBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RFNjoJbY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RFNjoJbY"
Received: (qmail 44799 invoked by uid 109); 15 Feb 2026 09:12:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=V4w0EmozdacLebBnoalH7TwazT5FzwDSwNTloRbsKrQ=; b=RFNjoJbYfi24wLi/2Eob8l8klMiHJhIfJhd/vFQARZhJmQoeAcVQWsERBawkIyUcOAr657mMOtrUfiMDwiqNbhVcwNI0J9QXd0KnL5zrE4I7wUoKRRT8k0nFB+P6ck1OxoaJZHehbG/5O8209EP+4KvSRccXQDQthqnXjMV/neQaYtPW1eVPZZ+dvlSFHOfYqBRMP0m7QcrydwdM4qYHkouEdoAhDB7hYsKTUxYoil91iK0CxFpIK8WlS+RAqXRybY2gqcwCx+4VzFdSAaE8/r3FzUHznmJrpYUnAkSn+xjYrLaJ53cfnmcSiuiuYW9aYffKmlsYX1NIvYv5w0ktqA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Feb 2026 09:12:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 113370 invoked by uid 111); 15 Feb 2026 09:12:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Feb 2026 04:12:10 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Feb 2026 04:12:04 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	gitster@pobox.com
Subject: Re: [PATCH v5 2/4] refs: forward and use the reference storage
 payload
Message-ID: <20260215091204.GA696020@coredump.intra.peff.net>
References: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
 <20260209-kn-alternate-ref-dir-v5-2-740899834ceb@gmail.com>
 <20260210224654.GA1837132@coredump.intra.peff.net>
 <CAOLa=ZQdYVO8wJxs_e-6FR7x_zOJnTNTwAVm1sHv23pnDYKnug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQdYVO8wJxs_e-6FR7x_zOJnTNTwAVm1sHv23pnDYKnug@mail.gmail.com>

On Fri, Feb 13, 2026 at 06:45:20AM -0800, Karthik Nayak wrote:

> > BTW, is it possible to have a gitdir string without a slash in it? I
> > guess not if it is absolute, but I didn't look at the caller to see if
> > that is always true. Anyway, I wonder if we should be checking the
> > result of strrchr() here.
> 
> Since this is called during the ref store initialization and that value
> is generally set via:
> 
> 1. `repo->gitdir`: Which is resolved to an absolute path
> 2. `repo->commondir`: Which is user input, can be without slash
> 3. `worktree dir`: Should contain a slash
> 4. `submodule dir`: Should contain a slash
> 5. `refs migration dir`: Should contain a slash
> 
> But even with this, Gits understanding of linked worktrees are that they
> are in a `$gitdir/worktrees/$wt_id`. So it should be safe to do this.
> Nevertheless, I'll add in a check.

Thanks. I figured it was something like that. Even a comment or a BUG()
would be more than enough, I'd think.

-Peff
