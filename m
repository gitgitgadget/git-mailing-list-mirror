Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0469120401
	for <e@80x24.org>; Thu, 15 Jun 2017 13:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbdFONBy (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 09:01:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:40632 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752321AbdFONBx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 09:01:53 -0400
Received: (qmail 25935 invoked by uid 109); 15 Jun 2017 13:01:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 13:01:47 +0000
Received: (qmail 22979 invoked by uid 111); 15 Jun 2017 13:01:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 09:01:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 09:01:45 -0400
Date:   Thu, 15 Jun 2017 09:01:45 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Junio Hamano <gitster@pobox.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
Message-ID: <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
 <20170306182423.GB183239@google.com>
 <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
 <20170615110518.ordr43idf2jluips@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170615110518.ordr43idf2jluips@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 08:05:18PM +0900, Mike Hommey wrote:

> On Thu, Jun 15, 2017 at 12:30:46PM +0200, Johannes Schindelin wrote:
> > Footnote *1*: SHA-256, as all hash functions whose output is essentially
> > the entire internal state, are susceptible to a so-called "length
> > extension attack", where the hash of a secret+message can be used to
> > generate the hash of secret+message+piggyback without knowing the secret.
> > This is not the case for Git: only visible data are hashed. The type of
> > attacks Git has to worry about is very different from the length extension
> > attacks, and it is highly unlikely that that weakness of SHA-256 leads to,
> > say, a collision attack.
> 
> What do the experts think or SHA512/256, which completely removes the
> concerns over length extension attack? (which I'd argue is better than
> sweeping them under the carpet)

I don't think it's sweeping them under the carpet. Git does not use the
hash as a MAC, so length extension attacks aren't a thing (and even if
we later wanted to use the same algorithm as a MAC, the HMAC
construction is a well-studied technique for dealing with it).

That said, SHA-512 is typically a little faster than SHA-256 on 64-bit
platforms. I don't know if that will change with the advent of hardware
instructions oriented towards SHA-256.

-Peff
