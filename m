From: Jeff King <peff@peff.net>
Subject: Re: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Tue, 27 Apr 2010 13:54:42 -0400
Message-ID: <20100427175442.GB13626@coredump.intra.peff.net>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <4BD7032D.9050508@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 27 19:54:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6ozo-0002j6-B9
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 19:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab0D0Ryr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 13:54:47 -0400
Received: from peff.net ([208.65.91.99]:42580 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362Ab0D0Ryq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 13:54:46 -0400
Received: (qmail 30824 invoked by uid 107); 27 Apr 2010 17:54:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 27 Apr 2010 13:54:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Apr 2010 13:54:42 -0400
Content-Disposition: inline
In-Reply-To: <4BD7032D.9050508@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145933>

On Tue, Apr 27, 2010 at 05:30:53PM +0200, Michael J Gruber wrote:

> Your diff -> test_cmp are certainly something we want to have in any
> case. The code changes look ugly, honestly, making the code much less
> readable, but it seems to be the only way to make those older platforms
> and compilers happy. (Erik pointed out some good ways to reduce the
> uglyness somewhat.)

I agree. We really need to make a decision here about how far backward
we are willing to bend for older systems.

Solaris 2.6 was released in 1997, and Sun dropped support for it in
2006, four years ago. How long do we want to continue supporting it? And
at what cost?  If we have not hit end-of-life on it now, then what would
be a reasonable time? And what defines end-of-life support for git? I am
perfectly happy to carry a Solaris 2.6 section of the Makefile forever.
But if it is going to cause code changes that make the code harder to
read and maintain, is it worth it? Especially when one could probably
just use gcc to build for those platforms. Sure, it may be less
convenient for the builder, and it may not generate quite as good code
as a vendor compiler, but to what degree should we care? Those platforms
are an extreme minority, and we need to balance their impact on code
that developers on every platform have to work with.

Furthermore, if we do take such changes, how are we going to manage
portability going forward? Some constructs (like non-constant
initializers) make the code much easier to read. People _will_ submit
patches that use them. Is somebody going to be auto-building on all of
these platforms with vendor compilers to confirm that nothing is broken?

If all of these questions seem like rhetorical "I am trying to convince
you these patches aren't a good idea" questions, they're not meant as
such. I think these are serious questions that need to be answered when
evaluating portability patches.

-Peff
