From: Theodore Tso <tytso@mit.edu>
Subject: Re: Some ideas for StGIT
Date: Sat, 4 Aug 2007 02:38:58 -0400
Message-ID: <20070804063858.GA13758@thunk.org>
References: <1186163410.26110.55.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 08:39:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHDI4-0008IJ-1D
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 08:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916AbXHDGjF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 02:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754845AbXHDGjE
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 02:39:04 -0400
Received: from thunk.org ([69.25.196.29]:35984 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754631AbXHDGjD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 02:39:03 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IHDQO-0000Mr-6i; Sat, 04 Aug 2007 02:47:44 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IHDHu-0008AD-Bz; Sat, 04 Aug 2007 02:38:58 -0400
Content-Disposition: inline
In-Reply-To: <1186163410.26110.55.camel@dv>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54801>

On Fri, Aug 03, 2007 at 01:50:10PM -0400, Pavel Roskin wrote:
> Hello!
> 
> I was recently disappointed to learn that one of the Linux drivers
> (bcm43xx_mac80211, to be precise) switched from git to quilt.  I asked
> whether StGIT was considered, a discussion followed, and I think the key
> points need to be shared with StGIT developers.  I'll add some of my
> ideas to the mix.

You might also ask them if they considered "guilt", which uses
text-based patches.  It's a lot easier to use, and if they really want
quilt-like functionality, "guilt" will provide it.

My main reason for avoiding StGIT is the fact that at least in the
past, I've found it very fragile when I forget and use "git checkout"
instead of "stg branch" to switch between branches.  The fact that
sometimes you have to use the StGit variant of basic git commands has
always struck me as confusing, and then recovering when things get
screwed can be exciting.  Usually it's when I start having to cut and
paste SHA1 hashes and running diffs to recreate my patch series after
things get screwed is usually about the time when I wonder why I tried
using StGIT again.  (Don't get me wrong; I'm sure I did something
really stupid, and wrong, that caused things to get screwed up.  My
complaint is that when I do something stupid, StGIT isn't robust and
is painful to recover from.)

That's why I like guilt; it doesn't require that you use alternate stg
commands for manipulating branches, and since it maintains an external
set of text patches, recovering is much easier; worst case I can just
do a "git reset --hard" and then follow it up with a guilt push -a.
And because it's so stupid simple, it's much rarer that something goes
seriously wrong that requires me to use a recovery procedure in the
first place.

Editing patch headers are also a lot easier with guilt; you can just
go ahead and edit them all, and then you can fresh them in git by
doing a "guilt pop -a; guilt push -a".  Since it's not using a
git-based storage, it doesn't have to rewrite the whole patch stack
when you modify a single patch header; you can edit a whole bunch of
text headers and then refresh the git commit series just once.

Of course, that's just my preference; others may find StGIT more
convenient, or folks may find the new rebase -i to be better yet.
YMMV.

     	  		    	 	- Ted
