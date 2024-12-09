Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB40B66E
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733710561; cv=none; b=ToRP5E3r9h0xkeLQuh2LeI7J+FTDwzB2YIYgv6XsdJntBeaajQ9OFvnrCGJTGp66O1OdVpTpFsfA2sck19hg81vLY4Un/G8b19JKxgsIIbVEjZflAimG/pidwiqzLlCnHU9m2owPIkqFaiHPFbcuPB1ONNJ1HhqGq/EwfgSP7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733710561; c=relaxed/simple;
	bh=vXK2Z5cKsxAlsiU6XXmMc49UTCl+Y/mfZeL/1P4h6Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5WUOKXf9OX+fTxcX6tM5Y/0mMFaHP456q9NnNfh71ZUF1xf2DrFB1qYRTEuq/fzzN6uis/WIOgmTikQalx/ojk+V0VFvKS/d2qeSlpVMEeeXdCHjy9JyCdHQB4SY8GWi63C3vyEMjkZBjwy90y4q4XP3vi12WMEpBf2wWdqTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=b8I9uNll; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="b8I9uNll"
Received: (qmail 16879 invoked by uid 109); 9 Dec 2024 02:15:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=vXK2Z5cKsxAlsiU6XXmMc49UTCl+Y/mfZeL/1P4h6Ss=; b=b8I9uNllxXTFeVTQ28BgYCUGAWZuslwFQFx4We1NhuXkQTEKj5z+p+I1wtxCEG+hp0yFSN5F1FEcZj4o74I18QxOvT6XYH5Wuy/tksoObbs9NBKUnOrc/iruO709M1l8yS1Ia1gk31npDaVvko5YsfyQwan/3IRBA+YbaB/spMUq6K/SL18zpANwZxUl8VAs30uZIzVRegKLeeicb84e786b5evlSvzjmfw3Sr099bGSGDok4us1aAEwEUNMuaRQNmq2NXWtPbF+47McXoGW+87iQwYVq5d6BjJdEpxrveonYpcn+6HolGi47mP8721AFnGZMFvQTmVrbs2duYY9jA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Dec 2024 02:15:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21448 invoked by uid 111); 9 Dec 2024 02:15:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 08 Dec 2024 21:15:56 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 8 Dec 2024 21:15:56 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically initialized
 vector
Message-ID: <20241209021556.GA1293399@coredump.intra.peff.net>
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
 <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
 <xmqqwmgf3nf3.fsf@gitster.g>
 <c949fea0-817b-45f9-b8b2-55e1cb55e915@gmail.com>
 <4e60eedc-e4d9-423c-b2e7-f1c65bccc254@gmail.com>
 <xmqqser33ga6.fsf@gitster.g>
 <xmqqy10pprnp.fsf@gitster.g>
 <xmqqttbdprj0.fsf@gitster.g>
 <xmqqikrtpqkb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqikrtpqkb.fsf@gitster.g>

On Mon, Dec 09, 2024 at 10:56:20AM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >>> Rubén Justo <rjusto@gmail.com> writes:
> >>>
> >>>>> ...
> >>>>> Sorry.  I'll re-roll later today.
> >>>
> >>> No need to say "sorry".  Thanks for quickly reacting and starting to
> >>> work on it.
> >>
> >> Any progress?
> >>
> >> Thanks.
> >
> > Sorry, you did send and I did queue v3.
> 
> ... and it seems to be causing problems, I didn't look very deep,
> but it looks similar to what I reported for the earlier round.

I think it is this off-by-one:

diff --git a/strvec.c b/strvec.c
index 62283fcef2..d67596e571 100644
--- a/strvec.c
+++ b/strvec.c
@@ -66,7 +66,7 @@ void strvec_splice(struct strvec *array, size_t idx, size_t len,
 			array->v = NULL;
 		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
 			   array->alloc);
-		array->v[array->nr + (replacement_len - len) + 1] = NULL;
+		array->v[array->nr + (replacement_len - len)] = NULL;
 	}
 	for (size_t i = 0; i < len; i++)
 		free((char *)array->v[idx + i]);

We allocate with "+1" to account for the NULL, but when we index to
assign the slot, we count from 0.

Or more concretely for the test case, we are adding 1 replacement item
to a 0-element array, and the result will have 1 item. So we allocate
2 slots, and slot 1 is the NULL.

-Peff
