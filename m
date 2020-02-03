Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E182C33CAC
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 11:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CC320658
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 11:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgBCLCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:02:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:51172 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727066AbgBCLCv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 06:02:51 -0500
Received: (qmail 1956 invoked by uid 109); 3 Feb 2020 11:02:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Feb 2020 11:02:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23693 invoked by uid 111); 3 Feb 2020 11:10:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2020 06:10:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Feb 2020 06:02:49 -0500
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git-compat-util.h:798:13: =?utf-8?Q?er?=
 =?utf-8?B?cm9yOiBjb25mbGljdGluZyB0eXBlcyBmb3Ig4oCYaW5ldF9udG9w4oCZ?=
Message-ID: <20200203110249.GA4153124@coredump.intra.peff.net>
References: <CAH8yC8m3JFvEcfFF3z1rrRnEPK-adHGObmkOhNZiph7QJKUWqA@mail.gmail.com>
 <CAH8yC8mh0gysNz3Dbrph0f8KZ8DEWaH-6rWg6fSOD-_aGh3=3A@mail.gmail.com>
 <20200203085405.GC2164@coredump.intra.peff.net>
 <CAH8yC8mmNXGw13zkrmxxJFQKEsmGqkKHFp13+U7==umHM2WR_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8mmNXGw13zkrmxxJFQKEsmGqkKHFp13+U7==umHM2WR_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 05:46:53AM -0500, Jeffrey Walton wrote:

> Below is from configure.ac around line 720
> (https://github.com/git/git/blob/master/configure.ac#L722).
> 
> I think the test program needs to include <arpa/inet.h>.

I don't know very much about autoconf, but I'm not sure we need to worry
about the header. Looking at the generated "configure" script, I think
it puts in a dummy prototype, and just confirms that the linker is able
to find it (the resulting test-program would obviously behave poorly,
but we don't try to run it).

> Then, if the current -lresolv test fails, configure should use the
> same program and check -lsocket -lnls.

Yeah, that makes sense. Though there is a test above for -lsocket, and
if it works, then we put "-lsocket" into $LIBS in the configure script.
And I _think_ that means that subsequent tests would already be trying
with -lsocket, and we might just need a similar test for -lnsl (but
again, my autoconf is quite rusty).

You might get more information by looking at the output in config.log to
see the actual compiler/linker output during the inet_ntop test, and why
the link fails.

-Peff
