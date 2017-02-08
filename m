Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71CF71FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 19:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbdBHTub (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 14:50:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:51706 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbdBHTu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 14:50:29 -0500
Received: (qmail 23977 invoked by uid 109); 8 Feb 2017 19:50:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 19:50:24 +0000
Received: (qmail 23573 invoked by uid 111); 8 Feb 2017 19:50:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 14:50:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 14:50:22 -0500
Date:   Wed, 8 Feb 2017 14:50:22 -0500
From:   Jeff King <peff@peff.net>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] mailmap.blob overrides default .mailmap
Message-ID: <20170208195022.6kqpgit3lkvskxta@sigill.intra.peff.net>
References: <77c0182b-8c4f-9727-f56f-d8e2bad8146d@tngtech.com>
 <CAGZ79kZ=ikbYpuK6E=ui1ju=bRavcVcxb3AA_dvb2Jp6cRNmJQ@mail.gmail.com>
 <20170207192801.qoncjaqjpn3axpyn@sigill.intra.peff.net>
 <53836bcd-1d4d-13fb-a523-1258017d19c9@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53836bcd-1d4d-13fb-a523-1258017d19c9@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 07, 2017 at 11:45:31PM +0100, Cornelius Weig wrote:

> On the other hand, a checked-in .mailmap file and a mailmap-blob are
> both as in-history as the other to me. Now consider the following
> settings:

I think it depends how you use them. You could point mailmap.blob to
some other ref entirely (even one that you fetched from another
repository).

I'd expect normal use to point it to HEAD:.mailmap, though (and that was
certainly the use case I wrote it for). On the other hand, the point of
pointing it to that particular blob is that it works even when you
_don't_ have a checkout (and this kicks in automatically in a bare
repo).

> $ git config --unset mailmap.file
> $ git config mailmap.blob HEAD:.mailmap
> $ sed -i 's:peff@peff.com:no-valid-address:' .mailmap
> $ git log -1 --author 'Jeff King'

In case anybody wants to experiment, there are a bunch of things that
make this a non-working example (at least on git.git):

  - my address is actually peff.net :)

  - There mailmap which mentions peff.net maps peff@github.com to
    peff.net, so this change would require --author=peff@github.com.

  - We don't apply mailmaps for the default output of "git log". You can
    format with "%aN %aE", or just use "git shortlog -ns --author=peff"
    which does map.

But that aside, yeah, you can make an argument to expect one way or the
other, depending on the situation you set up. I don't have a strong
feeling about it, but my gut feeling is that no ordering is
significantly better than the other, and that puts me in favor of
leaving it as-is purely out of inertia and backwards-compatibility.

-Peff
