Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFD2A20966
	for <e@80x24.org>; Fri,  7 Apr 2017 06:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbdDGGiN (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 02:38:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:57921 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752954AbdDGGiL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 02:38:11 -0400
Received: (qmail 31058 invoked by uid 109); 7 Apr 2017 06:38:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 06:38:10 +0000
Received: (qmail 32422 invoked by uid 111); 7 Apr 2017 06:38:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 02:38:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Apr 2017 02:38:08 -0400
Date:   Fri, 7 Apr 2017 02:38:08 -0400
From:   Jeff King <peff@peff.net>
To:     Javier Domingo Cansino <javierdo1@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git branch deletion not based on HEAD branch anymore
Message-ID: <20170407063808.frjjclz7ksqgmtyt@sigill.intra.peff.net>
References: <CALZVapk4zxn-DSdMdy2q-Z0KvsBvx4MCSB5UDVOaBrBvAqw_AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALZVapk4zxn-DSdMdy2q-Z0KvsBvx4MCSB5UDVOaBrBvAqw_AA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2017 at 10:31:55PM +0200, Javier Domingo Cansino wrote:

> I understand it's not possible / convenient anymore to go back, but
> would it be possible to have an option such as `--merged` to support
> the old usecase?

There's "branch --merged" already. And in recent versions of git, the
scriptable for-each-ref knows it, too. So you could do something like:

  git for-each-ref --format='delete %(refname)' --merged HEAD refs/heads/ |
  grep -v 'any-branches-you-want-saved' |
  git update-ref --stdin

The "--merged" option to git-branch is only used for listing. In theory
we could use it for selection in other operations, like "git branch -d
--merged". But I'm not sure how you'd tell it _not_ to delete the branch
that matches HEAD.

-Peff
