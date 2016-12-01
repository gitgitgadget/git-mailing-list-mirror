Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5301FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbcLAUzH (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:55:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:50206 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbcLAUzG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:55:06 -0500
Received: (qmail 16405 invoked by uid 109); 1 Dec 2016 20:55:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 20:55:06 +0000
Received: (qmail 4130 invoked by uid 111); 1 Dec 2016 20:55:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 15:55:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 15:55:04 -0500
Date:   Thu, 1 Dec 2016 15:55:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] add diff-pairs tool
Message-ID: <20161201205504.flgaf7dwv3b3dkkd@sigill.intra.peff.net>
References: <20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net>
 <xmqqbmwv8j9m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmwv8j9m.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 12:52:05PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This takes the output of `diff-tree -z --raw` and feeds it
> > back to the later stages of the diff machinery to produce
> > diffs in other formats.
> 
> A full circle.  This reminds me of the experiment done more than 10
> years ago at the beginning of the "diffcore transformations" design.

Heh, I didn't even think to dig for prior art on the list.

In a sense this is just bringing the full power of diffcore out to the
scripting interface. The one missing component is that you can't
actually call diffcore_std() in the middle. The full pipeline would I
guess be something more like:

  git diff-tree --raw -z $a $b |
  git detect-renames |
  git diff-pairs -p

or something. In my model it's sufficient for the rename detection to
happen as part of the first diff-tree (since it's a whole-tree operation
anyway, there's no benefit to breaking it up into chunks).

-Peff
