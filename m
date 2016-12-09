Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D03A2093C
	for <e@80x24.org>; Fri,  9 Dec 2016 13:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933054AbcLINps (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 08:45:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:54158 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932955AbcLINpr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 08:45:47 -0500
Received: (qmail 29720 invoked by uid 109); 9 Dec 2016 13:45:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 13:45:46 +0000
Received: (qmail 18299 invoked by uid 111); 9 Dec 2016 13:46:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 08:46:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Dec 2016 08:45:44 -0500
Date:   Fri, 9 Dec 2016 08:45:44 -0500
From:   Jeff King <peff@peff.net>
To:     Paul Boyle <paulcboyle@gmail.com>
Cc:     Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org
Subject: Re: Bug: git-sh-setup giving no such file or directory
Message-ID: <20161209134544.z2xbly5xjyito62w@sigill.intra.peff.net>
References: <CABZ0BffSi6h8Zhg8vjo1dZhxXg3fUt_U6TAtqMvpDShOX6HyyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABZ0BffSi6h8Zhg8vjo1dZhxXg3fUt_U6TAtqMvpDShOX6HyyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2016 at 12:00:36PM +0000, Paul Boyle wrote:

> There appears to be an issue with the latest master.
> 
> "git submodule init" is producing the following error:
> 
> /home/paul.boyle/bin/git/git-sh-setup: line 46:
> /home/paul.boyle/libexec/git-core/git-sh-i18n: No such file or
> directory

Hmm. Did you run "make install"? Or are you trying to run git directly
out of the build directory?

If the latter, that has been unsupported for a while, though it mostly
works. The "right" way is to either set up GIT_EXEC_PATH as appropriate,
or to just .../git/bin-wrappers into your $PATH.

> Broken sha: 8d7a455ed52e2a96debc080dfc011b6bb00db5d2
> 
> Checking out an older version works fine.
> 
> git checkout 'master@{2016-11-01 18:30:00}'
> 
> Sha: 3cdd5d19178a54d2e51b5098d43b57571241d0ab
> 
> This can be reproduced simply by:
> 
> make clean ; make ; git submodule init
> 
> 
> I didn't track it down further than to a commit sometime in the last month.

You could probably find the exact commit with git-bisect. However, I'd
be surprised if it is anything but 1073094f3 (git-sh-setup: be explicit
where to dot-source git-sh-i18n from., 2016-10-29). Before that commit,
we found git-sh-i18n in the $PATH, which would work if you were adding
git's build directory to your $PATH (but not work for people who
actually did an install).

-Peff
