From: Jeff King <peff@peff.net>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 08:10:29 -0500
Message-ID: <20090210131029.GC17305@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 14:12:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWsPA-0006tR-4n
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 14:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbZBJNKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 08:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbZBJNKc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 08:10:32 -0500
Received: from peff.net ([208.65.91.99]:39051 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbZBJNKc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 08:10:32 -0500
Received: (qmail 13707 invoked by uid 107); 10 Feb 2009 13:10:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 08:10:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 08:10:29 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109234>

On Tue, Feb 10, 2009 at 01:59:06PM +0100, Johannes Schindelin wrote:

> > Hmm. Do we really care about how easy it is to generate? Are we
> > expecting people to not use the command interface and instead check out
> > a notes tree and start putting stuff into $commit/foo?
> 
> I wanted to be nice to existing users of the feature (it is in 'next', 
> after all, and Thomas has produced some awesome examples, that will 
> hopefully show the scalability of the thing).
> 
> But you're right, it almost, but not quite, too late to switch.

OK. I think if you are seeing performance benefits from a 2-character
fanout, then we should standardize on that (do you have new performance
numbers somewhere?).

The notes implementation is now in master. If it's about to change in an
incompatible way, how do you want to handle it? I'm wary of a quick
patch to change the format this late in the release cycle. We could hold
it back from 1.6.2. Alternatively, we could let it release with a "this
is probably going to change" warning.

I think I favor holding it back, but I am not picky.

> > multiple notes some sane semantics (one trumps the other, or they are a
> > list, or whatever), but there is still an inconsistency: B's notes and
> > C's notes behave differently. So now A has to start caring about how
> > other people generate their notes.
> > [...]
> 
> You're correct.  This buys all kinds of trouble.

One other thing to note: I think we discussed in the past other kinds of
"more than one way to store it" strategies (e.g., letting a blob note be
the same as a tree note containing a blob "default"). They suffer from
some of the same issues (though not quite as badly, since you would at
least see that there was a conflict).

-Peff
