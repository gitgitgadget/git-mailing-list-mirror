Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1C820248
	for <e@80x24.org>; Tue, 26 Mar 2019 16:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfCZQcH (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 12:32:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:36774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730451AbfCZQcG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 12:32:06 -0400
Received: (qmail 15442 invoked by uid 109); 26 Mar 2019 16:32:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 16:32:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20587 invoked by uid 111); 26 Mar 2019 16:32:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 12:32:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 12:32:04 -0400
Date:   Tue, 26 Mar 2019 12:32:04 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m
 1' is specified
Message-ID: <20190326163204.GC29627@sigill.intra.peff.net>
References: <87efh0pdln.fsf@javad.com>
 <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
 <8736nj2jcl.fsf@javad.com>
 <xmqqbm26xtum.fsf@gitster-ct.c.googlers.com>
 <87h8bra1z6.fsf@javad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h8bra1z6.fsf@javad.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 09:43:09AM +0300, Sergey Organov wrote:

> How about changing "git show -p M" to output "diff -p M^ M" rather than
> "diff-tree --cc M" for merge commits? It's really surprising specifying
> -p has no visible effect.

That's because "-p" is already the default, and the format selection is
orthogonal to the handling of merge commits. Providing "-m" would
actually override the "--cc" default (though "--first-parent -m" is
likely to be less noisy, per this discussion).

As far as defaults go, I dunno. The idea is that "--cc" would give you a
nice summary of what the merge _itself_ had to touch. I think that's
valuable, too. If we were starting from scratch, I think there could be
a discussion about whether one default is better than the other. But at
this point I have a hard time finding one so much obviously better than
the other to merit changing the behavior.

> Also, is current output of "git log -m", being extremely confusing,
> suitable for anything? Maybe consider to change it to output diff with
> respect to the first parent only? Though it's then a pity "-m" lacks
> argument here, similar to what it has in cherry-pick.

I've used "-m" without "--first-parent" sometimes in order to track down
mis-merges manually. It's not usually a big deal to say "--first-parent"
if that's what you want. But one thing I don't think is currently
possible is to ask only for the first-parent diff, but _not_ restrict
the actual traversal.

If that's what you mean by giving an argument to "-m", then yeah, I
think that would be a useful addition.

-Peff
