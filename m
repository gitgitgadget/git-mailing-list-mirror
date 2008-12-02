From: Jeff King <peff@peff.net>
Subject: Re: Managing websites with git
Date: Mon, 1 Dec 2008 20:11:54 -0500
Message-ID: <20081202011154.GA6390@coredump.intra.peff.net>
References: <fe5a74300811300830x850d81csc5cf1f9b367bac11@mail.gmail.com> <20081130170722.GJ6572@eratosthenes.sbcglobal.net> <20081130172717.GA7047@coredump.intra.peff.net> <87k5ajflp0.fsf@sparse.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Bryson <david@statichacks.org>,
	Felix Andersen <felix@nibbo.se>, git@vger.kernel.org
To: Jason Riedy <jason@acm.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 02:13:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7JpP-0003bo-ID
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbYLBBL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbYLBBL7
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:11:59 -0500
Received: from peff.net ([208.65.91.99]:4527 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbYLBBL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:11:58 -0500
Received: (qmail 6925 invoked by uid 111); 2 Dec 2008 01:11:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Dec 2008 20:11:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Dec 2008 20:11:54 -0500
Content-Disposition: inline
In-Reply-To: <87k5ajflp0.fsf@sparse.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102085>

On Mon, Dec 01, 2008 at 07:46:35PM -0500, Jason Riedy wrote:

> And David Bryson writes:
> > One really should not push to a non-bare repo.
> WHAT?!?!?!

To clarify: one should not push to the _current branch_ of a non-bare
repo...

> And Jeff King responds:
> > It's in master and should be in 1.6.1, but it is a config option that
> > defaults to "warn" for now, so as not to break existing setups.
> WHAT?!?!?!

...and that is what 1.6.1 will warn about.

> I do this all the time.  I clone from my main working directory
> onto some cluster / MPP where the build system is all wonky.
> Once I get everything building, I push back to a branch (often
> new) in my main working directory.  Then I can merge the build
> changes whenever I get a chance.

As long as you are not pushing to the currently checked-out branch, then
you will see no change in behavior. If you are pushing to the currently
checked-out branch, then what are you doing to reconcile the resulting
mismatch between the index and HEAD?

> Pushing from these systems often is much, much easier than
> pulling from the origin.  Sometimes you're working in temporary
> space on a back-end node; you can connect out but you cannot
> connect in.

Of course. The recommended thing to do is:

  # on pusher
  git push $remote HEAD:some-branch-that-is-not-checked-out
  # on $remote
  git merge some-branch-that-is-not-checked-out

where an obvious choice for branch name is "incoming/master" or whatever
suits your workflow. You can also do:

  # on pusher
  git push $remote HEAD:branch-that-is-checked-out
  # on $remote
  git reset --hard

but that throws away anything else going on in that branch on $remote.

> It feels like newer gits make more and more decisions about what
> I shouldn't do.

Doing

  git push $remote HEAD:branch-that-is-checked-out

has _never_ worked without further action on $remote. Now we're warning
about it.

If you have other specific complaints about new git behavior, I'm sure
the list would be happy to hear about it. Almost every behavior change
is in response to user complaints, and a lot of effort is put into
maintaining backwards compatibility. If we've screwed up somewhere, it
would be good to know.

-Peff
