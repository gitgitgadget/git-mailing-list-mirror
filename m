Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CB531F404
	for <e@80x24.org>; Tue, 20 Feb 2018 21:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeBTVQh (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 16:16:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:58678 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750799AbeBTVQg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 16:16:36 -0500
Received: (qmail 9825 invoked by uid 109); 20 Feb 2018 21:16:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Feb 2018 21:16:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17126 invoked by uid 111); 20 Feb 2018 21:17:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Feb 2018 16:17:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Feb 2018 16:16:34 -0500
Date:   Tue, 20 Feb 2018 16:16:34 -0500
From:   Jeff King <peff@peff.net>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180220211634.GA15232@sigill.intra.peff.net>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 10:22:36PM +0100, Peter Backes wrote:

> please ensure to CC me if you reply as I am not subscribed to the list.
> 
> https://git.wiki.kernel.org/index.php/Git_FAQ#Why_isn.27t_Git_preserving_modification_time_on_files.3F 
> argues that git isn't preserving modification times because it needs to 
> ensure that build tools work properly.

I think there are some references buried somewhere in that wiki, but did
you look at any of the third-party tools that store file metadata
alongside the files in the repository? E.g.:

  https://etckeeper.branchable.com/

or

  https://github.com/przemoc/metastore

I didn't see either of those mentioned in this thread (though I also do
not have personal experience with them, either).

Modification times are a subset of the total metadata you might care
about, so they are solving a much more general problem. Which may also
partially answer your question about why this isn't built into git. The
general problem gets much bigger when you start wanting to carry things
like modes (which git doesn't actually track; we really only care about
the executable bit) or extended attributes (acls, etc).

-Peff
