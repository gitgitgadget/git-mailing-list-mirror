From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 14:54:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
 <7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 23:54:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAwRC-0006MD-Oh
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 23:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbXA0WyQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 17:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbXA0WyQ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 17:54:16 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37690 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932107AbXA0WyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 17:54:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0RMsB1m022165
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Jan 2007 14:54:11 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0RMsAuT018247;
	Sat, 27 Jan 2007 14:54:10 -0800
In-Reply-To: <7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.472 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38005>



On Sat, 27 Jan 2007, Junio C Hamano wrote:
> 
> I would think we probably should reuse the --porcelain output,
> perhaps enhancing it even more.

I looked at using "emit_porcelain()" directly, but that format doesn't 
seem to actually be usable for incremental blame.

For example: the porcelain depends on things like the MORE_THAN_ONE_PATH 
flag having been computed, which simply isn't known incrementally.

Also, for the incremental blame, it makes no sense to actually print out 
the actual blame buffer: anybody who uses the incremental blame thing 
really needs to get the original buffer separately set up anyway.

So one one hand, I agree: the output really should probably share a lot of 
the ideas with --porcelain. At the same time, the porcelain output as it 
is now is actually very non-sensible for the incremental case.

(The "METAINFO_SHOWN" kind of logic works fine for --incremental, though. 
It's only the MORE_THAN_ONE_PATH things that don't really make sense until 
the end, since they are part of the discovery logic rather than part of 
the actual print-out logic. I guess it _works_, but still).

I think the people who will care are the people who actually write some 
nice gui around it..

		Linus
