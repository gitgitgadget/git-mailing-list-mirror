From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 18:58:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701211851310.14248@woody.osdl.org>
References: <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net> <20070119034404.GA17521@spearce.org>
 <20070119104935.GA5189@moooo.ath.cx> <7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
 <20070120111832.GA30368@moooo.ath.cx> <7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
 <20070121103724.GA23256@moooo.ath.cx> <7vejpo39zg.fsf@assigned-by-dhcp.cox.net>
 <20070121220114.GA24729@coredump.intra.peff.net> <45B415B1.30407@midwinter.com>
 <20070122015252.GA26934@coredump.intra.peff.net> <7vwt3fx1am.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701211813410.14248@woody.osdl.org> <7virezwzpz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 03:58:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8pOL-0001Z0-5Z
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 03:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbXAVC61 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 21:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbXAVC61
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 21:58:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53330 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbXAVC60 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 21:58:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0M2wNhB011869
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 Jan 2007 18:58:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0M2wMML015324;
	Sun, 21 Jan 2007 18:58:23 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virezwzpz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.66 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37390>



On Sun, 21 Jan 2007, Junio C Hamano wrote:
> >
> > So to recap: "git prune" simply isn't a safe thing to do. Don't do it 
> > without thinking. I'm not at all sure it's a good idea that "git gc" does 
> > it for you, since it just encourages mindless pruning that probably 
> > shouldn't happen in the first place.
> 
> I guess we are in agreement on this.

Well, having complained about "git prune", I at the same time have to 
admit that I worry about loose objects (and scary messages from 
git-fsck-objects) potentially confusing new people.

So "git prune" _does_ remove stuff that happens normally. It removes stuff 
that accumulates (even with reflog) thanks to commands that were 
interrupted with ^C, and it also removes the auto-merge turds that the 
recursive merge can create when it does its internal pseudo-commit for 
more complex merges.

So I don't think running "prune" from within "git gc" is necessarily 
wrong per se - I just don't think it's a good idea to do so by _default_, 
exactly because of the issues it can have. 

So hiding "git prune" behind "git gc" is probably a good thing (make 
people learn just one thing they need to interface to), but maybe we need 
a "--prune" flag to the gc command, and then perhaps just document that 
you should be careful.

		Linus
