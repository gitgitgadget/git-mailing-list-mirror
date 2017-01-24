Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA081F437
	for <e@80x24.org>; Tue, 24 Jan 2017 23:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750905AbdAXXFD (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 18:05:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:44168 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbdAXXFD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 18:05:03 -0500
Received: (qmail 13199 invoked by uid 109); 24 Jan 2017 23:05:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 23:05:02 +0000
Received: (qmail 6712 invoked by uid 111); 24 Jan 2017 23:05:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 18:05:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jan 2017 18:05:00 -0500
Date:   Tue, 24 Jan 2017 18:05:00 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] difftool.c: mark a file-local symbol with static
Message-ID: <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net>
References: <3e6a6685-19ec-4536-4a5f-3a56e30fb530@ramsayjones.plus.com>
 <20161130231848.v5ge6otytim2t6d2@sigill.intra.peff.net>
 <xmqqinr4bkf4.fsf@gitster.mtv.corp.google.com>
 <59da5383-16a0-b327-75a8-b4c4ad7bd479@ramsayjones.plus.com>
 <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net>
 <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com>
 <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net>
 <20170122052608.tpr5pihfgafhoynj@gmail.com>
 <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net>
 <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 01:52:13PM -0800, Junio C Hamano wrote:

> > I dunno. As ugly as the "%s" thing is in the source, at least it doesn't
> > change the output. Not that an extra space is the end of the world, but
> > it seems like it's letting the problem escape from the source code.
> >
> > Do people still care about resolving this? -Wno-format-zero-length is in
> > the DEVELOPER options. It wasn't clear to me if that was sufficient, or
> > if we're going to get a bunch of reports from people that need to be
> > directed to the right compiler options.
> 
> I view both as ugly, but probably "%s", "" is lessor of the two
> evils.
> 
> Perhaps
> 
> 	#define JUST_SHOW_EMPTY_LINE "%s", ""
> 
> 		...
> 		warning(JUST_SHOW_EMPTY_LINE);
>                 ...
> 
> or something silly like that?

Gross, but at least it's self documenting. :)

I guess a less horrible version of that is:

  static inline warning_blank_line(void)
  {
	warning("%s", "");
  }

We'd potentially need a matching one for error(), but at last it avoids
macro trickery.

-Peff
