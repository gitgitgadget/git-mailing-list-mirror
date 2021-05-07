Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A18AC433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 22:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313FE61104
	for <git@archiver.kernel.org>; Fri,  7 May 2021 22:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhEGWDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 18:03:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:47682 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGWDS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 18:03:18 -0400
Received: (qmail 2956 invoked by uid 109); 7 May 2021 22:02:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 May 2021 22:02:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4186 invoked by uid 111); 7 May 2021 22:02:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 May 2021 18:02:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 May 2021 18:02:17 -0400
From:   Jeff King <peff@peff.net>
To:     Will Chandler <wfc@wfchandler.org>
Cc:     git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] refs: cleanup directories when deleting packed ref
Message-ID: <YJW46fsdKaUv2Fln@coredump.intra.peff.net>
References: <YJVQpaDwkQH/aCee@mini.wfchandler.org>
 <YJW3n6lVWVAuLQap@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJW3n6lVWVAuLQap@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 07, 2021 at 05:56:47PM -0400, Jeff King wrote:

> > +test_expect_success 'directory not created deleting packed ref' '
> > +	git branch d1/d2/r1 HEAD &&
> > +	git pack-refs --all &&
> > +	test_path_is_missing .git/refs/heads/d1/d2 &&
> > +	git branch -d d1/d2/r1 &&
> > +	test_path_is_missing .git/refs/heads/d1/d2 &&
> > +	test_path_is_missing .git/refs/heads/d1
> > +'
> 
> ...this test passes even without your patch applied. I wonder if there's
> something else required to trigger the problem.

If I replace "git branch -d" with "git update-ref -d", then the problem
does trigger (and your patch does indeed clear it up). I wonder what the
difference is.

-Peff
