Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FC0E1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 21:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfBFVfA (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 16:35:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:35170 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725983AbfBFVfA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 16:35:00 -0500
Received: (qmail 23584 invoked by uid 109); 6 Feb 2019 21:35:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Feb 2019 21:35:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5975 invoked by uid 111); 6 Feb 2019 21:35:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 16:35:08 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 16:34:58 -0500
Date:   Wed, 6 Feb 2019 16:34:58 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, steadmon@google.com
Subject: Re: [PATCH 0/8] Resend of GIT_TEST_PROTOCOL_VERSION patches
Message-ID: <20190206213458.GC12737@sigill.intra.peff.net>
References: <cover.1549411880.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1549411880.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 05, 2019 at 04:21:14PM -0800, Jonathan Tan wrote:

> This is on the latest master (8feddda32c ("Fifth batch for 2.21",
> 2019-02-05)) + js/protocol-advertise-multi.
> 
> This is a resend of [1], which was built on the result of merging many
> branches. Now that most of the branches have been merged to master, I
> have rebased it on master. The only branch that I needed to merge was
> js/protocol-advertise-multi.

Thanks for working on this. With the exception of the final patch, this
all seems pretty sane to me from a quick look.

There is one thing that your test patches made me wonder. When we have
to make an exception to a test (i.e., that doesn't work under v2), you
do it by unsetting GIT_TEST_PROTOCOL_VERSION in the environment. That
means we'll actually run the test, but not with the version that the
caller specified.

I wonder if it would be more obvious what's going on if we instead had a
prereq like:

  test_expect_success !PROTO_V2 'ls-remote --symref' '
     ...
  '

and just skipped those tests entirely (and in a way that appears in the
TAP output).

I think it would also future-proof us a bit for v2 becoming the default
(i.e., when GIT_TEST_PROTOCOL_VERSION being blank does mean "use v2").

I dunno. It probably doesn't matter all that much, so it may not be
worth going back and changing at this point. Just a thought.

-Peff
