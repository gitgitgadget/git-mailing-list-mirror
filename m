Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160D5C2BB55
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E853B2078B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414606AbgDOPQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:16:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:54550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2393356AbgDOPQy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 11:16:54 -0400
Received: (qmail 12504 invoked by uid 109); 15 Apr 2020 15:16:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Apr 2020 15:16:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4268 invoked by uid 111); 15 Apr 2020 15:27:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Apr 2020 11:27:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Apr 2020 11:16:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
Message-ID: <20200415151652.GB2464307@coredump.intra.peff.net>
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
 <20200415135627.vx75hsphbpmgrquv@chatter.i7.local>
 <xmqq1roo947y.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1roo947y.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 08:08:17AM -0700, Junio C Hamano wrote:

> Do these (and I think we saw other reports) make us rethink the
> status of protocol v2 as the default?  Are all of these fallouts 
> we saw so far easy-to-fix bugs, or are there more fundamental issues
> in the v2 protocol design?

I don't think we know yet.

I agree with Konstantin that the v2 switch is the likely culprit for
these issues, but without having been able to reproduce, I don't think
we know exactly what the problem is yet. It could be a protocol design
issue, or it could be a minor implementation bug.

Note that there is one other issue that's turned up, that I discussed
here:

  https://lore.kernel.org/git/20200328154936.GA1217052@coredump.intra.peff.net/

That's more fundamental to the v2 design, but:

  - it only happens when one side drops the connection, so it's not
    impacting normal operation (it does turn an error case into a hang,
    though, which can be rather annoying)

  - it's not in the network protocol itself, but rather the protocol
    between Git and the remote helper. So we could solve it purely as a
    client-side fix.

-Peff
