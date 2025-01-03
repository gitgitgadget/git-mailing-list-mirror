Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034228F66
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931229; cv=none; b=muGuOT5VYfTRru6jh6Qq7hMXKl7JvAlg3EGJeNTPwLLqzdhX0O4sovTcRTSfZbjrpv3xMDM15pNvx5XYl9dLTkIGzwXg4Qa6Rv8QUc40zk5qxwynAleChpEOisTWSGH9O8ceKL6kEqjoLUTssoP+MUgGHPf833M2FBozTDbJ2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931229; c=relaxed/simple;
	bh=jKAeJR8b4eY+3cSMHoDIN2Yb3p9DV4YKAtOnL8UsPcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuHeB2tOPO1iGkFQL8LiMpM5bUmOWkXMKgwuBNkDOBQqhVqJAzlayWEDMIMWw6wFwluotY8+nrji5SNZNhzVfGbH/7apMSD3Hg+Gwahk6qwaR+1980FZ79GQV6HtUC0JdORzqlDmjGTPUZi8aWUjl1zEqvxBISoE4AVrw0Nbs3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZKsJ4C/0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZKsJ4C/0"
Received: (qmail 18492 invoked by uid 109); 3 Jan 2025 19:07:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jKAeJR8b4eY+3cSMHoDIN2Yb3p9DV4YKAtOnL8UsPcg=; b=ZKsJ4C/0JxfIKXoiLrVOUhB186OrIp7AREiGKj4drAnqU0ksUbhmf1vo0u+D09rAw1WZpOD+Lvzuv+QgmIEScQDG0siwqUb0pNqdKsHTiX+KhFya1UL1tSgRhjqcwghO4LVn4OjXECFwBl0Lj4nMs1S1YP7AFGp8+nXOe0upj3DgBbg/iiATek0DNQvkyBlXh4vjcl59+o+c6zEnfEbzLnAAM8Rb4ay2CVVQQkV9DtTQxHWFDfrjOoZ4Uc8wFAukPXJHZ9XlMzeCuSaM3ndlsnO/qXOJKuV8AioUFYsBWfP4GXK6HyC6pTETXgQUsmcuQyDUkkLMr7GtfvEgWEMegg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Jan 2025 19:07:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4104 invoked by uid 111); 3 Jan 2025 19:06:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jan 2025 14:06:59 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jan 2025 14:06:59 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/10] github: convert all Linux jobs to be containerized
Message-ID: <20250103190659.GC3208749@coredump.intra.peff.net>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
 <20250103-b4-pks-ci-fixes-v1-4-a9bb95dff833@pks.im>
 <20250103185640.GA3208749@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103185640.GA3208749@coredump.intra.peff.net>

On Fri, Jan 03, 2025 at 01:56:40PM -0500, Jeff King wrote:

> I do wonder if it will affect run times. Presumably GitHub has made it
> pretty fast to get things started on the bare runner image. Now we're
> pulling docker images. That is hopefully pretty optimized and cached,
> but it is extra work. Might be worth measuring.

Just peeking at your CI run here:

  https://github.com/git/git/actions/runs/12597967146

versus the latest run on Junio's master:

  https://github.com/git/git/actions/runs/12589300693

I see:

  job                 |  old | new
  --------------------|------|------
  linux-TEST-vars      11m30s 10m54s
  linux-asan-ubsan     30m26s 31m14s
  linux-gcc             9m47s 10m6s
  linux-gcc-default     9m47s  9m41s
  linux-leaks          25m50s 25m21s
  linux-meson          10m36s 10m41s
  linux-reftable       10m25s 10m23s
  linux-reftable-leaks 27m18s 27m28s
  linux-sha256          9m54s 10m31s

So it looks like any change is lost in the noise (sha256 is noticeably
slower, but most jobs aren't, and some are even faster).

-Peff
