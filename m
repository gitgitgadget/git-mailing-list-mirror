From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Default "tar" umask..
Date: Fri, 5 Jan 2007 13:40:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701051336000.3661@woody.osdl.org>
References: <Pine.LNX.4.64.0612301037570.4473@woody.osdl.org>
 <7vfyaxjiaj.fsf@assigned-by-dhcp.cox.net> <459EB78B.60000@lsrfire.ath.cx>
 <7vzm8xdw3t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 22:41:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2wnx-0004DM-AV
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 22:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbXAEVkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 16:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbXAEVkq
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 16:40:46 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34598 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbXAEVkq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 16:40:46 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l05LehWi010273
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 Jan 2007 13:40:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l05LecLb000767;
	Fri, 5 Jan 2007 13:40:41 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzm8xdw3t.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.67 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36028>



On Fri, 5 Jan 2007, Junio C Hamano wrote:
> >
> > Yes, using 002 is tempting.  But it's got the same "looseness" problems
> > as 000, only on a smaller scaler: there are certainly situations where a
> > user doesn't want to share write permissions with all the members of her
> > current group.  If we change the default, let's go all the way to 022.
> 
> I don't think the above argument makes much sense -- it does not
> explain why you do not go "all the way" to 077.

I really think that 022 is the right choice, for a very simple reason: 
peoples expectations. It's just _common_.

> On the other hand, I can explain 002 fairly easily and
> consistently.

No you can't. 002 makes no sense at all in a very common old-fashioned 
setup with a "user" group. 

Maybe I'm old, and these days most setups seem to give people their own 
group (so I'm "torvalds:torvalds" on all the machines I have access to), 
but it used to be _very_ common to have just a "user" group that all 
normal users were part of (or have the default gid depend on something 
like which department you are in).

In that situation, 002 is really effectively no different at all from 000.

Which is why 022 is the historical default for umask. 

022 really is very easy to explain: "readability (and executability) is a 
lot less dangerous than writability, and by default we only give 
writability to the user". That's why we _don't_ commonly have 066 or 077 
as the umask, and also why 002 is the default umask ONLY on systems where 
users have their own individual groups by default.

		Linus
