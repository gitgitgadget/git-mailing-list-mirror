From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: Talk about tracking third-party snapshots
Date: Sun, 18 Nov 2007 20:17:01 -0500
Message-ID: <20071119011701.GC23671@fieldses.org>
References: <11949569992214-git-send-email-msmith@cbnco.com> <7vtznqrlrb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Smith <msmith@cbnco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 02:17:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItvGU-0007GP-SV
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 02:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbXKSBRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 20:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbXKSBRN
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 20:17:13 -0500
Received: from mail.fieldses.org ([66.93.2.214]:44901 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509AbXKSBRM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 20:17:12 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1ItvG1-0000oO-IX; Sun, 18 Nov 2007 20:17:01 -0500
Content-Disposition: inline
In-Reply-To: <7vtznqrlrb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65398>

On Tue, Nov 13, 2007 at 11:25:12AM -0800, Junio C Hamano wrote:
> Michael Smith <msmith@cbnco.com> writes:
> 
> > +You can fix situations like these by doing a merge that isn't really a
> > +merge, using the "ours" merge strategy. Look through the history on the
> > +third-party branch and try to find the exact commit that matches the
> > +last snapshot you imported. Often there's a tag close to the commit, or
> > +on the commit, if you're lucky--but don't trust it blindly; check the
> > +diffs. Check out your local branch and tell Git about the relationship:
> > +
> > +------------------------------------------------
> > +$ git remote add upstreamgit git://upstream.org/project.git
> > +$ git fetch upstreamgit
> > +$ git tag
> > +v1.0
> > +v1.1
> > +v1.2
> > +$ git checkout master
> > +$ git merge --strategy=ours \
> > +    -m "Tie old v1.1 into our history by merging with strategy=ours." \
> > +    v1.1
> > +------------------------------------------------
> > +
> > +You'll see the branches merge together in `gitk --all` or `git
> > +show-branch master upstreamgit/master`.  Now you'll be able to merge any
> > +changes from the remote branch since v1.1 with `git merge
> > +upstreamgit/master`.
> > +
> 
> This would work only when your 'master' happens to be at v1.1
> (and identical to it) isn't it?  Which means that as an example
> it will be of very limited scope.
> 
> People would want to know "But my 'master' is _not_ at v1.1 but
> is _based_ on v1.1.  How would I handle that case?" and the
> above does not answer that question.
> 
> Even worse, most people are probably not careful enough to ask
> the above question, but just say "Heh, my 'master' is based on
> v1.1, so I'll blindly follow that example to bind the histories
> together".
> 
> I did not find any technical problem in the other parts of your
> description, but I did not read the resulting document from
> cover to cover, so I do not know if your change fits in the
> entire organization of the document very well.

A mention of git-cherry or --left-right someplace might make sense,
maybe in chapter 2 somewhere (maybe in "Browsing revisions"?), but it
might also be useful to discuss this kind of stuff in the "sharing
development with others" section.  (E.g. at the end of "Submitting
patches to a project", it might help to have some hints about how to
recognize when they've been accepted and what to do then.)

The trick of using a merge (possibly with -s ours) to tie together two
independent paths to the same state is more generally useful.  (I've
been using it sometimes to keep track of the revision history of a patch
series, for example).  I'm not sure where that should go.

I like the tips on importing snapshots or other history.  I've long been
wanting an "interoperating with other SCM's" section (rough beginnings
at git://linux-nfs.org/~bfields/git.git docwork-foreign-scms), and maybe
some of this would fit here.

All of these things seem more generally useful even to an audience that
hasn't worked with CVS vendor branches before, so I'd prefer
explanations that didn't reference the CVS stuff.  (With CVS-specific
stuff moved somewhere else, maybe to cvs-migration.txt.)

--b.
