Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A82C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223FB61BF9
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhKQDH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:07:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:60730 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhKQDH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 22:07:26 -0500
Received: (qmail 21842 invoked by uid 109); 17 Nov 2021 03:04:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Nov 2021 03:04:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6626 invoked by uid 111); 17 Nov 2021 03:04:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 22:04:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 22:04:26 -0500
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
Message-ID: <YZRxOrv9JFt2oeSU@coredump.intra.peff.net>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-2-sandals@crustytoothpaste.net>
 <YZPOzqU0UQDVA57R@coredump.intra.peff.net>
 <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com>
 <YZQzqjWMzaWVkkfP@camp.crustytoothpaste.net>
 <00e001d7db40$985c61a0$c91524e0$@nexbridge.com>
 <YZRUzHVS32W4Flo/@camp.crustytoothpaste.net>
 <CAPUEspiHnTkwbUJ5o+fT2u4Kn+fwNe-3FoqVtNsjTF+Pg6Tryg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEspiHnTkwbUJ5o+fT2u4Kn+fwNe-3FoqVtNsjTF+Pg6Tryg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 05:50:44PM -0800, Carlo Arenas wrote:

> for the little amount of random data we need, it might be wiser to
> fallback to something POSIX like lrand48 which is most likely to be
> available, but of course your tests that consume lots of random data
> will need to change.

Unfortunately that won't help. You have to seed lrand48 with something,
which usually means pid and/or timestamp. Which are predictable to an
attacker, which was the start of the whole conversation. You really need
_some_ source of entropy, and only the OS can provide that.

> PS. Probably missing context as I don't know what was discussed
> previously, but indeed making this the libc problem by using mkstemp
> (plus some compatibility on top), like Peff mentioned seems like a
> more straightforward "fix"

It might be nice if it works. I don't recall all of the reasons that led
us to implement our own mkstemp in the first place. So the first step
would probably be digging in the history and the archive to find that
out, and whether it still applies.

-Peff
