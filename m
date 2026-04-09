Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696CF1DC1AB
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775763487; cv=none; b=ZJw1ZDI7gyUn2mrJMI3/Fip5e+j9+w4IAPDE2CaA2AWxGRb0kqZp1ia6C+VeC2d2nE9UR5RSiORi2NapGWB+KxYAoYUB9rsvc3OD41fkHul0dIH+kMG1e1LzbFa5qONdWV2AEB8oiz9yjbfr5R9tnnIVVNaD77KsJFOghi3FfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775763487; c=relaxed/simple;
	bh=n0S7fiPviwLWFF1DhPT2GFh4bFD1/eeqovlbmmJymQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwECFxbxFsGk8gb1ZdOXOQJtxxUUCEGVohkE8XkKIcfeRZh4NkkWMkUQxCFgV9EXvamtyflD3X/N5fo5xrjmLmrM2rXXLEzc2/qzgUaHQxPNNJh3t51BlP77e9xV6gh3+Xi55wAtWftjk09jlidDbRW3fUZfZOXjjTJiFTCQ8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=MlbHX314; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="MlbHX314"
Date: Thu, 9 Apr 2026 21:37:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1775763476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0S7fiPviwLWFF1DhPT2GFh4bFD1/eeqovlbmmJymQM=;
	b=MlbHX314QhQaPyE+1Q4Ns6ln+Edf/qeQiX7hIHzc8OCcSWtVAMuC4bzhWamyx3Jet4jKdy
	J4bJ0RCGJynJTcsWfZ2ezEfjnJ87OGb8eNTBFBH/83YOQPqLLMmB0RHi3eWpUS2+Ds/nwS
	KLGNizeJ21vfkipNB4ACNEgJaP4VOm/Piwg7xNOBQy2llc8CjUsOXCqc0p2F4tFlsa88R/
	vy59TmG145DOZHv9t1JJeaC+izH8gGaCRoPsQADJiZH7HlVTA6GWzP4GNprbtAwvW6NW+T
	iPCQHDRLiE4elg18IuMe90tNt8zck/YPrUtUSaqXv7AAcozURE69/6QXcuckxg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, ben.knoble@gmail.com, 
	quentin.bernet@bluewin.ch, gitster@pobox.com, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v3] stash: infer "push" when push-specific options are
 given
Message-ID: <adf-452vT7MBZfwc@exploit>
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
 <20260405110953.3316-1-deveshigurgaon@gmail.com>
 <adP3JZhS7IHDuUxm@exploit>
 <a280c7de-1357-44a9-afdd-bd473fd4e2a4@gmail.com>
 <CAG7UgESxcbKb=Jzi36osBhD51KO9GvQr8esD=6BMupLAi33nWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG7UgESxcbKb=Jzi36osBhD51KO9GvQr8esD=6BMupLAi33nWQ@mail.gmail.com>
X-Spamd-Bar: -

On Fri, Apr 10, 2026 at 12:52:06AM +0530, Deveshi Dwivedi wrote:
> > "create" accepts "-m" as well so that's not unique either. I agree with
> > Junio's suggestion in the link above that we should assume "push" when
> > there is no subcommand given and error out if we see an unsupported
> > option. That does not require the arguments to be unique to "push". A
> > complete implementation would also support negated options like "git
> > stash --no-stage [<pathspec>]". What is implemented in this patch maybe
> > sufficient in practice but it would be good to mention the limitations
> > in the commit message.
> >
> > Thanks
> >
> > Phillip
> Sure, I will send a v4 with an updated commit message. Thank you.

I think the documentation should change as well as it can be ambiguous.
From reading "push-specific options" I'm assuming it would work only
with options that are unique to push, which is not the case, while
others might assume the correct behaviour which works with any option
that push accepts.
