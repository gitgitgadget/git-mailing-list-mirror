Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DAF620984
	for <e@80x24.org>; Tue, 13 Sep 2016 22:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933041AbcIMWWm (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 18:22:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:42846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932886AbcIMWWk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 18:22:40 -0400
Received: (qmail 19493 invoked by uid 109); 13 Sep 2016 22:22:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 22:22:38 +0000
Received: (qmail 26363 invoked by uid 111); 13 Sep 2016 22:22:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 18:22:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2016 15:22:33 -0700
Date:   Tue, 13 Sep 2016 15:22:33 -0700
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 06/16] diff: always try to set up the repository
Message-ID: <20160913222144.f3f3oqhqbe6sjzdf@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
 <20160913032336.cur3rrzpgepulqi6@sigill.intra.peff.net>
 <CAGZ79kYNfUmBG+9irQoZ+C6qfiiz0P7pGKHZVk-8569gk4+_EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYNfUmBG+9irQoZ+C6qfiiz0P7pGKHZVk-8569gk4+_EQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 03:00:17PM -0700, Stefan Beller wrote:

> On Mon, Sep 12, 2016 at 8:23 PM, Jeff King <peff@peff.net> wrote:
> 
> >   2. If you're in a subdirectory of a repository, then we
> >      still try to read ".git/config", but it generally
> >      doesn't exist. So "diff --no-index" there does not
> >      respect repo config.
> 
> Nit:
> So IIUC your cover letter even this /used/ to work but
> broke only recently? So I feel like the message is a bit
> misleading (i.e. you argue for a change in behavior instead of
> calling it a bug fix for a regression. I think a bug fix for a regression
> is harder to revert as compared to a "new" behavior)

No, this has always been broken. What broke recently is the tests
covered in patch 14 related to git-init.

IOW, we have always done this "blind read" of .git/config, ever since
the early days. It was always wrong, but was mostly overlooked because
it worked often enough and usually didn't cause other problems. But
because of the caching and lazy-reading done by git_config() these days
(and get_shared_repository() which builds on it), you can get quite
confusing and buggy effects if you lazy-read at the wrong time.

-Peff
