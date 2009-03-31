From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC GSoC 2009: git-submodule for multiple, active developers
 on  active trees]
Date: Wed, 1 Apr 2009 01:05:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904010058490.6616@intel-tinevez-2-302>
References: <526944450903251314o622711b5u3665bac90398d6be@mail.gmail.com>  <20090330153245.GD23521@spearce.org>  <526944450903310830q5f56fe82xb64ae8dc3c954ffb@mail.gmail.com>  <alpine.DEB.1.00.0903311749160.7052@intel-tinevez-2-302>
 <526944450903311532u24eb74fby1f558c1bef5c653a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: P Baker <me@retrodict.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 01:06:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lon2d-00034N-T2
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 01:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760449AbZCaXFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 19:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758882AbZCaXFN
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 19:05:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:49710 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758154AbZCaXFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 19:05:12 -0400
Received: (qmail invoked by alias); 31 Mar 2009 23:05:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp068) with SMTP; 01 Apr 2009 01:05:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4FGlM0+C4dBbcHpZ1r6yHa9msMH6enYWYo8EJki
	x2W6nZZS+iXBbu
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <526944450903311532u24eb74fby1f558c1bef5c653a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115327>

Hi,

On Tue, 31 Mar 2009, P Baker wrote:

> On Tue, Mar 31, 2009 at 11:57 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> >> *move objects of submodules into base .git/ directory
> >> **This would, as I understand it: protect submodules from being
> >> overwritten and changes lost when switching between branches of the
> >> superproject that might or might not contain the submodules and
> >> centralize their management into one location.  The added benefits of
> >> fully using git's ability to branch and merge submodules makes it
> >> worth adding some complexity within the .git directory.
> >
> > The main problem with renaming/deleting is not the repository of the
> > submodule, but the working directoy.
> >
> 
> My understanding is that since the submodule objects (history) is
> stored in a .git directory in the subdirectory where the submodule is
> located, removing that subdirectory during checkout of a branch that
> does not include that submodule eliminates the .git directory as well.
> Moving the objects from the submodule's .git directory to the base
> .git directory would seem to alleviate this problem.

My point was more about "you cannot just remove the subdirectory, or you 
_will_ lose data".

> >> *use .git instead of .gitmodules
> >> **I actually don't know why this was included with the project
> >> description, I searched for an explanation of the desired name change
> >> on the mailing list and in commit messages, but came up with nothing.
> >
> > AFAICT somebody thought that the information about the locations of the
> > submodules should be in .git/ rather than in the working directory.  But
> > of course, that is wrong: you want it to be tracked.
> 
> So, in looking back through the archives of the mailing list there
> seems to be some disagreement between using .gitmodules and
> .git/config to track submodules.

No.  .gitmodules has the default information, and "git submodule init" 
brings that into .git/config, to be overridden by the user if she so 
likes.

> >> *git submodule update --init should initialize nested levels of submodules
> >> **As an ease of use command, either an additional flag to recurse can
> >> be added, or it can act by default. As a requested feature on the
> >> mailing list, this is worth implementing.
> >
> > I thought there was a patch to support "git submodule recurse"?  That
> > would be rather less limited than yet another option to submodule update.
> 
> There is a git submodule foreach command, but it doesn't look like the
> patch for git submodule recurse
> (http://marc.info/?l=git&m=120997867213008&w=2) has been incorporated
> into a public release.
> 
> That is one route, on the other hand, the default action is also open
> to question. When I update a submodule, I would probably expect that
> anything it depends on is also updated. The default action probably
> should be recursive.

No.  Not at all.  At least in my usage, submodules are mostly optional.  
IOW I have ways in my projects to cope with the absence of a checkout.

> >> *ability to update submodule pulled from svn repo
> >> **One workaround is to clone it as local copy using git-svn and then
> >> import that local clone as a submodule; clearly a clunky solution.
> >> There are many requests for this feature (see
> >> http://panthersoftware.com/articles/view/4/git-svn-dcommit-workaround-for-git-submodules
> >> for a typical example), and it makes sense integrating git-submodule
> >> with git-svn would expand submodule's usefulness.
> >
> > I do not think that this would be good.  Both "git svn" and "git
> > submodule" are rather complex by now, and mixing them would only
> > complicate code.
> 
> Hm, point well taken, but it would seem to have enormous benefit for a
> lot of people. I can move it down the priority list, but I'd like to
> include it in the proposal - complexity alone isn't a good reason to
> avoid something.

Complexity is often a good sign of bad design.

In this case, I want to point out that there has been a better design 
already:

http://thread.gmane.org/gmane.comp.version-control.git/114545

(Unfortunately, Daniel decided to post the follow-up patches in different 
threads; that will make it hard for you to find them.)

Ciao,
Dscho
