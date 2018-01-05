Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EFC21F406
	for <e@80x24.org>; Fri,  5 Jan 2018 07:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeAEHEN (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 02:04:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:53972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751056AbeAEHEM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 02:04:12 -0500
Received: (qmail 15047 invoked by uid 109); 5 Jan 2018 07:04:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Jan 2018 07:04:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2281 invoked by uid 111); 5 Jan 2018 07:04:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Jan 2018 02:04:43 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Jan 2018 02:04:10 -0500
Date:   Fri, 5 Jan 2018 02:04:10 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?54mb5pet?= <niuxu16@nudt.edu.cn>
Cc:     git@vger.kernel.org
Subject: Re: Patch recommendation for replace invoke of error() to that of
 error_errno()
Message-ID: <20180105070409.GA14251@sigill.intra.peff.net>
References: <950adae.6741.160c458ce64.Coremail.niuxu16@nudt.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <950adae.6741.160c458ce64.Coremail.niuxu16@nudt.edu.cn>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 05, 2018 at 11:24:02AM +0800, 牛旭 wrote:

> Our team researches on consistent update of Git during evolution. And
> we have figured out several spots that may be missed. 
> 
> 
> By mining historical patches, we suggest that invokes of error(...,
> strerror(errno)) should be replaced with that of error_errno(). One
> example for recommendation and corresponding patch are listed as
> follows. 

Yes, historically we've done cleanups like this across time as we touch
the various pieces of code. More conversions are welcome as long as they
don't conflict with any topics that other people are working on (a good
test is to see if your suggested changes merge cleanly with the "pu"
branch).

In more recent times, we've been using the Coccinelle tool to do
automated conversions across the code base. Look at the contents and
history of the contrib/coccinelle directory. This might be a candidate
for that cleanup.

> One example of missed spot:
> 
> 1  int cmd_fetch__tool(int argc, const char **argv, const char 
>   *prefix)
> 2  {
> ....
> 31  filename = git_path_fetch_head();
> 32  fp = fopen(filename, "a");
> 33  if (!fp)
> 34  return error("cannot open %s: %s", filename, strerror(errno));
> ....
>   }

This one is actually a bit funny. It's in contrib/examples, which is all
historical code. It's not compiled or used as part of Git (and I'd
suspect most of it would not compile at all these days). It's not really
worth modernizing.

> More recommendations and supporting patches are saved in attachments.
> It is so kind of you to reply me about the correctness of our
> suggestions. And thank you for your reading. 

Eek, word documents. We're happy to take patches, but please format them
as plain text in your email (e.g., by using git-send-email). More
details are in Documentation/SubmittingPatches. Thanks.

-Peff
