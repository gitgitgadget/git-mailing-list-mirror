Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61780644
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E26BB8
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 19:13:03 -0700 (PDT)
Received: (qmail 5407 invoked by uid 109); 28 Oct 2023 02:13:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 28 Oct 2023 02:13:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28209 invoked by uid 111); 28 Oct 2023 02:13:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Oct 2023 22:13:05 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Oct 2023 22:13:01 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kousik Sanagavarapu <five231003@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
Message-ID: <20231028021301.GA35796@coredump.intra.peff.net>
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
 <20231027184357.21049-1-five231003@gmail.com>
 <xmqq7cn7obah.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7cn7obah.fsf@gitster.g>

On Sat, Oct 28, 2023 at 09:12:06AM +0900, Junio C Hamano wrote:

> Grouping @gmail.com addresses do not smell all that useful, though.
> 
> More importantly, it is not clear what "Many reports" refers to.  If
> they are *not* verbatim output from "git log" family of commands,
> iow, they are produced by post-processing output from "git log"
> family of commands, then I do not quite see why %aa is useful at
> all.

One way you could directly use this is in shortlog, which these days
lets you group by specific formats. So:

  git shortlog -ns --group=format:%aA

is potentially useful.

I say "potentially" because it really depends on your project and its
contributors. In git.git the results are mostly either too broad
("gmail.com" covers many unrelated people) or too narrow (I'll assume
I'm the only contributor from "peff.net"). There are a few possibly
useful ones ("microsoft.com", "gitlab.com", though even those are
misleading because email domains don't always correspond to
affiliations).

So I don't find it useful myself, but I see how it could be in the right
circumstances. It also feels like a symmetric match to "%al", which
already exists. I do find "aa" as the identifier a little hard to
remember. I guess it's "a" for "address", though I'd have called the
whole local@domain thing an address thing that. Of course "d" for domain
would make sense, but that is already taken. If we could spell it as
%(authoremail:domain) that would remove the question. But given the
existence of "%al", I'm not too sad to see another letter allocated to
this purpose in the meantime.

Just my two cents as a shortlog --format afficionado. ;) (Of course,
shortlog itself is the ultimate "you could really just post-process log
output" example).

-Peff
