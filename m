Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B020FC2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 23:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4F2206A1
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 23:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgDIX5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:57:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:38956 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726779AbgDIX5U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 19:57:20 -0400
Received: (qmail 22738 invoked by uid 109); 9 Apr 2020 23:57:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Apr 2020 23:57:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24732 invoked by uid 111); 10 Apr 2020 00:07:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2020 20:07:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Apr 2020 19:57:19 -0400
From:   Jeff King <peff@peff.net>
To:     Erwin Bonsma <erwin.bonsma@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Commit includes rename which was not staged, nor actually
 performed
Message-ID: <20200409235719.GA46281@coredump.intra.peff.net>
References: <CAG5PFTvqnR-aeJ=+4W5A5WKqJ8Wq3JsD7J5QjwprE+Nws+=YBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG5PFTvqnR-aeJ=+4W5A5WKqJ8Wq3JsD7J5QjwprE+Nws+=YBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 08, 2020 at 09:28:09PM +0200, Erwin Bonsma wrote:

> The branch includes the wrong commit. To reproduce it:
> > git reset --soft HEAD~1
> > git restore --staged de.xliff
> > git restore --staged Pending/it.xliff.todo
> > git restore de.xliff

There was a bug where git-restore didn't correctly invalidate the
cache-tree extension of the index, and could cause phantom changes to
end up in commits.

It was fixed by e701bab3e9 (restore: invalidate cache-tree when removing
entries with --staged, 2020-01-08), which is in v2.25.1 and up.

-Peff
