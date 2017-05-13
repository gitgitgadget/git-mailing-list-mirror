Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67F9201A4
	for <e@80x24.org>; Sat, 13 May 2017 09:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbdEMJQo (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 05:16:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:50777 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbdEMJQn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 05:16:43 -0400
Received: (qmail 28969 invoked by uid 109); 13 May 2017 09:16:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 09:16:39 +0000
Received: (qmail 30647 invoked by uid 111); 13 May 2017 09:17:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 05:17:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 May 2017 05:16:37 -0400
Date:   Sat, 13 May 2017 05:16:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH v7 00/10] refactor the filter process code into a
 reusable module
Message-ID: <20170513091637.zebzyi7ggidybzak@sigill.intra.peff.net>
References: <20170505152802.6724-1-benpeart@microsoft.com>
 <xmqqfuggaz3d.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuggaz3d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 10:58:46AM +0900, Junio C Hamano wrote:

> Will queue; during the pre-release freeze, new things would move
> slowly, but let's see if we have more comments from others and then
> merge it to 'next' soon after the 2.13 final.

I gave it a fresh read-through. I had a few comments, but nothing that I
think should hold up moving these patches to 'next'.

I do find the convert/sub-process split a little funny. Most of the
protocol bits from convert didn't get moved over, and you could use a
sub-process that spoke any arbitrary protocol. The odd man out is
subprocess_read_status(), which assumes not only pktlines, but also
a "status=foo" key/value pair inside them.

I have a feeling that funny split is because this is a preliminary
refactoring step that will have more features built on it, and the end
result may be more consistent. We _could_ hold these back and pass
judgement once we see more. But they're a reasonable-sized chunk that's
already been through 7 rounds of review. It makes sense to me to
graduate them at least to 'next' and let the next steps use them as a
stable base.

-Peff
