Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38BDC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5AEA61166
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhIUWBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:01:35 -0400
Received: from silly.haxx.se ([159.253.31.95]:40038 "EHLO silly.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235766AbhIUWBd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:01:33 -0400
Received: by silly.haxx.se (Postfix, from userid 1001)
        id 127B75F8E2; Wed, 22 Sep 2021 00:00:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by silly.haxx.se (Postfix) with ESMTP id 0BF367FA80;
        Wed, 22 Sep 2021 00:00:03 +0200 (CEST)
Date:   Wed, 22 Sep 2021 00:00:03 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@silly
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
In-Reply-To: <YUoorS6UwA1DmwBm@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.2109212351440.26668@fvyyl>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net> <YUoorS6UwA1DmwBm@coredump.intra.peff.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 21 Sep 2021, Jeff King wrote:

> I cc'd you here mostly as an FYI. I think Git was doing the wrong thing
> in assuming case here (we're only expecting these particular headers
> coming from the client, but for response headers, I thnk curl will give
> us whatever form the server sent us).

That'd be correct, yes.

> But certainly I found the behavior surprising. :) I'd guess it's because 
> HTTP/2 is sending some binary goo instead of text headers, and the names we 
> get are just coming from some lookup table? Or maybe I'm just showing my 
> ignorance of HTTP/2.
>
> At any rate, I wonder if it would be friendlier for curl to hand strings
> to the debug function with the usual capitalization.

Maybe that could've been a good idea if we had done it when we introduced 
HTTP/2 support. Now, I think that ship has sailed already as libcurl has 
supported HTTP/2 since late 2013 and changing anything like that now will just 
risk introducing the reverse surprise in applications. Better not rock that 
boat now methinks.

> PS This nit aside, it is totally cool that I have been seamlessly using
>   HTTP/2 to talk to github.com without even realizing it. I wonder for
>   how long!

I don't know when github.com started supporting h2, but since libcurl 7.62.0 
(released Oct 31, 2018) it has negotiated h2 by default over HTTPS.

-- 

  / daniel.haxx.se
