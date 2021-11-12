Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D239C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854D7610F8
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhKLVbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:31:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:58340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233990AbhKLVbO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:31:14 -0500
Received: (qmail 4631 invoked by uid 109); 12 Nov 2021 21:28:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Nov 2021 21:28:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15620 invoked by uid 111); 12 Nov 2021 21:28:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Nov 2021 16:28:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 12 Nov 2021 16:28:21 -0500
From:   Jeff King <peff@peff.net>
To:     6a50120e@schuerz.at
Cc:     git@vger.kernel.org
Subject: Re: Password for proxies from external
Message-ID: <YY7cdTC2HWOoe56z@coredump.intra.peff.net>
References: <5743c211-bf8b-b485-3b81-a71b1b64bb4d@schuerz.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5743c211-bf8b-b485-3b81-a71b1b64bb4d@schuerz.at>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 12, 2021 at 02:07:03PM +0100, 6a50120e@schuerz.at wrote:

> when i want to set a http-proxy for git, the configuration goes to
> ~/.gitconfig
> 
> ```
> [http]
>     proxy = http://username:password@proxy.dings.bums:1234
> 
> ```
> 
> So the proxy password is in cleartext written down to the config-file. The
> git own password-store can not be used... even no external like pass.

Have you tried including just the username, like:

  [http]
  proxy = http://username@example.com:1234

That should prompt for the password, including using your regular
configured credential helpers; see 372370f167 (http: use credential API
to handle proxy authentication, 2016-01-26).

We don't recognize HTTP 407 ("Proxy Authentication Required") to trigger
the username/password lookup, like we do for an HTTP 401. That probably
wouldn't be much code to add, but I suspect it's less important for a
proxy versus a regular site because you only use one proxy (and it
either needs auth or it doesn't).

-Peff
