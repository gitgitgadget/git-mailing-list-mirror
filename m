Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843CDC35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8E52187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgBNGcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:32:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:43180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725897AbgBNGcO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 01:32:14 -0500
Received: (qmail 19213 invoked by uid 109); 14 Feb 2020 06:32:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 06:32:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19285 invoked by uid 111); 14 Feb 2020 06:41:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 01:41:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 01:32:13 -0500
From:   Jeff King <peff@peff.net>
To:     gritzmann <gritzmann@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: How do I change the AuthorDate and CommitDate of all my commits?
Message-ID: <20200214063213.GC605125@coredump.intra.peff.net>
References: <Ogtz26tj4ZgCMamF3jprc21AvPiEvWlYS9IgAwPDAPOJHd0THDCaNSwNi6qjUxE9ZknGw-87P7wnnQUkH3khrFnEXoAy8VvmEuBpVLpQ3Qw=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ogtz26tj4ZgCMamF3jprc21AvPiEvWlYS9IgAwPDAPOJHd0THDCaNSwNi6qjUxE9ZknGw-87P7wnnQUkH3khrFnEXoAy8VvmEuBpVLpQ3Qw=@protonmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 16, 2020 at 11:30:10AM +0000, gritzmann wrote:

> I*m looking to completely anonymize the timestamps of my files and
> repos For the files themselves I changed their access, modify, change
> and birth times like this: `touch -acm -d "1980-01-01 00:00:00"`.
> 
> But how do I do the same for the AuthorDate and CommitDate of all my
> commits?

If you're just creating the commits now, you can set $GIT_AUTHOR_DATE
and $GIT_COMMITTER_DATE in the environment. Like:

  export GIT_AUTHOR_DATE='1980-01-01 00:00:00 +0000'
  export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"

If you have existing commits, you'll have to look into rewriting them
with git-filter-branch, or piping git-fast-export to git-fast-import and
modifying the stream in between.

-Peff
