From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Mon, 2 Jun 2008 19:05:03 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
References: <200806030314.03252.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 04:06:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Luw-0000XQ-EI
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 04:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbYFCCFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 22:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbYFCCFh
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 22:05:37 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42617 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752627AbYFCCFf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jun 2008 22:05:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m53254rH004844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Jun 2008 19:05:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m532547E010953;
	Mon, 2 Jun 2008 19:05:04 -0700
In-Reply-To: <200806030314.03252.jnareb@gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.39 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83609>



On Tue, 3 Jun 2008, Jakub Narebski wrote:
>
> I think that octopus merge (merge with more than two parents/legs) is 
> feature which is unique to git (isn't it?).  Do you remember perhaps 
> why it was introduced?

Well, mainly because the data structures supported the notion naturally.

Once you have 0, 1 or 2 parents, the logical progression is "many". 

> What does it give, beside making it difficult 
> to convert git repositories using this feature to others SCMs

Actually, it's trivial to convert to other SCM's, although I guess the 
conversion tools haven't really tried. You can always turn it into a 
series of multiple merges. Yes, you lose information, but it's not like 
you lose a huge amount.

As to how useful it is.. We don't have a lot of them in the kernel, but I 
do have to say that the ones we have generally tend to make perfect sense. 

To see just octopus merges, do

	git rev-list --parents HEAD |
		grep '.* .* .* ' |
		git diff-tree --stdin --pretty --always -S |
		less -S

but a couple of them are actually fake (same parent listed twice), due to 
a confluence of (a) historically bad "git merge" semantics and (b) a bug 
that made it not notice. In fact, that bug seems to have re-appeared, now 
that I look at it!

Junio: see kernel commits a733a5da9 and 52b097fff89, done as lately as 
February of this year. We shouldn't allow that kind of thing, and in git 
we have commits b389237ae and 6ea23343ce that were both about those kinds 
of mis-uses.

That said, most of those octopus merges look fine and actually give a 
nicer view of history. Of course, Len has been known to over-do it a bit ;)

		Linus
