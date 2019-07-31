Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32BBD1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 17:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfGaRT6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 13:19:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:57114 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726786AbfGaRT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 13:19:58 -0400
Received: (qmail 18307 invoked by uid 109); 31 Jul 2019 17:19:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 17:19:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19788 invoked by uid 111); 31 Jul 2019 17:21:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 13:21:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 13:19:57 -0400
From:   Jeff King <peff@peff.net>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     git@vger.kernel.org
Subject: Re: Support for --stdin-paths in commit, add, etc
Message-ID: <20190731171956.GA26746@sigill.intra.peff.net>
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 31, 2019 at 05:45:12PM +0200, Alexandr Miloslavskiy wrote:

> In our git UI, we sometimes run into OS commandline length limit when
> trying to specify a list of pathspecs. For example, this happens when
> user selects a large set of files and wants to commit them. As a
> workaround, we split files and issue multiple git commands.
> 
> This has multiple disadvantages:
> 1) Some commands are a lot slower this way. For example, commit-amend
>    can take 45 minutes instead of 30 seconds, because git will do a lot
>    of unnecessary work.
> 2) The operation is no longer completed in one "transaction".
> 3) This makes our code more complicated.
> 
> Our suggestion is to change commands such as 'commit', 'add', etc to
> also work with --stdin-paths. If a command already supports stdin for
> any purpose, then trying to use both options will return an error.

I don't have any real objection to adding stdin support for more
commands. Bu tin the specific case you're discussing, it seems like
using "git update-index" might already solve your problem. It's the
intended plumbing for scripted index updates, and it already supports
receiving paths from stdin.

-Peff
