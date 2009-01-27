From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/3] fix "Funny: git -p submodule summary"
Date: Tue, 27 Jan 2009 07:23:15 -0500
Message-ID: <20090127122315.GA22628@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090127062512.GA10487@coredump.intra.peff.net> <497EDCB0.8080806@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 13:26:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRn0x-0000AY-Ib
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 13:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbZA0MXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 07:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752874AbZA0MXU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 07:23:20 -0500
Received: from peff.net ([208.65.91.99]:60593 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbZA0MXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 07:23:20 -0500
Received: (qmail 11066 invoked by uid 107); 27 Jan 2009 12:23:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 27 Jan 2009 07:23:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jan 2009 07:23:15 -0500
Content-Disposition: inline
In-Reply-To: <497EDCB0.8080806@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107338>

On Tue, Jan 27, 2009 at 11:06:40AM +0100, Johannes Sixt wrote:

> - Note that run_command returns the negated exit code, therefore, we must 
> negate it again in the call to exit(). Without this t6030 failed. (And 
> negative exit codes causes grief on Windows because bash for some reason 
> does not recognize that as failure.)

Oops, indeed. And you made me realize that I forgot to run the test
script against this patchset.

However, I'm not sure just negating the exit code is sufficient.
run_command can return codes in the 10000 range for its own internal
errors. We don't want to pass those out through exit, which will
truncate them to 8 bits.

> - The close() calls can overwrite errno.

Good point.

> And since fork() should not  (cannot?) fail with ENOENT, it's safe to
> remove the #ifdef __MINGW32__.

Yeah, I thought of that, but I was worried it might make the code a
little bit non-obvious (but it does clean up an ifdef, which is ugly,
too).

Thanks for your feedback. I'll squash in your fixes and repost 2/3 later
today.

-Peff
