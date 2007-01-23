From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Allow fetch-pack to decide keeping the fetched pack
 without exploding
Date: Tue, 23 Jan 2007 08:15:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701230809440.32200@woody.linux-foundation.org>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 17:16:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9OJf-0004Q2-1p
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 17:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040AbXAWQQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 11:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933037AbXAWQQH
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 11:16:07 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36212 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933040AbXAWQQG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 11:16:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0NGFq3U008140
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Jan 2007 08:15:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0NGFle3024044;
	Tue, 23 Jan 2007 08:15:50 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-1.357 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37543>



On Tue, 23 Jan 2007, Johannes Schindelin wrote:
> 
> P.S.: These patches make me dream of yet another diff format enhancement: 
> code moves!

It's basically impossible.

Why? You need the context. 

In a _context_less_ diff, it's fairly trivial to indicate code movement: 
you just say "move bytes x-y into z". However, if you want anything 
approaching readability and safety, you want context, and that 
automatically means that you need to have the stuff around the context, 
which in turn means that you can't sanely do that.

Sure, you could do a diff that has the *context* repeated around the code 
that moves (and not actually quoting all the movement itself, except for 
the first and last three lines or something), but that would be really 
unreadable. A lot more unreadable than what we have now, with delete+add 
chunks.

> Of course, for this to be really usable, you'd also have to 
> automatically determine indent changes...

Indeed. Much code movement isn't just pure data movement, it's 
re-indentation too. Making the thing even less tractable.

In other words - you can do it (and we _do_ do it) when you don't do diffs 
at all, but deltas. Our deltas actually do contain block movement. But 
diffs? Forget about it.

> You may say I'm a dreamer. But I'm not the only one...

I am the walrus.

		Linus
