From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 12:53:57 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708121246020.30176@woody.linux-foundation.org>
References: <85ir7kq42k.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708121140190.30176@woody.linux-foundation.org>
 <854pj4o8k5.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:54:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJVt-0001jK-2d
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 21:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937020AbXHLTyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 15:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937414AbXHLTyJ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 15:54:09 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57893 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936280AbXHLTyI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 15:54:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CJs3RP006462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Aug 2007 12:54:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7CJrvs5019242;
	Sun, 12 Aug 2007 12:53:58 -0700
In-Reply-To: <854pj4o8k5.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-2.741 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55713>



On Sun, 12 Aug 2007, David Kastrup wrote:
> 
> dak@lola:/home/tmp/emacs$ time git-rev-list --parents --topo-order --all>/dev/null
> 
> real    0m9.042s
> user    0m8.801s
> sys     0m0.168s
> 
> This does not even start to _think_ of swapping.

Ok, good. That's the part I care about most. Nine seconds is still a long 
time to wait for the the window to come up, so I'd still suggest at least 
thinking about limiting it, but..

> It does not bother git-rev-list.  What takes them time is that they
> are simply not written with insane amounts of data in mind.

Well, gitk has certainly had performance problems in the past, they've 
been fixable. I think this should just be fixed too. And if the rev-list 
is fast enough, then the gitk fix may well be to just not compute the 
*whole* history - ie the solution may be as simple as stopping the 
background job that does all the graph calculations when it is (pick a 
point at random) something like a thousand commits into the graph, and the 
user hasn't scrolled down..

Gitk is already incremental (ie it shows the top of the graph long before 
it has drawn it all), so that should not be fundamentally hard. Paul has 
been pretty good about these things when we've had problems in the past.

Paul added to Cc. Paul?

> And newsreaders, for that reason, have a set of strategies for
> limiting the size of the problem (and changing the limits on the fly
> as needed) as well as being efficient with handling it.  They have to
> be _good_ at dealing with that amount of data, or they would have
> fallen by the wayside.

The reason I argue against this is that (a) the graph really is very 
useful. It tells you things that you reasonably visualize any other way. 
And (b) I think what you suggest wouldn't be trivial at all.

But if you want to make a virtual NNTP server that exposes the 
git-rev-list output, go right ahead.

I don't think it should be needed (ie I think we should be able to handle 
this issue other ways), and I don't think it's as good as the alternatives 
(because I don't think any client will ever be able to show the history 
well), but hey, alternatives are fine.

		Linus
