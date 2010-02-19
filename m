From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 7/7] t7006-pager: if stdout is not a terminal, make
 a new one
Date: Fri, 19 Feb 2010 03:08:19 -0500
Message-ID: <20100219080819.GA13691@coredump.intra.peff.net>
References: <20100219065010.GA22258@progeny.tock>
 <20100219072331.GG29916@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 09:08:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiNuV-0008AB-Ia
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 09:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab0BSIIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 03:08:22 -0500
Received: from peff.net ([208.65.91.99]:41610 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767Ab0BSIIV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 03:08:21 -0500
Received: (qmail 12259 invoked by uid 107); 19 Feb 2010 08:08:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 19 Feb 2010 03:08:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2010 03:08:19 -0500
Content-Disposition: inline
In-Reply-To: <20100219072331.GG29916@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140430>

On Fri, Feb 19, 2010 at 01:23:31AM -0600, Jonathan Nieder wrote:

> Test t7006-pager skips most of its tests except when running with
> --verbose, for lack of a terminal to use.  Thus many of the tests
> would not get much coverage, since whole testsuite runs with --verbose
> are rare.  Redirecting output to /dev/tty would be problematic because
> (1) there really could be no controlling terminal and (2) test
> breakage might manifest itself by the producing extraneous output.
> Luckily, there is a way around this: Unix98-style pseudo-terminals
> allow us to create a fake terminal on the fly and capture its output.
> 
> Do so.  The new test-terminal command to accomplish this uses
> posix_openpt (from SuSv3) to create a terminal because that is good
> enough on Linux.  I would like some feedback on what platforms are
> missing that function and thus what alternate interfaces are worth
> supporting.  The perl IO::Tty module could take care of this for us,
> but I do not think it is worth the extra dependency.

Solaris 8 and 9 seem to be lacking it. Solaris 10 does have it. AIX 5.2
and 6.1 both have it.

So it would mean some platforms couldn't run all tests. That is probably
good enough, given that most of our terminal-related bugs have not been
platform-specific problems.

Still, it seems like just wrapping isatty would be simpler. I guess you
are opposed to carrying around test-specific code in the main git
binary?

-Peff
