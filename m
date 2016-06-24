Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088872018A
	for <e@80x24.org>; Fri, 24 Jun 2016 16:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbcFXQqI (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 12:46:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:59775 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751132AbcFXQqH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 12:46:07 -0400
Received: (qmail 23721 invoked by uid 102); 24 Jun 2016 16:46:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 12:46:06 -0400
Received: (qmail 20681 invoked by uid 107); 24 Jun 2016 16:46:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 12:46:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 12:46:03 -0400
Date:	Fri, 24 Jun 2016 12:46:03 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 1/4] t5000: test tar files that overflow ustar headers
Message-ID: <20160624164603.GA13789@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
 <20160623232041.GA3668@sigill.intra.peff.net>
 <576D621F.1030000@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <576D621F.1030000@kdbg.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 06:38:55PM +0200, Johannes Sixt wrote:

> Am 24.06.2016 um 01:20 schrieb Jeff King:
> > +# We expect git to die with SIGPIPE here (otherwise we
> > +# would generate the whole 64GB).
> > +test_expect_failure BUNZIP 'generate tar with huge size' '
> > +	{
> > +		git archive HEAD
> > +		echo $? >exit-code
> > +	} | head -c 4096 >huge.tar &&
> > +	echo 141 >expect &&
> > +	test_cmp expect exit-code
> 
> It's going to be 269 with ksh, and who-knows-what on Windows (due to lack of
> SIGPIPE - I haven't tested this, yet).

Thanks, I meant to ask about that. We do a workaround in t0005, but we
_don't_ do it in the new sigpipe handling for test_must_fail. Is the
latter just broken, too?

-Peff
