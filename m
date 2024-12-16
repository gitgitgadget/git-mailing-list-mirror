Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405E1204099
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347915; cv=none; b=FgfdNlp1Fy3W7A+0vTYmLuy5yFVSiMeXlRYjUmXBziYF4ymwpVUxnYZ+9m4xDEus0yCLUCaeuqFMHpeXriPcKcRAkuedtzoSLK0tfFfLjkHHBlRElWfYr1QphvK219D3pPGlXPDVc2ueHmtKoEoEPa1KSf0DE55aXhpYD8GtIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347915; c=relaxed/simple;
	bh=dMKN4WrSFrCLzc3F22+SzaqIfR02g2InTs/HLtrNIiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F41wbA3XEsyCZK95pY0GruMqKESAKUr2M3HRV87PBawRvb5ADj5/rYZpE2MEPNAttVN1NJDTdM6MacEXLOCCXcmeq7ddshvtVGq/Y3em+MGltE8fquf3HkVYvB6QF6Sac4f+oOdjsHhB6YPA/7/HClNIgjBWdDILAJyOTkalOys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AcE8/NUa; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AcE8/NUa"
Received: (qmail 26286 invoked by uid 109); 16 Dec 2024 11:18:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dMKN4WrSFrCLzc3F22+SzaqIfR02g2InTs/HLtrNIiE=; b=AcE8/NUaxdHboDkNsmYxZStzHh0tVZSa+JBZQPR69ccfL9ny3+ZOYtyH5YWuFTgyY268G7S2Ru/xe3IxsXQGNAq9aer71+WRkAuGRxarrDc9Y9wrbpSWKfCkfCPzk+RK3HNTugxPHo3CzmOx25asMsMk/mBUNmmyDfhcDLkcCgwFj2q/MMGyrzIdAYvTTRyJOKXNz/xt8Fe7+/i5PoNLS74e/FJLB23IhdvoqtWRuNY1030nrGiytaTjm8l7Td3LWbpOQJ+BlAzJxFxL+Ge2i0v15TxQUP90YTUAdlySatvjwj8xTf07vkUAC8TNKKBdr30OaNAxYIKyF62DjeJE9A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Dec 2024 11:18:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26627 invoked by uid 111); 16 Dec 2024 11:18:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Dec 2024 06:18:31 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 16 Dec 2024 06:18:31 -0500
From: Jeff King <peff@peff.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
Message-ID: <20241216111831.GB2201417@coredump.intra.peff.net>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20241213081211.GA1443203@coredump.intra.peff.net>
 <7q5dse6hbvuqwlhfceqwockouyfvvuxaekegahgelnri6nkv7h@2ph2qdfaktx2>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7q5dse6hbvuqwlhfceqwockouyfvvuxaekegahgelnri6nkv7h@2ph2qdfaktx2>

On Fri, Dec 13, 2024 at 10:41:25AM -0600, Justin Tobler wrote:

> > The patch might look something like this:
> > 
> >   https://lore.kernel.org/git/20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net/
> > 
> > :) That is what has been powering the diffs at github.com since 2016 or
> > so. And continues to do so, as far as I know. I don't have access to
> > their internal repository anymore, but I've continued to rebase the
> > topic forward in my personal repo. You can fetch it from:
> > 
> >   https://github.com/peff/git jk/diff-pairs
> > 
> > in case that is helpful.
> 
> Thanks Peff! From looking at the mentioned thread and branch, it looks
> like I'm basically trying to accomplish the same thing here. Just a bit
> late to the conversation. :)
> 
> While the use-case is rather narrow, I think it would be nice to see
> this functionality provided upstream. I see this as a means to faciliate
> more fine-grained control of the blob diffs we actually want to compute
> at a given time and it seems like it would be reasonable to expose as
> part of the diff plumbing. I would certainly be interested in adapting
> this series to instead use raw input from git-diff-tree(1) or trying to
> revive the previous series if that is preferred.

Yeah, if you want to take it in that direction, either by adapting the
idea, or by starting with diff-pairs and polishing it up, I'm happy
either way. GitHub folks may be happy if you keep the name "diff-pairs"
and match the interface. ;)

> If there is interest in continuing, some lingering questions I have:
> 
> Being that the primary purpose of git-diff-blob(1) here is to handle
> generating blob diffs as specified by stdin, is there any reason to have
> a normal mode that accepts a blob pair as arguments? Or would it be best
> to limit the input mechanism to stdin entirely? If the user wanted to
> compute a single blob diff they could just use git-diff(1) already so
> providing this as a part of git-diff-blob(1) is a bit redundant. Having
> it as an option for the user does seem a bit more friendly though.

I don't have a strong opinion. I agree it _could_ be more friendly, but
it also raises questions about how that mode/path context is filled in.
And also about other modes. E.g., "git diff HEAD:foo bar" will diff
between a blob and a working tree. Should a new plumbing command support
that, too?

If those aren't things you immediately care about, I'd probably punt on
it for now. I think it could be added later without losing compatibility
(command-line arguments as appropriate for a  single pair, and since the
stdin format starts with ":mode" there's room to extend it).

-Peff
