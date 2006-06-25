From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-fetch - repack in the background after fetching
Date: Sun, 25 Jun 2006 10:29:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606251025100.3747@g5.osdl.org>
References: <11511486003924-git-send-email-martin@catalyst.net.nz>
 <Pine.LNX.4.64.0606242049500.3747@g5.osdl.org>
 <Pine.LNX.4.63.0606251122260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Jun 25 19:30:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuYR1-0005iI-Oc
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 19:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWFYRaI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 13:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWFYRaH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 13:30:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48005 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751337AbWFYRaG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 13:30:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5PHTpnW006687
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 25 Jun 2006 10:29:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5PHTnMZ003626;
	Sun, 25 Jun 2006 10:29:50 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606251122260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22640>



On Sun, 25 Jun 2006, Johannes Schindelin wrote:
> 
> On Sat, 24 Jun 2006, Linus Torvalds wrote:
> 
> > However, the more worrisome thing about background repacking is that while 
> > it should be safe against normal users, if you have two _repacks_ at the 
> > same time, they can decide to remove each others packs. Yeah, yeah, that's 
> > pretty damn unlikely, but hey, "pretty damn unlikely" is not "impossible".
> 
> Why not introduce a lock file for repack?

You can do that. The problem is, lock-files are really hard to do 
right, and portably. Especially from scripts.

But _I_ think the basic issue is that it's wrong to even try to do this 
background repack.

Git does explicit repacking. That's just how it is. If the worry is that 
people forget to pack often enough, why not just have the "git pull" 
script _tell_ the user, something like

	if [lots of unpacked objects]; then
		echo "You've got a boatload of unpacked objects now."
		echo "Maybe you'd like to repack using"
		echo "   git repack -a -d"
		echo "Thank you for not smoking"
	fi >&2

which is educational on so many levels.

		Linus
