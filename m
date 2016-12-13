Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 953C9203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 18:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933800AbcLMSQG (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 13:16:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:55867 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933938AbcLMSQF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 13:16:05 -0500
Received: (qmail 21660 invoked by uid 109); 13 Dec 2016 18:15:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 18:15:40 +0000
Received: (qmail 17066 invoked by uid 111); 13 Dec 2016 18:16:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 13:16:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 13:15:38 -0500
Date:   Tue, 13 Dec 2016 13:15:38 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] tmp-objdir: quote paths we add to alternates
Message-ID: <20161213181538.6gv4it4b33uhbuud@sigill.intra.peff.net>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
 <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
 <d83cd58f-9b52-cbc5-04dd-5aafe2822533@kdbg.org>
 <20161213114414.masgfo7lf7e3utym@sigill.intra.peff.net>
 <xmqqwpf34s5f.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpf34s5f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 10:10:04AM -0800, Junio C Hamano wrote:

> > -	git clone --bare . xxx:yyy.git &&
> > +	git clone --bare . xxx${path_sep}yyy.git &&
> 
> Don't you want to dq the whole thing to prevent the shell from
> splitting this into two commands at ';'?  The other one below is OK.

After expansion, I don't think the shell will do any further processing
except for whitespace splitting. E.g.:

  $ debug() { for i in "$@"; do echo "got $i"; done; }
  $ sep=';'
  $ space=' '
  $ debug foo${sep}bar
  got foo;bar
  $ debug foo${space}bar
  got foo
  got bar

I don't mind quoting it to make it more obvious, though.

-Peff
