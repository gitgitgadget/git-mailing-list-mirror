From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How-to combine several separate git repos?
Date: Sun, 9 Dec 2007 20:11:06 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712091942520.5349@iabervon.org>
References: <475B8C59.7050707@saville.com> <20071209104336.GA3163@steel.home>
 <475C3E25.30704@saville.com> <Pine.LNX.4.64.0712091445470.5349@iabervon.org>
 <475C7DD5.9040209@saville.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 02:11:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1XBD-0008LD-Ei
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 02:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbXLJBLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 20:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbXLJBLJ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 20:11:09 -0500
Received: from iabervon.org ([66.92.72.58]:55339 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbXLJBLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 20:11:08 -0500
Received: (qmail 10228 invoked by uid 1000); 10 Dec 2007 01:11:06 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Dec 2007 01:11:06 -0000
In-Reply-To: <475C7DD5.9040209@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67668>

On Sun, 9 Dec 2007, Wink Saville wrote:

> Daniel Barkalow wrote:
> > On Sun, 9 Dec 2007, Wink Saville wrote:
> >
> >   I think that submodules do what you want. And they may not be ready for
> > neophytes to just use, but they're ready for neophytes to try using and tell
> > us where things get confused.
> >   
> <snip>
> >  -Daniel
> I would like to try submodules and started to  read the man
> 
> 
> I'll try submodules and I'll start by reading the man page,
> I got to "add" and did the following:
> 
> wink@ic2d1:$ mkdir x
> wink@ic2d1:$ cd x
> wink@ic2d1:$ git init
> Initialized empty Git repository in .git/
> wink@ic2d1:$ git-submodule add ../android/StateMachine
> remote (origin) does not have a url in .git/config
> you must specify a repository to clone.
> Clone of '' into submodule path 'StateMachine' failed

It looks like git-submodule does something really wrong for URLs that 
start with ./ or ../. (By "wrong", I mean that it's different from the 
handling of the same URL anywhere else.) I think there's a general problem 
(beyond submodule support) that git doesn't do a good job with 
intermediate repositories: if you clone a repository, and then clone the 
clone, the second clone sees the local-to-the-first aspects and largely 
ignores the actual origin's properties.

On the other hand, you probably don't really want the canonical URL for 
the submodule to be a local relative path. If what you have are local 
clones of public repositories, you want to use the public remote 
repositories' URLs there. If you really want it to be a clone of the local 
repository, you can use an absolute path and weird things won't happen.

I think it should be possible to store the submodule data in the 'x' 
repository as well; have some branches which are the three different 
projects, and then pull them out of '.', but this doesn't seem to be 
working for me, either.

> The documentation for "submodule add" says:
> 
> /git-submodule/ [--quiet] [-b branch] add <repository> [<path>]
> Add the given repository as a submodule at the given path to the changeset to
> be committed next.
> 
> From the above, <path> is ambiguous to me, is it referring to the source or
> destination. I continue reading and in the options section we find:
> 
> <path>
> 
>    Path to submodule(s). When specified this will restrict the command
>    to only operate on the submodules found at the specified paths.
> 
> So it seems <path> is the for the source, but some how it can specify multiple
> paths.

This is actually the destination. The projects that are under discussion 
are only submodules in the context of the destination. For "git submodule 
add" it's the path in the superproject where the submodule will appear.

	-Daniel
*This .sig left intentionally blank*
