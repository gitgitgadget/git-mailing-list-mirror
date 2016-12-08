Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD63A1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 17:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbcLHRqf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 12:46:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:53734 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751064AbcLHRqe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 12:46:34 -0500
Received: (qmail 21853 invoked by uid 109); 8 Dec 2016 17:46:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Dec 2016 17:46:33 +0000
Received: (qmail 11410 invoked by uid 111); 8 Dec 2016 17:47:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Dec 2016 12:47:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2016 12:46:33 -0500
Date:   Thu, 8 Dec 2016 12:46:33 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     vi0oss <vi0oss@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned
 submodules
Message-ID: <20161208174633.bsktiflql6jpn5t3@sigill.intra.peff.net>
References: <20161208003940.28794-1-vi0oss@gmail.com>
 <CAGZ79kZU401JRp4EtwTGHzk3Zq+snQhX3GArDfF6SpKxsSwtWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZU401JRp4EtwTGHzk3Zq+snQhX3GArDfF6SpKxsSwtWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2016 at 05:22:30PM -0800, Stefan Beller wrote:

> On Wed, Dec 7, 2016 at 4:39 PM,  <vi0oss@gmail.com> wrote:
> 
> >
> >     Previously test contained errorneous
> >     test_must_fail, which was masked by
> >     missing &&.
> 
> I wonder if we could make either
> the test_must_fail intelligent to detect such a broken && call chain
> or the test_expect_success macro to see for those broken chains.

I don't think test_must_fail is relevant for &&-chains. Even something
like:

  test_must_fail foo
  bar

or:

  bar
  test_must_fail foo

will both trigger on the &&-chain linter, because it uses a magic exit
code to detect the breakage. I think the problem is just that the
&&-chain linter cannot peek inside subshells, and that's where the bug
was in this case.

I wish we could improve that, but I spend a lot of brain cycles on it at
one point and couldn't come up with a workable solution.

-Peff
