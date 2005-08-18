From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Teach parse_commit_buffer about grafting.
Date: Wed, 17 Aug 2005 22:16:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508172209220.3412@g5.osdl.org>
References: <7vslxw4tb1.fsf_-_@assigned-by-dhcp.cox.net>
 <20050818003036.C53FD353BF9@atlas.denx.de> <7vd5ocouus.fsf@assigned-by-dhcp.cox.net>
 <17155.64070.264664.926461@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Wolfgang Denk <wd@denx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 07:16:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5clV-0002C8-LR
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 07:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVHRFQa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 01:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVHRFQa
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 01:16:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25576 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750729AbVHRFQa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 01:16:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7I5GKjA005345
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 Aug 2005 22:16:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7I5GJrd032341;
	Wed, 17 Aug 2005 22:16:20 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17155.64070.264664.926461@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 18 Aug 2005, Paul Mackerras wrote:
> 
> I added support for grafts to gitk just yesterday, and it should be on
> kernel.org by now.  I also committed the changes to send lines into
> hyperspace.

Paul, I hate to tell you about yet another flag to git-rev-list, but did 
you realize that in addition to all the other magic flags, there's a flag 
called "--parents"?

Right now you use "git-rev-list --header --topo-order", which gives you 
both the commit ID's and the header. Add a "--parents" there, and you'll 
notice that the first line of each NUL-terminated record changes from just 
the commit ID to the "commit ID + parent list".

That way gitk wouldn't need to actually know about grafts, because it 
would just pick it up from the git-rev-list output which gets it from the 
regular commit parsing code.

Umm. git-rev-list really does everything. Rule of thumb: if you _ever_
need to look at any other internal git information, you're probably doing
something wrong, or you've missed yet another flag ;)

		Linus
