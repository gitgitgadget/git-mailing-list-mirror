Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0171FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 21:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdBFVpL (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 16:45:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:50152 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751172AbdBFVpL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 16:45:11 -0500
Received: (qmail 2519 invoked by uid 109); 6 Feb 2017 21:45:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 21:45:10 +0000
Received: (qmail 19119 invoked by uid 111); 6 Feb 2017 21:45:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 16:45:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2017 16:45:08 -0500
Date:   Mon, 6 Feb 2017 16:45:08 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Samuel Lijin <sxlijin@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git/git-scm.com GH Issue Tracker
Message-ID: <20170206214507.7l5haqbimmwdwfm3@sigill.intra.peff.net>
References: <CAJZjrdX_8tjMhRac9QQOW8m_S2DprFPV=uZp8mFT+g6bASVd-w@mail.gmail.com>
 <CACsJy8BCTY=T9f2ac7HUuHA-_RzjaxPHZNPQs9ecBhmsnDuRVQ@mail.gmail.com>
 <20170206184951.vwq6ib2qzxc542i4@sigill.intra.peff.net>
 <xmqqlgtj11up.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgtj11up.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 06, 2017 at 12:49:34PM -0800, Junio C Hamano wrote:

> Of course, that will make it easier to let broken objects created by
> newer reimplementations of Git (and bugs in our code that cause us
> to create such broken objects) go unnoticed, so we would want to
> keep them at warn (not ignore) for the end-users.

Yes, sorry if that wasn't clear. By "loosen" I just meant to warn,
not ignore.

So a viable path forward is perhaps:

  1. Add fetch.fsck.* (and probably transfer.fsck.*) to match the
     receive-pack options.

  2. Go over the current list of default warning/error settings and make
     sure they are sensible.

  3. Add a "light" mode to transfer.fsckObjects and friends that blocks
     only errors, not warnings. Maybe setting the config bool to
     "errors-only" instead of "true" or something.

  4. (Optional) Default transfer.fsckObjects to "errors-only".

     The escape hatch is to set fsckObjects to "false", or to downgrade
     your specific problem to a warning via transfer.fsck.*.

-Peff
