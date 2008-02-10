From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 18:29:11 -0500
Message-ID: <20080210232911.GA15313@sigill.intra.peff.net>
References: <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de> <alpine.LSU.1.00.0802091307160.11591@racer.site> <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802100213330.11591@racer.site> <0DE4061C-7189-4932-AA3D-D09009F753F2@wincent.com> <alpine.LSU.1.00.0802101625200.11591@racer.site> <07136779-23EB-4DAA-84C3-D54B7AC029AB@wincent.com> <20080210223440.GA15051@sigill.intra.peff.net> <7vzlu8cta1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 00:29:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOLcM-0000lN-Hp
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 00:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbYBJX3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 18:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbYBJX3P
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 18:29:15 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1408 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752695AbYBJX3O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 18:29:14 -0500
Received: (qmail 1690 invoked by uid 111); 10 Feb 2008 23:29:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 10 Feb 2008 18:29:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2008 18:29:11 -0500
Content-Disposition: inline
In-Reply-To: <7vzlu8cta1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73434>

On Sun, Feb 10, 2008 at 02:59:18PM -0800, Junio C Hamano wrote:

> > ... Are there any
> > other git commands which use non-HEAD branches that have not been
> > explicitly mentioned by the user?  I can think only of query-type
> > commands (like show-branch, or describe) that are non-state-changing.
> 
> That's an irrelevant comparison.  push and fetch have always
> been multi-branch operations by default from day one.  The issue
> is not HEAD vs non-HEAD.

I think "irrelevant" here is in the eye of the beholder. If you are
coming from the perspective of "historical behavior" then the current
behavior makes sense. If you are coming from the perspective of a user
who does not typically do a lot of branching, then the behavior can be
surprising. And I think there is anecdotal evidence that some users _do_
find this surprising. I have personally seen it, and I think even an
experienced user like Martin is finding the behavior non-intuitive.

> You can argue that historically established practices do not
> matter at all (at least to new people), and I'd grant that it
> may be a valid argument.  But a change that breaks existing
> practices needs to be sold much more carefully.  I still do not

Agreed.

> understand what the opposition is to keep the current behaviour
> as the default and have a shorthand for the single head push
> accessible with a short and sweet "git push $there HEAD" (and
> default $there to 'origin' when missing).

I think the problem is that you are asking people with particular
workflows to always remember to type something extra, and if they
forget, you punish them by doing a potentially destructive operation
(although admittedly, it is destructive only if you happen to be using
"-f").

> If you are introducing a new behaviour, there is no way the new
> behaviour can start out by replacing the longtime default.  It
> should start out as an option, and if it is a commonly useful
> option then make it an _easily accessible_ option.  And accept
> such an _enhancement_ sooner to help people who want such a
> behaviour sooner.  That would not hurt anybody but help
> (hopefully) many people, without downside.

I think we already have that option (as you mentioned): "git push $there
HEAD". We can make it more easily accessible (as you have proposed):
"git push HEAD" (though I still have some reservations about that). But
none of that changes the fact that for some people's workflows, they
will _always_ have to remember to add extra magic to the command line.

What I have proposed is adding a config option to make that option even
more easily accessible. The only argument I have seen against that is
"some users can't use other users' git setup". While this is a downside,
I think this uncommon situation is outweighed by the very common
situation of users using their _own_ git setups.

IOW, such an option makes a tradeoff. Users helping other users must
explicitly say what they mean: "git push --matching" or "git push $there
HEAD". But users using their own setups can use the shorthand "git push"
to do what is most useful for their workflow. And I think we should
optimize for the latter case, as it is much more common.

-Peff
