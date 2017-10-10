Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6C01FA21
	for <e@80x24.org>; Tue, 10 Oct 2017 09:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755157AbdJJJZq (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 05:25:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:48018 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751398AbdJJJZq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 05:25:46 -0400
Received: (qmail 2263 invoked by uid 109); 10 Oct 2017 09:25:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 09:25:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24412 invoked by uid 111); 10 Oct 2017 09:25:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 05:25:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Oct 2017 05:25:43 -0400
Date:   Tue, 10 Oct 2017 05:25:43 -0400
From:   Jeff King <peff@peff.net>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] write_entry: fix leak when retrying delayed filter
Message-ID: <20171010092543.e4dh2lo4sj3w6w7j@sigill.intra.peff.net>
References: <20171009174715.a6wziu6w535u6rd2@sigill.intra.peff.net>
 <20171009174824.tt5tpxdvcvzbyvnl@sigill.intra.peff.net>
 <xmqq7ew3swhi.fsf@gitster.mtv.corp.google.com>
 <20171010092319.ugim7ww7t6ks2vqf@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171010092319.ugim7ww7t6ks2vqf@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 11:23:19AM +0200, Simon Ruderich wrote:

> On Tue, Oct 10, 2017 at 09:00:09AM +0900, Junio C Hamano wrote:
> >> --- a/entry.c
> >> +++ b/entry.c
> >> @@ -283,6 +283,7 @@ static int write_entry(struct cache_entry *ce,
> >>  			if (dco && dco->state != CE_NO_DELAY) {
> >>  				/* Do not send the blob in case of a retry. */
> >>  				if (dco->state == CE_RETRY) {
> >> +					free(new);
> >>  					new = NULL;
> >>  					size = 0;
> >>  				}
> 
> FREE_AND_NULL(new)?

Ah, yeah, I forgot we had that now. It would work here, but note that
this code ends up going away later in the series.

-Peff
