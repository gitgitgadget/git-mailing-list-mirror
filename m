From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Tue, 1 Jul 2008 23:21:55 -0400
Message-ID: <20080702032155.GA13581@sigill.intra.peff.net>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com> <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com> <20080701095117.GC5853@sigill.intra.peff.net> <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 05:22:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDsvp-0001w8-9B
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 05:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbYGBDV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 23:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbYGBDV7
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 23:21:59 -0400
Received: from peff.net ([208.65.91.99]:1437 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600AbYGBDV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 23:21:59 -0400
Received: (qmail 846 invoked by uid 111); 2 Jul 2008 03:21:57 -0000
Received: from lawn-128-61-25-46.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.25.46)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 01 Jul 2008 23:21:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jul 2008 23:21:55 -0400
Content-Disposition: inline
In-Reply-To: <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87082>

On Tue, Jul 01, 2008 at 09:36:20PM -0400, Adam Brewster wrote:

> Makes sense,  I thought it was small enough for one commit, but I'll
> split it up when I resubmit.

I think in this instance it is not too big a deal either way.  I am just
trying to help encourage good habits. :)

> > Style: we usually spell NUL as '\0'.
> 
> Okay.  I can also include a third patch for the code I cut-and-pasted.

Heh. I said "usually", but I guess even Junio makes mistakes (unless I
am dreaming such a style directive, but ISTR it being mentioned before
on the list). I wouldn't bother with the style cleanup in rev-list
(usually for such small things, we just wait until touching that part of
the code).

> > Why make a hash when the only thing we ever do with it is "keys %new"?
> > Shouldn't an array suffice?
> 
> It's probably a non-issue, but using a hash will prevent duplicates.

Ah, true. And there will be duplicates here, if you have multiple refs
at the same spot in your bundle list. So it should remain as you have
it.

> If all goes well then you're right, but I thought old objects should
> be kept around  in case the user has some reason to manually delete
> them.  As it is, you can go into the basis file and delete everything
> past a given date line and be back where you were.  If I delete the
> redundant objects, then that's not always possible.

Hmm, and that might be useful. Probably the best thing would be to leave
it as-is for now, then, with a note. Then we can decide the best pruning
strategy if and when it becomes an issue.

> Maybe I'm a idiot, but I can't find any built-in date to string
> functions that do nice things like print the date the way the user
> says he likes to look at dates.
> 
> I updated the comment line to be "# <git-date> // `date`" where
> git-date is as per git-fast-import (seconds since 1969 +/-TZ).  If
> automatic pruning ever happens, the git-date will be used, so `date`
> is just for humans.

That sounds reasonable.

> > Notably absent: any tests.
> Working on those.  I'll also include tests for git-bundle.

Great. Glancing over Junio's comments, though, it might make sense to
integrate this more tightly with git-bundle, in which case the perl
stuff would go away. So I'll let you work out with him which is the best
route.

-Peff
