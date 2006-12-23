From: Nicolas Pitre <nico@cam.org>
Subject: Re: Separating "add path to index" from "update content in index"
Date: Sat, 23 Dec 2006 00:27:16 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612221709380.18171@xanadu.home>
References: <89b129c60612191233s5a7f36f2hd409c4b9a2bbbc5c@mail.gmail.com>
 <7v64c7pmlw.fsf@assigned-by-dhcp.cox.net> <87wt4m2o99.wl%cworth@cworth.org>
 <7vmz5i6vqb.fsf@assigned-by-dhcp.cox.net> <87vek62n1k.wl%cworth@cworth.org>
 <7v1wmu5ecs.fsf@assigned-by-dhcp.cox.net> <87tzzp3fgh.wl%cworth@cworth.org>
 <slrneokplo.nsf.Peter.B.Baumann@xp.machine.xx>
 <7vbqlw92fw.fsf@assigned-by-dhcp.cox.net> <87d56cirs8.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0612212337180.18171@xanadu.home>
 <878xgziog0.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 06:27:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxzPl-0004ah-ID
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 06:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbWLWF1S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 00:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbWLWF1S
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 00:27:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55385 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbWLWF1R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 00:27:17 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAP00GZWOHGK2W0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 23 Dec 2006 00:27:17 -0500 (EST)
In-reply-to: <878xgziog0.wl%cworth@cworth.org>
X-X-Sender: nico@xanadu.home
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35268>

On Fri, 22 Dec 2006, Carl Worth wrote:

> On Fri, 22 Dec 2006 00:06:32 -0500 (EST), Nicolas Pitre wrote:
> > On Thu, 21 Dec 2006, Carl Worth wrote:
> >
> > > So, I think what I really want here is a complete separation in the
> > > interface between adding a path to the index and updating content into
> > > the index.
> >
> > Strangely enough I think this separation is unnecessary and redundent.
> 
> One argument I would make in favor of the separation is that the two
> operations are conceptually distinct from the user point-of-view. But
> that's really hard to nail down since all users have different points
> of view and different conceptual models,

... and if we want to break the CVS model and give people a better 
chance of ever grasping the git index concept I think they should not be 
different.

> (though I think the recent
> post about similar file names and accidentally adding a file meant to
> be untracked is evidence in favor of this argument).

This could be used as evidence for anything.  "Oh I wanted to delete 
this file but that file had a similar name and I deleted the wrong 
one."

> There's a much less fuzzy, and strictly technical argument that can be
> made. Right now, we document "git add" as being useful for two
> purposes, ("adding new files" and adding "modified files...to the set
> of changes").
[...]
> The technical argument for separating the notions of "add path" and
> "update content" comes from looking at how to specify path names to
> these operations, (and recursive names in particular).

Sometimes pure _technical_ arguments don't make good _user_ interfaces. 
The "git add" changes are about _usability_, not _technicality_. It is 
much easier to learn about one concept which is "you add stuff to your 
commit" with no other distinction to make.

> Yes, update-index still exists. But we're relegating that to
> plumbing.

But plumbing is there for you to use with your own enhancements when 
they are sophisticated enough like your workflow description seem to 
imply.

> > The problem lies with the git-diff interface then, not git-add.
> 
> I don't think so. I'm quite convinced that the fact that "git diff"
> shows the difference from the index to the working tree is correct and
> can't really be changed.

I'm not proposing to change existing output either.

> > There is no consistency needed between git-add and git-update-index.
> > The first is for users while the second is more suited for scripting
> > your own interface.
> 
> But it's not actually update-index that I want. I agree that it's a
> plumbing thing that users shouldn't use. What I want is two different
> pieces of porcelain here, each focusing one one simple task. One to
> add the path to the index, and one to update content in the index for
> a path that exists.
> 
> Much better would be for "git add" and "git refresh" to each just
> stick to a single task and to do it well, (git has UNIX philosophy,
> right?). So "git add" should just add paths to the index, "git
> refresh" should just update content for existing paths in the index,
> and we don't need a lot of options for either command for users to
> have to wade through.

I'm still unconvinced this is useful distinction to make in the majority 
of all cases for the majority of people.

> With those simple commands, we could have nice, separate behavior for:
> 
> 	git add some-dir
> and:
> 	git refresh some-dir
> 
> and if someone wants the existing "add path and update content"
> behavior of git add then it should be a simple matter of aliasing to
> the combination of "git add" followed by "git refresh".

I think that if you want that behavior it might be a better idea for you 
to alias those behaviors with a combination of git-ls-files and 
git-update-index.

> > But the best solution is really for git-diff to have a mode where you
> > could display a diff between the work tree and the index, _or_ the index
> > and HEAD, for each file listed in the index while giving priority to the
> > former.
> 
> I don't understand what you are proposing here. What would this mode
> display? How would it decide?

This is something that you might not need after all.  but for people 
using git-commit -a they might benefit from a git-diff -a that would 
output the equivalent of what will be committed, including newly added 
files (already in the index) and modified files (not yet in the index).  
It is easy to do: for each index entry, generate a diff against the 
corresponding file in the work tree, but if there is no difference then 
generate the diff against HEAD.  Modified files will be in the first 
case while added files will be in the second case.


Nicolas
