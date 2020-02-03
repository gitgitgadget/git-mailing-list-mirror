Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00068C3524D
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 08:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C462F20658
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 08:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgBCIn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:43:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:51072 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726214AbgBCIn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 03:43:57 -0500
Received: (qmail 1432 invoked by uid 109); 3 Feb 2020 08:43:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Feb 2020 08:43:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23028 invoked by uid 111); 3 Feb 2020 08:52:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2020 03:52:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Feb 2020 03:43:56 -0500
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git 2.25 and failed self tests on OS X
Message-ID: <20200203084356.GB2164@coredump.intra.peff.net>
References: <CAH8yC8kXPi0teqdZ8NRJ677Z6btbmdafR=y4MFFaKZgZrB=d4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8kXPi0teqdZ8NRJ677Z6btbmdafR=y4MFFaKZgZrB=d4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 02, 2020 at 11:08:17PM -0500, Jeffrey Walton wrote:

> I'm seeing some self-tests failures building the 2.25 release tarball
> on OS X. I'm seeing it on the old PowerMac with OS X 10.5, and a
> modern Intel Mac with OS X 10.9. PowerMac failures are not too
> surprising, but the modern Mac should probably pass its self tests.
> 
> *** t3902-quoted.sh ***
> not ok 1 - setup
> #
> #
> #               mkdir "$FN" &&
> #               for_each_name "echo initial >\"\$name\"" &&
> #               git add . &&
> #               git commit -q -m Initial &&
> #
> #               for_each_name "echo second >\"\$name\"" &&
> #               git commit -a -m Second &&
> #
> #               for_each_name "echo modified >\"\$name\""

It's hard to see what's going on with this output. Try running:

  ./t3902-quoted.sh -v -x -i

to get more verbose output.

Looking at this test, it tries to create files with funny characters in
the names. Presumably your filesystem isn't happy with one or more of
them. The verbose output will probably make it clear which.

Version 10.9 isn't incredibly new, but these tests have been around a
long time. If OS X has a problem with these filenames, it seems odd for
it to be surfacing now.

Do you know what filesystem you're using? You aren't running the tests
by any chance on a network mount from a Windows machine?

-Peff
