Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734932F12CE
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760782944; cv=none; b=at6RggOuJn8bQ09hFNhDmfN0SwakpoWR0wTQOrp2dopJD2Rz/vNFpeY7tsQPgMXVabEI1YRvk0PPRlXHrWFmP8QKApgzx6r2TjD+Y/mjfHR8P1ehXOD8Z+08R7EDibvosuBFpVoryKsB2B+YaBuFjyWQMF8nCQQ54cGqzDMmJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760782944; c=relaxed/simple;
	bh=8lv5quJroHDuHixfXQy6oAOwgXUn3XvJd/b6DNDjTF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7gUf0LOywK3BwpketHhifA12ttpCyNtQ6xrH8+ThwOolhxTaAaZnysY9TatJjkcLLIo6Ijzh8G6L1uWt12ZNlC0bZgzJbga5bsOCbb4uzuNMBBeQC1P5jc6wJJA0mN1g1abDOAuFcJIkIFEbvI/UDui+DVO0nWq58pP1xbSqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dCMXvPFU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dCMXvPFU"
Received: (qmail 261383 invoked by uid 109); 18 Oct 2025 10:22:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8lv5quJroHDuHixfXQy6oAOwgXUn3XvJd/b6DNDjTF8=; b=dCMXvPFUuL4/w0POfa9DFarfTaT39eE+5RFIPpGtES9jwdYiQ0k+qZHrvTHQPynNVj5OG2ZeSWsHjMX+cUD6pSf1oRkmlubznA6VqGy+gDXBHUGzautbIHAwtfnE3daYC6R/+0orp3ATxli7oWRGRYdFAXnbyn5st0HJ1qGiTU5HRLEH8tVS6C98TZAWB9n0iPA4jdT8aGxpdOuTURAqWy9frjJo/7d+8kPJCPtJoyDKTyfIWfD7CpbjlFRh0SXNn6KRE2FicVo+1lhi7rt4nt5/I7kmojD1GHUPyYx2KAVVAIPsUd5K824QATOsNDur5K+lgFrwbX2eD5ItFGR7sw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Oct 2025 10:22:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 410197 invoked by uid 111); 18 Oct 2025 10:22:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Oct 2025 06:22:10 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Oct 2025 06:22:09 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: El_Hoy <eloyesp@gmail.com>, git@vger.kernel.org
Subject: Re: Making git grep ignore binary the default
Message-ID: <20251018102209.GH1060824@coredump.intra.peff.net>
References: <CAPapNH0C3+bU-RUO6oFHUKLjKuNdm-aXgsFTHFobYVrJXWzr=g@mail.gmail.com>
 <xmqqsefhxlmd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsefhxlmd.fsf@gitster.g>

On Fri, Oct 17, 2025 at 02:29:46PM -0700, Junio C Hamano wrote:

> Simply because we have never needed to do something similar to "-a"
> and "-I" that we added in early 2006 for the past nearly 20 years.
> Also because GNU does not have any such thing to force "-a" or "-I"
> as default.  The biggest reason is that it would be surprising if
> such a change does not break existing scripts that have been written
> by people over the years.

I do think there is one difference between git-grep and regular grep
here: the input file selection.

In "grep", the default set of files to search is nothing, and you have
to tell it which files to look at. So aside from overly broad globs, the
problem solves itself when you just don't pass in the binary paths.

But in git-grep, the default set of files to search is everything in the
repository! So it is very easy to noisy hits from uninteresting files.

I think binary-ness of the files is a red herring, though. There are
plenty of text files that are not interesting to grep either. I almost
never want to see hits from po/ in git.git, for example. I get by with
"^po/", or even "'*.c'" (extra single-quotes so that Git expands the
glob). But I'd be happy if I could set a configuration knob to say that
files with attribute X should be omitted from grep results (whether
binary, or some custom attribute that I assign in .git/info/attributes).

I think we've discussed this before, and digging in the archive found
this thread from 2012:

  https://lore.kernel.org/git/4f1d2a8b.a2d8320a.50ec.576d@mx.google.com/

I think some of those ideas came to fruition. You can do:

  git grep ':(attr:!binary)'

now (which obviously is harder than "-I", but the point is that it
extends to any attribute if you want). But I still think it would be
nice if there was a way to make it the default (without using an alias).

-Peff
