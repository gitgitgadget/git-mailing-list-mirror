Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96041202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 16:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753590AbdJSQNr (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 12:13:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:57694 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753123AbdJSQNq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 12:13:46 -0400
Received: (qmail 25687 invoked by uid 109); 19 Oct 2017 16:13:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 16:13:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9393 invoked by uid 111); 19 Oct 2017 16:13:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 12:13:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 12:13:44 -0400
Date:   Thu, 19 Oct 2017 12:13:44 -0400
From:   Jeff King <peff@peff.net>
To:     Guillaume Castagnino <casta@xwing.info>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] use filetest pragma to work with ACL
Message-ID: <20171019161344.zmwgb2a2rziorffm@sigill.intra.peff.net>
References: <0102015f310e24b9-b96378f3-a029-4110-80dd-e454522e2cb7-000000@eu-west-1.amazonses.com>
 <20171018212451.goqxu4qq6aqe4tpl@sigill.intra.peff.net>
 <1508399608.4529.10.camel@xwing.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1508399608.4529.10.camel@xwing.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 09:53:28AM +0200, Guillaume Castagnino wrote:

> > This "use" will unconditionally at compile-time (such as "compile" is
> > for perl, anyway). Which raises a few questions:
> > 
> >   - would we want to use "require" instead to avoid loading when we
> >     don't enter this function?
> 
> I was under the impression that as this is a pragma affecting perl
> “compiler”, you have to always use “use”, not require, as the pragma
> initialisation has to be done before code is run.

Yeah, I think you're right.

> I quickly grepped the code, I did not see other calls that could
> benefits from the pragma, but it could be indeed nice to move it at the
> top to avoid future issues with such tests and POSIX ACL.

Makes sense.

> >   - Do all relevant versions of perl ship with filetest? According to
> >     Module::Corelist, it first shipped with perl 5.6. In general I
> > think
> >     we treat that as a minimum for our perl scripts, though I do
> > notice
> >     that the gitweb script says "use 5.008". I'm not sure how
> > realistic
> >     that is.
> 
> So the CGI already requires perl 5.8, so it’s fine I think.

Right, I totally forgot about perl's funny version-numbering scheme.

> Attached a cleanup proposal and moving the use at the top.

Thanks, it looks good to me.

For future reference, we usually prefer patches inline, separated by
"-- >8 --" scissors if there's other material (like your reply).

-Peff
