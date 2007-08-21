From: David Watson <dwatson@mimvista.com>
Subject: Re: Multiple branches and git-svn
Date: Tue, 21 Aug 2007 07:56:11 -0400
Message-ID: <20070821115611.GA21410@mimvista.com>
References: <864pj16r10.fsf@lola.quinscape.zz> <9FD13095-36B5-4663-B658-082981B1ACD9@lrde.epita.fr> <861wdxgncz.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 14:21:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INSjV-0008IB-4h
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 14:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbXHUMVK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 08:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbXHUMVJ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 08:21:09 -0400
Received: from net-207-58-228-27.arpa.fidelityaccess.net ([207.58.228.27]:57057
	"EHLO zimbra.mimvista.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750815AbXHUMVI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2007 08:21:08 -0400
X-Greylist: delayed 1566 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Aug 2007 08:21:08 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.mimvista.com (Postfix) with ESMTP id 33946354E42
	for <git@vger.kernel.org>; Tue, 21 Aug 2007 07:54:02 -0400 (EDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -0.007
X-Spam-Level: 
X-Spam-Status: No, score=-0.007 tagged_above=-10 required=6.6
	tests=[AWL=0.646, BAYES_00=-2.599, RCVD_IN_NJABL_DUL=1.946]
Received: from zimbra.mimvista.com ([127.0.0.1])
	by localhost (zimbra.mimvista.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uWAte4y-jLFS for <git@vger.kernel.org>;
	Tue, 21 Aug 2007 07:54:00 -0400 (EDT)
Received: from localhost (cpe-66-61-71-72.neo.res.rr.com [66.61.71.72])
	by zimbra.mimvista.com (Postfix) with ESMTP id 0E678354E1F
	for <git@vger.kernel.org>; Tue, 21 Aug 2007 07:53:59 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <861wdxgncz.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56290>

Yes, that's quite true. It took me quite a while to figure that out when I
first started using git-svn, and its non-sensicalness nearly put me off using
git entirely. My workflow at this point is to use git-cherry-pick -e to pull in
any changes from other branches, then delete the git-svn-id line. 

Essentially, merging using git-svn is almost entirely broken, since an
inconsistent tool is worthless - you spend more time figuring out if it's going
to break, and working around the breakage, than you save using it.

Now, I'm not sure this is 100% the fault of git-svn. Perhaps keeping its
metadata about which SVN branch it's connected to isn't the best thing, but
git-merge is doing exactly what you ask for. Perhaps we need a merge command in
git-svn that does the right thing? Although what that right thing would be, I'm
not quite sure.  Either way, there needs to be a BIG GIGANTIC WARNING in the
git-svn manual that if you actually use git for what it claims to be great at
(i.e., merging) you may be in for a world of pain, with your coworkers and boss
coming at you with pitchforks and torches. Especially because there are
so many git users who need to interoperate with SVN.

On Tue, Aug 21, 2007 at 01:04:28PM +0200, David Kastrup wrote:
> Benoit SIGOURE <tsuna@lrde.epita.fr> writes:
> 
> > On Aug 15, 2007, at 12:17 PM, David Kastrup wrote:
> >
> >>
> >> After having had several embarrassing occurences with git-svn dcommit,
> >> I think it would not be amiss to mention in the docs just how git-svn
> >> happens to figure out which Subversion remote it is associated with.
> >>
> >> One surprising relevation was that this association changed after a
> >> git-rebase.
> >>
> >> It may be a general git thing, or it may be git-svn specific, but it
> >> was not exactly what I expected.  And the docs were not really that
> >> helpful.
> >>
> >> In particular, man git-svn is completely silent about this.
> >
> > What I do usually is that I look in git log until I see a git-svn-id
> > line:
> > git-svn-id: https://svn.foo.com/svn/project/branches/bar@<rev-SVN>
> > <Repository UUID>
> > AFAIK git-svn dcommit will commit in the branch specified in the last
> > git-svn-id.  I also dcommitted in the wrong branch after a rebase
> > because I imported commits from another branch and the topmost commit
> > in git-log was "pointing to" a different branch.
> 
> Sounds insane: apparently one result is that when you do a merge and
> dcommit, the commit will go to the branch you merged.
> 
> The whole point of merging is to stay on one's current branch.
> 
> -- 
> David Kastrup
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dave Watson
