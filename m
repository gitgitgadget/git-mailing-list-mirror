From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 08:56:21 -0400
Message-ID: <20110914125621.GE16815@dhcp-172-31-195-159.cam.corp.google.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <4E7085E6.3060509@alum.mit.edu>
 <vpqfwjzxu6i.fsf@bauges.imag.fr>
 <201109141428.53163.johanh@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johanh@opera.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 14:56:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3p0z-00086o-Af
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 14:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756373Ab1INM41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 08:56:27 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:41914 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756345Ab1INM40 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 08:56:26 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1R3p0o-0005Au-Ub; Wed, 14 Sep 2011 12:56:23 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1R3p0n-000595-St; Wed, 14 Sep 2011 08:56:21 -0400
Content-Disposition: inline
In-Reply-To: <201109141428.53163.johanh@opera.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181356>

On Wed, Sep 14, 2011 at 02:28:52PM +0200, Johan Herland wrote:
> On Wednesday 14. September 2011, Matthieu Moy wrote:
> > Michael Haggerty <mhagger@alum.mit.edu> writes:
> > > I wish that one could annotate a branch (e.g., at creation) and
> > > have the annotation follow the branch around.  This would be a
> > > useful place to record *why* you created the branch, your plans
> > > for it, etc.  The annotation should be modifiable, because often a
> > > branch evolves in unforeseen ways during its lifetime.  Anybody
> > > could read the annotation to get a quick idea of what kind of work
> > > is in progress.
> > 
> HOWEVER, "git notes prune" will assume that the SHA1 keys are supposed 
> to identify existing git objects, and will delete any note whose SHA1 
> key does not identify a reachable git object.
> 
> Hence, if you promise to never run "git notes prune" on 
> refs/notes/branch-descriptions, you could use that ref to store your 
> branch descriptions keyed by the SHA1 of your branch name.

It seems like notes is the wrong place to encode this.  If people
really want this, what if there was a convention where there could be
a separate branch head: ref/heads/META

which contained a directory structure like this:

<e-mail>/key			# The developer's GPG key
<e-mail>/<tree>/URL		# URL of developer's tree named <tree>
<e-mail>/<tree>/description	# Descrition of <tree>
<e-mail>/<tree>/branch/<branch-name>	# A description of that branch

etc.

Since it's a separate branch head, the contents can be pushed around
and merged very easily, and there's no danger of the information
getting lost via a garbage collection or prune operation.

If there was an association between a local branch and <e-mail>/<tree>
that it was tracking, then either a modified git core or porcelein
command could get the information from the META tree.  It would also
make it easy to fetch a developer's GPG key without having to go to
outside GPG key servers, which is a minor benefit (although maybe
that's not worth it).

	     	   	   	      	 - Ted
