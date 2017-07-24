Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3AAA203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 18:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755618AbdGXSTL (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 14:19:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:47352 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755065AbdGXSSh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 14:18:37 -0400
Received: (qmail 9270 invoked by uid 109); 24 Jul 2017 18:18:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 18:18:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11716 invoked by uid 111); 24 Jul 2017 18:18:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 14:18:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2017 14:18:36 -0400
Date:   Mon, 24 Jul 2017 14:18:36 -0400
From:   Jeff King <peff@peff.net>
To:     tonka tonka <tonka3100@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: change the filetype from binary to text after the file is
 commited to a git repo
Message-ID: <20170724181835.zo3lcv7pxmkif2jr@sigill.intra.peff.net>
References: <CAEor4NHDNL4CQP_FpCuJ_3F86-A3P8i=yvp1AZr-NKt0i1=cXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEor4NHDNL4CQP_FpCuJ_3F86-A3P8i=yvp1AZr-NKt0i1=cXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 07:11:06AM +0200, tonka tonka wrote:

> I have a problem with an already committed file into my repo. This git
> repo was converted from svn to git some years ago. Last week I have
> change some lines in a file and I saw in the diff that it is marked as
> binary (it's a simple .cpp file). I think on the first commit it was
> detected as an utf-16 file (on windows). But no matter what I do I
> can't get it back to a "normal text" text file (git does not detect
> that), but I is now only utf-8. I also replace the whole content of
> the file with just 'a' and git say it's binary.

Git doesn't store a flag for "binary-ness" on each file (though see
below). As the diffs are generated on the fly when you ask to compare
two versions, so too is the determination of "is this binary".

The default heuristic looks at file size (by default, if the file is
over 500MB it's considered binary) and whether it has any zero-byte
characters in the first few kilobytes. But note that if _either_ side of
a diff is considered binary, then Git won't show a text diff.

If you want a particular diff to show all content, even if it doesn't
look like text, add "-a" to your git invocation (e.g., "git show -a").

That said, you can also use .gitattributes (see "git help attributes")
to mark a file as binary or not-binary, skipping the heuristic check.
I'm guessing since you converted from svn that you don't have a
.gitattributes file, but it's possible that somebody later added one
that marks the file as binary (and so the solution would be to drop that
entry).

-Peff
