Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CA75202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 18:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752806AbdJ3S1V (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 14:27:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:40448 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752778AbdJ3S1V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 14:27:21 -0400
Received: (qmail 10771 invoked by uid 109); 30 Oct 2017 18:27:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Oct 2017 18:27:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25848 invoked by uid 111); 30 Oct 2017 18:27:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Oct 2017 14:27:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Oct 2017 11:27:19 -0700
Date:   Mon, 30 Oct 2017 11:27:18 -0700
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?B?QmVyZcW8YcWEc2tp?= <kuba@berezanscy.pl>,
        Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/2] t0302: check helper can handle empty credentials
Message-ID: <20171030182718.oyzhjffd6jd4wslu@sigill.intra.peff.net>
References: <cover.1509383993.git.johannes.schindelin@gmx.de>
 <e055913ec27fc3feb3f017747560f454f6817a0b.1509383993.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e055913ec27fc3feb3f017747560f454f6817a0b.1509383993.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 30, 2017 at 06:20:12PM +0100, Johannes Schindelin wrote:

> Subject: Re: [PATCH 1/2] t0302: check helper can handle empty credentials

I guess we really care about t0303 here (which tests external helpers).
This patch adds the test to lib-credential, so it hits the "cache" and
"store" helpers, too. Which seems to pass, so I guess that's OK (I have
to admit that as the author of those tools, I wasn't sure how they'd
react).

> Make sure the helper does not crash when blank username and password is
> provided. If the helper can save such credentials, it should be able to
> read them back.

I worry that some third-party helpers might not be able to represent
this case and would fail the test. This has been around for years no
Windows, but probably hasn't ever been run with osxkeychain or
libsecret. I'd be OK with taking this as-is, though, and waiting to see
if anybody complains. At that point we'll know if the right solution is
enhancing that helper, or providing a way to optionally skip this test.

(Though I have no idea if anybody actually runs t0303 against
custom-built helpers in the first place. The process is pretty manual
for now, though the Makefiles in contrib/credential could probably at
least provide a "make test").

-Peff
