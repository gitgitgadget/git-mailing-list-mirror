From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: jgit merge question
Date: Wed, 14 Jan 2009 07:30:34 -0800
Message-ID: <20090114153034.GZ10179@spearce.org>
References: <S1760244AbZANHqN/20090114074613Z+1959@vger.kernel.org> <4EDE3D74-CEA3-473C-ADD1-03B79AAB9EDF@asu.edu> <alpine.DEB.1.00.0901141124460.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Birchfield <dbirchfield@asu.edu>
X-From: git-owner@vger.kernel.org Wed Jan 14 16:32:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN7iq-0003I7-9H
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 16:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758076AbZANPah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 10:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757876AbZANPag
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 10:30:36 -0500
Received: from george.spearce.org ([209.20.77.23]:38711 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188AbZANPaf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 10:30:35 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id BC55838210; Wed, 14 Jan 2009 15:30:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901141124460.3586@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105640>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 14 Jan 2009, David Birchfield wrote:
> 
> > I have been working with the JGit library and with the pgm files and 
> > other documentation I have been able to implement most of the basic 
> > functions that I need for my testing application - including fetch.  
> > This is great!

I'm glad JGit has been useful for you.

> > However, I have not been able to successfully implement 
> > the merge function with JGit. There is some reference to this in the 
> > mail archive, but I cannot find any of the merge code that is referenced 
> > in the distribution.

David is probably talking about the 8 patch series I proposed to add a
crude merge API to JGit.  The patches are available here, based on the
current JGit master:

  http://android.git.kernel.org/?p=tools/egit.git;a=shortlog;h=refs/heads/for-gerrit2
  git://android.git.kernel.org/tools/egit.git for-gerrit2

as I'm still highly dependent upon this in Gerrit2, but I haven't
been able to fix enough bugs and add enough unit tests to make
Robin happy with accepting them into the library.  I plan to get
back to that as soon as Gerrit2 is live for Android.

That API is a very, very crude merge API.  I don't like coding
with it from the application level.  It doesn't give Gerrit2
enough error information when it fails, and that means any other
application will also be unhappy with it.

It also has at least one bug, but at least its a conservative bug
(it won't merge subtrees sometimes and aborts even though they
should have merged clean).  Its also missing a huge block of code
about head simplification; that block is in Gerrit2 application
code rather than down in the library (that was a mistake in design).

So basically, yea, I've proposed something, but there are some very
good reasons why there isn't merge support yet in JGit.

> http://thread.gmane.org/gmane.comp.version-control.git/100524/focus=100589

Yea, we also need the diff implementation so we can do file-level
merges.  That merge API above only does path-level merges.  If a
file is modified on both sides, the merge API I use in Gerrit2
just aborts.  That typically isn't what a human who is trying to
use Git for development wants.
 
> Yes, it has not been implemented, basically because it needs a diff 
> implementation, and I constantly run out of time working on it.  I have 
> something that works, but needs lots of improvements to be usable 
> (basically, it has to avoid deep recursion depths).

What's a little stack space between friends?  ;-)

-- 
Shawn.
