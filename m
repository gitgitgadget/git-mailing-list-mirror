Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B22367BA
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753773299; cv=none; b=U4fwI2YY+FCNJ27ztCxCCkIHjTwIEmc01jcfAZvfO5IfruuZ3h0jo2iJOyGJ9rEX5Sv+JaYYf6YVQPUJmuZeIq211/GDxr6Z0313y/TnBCoxTSG67lFB1zjiOIAxmxWISt95HiYhjabx6cf0V41v0DXIotdrXmeKQpYkWTKr9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753773299; c=relaxed/simple;
	bh=nN3ZeRwYAVVdGncqoru0s/Hi9XkPH/P/Dsz6o5s4hbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhArnpEM5bxqXAxi4zJ0l4ZgSZFrCjehtbv9I7EWBU+8iD15BOpgMRL7TUJRuu4VxwUPauLadUwWAYsO7Y+wJppicDQPmD4g60K1bbuJiQySjICzlmjSNNaeBA/RVWU4uabZhWuSNrnZ0rQrG7bV69WUj7pkv28h4pTI12Tbxf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=O3dcbEvx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="O3dcbEvx"
Received: (qmail 2066 invoked by uid 109); 29 Jul 2025 07:14:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=nN3ZeRwYAVVdGncqoru0s/Hi9XkPH/P/Dsz6o5s4hbA=; b=O3dcbEvxyt2KgegGIk0e3xZYl9oRrcOBXBd7f9FG4ic3Ezm/p5aHSVGZdQFyIu69KcJoxKIhe68ad1yCq1BNyFSp4MFE4j/wCdt7Yr8M5KnTtThwNKO98xmLEVuNNDH/ZgaIz3Yg7IOBa9vzGMYeU92MR+G4/jw2I2pcx5f3RdgaJZ4Y4OZiR9bzQTObrAZ1K3cw6SXey6wDrNZFBgwLZLqwdigX8KKaouxsTn+4e1koEZBazWCkWOf723pfoQTP5BmM339iI10bxOcAxGCevKq7D7JLL0OvcP8V8hjsXlWH2dd1Xju0WFtJsgAmvvjFoIyWdnyjQPAj+Pk4CwkO8w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Jul 2025 07:14:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30416 invoked by uid 111); 29 Jul 2025 07:15:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jul 2025 03:15:00 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Jul 2025 03:14:55 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 7/8] refs: stop unsetting REF_HAVE_OLD for log-only
 updates
Message-ID: <20250729071455.GB1426859@coredump.intra.peff.net>
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
 <20250725-pks-reflog-append-v2-7-e4e7cbe3f578@pks.im>
 <20250725113610.GA3015361@coredump.intra.peff.net>
 <aIeMgE-11UnAJINI@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIeMgE-11UnAJINI@pks.im>

On Mon, Jul 28, 2025 at 04:43:12PM +0200, Patrick Steinhardt wrote:

> > > @@ -2508,8 +2507,9 @@ static enum ref_transaction_error check_old_oid(struct ref_update *update,
> > >  						struct object_id *oid,
> > >  						struct strbuf *err)
> > >  {
> > > -	if (!(update->flags & REF_HAVE_OLD) ||
> > > -		   oideq(oid, &update->old_oid))
> > > +	if (update->flags & REF_LOG_ONLY ||
> > > +	    !(update->flags & REF_HAVE_OLD) ||
> > > +	    oideq(oid, &update->old_oid))
> > >  		return 0;
> > >  
> > >  	if (is_null_oid(&update->old_oid)) {
> > 
> > Which make sense to me. But the weird thing I noticed is that when we do
> > something similar for split_head_update(), we don't strip REF_HAVE_OLD!
> 
> And we shouldn't do that, as in the next commit we actually build on
> always having `REF_HAVE_OLD` set for reflog-only updates. So I'd argue
> that the problem is actually the other way round: when splitting off the
> HEAD update we must resolve the old object ID if `REF_HAVE_OLD` is not
> set.

Yeah, I agree that after your patches, split_head_update() should
definitely not be clearing that flag. What I more meant was: this patch
is introducing a behavior change for those split HEAD updates, which
used to do the extra old-oid check but now won't (whereas for other
symref log-only updates, you are preserving the behavior).

I _think_ that's a reasonable thing, but I wanted to make sure.

However...

> > (For those not familiar with that

...did you mean to write more? I know you've been running into weird
email truncation issues lately.

-Peff
