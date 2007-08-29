From: Theodore Tso <tytso@mit.edu>
Subject: Re: repo.or.cz wishes?
Date: Wed, 29 Aug 2007 07:13:45 -0400
Message-ID: <20070829111345.GD29615@thunk.org>
References: <20070826235944.GM1219@pasky.or.cz> <Pine.LNX.4.64.0708270933450.28586@racer.site> <20070828041059.GK18160@spearce.org> <20070828111913.GA31120@thunk.org> <20070829041523.GS18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 13:14:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQLUh-0002Vj-O2
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 13:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930AbXH2LNv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 07:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbXH2LNv
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 07:13:51 -0400
Received: from thunk.org ([69.25.196.29]:52844 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112AbXH2LNu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 07:13:50 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IQLdU-0005M5-32; Wed, 29 Aug 2007 07:23:00 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IQLUX-0003By-6x; Wed, 29 Aug 2007 07:13:45 -0400
Content-Disposition: inline
In-Reply-To: <20070829041523.GS18160@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56936>

On Wed, Aug 29, 2007 at 12:15:23AM -0400, Shawn O. Pearce wrote:
> > This is morally the same, but it makes the hardlink step easier (only
> > one pack to link from A to B), and by using git-gc mit makes it
> > conceptually easier for people to understand what's going on.
> > 
> > git --git-dir=A gc
> > ln A/.git/objects/pack/* B/.git/objects/pack
> > git --git-dir=B gc --prune
> > git --git-dir=A prune
> 
> No, it won't work.
> 
> The problem is that during the first `git --git-dir=A gc` call
> you are deleting packfiles that may contain objects that B needs.
> *poof*.  

But "git-gc" without the --prune doesn't delete any objects.  So it
should always be safe to use git-gc even if there are repositories
that are relying on that repo's ODB.  It's only if you use git-gc
--prune that you could get in troudble.  It might delete some
packfiles containing objects needed by B, but only after consolidating
all of the objects into a single packfile that contains all of the
objects that had always been in A's ODB.

So I don't see why this wouldn't work.

						- Ted
