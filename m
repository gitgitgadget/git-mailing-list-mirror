Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A4231F404
	for <e@80x24.org>; Thu,  5 Apr 2018 16:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeDEQca (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 12:32:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:54692 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751275AbeDEQc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 12:32:29 -0400
Received: (qmail 29541 invoked by uid 109); 5 Apr 2018 16:32:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Apr 2018 16:32:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16742 invoked by uid 111); 5 Apr 2018 16:33:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Apr 2018 12:33:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2018 12:32:27 -0400
Date:   Thu, 5 Apr 2018 12:32:27 -0400
From:   Jeff King <peff@peff.net>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: How to undo previously set configuration?
Message-ID: <20180405163227.GA25224@sigill.intra.peff.net>
References: <20180405092358.569e0315.olaf@aepfle.de>
 <874lkq11ug.fsf@evledraar.gmail.com>
 <20180405104948.276de0ca.olaf@aepfle.de>
 <8737092929.fsf@evledraar.gmail.com>
 <20180405152525.13d1c776.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180405152525.13d1c776.olaf@aepfle.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 03:25:25PM +0200, Olaf Hering wrote:

> Am Thu, 05 Apr 2018 13:21:02 +0200
> schrieb Ævar Arnfjörð Bjarmason <avarab@gmail.com>:
> 
> > I'm assuming you mean something like:
> >         [user]
> >         # This is an error
> >         -email
> 
> Yes. Just some flag to say "whatever value this variable has from
> earlier parsing, forget it in case it really exists". Just like "unset
> PATH" in bash.
> 
> I do not know the git internals, so can not really help with the case.

The general strategy in Git's config is that instead of "unsetting", you
should overwrite with whatever value you _do_ want. So a config option
like sendemail.smtpauth should accept some kind of empty or "none" value
to disable auth.

Most single-value config options should work this way (and if one
doesn't, I'd say that's a bug we should fix).

Multi-valued config (e.g., "remote.*.fetch") is harder, since it's
inherently a list where each new instance adds to the list. We've
discussed there having an empty value reset the list, but it's not
applied consistently.

-Peff
