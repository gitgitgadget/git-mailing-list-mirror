From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] git-add--interactive: manual hunk editing mode
Date: Thu, 12 Jun 2008 03:13:11 -0400
Message-ID: <20080612071311.GA32491@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200806111102.31481.trast@student.ethz.ch> <20080612044932.GA25992@sigill.intra.peff.net> <200806120855.26847.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 12 09:14:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6h0h-0006Py-A0
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 09:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbYFLHNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 03:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbYFLHNQ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 03:13:16 -0400
Received: from peff.net ([208.65.91.99]:1165 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753036AbYFLHNP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 03:13:15 -0400
Received: (qmail 13234 invoked by uid 111); 12 Jun 2008 07:13:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 12 Jun 2008 03:13:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jun 2008 03:13:11 -0400
Content-Disposition: inline
In-Reply-To: <200806120855.26847.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84727>

On Thu, Jun 12, 2008 at 08:55:24AM +0200, Thomas Rast wrote:

> > > +# If the patch applies cleanly, the hunk will immediately be marked
> > > +# for staging as if you had answered 'y'.  (However, if you remove
> > > +# everything, nothing happens.)  Otherwise, you will be asked to edit
> > > +# again.
> [...]
> I wanted to make the same special case that 'recount -i' has: Deleting
> everything does not "do nothing", but actually aborts the edit.  So in
> rebase, deleting everything will not rebase anything (instead of
> rebasing "no patches" onto wherever you said).  Along the same lines,
> in the above patch deleting everything does not patch "no changes",
> but aborts editing the hunk and leaves it unchanged.
> 
> Do you think that behaviour confuses users?

Ah, OK. That makes sense. I think it could be worded more explicitly,
though. Maybe:

  If the patch applies cleanly, the edited hunk will immediately be
  marked for staging. If it does not apply cleanly, you will be given an
  opportunity to edit again. If all lines of the hunk are removed, then
  the edit is aborted and the hunk is left unchanged.

> Feeding it the single hunk would be enough, but doing it this way
> ensures that the edited hunk cannot step on another hunk's toes,
> i.e. produce a conflict that may prevent us from applying the patch at
> the end of the hunk selection loop.
> 
> It's fairly unlikely of course, because the user would deliberately
> have to extend the hunk beyond its current borders by adding extra
> context from the original file.

Right, but you may get false positives if a later conflicting hunk is
not staged. Though as you say, I think it is unlikely in either case.

-Peff
