Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0E3064B5
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381076; cv=none; b=jdZLdagW9TS+jJ/SHSoVHD6gKb7UgkwWmXMEaFvts6BDZIqG4ji05p33MTgONb/jCNM6zY8zpW7MGPkd0DI35dSPy6zrSsWEgNpSof/xJyauL+6VovDjfe4w2oWCJftClEZDcBMk7Cg1jNRh4/5BNBiVhrYUrqSpE1KlOyxkWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381076; c=relaxed/simple;
	bh=xTlA9jY5nHAEbFwvl8Dm9TPk64mQpVhUqWLnpvzg3w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRTQ8fPBdMbqL5HtbIcxENkAq4hfba1CGtfDQGDU79UBYSUOyckmune50lkfdXvRh48F2dqK+0Yx55Uk6UJd/9xSUANTAtNldRuie1gk0Gx/Ej71444zZ9519Nhh4LeEEsw+3YbqO+amF13S8ks15+Zbo5iQQaHvSMpQSvZMyho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ma9LTCU1; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ma9LTCU1"
Received: (qmail 30417 invoked by uid 106); 2 Jun 2026 06:17:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xTlA9jY5nHAEbFwvl8Dm9TPk64mQpVhUqWLnpvzg3w0=; b=Ma9LTCU10wJ+Qeae62HhWvvyJnAjLzHR9Vm1xgrXEuMXkoYNljFb8LMXccQnIAt9NuY7nImqXe2i6NyWNDORkzRoMmaZq+IlVmTQ/iaAbdycqXEA45IlyjJZ6WXmUYh5Z7xpV+eAbgz8FSGc+ZMD0x3Lr/mapiwQowWkOVtGxQMNO3hlq11y6L42ZJi4Do3pxGy1YMLVvoMfeQm3jDd5XDw35Tp8fuvuIJ3ITBtYx+uJRxrVQy2DYZpb6u3CSDVkfXY9Nui2mh/j7X5BI8WOLlS+5f+Nmat7crtCVLcvLW3pWklCmXN3HzxdJ171Wvvo+LkMiTyuo+SCyz1G/TJLVA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jun 2026 06:17:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 75711 invoked by uid 111); 2 Jun 2026 06:17:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Jun 2026 02:17:57 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Jun 2026 02:17:52 -0400
From: Jeff King <peff@peff.net>
To: Luna Schwalbe <dev@luna.gl>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: document and test `@` prefix for raw timestamps
Message-ID: <20260602061752.GA695568@coredump.intra.peff.net>
References: <20260601213944.645731-2-dev@luna.gl>
 <xmqqfr35zt6h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfr35zt6h.fsf@gitster.g>

On Tue, Jun 02, 2026 at 09:23:34AM +0900, Junio C Hamano wrote:

> > +    It is safer to prepend the `<unix-timestamp>` with `@`
> > +    (e.g., `@0 +0000`), which forces Git to interpret it as a raw
> > +    timestamp. This is required for values less than 100,000,000
> > +    (which have fewer than 9 digits) to avoid confusion with other
> > +    date formats (like `YYYYMMDD`).
> 
> Does this "additional paragraph" format correctly, instead of
> rendered as a literal block (typically typeset in typewriter font,
> monospace)?  Don't you need to do something like what is done for
> "ISO 8601::" that appears later in the same file?  I.e. lose the
> four-space indent and replace the blank line before it with a single
> '+' list continuation operator?

Yes, I think so. As a tip for contributors, running:

  cd Documentation
  ./doc-diff HEAD^ HEAD

is often good for seeing a rough approximation of the rendered doc. It
shows here that the result is incorrectly indented versus the rest of
the section.

Sadly it is somewhat limited in terms of typography, since it is diffing
the roff-rendered manpages. So you wouldn't realize that it is rendered
in a typewriter font, as you would if you looked at the html output.
Spot-checking the html is also a good thing to do when writing doc
patches.

-Peff
