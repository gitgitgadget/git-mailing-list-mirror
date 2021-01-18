Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040ABC433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC94922CA1
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405584AbhARSVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:21:05 -0500
Received: from mail.aerusso.net ([104.225.219.13]:57876 "EHLO mail.aerusso.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436747AbhARSUx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 13:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aerusso.net; s=default;
        t=1610994010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJI6gjLXi1ty6SKqRBr/DPvlTQJ1m+hQr/WMvcl+wFs=;
        b=dU9exwF+B/ZD9qvrgLEhBYyCrajPJRLHuQrFzP9X1b1JOdifW9yciBYHq3pIkliPXh0zBS
        CAni/hYgUtlRzX8vUaZZW/WK8YllScJk4c9/RHju1DUCmPYKuc/Rg0r1NOccP2WPMYyFKh
        I1C7Yx9o6yqevFsRWUl76+jE6+mT9OFEkK+M7ZTdDj9Sz1lmU3xzuRKFsvwtXxltf7WE1w
        5HDrCUSx8enkKFEYKh/0aCEKJfe176Trq2xqIAwYFnyrSukeE+H+6IChgQz9t8OgN0PvzL
        bq5yD00jSeUtKYOds9bEcwYi4rbqxkTOw53FsN8aDG5gaTRRG/Von5Wg6OoBmg==
To:     Aiyee Bee <shane.880088.supw@gmail.com>, git@vger.kernel.org
References: <C8MHFL3YJDSF.1GLOUSV7BYS1X@localhost>
From:   Antonio Russo <aerusso@aerusso.net>
Subject: Re: DEVEL: Help with feature implementation
Message-ID: <f29fadef-6497-403c-59e0-8bd7beec77af@aerusso.net>
Date:   Mon, 18 Jan 2021 11:19:54 -0700
MIME-Version: 1.0
In-Reply-To: <C8MHFL3YJDSF.1GLOUSV7BYS1X@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/18/21 11:06 AM, Aiyee Bee wrote:
> Hello everybody!
> 
> I want to implement a feature in git, and I'm looking for some help.
> 
> I wanted to add a history-simplification option to rev-list so that it
> doesn't simplify away any irrelevant commits if they have multiple
> relevant _children_, i.e. when they are the point where two relevant
> histories diverge.

I'm actually working on something that does the opposite---it ignores
the fork point when drawing the graph.  (I'm currently dog-fooding a
partial implementation of this.)

> Basically the effect I want for --show-forkpoints (named like --show-pulls):
> http://ix.io/2Ms6
> 
> But it seems there is no existing apparatus in the revision walker for
> deciding simplification on basis of *children*, am I correct? Admittedly
> my understanding of it is still a WIP, but I don't see anything that
> could help.

It's even worse than this.  AFAICT, there are two code paths: one for when
the git-commit-graph is enabled, and one when it is not.  There's a special
"revs->limited" option which lets you deal with the commits all at once, at
the expense of losing all the speed improvements from the git-commit-graph
efforts.

Aside: I want to get rid of that alternative path.  But I only have limited
time.

> I was hoping that simply the flag CHILD_SHOWN could be checked, but it
> seems that's only set on boundary commits :(
> 
> This option would be pretty useful when used with some diffs, to see how
> much two forks have diverged. Currently if you use history simplification,
> the diffs for both divergent histories will be created against the last
> relevant commit instead of the last common ancestor, which creates pretty
> useless diffs with a lot of intersection between them.

Sounds neat!

> Are there any viable alternative means to do this that I can explore?

I too would like to hear about suggestions for this.

> 
> Thanks!
> 
> FriendlyNeighborhoodShane
> 
