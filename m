From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Odd merge behaviour involving reverts
Date: Thu, 18 Dec 2008 16:21:25 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812181614070.14014@localhost.localdomain>
References: <1229642734.5770.25.camel@rotwang.fnordora.org>  <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain> <1229645511.5770.29.camel@rotwang.fnordora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alan <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 01:23:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDT98-0000em-AU
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 01:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbYLSAVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 19:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbYLSAVy
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 19:21:54 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58787 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751976AbYLSAVy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 19:21:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBJ0LQX1002588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Dec 2008 16:21:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBJ0LPat021922;
	Thu, 18 Dec 2008 16:21:26 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1229645511.5770.29.camel@rotwang.fnordora.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.424 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103516>



On Thu, 18 Dec 2008, Alan wrote:
> 
> I think I know how to fix it.  I am just concerned about having it occur
> again if someone else makes the same mistake I did.

I suspect we should warn about reverting merges. I'm surprised we don't 
already. Reverting a merge isn't "wrong", but it's a whole lot more subtle 
than reverting a regular commit.

Reverting a regular commit just effectively undoes what that commit did, 
and is fairly straightforward. But reverting a merge commit also undoes 
the _data_ that the commit changed, but it does absolutely nothing to the 
effects on _history_ that the merge had.

So the merge will still exist, and it will still be seen as joining the 
two branches together, and future merges will see that merge as the last 
shared state - and the revert that reverted the merge brought in will not 
affect that at all.

So a "revert" undoes the data changes, but it's very much _not_ an "undo" 
in the sense that it doesn't undo the effects of a commit on the 
repository history.

So if you think of "revert" as "undo", then you're going to always miss 
this part of reverts. Yes, it undoes the data, but no, it doesn't undo 
history.

			Linus
