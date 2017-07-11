Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBB8E202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 13:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755907AbdGKNyc (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 09:54:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:37034 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755904AbdGKNyc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 09:54:32 -0400
Received: (qmail 10499 invoked by uid 109); 11 Jul 2017 13:54:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 13:54:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16832 invoked by uid 111); 11 Jul 2017 13:54:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 09:54:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 09:54:29 -0400
Date:   Tue, 11 Jul 2017 09:54:29 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 2/7] git.c: let builtins opt for handling `pager.foo`
 themselves
Message-ID: <20170711135429.3vq55amejo37mtjy@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <62a5a588d880d1a41d6cdd54cd92ee577a0451fa.1499723297.git.martin.agren@gmail.com>
 <20170711102451.27r3yaa2mgjgk4qv@sigill.intra.peff.net>
 <CAN0heSqLX1WNk3KC9U3f=qem0SYV-g=-HU+XHepi_CbuHatCOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqLX1WNk3KC9U3f=qem0SYV-g=-HU+XHepi_CbuHatCOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 03:46:08PM +0200, Martin Ågren wrote:

> > Can this ever trigger in execv_dashed_external()? We should only get
> > there if get_builtin() returned NULL in the first place. Otherwise, we'd
> > run and exited via handle_builtin().
> 
> I can trigger it with this:
> 
> $ git -c pager.tag="echo paging" -c pager.tag.list=no -c alias.t=tag t -l
> 
> where the alias is what triggers it and the two pager-configurations
> demonstrate the effect.

Interesting. As you noted below, I think the dashed external we exec
should be choosing whether to run the pager. I suspect what's happening
is that execv_dashed_external() says "a-ha, we're running 'tag', and I
know how to check its pager config". But IMHO that is wrong in the first
place (but it just never really made a difference until your series).

That's just a guess, though. I didn't dig.

-Peff
