From: Andreas Gal <gal@uci.edu>
Subject: Re: Git-commits mailing list feed.
Date: Sun, 24 Apr 2005 19:39:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504241930480.1394@sam.ics.uci.edu>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <426C4168.6030008@dwheeler.com>
 <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org> <200504250417.17231.FabianFranz@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	"David A. Wheeler" <dwheeler@dwheeler.com>,
	Paul Jakma <paul@clubi.ie>, Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 04:35:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPtRg-0001J1-72
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 04:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVDYCk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 22:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVDYCk2
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 22:40:28 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:19883 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S262465AbVDYCkS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 22:40:18 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3P2dkwf001480;
	Sun, 24 Apr 2005 19:39:46 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3P2djiL001476;
	Sun, 24 Apr 2005 19:39:46 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Fabian Franz <FabianFranz@gmx.de>
In-Reply-To: <200504250417.17231.FabianFranz@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


It may sound a little weird, but we could actually store the signature in 
the inode/filename. GPG signatures seem to be around 80 bytes of ASC, 
thats well below MAXPATH and should work even if your repository is 
somewhere/deep/in/your/filesystem/hierarchy. 

1. Signed objects are named sha1-sig (sig is a 80 character signature 
here, not the three letters sig).

2. To make sure we can find objects without their signature, there is 
   always a soft link sha1 -> sha1-sig (fsck can check this and create 
   missing links).

3. To find a signature, just follow the link and look at the real name.

4. Files can be distributed without signature (content is unchanged) and
   you can sign them in your local tree with your own signature, 
   effectively throwing my signature away.

The only limitation is that each object can only be signed by one person. 
On the other hand, this might not be a limitation at all. If I create a 
file, I sign it. Nobody else. Same goes for trees and commits that I 
create. You can sign your own commit object when you merge my stuff, and 
then push that commit object out (along with your co-signature).

Andreas

On Mon, 25 Apr 2005, Fabian Franz wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Am Montag, 25. April 2005 03:50 schrieb Linus Torvalds:
> 
> > Maybe we'll just have signed tags by doing exactly that: just a collection
> > of detached signature files. The question becomes one of how to name such
> > things in a distributed tree. That is the thing that using an object for
> > them would have solved very naturally.
> 
> What about just <sha1 hash of object>.sig or <sha1 hash of object>.asc?
> 
> Or would this violate the concept of the object database to just contain 
> hashes?
> 
> cu
> 
> Fabian
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
> iD8DBQFCbFMsI0lSH7CXz7MRAof0AKCILjPE/M72cMSVNDC/DWYSzmrU/ACggOuS
> ogNPwUf2ASAwmbwixzSTuPs=
> =pW5D
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
