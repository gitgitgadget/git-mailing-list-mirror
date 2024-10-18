Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735F20E31F
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 04:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225990; cv=none; b=KUVM3mJigoBHPM7gQFomnk12JuZtxwZBRNnhjbNXL6J0hdFbQLqUcp88Dv1lLQ9y6Ve0WomNGfnLKXKja1Z1fyhxA3hg0knLeJCeZGdDjzTa5HsJQRg4ru+HgJqJzxuUpMXzdOyas1Tdwnz86IDI7GfCFw6gD93AwV12bDSDYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225990; c=relaxed/simple;
	bh=+Rih+AFGMjKzYJGviJXiF6xM7udfurI2ofowc5dVciI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3pApCUrtbFzoZYCKpFcpypUqpx+F05ZjrSNOI4/zmoVnIJeRltFk6zSNw4eQaGQ80wTd8TTLUWhb/dBQ76kp7nsRRNQZ9wzqQefuDKC0H5WDCIU9zyr5sp4OphXhNGZ7qcrATsQT0KjPX22Ok8Tf05M/iIMuk7lkri23UPKfow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U/mlxTSV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U/mlxTSV"
Received: (qmail 32233 invoked by uid 109); 18 Oct 2024 04:33:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+Rih+AFGMjKzYJGviJXiF6xM7udfurI2ofowc5dVciI=; b=U/mlxTSVJYF/NRegsX/+Y7gLRx0cCuleYleuw8HQIJgSQMQJOP1pRbzgAJJMTfpj8++amMk4XYObXQPQtj4RgcD0eCU64uIGBrx5+8QiBU1cijBVLl1ftx/tLzUJIRknUWDGCkcohQXZKjM/PTcXfMQ+xrUQPYEzsnVOR0OlaCCoZZA1Q9u3dA7lT7lQgd7OAS/Ws/Y37pvfvLfcEeoyjAHBQA99qqNYdnwvuQdKZjn2K1n5qTuHN2dqVqOZsSzWCX2DYvPduBHPqiLDmYI58dRJv+r//RAcWTpqSJKYkvgqMujEwiyPKC2U/Z5DHkKdEd5Aed2ujY0Yt7nCd9kHAw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Oct 2024 04:33:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12500 invoked by uid 111); 18 Oct 2024 04:33:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2024 00:33:07 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 18 Oct 2024 00:33:06 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Piotr Szlazak <piotr.szlazak@gmail.com>,
	Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	David Turner <dturner@twosigma.com>
Subject: Re: [PATCH] upload-pack: fix how ALLOW_ANY_SHA1 flag is disabled
Message-ID: <20241018043306.GB2408674@coredump.intra.peff.net>
References: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
 <ZxAttC1dQUllR76m@nand.local>
 <20241017023735.GB1858436@coredump.intra.peff.net>
 <ZxEr4+sb4DfmtrKv@nand.local>
 <a328b6d5-e604-4517-b041-59db19e1f66c@gmail.com>
 <ZxFblRri8Xo/lGsK@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxFblRri8Xo/lGsK@nand.local>

On Thu, Oct 17, 2024 at 02:46:45PM -0400, Taylor Blau wrote:

> > Rather not as config file is parsed only once:
> >
> > https://github.com/git/git/blob/15030f9556f545b167b1879b877a5d780252dc16/upload-pack.c#L1368
> 
> I am not sure I follow... upload_pack_config() is invoked on every
> configuration line that we see. So the first time when we read
> "allowAnySHA1InWant = true", we take the first path through that
> function you linked. The second time, we take the else branch, and
> correspondingly unset the bits from ALLOW_ANY_SHA1.
> 
> So today that is doing the right thing (it will end with the same bits
> set that we started with). But under the proposed patch that behavior
> would change, and the lower two bits would still be set.

Reading Piotr's response I wondered if upload-pack might be using the
configset API instead of a config callback. But no, it does look like a
config callback.

But it does hint at a possible path if we wanted to process these
independently: we could read each of the config options separately,
resolving them in the usual last-one-wins way, and then turning the
result into a bitfield. Something like this, outside of the callback
(totally untested):

  int v;
  unsigned bits = 0;

  if (!git_config_get_bool("uploadpack.allowtipsha1inwant", &v) && v)
	bits |= ALLOW_TIP_SHA1;
  if (!git_config_get_bool("uploadpack.allowreachablesha1inwant", &v) && v)
	bits |= ALLOW_REACHABLE_SHA1;
  if (!git_config_get_bool("uploadpack.allowanysha1inwant", &v) && v)
	bits |= ALLOW_ANY_SHA1;

That makes the config flags independent. But the features themselves are
not really independent. If you do:

  [uploadpack]
  allowAnySHA1InWant = true
  allowTipSHA1InWant = false

it is still going to allow the "tip" flag, because it's a subset of the
"any" flag. And you can't escape that.

So I still think we're better off to just document (and of course in the
long run all of these become less and less interesting as they are
v0-only options).

-Peff
