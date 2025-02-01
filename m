Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EFD43AA8
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738375405; cv=none; b=OXkgLD0VefDbo3Vc6on9L0AJLK2tFAc9f6tAOvmo8ZSiW3tGWjg4gpLGM7VkhV9Yd7HHhRFou15IPHkmk/jpltJQES2PLv9jtaUf9Bh6kOSLpl01Her3MNHIZyxXXDbCa/Pj/l4HhZrec6+MpRhK8+5jnIwVebGsbcbUTOd6C+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738375405; c=relaxed/simple;
	bh=8fUYKPrLiBkpFHfv8NFu1IB8VtvfLmgjjE/8VsKrDCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1rXsOSQ4jfAweAxC/JI3XaVVM0wnY4XAwkvnGw8ANQSaIafgO3sGQXHrdOtGgUUu6mZ91jgQioCCK9wYa0ZUr8dtg31lP2pcVcaiBwnb4xWIhsN+BY8I8RdNrW2En5GMw5C3h8+7/S2g8PNa66hX9sBRQPIP2pQ2Q+ofPWvpb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IDr6do9/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IDr6do9/"
Received: (qmail 9666 invoked by uid 109); 1 Feb 2025 02:03:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8fUYKPrLiBkpFHfv8NFu1IB8VtvfLmgjjE/8VsKrDCY=; b=IDr6do9/dbcQ/MlXeGqH9uwHdkMycM1spwK+g8WgaVuubb3npESDWz/c5ad133SA6Qcn6n5VsHIami4NXRK70b5lLTKFkekjYF+7zMUIW1coWtcO96dq8WuVBvvndDLvNYp+9qvUNVhkyblPnmme15Oo4CJUZKs+mNZiLp4/0iXrlgFw9sOgvxYKQFJKsy3PcA9nYUJavLVWrLC2wuuiUcejO6NS7ujkOsUxLXfqEZnZBM4pNXNcHxi1i4T++GP9QAnhcqO3KfGgP1DrPKAbW+ps4oUOixPjr6jdhA4lhSguJqG/250l3ZHHA9zq3S/+gwphGtpU3KTba5AbU6HgcQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Feb 2025 02:03:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7821 invoked by uid 111); 1 Feb 2025 02:03:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2025 21:03:24 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 31 Jan 2025 21:03:21 -0500
From: Jeff King <peff@peff.net>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v10 8/8] cat-file: add remote-object-info to batch-command
Message-ID: <20250201020321.GA4081169@coredump.intra.peff.net>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250114021502.41499-1-eric.peijian@gmail.com>
 <20250114021502.41499-9-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250114021502.41499-9-eric.peijian@gmail.com>

On Mon, Jan 13, 2025 at 09:15:00PM -0500, Eric Ju wrote:

> +static void parse_cmd_remote_object_info(struct batch_options *opt,
> +					 const char *line, struct strbuf *output,
> +					 struct expand_data *data)
> +{
> +	int count;
> +	const char **argv;
> +
> +	char *line_to_split = xstrdup_or_null(line);
> +	count = split_cmdline(line_to_split, &argv);
> +	if (get_remote_info(opt, count, argv))
> +		goto cleanup;

Coverity complains that split_cmdline() can return a negative value when
the input is malformed, which we then feed to get_remote_info(). If I
understand correctly (from my very brief glance at the series), that
string would be under the control of the untrusted client?

I _think_ an attacker can't do anything too bad here, since
get_remote_info() also takes a signed int, and so iterating from 0 will
just find no entries. But probably we should explicitly check for error
and bail.

While just looking at this code from a security perspective, two other
things occur to me:

  1. Calling xstrdup_or_null() implies that "line" may be NULL, which
     would make "line_to_split" also NULL. But I think split_cmdline()
     would segfault in that case. Should it just be xstrdup()?

  2. Are there any bounds on the size of "line"? E.g., is it coming in
     as a single pkt, or can it be arbitrarily large if an attacker
     wants (it looks like maybe the latter, since it comes from a strbuf
     in batch_objects_command(), but I didn't look at how network data
     gets passed in to that). At any rate, I think we ran into problems
     before with split_cmdline() and integer overflow, since it returns
     an int (CVE-2022-39260). I thought we fixed it by rejecting long
     lines in git-shell, but it looks like we also hardened
     split_cmdline() in 0ca6ead81e (alias.c: reject too-long cmdline
     strings in split_cmdline(), 2022-09-28).

     So we are maybe OK, but I wonder if we should punt on absurd lines.
     Related, can an attacker just flood input into that strbuf, making
     it grow forever and waste memory? That's just a simple resource
     attack, but we have tried to avoid those elsewhere in upload-pack,
     etc.

-Peff
