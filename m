Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215D21C9F6
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555506; cv=none; b=a6gXZIPCCq7yl49XzAsIxgqNSBsXOJToSkmLCTfOf9G4gXEZ97ovJjyZE3L8ctObYuNRxYEC6NW7xgpoDg5c/XkS3ZLB/NMsLp2XVD33PQMdVyWJcTdtDCyUiKq2grwmn8k/bfKuap+TWH7xRzGM7u48ysHubhMW9hPrYa+gINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555506; c=relaxed/simple;
	bh=FYicJ5ahDJYpfqFeVqjkRlDTIs87RJRMfKPcXybjREk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsUM1ZePxmOb571wgAttNJKm0onUO4TS06zrc3tHKBVupuGrDiKWeLF1WQ0ggaxW0OgRvPLLveen3Bn19W3jcQg4/MBLzVul9AFxtXwa9q/sy+aYCmXrDvvMNTHgN1PCjQjzd815X10kAjkGxQPicp2OzQ4KLKjWlB+ICJr7FWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Xi1UsFzn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Xi1UsFzn"
Received: (qmail 5683 invoked by uid 109); 26 Feb 2025 07:38:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FYicJ5ahDJYpfqFeVqjkRlDTIs87RJRMfKPcXybjREk=; b=Xi1UsFznMeAtA4bhBYVj4j6scbNXADKKvveDnJ6NzDv/QBI6hjguWjExpuXijhvXsAKcRE0EPrsaDKPKPSzWgJO7vjrF7eEgzhvgd9kmOyUiL76JwvbjcQ4tXbfIA6E2WwOgiDntbn8qX15D20ePed+ksWEWfFE6dECR3gkPIKTTNg7gv55vC/tSMbnciTSvPT5Ls7WfT/gXlnioEBEGpJU0lG/Kc5sitrlstGteoyJwNdOrgoCRXjEJduGdsEzlTVMNRaxj/LCh6owZg1c4JgpAHfl2LwLkKqTGAcy3py9y/GMAdZvAKsAmNrACh6Mpjwq+gUzZmfP/7qqHOW2nvA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Feb 2025 07:38:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20977 invoked by uid 111); 26 Feb 2025 07:38:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Feb 2025 02:38:23 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Feb 2025 02:38:22 -0500
From: Jeff King <peff@peff.net>
To: Yaakov Smith <Yaakov.Smith@wisetechglobal.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: \b character escapes in CLI usage
Message-ID: <20250226073822.GA21138@coredump.intra.peff.net>
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>

On Tue, Feb 25, 2025 at 11:44:33PM +0000, Yaakov Smith wrote:

> In some places, such as trying to fetch a remote with this in the URL, git will render the character differently.
> 
> [remote "backslashb"]
>         url = "\b"
>         fetch = +refs/heads/*:refs/remotes/backslashb/*
> 
> $ git fetch backslashb
> fatal: '?' does not appear to be a git repository
> fatal: Could not read from remote repository.

Here we sanitize error output, because we know the result is human
readable (and likely to be showing untrusted input from the repo or a
remote server).

> When using "git config --list" however, this is emitted in its raw format, and can be used to mask or hide an actual (probably invalid) value:
> 
> $ cat .git/config
> [core]
>         somevalue = "true\b\b\b\bfalse"
> $ git config --local --list
> core.somevalue=false

But here, the point of "git config" is to show the output. If we
sanitized it (especially in a lossy way like we do for error messages),
then any program reading the output would not see the real data.

> Should "git config" be smarter here and print something other than a
> literal backspace to the terminal, like "git fetch" does?

So I would say no here, in general.

We could perhaps try to be kinder about sanitizing output when it is
going to a terminal, rather than a pipe. But quite curiously, that
should already be the case for "config --list"! It invokes a pager by
default. Much to my surprise, though, "less" does not seem to treat
backspace as a control character. It can be configured to do so:

       $ LESS=FRXU git config --list --local
       ...
       core.foo=true^H^H^H^Hfalse

Here's what the manpage for less(1) says:

  By default, if neither -u nor -U is given, backspaces which appear
  adjacent to an underscore character are treated specially: the
  underlined text is displayed using the terminal's hardware underlining
  capability. Also, backspaces which appear between two identical
  characters are treated specially: the overstruck text is printed using
  the terminal's hardware boldface capability. Other backspaces are
  deleted, along with the preceding character.[...]

So I guess it is intentional to allow programs to use some effects, but
in general I think I might prefer them being marked visually. Especially
because the same would be true in a diff, like:

  git init
  echo old >file && git add file && git commit -m old
  printf 'sneaky\b\b\b\b\bnew\n' >file && git commit -m new
  git show

which respects the backspaces (actually it says "snew" with a bolded "n"
because of the overstrike rule ;) ).

I wonder if we should consider adding "U" to the default $LESS variable
we set.

-Peff
