Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A75820A28
	for <e@80x24.org>; Tue, 19 Sep 2017 19:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbdISTkr (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:40:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:43882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751074AbdISTkq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:40:46 -0400
Received: (qmail 11256 invoked by uid 109); 19 Sep 2017 19:40:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 19:40:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7234 invoked by uid 111); 19 Sep 2017 19:41:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 15:41:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Sep 2017 15:40:44 -0400
Date:   Tue, 19 Sep 2017 15:40:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/2] fix read past end of array in alternates files
Message-ID: <20170919194044.3prgaxd4sqandy75@sigill.intra.peff.net>
References: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 18, 2017 at 11:51:00AM -0400, Jeff King wrote:

> This series fixes a regression in v2.11.1 where we might read past the
> end of an mmap'd buffer. It was introduced in cf3c635210, but I didn't
> base the patch on there, for a few reasons:

Here's a v2 that fixes a minor leak in the first patch (I carefully
remembered to free() the path buffer on the error path, but forgot to do
it in the normal one. Oops).

I also tried to address Jonathan's "should this be in the commit
message" comment. The information above _is_ in there, but maybe putting
it at the top as a sort of tl;dr makes it easier to find?

The second patch is unchanged.

Junio, I see you ended up back-porting it to v2.11. Would you prefer me
to have done it that way in the first place? I was trying to reduce your
work by basing it on "maint" (figuring that we wouldn't bother making a
v2.11.x release anyway, and that skips you having to apply the second
patch separately after the merge).

  [1/2]: read_info_alternates: read contents into strbuf
  [2/2]: read_info_alternates: warn on non-trivial errors

 sha1_file.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

-Peff
