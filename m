Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 221D91F597
	for <e@80x24.org>; Thu, 19 Jul 2018 16:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbeGSRbH (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:31:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:52766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731661AbeGSRbG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:31:06 -0400
Received: (qmail 458 invoked by uid 109); 19 Jul 2018 16:47:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 16:47:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12484 invoked by uid 111); 19 Jul 2018 16:47:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 12:47:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 12:47:05 -0400
Date:   Thu, 19 Jul 2018 12:47:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Basin Ilya <basinilya@gmail.com>, git@vger.kernel.org
Subject: Re: Use different ssh keys for different github repos (per-url
 sshCommand)
Message-ID: <20180719164704.GB4868@sigill.intra.peff.net>
References: <44d3c280-3fb2-2415-46b7-343983e76e0b@gmail.com>
 <87zhynbd9z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhynbd9z.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 02:50:16PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I thought of writing a wrapper script to deduce the key from the arguments:
> >
> >     git@github.com git-upload-pack '/theorganization/privaterepo.git'
> >
> > Is this the only option?
> 
> Yes, I had a similar problem a while ago (which I sent an RFC patch for)
> which shows a script you can use:
> https://public-inbox.org/git/20180103102840.27897-1-avarab@gmail.com/
> 
> It would be nice if this were configurable. Instead of the way you
> suggested, it would be more general if we supported:
> 
>     [Include "remote:git@github.com:theorganization*"]
>     path = theorganization.config
> 
> Although I'm sure we'd have some interesting chicken & egg problems
> there when it comes to bootstrapping the config parsing.

I don't think we'd ever support this via the include mechanism. The
idea of "which remote are we looking at" is specific to a particular
part of an operation. Whereas config parsing is generally process-wide,
so it has to be based on a property of the whole process (like "which
directory are we in"). Maybe that's what you meant by chicken and egg.

If we were to make this more configurable, it would probably be more
like existing http.* config, which loads all the config, but then does
URL-specific matching when applying the config to a particular
operation.

-Peff
