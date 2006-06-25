From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-fetch - repack in the background after fetching
Date: Sat, 24 Jun 2006 20:53:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606242049500.3747@g5.osdl.org>
References: <11511486003924-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Jun 25 05:53:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuLgo-0003jE-2l
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 05:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWFYDxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 23:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWFYDxe
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 23:53:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55752 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751370AbWFYDxe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 23:53:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5P3rHnW019428
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 24 Jun 2006 20:53:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5P3rGSd014150;
	Sat, 24 Jun 2006 20:53:17 -0700
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <11511486003924-git-send-email-martin@catalyst.net.nz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22586>



On Sat, 24 Jun 2006, Martin Langhoff wrote:
>
> Check whether we have a large set of unpacked objects and repack
> after the fetch, but don't for the user to wait for us. Conditional
> on core.autorepack =! no.

I don't think this is safe.

It's also done stupidly.

Instead of askign how many unpacked objects we have with the (expensive) 
git-rev-list, why not just do

	ls "$GIT_DIR/objects/00" | wc -l

which is pretty much guaranteed to be faster and easier.

However, the more worrisome thing about background repacking is that while 
it should be safe against normal users, if you have two _repacks_ at the 
same time, they can decide to remove each others packs. Yeah, yeah, that's 
pretty damn unlikely, but hey, "pretty damn unlikely" is not "impossible".

Also, I think you'd want to repack with "-l", in case the thing is set up 
with an alternate object directory.

			Linus
