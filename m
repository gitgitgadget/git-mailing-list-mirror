Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 545A21FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933797AbcK3Xqr (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:46:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:49382 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933268AbcK3Xqo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:46:44 -0500
Received: (qmail 26148 invoked by uid 109); 30 Nov 2016 23:46:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 23:46:39 +0000
Received: (qmail 27076 invoked by uid 111); 30 Nov 2016 23:47:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 18:47:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 18:46:36 -0500
Date:   Wed, 30 Nov 2016 18:46:36 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161130234636.6az7xfywzprpn6ly@sigill.intra.peff.net>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
 <20161130195427.GA166433@google.com>
 <20161130232823.GA192901@google.com>
 <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
 <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
 <20161130234248.GB192901@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161130234248.GB192901@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 03:42:48PM -0800, Brandon Williams wrote:

> > where 20813 and 20867 are two threads of the main process. One is doing
> > the lstat and the other calls chdir at the same moment.
>
> Yeah so it looks like the start_command function calls chdir.  Which
> means any uses of the run-command interface are not thread safe....

That seems crazy. The chdir should be happening on the child side of the
fork (and looking at the code, it seems to be the case). And on the
Windows side, without fork, it's an option to the spawn call, which
makes sense.

> For now the work around could be to just pass "-C <dir>" to the child
> process instead of relying on run-command to chdir.

Yeah, that would push it after the exec. I just don't understand why
that would be necessary.

-Peff
