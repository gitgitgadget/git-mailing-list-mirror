Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A921320958
	for <e@80x24.org>; Mon, 20 Mar 2017 19:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932102AbdCTTlk (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 15:41:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:47999 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756101AbdCTTku (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 15:40:50 -0400
Received: (qmail 17915 invoked by uid 109); 20 Mar 2017 19:14:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 19:14:07 +0000
Received: (qmail 5005 invoked by uid 111); 20 Mar 2017 19:14:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 15:14:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 15:14:03 -0400
Date:   Mon, 20 Mar 2017 15:14:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Add configuration options for some commonly used command-line
 options
Message-ID: <20170320191403.wn65gyoime2lrubu@sigill.intra.peff.net>
References: <CACsJy8Du+WWWkx3wqRJYA=cyTdro=OOD7GWaFi29=h1_9yC+LQ@mail.gmail.com>
 <vpqa88hlghm.fsf@anie.imag.fr>
 <20170319131845.tl6o3t2nwicj2rug@genre.crustytoothpaste.net>
 <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
 <CACsJy8CQzo9K8N3xH_HJq=NjJVOUG9wawC4Mg+UuyFRZCPBpFw@mail.gmail.com>
 <20170320173237.GA188475@google.com>
 <xmqq7f3jwzdo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f3jwzdo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 11:56:35AM -0700, Junio C Hamano wrote:

> One thing we may want to consider is why we have to even worry about
> scripts getting broken.  It is because people script around
> Porcelain, and that is because we have been too eager to improve
> Porcelain while neglecting plumbing for too long, to the point that
> some things are only doable with Porcelain (or doing the same with
> plumbing while possible are made too cumbersome).  I find it quite
> disturbing that nobody brought that up as an issue that needs to be
> addressed in this entire thread.

I think there is a chicken-and-egg problem there. The plumbing _wasn't_
there, so people started using porcelain in their scripts, which made us
hesitant to change it. That fact that it doesn't break makes script
writers think it's OK. And now we're stuck with things like "log" and
"diff" as pseudo-plumbing, unless we want to take a strong stand and say
"you're doing it wrong, even though there was no other way to do it
until now".

Unless you want to follow the usual deprecation schedule by introducing
new plumbing commands to fill in the gaps, waiting, and then proceeding
to change the porcelain. But I think that's isomorphic with the other
solutions. I.e., out of:

  1. git rev-list
  2. GIT_PLUMBING=1 git log
  3. git command log

They are all doing the exact same thing: running a log-like command
without any config or cross-version changes. It's just a matter of
syntax. One of the nice things about (2) and (3) is that you don't have
to invent a new plumbing-ish name for each command.

-Peff
