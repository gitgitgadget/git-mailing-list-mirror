From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git merge and merge message
Date: Sun, 11 Mar 2007 13:19:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org>
References: <200703111505.l2BF54Kq006625@localhost.localdomain>
 <20070311160424.GA629@fieldses.org> <200703111815.l2BIFHbq010315@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:19:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQUVf-0002Ow-5X
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 21:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbXCKUTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 16:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbXCKUTM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 16:19:12 -0400
Received: from smtp.osdl.org ([65.172.181.24]:57374 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbXCKUTL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 16:19:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2BKJ1o4010648
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Mar 2007 13:19:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2BKJ0FJ018830;
	Sun, 11 Mar 2007 12:19:00 -0800
In-Reply-To: <200703111815.l2BIFHbq010315@localhost.localdomain>
X-Spam-Status: No, hits=-0.488 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41971>



On Sun, 11 Mar 2007, Xavier Maillard wrote:
>    On Sun, Mar 11, 2007 at 04:05:04PM +0100, Xavier Maillard wrote:
>    > The merge is correct but there is not merge message when I do a
>    > git log.
> 
>    Have you done any work on the master branch since you branched the topic
>    branch off from it?  If not, the merge is just a "fast forward"--no
>    merge commit is created, and instead the head of the master branch is
>    just updated to point at the same commit as the head of the topic
>    branch.
> 
> No I did not touch master before. It could explain that behaviour
> then :)

Indeed.

The "don't merge, just fast-forward" is the right thing to do for working 
together. However, I can well imagine that if you actually work with 
branches not as "distributed development", but *just* as "topic branches", 
then having the "useless" merge (with the parents actually being parents 
of each other) migth actually be nice from a documentation standpoint.

I'm torn on this. I really dislike anything but fast-forward, because I 
have a strong suspicion that it will cause "alpha male" behaviour (where 
maintainers use the "useless merge" as a way to mark their territory), 
which I think is actually really bad form.

At the same time, I think that the kind of behaviour that Xavier is 
talking about, where you actually end up having feature branches for your 
own project, and then using

	git merge -m "Merge feature Xyz" xyz-branch

is potentially a really good way of making it clear that the code along 
the branch you merged did Xyz.

My other rule in life is that a tool should not *force* a certain policy 
(although encouraging good behaviour by making that the *easy* thing to do 
is a good idea), so I think that it would probably be ok to add a flag to 
"git merge" to say "force a merge commit", which would disable the 
fast-forward behaviour.

(And if you don't support it for "git pull", maybe that's enough of a 
disincentive that you won't see the "maintainer marking his territory by 
peeing in the snow" behaviour).

Comments? Do people think it would be a good idea to do

	git merge --no-fast-forward -m "Merge feature Xyz" xyz-branch

as an option?

			Linus
