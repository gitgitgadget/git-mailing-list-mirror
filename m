Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADDA31F462
	for <e@80x24.org>; Mon,  3 Jun 2019 12:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFCMew (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 08:34:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:44506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726137AbfFCMew (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 08:34:52 -0400
Received: (qmail 13311 invoked by uid 109); 3 Jun 2019 12:34:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Jun 2019 12:34:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3965 invoked by uid 111); 3 Jun 2019 12:35:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 03 Jun 2019 08:35:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Jun 2019 08:34:35 -0400
Date:   Mon, 3 Jun 2019 08:34:35 -0400
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190603123435.GA18953@sigill.intra.peff.net>
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <20190528215359.GB133078@google.com>
 <20190531204821.GC4641@comcast.net>
 <20190531211041.GA19792@sigill.intra.peff.net>
 <20190601001231.GF4641@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190601001231.GF4641@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 31, 2019 at 05:12:31PM -0700, Matthew DeVore wrote:

> On Fri, May 31, 2019 at 05:10:42PM -0400, Jeff King wrote:
> > On Fri, May 31, 2019 at 01:48:21PM -0700, Matthew DeVore wrote:
> > 
> > > > > +static int digit_value(int c, struct strbuf *errbuf) {
> > > > > +	if (c >= '0' && c <= '9')
> > > > > +		return c - '0';
> > > > > +	if (c >= 'a' && c <= 'f')
> > > > > +		return c - 'a' + 10;
> > > > > +	if (c >= 'A' && c <= 'F')
> > > > > +		return c - 'A' + 10;
> > > > 
> > > > I'm sure there's something I'm missing here. But why are you manually
> > > > decoding hex instead of using strtol or sscanf or something?
> > > > 
> > > 
> > > I'll have to give this a try. Thank you for the suggestion.
> > 
> > Try our hex_to_bytes() helper (or if you really want to go low-level,
> > your conditionals can be replaced by lookups in the hexval table).
> 
> Using hex_to_bytes worked out quite nicely, thanks!

Great. We might want to stop there, but it's possible could reuse even
more code. I didn't look closely before, but it seems this code is
decoding a URL. We already have a url_decode() routine in url.c. Could
it be reused?

-Peff
