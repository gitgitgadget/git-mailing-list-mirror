Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92E78F24
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735415072; cv=none; b=Eby9Wi8EHSdO72Mxnb39CzbWQV9NDoGNTNsy3JZrsgl/mYqG1UDNgTiUSQ7XLVc6zB9C/L0kO+YTIsbYMk/4Eybx+TuGa3VLKXhaCUF3HF7PI0RjeR206zesxUr7g7+VcpPCR7WysL3Ph8MD2GXnmpQ3oTq4n/HSoJKMUdKJ6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735415072; c=relaxed/simple;
	bh=Uc6g8ZBgR+56KlITsc3JH1tN2VD7y2TtJFEjYzvK7LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWe9V/kHhcKt3faa/gA1OwsbZ6NmDo+jNZLiIN+pQ9O4i1K1caT0ikF0LguNP7Ybdm5s9To8I0NY40u1bZXP+lXDQDimcQ1qClOU0vwXLh8XjdJ9dnsFN0yRDIDU76P+MsyXkM7QHA81vUs42r9JKvHVBRicXo4m9nBXYSb2wSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ULVUBA7O; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ULVUBA7O"
Received: (qmail 24863 invoked by uid 109); 28 Dec 2024 19:44:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Uc6g8ZBgR+56KlITsc3JH1tN2VD7y2TtJFEjYzvK7LY=; b=ULVUBA7OodpPIYDlfb7AEgSZduc2onFxGA5CvHhVXPO/1C8CG5ETokhVRdQmwo8peLRGgIeP7WuQWjqsgpflrNzTMTthhfmTGIRSDJ5t02zw2HVtbUIEQajex+qlPh6ml/J7o6sXFEugSzdX5fTNQZ5JYLwFhWg4yGmnsj1fKYOypKKlmS/MbMXAOaxVdb6ufDTOXetxEe5WMAdwPYCuUEPDFuo9s8fMyrhE1JrFmM+WtQSdR/qCmpEw+vVSJd20uO4mFVLwA0PwDBH6M9orQL8G/Cg5TFo3+uzt/CR+Z8QpRu+/bAV6tLEkzAegJJhBgQURTR7OQ3mtIiPURrLG9w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 28 Dec 2024 19:44:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30288 invoked by uid 111); 28 Dec 2024 19:44:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Dec 2024 14:44:29 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 28 Dec 2024 14:44:28 -0500
From: Jeff King <peff@peff.net>
To: Boomman <boomman37@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git gc does not clean tmp_pack* files
Message-ID: <20241228194428.GB1535629@coredump.intra.peff.net>
References: <CADMKT2-vsUUi-23YGexvxbW9wj0Br+cQcv34eStnw-0EDRiKMw@mail.gmail.com>
 <20241219054222.GA2310556@coredump.intra.peff.net>
 <CADMKT28cZcdW8UJ59vZHoMa0WEbyAccx4A10-jk3MiBkhZLxEg@mail.gmail.com>
 <xmqqmsgrncr6.fsf@gitster.g>
 <20241220090533.GC133148@coredump.intra.peff.net>
 <CADMKT2_QonR_XbZ5297Df34FrrTpbJp04Qy5BGjPb_Ov=uFF4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADMKT2_QonR_XbZ5297Df34FrrTpbJp04Qy5BGjPb_Ov=uFF4A@mail.gmail.com>

On Fri, Dec 20, 2024 at 05:17:50PM -0800, Boomman wrote:

> For me, two "git gc" on a same repo fail to run:
> fatal: gc is already running on machine 'WIN-blah' pid 40304 (use
> --force if not)
> 
> If you're already colliding on this, then I don't see why you can't
> use a normal looking name without a randomized string like
> "tmp_garbagecollecting", so that each execution would at least
> overwrite the same location. In this case --force could append _1
> probably.

git-gc is not the only thing that writes packs. There might be
simultaneous packs written by incoming pushes or fetches, for example.

-Peff
