From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in git.git (stable)
Date: Fri, 27 Apr 2007 10:11:49 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704271002310.9964@woody.linux-foundation.org>
References: <7v7is3inbw.fsf@assigned-by-dhcp.cox.net>
 <1177662893872-git-send-email-junkio@cox.net>
 <200704271019.56341.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 19:12:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhTza-0006Y3-Jv
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 19:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585AbXD0RL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 13:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756610AbXD0RL7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 13:11:59 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:47206 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756585AbXD0RLz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2007 13:11:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3RHBoeX010525
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Apr 2007 10:11:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3RHBnon000432;
	Fri, 27 Apr 2007 10:11:50 -0700
In-Reply-To: <200704271019.56341.andyparkins@gmail.com>
X-Spam-Status: No, hits=-3.01 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45735>



On Fri, 27 Apr 2007, Andy Parkins wrote:
> 
> Let's be really, really sure.  I'm not sure a big enough fuss has been made of 
> the fact that this is a change of repository format.  Before this you could 
> pretty much access any repository with any version.

I'm personally really really sure. The whole point of subprojects (at 
least the way _I_ envisioned them) was to have them point to objects 
outside the same repository, so it's more than just an implementation 
detail, it's very much design.

And yes, of course we could have made it point to a blob inside the 
superproject, and have that blob then contain a SHA1 that old versions of 
git wouldn't have known to follow. But that would have been pretty hacky, 
and old versions of git would _still_ have had trouble with the new 
feature: at a minimum, git-fsck would always complain about the invalid 
mode (and things like "git diff" would too - I think it used to just die 
on unknown modes).

The "git-fsck/diff not working" thing might be seen as something that 
isn't important on the server side, but I think it ends up being critial, 
both for gitweb, and simply because I'd expect server side to want to 
verify the projects they export too. So I do think you'd want to have a 
recent git to support recent featurs.

So I think it boils down to: 
 - old git versions will obviously happily continue to  export all normal 
   repositories (including the submodules themselves).
 - but the actual supermodule support for embedding those submodules 
   really is a fundamentally new linkage, and if you want to use 
   supermodules, you have to have a recent enough git. Even if it's just 
   exporting them.
 - with 1.5.2, git will be good enough to _serve_ stuff, even if it might 
   not be very usable for the client-side operations. So especially since 
   there won't be a whole lot of users (due to the client limitations), I 
   think it's fine to expect a "sufficiently capable" git version if you 
   start serving subproject content.

But, yeah, this is just my personal view of sub/superproject support, and 
I've never actually _used_ it myself apart from my small test-repo thing.

		Linus
