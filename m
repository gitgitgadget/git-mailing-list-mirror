Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034B620372
	for <e@80x24.org>; Mon,  9 Oct 2017 17:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754396AbdJIRrS (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 13:47:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:47242 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751635AbdJIRrR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 13:47:17 -0400
Received: (qmail 25408 invoked by uid 109); 9 Oct 2017 17:41:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 17:41:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18714 invoked by uid 111); 9 Oct 2017 17:47:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 13:47:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Oct 2017 13:47:15 -0400
Date:   Mon, 9 Oct 2017 13:47:15 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v1 1/2] entry.c: update cache entry only for existing
 files
Message-ID: <20171009174715.a6wziu6w535u6rd2@sigill.intra.peff.net>
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
 <20171005104407.65948-2-lars.schneider@autodesk.com>
 <xmqqk2097sge.fsf@gitster.mtv.corp.google.com>
 <20171005112658.p7hohhtkdkcapwe6@sigill.intra.peff.net>
 <xmqqefqh6vxf.fsf@gitster.mtv.corp.google.com>
 <20171006045440.2imc2c7hvu5d3hdk@sigill.intra.peff.net>
 <FC9D1B20-C056-4739-9FE3-692CA75FC128@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FC9D1B20-C056-4739-9FE3-692CA75FC128@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2017 at 11:37:14PM +0200, Lars Schneider wrote:

> >> Yeah, I think that makes more sense.
> >> 
> >> A patch may look like this on top of these two patches, but I'd
> >> prefer to see Lars's eyeballing and possibly wrapping it up in an
> >> applicable patch after taking the authorship.
> > 
> 
> This looks all good to me. Thank you!
> A few minor style suggestions below.

Thanks, these were all reasonable (I actually avoided unwrapping some of
the lines in the original to make the "-w" diff more readable :) ).

I ended up breaking this into three commits, since I think that makes it
easier to see what each of the changes is doing. Here's what I have (on
top of what Junio has already queued in ls/filter-process-delayed):

  [v2 1/3]: write_entry: fix leak when retrying delayed filter
  [v2 2/3]: write_entry: avoid reading blobs in CE_RETRY case
  [v2 3/3]: write_entry: untangle symlink and regular-file cases

 entry.c | 83 ++++++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 35 deletions(-)

-Peff
