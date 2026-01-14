Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732BC36165B
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426041; cv=none; b=jPrYIhGp0CmUmPuzbpi37vLhAAcNx/dbRc1LgmDskGHdrVkpPX2UmT8uWOKgMXCrarHrp4udwGD7F/XBve2cVc3p4845mblgFqstZjRVQD5IXLqvFdOoepRX8yxq1ac/yXj+mER4ogkDrmaql4Vg1SRKZu0SJvxKq1RgC2pm7QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426041; c=relaxed/simple;
	bh=CAZhrLmAdjLz+kh0jB1Qjm3/hmpiEFWPrmYcWjQfKSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A90wL7vJQNaNnqJews0i80w6pR54LcsN1EKfynXfFSub4XjLDoRmKLL1G8p3IZ0GcqgqlzYTBP+hpG+WrzRZdfyEH83wEzM0gic1WN5tRTKNUwqUWeniL/u0DU7UJWn5SVPuuG0pJO7/kbSo0cYirGG/98g60LgWwV1ZYIW50VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fqPEa0E/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fqPEa0E/"
Received: (qmail 41806 invoked by uid 109); 14 Jan 2026 21:27:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CAZhrLmAdjLz+kh0jB1Qjm3/hmpiEFWPrmYcWjQfKSg=; b=fqPEa0E/hD8ZURCyXgWbi3nCww0F1tJ8EekfRQl9zenuBRMS1hcZDyzWFR7voTD6Bugn0Qvrhx3MrL52qpMUyEypPY8jmYsiUyO9i91Dzmedmy2XNRiRzFno1mUmkP79HZ3ubQfzy/CXlgJhTGtjoO9lJ3OTCT8KOJriqurNHzb61lupIuDRWpkRURXrJal4EKHNFM8FJVGicyxw9s/FtkJpcrizzoby7uV9v/sxTcrWLGizrVRQEDZuxJqHHSY/5AbOY8PpbnisqufQeZSDDmUzAuU6nLhGUwM79qeZf3FGbUlmJ3B18O7EuMei9zAvPCSyYayyp8jIR/kT2R6gbA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 21:27:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 70204 invoked by uid 111); 14 Jan 2026 21:27:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 16:27:21 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 16:27:18 -0500
From: Jeff King <peff@peff.net>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Chris Darroch <chrisd@apache.org>
Subject: Re: [PATCH v3 2/2] hook: make ungroup opt-out instead of opt-in
Message-ID: <20260114212718.GB1010080@coredump.intra.peff.net>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260114185731.2381550-1-adrian.ratiu@collabora.com>
 <20260114185731.2381550-3-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114185731.2381550-3-adrian.ratiu@collabora.com>

On Wed, Jan 14, 2026 at 08:57:31PM +0200, Adrian Ratiu wrote:

> In 857f047e40 (hook: allow overriding the ungroup option, 2025-12-26),
> I accidentally made the ungroup option opt-in instead of opt-out and
> despite my best efforts to set it for all API users, I missed a case
> which requires it to be set: the pre-push hook which regressed.
> 
> The only thing I needed in that commit was a way to change the default,
> to convert the remaining receive-pack hooks which require ungroup == 0
> for sideband output, so it doesn't matter if it's on or off by default.
> 
> Bring back the original behavior by setting it for all hooks in the
> struct run_hooks_opt initializer, which nicely allows changing the
> default value only where needed, in receive-pack.c.

I think this is an improvement overall to what's currently in 'seen',
and the patch looks as I'd expect.

I have doubts in general about the approach taken by c65f26fca4
(receive-pack: convert receive hooks to hook API, 2025-12-26). We used
to use an async muxer thread, and now we are buffering hook stderr,
which to my mind is a regression (both in terms of real-time output, but
also the deadlock issues mentioned earlier).

I'd rather see us continue to set up a muxer thread, and then direct the
hook API to attach the stderr of the hook processes to that descriptor.
Then receive-pack would just work as before, without having to fiddle
with the ungroup flag at all.

You can take that with the appropriate size grain of salt from an
observer who has not been following the series (and is not really
interested in it, beyond making sure we do not introduce regressions).
But it is also an observer who has dealt with many I/O deadlocks in Git. ;)

-Peff
