Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9521397
	for <git@vger.kernel.org>; Fri,  8 May 2026 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778198983; cv=none; b=jwlhaUNuOje8K+iSEtLvDz7VL5aJULxOZNlHJ52DB47y/pvkAgoEJ40PH5sDfcMW96npG/Pt0bS0Nlsqm9vqxv7K73jTIj4yKpLfPFaqUsylxw48DHq0F3ffCA9TAfKWJTRFb5rZa5k6NDg91komA71hvcGvifE+y8OuWd2+spo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778198983; c=relaxed/simple;
	bh=9jcAzDGWGiscJzQgQj8PyRWlk1SSnHQ+QDdyHhVSakU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ex2ac2V0qCfc9biOCNXa/E4VXOKuV8Yh5OA+gaUIpPEMUzVVoNS6PIMZ6YL3yRwq1RjnhioFRTJSw3Dff1TmSjgTRg5uxN5swFTOwZRbfHrqYzmX54MkrtP9z8+SIYTmsBVNb0Zv3NtO42ZZesQxKG6vufkDPBn5TS+bTXHcKGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=iCFzryMa; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="iCFzryMa"
Date: Fri, 8 May 2026 02:09:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1778198972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/Dpx76MlPZaQZWNKwvjid7CxUGwgtPXickuetA3678=;
	b=iCFzryMaVuNMCKQhCmV5n32FrS95Hf4kA8aGNgri0C0DCJiWRAGUkeK+9mh0zxPKRlNVf7
	CLf8uzS9SPBcn05rhtcO1YcyfBv3n15/I6wLpSYA77HtxTnfAcjPT+6zVM43r3sW+iseib
	5wb0wQtzdhsB0hah/Ip6DCwrInQT7fleJIWG0K9PRV8bUrPOdRxkO+QJ3ZCzveXfk3cJ0E
	gceURre4yS89bdPbnq2ozICWd23GUcnI/EzDxFoj/ZKAalakf+3aE+E3hOWqGviPq++vNM
	AYLjExikZMycuGAzBcIHcjqAb3vbGg2OzaOWQFI7cjlKiWJkqHo3MFQ4njKbbQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, 
	Ben Knoble <ben.knoble@gmail.com>, Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v6] revision.c: implement --max-count-oldest
Message-ID: <af0kZUczSPJrQcU6@exploit>
References: <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
 <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
 <7250e6c1-633e-417b-aacb-94e35d240d3f@kdbg.org>
 <afs2QVHerGLALFcl@exploit>
 <87o6ireftj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6ireftj.fsf@gitster.g>
X-Spamd-Bar: -

On Thu, May 07, 2026 at 06:20:40PM +0900, Junio C Hamano wrote:
> Mirko Faina <mroik@delayed.space> writes:
> 
> >> BTW, this makes me think whether this kind of limiting could be
> >> triggered by a negative argument to --max-count.
> >
> > Would be a good idea if it weren't for the fact that --max-count < 0 has
> > for a long time acted like no max count. I'd imagine many could be
> > asssuming this behaviour in their scripts.
> 
> Many?  I am not sure.  
> 
> What do these script try to achieve by having "--max-count=-1"?  It
> would be to defeat --max-count=<n> coming from elsewhere, but where?

It's not necessarely to defeat a previous use of --max-count. If I know
that --max-count behaves in as certain way, in this case the same as not
having it when below 0, I can always have it in the command that I have
to run and just work with the argument (of course one would do this only
if it is easier to work with just the argument). That way I don't have
to conditionally add the option if it has to be enabled. Something like

	N=should_use_max_count_and_if_so_much_to_limit
	git rev-list --max-count=$N

Of course these script make use of behaviour that is not documented and
might not even be intended, so really their fault if it breaks.

This has been the behaviour of --max-count for a long time so I'm
assuming that there is a possibility that it will break many scripts.
But like I said, their fault if it breaks, if you think its not that
widespread I'll get rid of --max-count-oldest.
