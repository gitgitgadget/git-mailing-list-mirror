Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041F71F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 02:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbfDWCgx (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 22:36:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:37620 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729113AbfDWCgx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 22:36:53 -0400
Received: (qmail 14787 invoked by uid 109); 23 Apr 2019 02:36:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Apr 2019 02:36:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5040 invoked by uid 111); 23 Apr 2019 02:37:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 22:37:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 22:36:51 -0400
Date:   Mon, 22 Apr 2019 22:36:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] p5302: create the repo in each index-pack test
Message-ID: <20190423023651.GD16369@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx>
 <20190420035825.GB3559@sigill.intra.peff.net>
 <16052712.dFCfNLlQnN@mfick-lnx>
 <20190422205653.GA30286@sigill.intra.peff.net>
 <20190422211952.GA4728@sigill.intra.peff.net>
 <xmqqef5t7cil.fsf@gitster-ct.c.googlers.com>
 <20190423020749.GB16369@sigill.intra.peff.net>
 <xmqqv9z55udl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9z55udl.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 23, 2019 at 11:27:02AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> This is obviously inherited from the original, but do we get scolded
> >> by some versions of bash for this line, without quoting the source path
> >> of the redirection, i.e.
> >> 
> >> 	... --stdin <"$PACK"
> >
> > In general, yes, but I think we are OK in this instance because we
> > generated $PACK ourselves in the setup step, and we know that it is just
> > a relative .git/objects/pack/xyz.pack with no spaces.
> 
> I know we are OK, but the issue with some versions of bash AFAIU is
> that bash is not OK regardless of the contents of $variable that is
> not quoted and used as the target or the source of a redirection,
> issuing an unnecessary warning.

Is it? I thought the issue was specifically when there were spaces. I
get:

  $ bash
  $ file=ok
  $ echo foo >$file
  $ file='not ok'
  $ echo foo >$file
  bash: $file: ambiguous redirect

And that is AFAIK what the recent 7951a016a5 (t4038-diff-combined: quote
paths with whitespace, 2019-03-17) was about (because our trash
directory always has a space in it).

Did I miss a report where it happens on some versions even without
spaces? If so, we have quite a number of things to fix judging from the
output of:

  git grep '>\$'

-Peff
