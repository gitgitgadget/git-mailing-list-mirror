Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7880C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C10C64F8A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCPVXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:23:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:38902 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhCPVXh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:23:37 -0400
Received: (qmail 21429 invoked by uid 109); 16 Mar 2021 21:23:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Mar 2021 21:23:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2086 invoked by uid 111); 16 Mar 2021 21:23:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Mar 2021 17:23:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Mar 2021 17:23:36 -0400
From:   Jeff King <peff@peff.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
Message-ID: <YFEh2LxvsSP+x7d2@coredump.intra.peff.net>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga>
 <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga>
 <YFADuptwV7iR76g5@google.com>
 <C9YDEO8Z8J96.262IOS9IW6F39@taiga>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C9YDEO8Z8J96.262IOS9IW6F39@taiga>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 09:05:34PM -0400, Drew DeVault wrote:

> On Mon Mar 15, 2021 at 9:02 PM EDT, Jonathan Nieder wrote:
> > I'm not sure it's a disconnect; instead, it just looks like we
> > disagree. That said, with more details about the use case it might be
> > possible to sway me in another direction.
> >
> > To maintain the URI analogy: the URI does not tell me the content-type
> > of what I can access from there. Until I know that content-type, I
> > may not know what the best tool is to access it.
> 
> git isn't a content type, it's a protocol. git over HTTP or git over SSH
> is a protocol in its own right, distinct from these base protocols, in
> the same sense that SSH lives on top of TCP which lives on top of IP
> which is transmitted to your computer over ethernet or 802.11. It's
> turtles all the way down.

I think this is the key observation. A browser can access an HTTP URL,
and then based on the content type, decide what to do with the result.
But one cannot do so with a git-over-http URL. Git will not even
directly access the resource specified in the URL! It will construct a
related one (with appending "info/refs" and a "service" field) and
request that.

So you definitely need to "somehow" know that a URL is meant to be used
with Git. And that makes me somewhat sympathetic to your request.

The downsides I see are:

  - one of the advantages of straight http:// URLs is that they can
    accessed by multiple tools. Most "forge" tools let you use the same
    URL both for getting a human-readable page in a browser, as well as
    accessing the repository with the Git CLI. I'd hate to see https+git
    URLs become common, because they add friction there (though simply
    supporting them at all gives people the choice of whether to use
    them).

  - I'm also sympathetic to brian's point that there's a wider
    ecosystem. It's not just "git" that needs to learn them. It's jgit,
    and libgit2, and many tools that work with git remotes.

-Peff
