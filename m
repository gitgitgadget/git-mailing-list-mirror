Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8019A
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 00:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257121; cv=none; b=az8lAKEa4FBKvVjUVO8xgULQ+kO4glVBAxP5VlTioSFPXp60CBXkcSpmEphSyTElMyHZiGjffS91ZbXaoopX2U4NcJ/hPcqrg7751UA7ncc5zxshpBtukDomh/DJwHBYqjwwbXaQMIzxuz7WSbFp8HsXye7e5n5/fObJFUdYOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257121; c=relaxed/simple;
	bh=kFOjqzCF5MDK8VIlzvnTFDJ0l0JLbDHO/Sc1RRiKcms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckikobv7Bhsib7wLKXZTo5ENZkbvGUq7fyRnLBYLhQk+voZ6IOu2HO/QxN3U4hXBRGqisj+hR5PNZdmYh+VecjY+hTFS8IsrOkZ8a5FE0u65kbnqzk78Y+L4eE1Hmgasmko5DL+tVW758iwNG9QmKnbHtFA7dSw4XuxKCoowy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Svsli9aN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Svsli9aN"
Received: (qmail 25788 invoked by uid 109); 18 Mar 2025 00:18:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kFOjqzCF5MDK8VIlzvnTFDJ0l0JLbDHO/Sc1RRiKcms=; b=Svsli9aNI+ccmjZeEnMbCni1H7nqxBqmC/5Jw3BHTW1rS7TsxQYj4qXlgm/0aBJh+4JlBtI0Tv3uWS0ouLqnRbOynfOvRYqIzoOO08lk2Qo1a3Kiz+koZDDYMLtEdO0A3IQ3anSII2G33kci7yl23oQU23++TcXnNqDzRECmArFKCuWvfdETJz9u/cV7Pe2PKN7AV9UmLjFPwxYF+8rqux0H9B+QFsdv1hPtwHUN2uyvAgA9ckqfnoi4MW1rQ6tRKYD7HtMEFXrnuWxjQbNKhdjA3QOB3cL43DlGa7+bLdFyEEFC0UjLrzNJPtWbPHAyT9oiv46koB/SLawvvrimkQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 00:18:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2105 invoked by uid 111); 18 Mar 2025 00:18:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 20:18:35 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 20:18:35 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/3] -Wunreachable-code
Message-ID: <20250318001835.GA1470172@coredump.intra.peff.net>
References: <20250314210909.3776678-1-gitster@pobox.com>
 <20250317235329.809302-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317235329.809302-1-gitster@pobox.com>

On Mon, Mar 17, 2025 at 04:53:26PM -0700, Junio C Hamano wrote:

> As Taylor noticed, we can still help macOS users by first dealing
> with the false positive in the code, and then flip the warning
> option for developers on.

Yeah, this is worth doing.

> This is totally offtopic, but I often find the short-log (list of
> commits, grouped by author) in the cover letter very awkward to work
> with.  Between v2 and v3, aside from the NOT_CONSTANT() improvements
> in the patch [2/3] that used to be [3/3], one large change is the
> reordering of the patches but that is not seen in the shortlog (I
> ran "git log --oneline -reverse" to prepare the list of commits in
> the order they are applied to describe them in the above list).
> 
> Jeff King (2):
>   run-command: use errno to check for sigfillset() error
>   config.mak.dev: enable -Wunreachable-code
> 
> Junio C Hamano (1):
>   git-compat-util: add NOT_CONSTANT macro and use it in atfork_prepare()

The re-ordering does appear in the range-diff, if you provide one. But I
agree that the organized-by-name shortlog does not make much sense for
most series. As a reviewer, I care most about the patches, not the
authors.

I make my cover letters with something like this (part of a larger
script):

    git format-patch --stdout origin..$topic |
    perl -lne '
      if (/^Subject: (.*)/) {
        $subject = $1;
      }
      elsif ($subject && /^\s+(.*)/) {
        $subject .= " $1";
      }
      elsif ($subject) {
        print $subject;
        $subject = undef;
      }
    ' |
    sed -e 's/\[PATCH /[/' \
        -e 's/]/]:/' \
        -e 's/^/  /'

which yields something like (for the older version of this series):

  [1/3]: config.mak.dev: enable -Wunreachable-code
  [2/3]: run-command: use errno to check for sigfillset() error
  [3/3]: git-compat-util: add NOT_A_CONST macro and use it in atfork_prepare()

Having the correct order and the matching numbering next to each one
makes it much easier if you're going to comment on them inline.

The perl in the script above is required to handle rfc822 wrapping /
line continuation. I never bothered to implement rfc2047 unquoting. I
don't tend to use non-ascii chars in my subject lines. ;)

It would be nice if we had a format-patch option to avoid quoting and
wrapping in order to make text processing like this easier.

-Peff
