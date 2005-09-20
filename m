From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: GIT - breaking backward compatibility
Date: Mon, 19 Sep 2005 22:03:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509192156310.2553@g5.osdl.org>
References: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net> <432F8C33.5080603@didntduck.org>
 <Pine.LNX.4.58.0509192131260.2553@g5.osdl.org> <432F92FC.4000405@didntduck.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 07:05:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHaI5-0007zc-IL
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 07:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVITFDI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 01:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVITFDH
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 01:03:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964891AbVITFDG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 01:03:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8K531Bo004153
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 22:03:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8K530HY003756;
	Mon, 19 Sep 2005 22:03:00 -0700
To: Brian Gerst <bgerst@didntduck.org>
In-Reply-To: <432F92FC.4000405@didntduck.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8975>



On Tue, 20 Sep 2005, Brian Gerst wrote:
> 
> That would be great, if git-apply accepted fuzzy patches.  I am trying 
> to apply the -mm series patches, which often are slightly out of date. 
> Andrew doesn't rebase them until they won't apply at all.

Patches welcome..

Actually, fuzzy patches themselves are pretty easy to do (yeah, the
"memcmp" needs to become something smarter - not a huge deal), but one big
issue is what the "priority" should be.

Should we prefer an exact match that is a hundred lines away from the line 
indicated, over a fuzzy patch that is right where we indicated? What if 
it's 50 lines and 10 lines? What if there's one that applies with fuzz 1 
that is further away from one that applies with fuzz 2? 

Personally I don't much like fuzzy patches. I think it's perfectly valid 
to say "try exact patch by default, and do that really fast", and then 
fall back on something slower for the fuzzy case.

In other words: I'd suggest you use git-apply --index by default. It fails
very gracefully: if will apply _all_ of a patch, or it won't apply
anything at all (that means that if the last of a hundred files will 
fail, git-apply will not have modified any of the first 99 either).

In other words, git-apply has _none_ of that traditional "patch" crap
behaviour. It does patch application _right_.

Of course it does. I wrote it.

		Linus
