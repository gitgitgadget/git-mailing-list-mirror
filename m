From: Jeff King <peff@peff.net>
Subject: Re: Funny: git -p submodule summary
Date: Sun, 11 Jan 2009 06:22:22 -0500
Message-ID: <20090111112222.GA29656@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090109083836.GB21389@coredump.intra.peff.net> <20090109092250.GA1809@coredump.intra.peff.net> <49672244.80200@viscovery.net> <20090109101335.GA4346@coredump.intra.peff.net> <496728B9.7090200@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Jan 11 12:23:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLyQ0-0007l5-S7
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 12:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbZAKLWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 06:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbZAKLWZ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 06:22:25 -0500
Received: from peff.net ([208.65.91.99]:52975 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbZAKLWY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 06:22:24 -0500
Received: (qmail 22447 invoked by uid 107); 11 Jan 2009 11:22:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 11 Jan 2009 06:22:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Jan 2009 06:22:22 -0500
Content-Disposition: inline
In-Reply-To: <496728B9.7090200@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105166>

On Fri, Jan 09, 2009 at 11:36:41AM +0100, Johannes Sixt wrote:

> I'll test your other patch (that replaces the execvp in git.c by
> run_command).

There is something funny with it that I have not diagnosed: aliases are
broken, and "git foobar" does not return an error. Presumably just
checking the "we did not exec succesfully" case is not triggering
properly.  However, I think the right solution is actually to refactor
git.c to figure out ahead of time whether we have a builtin, external,
or alias. I can work on that, but not tonight, as my git-time is up for
now.

But other than that, did it work for you on Windows?

However, here is a 4-patch series that handles the separate signal
delivery problem. It should fix the "^C makes funny things happen"
problems you were seeing. Please test and let me know how it works on
Windows.

The patches are:
  1/4: Makefile: clean up TEST_PROGRAMS definition
  2/4: chain kill signals for cleanup functions
  3/4: refactor signal handling for cleanup functions
  4/4: pager: do wait_for_pager on signal death

-Peff
