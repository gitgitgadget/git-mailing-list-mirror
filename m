Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86CF01F453
	for <e@80x24.org>; Mon, 24 Sep 2018 00:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeIXGmq (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 02:42:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:56810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726339AbeIXGmq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 02:42:46 -0400
Received: (qmail 31029 invoked by uid 109); 24 Sep 2018 00:43:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Sep 2018 00:43:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21802 invoked by uid 111); 24 Sep 2018 00:42:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 23 Sep 2018 20:42:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Sep 2018 20:43:08 -0400
Date:   Sun, 23 Sep 2018 20:43:07 -0400
From:   Jeff King <peff@peff.net>
To:     Stas Bekman <stas@stason.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git diff-tree ignores --textconv
Message-ID: <20180924004307.GA26103@sigill.intra.peff.net>
References: <41cd358c-d900-2996-b78a-b9d897a2ba2b@stason.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41cd358c-d900-2996-b78a-b9d897a2ba2b@stason.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 23, 2018 at 03:41:45PM -0700, Stas Bekman wrote:

> $ git config --get diff.jupyternotebook.command
> git-nbdiffdriver diff

That's an "external diff driver", not a textconv driver.

So here:

> $ GIT_TRACE=1 git diff-tree -p HEAD --textconv test/test.ipynb
> <shows normal diff, ignoring nbdiff>

You probably want "--ext-diff", not "--textconv".

There's some discussion in the gitattributes manpage, but the short of
it is that textconv converts binary input to text, which is then fed
through the normal diff mechanism. Whereas an external diff driver is
given both sides and can produce whatever output it wants. Textconv is
less flexible, but generally way easier to write.

-Peff
