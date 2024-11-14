Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348A163
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731543013; cv=none; b=Mwn8tOmVKMdmZTwKeZTROB6IReLwVUyB8HShUW1zzcxdAH8wYIHuh5N8RJdFIxiI5w+zVzOeEDjv6KmWkZ/I/zuymmXs0+Y7TsC1b8GtS6V7oG2LPQpaybTcea08nBvuWVi3YHIVibYao3w53lCSuCCQw/f/CnA2BkcQfBQ6CdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731543013; c=relaxed/simple;
	bh=T7grz45vn68cInHzATbra87hlSPkUBA9KgYtr1sWNZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6yp8MdiAHIn6looP7TUuXEnnItP0Q6pDQhzCydFQTmmryk+paik48xpa2MWgBco2xgszpVCR+AEjxDSUE5uiSjQFIy1dBsA4RmhITYZUqp4wwc7cMSGiJgLQkXSeM6mmAUSqLgav5NDs91mZa6DgfpceL92o/Y1GIB5z577SRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TuYaJ9U3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TuYaJ9U3"
Received: (qmail 25901 invoked by uid 109); 14 Nov 2024 00:10:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=T7grz45vn68cInHzATbra87hlSPkUBA9KgYtr1sWNZs=; b=TuYaJ9U3UZ7cXHCyz9BPce6I7KB3XIj7YI7V9UhYVYObrIU/9AQn68pKBm5TQEMkgsAZNTrnImey3aDHuGK6LLJ0jLEUY2WzLAYYQ2/TW0C6N5zbwce9+vp0nNAYJo1mF1Xv082MMsjGJ7iOjmjxUZ3KTddGM9fqVnAUsX83xZ6v3xTLcgNYlASgydX2Bb8j8f9KKWaiUAzTrBQ7kHUipbfWx8fLwfIUG54FnLsQjTBcB6Tp0hNRDpK085LNT0KhCjQlYzWqiKsx0LF/h5JhqJ8z/yJC5uatb9KbRW3kcBbuLieSCdvBMyhNMtJBlimpiWrnymoGSbSVzywyWtShcg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Nov 2024 00:10:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19370 invoked by uid 111); 14 Nov 2024 00:10:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Nov 2024 19:10:06 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 13 Nov 2024 19:10:03 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Neil Mayhew <neil@mayhew.name>,
	Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/3] Strengthen fsck checks for submodule URLs
Message-ID: <20241114001003.GA1140565@coredump.intra.peff.net>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <20240110102338.GA16674@coredump.intra.peff.net>
 <d9f53fe7-6570-4aea-894c-942e12e012c4@mayhew.name>
 <xmqq5xoqahbx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xoqahbx.fsf@gitster.g>

On Thu, Nov 14, 2024 at 07:40:02AM +0900, Junio C Hamano wrote:

> > Is there any possibility of "loosening the fsck.gitmodulesUrl
> > severity", as Jeff suggested?
> 
> Isn't the suggestion not about butchering the rest of the world but
> by locally configuring fsck.gitmodulesUrl down from error to
> warning?  I personally think excluding a single known-offending blob
> without doing such loosening is a much better idea in that it
> prevents *new* offending instances from getting into the repository,
> while allowing an existing benign and honest mistake to stay in your
> history.  Loosening the severity of a class of check means you will
> accept *new* offending instances, which may very well be malicious,
> unlike the existing benign one you know about.

The trouble with configuring fsck.gitmodulesUrl yourself (or using
skipList, which I agree is better if you can do it) is that it only
helps your local repo, and not:

 1. Hosting sites which may need special work-arounds to let you push up
    to them, since they are using receive.fsckObjects.

    In theory this is a good thing, because it prevents dumb mistakes
    from getting distributed in the first place. But it also is a pain
    for projects with established history.

 2. All of the people who are going to clone your repo, who might need
    to follow special instructions.

    The only reason this hasn't been a huge pain in practice is that
    almost nobody turns on transfer.fsckObjects in the first place. In
    theory the people who do turn it on know enough to examine the
    objects themselves and decide if it's OK. I don't know how true that
    is in practice, though (and certainly it would be nice to turn this
    feature on by default, but I do worry about people getting caught up
    in exactly these kind of historical messes).

We did add the gitmoduleUrl check to help with malicious URLs. But it
was always an extra layer of defense over the real fix, which was in the
credential code. It's _possible_ that a newly discovered vulnerability
will be protected by the existing fsck check, but I'm a little skeptical
about its security value at this point (especially because hardly
anybody runs it locally, and protection on the hosting sites isn't that
hard to work around).

So if it's causing people real pain in practice, I think there could be
an argument for downgrading the check to a warning. I don't have a
strong feeling that we _should_ do that, only that I don't personally
reject it immediately as an option.

-Peff
