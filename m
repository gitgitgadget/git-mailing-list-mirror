Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5AF01F597
	for <e@80x24.org>; Sat, 28 Jul 2018 04:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeG1GOB (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 02:14:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:33918 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725876AbeG1GOB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 02:14:01 -0400
Received: (qmail 28794 invoked by uid 109); 28 Jul 2018 04:49:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Jul 2018 04:49:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 928 invoked by uid 111); 28 Jul 2018 04:49:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 28 Jul 2018 00:49:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jul 2018 00:48:57 -0400
Date:   Sat, 28 Jul 2018 00:48:57 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git clone and case sensitivity
Message-ID: <20180728044857.GA10444@sigill.intra.peff.net>
References: <24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com>
 <20180727205909.GC376343@genre.crustytoothpaste.net>
 <20180728043559.GA29185@duynguyen.home>
 <CACsJy8A3pd85fDrbak8TCnmkMb_FDmmpaNd5tBSCKBGkGswKCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8A3pd85fDrbak8TCnmkMb_FDmmpaNd5tBSCKBGkGswKCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 28, 2018 at 06:45:43AM +0200, Duy Nguyen wrote:

> > I agree throwing a real exception would be bad. But how about detecting
> > the problem and trying our best to keep the repo in somewhat usable
> > state like this?
> >
> > This patch uses sparse checkout to hide all those paths that we fail
> > to checkout, so you can still have a clean worktree to do things, as
> > long as you don't touch those paths.
> 
> Side note. There may still be problems with this patch. Let's use
> vim-colorschemes.git as an example, which has darkBlue.vim and
> darkblue.vim.
> 
> Say we have checked out darkBlue.vim and hidden darkblue.vim. When you
> update darkBlue.vim on worktree and then update the index, are we sure
> we will update darkBlue.vim entry and not (hidden) darkblue.vim? I am
> not sure. I don't think our lookup function is prepared to deal with
> this. Maybe it's best to hide both of them.

It might be enough to just issue a warning and give an advise() hint
that tells the user what's going on. Then they can decide what to do
(hide both paths, or just work in the index, or move to a different fs,
or complain to upstream).

-Peff
