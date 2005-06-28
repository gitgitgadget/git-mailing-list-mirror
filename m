From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 01:09:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506280049090.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506271910390.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 07:05:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn8H0-0002rl-KR
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 07:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVF1FLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 01:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVF1FLY
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 01:11:24 -0400
Received: from iabervon.org ([66.92.72.58]:34821 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261746AbVF1FLE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 01:11:04 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Dn8LT-0001H3-00; Tue, 28 Jun 2005 01:09:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506271910390.19755@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 27 Jun 2005, Linus Torvalds wrote:

> > > [..  git-ssh-pull hopefully working ..]
> >
> > No.  The pull protocol Dan did expects to throw compressed
> > representation around on the wire (which is valid if you assume
> > uncompressed transfer) and does not use read-sha1-file --
> > write-sha1-file pair, so all three do not work.
> 
> Fair enough. I'd prefer for the pull/push to push object packs around 
> anyway, so there's some more work there..

It shouldn't be hard to add; the main issue is determining when
transfering a pack file is a good idea, because it probably doesn't make
sense to transfer a pack file just because the source side has an object
that the target side wants in that pack. (If you pull from someone who
packed up the whole history of everything, which you already have, into a
file with one new commit, you'd be sad to get the huge thing; you really
want a little custom (or just limited) pack file.)

The ideal thing is probably to pick up some tricks from Mercurial in
figuring out what needs to be transferred, and have the source side write
a pack file directly to the connection, which the target side would then
save directly. I never worked out exactly what those tricks were, though.

The next trick would be to put something in place of cleverly-chosen
objects to specify what pack file they're in, so that the HTTP client
could find things from a packed repository. (Or we could just have an
option to unpack post-transfer.)

	-Daniel
*This .sig left intentionally blank*
