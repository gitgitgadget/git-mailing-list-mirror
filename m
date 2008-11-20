From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 12:59:08 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0811201223300.19665@iabervon.org>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com> <20081120112708.GC22787@ravenclaw.codelibre.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian MICHON <christian.michon@gmail.com>, git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:00:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3DpP-0000vf-6z
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 19:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbYKTR7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 12:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753949AbYKTR7K
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 12:59:10 -0500
Received: from iabervon.org ([66.92.72.58]:43871 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753756AbYKTR7K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 12:59:10 -0500
Received: (qmail 861 invoked by uid 1000); 20 Nov 2008 17:59:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Nov 2008 17:59:08 -0000
In-Reply-To: <20081120112708.GC22787@ravenclaw.codelibre.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101464>

On Thu, 20 Nov 2008, Roger Leigh wrote:

> On Wed, Nov 19, 2008 at 05:18:16PM +0100, Christian MICHON wrote:
> > On Wed, Nov 19, 2008 at 12:37 PM, Roger Leigh <rleigh@codelibre.net> wrote:
> > > Would it be possible for git to store the mtime of files in the tree?
> > >
> > > This would make it possible to do this type of work in git, since it's
> > > currently a bit random as to whether it works or not.  This only
> > > started when I upgraded to an amd64 architecture from powerpc32,
> > > I guess it's maybe using high-resolution timestamps.
> > >
> > 
> > beside the obvious answer it comes back often as a request, it is
> > possible in theory to create a shell script which, for each file
> > present in the sandbox in the current branch, would find the mtime of
> > the last commit on that file (quite an expensive operation) and apply
> > it.
> 
> Surely this is only expensive because you're not already storing the
> information in the tree; if it was there, it would be (relatively)
> cheap?  You could even compare the old and new trees to see if you
> needed to touch a file at all.
> 
> > You should store mostly content of source files. You should do a make
> > in your first cloned repo at least once before committing anything to
> > the repo. That's what I did and I saved days...
> 
> Except in this case I'm storing the content of *tarballs* (along with
> pristine-tar).  I'm committing exactly what's in the tarball with
> no changes (this is a requirement).  I can't change the source prior
> to commit.

Can you store the tarballs in the repository, instead of the contents of 
the tarballs? The tarballs will contain the dates you want, and you can 
obviously get tar to set the timestamps the way you want. (Then you add a 
higher-level Makefile that knows how to unpack the tarball to a directory, 
maintaining the timestamps, patch anything you're changing, and run make 
in that directory.)

That is to say, from your perspective, the sources include the upstream 
distributed tarballs, but the individual files in upstream tarballs aren't 
source files for you, since you can't (by policy) modify them (within the 
pristine tarball). If you want to change the sources of the packaged 
project, you add a patch file to do it, rather than simply changing the 
source (which, as you say, you're required not to do).

Git really wants to store the inputs to your workflow, each of which might
change independently. That's why the files in your work tree have 
timestamps based on when they came to be in your work tree (get set to the 
current time whenever git puts different content there, and leaves them 
unchanged if their contents don't change when moving from commit to 
commit). The "sources" in your workflow are a different set of files from 
the sources in the project, and git really wants *your* repository to 
match *your* workflow and not the workflow of the upstream project, when 
you're acting as a packager rather than an upstream developer.

	-Daniel
*This .sig left intentionally blank*
