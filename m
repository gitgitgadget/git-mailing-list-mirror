From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when
	cherry-picking an empty commit
Date: Sun, 22 Mar 2009 18:38:34 -0400
Message-ID: <20090322223834.GB22428@sigill.intra.peff.net>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com> <20090308144240.GA30794@coredump.intra.peff.net> <7v8wnflrws.fsf@gitster.siamese.dyndns.org> <20090310181730.GD26351@sigill.intra.peff.net> <AA6A171F-70CE-4CB3-9AE1-27CD69C3202C@pobox.com> <20090311003022.GA22273@coredump.intra.peff.net> <e2b179460903110408i4ab3c9cg3c863b89a2f57cba@mail.gmail.com> <20090322094139.GA10599@coredump.intra.peff.net> <7veiwpdxtg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:40:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlWKt-0004xK-63
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 23:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908AbZCVWif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 18:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754929AbZCVWif
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 18:38:35 -0400
Received: from peff.net ([208.65.91.99]:59744 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbZCVWif (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 18:38:35 -0400
Received: (qmail 16633 invoked by uid 107); 22 Mar 2009 22:38:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 22 Mar 2009 18:38:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2009 18:38:34 -0400
Content-Disposition: inline
In-Reply-To: <7veiwpdxtg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114190>

On Sun, Mar 22, 2009 at 02:58:35PM -0700, Junio C Hamano wrote:

> > Junio, do you want to put anything in the release notes warning people
> > who build from source that this is a potential issue? Do you want
> > something in the Makefile detecting that the shell is broken?
> 
> A sentence or two in INSTALL will not hurt.
> 
> I would not worry too much about the test scripts, but I would worry more
> about getting phantom bug reports for our shell script Porcelains that get
> hit by this.  Earlier I mentioned bisect is the only heavy user, but the
> issue is more severe with filter-branch that is designed to eval end user
> scripts (calls to 'eval "$filter_frotz"' check the exit status and die on
> failure---with trailing blank lines the failure the filter reports will
> not get caught).

Agreed. The good news is that the /bin/sh people are treating it like a
bug:

  http://lists.freebsd.org/pipermail/freebsd-standards/2009-March/001721.html

so it will hopefully be fixed soon. It might still be worth warning
users of older releases in INSTALL, though.

-Peff
