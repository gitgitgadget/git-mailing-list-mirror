Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0E061F42D
	for <e@80x24.org>; Tue, 29 May 2018 16:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964967AbeE2QwY (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 12:52:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:55404 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S964965AbeE2QwY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 12:52:24 -0400
Received: (qmail 24761 invoked by uid 109); 29 May 2018 16:52:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 May 2018 16:52:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27834 invoked by uid 111); 29 May 2018 16:52:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 May 2018 12:52:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 May 2018 12:52:22 -0400
Date:   Tue, 29 May 2018 12:52:22 -0400
From:   Jeff King <peff@peff.net>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        git discussion list <git@vger.kernel.org>
Subject: Re: RFC: New reference iteration paradigm
Message-ID: <20180529165221.GB13385@sigill.intra.peff.net>
References: <56FD4CAD.3070100@alum.mit.edu>
 <xmqqlh4yo7av.fsf@gitster.mtv.corp.google.com>
 <20160331193150.GC5013@sigill.intra.peff.net>
 <86h8mu1g8j.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86h8mu1g8j.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 26, 2018 at 07:25:32PM +0200, Jakub Narebski wrote:

> > At one point I wrote a patch to binary search the packed-refs file, find
> > the first "refs/tags/" entry, and then walk linearly through there. What
> > stopped me is that the current refs.c code (I guess file-backend.c these
> > days) was not happy with me partially filling in the ref_dir structs in
> > this "inside out" way.
> [...]
> 
> Isn't this what reftable - an alternative way of storing refs in Git,
> tested by being used by JGit - would solve?  See Christian Couder post
> "Implementing reftable in Git"
> 
>   https://public-inbox.org/git/CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com/t/#u
> 
> 'Efficient lookup of an entire namespace, such as refs/tags/' is
> allegedly one of the objectives of this format.

The thread you are responding to is over 2 years old. ;)

Since then, Michael rewrote the packed-refs code to handle this case,
and we mmap and binary-search the file since v2.15.

Reftables would also have (amortized) log-n lookup, and also fix some
other problems (like lack of atomic transactions). So yes, I hope we do
eventually move to reftable, too.

-Peff
