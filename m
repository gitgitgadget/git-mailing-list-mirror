Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4372D201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932618AbdEKURL (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:17:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:49835 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932366AbdEKURK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:17:10 -0400
Received: (qmail 14561 invoked by uid 109); 11 May 2017 20:17:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 20:17:10 +0000
Received: (qmail 18041 invoked by uid 111); 11 May 2017 20:17:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 16:17:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 16:17:08 -0400
Date:   Thu, 11 May 2017 16:17:08 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Best "triangle" workflow setup?
Message-ID: <20170511201707.aobrdiompzg6wu5k@sigill.intra.peff.net>
References: <CAHd499DjBHsWCf8h+i4EstR7qs-9hkO4En5-B-WA17DoPZQNoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499DjBHsWCf8h+i4EstR7qs-9hkO4En5-B-WA17DoPZQNoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 02:41:41PM -0500, Robert Dailey wrote:

> What I want (as a default) is for `git pull` to pull from the
> same-named branch on the upstream repository, but for `git push` to
> push to the same-named branch on the fork repository. However to
> override this behavior for when I want to push directly to upstream
> repo, I should be able to use an explicit `git push origin my-topic`
> (but `git push` by default will act as `git push fork my-topic`).

I think you want:

  [push]
  default = current
  [remote]
  pushDefault = myfork

to make "git push" do what you want. And then generally have branches
mark their counterparts on "origin" (which you can do either at creation
time, or probably by using "git push -u origin my-topic" when you push
them).

This is similar to what I do for my git.git workflow, though I usually
have origin/master as the branch's upstream. I.e., I'd create them with:

  git checkout -b my-topic origin

And then rebasing always happens on top of master (because "origin"
doesn't even have my topic branch at all). If I want to compare with
what I've pushed to my fork, I'd use "@{push}".

-Peff
