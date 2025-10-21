Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F20280024
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032204; cv=none; b=ti1wMYDqlY0HNyBN9cAbq6eyTOHoE/5gD8PapDFK/BS3+Od+C8mdEbQE7gGTvN2NJ3t03ASco1U6KFZoHICjRfWj5Ue4hdyhrEZWX3dloPFOgT3VZ2c3icWXeHPLRQsyckGldNlnTHHKJkaUi36udPwM+atSLcP2+h3VnTro0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032204; c=relaxed/simple;
	bh=TsWi6v0OwvLOgWX345WL23/KimqQPNniGs8wZc+3kpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUPNat9GQU+qtWxAzkJUeftMpYg/wc2Szwu+YdNOsh8ATbnFccf5O4/9li+lOV5wI9ZCGgkdVdNWyBKcT+dsji7FFRIE3ya8R40DOKY5ocXezav4zWwhSamYBWZvtyXPw4ZdWQJfdb1pCLG6+kKzdt8cP+oe7GdliTHlyyoFaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gl6E7s54; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gl6E7s54"
Received: (qmail 291740 invoked by uid 109); 21 Oct 2025 07:36:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TsWi6v0OwvLOgWX345WL23/KimqQPNniGs8wZc+3kpo=; b=gl6E7s54EWHKwssNRU2Z9OkeyQj47meV9BI1/o3c68j8yBXSeg+a0e8lz/MY0o0Cuqu080f2whol07v+LI6DdICkXXjdugOEINPnlpVm1nDcRhRY7RN2T3lr2I+DUv6OeAOMi+AnH1NZ4YjmZ2jAVoY2CfDVwLpfdR7OyAhq1BlZzOD8cK/+JGT9vwLVhWPepSgnKbQum0sD5QOLVmkNnIcfRBowvVf+UBmrC3a3n0CCDq0fHEUDFaLliH0PYyI7v4e1+7+MJIRizXgp/OmSPzMfCe6XVkruOOaEObMCW53bauAPgNzmwUISFEKtprLfkeB1NNqwjAtw83oOZAXZgA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Oct 2025 07:36:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 454549 invoked by uid 111); 21 Oct 2025 07:36:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Oct 2025 03:36:40 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 21 Oct 2025 03:36:40 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jake Zimmerman <jake@zimmerman.io>, Lidong Yan <yldhome2d2@gmail.com>,
	git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
Message-ID: <20251021073640.GB259661@coredump.intra.peff.net>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
 <20251017075153.GA4078773@coredump.intra.peff.net>
 <xmqq7bwt1kyf.fsf@gitster.g>
 <20251018094037.GA1060824@coredump.intra.peff.net>
 <xmqqh5vww7xa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5vww7xa.fsf@gitster.g>

On Sat, Oct 18, 2025 at 08:23:13AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure which of these you mean:
> >
> >   - Do we still need to call diff_flush_patch_quietly() directly below
> >     the hunk above, in diff_flush()?
> >
> >   - Do we still need the dry-run code at all?
> 
> Both.  We do not have to call flush_quietly() and can call the real
> thing with output disabled.  The dry-run bit was only added to
> implement the flush_quietly() variant.  If we lose the only caller
> to flush_quietly(), all of the supporting infrastructure can go.

It's not the only caller, though. b55e6d36eb added another earlier in
diff_flush(), to handle --name-status, etc (which was its original
goal). That code possibly remains broken, even with my patch, and
would wait either on Lidong's dry-run fixes, or lifting the /dev/null
into the flush_quietly() function.

> It concentrates only on the regression-fix aspect of the changes.
> Going forward, my preference is:
> 
>  * Apply your patch.  This is the base of the fix for 'maint' and
>    all branches.
> 
>  * As Lidong updates dry-run code by adding more "ah we are in
>    dry-run, so we should stop at the first change and se should be
>    silent" fixes, we can queue them on the 'master' front for the
>    preparation for a better future.  Note that the 'master' front
>    would contain your "In from_contents modes, run flush_quietly()
>    with output redirected to /dev/null".
> 
>  * Once we regain enough confidence for dry-run with the above
>    effort, we mark your "why not redirect to /dev/null for extra
>    protection?" code with NEEDSWORK comment to be removed after a
>    thorough code audit to ensure that dry-run is now sound.
> 
> And I do not mind if the NEEDSWORK comment stay there for extended
> period of time.

Yeah, that matched my thinking exactly.

But thinking on it more, I think the regression is slightly bigger than
I originally counted. My view was that:

  - the attempt to fix "-I" was incomplete but did not make anything
    worse there

  - that attempt also broke "--quiet"

So we should first un-break "--quiet" as simply as possible, and then
try to make the fix for "-I" more complete as a separate step. But I
think "-I" may actually have regressed, too, since it is subject to
printing the extra bogus output when trying to decide if the
content-diff is applicable, which it did not do before.

So really, the regression fix should probably cover both of them (which
it would if we move the /dev/null redirection into the flush_quietly()
variant).

-Peff
