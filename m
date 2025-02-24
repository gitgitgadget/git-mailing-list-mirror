Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00614A4E9
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438630; cv=none; b=iALsIIO99arTF01nogsLaSCARG4qM+/Rp0mdv5D/RVuM+Am4vEZvdsivRFCXj7W1MCowvINxK3wmJv68beuhXvkUwwBDkFgqI7gvIgeRuz/W7rOET/go473xfG1L912lBV9ladkOoX/Sym7uCW/XG7IfQ73NItvumXhtmT2I8PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438630; c=relaxed/simple;
	bh=8ihbhuDVye3jl3AvIhLaf5nUPTdovIxQb4Q4l3NaI/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCEKykGpIb61T0/uR5kjB4v40DUMyktn7oV3BiCh1q8uikbfzD5Ux23CzKLOar1q0OgF/s2iaJg0bDqrjVrRiyfW68C6vIdGIRpyEkI+7YQOL8OvBu7JUcxdEoui7lPIOmWMOhMQ6HipABQkbPX/+ctJ/obToWj86boZXm2xCj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fvsW2dPw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fvsW2dPw"
Received: (qmail 21150 invoked by uid 109); 24 Feb 2025 23:10:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8ihbhuDVye3jl3AvIhLaf5nUPTdovIxQb4Q4l3NaI/I=; b=fvsW2dPw6yAVLEOAoLfHldi0pglbTb+evRuqp5KZMd1SmpqJPmD/14iRz5YAFrTjuNTVg5u/FAdUxvIemC6iLyxHQSMiWZSvfRcSwUQI1l5VX/+XtgjjFNPWp0FfYQ+pIDgN1nUNOd0TmlwNFXOHp3uifaqskC8edUVbjqkwiUUnhSBNWfcBnVHzBSz4tqTkf/7hjvf9iC7nSxEYCK0q2sunI10to/FxGydbUT5Dqnfc2VMgrljxAqALwIuW3yxisR2nz4Ugh9nvZnnWKHAUZf8Yas4+qVeD7bpE9m6emYewve9jhL4+PqrD2Mjfmjtvm/Fesqt+Ia/4H+H65VGRNA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Feb 2025 23:10:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30188 invoked by uid 111); 24 Feb 2025 23:10:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Feb 2025 18:10:25 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Feb 2025 18:10:24 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v2 11/16] rerere: let `rerere_path()` write paths into a
 caller-provided buffer
Message-ID: <20250224231024.GA729825@coredump.intra.peff.net>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
 <20250207-b4-pks-path-drop-the-repository-v2-11-13cad3c11b8a@pks.im>
 <20250222072048.GA3096947@coredump.intra.peff.net>
 <xmqqr03n7218.fsf@gitster.g>
 <20250224221914.GA193356@coredump.intra.peff.net>
 <xmqqh64j3qkn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh64j3qkn.fsf@gitster.g>

On Mon, Feb 24, 2025 at 02:50:32PM -0800, Junio C Hamano wrote:

> I do not think timestamp_t is appropriate for rerere records,
> actually.  The reason why we have timestamp_t is for things like the
> author dates that can be arbitrarily and deliberately set to any
> historical times, e.g. long before the committer was born.
> 
> Unlike that, the timestamps we are dealing with with rerere records
> are the times on the filesystem when these rerere records were
> created and/or used so whatever stat() gives us for st_mtime
> (i.e. time_t) is a lot more appropriate.
> 
> I'd probably leave a #leftoverbits here; we should vet our use of
> timestamp_t to see if we are not overusing the type.  Roughly, the
> timestamps we may record in the commit and the tag objects should be
> timestamp_t, but the time we get from the filesystem and only
> compared with another timestamp the same way should use appropriate
> system-defined type, which is likely to be time_t, as not everybody
> may have struct timespec, and file expiration should not need
> nanoseconds precision.

Yes, I was going to suggest using time_t (or even timespec) consistently
here, but...I think it is a little trickier than that.

We will compare these mtimes not just with themselves, but with a cutoff
time that we get from the user, via repo_config_get_expiry_in_days().
And that's parsing lots of formats into a timestamp_t. So either we need
a parallel universe of functions that operate on time_t (to use for
things we expect to only interact with filesystem times), or at some
point we have to interact between time_t and timestamp_t.

I hope you'll agree that that the "parallel universe" direction is too
gross to contemplate. ;)

So the only question is how and when to convert from time_t to
timestamp_t. I think our general strategy for when has been "as soon as
possible" which makes sense to me (most of the code only has to deal
with our one type). So I think doing it right after the stat() here
makes sense.

The "how" should probably not be "do an implicit cast". We have checks
for overflow, etc, in gm_time_t(), though I'm not sure what the error
handling should be for a case like this (that function just calls die(),
which might not be ideal).

All of which is to say it might be a bit more than a #leftoverbits.

-Peff
