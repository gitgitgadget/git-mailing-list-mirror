From: Andreas Gal <gal@uci.edu>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 16:16:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231602010.28584@sam.ics.uci.edu>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>
 <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
 <200504231950.43903.FabianFranz@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 01:12:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPTnr-00036f-4I
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 01:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVDWXRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 19:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVDWXRc
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 19:17:32 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:48529 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S262168AbVDWXRW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 19:17:22 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3NNGn1e028650;
	Sat, 23 Apr 2005 16:16:49 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3NNGn1I028646;
	Sat, 23 Apr 2005 16:16:49 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Fabian Franz <FabianFranz@gmx.de>
In-Reply-To: <200504231950.43903.FabianFranz@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I would prefer a generic mechanism to sign _any_ object, not just tag 
objects:

- Introduce "signature objects" that contains an implementation-specific 
  signature. git doesn't care about the content, as long some script can 
  verify that the signature in the signature object matches the content of 
  the object(s) it references. The "name" of a signature object is the 
  SHA1 hash of the content (=gpg signature, for example).

- Referencing signatures in tags makes no sense IMO, because it would 
  require to change the (hash) name of tags when someone else wants to 
  co-sign it later on. I would just distribute two names for that (here is 
  tag xxxxx and its signature is yyyyy). Tags should only contain a
  symbolic name and the hash of the commit object they point to.

- A nice benefit of this is that we could sign unnamed commits (think 
  automatic signing of intermediate commit), or even sign individual
  files in the tree.

Just my 2c.

Andreas

On Sat, 23 Apr 2005, Fabian Franz wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Am Samstag, 23. April 2005 19:31 schrieb Linus Torvalds:
> > On Sun, 24 Apr 2005, David Woodhouse wrote:
> > > Nah, asking Linus to tag his releases is the most comfortable way.
> > >
> > The reason I've not done tags yet is that I haven't decided how to do
> > them.
> >
> > 	commit a2755a80f40e5794ddc20e00f781af9d6320fafb
> > 	tag v2.6.12-rc3
> > 	signer Linus Torvalds
> >
> > 	This is my official original 2.6.12-rc2 release
> >
> > 	-----BEGIN PGP SIGNATURE-----
> > 	....
> > 	-----END PGP SIGNATURE-----
> >
> > If somebody writes a script to generate the above kind of thing (and tells
> > me how to validate it), I'll do the rest, and start tagging things
> > properly. Oh, and make sure the above sounds sane (ie if somebody has a
> > better idea for how to more easily identify how to find the public key to
> > check against, please speak up).
> 
> To generate those you do:
> 
> # cat unsigned_tag
> 
> 	commit a2755a80f40e5794ddc20e00f781af9d6320fafb
> 	tag v2.6.12-rc3
> 	signer Linus Torvalds
> 	This is my official original 2.6.12-rc2 release
> 
> # gpg --clearsign < unsigned_tag > signed_tag # gpg will ask here for the 
> secret key phrase
> 
> To verify you do:
> 
> # gpg --verify < signed_tag
> 
> and check exit status.
> 
> Hope that helps,
> 
> cu
> 
> Fabian 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
> iD8DBQFCaorzI0lSH7CXz7MRAr3QAJ45f2CQTgJ0sYfF9kRyrWHbsazVQQCeMqW7
> HCsah/llt/I8sQ36dlDnRWg=
> =Fgq1
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
