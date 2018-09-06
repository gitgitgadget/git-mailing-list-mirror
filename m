Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB7801F404
	for <e@80x24.org>; Thu,  6 Sep 2018 19:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeIFX5R (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 19:57:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:41646 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726980AbeIFX5R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 19:57:17 -0400
Received: (qmail 26587 invoked by uid 109); 6 Sep 2018 19:20:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Sep 2018 19:20:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7029 invoked by uid 111); 6 Sep 2018 19:20:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 15:20:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 15:20:22 -0400
Date:   Thu, 6 Sep 2018 15:20:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Tim Schumacher <timschumi@gmx.de>, gitster@pobox.com,
        pclouds@gmail.com
Subject: Re: ordered string-list considered harmful, was Re: [PATCH v3] Allow
 aliases that include other aliases
Message-ID: <20180906192021.GB26575@sigill.intra.peff.net>
References: <20180906191203.GA26184@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180906191203.GA26184@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 03:12:03PM -0400, Jeff King wrote:

> On Thu, Sep 06, 2018 at 10:59:42AM -0400, Jeff King wrote:
> 
> > > +		string_list_append(&cmd_list, *argv[0]);
> > 
> > This will create an unsorted list. You'd have to use
> > string_list_insert() here for a sorted list, or
> > unsorted_string_list_has_string() in the earlier call.
> > 
> > It's unfortunate that string_list makes this so easy to get wrong.
> 
> This is getting really off-topic (since it sounds like we'd probably
> want to use an ordered list here), but is it crazy to think that
> basically every use of an ordered string list could just be a hashmap?

Er, oops, I used "ordered" to mean two things here.

I meant that the code regarding aliases would use an _unsorted_ list
(where we care about keeping the original insertion order).

But what I think is harmful is a _sorted_ list, because of the
"accidentally quadratic" nature, and because it's easy to call its
functions on an unsorted list.

-Peff
