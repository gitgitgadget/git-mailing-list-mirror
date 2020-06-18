Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566B2C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 11:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DBB20706
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 11:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgFRLua (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:50:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:35948 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgFRLua (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 07:50:30 -0400
Received: (qmail 18092 invoked by uid 109); 18 Jun 2020 11:50:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Jun 2020 11:50:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12722 invoked by uid 111); 18 Jun 2020 11:50:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Jun 2020 07:50:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Jun 2020 07:50:28 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 2/9] remote: respect `core.defaultBranchName`
Message-ID: <20200618115028.GB41345@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <06a2cea051c01ebee38c9910425171f112daf41a.1591823971.git.gitgitgadget@gmail.com>
 <20200616123559.GB666057@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2006181218270.54@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2006181218270.54@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 12:21:30PM +0200, Johannes Schindelin wrote:

> > Hopefully this would not matter _too_ much either way, as most servers
> > would support the symref extension these days. But I still think we
> > should do our best to minimize spots where the user may see a
> > regression.
> 
> Sure, we could just leave this alone, or we can just ditch the
> special-casing of `master` here.
> 
> As you say, this does not affect any modern Git version, and IIRC the code
> after that special-casing tries to find any remote ref that matches the
> remote `HEAD`.

I think we need to be a little careful with "any modern Git", because a
modern client against an old (or perhaps an alternative implementation)
server might still use it. I have to imagine it's pretty rare, but I
think it's still useful to return _some_ value.

But as you note, even without a symref extension, we already try to
guess based on a unique branch. Probably even choosing the first one
alphabetically would be reasonable. But I'd rather err on the side of
historical compatibility if we can do so easily. Looking for
init.mainBranch, followed by master, accomplishes that and isn't many
lines of code.

-Peff
