Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058DA846F
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760073165; cv=none; b=aEcPT3VTmRFMBFixcJFJS9yecEt8s/w1oobME1XH0oqiGoENMj/ND88JudrBtQj7uNzW2P0Y+fx8S0/ctnzcsmYQs7EnNDFPnCHssh1kfZELoZ5DEIlHJfHt2R03k6gArxGaDqfzw/cR6qna5oTWJk/bbShAPVh1BdHrJz5xaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760073165; c=relaxed/simple;
	bh=qnjjXTIzjZCsyS5tvpWLekPcsgcN7G4VZKMjMrtg6jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWH8z2ckq4ZfBkWMPVq6lIaOhc4IQsjcIuTV3AsuXXB4lXduOFIJE3eXXz8W+RJUXUl+MKUV2h5pYr4K5PfwO2nIg+Nb4gy4gQDZY6fsNQ2cIIDTLJ0OEGRYyELE2P0MFlizwQQkxBia5L/GBXFVDTkZ50WnDmRz8YDBK6h/NNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LjDJpsYd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LjDJpsYd"
Received: (qmail 181920 invoked by uid 109); 10 Oct 2025 05:12:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qnjjXTIzjZCsyS5tvpWLekPcsgcN7G4VZKMjMrtg6jg=; b=LjDJpsYdE4u/DJ1XcvnOiazylSqkFVDbrG1YaSIr7lE/smwB+lW6yvI/0IopH0BS+r2AVy6RfLBwC+P3VZ2h/P1F5C2zx6w9whWm/oJ/xuWjVTebK0Ghim3R3iM2/1ADiePGgDVZfJ2/8Cv4KJ7BmlsStESxtgPwv4NADF/ibEQvsUPdfkTipUhcfIsCobedw3zvDxaAU4h3ePYBZUbA7Nt2t39x3XTHilCPv4jWzPmaqMg8Md6/m1UrmR8mqV4FcmS3q0X97H79+NIsJdt8uhiHvS5Y3BudvmY3XIQDIdIhY4cuSVMLZwYvKJ2poGRJeynt/91CN9gXAHMt2uyUgg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 05:12:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 282747 invoked by uid 111); 10 Oct 2025 05:12:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 01:12:42 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 01:12:42 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/14] refs: improvements and fixes for peeling tags
Message-ID: <20251010051242.GC1897715@coredump.intra.peff.net>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
 <20251009053825.GB1614343@coredump.intra.peff.net>
 <aOdRsR-k77uTWJRb@pks.im>
 <20251009063956.GA1622884@coredump.intra.peff.net>
 <aOdjM8F6WvTEBIo_@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOdjM8F6WvTEBIo_@pks.im>

On Thu, Oct 09, 2025 at 09:24:35AM +0200, Patrick Steinhardt wrote:

> > I am not so much arguing that "struct reference" is misnamed, as that it
> > is sufficiently generic that people will reach for it when it is not the
> > appropriate tool. It is for passing the ref data to the iterator
> > callback, but it probably doesn't make sense in other contexts. Would we
> > ever expect anybody to declare their own "struct reference" in a local
> > function? I don't think so.
> 
> Hm. The thing is: if `struct reference` is established in our code base,
> and if it is a simple representation of a reference, then I think it
> might even be a good thing to having it. I could for example see that we
> gain more interfaces over time that use it.
> 
> For example, functions like `refs_read_ref()` could totally be adapted
> to use the same struct, and I would claim that this is a good thing.
> We'd basically have a single central structure that allows us to get a
> reference out of the "refs" subsystem with metadata.

I agree that if it became the standard representation, then having the
generic name would be good. I guess I'm just skeptical that it will
become/remain that, and not grow gross appendages like the fetch/push
status fields of "struct ref". But maybe I am just too pessimistic. ;)

I do agree that it would be nice for refs_read_ref() and other refstore
functions to use this as a common type for returning results. Even if it
later gained more fields that were specific to the ref subsystem, they'd
still make sense in that context.

So I dunno. I could go either way (keeping your series as-is, or using a
new name).

> > And yes, "struct ref" suffers somewhat from the same problem. It is
> > mostly about using refs in one specific space, but the name does not
> > really help clarify that. I wouldn't mind seeing that improved, but yes,
> > it would be a noisy patch. I don't know if remote_ref is the right name,
> > though (the "peer_ref" links mean we store both local and remote refs in
> > it, IIRC).
> 
> If we decide to do it it should definitely be a standalone patch (or
> patch series). I'm also open for different naming suggestions, but for
> now this is the best I could come up with.

That makes sense. The only reason to touch it here would be if we wanted
to free up the name "struct ref" to use right now. I think that is a
better name than "struct reference", but given all of the existing uses
of "struct ref", it is probably not worth the hassle to switch now.

-Peff
