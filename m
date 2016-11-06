Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD30E2022D
	for <e@80x24.org>; Sun,  6 Nov 2016 14:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbcKFOae (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 09:30:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:39261 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751872AbcKFOaA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 09:30:00 -0500
Received: (qmail 741 invoked by uid 109); 6 Nov 2016 14:29:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 06 Nov 2016 14:29:59 +0000
Received: (qmail 5711 invoked by uid 111); 6 Nov 2016 14:30:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 06 Nov 2016 09:30:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Nov 2016 09:29:58 -0500
Date:   Sun, 6 Nov 2016 09:29:58 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] t0021: use write_script to create rot13 shell script
Message-ID: <20161106142957.52wx2llanw5bis4i@sigill.intra.peff.net>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
 <20161102181751.trxsns5pxqk73ukc@sigill.intra.peff.net>
 <22DAA280-1857-4E22-914A-1208D784DA98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22DAA280-1857-4E22-914A-1208D784DA98@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 06, 2016 at 03:25:33PM +0100, Lars Schneider wrote:

> This looks good to me (and it works on my machine).
> However, I took a look at the "write_script" function and found this,
> added by Junio in 840c519d:
> 
> echo "#!${2-"$SHELL_PATH"}" &&
> 
> There is some kind of variable expansion happening with the "2-" but
> I can't quite figure out what is going on. Plus, I can't find anything 
> about this in the sh docs.
> 
> Can anyone help me to understand it?

See the section on parameter expansion in "man bash". Basically:

 ${foo:-bar}

expands to $foo, or "bar" if it is unset or empty. Without the colon:

  ${foo-bar}

expands to $foo, "bar" if it unset (but not if it is empty). I don't
think we really care about the distinction here, and either is fine (you
would not ever pass an empty argument).

So in this context you may pass in the interpreter:

  write_script "$PERL_PATH" <<\EOF
  ... some perl code ...
  EOF

or it defaults to shell, which is what most of the callers want:

  write_script <<\EOF
  ... some shell code ...
  EOF

-Peff
