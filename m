Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188427470
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775932714; cv=none; b=Rkzw49YLSIq9c1OIJzDGYyq+kTT3yTJ34hDqA6D7R/hlF5jD96WZp2zEr+CrXM5vzC1vFazxKJeSabHuS15FCjdMtkRllWa34uj4SAqc3kPvYF2LVAAZIL1A4Z8UdOz1S+DyRXTU05Bg/dvw5KBeWPaQNGMjA6KBRuMHUiGL9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775932714; c=relaxed/simple;
	bh=qKaTwHyodjiggrGgXBYQmt0y4rYDEixcKnA0wuAyv9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnwEPO4uUD2M1YsytrW1kwCoS7Y8KyIQKki0n0+3YgNt+mszqxuyTGn378kISi1Lmw/qmVzg3RglbA1A5dxFN2kGsdZqACKeINzMtwYeyVwypgkfHYLuQan7Tn+HkvK57kGAOyooQbPq3fGWR+8pTbuerFCbBmLFZEVcq5Zk7Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YCjKW2C5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YCjKW2C5"
Received: (qmail 317676 invoked by uid 106); 11 Apr 2026 18:38:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=qKaTwHyodjiggrGgXBYQmt0y4rYDEixcKnA0wuAyv9U=; b=YCjKW2C5NEAoBD0oqInV3uoRofcHjO0LP/0vZjKvGcRKRAtkBZe9CYDQ2NWHVCKZGgwaV02ve2OmDaFeSdbr2SPkmTN8wyJJ4Q9IWsDMILM+zLqNQzxc0RFu0SGLKB/A+xxC5Bbq4XMCAAS1K09PNkwsUZFIZmHSXIqHHzb0QW+Ihp7lxclCZ5YYfYnLWf5HYKtQ5kk5LYId/tFd/qhl88pfjQ4ntG+jPsP2XpGXTK+ehLKy/beoWnLjg9+aLOSlu8KAbZQlA844c6D72uwQ/LflGAo0OmoqZY34XBRmEdSWVmlln7TCEYvewyLQkQ4rPsdP5/WZM9YvYGbDqjKziA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Apr 2026 18:38:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 524851 invoked by uid 111); 11 Apr 2026 18:38:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Apr 2026 14:38:23 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 11 Apr 2026 14:38:23 -0400
From: Jeff King <peff@peff.net>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Chris Torek <chris.torek@gmail.com>,
	Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v9 4/4] checkout: -m (--merge) uses autostash when
 switching branches
Message-ID: <20260411183823.GA672575@coredump.intra.peff.net>
References: <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
 <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
 <00e0b3196cd158244cb15bfd7edb7d9d3f0954a2.1775854874.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00e0b3196cd158244cb15bfd7edb7d9d3f0954a2.1775854874.git.gitgitgadget@gmail.com>

On Fri, Apr 10, 2026 at 09:01:13PM +0000, Harald Nordgren via GitGitGadget wrote:

>  	if (do_merge) {
>  		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
> +		if (ret && opts->merge) {
> +			create_autostash_ref_silent(the_repository,
> +						   "CHECKOUT_AUTOSTASH");

This tries to create a root-level ref called CHECKOUT_AUTOSTASH, which
violates the syntax rules given in gitglossary's "ref" entry:

  Ref names must either start with refs/ or be located in the root of
  the hierarchy. For the latter, their name must follow these rules:

    •   The name consists of only upper-case characters or underscores.

    •   The name ends with "_HEAD" or is equal to "HEAD".

Our enforcement of these rules has some holes, but I have a local series
to fix that (which is how I noticed the problem). The entry continues to
list some exceptions:

  There are some irregular refs in the root of the hierarchy that do not
  match these rules. The following list is exhaustive and shall not be
  extended in the future:

    •   AUTO_MERGE

    •   BISECT_EXPECTED_REV

    •   NOTES_MERGE_PARTIAL

    •   NOTES_MERGE_REF

    •   MERGE_AUTOSTASH

We can add CHECKOUT_AUTOSTASH to the list of exceptions, but I wonder if
there is another name we could use that would conform to the usual
rules.

-Peff
