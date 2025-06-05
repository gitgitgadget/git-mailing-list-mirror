Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773928E17
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749163823; cv=none; b=M4KK7bIRvCqRqhk8Ha1ykkGMe5hpTSz/oQSPHj/p0k2Art1OUvxTA0nfzWze5LaAOWG3nnJXXveusFT1cXl+RfLhZyCR+CC+DOW5a8ohtLTDamvV0xdkGrMcH+NP3KG7km1Y40fnQjrd/9tk4v3hKoDL+4eTi6wxmA5wtla+4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749163823; c=relaxed/simple;
	bh=CJpuFt5AcZO6Du0SoRlpUp7KHyhizKKm0+O1ADFCRe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhXLFqWQtJd1AW16R3aSjWQh0hdMOwJ/9bUOTDueEgqPvYHI8KnTNQmT1imv4gTkA/qZkqhMS83Qww+TX+LeuiNDcXiMEJq7NvHNZFNZnX+z3/lw5tDls1JBLVFrJTHTG/vgmP7sUE4XEs/ahqmmnJaVKaC3CRrHL5kkNToM1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gph7TvKY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gph7TvKY"
Received: (qmail 23815 invoked by uid 109); 5 Jun 2025 22:50:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CJpuFt5AcZO6Du0SoRlpUp7KHyhizKKm0+O1ADFCRe4=; b=gph7TvKY6Bn+lWyVVHlITaLbryI7xw1bzWhUXnM7aoyZq+9hzd1mfyLmuYyRC6VyZGYGNk3O4EiG9DzcY8pqz0gZaWXYz3Qci31UycysWwuxNvxShHAfrPZxZ68dGmzU/I+b210TZpdzGgi5VuBIWOWydpa/oBRjy8aLnkDQpRpRiGg/RmmLgbyNbH4X6rKiCuIa/fcxw7RlQGuqVzeAJHJkZ3ecJ8rD3eLTdzmUFK24ZuDXzcsfRD/TYVz8um7ZRaxZ4JtMbZOegQJNrBISDXkgDExblWV1t8OofxwgezxD+ACzSDul6XgNnI/gRfT/u7Fv35we8nFkxs+tf7tVqg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Jun 2025 22:50:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32392 invoked by uid 111); 5 Jun 2025 22:50:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Jun 2025 18:50:22 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Jun 2025 18:50:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Aditya Garg <gargaditya08@live.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v12 02/10] imap-send: add support for OAuth2.0
 authentication
Message-ID: <20250605225019.GC3005733@coredump.intra.peff.net>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D1C148578224A02B9773B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250605080002.GA2998537@coredump.intra.peff.net>
 <xmqq34ce9mql.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34ce9mql.fsf@gitster.g>

On Thu, Jun 05, 2025 at 09:28:18AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Jun 02, 2025 at 04:29:33PM +0530, Aditya Garg wrote:
> >
> >> @@ -1405,7 +1558,11 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
> >>  
> >>  	server_fill_credential(srvc, cred);
> >>  	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
> >> -	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
> >> +
> >> +	if (!srvc->auth_method ||
> >> +	    strcmp(srvc->auth_method, "XOAUTH2") ||
> >> +	    strcmp(srvc->auth_method, "OAUTHBEARER"))
> >> +		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
> >
> > Coverity complains that this "if" will always be true, since one of the
> > strcmp() calls must return non-zero (srvc->auth_method cannot match both
> > strings!).
> >
> > I'm not sure what the logic is supposed to be here. If we are matching
> > either string, it should be !strcmp() for both. If we want to match
> > neither, then it should be &&, not ||.
> 
> "If XOAUTH2 or OAUTHBEARER, use the password" sounds somewhat
> strange (unless the bearer token is stored in .pass and passed as if
> it is a password).
> 
> "Unless XOAUTH2 or OAUTHBEARER, use the password" sounds even more
> strange.  What about other methods that are not a plain simple
> password authentication?  Will we remember extending this code when
> we add yet another one to exclude it like XOAUTH2 and OAUTHBEARER
> are excluded with this patch?

That was my gut feeling, but I confess to not engaging my brain and was
just relaying the coverity message before logging off for the day. ;)

-Peff
