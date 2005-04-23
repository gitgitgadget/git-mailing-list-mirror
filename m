From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 10:45:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231033500.2344@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>  <42674724.90005@ppp0.net>
 <20050422002922.GB6829@kroah.com>  <426A4669.7080500@ppp0.net> 
 <1114266083.3419.40.camel@localhost.localdomain>  <426A5BFC.1020507@ppp0.net>
 <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 19:40:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPObQ-0006wQ-40
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 19:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVDWRoP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 13:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVDWRoP
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 13:44:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:18315 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261632AbVDWRoF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 13:44:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3NHhus4023450
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 10:43:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3NHhtm1009837;
	Sat, 23 Apr 2005 10:43:56 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, Linus Torvalds wrote:
> 
> 	commit a2755a80f40e5794ddc20e00f781af9d6320fafb
> 	tag v2.6.12-rc3
> 	signer Linus Torvalds
> 
> 	This is my official original 2.6.12-rc2 release
> 
> 	-----BEGIN PGP SIGNATURE-----
> 	....
> 	-----END PGP SIGNATURE-----

Btw, in case it wasn't clear, one of the advantages of this is that these
objects are really _not_ versioned themselves, and that they are totally 
independent of the objects that they actually tag.

They spread together with all the other objects, so they fit very well
into the whole git infrastructure, but the real commit objects don't have
any linkages to the tag and the tag objects themselves don't have any
history amongst themselves, so you can create a tag at any (later) time,
and it doesn't actually change the commit in any way or affect other tags 
in any way.

In particular, many different people can tag the same commit, and they
don't even need to tage their _own_ commit - you can use this tag objects
to show that you trust somebody elses commit. You can also throw the tag
objects away, since nothing else depends on them and they have nothing
linking to them - so you can make a "one-time" tag object that you can
pass off to somebody else, and then delete it, and now it's just a
"temporary tag"  that tells the recipient _something_ about the commit you
tagged, but that doesn't stay around in the archive.

That's important, because I actually want to have the ability for people 
who want me to pull from their archive to send me a message that says 
"pull from this archive, and btw, here's the tag that not only tells you 
which head to merge, but also proves that it was me who created it".

Will we use this? Maybe not. Quite frankly, I think human trust is much 
more important than automated trust through some technical means, but I 
think it's good to have the _support_ for this kind of trust mechanism 
built into the system. And I think it's a good way for distributors etc to 
say: "this is the source code we used to build the kernel that we 
released, and we tagged it 'v2.6.11-mm6-crazy-fixes-3.96'".

And if my key gets stolen, I can re-generate all the tags (from my archive
of tags that I trust), and sign them with a new key, and revoke the trust
of my old key. This is why it's important that tags don't have
interdependencies, they are just a one-way "this key trusts that release
and calls it xyzzy".

		Linus
