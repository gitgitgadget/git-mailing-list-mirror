From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Wed, 15 Feb 2006 14:45:35 -0500
Message-ID: <20060215194535.GA22007@fieldses.org>
References: <tnxoe1aqoj2.fsf@arm.com> <20060214100844.GA1234@diana.vm.bytemark.co.uk> <43F1F5CB.10402@citi.umich.edu> <20060214160747.GA6350@diana.vm.bytemark.co.uk> <43F2445A.6020109@citi.umich.edu> <20060214222913.GK31278@pasky.or.cz> <43F2745D.4010800@vilain.net> <20060215003510.GA25715@spearce.org> <20060215041142.GA21048@fieldses.org> <20060215065411.GB26632@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 15 20:46:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Sb4-0002i6-Ec
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 20:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWBOTpw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 14:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWBOTpv
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 14:45:51 -0500
Received: from mail.fieldses.org ([66.93.2.214]:8928 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S1750960AbWBOTpv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2006 14:45:51 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F9Sal-00067g-Fq; Wed, 15 Feb 2006 14:45:35 -0500
To: Sam Vilain <sam@vilain.net>, Petr Baudis <pasky@suse.cz>,
	Chuck Lever <cel@citi.umich.edu>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060215065411.GB26632@spearce.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16253>

On Wed, Feb 15, 2006 at 01:54:11AM -0500, Shawn Pearce wrote:
> "J. Bruce Fields" <bfields@fieldses.org> wrote:
> > On Tue, Feb 14, 2006 at 07:35:10PM -0500, Shawn Pearce wrote:
> > > Publishing a repository with a stg (or pg) patch series isn't
> > > a problem; the problem is that no clients currently know how to
> > > follow along with the remote repository's patch series.  And I can't
> > > think of a sensible behavior for doing so that isn't what git-core is
> > > already doing today for non patch series type clients (as in don't go
> > > backwards by popping but instead by pushing a negative delta).  :-)
> > 
> > If you represent each patch as a branch, with each modification to the
> > patch a commit on the corresponding branch, and each "push" operation a
> > merge from the branch corresponding to the previous patch to a branch
> > corresponding to the new patch (isn't that what pg's trying to do?),
> > then it should be possible just to track the branch corresponding to the
> > top patch.
> 
> Yes that's pg in a nutshell.
> 
> But what happens when I pop back two patches (of three) and then push
> down a different (fourth) patch?  The tree just rewound backwards
> and then forwards again in a different direction.

So you've got p1, p2, and p3 applied, each with its corresponding
branch--respectively, b1, b2, and b3.  Popping two patches just checks
out b1, and doesn't affect the repository at all.  If you push a new
patch, p4, you've just created a new branch, b4--you haven't touched the
existing branches.  If you push p2 and p3 back on, you're just merging
the new changes from b4 into b2 and then merging the newly merged b2
into b3.

>From the point of view of someone tracking b3, this is all fine.  OK,
maybe it's excessively complicated, but pulls should work, because it
never sees history diseappear as it does when you represent each patch
with a commit on a single branch.

> > If you really want revision control on patches the simplest thing might
> > be just to run quilt or Andrew Morton's scripts on top of a git
> > repository--the documentation with Andrew's scripts recommends doing
> > that with CVS.
> 
> True but you also then run into problems about needing to know which
> base each patch revision was applied against so you can reproduce
> a source tree plus patch at a specific point in time.

Right, so you keep the tree under revision control as well as the
patches.

--b.
