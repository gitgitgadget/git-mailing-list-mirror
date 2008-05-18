From: Jeff King <peff@peff.net>
Subject: Re: t3701 fails if core.filemode disabled
Date: Sun, 18 May 2008 15:08:39 -0400
Message-ID: <20080518190839.GC15506@sigill.intra.peff.net>
References: <20080518152337.GB3058@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 18 21:09:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxoGE-0007TU-AW
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 21:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbYERTIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 15:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753485AbYERTIn
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 15:08:43 -0400
Received: from peff.net ([208.65.91.99]:4884 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608AbYERTIm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 15:08:42 -0400
Received: (qmail 5548 invoked by uid 111); 18 May 2008 19:08:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 18 May 2008 15:08:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 May 2008 15:08:39 -0400
Content-Disposition: inline
In-Reply-To: <20080518152337.GB3058@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82395>

On Sun, May 18, 2008 at 05:23:37PM +0200, Alex Riesen wrote:

> This is on Cygwin, yes. I have the core.filemode disabled in
> ~/.gitconfig. How about stopping the test before the failing portion
> (only the last two fail, below)?

What's in your ~/.gitconfig shouldn't have any effect (the test scripts
take care to avoid looking at anything outside of your git directory).
But presumably this test is broken on Cygwin, anyway?

I don't mind disabling these tests if they don't make sense on certain
platforms, but regarding your specific proposal:

  - can you confirm that the test doesn't make sense, and not that it is
    simply broken on cygwin? Does changing your ~/.gitconfig's
    core.filemode make a difference? It shouldn't, but that could be
    a bug in test-lib. What happens if you run the test manually? Does
    git-add just not prompt for the mode change?

  - if the tests are to be disabled, I think it is better to
       if tests_make_sense; do
         tests
       fi
    rather than exiting the script. It is less error prone if tests get
    added later.

  - What is the right tests_make_sense? You are checking core.filemode,
    but that should not be leaking in from your .gitconfig. Does cygwin
    have a different defaults for that value? Is it actually a matter of
    being on a filesystem which doesn't properly handle the executable
    bit?

-Peff
