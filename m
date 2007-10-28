From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: New features in gitk
Date: Sun, 28 Oct 2007 09:50:55 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:51:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImBMC-0001VD-Id
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 17:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbXJ1QvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 12:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbXJ1QvD
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 12:51:03 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33264 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751121AbXJ1QvB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2007 12:51:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9SGou58010855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 28 Oct 2007 09:50:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9SGotw5012652;
	Sun, 28 Oct 2007 09:50:55 -0700
In-Reply-To: <18212.13862.637991.30536@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-2.736 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62572>



On Sun, 28 Oct 2007, Paul Mackerras wrote:
>
> Yeah.  Actually what I'd like is to know how many commits git log is
> going to give me

That's not known until later.

> With --topo-order (or --date-order) it has to get to the last commit 
> before it outputs the first commit, doesn't it?

The cost is not generally in outputting the commits. The real cost is in 
traversing them in the first place. 

So yes, we could output the number of commits once we know it, but 
generally, by that time, it's not an interesting number any more! You 
might as well just read the list, because git is going to feed it to you 
as fast as it can (which is plenty fast - you'll probably get hundreds of 
megabytes of SHA1 values per second at that point).

So basically, by the time you start getting SHA1's from --topo-order, the 
best thing you can do is just lay back and think of England. The *last* 
thing you want to do is bother with any graphics and updates, because it's 
just going to slow things down.

It's before you even start getting the SHA1's, _or_ if you don't use 
"--date/topo-order" in the first place, that you want to have a "wait, I'm 
thinking" thing. And at neither time do you know how long it's going to 
be.

(And as mentioned many times earlier - if you can avoid topo-order and 
date-order entirely, you are going to perform a million times better at 
startup for the cold-cache case. Since you seem to be doing the graph 
layout lazily now, maybe you could aim for that some day? It does mean 
that you might - occasionally - end up having to add a commit to 
*before* one you already laid out).

		Linus
