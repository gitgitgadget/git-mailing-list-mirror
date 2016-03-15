From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone tests: rename t57* => t56*
Date: Tue, 15 Mar 2016 17:51:22 -0400
Message-ID: <20160315215121.GA30011@sigill.intra.peff.net>
References: <1458077150-15564-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 22:51:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afwsD-0004Mn-AH
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 22:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbcCOVv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 17:51:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:60159 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752958AbcCOVvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 17:51:25 -0400
Received: (qmail 13233 invoked by uid 102); 15 Mar 2016 21:51:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Mar 2016 17:51:24 -0400
Received: (qmail 7135 invoked by uid 107); 15 Mar 2016 21:51:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Mar 2016 17:51:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Mar 2016 17:51:22 -0400
Content-Disposition: inline
In-Reply-To: <1458077150-15564-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288921>

On Tue, Mar 15, 2016 at 02:25:50PM -0700, Stefan Beller wrote:

> When trying to find a good spot for testing clone with submodules, I
> got confused where to add a new test file. There are both tests in t560*
> as well as t57* both testing the clone command. t/README claims the
> second digit is to indicate the command, which is inconsistent to the
> current naming structure.
> 
> Rename all t57* tests to be in t56* to follow the pattern of the digits
> as laid out in t/README.
> 
> It would have been less work to rename t56* => t57* because there are less
> files, but the tests in t56* look more basic and I assumed the higher the
> last digits the more complicated niche details are tested, so with the patch
> now it looks more in order to me.

This seems like a good change to me. There definitely is a general sense
of "more complex things should come later" in the test suite[1], so
preserving the existing ordering seems reasonable.

> If there is a reason to have 2 separate spaces for clone testing,
> and I missed it, we should document that why it is important to keep
> them separate.

It looks like it was just carelessness from long ago. 5600 was added by
5508a616 (Feb 2006), and then t5700 in cf9dc653 (May 2006). For the
later ones, everybody probably just found or the other and built on top
(some of us even found both at various times; looks like I added t5708
in 2011 and t5603 last year).

I checked whether there were any stragglers in topics in flight with:

  git log --oneline --name-status --diff-filter=A origin..origin/pu t

but I think we are good.

-Peff

[1] I actually don't think the test ordering matters all that much. I
    guess if you run the tests directly from the Makefile, it will stop
    at the most basic test that fails.

    Personally, I run them in longest-to-shortest via "prove", which
    helps parallelism, and gives you the full list of failed tests.
    Which is often a good piece of knowledge by itself (is it just one
    test, or did I horribly break some fundamental part of git?). And
    then I pick one of the failures to study based on what seems simple
    to debug, and/or the area I've been making changes in.

    But I dunno. Maybe other people really do care about the order. It
    doesn't hurt to roughly follow the "simplest comes first" ordering.
