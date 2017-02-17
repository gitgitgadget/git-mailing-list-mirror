Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A79762013A
	for <e@80x24.org>; Fri, 17 Feb 2017 08:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755872AbdBQISM (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 03:18:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:56960 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755855AbdBQISK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 03:18:10 -0500
Received: (qmail 4540 invoked by uid 109); 17 Feb 2017 08:17:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 08:17:54 +0000
Received: (qmail 31936 invoked by uid 111); 17 Feb 2017 08:17:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 03:17:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 03:17:52 -0500
Date:   Fri, 17 Feb 2017 03:17:52 -0500
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] delete_ref(): support reflog messages
Message-ID: <20170217081752.oqozaaoscdwwzqce@sigill.intra.peff.net>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
 <20170217035800.13214-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170217035800.13214-1-kyle@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 10:57:57PM -0500, Kyle Meyer wrote:

> [Sorry for the slow response.]

No problem. The pace of open source varies wildly. :)

> >   - "git branch -m" does seem to realize when we are renaming HEAD,
> >     because it updates HEAD to point to the new branch name. But it
> >     should probably insert another reflog entry mentioning the rename
> >     (we do for "git checkout foo", even when "foo" has the same sha1 as
> >     the current HEAD).
> 
> I haven't worked out how to do this part yet.  I'm guessing the change
> will involve modifying split_head_update().
> 
> If this is added, should it be instead of, rather than in addition to,
> the deletion entry?  If a "Branch: renamed ..." entry is present, it
> doesn't seem like the deletion entry is providing any additional
> information.

I think you could do an "instead of" that goes from sha1 X to X, and
just mentions the rename. Or you could add a second entry after the
delete that takes it from 0{40} back to X.

I suspect the latter is easier to do, and I doubt anybody would care
that much of the exact form. These entries aren't really doing anything
for reachability. They're just giving an audit log of what happened. So
I don't think anybody would really care unless they were debugging a
confusing situation by hand. And as long as there's enough information
to figure out what happened, they'll be happy.

-Peff
