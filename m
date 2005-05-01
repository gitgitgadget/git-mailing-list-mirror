From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Complete http-pull; where should it go?
Date: Sun, 1 May 2005 12:44:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505011237410.2296@ppc970.osdl.org>
References: <Pine.LNX.4.21.0505011508270.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 01 21:37:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSKFE-0001UN-QR
	for gcvg-git@gmane.org; Sun, 01 May 2005 21:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVEATmg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 15:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVEATmg
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 15:42:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:38832 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262655AbVEATme (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 15:42:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j41JgTs4024529
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 May 2005 12:42:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j41JgSP3027693;
	Sun, 1 May 2005 12:42:28 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505011508270.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 1 May 2005, Daniel Barkalow wrote:
>
> My question is, where does this belong? It's based on adding to the core
> as it has been the knowledge that .git/refs/*/* consists of hex-format
> hash files, both locally and on remote servers.

So the main reason I _don't_ like programs that automatically look up the 
refs etc is that its' often simply WRONG.

For example, if I want to know what objects I have in my object directory 
that are needed for a release, I want to be able to tell fsck to list the 
objects that are extraneous for that release _regardless_ of the fact that 
I may have .git/refs/*/* files that point to other things.

So if fsck-cache automatically looks up references in .git/refs/ like in
one of your earlier patches, then instead of adding value to the program,
you actually _remove_ value from it by making it less flexible, and
enforcing a world-view that is not necessarily the only view.

This is why I want the true _plumbing_ to not care about these things, and 
if you include references to trees, you _list_ them explicitly. 

And if you want to have a command that takes implied references, then just 
make a script that does that for you, rather than making the core plumbing 
understand it.

This is a classic "ease of use" vs "power-user" issue. I'm very
fundamentally of the opinion that power-users are good, and that ease of
use is done by having scripts that turn normal ops into "power user"  
operations.

That's the unix way, really.

		Linus
