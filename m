Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89EE320756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdAQVqe (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:46:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:40541 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbdAQVqd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:46:33 -0500
Received: (qmail 28921 invoked by uid 109); 17 Jan 2017 21:45:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 21:45:07 +0000
Received: (qmail 22265 invoked by uid 111); 17 Jan 2017 21:46:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 16:46:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 16:45:04 -0500
Date:   Tue, 17 Jan 2017 16:45:04 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH 0/2] Fix remote_is_configured()
Message-ID: <20170117214504.y7fnpkgnugbtdxpz@sigill.intra.peff.net>
References: <cover.1484687919.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1484687919.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 10:18:58PM +0100, Johannes Schindelin wrote:

> A surprising behavior triggered the bug report in
> https://github.com/git-for-windows/git/issues/888: the mere existence of
> the config setting "remote.origin.prune" (in this instance, configured
> via ~/.gitconfig so that it applies to all repositories) fooled `git
> remote rename <source> <target>` into believing that the <target> remote
> is already there.
> 
> This patch pair demonstrates the problem, and then fixes it (along with
> potential similar problems, such as setting an HTTP proxy for remotes of
> a given name via ~/.gitconfig).

I thought it was intentional that any config "created" the remote, even
without a url field. E.g., you can set:

  [remote "https://example.com/foo/git"]
  proxy = localhost:1234

and then a bare "git fetch https://example.com/foo/git" will respect it.

I admit that "prune" is probably useless without a fetch refspec,
though.

Note that I don't disagree that the rule "it's not a remote unless it
has a url" would be a lot saner. But I have a feeling you may be
breaking some existing setups.

I grepped around in the list but I couldn't find any relevant
discussion. So maybe I just dreamed it.

-Peff
