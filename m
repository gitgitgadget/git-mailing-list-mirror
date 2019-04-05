Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05AFC20248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfDESYO (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:24:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:48830 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730329AbfDESYO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:24:14 -0400
Received: (qmail 11773 invoked by uid 109); 5 Apr 2019 18:24:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:24:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28545 invoked by uid 111); 5 Apr 2019 18:24:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:24:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:24:12 -0400
Date:   Fri, 5 Apr 2019 14:24:12 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190405182412.GC2284@sigill.intra.peff.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405105033.GT32732@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 12:50:33PM +0200, SZEDER Gábor wrote:

> > +test_expect_failure 'traverse unexpected non-tree entry (seen)' '
> > +	test_must_fail git rev-list --objects $blob $broken_tree >output 2>&1
> 
> This test saves standard output and error, but doesn't look at them.

I think we want to be checking for "not a tree" here, which is later
added with the fix. But either we should have the test_i18ngrep here
initially, or we should add both the redirect and the grep with the fix.

> > +test_expect_success 'setup unexpected non-commit parent' '
> > +	git cat-file commit $commit |
> > +		perl -lpe "/^author/ && print q(parent $blob)" \
> > +		>broken-commit &&
> 
> Don't run git commands upstream of a pipe, because the pipe hides
> their exit code.  This applies to several other tests below as well.

I disagree with that rule here. We're not testing "cat-file" in any
meaningful way, but just getting some stock output from a known-good
commit.

> Wouldn't a 'sed' one-liner suffice, so we won't have yet another perl
> dependency?

Heh, this was actually the subject of much discussion before the patches
hit the list. If you can write such a one-liner that is both readable
and portable, please share it. I got disgusted with sed and suggested
this perl.

-Peff
