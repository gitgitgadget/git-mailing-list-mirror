Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6F3C77B73
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 01:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjFFB52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 21:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjFFB50 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 21:57:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CBF123
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 18:57:23 -0700 (PDT)
Received: (qmail 23930 invoked by uid 109); 6 Jun 2023 01:57:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Jun 2023 01:57:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1932 invoked by uid 111); 6 Jun 2023 01:57:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Jun 2023 21:57:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Jun 2023 21:57:21 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Hanno =?utf-8?B?QsO2Y2s=?= <hanno@hboeck.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: git push --quiet is not quiet
Message-ID: <20230606015721.GA89456@coredump.intra.peff.net>
References: <20230519101505.416d0963.hanno@hboeck.de>
 <20230519090559.GA3515410@coredump.intra.peff.net>
 <ZH3IufbB/mJBBKsv@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZH3IufbB/mJBBKsv@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 05, 2023 at 07:36:25AM -0400, Taylor Blau wrote:

> I mentioned this to the team that is working on spokes-receive-pack, and
> they have graciously implemented support for the quiet capability here:
> 
>   https://github.com/github/spokes-receive-pack/pull/49
> 
> Hopefully that gets merged and rolled out soon, at which point I think
> we can call it a day here.

Ah, cool, I didn't realize the implementation was open source. That pull
request looks like what I'd expect (from my obviously brief look at the
code).

I wondered that it did not pass along any kind of "quiet" designation to
the hooks (who might want to be less chatty in that case). But it
doesn't look like git-receive-pack does, either. So at least
spokes-receive-pack will be on par with git.git. :)

I do think it would be a potentially useful feature for receive-pack to
pass on the information that it got a "quiet" capability request from
the client (probably through the environment). But if people aren't
complaining about it, it's probably not a high priority.  The only
discussion I could find was this thread from a few years ago:

  https://lore.kernel.org/git/ba70b25b-906c-0117-2594-c606595c6816@redhat.com/

but it didn't result in a patch (the code change itself is probably a
one-liner setenv(), but we'd want documentation, tests, etc).

-Peff
