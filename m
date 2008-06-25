From: Theodore Tso <tytso@mit.edu>
Subject: Re: policy and mechanism for less-connected clients
Date: Tue, 24 Jun 2008 22:33:53 -0400
Message-ID: <20080625023352.GC20361@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Jeske <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 04:34:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBKqW-0001Mv-Uk
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 04:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbYFYCeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 22:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbYFYCeB
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 22:34:01 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:54609 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752286AbYFYCeA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 22:34:00 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KBKpW-0000AV-Qf; Tue, 24 Jun 2008 22:33:55 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KBKpV-0005nt-1d; Tue, 24 Jun 2008 22:33:53 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86197>

On Wed, Jun 25, 2008 at 12:36:03AM -0000, David Jeske wrote:
> The purpose of this mechanism is to host a distributed source
> repository in a world where most most developer contributors are
> behind firewalls and do not have access to, or do not want to
> configure a unix server, ftp, or ssh to possibly contribute to a
> project. 

> design assumptions:
> 
> - all developers are firewalled and can not be "pulled" from directly.
> - there can be one or more well-connected servers which all users can access.
> - .. but which they cannot have ssh, ftp, or other dangerous access to
> - .. and whose protocol should be layered on http(s)
> - there is a shared namespace for branches, and tags
> - .. users are not-trusted to change the branches or tags of other users

Up to here, you can do this all with repo.or.cz, and/or github; you
just give each developer their own repository, which they are allowed
to push to, and no once else.  Within their own repository they can
make changes to their branches, so that all works just fine.

> (a) safely "share" every DAG, branch, and tag data in their
> repository to a well-connected server, into an established
> namespace, while only changing branches and tags in their
> namespace. This will allow all users to see the changes of other
> users, without needing direct access to their trees (which are
> inaccessible behind firewalls). [1]

Right, so thats github and/or git.or.cz.  Each user gets his/her own
> repository, but thats a very minor change.  Not a big deal.

> (b) fetch selected DAG, branch, and tag data of others to their tree, to see
> the changes of others (whether merged with head or not) while disconnected or
> remote.

This is also easy; you just establish remote tracking branches.  I
have a single shell scripted command, git-get-all, which pulls from
all of the repositories I am interested in into various remote
tracking branches so while I am disconnected, I can see what other
folks have done on their trees.

> (c) grant and enforce permission for certain users to submit _merges
> only_ onto certain sub-portions of the "well-named branches"

This is the wierd one.  *** Why ***?  There is nothing magical about
merges; all a merge is a commit that contains more than one parent.
You can put anything into a merge, and in theory the result of a merge
could have nothing to do with either parent.  It would be a very
perverse merge, but it's certainly possible.  So what's the point of
trying to enforce rules about "merges only"?

					- Ted
