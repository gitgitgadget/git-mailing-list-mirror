Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8361F404
	for <e@80x24.org>; Mon, 12 Mar 2018 23:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbeCLXkk (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 19:40:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:54732 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751333AbeCLXkj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 19:40:39 -0400
Received: (qmail 13671 invoked by uid 109); 12 Mar 2018 23:40:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Mar 2018 23:40:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19089 invoked by uid 111); 12 Mar 2018 23:41:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Mar 2018 19:41:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Mar 2018 19:40:37 -0400
Date:   Mon, 12 Mar 2018 19:40:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        git@jeffhostetler.com, jonathantanmy@google.com, bmwill@google.com,
        stolee@gmail.com, sbeller@google.com, johannes.schindelin@gmx.de
Subject: Re: Git Merge contributor summit notes
Message-ID: <20180312234037.GE1968@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
 <87efksqe3p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87efksqe3p.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 10, 2018 at 02:01:14PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >  - (peff) Time to deprecate the git anonymous protocol?
> [...]
> 
> I think the conclusion was that nobody cares about the git:// protocol,
> but people do care about it being super easy to spin up a server, and
> currently it's easiest to spin up git://, but we could also ship with
> some git-daemon mode that had a stand-alone webserver (or ssh server) to
> get around that.

I don't think keeping support for git:// is too onerous at this point
(especially because it should make the jump to protocol v2 with the
rest). But it really is a pretty dated protocol, lacking any kind of
useful security properties (yes, I know, if we're all verifying signed
tags it's great, but realistically people are fetching the tip of master
over a hijack-able TCP connection and running arbitrary code on the
result). It might be nice if it went away completely so we don't have to
warn people off of it.

The only thing git:// really has going over git-over-http right now is
that it doesn't suffer from the stateless-rpc overhead. But if we unify
that behavior in v2, then any advantage goes away.

I do agree we should have _something_ that is easy to spin up. But it
would be wonderful if git-over-http could become that, and we could just
deprecate git://. I suppose it's possible people build clients without
curl, but I suspect that's an extreme minority these days (most third
party hosters don't seem to offer git:// at all).

-Peff
