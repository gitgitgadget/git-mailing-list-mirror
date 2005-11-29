From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 20:34:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511282029290.3177@g5.osdl.org>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
 <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> <20051128105736.GO22159@pasky.or.cz>
 <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net> <20051128212804.GV22159@pasky.or.cz>
 <Pine.LNX.4.64.0511281420390.3263@g5.osdl.org> <Pine.LNX.4.64.0511281845280.25300@iabervon.org>
 <Pine.LNX.4.64.0511281637480.3177@g5.osdl.org> <Pine.LNX.4.64.0511282027360.25300@iabervon.org>
 <Pine.LNX.4.64.0511281837040.3177@g5.osdl.org> <Pine.LNX.4.64.0511282208050.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 05:36:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgxCm-0000b4-Tv
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 05:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVK2Ee3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 23:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVK2Ee3
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 23:34:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750733AbVK2Ee2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 23:34:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAT4YFnO013073
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 28 Nov 2005 20:34:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAT4YBrE007390;
	Mon, 28 Nov 2005 20:34:13 -0800
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511282208050.25300@iabervon.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12918>



On Mon, 28 Nov 2005, Daniel Barkalow wrote:
> 
> I was planning to keep it in .git (instead of .git/refs/...), because it's 
> information about the working tree, not properly part of the repository. 
> It's like MERGE_HEAD in being about what the user is in the middle of.

That's fine.

However, your patch isn't.

Your patch just creates this eternal confusion of "why is HEAD different 
from CHECKED_OUT". 

It's really easy to do what you want to do _without_ any tool changes:

	git-rev-parse HEAD > .git/CHECKED_OUT
	rm .git/HEAD
	ln -s refs/heads/../../CHECKED_OUT .git/HEAD

and you're done. No tool changes necessary.

Now "HEAD" always points to the checked-out thing, but a "git clone" won't 
ever actually clone your CHECKED_OUT branch.

		Linus
