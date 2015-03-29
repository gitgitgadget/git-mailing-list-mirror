From: Jeff King <peff@peff.net>
Subject: Re: [question] && chaining vs shell loops
Date: Sun, 29 Mar 2015 13:43:13 -0400
Message-ID: <20150329174312.GA6680@peff.net>
References: <20150329154840.GA8771@wheezy.local>
 <874mp3948k.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Mar 29 19:43:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcHF3-0002yK-Ho
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 19:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbbC2RnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 13:43:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:39660 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752408AbbC2RnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2015 13:43:16 -0400
Received: (qmail 27249 invoked by uid 102); 29 Mar 2015 17:43:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 29 Mar 2015 12:43:16 -0500
Received: (qmail 10206 invoked by uid 107); 29 Mar 2015 17:43:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 29 Mar 2015 13:43:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Mar 2015 13:43:13 -0400
Content-Disposition: inline
In-Reply-To: <874mp3948k.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266442>

On Sun, Mar 29, 2015 at 06:07:39PM +0200, Andreas Schwab wrote:

> Max Kirillov <max@max630.net> writes:
> 
> > As far as I can see, loops in shell ignore non-zero exit
> > codes of the bodies which are not last. For example, exit
> > code of command 'for f in false true; do $f; done' is 0,
> > even if there was false.
> 
> There is nothing special with loops, that's how the exit code of
> compound commands is defined in general: it's the exit code of the last
> executed command.

Yes, but that makes it problematic if you want to know if any of the
loop iterations failed. Doing:

  for f in false true; do $f || break; done

doesn't work, because the "break" has exit code 0. Doing:

  (for f in false true; do $f || exit 1; done)

works. In our test scripts, it is also OK to just "return 1", because
the test snippets execute inside a function.

If you have other solutions, I'd love to hear them. I just fixed several
of these loops recently, and I couldn't come up with anything more
clever.

-Peff
