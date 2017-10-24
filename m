Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69AE4202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 01:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdJXBbe (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 21:31:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:33520 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751220AbdJXBbd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 21:31:33 -0400
Received: (qmail 21412 invoked by uid 109); 24 Oct 2017 01:31:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 01:31:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6714 invoked by uid 111); 24 Oct 2017 01:31:39 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Oct 2017 21:31:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Oct 2017 18:31:31 -0700
Date:   Mon, 23 Oct 2017 18:31:31 -0700
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 4/3] t/Makefile: introduce TEST_SHELL_PATH
Message-ID: <20171024013130.5nuxmjlwnm2l3zrq@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
 <20171020225340.6qgybldewi7knxvz@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1710231258451.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1710231258451.6482@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 23, 2017 at 01:01:42PM +0200, Johannes Schindelin wrote:

> On Fri, 20 Oct 2017, Jeff King wrote:
> 
> > @@ -2350,6 +2357,7 @@ GIT-LDFLAGS: FORCE
> >  # and the first level quoting from the shell that runs "echo".
> >  GIT-BUILD-OPTIONS: FORCE
> >  	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@+
> > +	@echo TEST_SHELL_PATH=\''$(subst ','\'',$(TEST_SHELL_PATH_SQ))'\' >$@+
> 
> Do we really want to force the test shell path to be hardcoded at runtime?
> It may be a better idea not to write this into GIT-BUILD-OPTIONS.

My intent was to make it work "out of the box" in the same way as
SHELL_PATH does now. So that:

  echo TEST_SHELL_PATH=whatever >>config.mak
  make test
  cd t && ./t1234-*

both respect it. Without going through BUILD-OPTIONS, I don't think it
makes it into the environment via config.mak (it _does_ if you specify
it on the command-line of "make", though).

For my purposes it would be fine to just use the environment, but I was
trying to have it match the other variables for consistency.

> Or alternatively we could prefix the assignment by
> 
> 	test -n "$TEST_SHELL_PATH" ||
> 
> or use the pattern
> 
> 	TEST_SHELL_PATH="${TEST_SHELL_PATH:-[...]}"

I'm not quite sure what this is fixing.  Is there a case where we
wouldn't have TEST_SHELL_PATH set when running the tests? I think there
are already other bits that assume that "make" has been run (including
the existing reference to $SHELL_PATH, I think).

-Peff
