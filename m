From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Thu, 5 Jun 2008 05:20:16 -0400
Message-ID: <20080605092016.GA16748@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200806050954.13244.trast@student.ethz.ch> <20080605081126.GA16416@sigill.intra.peff.net> <200806051105.02802.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 05 11:21:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Bek-00052z-AE
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 11:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbYFEJUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 05:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753019AbYFEJUV
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 05:20:21 -0400
Received: from peff.net ([208.65.91.99]:4729 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbYFEJUU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 05:20:20 -0400
Received: (qmail 20351 invoked by uid 111); 5 Jun 2008 09:20:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 05 Jun 2008 05:20:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jun 2008 05:20:16 -0400
Content-Disposition: inline
In-Reply-To: <200806051105.02802.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83887>

On Thu, Jun 05, 2008 at 11:04:58AM +0200, Thomas Rast wrote:

> (Somehow it seems rather ironic that I'm trying to implement a feature
> that provides plenty of live bullets, yet keep shooting myself with
> the _MUA_.)

Heh.

> I should have provided a definition, sorry.  By "your" scheme, I meant
> the one where one is restricted to deleting existing lines, and thus
> deletes '-' lines to disable them; by "my" scheme, where one is free
> to edit and changes '-' lines to context to disable them.

OK, thanks for the clarification.

> At least it's my current understanding that, under the above
> definition, "your" scheme is what you actually proposed in
>   http://www.spinics.net/lists/git/msg67478.html
>   [why doesn't Google find gmane?]
> but I misunderstood and implemented "my" scheme.

For the record, "my" scheme was only half thought-through, and I think I
actually like "your" scheme better. Once we give the user an editor,
restricting them to a tiny subset of editor operations seems error-prone
and annoying, since we have no way of enforcing those operations except
to wait until after they edit and say "oops, you did something bad."

> [Let's just forget about the original patch at the top of the thread;
> in retrospect, it _is_ clunky, and the UI didn't get any replies in
> favour.]

It seems like Junio isn't all that keen on the raw patch-editing
interface. And even if we do like it, I think there is still room for a
less error-prone but more restrictive feature that mere mortals can use.
So maybe there is a better interface yet.

What about 'S' to do a "line split"; that is, take the current hunk, and
anywhere there are adjacent changed lines, split them into their own
hunks. I.e. the hunk,

   line 1
  +line 2
  -line 3
   line 4
  -line 5

becomes three hunks:

   line 1
  +line 2

  -line 3
   line 4

  -line 5

and then we proceed as usual, staging or not each split hunk. It would
be clunky to separate one or two lines from a huge chunk (since you
would inadvertently split the huge chunk and have to stage each
individually). But in many cases you can split into smaller hunks first
with 's'.

-Peff
