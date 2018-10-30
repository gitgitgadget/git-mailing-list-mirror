Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C5A01F453
	for <e@80x24.org>; Tue, 30 Oct 2018 23:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeJaIED (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 04:04:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:33484 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727430AbeJaIED (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 04:04:03 -0400
Received: (qmail 28524 invoked by uid 109); 30 Oct 2018 23:08:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Oct 2018 23:08:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5213 invoked by uid 111); 30 Oct 2018 23:07:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Oct 2018 19:07:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2018 19:08:33 -0400
Date:   Tue, 30 Oct 2018 19:08:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Infinite loop regression in git-fsck in v2.12.0
Message-ID: <20181030230833.GA12950@sigill.intra.peff.net>
References: <20170113175944.tdbfqx3e4xhris7m@sigill.intra.peff.net>
 <878t2fkxrn.fsf@evledraar.gmail.com>
 <877ehzksjd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877ehzksjd.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 10:56:22PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > So maybe a good approach would be that we'd annotate all those test
> > whose fsck fails with "this is how it should fail", and run those tests
> > under GIT_TEST_FSCK=true, and GIT_TEST_FSCK=true would also be asserting
> > that no tests other than those marked as failing the fsck check at the
> > end fail it.
> [...]
> Jeff: Gotta turn in for the night, but maybe Something you're maybe
> interested in carrying forward for this fix? It's not that much work to
> mark up the failing tests, there's 10-20 of them from some quick
> eyeballing.

For this fix, I'd much rather add a specific test to the existing fsck
tests. Otherwise, we're relying on what a bunch of other tests happen to
be doing now, but there's little hope that they won't get refactored in
a way that puts a gap in our test coverage.

IOW, I think of things like GIT_TEST_FSCK as a kind of shotgun approach.
They may find things, and we should fix them and make sure it runs
clean. But ultimately, specific cases of interest should get their own
tests.

-Peff
