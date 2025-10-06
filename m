Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254C834BA36
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 00:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759711612; cv=none; b=VhQ43PEeuxLxpOULtHGM7LCqHBtn2N54KuRiTsrI+98hcOkUPVPtLeAF7MTaD3FcKesJEQl6fqaU09vk3pEFHQnLvhjcnRv7gdbSOZkwMskcly9vV8J0mQD18i+u9vs2MBPSgDE4v6RPVE/7/kRpg4FXsNFa452/9Iqtumq3uxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759711612; c=relaxed/simple;
	bh=DukFEuhZprX8JeDhsGhkzNeTzHDxTKxPlWkMl/w+dOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W95DPS5+ekrXiSChBOafK1vH/bSb37ovdRWc8qqhZNGxfQ4uANBfBkOiwdN90h0fIh7HrUFBDCXVgDQy4Yr5LmXmc2hrYKx3YaONsw00mUCGnSH9vDSn/Yg1I5B5UuHoYxZE/6DG8tSK/tFBozIVpcKtnFEdLj9zbtW06MmNibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MTTqfE0Q; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MTTqfE0Q"
Received: (qmail 140148 invoked by uid 109); 6 Oct 2025 00:46:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DukFEuhZprX8JeDhsGhkzNeTzHDxTKxPlWkMl/w+dOM=; b=MTTqfE0Q82YD0RMK6fzCgXFMm7xpAlZIdNvpWX2LDvXpPVTSNOJye/tZHYGtU2ciDSbaQrARurRXsW3+BEr+0b72LGWYGezaEmfliD32NGzXZ82s3ZXqZJkhaKwLtnqRX3H7rSNfWeOfKbnJbj353yvhQn7gywiJFUSwrzuU2WJM0fNtBDs/W3Znw3rXM9H0LMLA+kkS+yimwE3ctyuQ+M2ICRr1+ijLeEeRfYwrnQIdg/Mi3Emk3+kNWcCLvjQA1wR1cjEAdeFWb9UtBbuoXVHhMqhMDLNvO+eKJ/epACTWF8RtxJpPtyEKAl7m1JiZ0gINCCPlJCY9Xx1AiWIKuA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Oct 2025 00:46:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 209640 invoked by uid 111); 6 Oct 2025 00:46:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Oct 2025 20:46:40 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 5 Oct 2025 20:46:39 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Han Young <hanyang.tony@bytedance.com>, git@vger.kernel.org,
	karthik.188@gmail.com, ps@pks.im,
	Han Young <hanyoung@protonmail.com>, Sigma <git@sigma-star.io>
Subject: Re: [PATCH v=2 1/1] files-backend: check symref name before update
Message-ID: <20251006004639.GA1462753@coredump.intra.peff.net>
References: <20251004144223.23436-1-hanyang.tony@bytedance.com>
 <20251004144223.23436-2-hanyang.tony@bytedance.com>
 <xmqq347xrp5o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq347xrp5o.fsf@gitster.g>

On Sun, Oct 05, 2025 at 02:53:39PM -0700, Junio C Hamano wrote:

> Han Young <hanyang.tony@bytedance.com> writes:
> 
> > From: Han Young <hanyoung@protonmail.com>
> >
> > In the ref files backend, the symbolic reference name is not checked
> > before an update. This could cause reference and lock files to be created
> > outside the refs/ directory. Validate the reference before adding it to
> > the ref update transaction.
> 
> This leaves the readers wondering why refname_is_safe(), which has
> no direct callers other than "git show-ref verify", is sufficient
> for the purpose of this particular validation.  All other callers of
> refname_is_safe() seem to use it only as a sanity check combined
> with other criteria.
> 
> For example, refs.c::transaction_refname_valid() calls
> refname_is_safe() as a small part of its validation, together with
> check_refname_format().  It also refuses to touch anything that
> satisfies is_pseudo_ref().

Yes, if we wanted to add a check here, it should be doing the usual
check for a syntactically valid refname and falling back to
refname_is_safe() only for deletions.

But I'm not sure if this check is that valuable. We are in
split_symref_update(), which takes an update to some symref and splits
it into an update to that symref's reflog and a real update to the
underlying target ref. So we are not checking input to the transaction
here, but the existing state of the symref on disk. And in theory we
should have checked that target already when we wrote it.

Do we want to check it again? I dunno. I can see an argument for being
overly paranoid (garbage snuck in somehow, but we prefer not to act on
it). We do already check sanity within resolve_ref_unsafe(), for
example.

I do think there are also some gaps in our symref target checks (as well
as a few other spots). I have a series to fix those that just needs a
little bit of polishing, and hopefully can send out this coming week.

> > diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> > index 0503a64d3..1dc314474 100755
> > --- a/t/t7102-reset.sh
> > +++ b/t/t7102-reset.sh
> > @@ -634,4 +634,12 @@ test_expect_success 'reset handles --end-of-options' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'reset should fail when HEAD is corrupt' '
> > +	head=$(cat .git/HEAD) &&
> > +	hex=$(git log -1 --format="%h") &&
> > +	echo "ref: refs/../foo" > .git/HEAD &&
> > +	test_must_fail git reset $hex &&
> > +	echo $head > .git/HEAD
> > +'

This test won't work against the reftable backend.

-Peff
