From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Common ancestor in merge diffs?
Date: Mon, 26 Jan 2009 12:54:31 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901261241540.3465@localhost.localdomain>
References: <alpine.LNX.1.00.0901261318030.19665@iabervon.org> <alpine.LFD.2.00.0901261100200.5284@localhost.localdomain> <alpine.LNX.1.00.0901261412110.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 26 21:56:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYVV-0001eV-G2
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 21:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbZAZUzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 15:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbZAZUzH
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 15:55:07 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44655 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751811AbZAZUzF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2009 15:55:05 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0QKsVjE014138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Jan 2009 12:54:32 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0QKsVLO001579;
	Mon, 26 Jan 2009 12:54:31 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LNX.1.00.0901261412110.19665@iabervon.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107273>



On Mon, 26 Jan 2009, Daniel Barkalow wrote:
> 
> That is really nice, and quite handy. I ended up getting approximately 
> that effect with blame and show, but gitk is much easier. For some reason, 
> I never think of the graphical tools.

You can do the same thing on the command-line with just doing

	git log --merge [filename]

but when doing conflict resolution you often do care (deeply) about the 
way the commits hang together, so the graphical tools really do end up 
giving you fundamentally interesting information that is hard to show in 
any readable way with just plain text.

[ Yeah, there's "--graph", but it really loses out on the whole 
  readability thing ]

> Is there an easy way of focusing on the changes that end up in a 
> particular conflict? Half of the work was finding the right commit and 
> finding the right part of the diff.

This is where the command line tools really help. What I do is to just 
fire up that "gitk" and 90% of the time the thing is clear from that. But 
_if_ it then is complex, and has a ton of changes to the same file that 
really aren't that interesting, doing a 

	git log --merge -S'interesting-part-goes-here' [filename]

in another window tends to be a good idea. That way you get the commits 
that just touch that string, and you can do the whole 'goto-SHA1' in the 
gitk window to see them there.

Sometimes, "git blame -C " is also a good tool to have around. You seem to 
have found it already. One usage case is

	git blame -C $(git merge-base HEAD MERGE_HEAD).. filename

which then high-lights the lines changed from the merge-base to the HEAD 
(change it to "..MERGE_HEAD" to see what changed to MERGE_HEAD), but quite 
frankly, I tend to use "git blame" more as a tool _after_ the merge, when 
I noticed that I merged things wrong and go back and try to figure out 
what caused the problem.

		Linus
