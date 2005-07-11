From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/2] Support for packs in HTTP
Date: Sun, 10 Jul 2005 20:20:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507101959410.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0507101637390.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 02:30:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrmAx-0006Aj-5B
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 02:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVGKA0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 20:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVGKAYH
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 20:24:07 -0400
Received: from iabervon.org ([66.92.72.58]:33540 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262173AbVGKAWd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 20:22:33 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Drm27-00036k-00; Sun, 10 Jul 2005 20:20:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507101637390.17536@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 10 Jul 2005, Linus Torvalds wrote:

> On Sun, 10 Jul 2005, Junio C Hamano wrote:
> >
> > So I would suggest either:
> > 
> >   - droping the packname parameter from git-pack-objects.  Make
> >     the packs always named pack-X{40}.pack (or just X{40}.pack);
> 
> Well, regardless, we want to be able to specify which directory to write 
> them to. We don't necessarily want to write them to the current working 
> directory, nor do we want to write them to their eventual destination in 
> .git/objects/pack.
> 
> In fact, the main current user ("git repack") really wants to write them 
> to a temporary file, and one that isn't even called "pack-xxx", since it 
> ends up doing cleanup with 
> 
> 	rm -f .tmp-pack-*
> 
> in case a previous re-pack was interrupted (in which case it simply cannor
> know what the exact name was supposed to be).
> 
> So the "basename" ends up being necessary and meaningful regardless. We do 
> _not_ want to remove that capability.

Shouldn't we do the same thing we do with object files? I don't see any
difference in desired behavior.

> >     also have verify-pack to verify the name of the packfile,
> >     and make sure X{40} part of the name matches what it claims
> >     to contain;
> 
> Now, that would be fine, but it can't be done. Not the way things are laid 
> out. A SHA1 checksum depends on the order the data was checksummed in, and 
> we don't even save that.

Why not checksum it in a predictable order, either that of the pack file
or the index? We do care that it's something verifiable, so that people
can't cause intentional collisions (for a DoS) just by naming their packs
after existing packs that users might not have downloaded yet.

	-Daniel
*This .sig left intentionally blank*
