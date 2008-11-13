From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: hosting git on a nfs
Date: Thu, 13 Nov 2008 12:18:24 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 21:19:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ifM-0006ji-0b
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 21:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbYKMUS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 15:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754789AbYKMUS3
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 15:18:29 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39512 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754796AbYKMUS2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 15:18:28 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mADKIOvw010654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Nov 2008 12:18:25 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mADKIOZV026024;
	Thu, 13 Nov 2008 12:18:24 -0800
In-Reply-To: <loom.20081113T174625-994@post.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.433 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100910>



On Thu, 13 Nov 2008, James Pickens wrote:
> 
> Is there any way to improve 'git status' performance on nfs?  I know nothing
> about how that code works, but if it's strictly serial, i.e. it waits for the
> result of each lstat() before doing the next lstat(), then perhaps it could be
> sped up by overlapping the lstat() calls via multi threading.

It's fairly doable. "git status" to some degree is actually the worst 
case, since it has to do readdir()'s etc to find new files, but I've 
occasionally considered trying to do a parallel version of the regular 
index file checking where we have the list of files a priori.

That would speed up "git diff" by potentially a big amount (it would also 
speed up git status, just not as much as also doing readdirs in parallel).

However, every time I think about it, I end up looking at my own setup 
which has effectively no parallelism. Sure, in theory parallel reads can 
help even with a local disk, but in practice the potential seek advantage 
is very small, and so I've never really had it as a high priority.

If I were still using NFS (I gave up on it years ago exactly because it 
was so painful for software development - and that was when I was using 
CVS) I'd surely have done it long since.

Bit I'll think about it again. 

		Linus
