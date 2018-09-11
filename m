Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998C51F404
	for <e@80x24.org>; Tue, 11 Sep 2018 19:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeILAGC (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 20:06:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:46220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726713AbeILAGC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 20:06:02 -0400
Received: (qmail 12490 invoked by uid 109); 11 Sep 2018 19:05:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Sep 2018 19:05:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20643 invoked by uid 111); 11 Sep 2018 19:05:34 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Sep 2018 15:05:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Sep 2018 15:05:19 -0400
Date:   Tue, 11 Sep 2018 15:05:19 -0400
From:   Jeff King <peff@peff.net>
To:     Michal Novotny <clime@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: with git 1.8.3.1 get only merged tags
Message-ID: <20180911190519.GA8396@sigill.intra.peff.net>
References: <CANT8FXRbep_32-eeMSa0C1e6q6MUvFddgTUiUgqv54J-2c+iXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANT8FXRbep_32-eeMSa0C1e6q6MUvFddgTUiUgqv54J-2c+iXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 12:43:15PM +0200, Michal Novotny wrote:

> I need to emulate git tag --merged with very old git 1.8.3.1. Is that
> somehow possible?
> I am looking for a bash function that would take what git 1.8.3.1
> offers and return only the tags accessible from the current branch
> tip. Could you, please, give me at least a hint how this could be
> done?

This is not particularly fast, but it should work:

  git for-each-ref refs/tags |
  cut -f2 |
  while read tag; do
    test "$(git merge-base $tag HEAD)" = \
         "$(git rev-parse $tag^{commit})" && echo $tag
  done

-Peff
