Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6031EA7D2
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759992000; cv=none; b=K4ds+q9W1+B+eTe4Il5VtBjQ/4/htyMFaxoekgRzPyqn4PLHXMtPylUHhGjbERioY5Sq7REgSa7srOuOvXNZaeSBcdkfPRh/GJN3RrQFbRDdEXge8mtqFupq7sFYCQta9cmcyJzV2+8tTjLy2dIoRDCbHmFgPrF1LQIeX4Ycjlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759992000; c=relaxed/simple;
	bh=6d8JId6/QMmpwRUnVsJt8WIpZB0rCad0mtbqRijm97w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlRROyRt78RsEwiI0YAgv1OF8c+VfR8JTnqeRq/xNxTM213xkz8wNkx38jmiYTep8qKk/PWvDonZJeJeR1/f6WENJ3UkMD21owRzpiXeG8bWWZYRTZ1EFi+g1uK9XqwkT0FeiyAtpEKJU6RQdVO9amqktyyfVacJEi+iHgfnHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ESDIiiCt; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ESDIiiCt"
Received: (qmail 174824 invoked by uid 109); 9 Oct 2025 06:39:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6d8JId6/QMmpwRUnVsJt8WIpZB0rCad0mtbqRijm97w=; b=ESDIiiCt6dcBwrta+yldjXiFBFjgqzH6jJZnawsoUMzheGSdrW+Quo9IGeiInPvfTi9aVDL1QV2qkZ2cDe4VxeyJVll+/gkeYTQBYXk3S+qS07RZ6GlhKX0Ysd5x7PGRrEq4BYqCL9d9CFVptz0EKAkSToi8EjUv2uw6jmU5+st343IWEcDBw6hy0/0oPbKQX8KrTr8bYq12qdw66cZjOYUbvTfeyGQIFT3LJQBMWvAL97qWfo4uHNgkgUWhqaVrDGyb48rZpmYgS3/tC2aOuuN9gX3xj3hJc0g2lt+lOWqbDVU9bOmFa/bT2UHqx1zibxofFuSL8Yn/beirycqkFQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Oct 2025 06:39:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 266310 invoked by uid 111); 9 Oct 2025 06:39:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Oct 2025 02:39:56 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Oct 2025 02:39:56 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/14] refs: improvements and fixes for peeling tags
Message-ID: <20251009063956.GA1622884@coredump.intra.peff.net>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
 <20251009053825.GB1614343@coredump.intra.peff.net>
 <aOdRsR-k77uTWJRb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOdRsR-k77uTWJRb@pks.im>

On Thu, Oct 09, 2025 at 08:09:53AM +0200, Patrick Steinhardt wrote:

> > I do have one minor complaint, though: the name of that struct. I have a
> > feeling that the name "struct reference" may cause confusion down the
> > road because it's so generic, and because "references" and "refs" are so
> > common in the code. From the names, when would I know when to use
> > "struct reference" and when "struct ref"?
> > 
> > Could we give it a name that ties it to the iteration interface?
> > Something like iterated_ref, each_ref_data, etc?
> > 
> > I know this is minor (and will be annoying to adjust your series), but
> > I'd rather raise the point now than realize later that it's confusing
> > and try to change it then.
> 
> It is puzzling indeed. I would claim that in this case it is not `struct
> reference` that is misnamed: what it contains is as close as you get to
> a representation of a reference. It's rather `struct ref` that is
> misnamed, as it carries a lot of data that is only valid in the context
> of a remote.
> 
> Another approach could thus be to rename `struct ref` to `struct
> remote_ref`, which I would claim would be a clear win for better semantics.
> It's used in lots of places though, which is a valid counter argument.

I am not so much arguing that "struct reference" is misnamed, as that it
is sufficiently generic that people will reach for it when it is not the
appropriate tool. It is for passing the ref data to the iterator
callback, but it probably doesn't make sense in other contexts. Would we
ever expect anybody to declare their own "struct reference" in a local
function? I don't think so.

And yes, "struct ref" suffers somewhat from the same problem. It is
mostly about using refs in one specific space, but the name does not
really help clarify that. I wouldn't mind seeing that improved, but yes,
it would be a noisy patch. I don't know if remote_ref is the right name,
though (the "peer_ref" links mean we store both local and remote refs in
it, IIRC).

-Peff
