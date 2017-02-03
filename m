Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF02D1F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 12:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbdBCM3P (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 07:29:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:48781 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753144AbdBCM3J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 07:29:09 -0500
Received: (qmail 22540 invoked by uid 109); 3 Feb 2017 12:29:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Feb 2017 12:29:08 +0000
Received: (qmail 26399 invoked by uid 111); 3 Feb 2017 12:29:11 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Feb 2017 07:29:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2017 13:29:00 +0100
Date:   Fri, 3 Feb 2017 13:29:00 +0100
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] document behavior of empty color name
Message-ID: <20170203122859.753bexioxxkibfzb@sigill.intra.peff.net>
References: <xmqqpoj2q25n.fsf@gitster.mtv.corp.google.com>
 <20170201002129.xb62hmxwrzwgp6vg@sigill.intra.peff.net>
 <20170202091615.GA22337@ash>
 <20170202124238.53k74cedpp2rcmzo@sigill.intra.peff.net>
 <20170203092430.GA10987@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170203092430.GA10987@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 03, 2017 at 04:24:30PM +0700, Duy Nguyen wrote:

> > I don't think so. The default value is a git-config thing, but you would
> > want to be able to do the same thing in a config file. For example, to
> > disable coloring entirely for part of the diff, you could do:
> > 
> >   [color "diff"]
> >   meta = ""
> 
> OK but it makes log.graphColors add empty colors though. In t4202.39,
> we have " blue,invalid-color, cyan, red , ". With this patch the color
> after red would be no color. Without it, we get a complaint and the
> next color would be cycled back to blue. The test does not catch this
> because the test graph does not have enough fork points to get to red
> and back to blue.

Right, I think that's the correct behavior. The empty color name is a
real color ("none"), and you can put it in your list just like any other
color.

It's possible that somebody would like to use the sort of "hanging
comma" behavior that people do with lists that might be added to later
(e.g., for enums in C).

IMHO that would be best handled by having the list-parsing code drop
trailing empty entries. But I don't think this special case is worth
supporting, if only for the mental complexity it adds to the user.

-Peff
