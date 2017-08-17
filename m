Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B7320899
	for <e@80x24.org>; Thu, 17 Aug 2017 17:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbdHQRdR (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 13:33:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:41784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752270AbdHQRdR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 13:33:17 -0400
Received: (qmail 2311 invoked by uid 109); 17 Aug 2017 17:33:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 17:33:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28292 invoked by uid 111); 17 Aug 2017 17:33:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 13:33:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Aug 2017 13:33:14 -0400
Date:   Thu, 17 Aug 2017 13:33:14 -0400
From:   Jeff King <peff@peff.net>
To:     Kai Zhang <kai@netskope.com>
Cc:     git@vger.kernel.org
Subject: Re: Question about git gc on large text files
Message-ID: <20170817173314.qjzii4e4rybqqn34@sigill.intra.peff.net>
References: <60A624DB-CFD1-4A62-A58B-80176F96BA30@netskope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60A624DB-CFD1-4A62-A58B-80176F96BA30@netskope.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 10:28:00AM -0700, Kai Zhang wrote:

> I have a git repository maintaining one large json file (along with
> several other small files). With commits for large json file, the
> repository become bigger and bigger, so I tried to run command "git gc
> --prune=now --aggressive" to reduce disk usage, then I found .git
> folder size did not change. I had wonderful experience with git gc
> against files around 10M to 20M, and I am wondering if there is any
> configuration need to tweak for large text files?
> 
> Here I have more details:
> 1. Json file size: 1G

Git won't try to delta-compress anything over 500MB by default. Try:

  git config core.bigfilethreshold 2G
  git gc --aggressive

-Peff
