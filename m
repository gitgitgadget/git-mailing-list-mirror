Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82F71F462
	for <e@80x24.org>; Tue,  4 Jun 2019 23:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfFDXOZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 19:14:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:46490 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726293AbfFDXOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 19:14:25 -0400
Received: (qmail 25841 invoked by uid 109); 4 Jun 2019 23:14:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Jun 2019 23:14:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19219 invoked by uid 111); 4 Jun 2019 23:15:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Jun 2019 19:15:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2019 19:14:18 -0400
Date:   Tue, 4 Jun 2019 19:14:18 -0400
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190604231418.GA12501@sigill.intra.peff.net>
References: <20190528215359.GB133078@google.com>
 <20190531204821.GC4641@comcast.net>
 <20190531211041.GA19792@sigill.intra.peff.net>
 <20190601001231.GF4641@comcast.net>
 <20190603123435.GA18953@sigill.intra.peff.net>
 <20190603222247.GG4641@comcast.net>
 <20190604161332.GA29603@sigill.intra.peff.net>
 <20190604171952.GI4641@comcast.net>
 <20190604185108.GA14738@sigill.intra.peff.net>
 <20190604225921.GA43275@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604225921.GA43275@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 04, 2019 at 03:59:21PM -0700, Matthew DeVore wrote:

> > I think you'll find that -Wunused-function complains, though, if nobody
> > is calling it. I wasn't sure if what you showed in the interdiff was
> > meant to be final (I had to add a few other variable declarations to
> > make it compile, too).
> 
> Sorry, my last interdiff was a mess because I made a mistake during git rebase
> -i. It was missing a call to has_reserved_char. Below is another diff that
> fixes the problems:

Ah, OK, that makes sense then (and keeping the function is obviously the
right thing to do).

> > That makes some sense, and I agree that readability is a good goal. Do
> > we not need to be escaping colons in other URLs? Or are the strings
> > you're generating not true by-the-book URLs? I'm just wondering if we
> > could take this opportunity to improve the URLs we output elsewhere,
> > too.
> 
> The strings I'm generating are not URLs. Also, in http.c, we have to use : to
> delimit a username and password:
> 
> 	strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
> 	strbuf_addch(&s, ':');
> 	strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
> 
> I think this is dictated by libcurl and is not flexible.

Right, that has to be a real colon because it's syntactically
significant (but a colon in the username _must_ be encoded). That strbuf
function doesn't really understand whole URLs, and it's up to the caller
to assemble the parts.

Anyway, we've veered off of your patch series enough. Yeah, it sounds
like using strbuf's url-encoding is not quite what you want.

-Peff
