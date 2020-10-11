Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980CDC433E7
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 09:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4831B207FB
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 09:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="VcoeXPwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbgJKJ70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 05:59:26 -0400
Received: from mout01.posteo.de ([185.67.36.65]:33821 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387502AbgJKJ7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 05:59:25 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 31B2D16005F
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 11:59:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1602410359; bh=/TlrV9peW0OOxPvqlBQau9tZyx06fS+LSlj2FMnFffI=;
        h=Date:From:To:Cc:Subject:From;
        b=VcoeXPwf2hJ6SuIueTQ0nlGpcQKZ+itJCxP4+2lDUZG0ctx0RQrK9iiO7ObfGFBa3
         1LEWk/b/5bVpaw8croy0gsLgb1OqWeelOyfncnnJst9b9QKWL1bhJPCIzZ4O7pD3PN
         eUmRMTdczivGqaTBXpqXE4cDZ+2Jbw75nie1n5g9Zbdcc/9GKkKs07la5d/I6qSCSO
         xBFu6RRLcn7XE+bPwWP5O7PTsOQoDUFNL/NBRkAdWqnqwEQOZECGjEMseqW2ORZW9d
         zUv36EKkqP198hOM1eZ4g95ZyMnXAKt2FAixbWvHt97vDXPxjTqcmCcRXhwrE7ADig
         o02/vhAeIOJ+g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4C8HMp26y6z6tm9;
        Sun, 11 Oct 2020 11:59:18 +0200 (CEST)
Date:   Sun, 11 Oct 2020 11:59:16 +0200
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] log: add log.showStat configuration variable
Message-ID: <20201011095916.GA14933@HP>
References: <20201008162015.23898-1-avoidr@posteo.de>
 <bec999ef-5f9c-0ca1-ddd9-70b54b8c51b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bec999ef-5f9c-0ca1-ddd9-70b54b8c51b1@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 08, 2020 at 02:12:50PM -0400, Derrick Stolee wrote:
> On 10/8/2020 12:20 PM, Robert Karszniewicz wrote:
> > Changes default behaviour of `git log` and `git show` when no
> > command-line options are given. Doesn't affect behaviour otherwise (same
> > behaviour as with stash.showStat).
> > ---
> > I've wanted to have `show` and `log` show --stat by default, and I
> > couldn't find any better solution for it. And I've discovered that there
> > is stash.showStat, which is exactly what I want. So I wanted to bring
> > stash.showStat to `show` and `log`.
> 
> I'm wondering: why should this be a config setting instead of just
> a configure alias?

I answered this in the reply to Junio C Hamano.

Actually, the first thing I tried, was make an alias named after the git
command, like so:

  git config --global alias.show "show --stat"
  git config --global alias.log "log --stat"

But that didn't work. Why, actually? We're used to it from our POSIX
shells, and other places I can't think of, but it feels familiar.
Perhaps this would be a good way to enable changing default behaviour of
each git command without having to change anything about config
handling? Would this be difficult to do?

> If this is something we want to do as a config instead of alias,
> I'm wondering if it is worth expanding the scope and thinking about
> these other arguments (like --graph, --oneline, etc.) and how they
> could be incorporated into a coherent config system.
> 
> I worry that this initial step leads us down a road of slowly adding
> one-off config settings for each option when:

I worried about that, too. But I think the initial step was already in
2015, when stash.showStat and stash.showPatch were added. No flood of
options happened since then? I was actually surprised about it, too,
that it took so long until someone wanted to have showStat for show and
log, too.

> 
>  1. aliases exist, and
>  2. it becomes unclear which arguments have configured defaults.
> 
> Thanks,
> -Stolee
> 

Thank you!
