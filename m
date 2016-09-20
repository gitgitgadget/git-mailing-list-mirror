Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA556207EC
	for <e@80x24.org>; Tue, 20 Sep 2016 23:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbcITXPg (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 19:15:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:45811 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753822AbcITXPg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 19:15:36 -0400
Received: (qmail 9182 invoked by uid 109); 20 Sep 2016 23:15:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Sep 2016 23:15:36 +0000
Received: (qmail 25942 invoked by uid 111); 20 Sep 2016 23:15:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Sep 2016 19:15:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Sep 2016 19:15:33 -0400
Date:   Tue, 20 Sep 2016 19:15:33 -0400
From:   Jeff King <peff@peff.net>
To:     Leandro Lucarella <leandro.lucarella@sociomantic.com>
Cc:     Mehul Jain <mehul.jain2029@gmail.com>, git@vger.kernel.org
Subject: Re: 2.10.0: git log --oneline prints gpg signatures in 4 lines
Message-ID: <20160920231533.fxcdjgphz25hnbxt@sigill.intra.peff.net>
References: <20160920170954.38b24284@labs-064.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160920170954.38b24284@labs-064.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2016 at 05:09:54PM +0200, Leandro Lucarella wrote:

> Hi, starting from 2.10.0 I noticed that when using git log --oneline,
> if commits are signed with GPG, now the signatures are printed too, and
> it takes 3 lines for the signature information + 1 line for the title
> of the commit, so suddenly --oneline became --fourline :)
> 
> Is this really intended?

I don't think anything has changed here in 2.10. Running "git log
--oneline --show-signature" has _always_ been horribly ugly. However,
2.10 did introduce the "log.showsignature" config, which makes "git log
--oneline" pretty unusable when it is enabled. Ditto for one-liner uses
of "--format".

I think we should probably ignore the config entirely when using any of
the one-liner formats (and I'd include --format, too, even though it can
sometimes be multi-line; it already has %GG to include that information
as appropriate).

Another option would be to somehow represent the signature information
in the --oneline output, but I think I'd rather leave that for people to
experiment with using "--format".

-Peff
