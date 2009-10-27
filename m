From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: support remote branches in guess_ref DWIM
Date: Mon, 26 Oct 2009 21:45:25 -0400
Message-ID: <20091027014525.GA29583@sigio.peff.net>
References: <20091026213353.GA27871@sigio.peff.net> <7v8wexn34i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 02:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2b4N-0005kp-GF
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 02:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015AbZJ0Blo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 21:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755588AbZJ0Blo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 21:41:44 -0400
Received: from peff.net ([208.65.91.99]:44654 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754603AbZJ0Bln (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 21:41:43 -0400
Received: (qmail 29594 invoked by uid 1000); 27 Oct 2009 01:45:25 -0000
Content-Disposition: inline
In-Reply-To: <7v8wexn34i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131301>

On Mon, Oct 26, 2009 at 04:31:57PM -0700, Junio C Hamano wrote:

> As _our_ origin can never be _their_ origin if we are clone of them, I do
> not think anybody sane would expect it to push into refs/remotes/origin/
> to begin with.

OK, I agree.

> But "not in refs/remotes/" does not automatically mean "the only sensible
> place is refs/heads", does it?  "We do not know what kind of mistake the
> user is trying to make" could be more plausible answer, and in that case,
> "complain and die" may be a more valid course of action.

The thing is that I can't think of another sensible place. And this
sensible place is useful for one particular action: renaming a remote
branch, like this:

  $ git fetch ;# presumably gets origin/branch
  $ git push origin/branch:renamed-branch

which is much nicer than exposing clueless users to
":refs/heads/renamed-branch".

> For example,
> 
>     git push origin origin/master:refs/heads/master
> 
> is most likely to be a mistake.  The only situation something similar to
> this makes sense is where you pushed out a bogus commit earlier and are
> trying to correct it perhaps with

I'm not sure why it's likely to be a mistake. I've given the one use
case I can think of where you _do_ want to do it. But I'm not sure why
you would accidentally provide something in refs/remotes, or not want to
be pushing to refs/heads. Where _else_ do you push, except for tags?

Am I missing some part of your argument?

> > A related issue (which exists even without this patch) is that doing
> > this:
> >
> >   master:remotes/incoming/master
> >
> > will create "refs/heads/remotes/incoming/master". Perhaps we should DWYM
> > a little more and recognize "heads", "remotes", and "tags" as special.
> 
> Yes, it is an independent issue; I think correcting this DWIM (or at least
> "warning" if not refusing to create remotes/ under refs/heads/) might be a
> good idea.

OK, I'll try to work up a patch.

-Peff
