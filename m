From: Sal Mangano <smangano@into-technology.com>
Subject: Re: Supressing sorting of trees
Date: Mon, 12 Oct 2009 16:51:59 +0000 (UTC)
Message-ID: <loom.20091012T182258-9@post.gmane.org>
References: <loom.20091012T152113-874@post.gmane.org> <20091012142032.GG9261@spearce.org> <loom.20091012T171550-239@post.gmane.org> <alpine.DEB.1.00.0910121803360.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 18:54:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxOAE-0008P4-Mf
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 18:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbZJLQyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 12:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbZJLQyC
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 12:54:02 -0400
Received: from lo.gmane.org ([80.91.229.12]:42767 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932460AbZJLQyA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 12:54:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MxO8b-0007Wh-Kf
	for git@vger.kernel.org; Mon, 12 Oct 2009 18:52:45 +0200
Received: from ool-18bd213f.dyn.optonline.net ([24.189.33.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 18:52:45 +0200
Received: from smangano by ool-18bd213f.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 18:52:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.189.33.63 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.25 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130032>

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:

> 
> Hi,
> 
> On Mon, 12 Oct 2009, Sal Mangano wrote:
> 
> > Shawn O. Pearce <spearce <at> spearce.org> writes:
> > 
> > > 
> > > Sal Mangano <smangano <at> into-technology.com> wrote:
> > > > I am using Git in a non-standard way and need to make a few twaeks 
> > > > in my custom build. I have added a --nosort option to git mktree 
> > > > which will suppress the qsort of the tree.
> > > > 
> > > > Will this break any other git functions? Are there any commands that 
> > > > assume trees are always sorted?
> > > 
> > > _YES IT BREAKS GIT_.
> > > 
> > > You cannot do this.
> > > 
> > > A Git repository whose trees are not sorted according to the Git 
> > > specific sort ordering is severly broken and most tools will fail 
> > > horribly on it.
> > > 
> > > Almost all code which reads trees assumes the names are sorted in a 
> > > specific order.  These tools perform sorted merges against other tree 
> > > like structures.  If the names are out of order the merge will fail. 
> > > `git fsck` will complain that the tree is not sorted properly. Tools 
> > > like `git log -- foo.c` will fail randomly because they break out of 
> > > the entry lookup as soon as they find a name that is after foo.c, as 
> > > they assume the tree is sorted.
> > > 
> > > I could go on.  But there is no point.
> > > 
> > > Oh, and trust me when I say this, the tree sorting matters.  Long ago 
> > > JGit had a bug where it didn't sort trees correctly all of the time 
> > > and we had a devil of a time tracking down that corruption.
> > > 
> > 
> > Thanks Shawn. I get the picture. 
> > 
> > Now, let's assume I am stubborn, crazy or both 
> > 
> > I can modify fsck to ignore unsorted and at the moment I don't care 
> > about merging trees. If I hunt down all usage of base_name_compare will 
> > that identify all code with the sort assumption or is there other places 
> > as well? I can go > through the entire source to figure this out myself 
> > but I need to get something hacked up very quickly and would appreciate 
> > help even if you think I am nuts!
> 
> Look, one of the most trusted Git contributors just told you that you are 
> asking for trouble.
> 
> It has nothing to do with being stubborn if you insist on doing it now.
> 
> But I smell an XY problem.  Why don't you just reveil _what_ you want to 
> do (as opposed to _how_ you think you should do it)?
> 
> Ciao,
> Dscho
> 
> 

My apologies for being cryptic.

I am working on a project where I need to create a repository consisting of 
hierarchical "blobs" of content (sound familiar?). In this repository the 
order of the blobs as specified by the end user is definitely important. 
However, I have a bunch of other reqs that fit Git perfectly such as the 
ability to quickly tell if two trees are the same using their SHA1 and the 
ability to version control the repository. My repository has no relationship 
to files stored on a file system unlike a typical use of Git. I also don't 
care about whether my repository remains compatible with standard Git because 
no one will access this repository using standard Git.

Now I can proceed in a few ways:

1) I can write by repository from scratch.
2) I can use Git unchanged but preserve order by storing some information in 
each sub tree (e.g. an extra blob) which retains the real order. I can also
store this information once for the whole "chunks" of the repository. 
3) I can change Git to suite my needs understanding that it is not Git 
anymore.

For me, (1) makes no sense at this time. I started with the hope that (2) 
would work but realized it is very awkward and will cause performance problems
because it means most updates where ordering matters will have to update the 
Git trees and my private ordering blob(s). So, after a quick look at the 
source code it seemed like hacking Git into what I wanted was easier than 1 
or 2. 

I realized tree merge would probably break and wanted to know what 
else. It is good to know fsck breaks. What else will break that I have to 
deal with?
