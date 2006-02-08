From: Pavel Roskin <proski@gnu.org>
Subject: Re: gitk changing line color for no reason after merge
Date: Tue, 07 Feb 2006 20:10:14 -0500
Message-ID: <1139361014.13646.37.camel@dv>
References: <1138900897.28967.18.camel@dv> <1139289517.15955.23.camel@dv>
	 <17384.24784.898327.669875@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 02:11:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6dr4-0003F2-5G
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 02:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWBHBKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 20:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWBHBKT
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 20:10:19 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:34480 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030388AbWBHBKR
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 20:10:17 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F6dqa-0000Jv-I8
	for git@vger.kernel.org; Tue, 07 Feb 2006 20:10:16 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F6dqY-0006wG-Ae; Tue, 07 Feb 2006 20:10:14 -0500
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17384.24784.898327.669875@cargo.ozlabs.ibm.com>
X-Mailer: Evolution 2.5.90 (2.5.90-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15728>

On Tue, 2006-02-07 at 19:56 +1100, Paul Mackerras wrote:
> Pavel Roskin writes:
> > Hello!
> 
> > I didn't realize that the colors correspond to nodes, not branches.
> > Every node has one color that is used for lines to all of its children.
> > It would be much better to assign colors to "branches" consisting of
> > individual lines connecting nodes, but changing that would require many
> 
> Why would that be better?

Because you would get consistent colors between line forks.  The color
would help to tack the line.  Anyway, I don't think I'll ever implement
it myself.

> > > -    if {$nparents($id) <= 1 && $nchildren($id) == 1} {
> > > +    if {$nchildren($id) == 1} {
> > >  	set child [lindex $children($id) 0]
> > >  	if {[info exists colormap($child)]
> > >  	    && $nparents($child) == 1} {
> > > 
> > > 
> > 
> > I still stand behind this patch because it eliminates color changes on
> > the nodes that have exactly one child and parent.  $nparents($id) is
> 
> Ummm... I don't see that you have changed anything for nodes that have
> exactly one parent?

Nodes with one parent are fine.  It's nodes with multiple parents that
are the problem - they fail to inherit the color assigned to their
child.

Let's see what assigncolor does:

|  ----------- color assigned to the child, possibly to be inherited
|
child
|
|  ----------- we are assigning color to this line
|
id ----------- we are processing this node
|\
| \--------\
|           |
parent1   parent2

Why should color at the child change because its single parent has
several parents?

> > However, further changes to reduce color changes didn't produce nice
> > results for me.  If I try to keep one color running as long as possible,
> > I get branches of the same color because, as I said, gitk uses the same
> > color for connections to all children.  So, every node on the branch
> > spurs branching lines of the same color, which can intersect or run
> > side-by-side.
> 
> The colors are really just to make the lines visually distinct.  They
> (the colors) have no semantic meaning.  (I did try coloring the lines
> according to the committer, but I just ended up with an awful lot of
> lines being the same color - corresponding to one Linus Torvalds. :)

I guess I wasn't clear about my intentions.  My only intention is
exactly that - "to make the lines visually distinct".  There is one
corner case where the color changes for no reason.  There are cases that
are harder to fix, but this one is easy, and I have found a working
solution.

-- 
Regards,
Pavel Roskin
