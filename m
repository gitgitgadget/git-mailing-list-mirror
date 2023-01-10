Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A91C54EBC
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 13:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbjAJNrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjAJNrd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 08:47:33 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF411C419
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:47:32 -0800 (PST)
Received: (qmail 17470 invoked by uid 109); 10 Jan 2023 13:47:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Jan 2023 13:47:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27698 invoked by uid 111); 10 Jan 2023 13:47:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Jan 2023 08:47:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Jan 2023 08:47:31 -0500
From:   Jeff King <peff@peff.net>
To:     Fredrik =?utf-8?B?w5ZiZXJn?= <fredrik@bakskuru.se>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: Bugreport: Prefix - is ignored when sorting (on committerdate)
Message-ID: <Y71scwT5d74Daw0E@coredump.intra.peff.net>
References: <CALDp=1EVmQE2NZAd7ccAT0z=R=2S8FvyJzsPNrDeXwdJkEW3Lg@mail.gmail.com>
 <CAN0heSprKD35P-D7GTVQ20eRsj0AriYEA7iCDnrA9GuiwX0snw@mail.gmail.com>
 <Y71Xnx2vmznV913I@coredump.intra.peff.net>
 <CAN0heSqvqnCHPa-RQ3JuxxP7M_k1ORYOAV9aG+8EuXvB1GZukw@mail.gmail.com>
 <CALDp=1GBtibTR5SvG8sOX14aODtdEJWhL_PCP1mzTLmX9V0sow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALDp=1GBtibTR5SvG8sOX14aODtdEJWhL_PCP1mzTLmX9V0sow@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2023 at 02:33:14PM +0100, Fredrik Öberg wrote:

> I am trying to understand what I did wrong. I guess you are saying
> that I tried to use the field committerdate, which is not available on
> the tags?

Right. The committerdate of a tag is a blank string, so sorting on it
was not doing anything.

> And that the handling of this situation has changed since
> git/2.23? Hence I got different results?

Sort of. Your committerdate sort was always doing nothing, but due to
the buggy way that the sort handled ties in 2.23 and older, it happened
to do a reverse refname sort instead of a forward refname sort. Now it
does a forward refname sort to break ties.

But the most important change for you is to actually do a real date
sort, so the tie-breaking should not be important either way.

-Peff
