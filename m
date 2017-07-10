Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D742035A
	for <e@80x24.org>; Mon, 10 Jul 2017 00:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbdGJAGl (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 20:06:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:35088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752765AbdGJAGl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 20:06:41 -0400
Received: (qmail 14229 invoked by uid 109); 10 Jul 2017 00:06:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 00:06:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2929 invoked by uid 111); 10 Jul 2017 00:06:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 20:06:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jul 2017 20:06:38 -0400
Date:   Sun, 9 Jul 2017 20:06:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] sha1_file: add slash once in
 for_each_file_in_obj_subdir()
Message-ID: <20170710000638.p7foedomfmdakyww@sigill.intra.peff.net>
References: <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>
 <20170709110016.nusy62u2morqvwmm@sigill.intra.peff.net>
 <xmqqy3rx8svk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3rx8svk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 09, 2017 at 09:41:51AM -0700, Junio C Hamano wrote:

> > On the plus side, this moves an invariant out of the loop. On the minus
> > side, it has to introduce an extra variable for "length we add on to"
> > versus "dir length to pass to the subdir_cb". That's not rocket science,
> > but it does slightly complicate things (though I note we already have
> > "origlen", so this is bumping us from 2 to 3 length variables, not 1 to
> > 2).
> >
> > So I dunno. It's fine with me if we take it, and fine if we leave it.
> 
> Unlike origlen, base vs dir lengths are not strictly needed; we
> prepare the base including '/', and we know we always have just one
> '/' at the end, so anybody that uses dirlen to truncate it back to
> the original before passing it down can truncate to (baselen-1), no?
> 
> In other words, something like this (not an incremental but a
> replacement) to keep calling "baselen" the length of the leading
> constant part we append to?

Yeah, I think that is correct. And you could even drop origlen by
replacing it with "baselen - 3" at the end. But somehow doing the
computation on the fly actually seems more complicated to me (from the
perspective of a reader who is trying to make sure all is correct).

-Peff
