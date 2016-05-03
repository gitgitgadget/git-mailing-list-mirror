From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7300: mark test with SANITY
Date: Tue, 3 May 2016 17:15:29 -0400
Message-ID: <20160503211528.GA32737@sigill.intra.peff.net>
References: <1462301672-20866-1-git-send-email-sbeller@google.com>
 <20160503190417.GD30530@sigill.intra.peff.net>
 <xmqqmvo7lz5f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	janx@linux.com, Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 23:15:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axhfM-0006gX-Ah
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 23:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756572AbcECVPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 17:15:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:33422 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756534AbcECVPc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 17:15:32 -0400
Received: (qmail 28169 invoked by uid 102); 3 May 2016 21:15:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 17:15:31 -0400
Received: (qmail 1986 invoked by uid 107); 3 May 2016 21:15:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 17:15:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 17:15:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmvo7lz5f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293456>

On Tue, May 03, 2016 at 12:28:12PM -0700, Junio C Hamano wrote:

> By the way, it is easy to make a mistake like this, not to notice it
> during a review, and to leave it unnoticed for a long time,
> especially because I do not think anybody active in the development
> community runs tests as 'root'.

I think the advice for running the tests as root has long been: don't.
But I guess some people are in situations where it's hard to do
otherwise.

I'm torn on whether it really matters or not. On the one hand, if a
breakage that is purely in a test and not in git itself goes for a long
time without anyone noticing, it's not really hurting anyone. On the
other, "noticing" and "reporting" are two different things; there may be
people who run "make test" and give up.

FWIW, I just did a "sudo make test" and the only other failures were
around HTTP (which correctly punts with "you can't run http tests as
root", but I set GIT_TEST_HTTPD=1, which turns skipping them into an
error).

> Perhaps in a future update, Travis should learn a step to catch
> breakages like like this.  Or perhaps it is not worth the effort?

Maybe. I admit to not really using the Travis tests myself, as they are
way too slow and cumbersome to debug compared to just running "make
test".  The primary value to me of centralized CI is:

  1. _If_ people are looking at PRs on GitHub, the test status is shown
     right there in the PR, without a reviewer having to wonder whether
     the submitter ran "make test". But since I don't ever look at PRs
     for Git, that's not helpful.

  2. Quicker testing on a variety of platforms that I don't have.

     We've known for years that the tip of master passes your "make
     test" under Linux, but other-platform breakage slips through, and
     we rely on people who use those platforms to report. But that may
     not happen in a timely way, and CI can let us know sooner.

     Right now we've taken a baby step there. CI auto-builds for various
     setups, but we still rely on people who care about those platforms
     to look at the results and surface the data to the list. If we
     tested individual topics picked up from the mailing list and sent
     out an email saying "by the way, this is broken on platform X",
     that would go a long way (and would help point 1, too). I think
     there was some discussion in the 0day thread elsewhere on the list,
     but I didn't follow it too closely.

Anyway, back to the original question. I do think "test as root" can be
considered another platform, which makes it a good match for CI. But at
the same time, I don't know that it has ever surfaced an actual bug in
_Git_, and not just the test suite. So seeing those bugs quickly is a
lot less interesting.

-Peff
