From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Core and Not-So Core
Date: Tue, 10 May 2005 18:18:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505101743520.30848-100000@iabervon.org>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 11 00:12:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVcwl-0005Fo-M2
	for gcvg-git@gmane.org; Wed, 11 May 2005 00:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVEJWSn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 18:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVEJWSn
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 18:18:43 -0400
Received: from iabervon.org ([66.92.72.58]:16903 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261839AbVEJWSa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 18:18:30 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DVd3J-0005p0-00; Tue, 10 May 2005 18:18:09 -0400
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc40320505100800426d38ca@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 11 May 2005, Jon Seymour wrote:

> I have been experimenting with pure-Java implementation of GIT
> concepts with a goal of eventually providing plugins to Eclipse to
> allow the Eclipse GUI to interact with GIT repositories.
> 
> One thing I noticed when doing this is that the present index/cache
> structure is rather arbitrary and the optimum index structure is
> determined by the structure of the tools that use a GIT repository
> rather than the structure of the GIT repository itself.

I'd guess that an Eclipse plugin wouldn't have a on-disk cache at all,
since it expects to keep the same address space through a whole day's
work.

> To give a concrete example: the cache currently contains most of the
> posix stat structure primarily to allow quick change detection. In the
> Java world, most of the posix stat structure is not directly
> accessible via the pure-Java file system abstractions. However, for
> most purposes detecting changes to files modification time and file
> size would be enough. Given this is the case, a Java-GIT client
> doesn't need to bother getting access to a posix stat structure and
> could therefore get away with a simpler  index structure, provided it
> doesn't need to interoperate with a 'C'-GIT client that shared the
> same workspace. A Java-GIT client might also choose to represent an
> index cache as a complex serialized Java object graph or (perhaps) an
> XML document.

The two clients should be able to interoperate trivially; the C version
would just treat the Java one as a text editor whose modifications happen
to match commits going into the same head; as soon as the C user does
either read-tree or update-cache, everything will be seen to be consistent
again.

> Currently the GIT stack is structured as follows:
> 
> cogito
> git-core 
> 
> I think it would be worthwhile if care was taken to draw a distinction
> between the repository and the cache aspects of the git core, perhaps
> even going to the extreme of moving all knowledge of the  cache into
> cogito itself. By clearly drawing this distinction, we will more
> easily enable the creation of different kind of tools sets atop the
> foundation of the GIT repository format.

I think this is nonsensical. The cache format is tied to the way in which
the repository accessing code is written, so a git-core separate from the
cache wouldn't have a useful set of code.

It might be worthwhile to produce a separate document describing the
repository format, such that it could be accessed by different code,
however. Of course, the index file wouldn't be part of this documentation,
for the same reason that the public git repositories don't include index
files.

	-Daniel
*This .sig left intentionally blank*

