Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D082F90EA
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693596; cv=none; b=QRBiaO98n28/ZLdsLy9swsmwkJdnxDjTsf9gWl+Xhqg7UtiigebugbrnxeKRIPj80gfZRxLlMzgWuspOl0holkANXTSqO1wRq+lqASKn4RBa10LFqX9mFlm5xiQ7sLOt7hUdU/evui2uiROq+CtUSrTOsbY1bGPyeFVJws5PB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693596; c=relaxed/simple;
	bh=jY+rDNtoUAz+Vm2DTdTrzj1CP5MrgbYLAwpW7HvNIX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FahnzYdLhDytqFHZlXXJCp+0bXDJAfzzSwW0PW5SNlVXwl/BOawu50dJZb7smYf8Zrmy04Fj+t6TKT4KC/eOoVM9EO62DbwwTkdmY1xqnY5KI11XBxjWsbwKn+L6go/F/hJC76Sv2PslN3Rh9+F+TlOlsXYln5omprU9SdNo3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=I1dkG7Tx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="I1dkG7Tx"
Received: (qmail 372853 invoked by uid 109); 28 Oct 2025 23:19:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jY+rDNtoUAz+Vm2DTdTrzj1CP5MrgbYLAwpW7HvNIX4=; b=I1dkG7TxTVvcOFpFJ6cZE/4DNpi4IzAzQVpQuivt+f0fa+Aau3VkEfxjbdOqdTvPNfcO6Af5DkstDa9dz+t9GF7Lhdc+g+624oBN6Q3oCLk9pqt/azrd5cInaC7m7Dqg8bzI3OE1BmcjbDiqOoJwVnQNG2t4KfbJkno8ciWoxiaC2hMiXxVS8A7bXUdLXwVYBeH6wbmW+AubgXtumqw/jQhU1yuQd1x3vzic0IMDJP7xLYZxb/iR/lpk1ZNMK5nqXrIh1LxdqZX6hmpm3JXQFI7QbskzUd8STPLz7RxKMSg7iRDgGd+89qoP44qrsMEhxWPa20CAHSXvK8XdwJeaUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Oct 2025 23:19:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 575892 invoked by uid 111); 28 Oct 2025 23:19:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Oct 2025 19:19:45 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 28 Oct 2025 19:19:45 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sruteesh Kumar <sruteesh.oss@protonmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] match_pathname(): give fnmatch one char of prefix context
Message-ID: <20251028231945.GA4128296@coredump.intra.peff.net>
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
 <20251014003404.GC1507@coredump.intra.peff.net>
 <xmqq7bwltlb8.fsf@gitster.g>
 <20251026152614.GB2095501@coredump.intra.peff.net>
 <xmqq7bwhmecb.fsf@gitster.g>
 <20251027142902.GB2758515@coredump.intra.peff.net>
 <xmqq4irkl5ms.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4irkl5ms.fsf@gitster.g>

On Mon, Oct 27, 2025 at 08:35:23AM -0700, Junio C Hamano wrote:

> > BTW, there was another bug mentioned in that original issue around
> > backslash handling. I didn't investigate it at all, though. It didn't
> > look like it would be related to this optimization, so I think we can
> > just consider this fix independently.
> 
> Hmph, backslash is GIT_GLOB_SPECIAL so nowildcard prefix would stop
> before it.  Could it be that we mistake it as a directory separator?
> I _think_ we are still cleanly distinguish paths from the filesystem
> (which could use backslash as directory separator on some platforms)
> and the pathspec (which defines the slash as the sole directory
> separator), and have platform-specific fspathncmp() to absorb the
> differences when matching one with the other.  And nowildcard_len is
> all about the pathspec, so it probably is something else.

Yeah, if you do:

  git init
  echo 'foo\' >.gitignore
  git check-ignore --no-index -n -v 'foo\'

then we do have a nowildcard prefix of only 3. But I don't think we get
to match_pathname() and the prefix-matching optimization at all. In
match_basename(), we directly call the equivalent of (those are literal
backslashes in the strings):

  fnmatch("foo\", "foo\", 0);

and it claims there's no match. Now this is our own wildmatch-backed
implementation, but I wondered what POSIX has to say on a trailing
backslash like that. It's:

         If FNM_NOESCAPE is not set in flags, a <backslash> character in
         pattern followed by any other character shall match that second
         character in string.  In particular, "\\" shall match a
         <backslash> in string.  If pattern ends with an unescaped
         <backslash>, fnmatch() shall return a non-zero value (indicating
         either no match or an error).  If FNM_NOESCAPE is set, a
         <backslash> character shall be treated as an ordinary character.

So we are supposed to reject the match. Looking at the wildmatch
implementation, it does this:

        switch (p_ch) {
        case '\\':
                /* Literal match with following character.  Note that the test
                 * in "default" handles the p[1] == '\0' failure case. */
                p_ch = *++p;
                /* FALLTHROUGH */
        default:
                if (t_ch != p_ch)
                        return WM_NOMATCH;
                continue;

which matches what POSIX says.

So I think the input is really nonsense, and we're following POSIX here
in rejecting it. I can't fault an alternative implementation too much
for treating the "\" as a literal char, since that's the only other
sensible behavior. It's probably what I'd do if I hadn't read that bit
of POSIX. ;)

But to a certain degree, I think this is a case of "if it hurts, don't
do it". If you are trying to match "foo\", the correct pattern is
"foo\\".

-Peff
