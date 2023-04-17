Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBB9C77B61
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 05:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDQFki (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 01:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDQFkh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 01:40:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E5390
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 22:40:34 -0700 (PDT)
Received: (qmail 21136 invoked by uid 109); 17 Apr 2023 05:40:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Apr 2023 05:40:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21487 invoked by uid 111); 17 Apr 2023 05:40:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Apr 2023 01:40:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Apr 2023 01:40:32 -0400
From:   Jeff King <peff@peff.net>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Subject: Re: Weird behavior of 'git log --before' or 'git log --date-order':
 Commits from 2011 are treated to be before 1980
Message-ID: <20230417054032.GA26997@coredump.intra.peff.net>
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
 <141f0f6b-ef5e-4470-b86f-7ebd6c2be3ab@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <141f0f6b-ef5e-4470-b86f-7ebd6c2be3ab@app.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2023 at 04:10:32PM +0200, Kristoffer Haugsbakk wrote:

> On Sat, Apr 15, 2023, at 10:52, Jeff King wrote:
> > Of course it may also be reasonable to consider this mystery solved and
> > leave the code as-is. These objects _are_ malformed.
> 
> I started to run `git-repair`[1] on the repository yesterday. I’m not
> sure yet if it will finish.[2]

I don't know if git-repair will fix syntactic problems in commits like
this, or if it's just looking for broken links between objects. But
regardless, it would be possible to fix these using filter-repo or other
tools.

The problem with repairing them is that it rewrites history, changing
the object id of every commit which comes after.  So you'd want to do it
once centrally for the project, and declare a flag day that everybody is
moving over to the new, fixed history.

It's probably not worth it for a minor problem like this.

-Peff
