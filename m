Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99AC01F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeG3RNF (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:13:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:35482 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726663AbeG3RNF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:13:05 -0400
Received: (qmail 32616 invoked by uid 109); 30 Jul 2018 15:37:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Jul 2018 15:37:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19552 invoked by uid 111); 30 Jul 2018 15:37:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 30 Jul 2018 11:37:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jul 2018 11:37:31 -0400
Date:   Mon, 30 Jul 2018 11:37:31 -0400
From:   Jeff King <peff@peff.net>
To:     Jeremy Morton <admin@game-point.net>
Cc:     git@vger.kernel.org
Subject: Re: Strange bug with "git log" - pdftotext?
Message-ID: <20180730153731.GA25797@sigill.intra.peff.net>
References: <5B5F096A.7030404@game-point.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B5F096A.7030404@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 01:49:46PM +0100, Jeremy Morton wrote:

> I'm trying to search my git log history for a particular term -
> "unobtrusive" - so I run this command:
> 
> git log -S unobtrusive --oneline
> 
> When I do this, this is displayed and I'm in an interactive less terminal or
> something:
> 
> pdftotext version 4.00
> [...]

That's definitely weird.

My guess is that the repository has some .gitattributes set up to diff
pdf files in a particular way, and you have some matching config that
tries to call pdftotext.

What does:

  git config --list | grep ^diff

say? I'd expect to see an external or textconv option there running
pdftotext.

Another option is that your pager is somehow set up to call pdftotext,
but that seems much more nonsensical to use the tool there (but try "git
var GIT_PAGER" and "git config pager.log" to check).

-Peff
