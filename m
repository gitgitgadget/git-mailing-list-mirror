Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE532153CE
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752789316; cv=none; b=KDwC5Ko5DhQxF3janOytk3FVnpedNxT+MEZ6ZAXt30CKFRQoeApOYfHTJFwaRpe9ULQ1jAshmJKXUYoh2dC7S8w7/fxrDNNeU50SUH+y5vOYG9qmt6J0myPtUBTE4FDb+lAr+q/uie2kSTqKmwU/LQTJ5JG4ZCe+MjmcUtgc7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752789316; c=relaxed/simple;
	bh=RfY0/r8DizRMQLdh3S5emwMQxZ/wDq60qKXgICe5zws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nItBlqGcBJ6E+5tz6aFb17puxJYgLj93bSBcSQP6rLxVIV/T0hEhaE6NAasJyiDWv0/emBnFDxzc6ZbvTipWqDL3+86SbVce1lUnWrxmHjgjKFHNRsNtyvkQxekAt67f0sufu2CSjiXGQiSDXihklECSsUoWUXwYpk/8kSAMT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=D4RqyrjH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="D4RqyrjH"
Received: (qmail 14933 invoked by uid 109); 17 Jul 2025 21:55:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RfY0/r8DizRMQLdh3S5emwMQxZ/wDq60qKXgICe5zws=; b=D4RqyrjHnbGVt/cuUh7rIZmluaIkrygfaPvOraz7EoNVjhHVqy3ncIsik9uVRK45TRxqz0xNOgm++mRcb69Si5tYQwO6+VyO4Nzm4z0ELQ7SNL8Gw00B6LxwdzEVzdOJlRart6ZzVzTbAPGbqyU60m7882Eq9eVcJEecrr9oMJ3fgbHx1wcrN2OboqBIiMyzU9c+LzcCmHVNyTFXOS83BoKIEIL6tuF2WQU4l6n1M64p4qstUcMTAPzCGGfteZOgSBzZlYUC+jlM3RykHwY77VFkm8M9nsiJN4KKdkE+sruEflaVueBcs5YAY3Lm/sF8FFwjkqC8ojIpt56ZuXuLtw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Jul 2025 21:55:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11697 invoked by uid 111); 17 Jul 2025 21:55:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Jul 2025 17:55:09 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 17 Jul 2025 17:55:06 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im,
	schwab@linux-m68k.org, phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 3/5] refs: selectively set prefix in the seek functions
Message-ID: <20250717215506.GA2244266@coredump.intra.peff.net>
References: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-3-852d5a2f56e1@gmail.com>
 <20250717020905.GA2193264@coredump.intra.peff.net>
 <CAOLa=ZTdUsv-6jVhPSwEW5dYr3vEh2bLT5ECRZZ1ot3MGAYhBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTdUsv-6jVhPSwEW5dYr3vEh2bLT5ECRZZ1ot3MGAYhBg@mail.gmail.com>

On Thu, Jul 17, 2025 at 12:49:33PM -0700, Karthik Nayak wrote:

> > diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> > index 1d95b56d40..3949d145e8 100644
> > --- a/refs/ref-cache.c
> > +++ b/refs/ref-cache.c
> > @@ -498,13 +498,14 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
> >  		 * indexing to each level as needed.
> >  		 */
> >  		do {
> > -			int len, idx;
> > +			size_t len;
> > +			int idx;
> >  			int cmp = 0;
> >
> >  			sort_ref_dir(dir);
> >
> >  			slash = strchr(slash, '/');
> > -			len = slash ? slash - refname : (int)strlen(refname);
> > +			len = slash ? slash - refname : strlen(refname);
> >
> >  			for (idx = 0; idx < dir->nr; idx++) {
> >  				cmp = strncmp(refname, dir->entries[idx]->name, len);
> >
> > -Peff
> 
> Thanks, I think we have to typecast `slash - refname` to size_t, but
> this is the right way to do it. Thanks for the review!

Ah, yeah. I mistakenly test-compiled without DEVELOPER=1. ;)

I do think that cast is a lesser evil, though. It is a ptrdiff_t, but we
know it is correctly unsigned because "slash > refname" via strchr.  I
wish there was a good way to use the type system to tell the compiler
that.

-Peff
