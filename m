From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitk: Turn short SHA1 names into links too
Date: Thu, 25 Sep 2008 17:37:10 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809251729440.3265@nehalem.linux-foundation.org>
References: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 02:38:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj1Lk-0003CQ-49
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 02:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbYIZAhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 20:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbYIZAhP
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 20:37:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52916 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556AbYIZAhO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2008 20:37:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8Q0bBgV003249
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Sep 2008 17:37:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8Q0bAlk016515;
	Thu, 25 Sep 2008 17:37:11 -0700
In-Reply-To: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.432 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96822>



On Thu, 25 Sep 2008, Linus Torvalds wrote:
> 
> And the thing I wanted to work was to have the abbreviated SHA1's that 
> have started to get more common in the kernel commit logs work as links in 
> gitk too, just the way a full 40-character SHA1 link works.

For a test-case, I just pushed out my current top-of-tree that finally 
pushed me over the edge. I've seen this before, but I couldn't really 
force me to do anything about it until now.

So to see this in action, do

	gitk v2.6.26..6ef190c

on the current kernel repo, and notice that "Commit ee1e2c82 ("IPoIB: 
Refresh paths .." thing, where we want that 'ee1e2c82' to be a link even 
though it's not a full SHA1.

Of course, the matching could be better, it will now accept any random 6+ 
character sequence of hex characters, even if they are surrounded by 
characters that make it clear that it's not a SHA1 ("Haahahhaaaaaa!" 
would find the 'aaaaaa' and if you have a commit that starts with that, 
link to it ;)

And because it's the top commit, you can also easily see the behavior that 
it doesn't turn out to be a link immediately, and you have to do 
cursor-down + cursor-up to get the link. The "it points to the wrong line" 
bug is much harder to trigger, and possibly impossible with that 
particular case (to trigger it, you need a setup where the first layout of 
the target commit then gets changed by the topo-sort, I'm not sure that 
will happen at all, and if it does, I'm not sure you could time it just 
right either, but I _have_ seen it in real life).

			Linus
