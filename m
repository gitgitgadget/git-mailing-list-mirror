From: Pavel Roskin <proski@gnu.org>
Subject: Re: gitk changing line color for no reason after merge
Date: Wed, 08 Feb 2006 16:06:23 -0500
Message-ID: <1139432783.16999.37.camel@dv>
References: <1138900897.28967.18.camel@dv> <1139289517.15955.23.camel@dv>
	 <7vlkwnxz5t.fsf@assigned-by-dhcp.cox.net> <1139360047.13646.22.camel@dv>
	 <17385.22468.218755.833713@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 22:10:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6wZN-0003Vk-5l
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 22:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWBHVJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 16:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWBHVJm
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 16:09:42 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:9405 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964914AbWBHVJm
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 16:09:42 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F6wZC-0008KB-4c
	for git@vger.kernel.org; Wed, 08 Feb 2006 16:09:38 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F6wW8-0004o1-8v; Wed, 08 Feb 2006 16:06:24 -0500
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17385.22468.218755.833713@cargo.ozlabs.ibm.com>
X-Mailer: Evolution 2.5.90 (2.5.90-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15751>

On Wed, 2006-02-08 at 13:30 +1100, Paul Mackerras wrote:
> Pavel Roskin writes:
> 
> > I'm trying to make it easier to follow a line.  It's easier if its color
> > is not changing, especially on trivial nodes (one parent, one child).
> 
> OK, you're using "line" to mean something a bit different from the
> connection between a commit and its children, which is how I use it.

I see.  Actually, your choice seems to me quite random and
non-intuitive.  You group together changes that have the same parent,
likely made independently by different people.  In fact, only those
changes are shown that would lead to the current revision of the
repository, unless "--all" is used.  Changes on unmerged branches are
not shown.

If you prefer "horizontal" grouping, it would be more logical to turn it
upside down, i.e. group commits with their parents.  In this case, the
line group would represent one act of merging, performed by one person.
No parents are hidden from view even without "--all".

> You seem to be using it more as a "line of development", or as a
> series of related patches.  Which is fine, if you can find a way to
> identify lines of development automatically.  (I know it looks obvious
> when you look at the gitk display, but that's a lot different from
> writing down an algorithm to do it.)

As usually, let's go from the newest commits to the root of the tree.
The idea is to assign branch ID to changesets, i.e. to combinations of
sha1 and parent number.  Branch ID should be inherited from the children
by the first parent.  Other parents get new branch ID.  There should be
a list of active branches, i.e. those branch ID with yet to be seen
parents.  Color should be assigned to branch ID at the creation time.
The color should be selected according to two rules, whenever possible.
It should be unique among the already assigned colors for the same
child, and is should avoid colors of the active branches.

Actually, qgit does a pretty reasonable thing.  I haven't used gitk for
months, but I had to inspect a Mercurial repository using hgk.  I was
surprised by its "crazy" color changes (or so it seemed to me after
qgit), then I found that gitk had the same problem, then I fixed it and
started this thread :-)

> > http://red-bean.com/proski/gitk/gitk-ideal.png - made in GIMP.  Trivial
> > nodes never change line color, because it changes as soon as the line
> > forks.
> 
> My problem with that is that it isn't clear that e.g. the green and
> brown lines near the bottom actually represent the same parent - and
> that will get worse with more complex graphs.

You are right.  qgit only uses vertical and horizontal lines, so it's
easier to find the parent.

-- 
Regards,
Pavel Roskin
