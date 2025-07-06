Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208829A5
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751773034; cv=none; b=ZN/JGUJZHJrQEph45GsbMuaf+Ar5TwYjihY48gBaeCnvMKzAWhChmfUXUaLEz05FXalTRXNETLMqFbGgw1LZEgz0ziCYhGb6rBW4KDysKrfaso2gOL0EYCM/DPsKg4ytWG2l9tW93VW7ROZydCwtVwkGXzwbpZkBo5ZzP1+01To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751773034; c=relaxed/simple;
	bh=vflZslcGtPftQ4qxhY45TOfzyE09o2KjyQLFvrXHdCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CspPD84uB5VY4JlH0lXo8piEIp0iS4lIyVPHHD2+wxgUGD0w+93lTbd+CHmCsJoL9FdFUQK/zeLGJTpg+w8h0VavmYf4iNh+AlhtzcmHFqDz6SLy4d42UMfVxlVW9FOe2/Yr5vTTRRgtGPRSq8r26RAN2rEIEUCoKnANpHVimZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=btzZRvVb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="btzZRvVb"
Received: (qmail 26609 invoked by uid 109); 6 Jul 2025 03:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vflZslcGtPftQ4qxhY45TOfzyE09o2KjyQLFvrXHdCc=; b=btzZRvVb1Iw7csq8dc2w/WegZ+x9Vtspjkfiuil3tv1CXUFBSnnN7IOX8VUdEj+oNnINcivKwNYqKk4YFsFym6VaR2h52U9g/0iTCSV+xQa/BExvUH1QydFbpmU8tl31oB806dzgxqfW7i5yelzjZwK3+A5LB6CUA6ekKfGy/2yEXGvvwFN0boohvQSUDxHG4If2AhJcp2t/YnvwSpOnTjsZZqg7Q4MvIc3yxGrieuVCm732Zk7GtOPVmw/ChUDlQEL6ec2S2BAvdJdezjtWMVjCaa5hBN2xikIeNkVRvm2wQzOh1LV7CPi+yH169KZJY1AVDMvFAlLfw2ZaK9sKrw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 06 Jul 2025 03:37:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11613 invoked by uid 111); 6 Jul 2025 03:37:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Jul 2025 23:37:15 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 5 Jul 2025 23:37:10 -0400
From: Jeff King <peff@peff.net>
To: Drew DeVault <drew@ddevault.org>
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@google.com>,
	Patrick Steinhardt <ps@pks.im>, Andy Koppe <andy.koppe@gmail.com>,
	Remo Senekowitsch <remo@buenzli.dev>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
Message-ID: <20250706033710.GD3041790@coredump.intra.peff.net>
References: <20250703113505.11889-1-drew@ddevault.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703113505.11889-1-drew@ddevault.org>

On Thu, Jul 03, 2025 at 01:29:51PM +0200, Drew DeVault wrote:

> One remark that occurs to me upon spinning v2 is that I'm not sure how
> to test this behavior. There is no obvious way to cause git upstream to
> produce a commit with a change-id -- presently these are only ever added
> by third-party tools.

I don't have any opinion on the feature itself, but the plumbing way to
do it would perhaps be:

  # make some vanilla commit...
  git commit -m foo &&

  # make a new variant with the change id
  commit=$(
    git cat-file commit HEAD |
    perl -lpe 'print "change-id foo" unless length' |
    git hash-object -w --stdin -t commit
  ) &&

  # replace the old one
  git update-ref HEAD $commit

which would be enough for Git's test suite. If this is something that
other third-party tools are going to start adding, it might be worth
adding some tests to Git's suite anyway to make sure it is handled
correctly. (I didn't follow the discussion on whether a new commit
header was something the Git project wanted to endorse, versus sticking
it in a trailer line, so don't take this as either a positive or
negative on the approach).

-Peff
