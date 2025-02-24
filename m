Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490785383
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435565; cv=none; b=d9/qfzuyuLk8QqgQ0EINWJ5AMu5w1jldkfv6g5R1Iy2UKbHr0KTV78DgQXAWi7TuDv711pcYyJyq7NKNt0R4Ik8a6HlHOj+QPBy+dRrO4bd/klcj6wRB3/og24A15oNcVbxo8MJ4DUI+LH3QRJ5Z+7Bt7JF+jr/LfhUYPuoCZuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435565; c=relaxed/simple;
	bh=foH5iU6oUT7/UAd6Y/kvyHSAvVCq4ffHNAWZJgtH0sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INamNWYd5TvxYpTr1ani8VukgYa7BafhCQtqZBGGIN0ixQc4aNCJ5F0Aob5tnf97kzLd0pF+XPTGG/Fxl0X5OcVboBKuLw1AnTwsBOEEzV79xPmX//HM9OkM/JvNHKLkAHVumu7W0crZ3DpsP1/5E7VP9W0CkhPQC48N2SXmha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RvXGxio4; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RvXGxio4"
Received: (qmail 20585 invoked by uid 109); 24 Feb 2025 22:19:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=foH5iU6oUT7/UAd6Y/kvyHSAvVCq4ffHNAWZJgtH0sg=; b=RvXGxio4YUhWtOBrPWKJRcSCfk3Zfi3Z/TBhNfMj8TWpOkXes3qb/pyddZzEldGFiBWdCE3FZHQxH6LUgmnDJBnXooQpBocVDfVFGp/hefOHw2HcqqLdjkgzbklhD0xfEv7MOt44fsNw9FGMSGaG/uOAR8nOeoQicKDrQ5ZSagZXNQdIw9Vr6dVC6rTYoOrKud4OZLce1DNO3cVw6ePp/KJCMqoHCJHcbB0Y50fpK7n379Gm08c1qdUmtXsHHUlT0aV86LqEf9mGV5e+XV1geRzhquwhGpInIxeqZULHc8EXQ1yAEnQceQhphXzfSdzSP10EofV77knmFkt2ESBfrQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Feb 2025 22:19:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29570 invoked by uid 111); 24 Feb 2025 22:19:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Feb 2025 17:19:15 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Feb 2025 17:19:14 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v2 11/16] rerere: let `rerere_path()` write paths into a
 caller-provided buffer
Message-ID: <20250224221914.GA193356@coredump.intra.peff.net>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
 <20250207-b4-pks-path-drop-the-repository-v2-11-13cad3c11b8a@pks.im>
 <20250222072048.GA3096947@coredump.intra.peff.net>
 <xmqqr03n7218.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr03n7218.fsf@gitster.g>

On Mon, Feb 24, 2025 at 08:14:43AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Feb 07, 2025 at 12:03:36PM +0100, Patrick Steinhardt wrote:
> >
> >>  static timestamp_t rerere_last_used_at(struct rerere_id *id)
> >>  {
> >> +	struct strbuf buf = STRBUF_INIT;
> >>  	struct stat st;
> >> +	int ret;
> >> +
> >> +	ret = stat(rerere_path(&buf, id, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
> >>  
> >> -	return stat(rerere_path(id, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
> >> +	strbuf_release(&buf);
> >> +	return ret;
> >>  }
> >
> > This "int ret" should surely be a timestamp_t, no?
> >
> > -Peff
> 
> Indeeeeeed.  Thanks for a careful reading.

Less reading, and more merge resolution. ;) (I had a similar series to
Patrick's that was half-done from a few months ago).

I see you added a fixup! to the topic. Note that rerere_created_at()
needs the same treatment, too.

One side note: using timestamp_t here should get us the same behavior
that the original had before this patch. But I'm not sure the original
was entirely correct. st_mtime is a time_t, so we are assuming the
implicit cast is OK. Our timestamp_t tries to be at least as long as
time_t, so I think we are OK for the future. For very old timestamps, it
is probably wrong (since time_t is usually signed, and timestamp_t is
not yet).

It's mostly academic, though, unless your filesystem has rerere files
before 1970. So I think we can probably just ignore it (and I do still
hope eventually to support negative values with timestamp_t).

-Peff
