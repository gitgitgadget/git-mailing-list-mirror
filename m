Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D03F2035F
	for <e@80x24.org>; Wed,  9 Nov 2016 03:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbcKIDep (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 22:34:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:40489 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751282AbcKIDeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 22:34:44 -0500
Received: (qmail 20306 invoked by uid 109); 9 Nov 2016 03:34:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 03:34:44 +0000
Received: (qmail 26257 invoked by uid 111); 9 Nov 2016 03:35:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 22:35:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2016 22:34:41 -0500
Date:   Tue, 8 Nov 2016 22:34:41 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Word <argoday@argoday.com>,
        Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org,
        jword@bloomberg.net
Subject: Re: Bug: git config does not respect read-only .gitconfig file
Message-ID: <20161109033441.hp4eyf5qahimrtr3@sigill.intra.peff.net>
References: <CAD9aWChH14eviop=0_Ma_2Pa-2OyWJp9KjimH8dyqy-XDn9Rhw@mail.gmail.com>
 <40608c85-f870-87f7-daee-7fa98f5d19c1@jump-ing.de>
 <CAD9aWCgZkuaZNMDparVZE_WNFpOp7ud6iyCueGVbnU8s_EYtrQ@mail.gmail.com>
 <20161108200110.zvqdm2nlu5zxfyv5@sigill.intra.peff.net>
 <xmqqk2cdbg5v.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2cdbg5v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2016 at 05:22:52PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Probably converting "rename(from, to)" to first check "access(to,
> > W_OK)". That's racy, but it's the best we could do.
> 
> Hmph, if these (possibly problematic) callers are all following the
> usual "lock, write to temp, rename" pattern, perhaps the lock_file()
> function can have access(path, W_OK) check before it returns a
> tempfile that has been successfully opened?

Yeah, that is a lot friendlier, as it prevents the caller from doing
work (which may even involve the user typing things!) when it is clear
that we would fail the final step anyway.

-Peff
