From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Wed, 15 Feb 2006 01:54:11 -0500
Message-ID: <20060215065411.GB26632@spearce.org>
References: <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com> <20060214100844.GA1234@diana.vm.bytemark.co.uk> <43F1F5CB.10402@citi.umich.edu> <20060214160747.GA6350@diana.vm.bytemark.co.uk> <43F2445A.6020109@citi.umich.edu> <20060214222913.GK31278@pasky.or.cz> <43F2745D.4010800@vilain.net> <20060215003510.GA25715@spearce.org> <20060215041142.GA21048@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Petr Baudis <pasky@suse.cz>,
	Chuck Lever <cel@citi.umich.edu>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 07:54:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9GYh-0006Ha-Hg
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 07:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422904AbWBOGyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 01:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423003AbWBOGyX
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 01:54:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:65452 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1422904AbWBOGyW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 01:54:22 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1F9GYH-0002vx-1F; Wed, 15 Feb 2006 01:54:13 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id 212AD20FBA0; Wed, 15 Feb 2006 01:54:11 -0500 (EST)
To: "J. Bruce Fields" <bfields@fieldses.org>
Mail-Followup-To: "J. Bruce Fields" <bfields@fieldses.org>,
	Sam Vilain <sam@vilain.net>, Petr Baudis <pasky@suse.cz>,
	Chuck Lever <cel@citi.umich.edu>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060215041142.GA21048@fieldses.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16216>

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Tue, Feb 14, 2006 at 07:35:10PM -0500, Shawn Pearce wrote:
> > Publishing a repository with a stg (or pg) patch series isn't
> > a problem; the problem is that no clients currently know how to
> > follow along with the remote repository's patch series.  And I can't
> > think of a sensible behavior for doing so that isn't what git-core is
> > already doing today for non patch series type clients (as in don't go
> > backwards by popping but instead by pushing a negative delta).  :-)
> 
> If you represent each patch as a branch, with each modification to the
> patch a commit on the corresponding branch, and each "push" operation a
> merge from the branch corresponding to the previous patch to a branch
> corresponding to the new patch (isn't that what pg's trying to do?),
> then it should be possible just to track the branch corresponding to the
> top patch.

Yes that's pg in a nutshell.

But what happens when I pop back two patches (of three) and then push
down a different (fourth) patch?  The tree just rewound backwards
and then forwards again in a different direction.  (I apologize for
not being able to draw a nice ASCII art diagram of this, that's a
skill I'll have to learn to keep up with you guys.)  This is the
issue with Junio's pu branch in git.git and is why some people
apparently don't follow it.

StGIT and pg aren't the only ones who suffer from this wonderful
little feature of GIT.

> In theory I guess it should also be possible to merge patch series that
> have followed two lines of development, by merging each corresponding
> branch.

Of course.  If I delete all of the refs used by pg to mark the patch
boundaries its just another GIT branch.  Ditto for StGIT.  So clearly
you can merge them together just like any other GIT branch.

The open question is could you preserve the patch boundaries
while doing the merge.  Probably not.  It would become way to
complicated as you would want to merge the entire branch and not each
individual patch as the individual patch merges may not work but the
larger branch merge might go through without human intervention.
Of course you can try to keep the patch boundaries by exporting
all of the patches from the one branch and push them on top of
the current branch.  But isn't that what a 3 way merge is anyway?
And again that might not work as well as taking the larger patch
and pushing that down.  :-)

> The history would be really complicated.  You'd need to figure out how
> to track the patch comments too, and you'd need scripts to convert to
> just a simple series of commits for submitting upstream.  Probably not
> worth the trouble, but I don't know.

I think I'm almost there with pg.  One of my next tasks is the
patch log ripping code.  This is really only complicated because GIT
won't let me store the base of a 3 way merge as part of a commit;
all I can store is the set of parents.  If I had the base in the
commit (and specifically marked as such so I can tell it from the
end points) then I could easily walk through the log to extract all
commits relevant to a patch and seek forward and backward over it.

Perhaps I could cheat and record 3 parents: (HEAD, base, last).
I wonder what gitk would make of that mess.  I doubt it would display
any better than the current (HEAD, last) format I'm using now.

> If you really want revision control on patches the simplest thing might
> be just to run quilt or Andrew Morton's scripts on top of a git
> repository--the documentation with Andrew's scripts recommends doing
> that with CVS.

True but you also then run into problems about needing to know which
base each patch revision was applied against so you can reproduce
a source tree plus patch at a specific point in time.

When I started pg I first thought about recording a patch in a
secondary index/working directory where each patch was its own file
and use git-diff-tree to extract the patch, commit it as a blob in
the secondary index/directory, and push it onto the series by reading
the blob in and running git-apply on the patch stored within it.

I ruled this strategy out as it just felt like it would be too
slow and rather unnatural to work on with existing GIT tools.
I didn't want to write a full porcelain; I was really hoping to just
extend Cogito to get a patch stack that worked the way *I* wanted a
patch stack to work, which was close to StGIT but not quite StGIT.
(Of course it didn't work out this way when I picked a prefix of
'pg' instead of 'cg' for my new commands.)  :-|

-- 
Shawn.
