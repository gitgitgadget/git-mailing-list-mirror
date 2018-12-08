Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C025520A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 07:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeLHH3R (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 02:29:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:34688 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726084AbeLHH3R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 02:29:17 -0500
Received: (qmail 14621 invoked by uid 109); 8 Dec 2018 07:29:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 08 Dec 2018 07:29:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5735 invoked by uid 111); 8 Dec 2018 07:28:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 08 Dec 2018 02:28:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Dec 2018 02:29:15 -0500
Date:   Sat, 8 Dec 2018 02:29:15 -0500
From:   Jeff King <peff@peff.net>
To:     biswaranjan panda <biswaranjan.nitrkl@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org
Subject: Re: Retrieving a file in git that was deleted and committed
Message-ID: <20181208072915.GA20697@sigill.intra.peff.net>
References: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
 <CAGyf7-FUHMEq_FfPNrH6uT2b-nCd_wi=Aww+OUuoDem11DROGA@mail.gmail.com>
 <CADHAf1Y8or_frf=Ecu-82z-jo06NKe7oqo1cxtsZsOxhKKxjAw@mail.gmail.com>
 <20181207072004.GA32603@sigill.intra.peff.net>
 <CAGyf7-EkyGOi02fqMcCPBzj-=wpsH4zCgvP5VhOoKMdG+wfoLw@mail.gmail.com>
 <CADHAf1bH5Aaw3-5WvoHawjXUXL9B-YNvh+AYU1fpGbUe=c0E+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADHAf1bH5Aaw3-5WvoHawjXUXL9B-YNvh+AYU1fpGbUe=c0E+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 07, 2018 at 01:50:57PM -0800, biswaranjan panda wrote:

> Thanks Jeff and Bryan! However, I am curious that if there were a way
> to tell git blame to skip a commit (the one which added the file again
> and maybe the one which deleted it originally) while it walks back
> through history, then it should just get back the
> entire history right ?

Not easily. ;)

You can feed a set of revisions to git-blame with the "-S" option, but I
don't offhand know how it handles diffs (I think it would have to still
diff each commit against its parent, since history is non-linear, and a
list is inherently linear). You might want to experiment with that.

Other than that, you can play with git-replace to produce a fake
history, as if the deletion never happened. But note that will affect
all commands, not just one particular blame. It might be a neat way to
play with blame, but I doubt I'd leave the replacement in place in the
long term.

-Peff
