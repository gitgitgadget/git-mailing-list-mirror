Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 678391F462
	for <e@80x24.org>; Mon, 29 Jul 2019 09:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfG2JLs (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 05:11:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:53844 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726694AbfG2JLs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 05:11:48 -0400
Received: (qmail 21015 invoked by uid 109); 29 Jul 2019 09:11:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Jul 2019 09:11:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26671 invoked by uid 111); 29 Jul 2019 09:13:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jul 2019 05:13:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Jul 2019 05:11:47 -0400
From:   Jeff King <peff@peff.net>
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] checkout.c: unstage empty deleted ita files
Message-ID: <20190729091146.GA1595@sigill.intra.peff.net>
References: <20190726045645.2437-1-vcnaik94@gmail.com>
 <20190726085756.GA20017@sigill.intra.peff.net>
 <CAK_rgsH6hL3g+PVfcMuq1dQLeNJcii=D_dQ8anmWLvYrShmkNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK_rgsH6hL3g+PVfcMuq1dQLeNJcii=D_dQ8anmWLvYrShmkNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 28, 2019 at 11:54:38PM -0700, Varun Naik wrote:

> > These two paragraphs would be a nice addition to the actual commit
> > message.
> 
> I will add them to the commit message, with some minor changes.

Thanks!

> > Hmm. This git-restore test means we don't apply to maint. But wouldn't
> > we want the fix for "checkout" there?
> >
> > I.e., I'd expect a patch to fix and test git-checkout, and then an
> > additional patch to be added on the merge of that plus master to test
> > git-restore.
> >
> 
> To make sure I understand, do you mean that I should omit the test
> case for "restore" right now, wait for the patch to reach master, and
> then create another patch for the "restore" test case?

I think we could do it all right now. If you split it into two patches,
one for "fix checkout" and another for "add restore tests", then Junio
could do something like:

  git checkout -b vn/checkout-ita maint
  git am fix-checkout.patch

  git checkout -b vn/restore-ita-tests master
  git merge vn/checkout-ita
  git am restore-tests.patch

The justification for the commit message in the latter patch is
something like "this is fixed already, but let's add a regression test
to make sure it remains fixed".

-Peff
