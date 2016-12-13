Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD7BD1FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 11:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933047AbcLMLuY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 06:50:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:55614 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933027AbcLMLuW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 06:50:22 -0500
Received: (qmail 29868 invoked by uid 109); 13 Dec 2016 11:50:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 11:50:22 +0000
Received: (qmail 13769 invoked by uid 111); 13 Dec 2016 11:51:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 06:51:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 06:50:18 -0500
Date:   Tue, 13 Dec 2016 06:50:18 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] handling alternates paths with colons
Message-ID: <20161213115018.quulwlheycjtlsub@sigill.intra.peff.net>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
 <xmqqwpf8rkeq.fsf@gitster.mtv.corp.google.com>
 <20161210085133.2pnkz6eqlxoxdckg@sigill.intra.peff.net>
 <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
 <xmqqvauo7p0r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvauo7p0r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 02:37:08PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So here are patches that do that. It kicks in only when the first
> > character of a path is a double-quote, and then expects the usual
> > C-style quoting.
> 
> The quote being per delimited component is what makes this fifth
> approach a huge win.  
> 
> All sane components on a list-valued environment are still honored
> and an insane component that has either a colon in the middle or
> begins with a double-quote gets quoted.  As long as nobody used a
> path that begins with a double-quote as an element in such a
> list-valued environment (and they cannot be, as using a non-absolute
> path as an element does not make much sense), this will be safe, and
> a path with a colon didn't work with Git unaware of the new quoting
> rule anyway.  Nice.

We do support non-absolute paths, both in alternates files and
environment variables. It's a nice feature if you want to have a
relocatable family of shared repositories. I'd imagine that most cases
start with "../", though.

-Peff
