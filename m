Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0B4C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 19:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8A32465A
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 19:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAUTGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:06:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:41430 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728829AbgAUTGO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 14:06:14 -0500
Received: (qmail 8138 invoked by uid 109); 21 Jan 2020 19:06:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Jan 2020 19:06:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13403 invoked by uid 111); 21 Jan 2020 19:13:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Jan 2020 14:13:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Jan 2020 14:06:13 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2] fetch: document and test --refmap=""
Message-ID: <20200121190613.GB11027@coredump.intra.peff.net>
References: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
 <pull.532.v2.git.1579570692766.gitgitgadget@gmail.com>
 <20200121162433.GA6215@coredump.intra.peff.net>
 <a87b9fc2-dae4-7e39-5aab-243ba9679531@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a87b9fc2-dae4-7e39-5aab-243ba9679531@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 21, 2020 at 01:01:47PM -0500, Derrick Stolee wrote:

> > This isn't strictly related to your patch, but since the rationale here
> > describes the concept of a background job and people might end up using
> > it as a reference, do you want to add in --no-tags to help them out?
> 
> That's a good idea. I keep forgetting about that. It's interesting that
> tags are fetched even though my refpsec does not include refs/tags.

Yeah, because tag-following is an extra thing outside of the refspecs. I
think it would be nice if there were a way to specify a "following"
refspec, something like:

  ~refs/tags/*:refs/tags/*

(where "~" is just a character I picked out of the blue that I think
doesn't have any other meaning there now). And then we could specify it
in the config alongside other refspecs, override it with a refmap, etc.

As a bonus, it would also give us a stepping stone towards being able to
do remote-specific tags like:

  [remote "origin"]
  url = ...
  fetch = +refs/heads/*:refs/remotes/origin/heads/*
  fetch = ~refs/tags/*:refs/remotes/origin/tags/*

But I'm sure there are a lot of backwards-compatibility gotchas.

-Peff
