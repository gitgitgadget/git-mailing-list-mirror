Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0E620958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbdCWTX7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:23:59 -0400
Received: from [104.130.231.41] ([104.130.231.41]:50476 "EHLO cloud.peff.net"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbdCWTX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:23:58 -0400
Received: (qmail 13729 invoked by uid 109); 23 Mar 2017 19:23:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 19:23:15 +0000
Received: (qmail 9666 invoked by uid 111); 23 Mar 2017 19:23:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 15:23:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 15:23:13 -0400
Date:   Thu, 23 Mar 2017 15:23:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] refs.c: use skip_prefix() in prettify_refname()
Message-ID: <20170323192313.ytr56pjpnillnh63@sigill.intra.peff.net>
References: <20170323155012.6148-1-szeder.dev@gmail.com>
 <4382e211-63f6-811f-6f33-1cf5d2c087a8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4382e211-63f6-811f-6f33-1cf5d2c087a8@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 08:18:26PM +0100, René Scharfe wrote:

> Am 23.03.2017 um 16:50 schrieb SZEDER Gábor:
> > This eliminates three magic numbers.
> > 
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  refs.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/refs.c b/refs.c
> > index e7606716d..0272e332c 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -366,11 +366,11 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
> > 
> >  const char *prettify_refname(const char *name)
> >  {
> > -	return name + (
> > -		starts_with(name, "refs/heads/") ? 11 :
> > -		starts_with(name, "refs/tags/") ? 10 :
> > -		starts_with(name, "refs/remotes/") ? 13 :
> > -		0);
> > +	if (skip_prefix(name, "refs/heads/", &name) ||
> > +	    skip_prefix(name, "refs/tags/", &name) ||
> > +	    skip_prefix(name, "refs/remotes/", &name))
> > +		; /* nothing */
> > +	return name;
> 
> Nice, but why add the "if" when it's doing nothing?

It's short-circuiting in the conditional.

-Peff
