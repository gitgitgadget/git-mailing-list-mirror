From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge time
Date: Sun, 29 Jul 2007 16:35:46 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707291623160.3442@woody.linux-foundation.org>
References: <630183.45851.qm@web51001.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 01:35:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFIIn-0004Op-SW
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbXG2Xfy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764558AbXG2Xfy
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:35:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44305 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936455AbXG2Xfx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 19:35:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6TNZpDt025152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 Jul 2007 16:35:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6TNZkHo015398;
	Sun, 29 Jul 2007 16:35:46 -0700
In-Reply-To: <630183.45851.qm@web51001.mail.re2.yahoo.com>
X-Spam-Status: No, hits=-2.726 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54161>



On Sun, 29 Jul 2007, Matthew L Foster wrote:
> 
> From viewing gitweb.cgi I have observed a situation where Linus creates 
> a tag, say rc1, and then he later merges changes but some subset of 
> those changes/commits show up in the list in time order as taking place 
> _before_ the rc1 tag was made even though they were merged after.

Absolutely. This is very common indeed. It's even more common with not the 
-rc1 tag, but a release.

When I cut a full release, that "opens the floodgates" for the merge 
window, and a lot of people who have committed their changes (maybe 
weeks or *months* before) but where the changes weren't appropriate to be 
merged before the merge window, will now ask me to pull.

So you may have the situation that 2.6.22 was released, but then a few 
days later I'll merge stuff that was actually committed two weeks before 
the 2.6.22 release, but was not _in_ the release.

> Do I describe a real or possible phenomenon? And does this happen 
> because the developer that made the subset of changes in question commit 
> them to his/her local repository in time order before the rc1 tag was 
> made?

Yes. I would seriously suggest you not use "gitweb" as your way to look at 
the repository, because you'll never see all the interactions that way. 

Cloning a git repository (not necessarily the kernel, but it needs to be 
something with concurrent developement), and exploring it locally with 
"gitk" or "qgit" is a _lot_ more informative. When you see the actual 
history chains graphically, something that might look "odd" in gitweb 
(commits that look old but weren't there a few days ago) suddenly makes 
tons of sense.

> So an external repository had the change before the rc1 tag was made but 
> Linus' repository didn't? But internally git on Linus' machine knows 
> that the gitweb.cgi displayed time order is wrong as far as the state is 
> concerned because each repository's index file keeps local track of the 
> true local state [just time isn't reconcilable], or am I missing 
> something(s)?

Well, there i sno "wrong" time. There are just "different" times. The only 
thing git really tracks is not actually the time (that's purely for human 
consumption), but the *relationship* between commits. So git really very 
fundmanetally just tracks things like "commit X was the parent of commit 
Y", and the time is really immaterial.

The time, to git, is not really different from authorship: it's very 
important to track when something was done, but it's really purely 
informational, exactly the same way the _author_ is purely informational. 
It has no "meaning" for git itself.

> Is it possible for gitweb.cgi to have a new view mode that 
> sorts/displays the list based on merge time for commits (the time merged 
> into Linus' or whatever repository) so the above situation doesn't 
> happen?

The public repositories don't even know what the merge time was for me. 
That's a purely local feature, and while I can see it in my private 
repository that I actually did the merge in, I don't publish that 
information. It's incidental, and quite frankly, it's "wrong" to care: 
because "Linus' tree" is really not even supposed to be special.

		Linus
