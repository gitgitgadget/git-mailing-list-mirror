Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1BDC2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0E9206CB
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfLUTbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:31:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:51838 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726107AbfLUTbL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 14:31:11 -0500
Received: (qmail 8852 invoked by uid 109); 21 Dec 2019 19:31:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Dec 2019 19:31:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21457 invoked by uid 111); 21 Dec 2019 19:35:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Dec 2019 14:35:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 21 Dec 2019 14:31:10 -0500
From:   Jeff King <peff@peff.net>
To:     Tom Miller <jackerran@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Propose promoting 'contrib/rerere-train.sh' to command
Message-ID: <20191221193110.GB3339249@coredump.intra.peff.net>
References: <BZAQIE4YND2I.Z7BFCW7BLH3K@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BZAQIE4YND2I.Z7BFCW7BLH3K@penguin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 08:17:57PM -0600, Tom Miller wrote:

> I would like to propose promoting 'contrib/rerere-train.sh' to one of the
> following:
> 
>     1. A builtin c command 'builtin/rerere-train.c'
>     2. To the top level directory as a built in script 'git-rerere-train.sh'
> 
> I have recently found myself writing scripts using 'contrib/rerere-train.sh'
> and I wish it was built into the command. This would make it easier to use
> rather than having to find it on different platforms. I think it could also
> benefit from some documentation.
> 
> I am trying to gauge the interest in this change before spending some time on
> working on it. I would also appreciate feedback or alternative approaches to
> what I have suggested. Thank you for your time.

The situations where I need rerere-train don't come up often, but when
they do, it has always worked easily and without hiccups for me. So
perhaps there are lurking gotchas that Junio might know about, but AFAIK
the quality is high enough for it to be part of normal Git.

I'd suggest converting it to C and making it a sub-command of rerere
(i.e., "git rerere train a..b") rather than a separate command.

It would be a nice bonus if it could do its work internally by looking
at the commits, rather than munging the working tree through checkout
and merge. I'm not sure how easy that would be, though. Historically the
merge-recursive machinery has not worked well without having a working
tree to dump the conflicted paths into, but I think that has gotten
somewhat better recently. So even a straight C conversion of the shell
script would be an OK starting point, I think.

-Peff
