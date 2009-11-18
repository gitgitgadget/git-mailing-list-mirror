From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Hey - A Conceptual Simplication....
Date: Wed, 18 Nov 2009 12:36:17 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0911181224110.2793@localhost.localdomain>
References: <005a01ca684e$71a1d710$54e58530$@com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: George Dennie <gdennie@pospeople.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 21:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NArHq-0000TV-2u
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 21:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbZKRUhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 15:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbZKRUhV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 15:37:21 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50079 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932436AbZKRUhP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 15:37:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id nAIKaHSD020985
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Nov 2009 12:36:18 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id nAIKaHvW014917;
	Wed, 18 Nov 2009 12:36:17 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <005a01ca684e$71a1d710$54e58530$@com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.46 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133199>



On Wed, 18 Nov 2009, George Dennie wrote:
> 
> The Git model does not seem to go far enough conceptually, for some
> unexplainable reason...

Others already mentioned this, but the concept you missed is the git 
'index', which is actually very central (it is actually the first part of 
git written, before even the object database) but is something that most 
people who get started with git can (and do) ignore.

Now, admittedly, for casual use it's not always clear _why_ the index is 
so central, so the fact that you overlooked it is certainly easy to 
understand. Just take my word for it: to truly understand git, you do need 
to understand the index.

You can ignore it for a long time, because one of the primary reasons for 
it existing is about performance. That happens to be a primary goal of 
git, of course, but some people always think it's "just performance". It's 
way more fundamental than that.

So the way you can start getting used to the index is to think of it as a 
way to avoid having to do a full 'readdir()' on the whole tree to figure 
out what is in there, and avoiding having to read all the files to check 
that their contents still match.

Of course, if that was _all_ the index did, it could be seen purely as a 
cache, and have no semantic visibility at all. And that's not the case: 
the index does have real semantic visibility.

The first time you'll see it is when you decide to stage your changes in 
parts. The index is what allows you to _not_ always commit all your 
changes exactly because git keeps track of something more than _just_ your 
whole current working tree.

A special case (but a really useful one) of the "staging your changes in 
parts" is when you do merges. Now, most people don't do merges like I do 
(what, average of 5 merges per day, day in and day out), so most people 
don't care quite as deeply as I do, but if you ever do a merge where 99% 
merged cleanly, and 1% did not (which is the common case for conflicts), 
you'll really understand why having a system that keeps track of the parts 
that merged cleanly is _critical_. 

So for merges, the index keeps track of what merged cleanly, and what 
didn't, and what the original state for the not-clean stuff was. And as 
somebody who probably does more merges than likely any other human in the 
history of the world, I can state with some authority that any source 
control model that doesn't have this is fundamentally broken.

So the index is really _really_ important. Even if you can ignore it most 
of the time. And the index is why you don't have a model of "always just 
track the exact tree state".

			Linus
