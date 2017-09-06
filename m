Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0A31F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 12:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbdIFM2h (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 08:28:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:58474 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752712AbdIFM2h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 08:28:37 -0400
Received: (qmail 15411 invoked by uid 109); 6 Sep 2017 12:28:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 12:28:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21379 invoked by uid 111); 6 Sep 2017 12:29:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 08:29:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Sep 2017 08:28:34 -0400
Date:   Wed, 6 Sep 2017 08:28:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/2] simplifying !RUNTIME_PREFIX
Message-ID: <20170906122834.s7a6je4b7casdfxx@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <CAN0heSrVzRPc+iVqU02qzk=DB0WT6Fscn6X-hZPFkM1TikMPVQ@mail.gmail.com>
 <20170905190212.4xx4xukx2bbtudij@sigill.intra.peff.net>
 <xmqqd174a9hs.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd174a9hs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 06, 2017 at 10:42:07AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In fact, the whole extract_argv0_path thing is pointless without
> > RUNTIME_PREFIX. So I think one reasonable fix is just:
> [...]
> Yeah, I kind of like this (I would have reduced the ifdef noise by
> leaving a totally-unused argv0_path in the BSS, though).

I wanted to drop it to make sure that I didn't miss any references to it
(and that we didn't add any in the future). But -Wunused also complains
if you leave it in. :)

I think we can reorganize the code a little to make the end result more
readable. Like this.

  [1/2]: system_path: move RUNTIME_PREFIX to a sub-function
  [2/2]: git_extract_argv0_path: do nothing without RUNTIME_PREFIX

 exec_cmd.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

-Peff
