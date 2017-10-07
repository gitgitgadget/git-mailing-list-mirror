Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70ED42036B
	for <e@80x24.org>; Sat,  7 Oct 2017 19:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbdJGTiI (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 15:38:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:36422 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751309AbdJGTiH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 15:38:07 -0400
Received: (qmail 15317 invoked by uid 109); 7 Oct 2017 19:38:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Oct 2017 19:38:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3773 invoked by uid 111); 7 Oct 2017 19:38:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Oct 2017 15:38:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Oct 2017 15:38:05 -0400
Date:   Sat, 7 Oct 2017 15:38:05 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Todd Zullinger <tmz@pobox.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
Message-ID: <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain>
 <20171007190402.GH3382@zaya.teonanacatl.net>
 <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
 <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 07, 2017 at 03:32:24PM -0400, Robert P. J. Day wrote:

> > Nothing, because there is nothing to recurse in the pathspecs you've
> > given.
> >
> > Try:
> >
> >   $ git rm drivers
> >   fatal: not removing 'drivers' recursively without -r
> >
> > versus
> >
> >   $ git rm -r drivers
> >   [...removes everything under drivers/...]
> 
>   that is not what the man page is saying ... it refers to a "leading"
> directory name, not simply a directory name. if it should say simply
> "when a directory name is given", then it should be changed to say
> that.

It's the leading directory of the files that will be removed.

An earlier part of the manpage (under <file>) also says:

  A leading directory name (e.g. dir to remove dir/file1 and dir/file2)
  can be given to remove all files in the directory, and recursively all
  sub-directories, but this requires the -r option to be explicitly
  given.

which perhaps makes it more clear. Later in "-r", we say:

   -r
           Allow recursive removal when a leading directory name is given.

which I guess is the part you're reading.  I think it would be equally
correct to say "leading directory" or just "directory" there.

Though really, you could give many such directory names, or even match
them with a glob. So a more accurate description might be something
like:

  -r
	Recursively remove the contents of any directories that match
	`<file>`.

or something.

-Peff
