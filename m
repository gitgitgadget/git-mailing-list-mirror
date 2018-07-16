Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53B31F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbeGPWB3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:01:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:48580 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726698AbeGPWB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:01:28 -0400
Received: (qmail 16991 invoked by uid 109); 16 Jul 2018 21:32:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 21:32:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15970 invoked by uid 111); 16 Jul 2018 21:32:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 17:32:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 17:32:11 -0400
Date:   Mon, 16 Jul 2018 17:32:11 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/9] X509 (gpgsm) commit signing support
Message-ID: <20180716213210.GI25189@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <20180710171224.GI23624@sigill.intra.peff.net>
 <20180714183312.GG1042117@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180714183312.GG1042117@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 14, 2018 at 06:33:12PM +0000, brian m. carlson wrote:

> > This series is a fine replacement for that earlier work. It's flexible
> > enough to allow what we really wanted out of that series (gpgsm support,
> > or another drop-in tool that uses the same interface). It doesn't lay
> > any groundwork for further tools (like signify), but I think the
> > consensus on the list was to punt on that until somebody had more
> > concrete plans for adding such a tool.
> 
> I actually think this moves in a nice direction for adding support for
> minisign/signify and other schemes.  There's a way to look up what
> algorithm is in use in a particular context based on the first line and
> a general interface for deciding what format to write.  Granted, it
> currently still is very specific to gpg-style tools, but I think this is
> an improvement in that regard.

My issue with this for helping with signify is that it creates a new
gpg.<tool>.* hierarchy with two slots (openpgp and x509). But we would
not want gpg.signify.program, would we?  That makes no sense, as neither
the signature-matching nor the program invocation are gpg-like.

But if we later moved to "signingtool.<tool>.*", now we have an extra
layer of compatibility to deal with. E.g., signingtool.openpgp.program
is the same as gpg.openpgp.program which is the same as gpg.program.

I think we can do that, but it means more historical baggage.

I'm OK with that since signify support is purely hypothetical at this
point.  But that's why I say that this doesn't lay the groundwork in the
way that the other series did.

> As an OpenPGP user, I have no interest in adding support for other
> tools, but I think this should make it easier if someone else wants to
> do that.

I don't plan to work on signify (or other tools) anytime soon either. My
interest here is in x509, since that's what enterprises would use over
pgp.

I actually dislike pgp for this application, too, because I find the key
management kind of complicated and tedious. But at least it's a standard
among open source folks.

-Peff
