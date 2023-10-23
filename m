Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3611C295
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5CFBA
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:58:43 -0700 (PDT)
Received: (qmail 22693 invoked by uid 109); 23 Oct 2023 18:58:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Oct 2023 18:58:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14878 invoked by uid 111); 23 Oct 2023 18:58:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Oct 2023 14:58:44 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Oct 2023 14:58:42 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/7] bulk-checkin: implement `SOURCE_INCORE` mode for
 `bulk_checkin_source`
Message-ID: <20231023185842.GE1537181@coredump.intra.peff.net>
References: <cover.1697736516.git.me@ttaylorr.com>
 <e427fe6ad383cc238c13f313dc9f11eab37a3840.1697736516.git.me@ttaylorr.com>
 <ZTY6kTZT-ni16usH@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTY6kTZT-ni16usH@tanuki>

On Mon, Oct 23, 2023 at 11:19:13AM +0200, Patrick Steinhardt wrote:

> > +	case SOURCE_INCORE:
> > +		assert(source->read <= source->size);
> 
> Is there any guideline around when to use `assert()` vs `BUG()`? I think
> that this assertion here is quite critical, because when it does not
> hold we can end up performing out-of-bounds reads and writes. But as
> asserts are typically missing in non-debug builds, this safeguard would
> not do anything for our end users, right?

I don't think we have a written guideline. My philosophy is: always use
BUG(), because you will never be surprised that the assertion was not
compiled in (and I think compiling without assertions is almost
certainly premature optimization, especially given the way we tend to
use them).

-Peff
