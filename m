Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C592022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbdBWToX (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:44:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:60995 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbdBWToV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:44:21 -0500
Received: (qmail 12284 invoked by uid 109); 23 Feb 2017 19:44:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 19:44:21 +0000
Received: (qmail 14864 invoked by uid 111); 23 Feb 2017 19:44:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 14:44:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 14:44:19 -0500
Date:   Thu, 23 Feb 2017 14:44:19 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] http: add an "auto" mode for http.emptyauth
Message-ID: <20170223194418.eqi5ynhyhrcybiok@sigill.intra.peff.net>
References: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net>
 <20170222234059.iajn2zuwzkzjxit2@sigill.intra.peff.net>
 <b5778a7988ad4dfa9adfc8d312432189@exmbdft7.ad.twosigma.com>
 <20170223013746.lturqad7lnehedb4@sigill.intra.peff.net>
 <092a87cf9aa94d53aebf42facb75b985@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <092a87cf9aa94d53aebf42facb75b985@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 04:31:13PM +0000, David Turner wrote:

> > As somebody who is using non-Basic auth, can you apply these patches and
> > show us the output of:
> > 
> >    GIT_TRACE_CURL=1 \
> >    git ls-remote https://your-server 2>&1 >/dev/null |
> >    egrep '(Send|Recv) header: (GET|HTTP|Auth)'
> > 
> > (without http.emptyauth turned on, obviously).
> 
> The results appear to be identical with and without
> the patch.  With http.emptyauth turned off,
> 16:27:28.208924 http.c:524              => Send header: GET /info/refs?service=git-upload-pack HTTP/1.1
> 16:27:28.212872 http.c:524              <= Recv header: HTTP/1.1 401 Authorization Required
> Username for 'http://git': [I just pressed enter]
> Password for 'http://git': [ditto]
> 16:27:29.928872 http.c:524              => Send header: GET /info/refs?service=git-upload-pack HTTP/1.1
> 16:27:29.929787 http.c:524              <= Recv header: HTTP/1.1 401 Authorization Required

Just to be sure: did you remove http.emptyauth config completely from
your config files, or did you turn it to "false"? Because the new
behavior only kicks in when it isn't configured at all (probably we
should respect "auto" as a user-provided name).

> (if someone else wants to replicate this, delete >/dev/null bit 
> from Jeff's shell snippet)

Hrm, you shouldn't need to. The stderr redirection comes first, so it
should become the new stdout.

-Peff
