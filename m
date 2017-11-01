Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EC7D202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 18:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933234AbdKASuf (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 14:50:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:42982 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932685AbdKASue (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 14:50:34 -0400
Received: (qmail 22505 invoked by uid 109); 1 Nov 2017 18:50:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 18:50:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14437 invoked by uid 111); 1 Nov 2017 18:50:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 14:50:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Nov 2017 14:50:27 -0400
Date:   Wed, 1 Nov 2017 14:50:27 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Colorize matches for git log --grep=pattern?
Message-ID: <20171101185026.d4ljyywz3fepgoth@sigill.intra.peff.net>
References: <otc9a3$h9a$1@blaine.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <otc9a3$h9a$1@blaine.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 01, 2017 at 11:57:14AM +0100, Sebastian Schuberth wrote:

> is there a way to colorize / highlight the pattern matched by
> 
>     git log -E -i --grep=pattern
> 
> in the console output?

I don't think so. The grep code _does_ know about colorizing matches
(which is why "git grep --color" works), but for the output code path
for commit messages doesn't use grep at all (it couldn't, because we're
not just showing the relevant lines but selecting the whole commit).

So I think it would have to be reimplemented separately.

The best workaround I could come up with is passing the output through a
highlighting script:

  git log --grep=foo --color |
  perl -pe 's/foo/\x1b[1;31m$&\x1b[m/' |
  less

Pretty hacky.

-Peff
