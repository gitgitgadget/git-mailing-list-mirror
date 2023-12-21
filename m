Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752876DC0
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 28301 invoked by uid 109); 21 Dec 2023 21:35:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Dec 2023 21:35:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28156 invoked by uid 111); 21 Dec 2023 21:35:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Dec 2023 16:35:43 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Dec 2023 16:35:43 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [RFC/PATCH] archive: "--list" does not take further options
Message-ID: <20231221213543.GC1446091@coredump.intra.peff.net>
References: <xmqqbkakqx6s.fsf@gitster.g>
 <xmqqttocp98r.fsf@gitster.g>
 <296e8d69-c1d7-4ad2-943a-dfc54940abc2@web.de>
 <20231221085948.GD545870@coredump.intra.peff.net>
 <xmqqmsu3mnix.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsu3mnix.fsf@gitster.g>

On Thu, Dec 21, 2023 at 10:13:58AM -0800, Junio C Hamano wrote:

> Thanks, both.  Just to tie the loose end, let me queue this and
> merge it to 'next'.
> 
> ----- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] archive: "--list" does not take further options

This looks fine to me. It does mean that this sequence of commands no
longer works:

  [let's try to make a "foo" archive]
  $ git archive --format=foo HEAD
  fatal: Unknown archive format 'foo'

  [oops, that didn't work. What formats are supported?]
  $ !! --list
  git archive --format=foo HEAD --list
  tar
  tgz
  tar.gz
  zip

I think that's OK in practice. The increased error checking is worth it
(and matches many other commands, which tend to warn about confusing
extra bits).

-Peff
