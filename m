From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 11:43:23 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707251131540.3607@woody.linux-foundation.org>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> 
 <693D0FFF-B271-4781-BCE2-3BF00C8BF426@zib.de>
 <316a20a40707250958w1fe9f6fdn41d75ca704aeb9cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Stephen Cuppett <cuppett@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 20:43:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDlph-0000Jx-S9
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 20:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933956AbXGYSnd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 14:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934816AbXGYSnc
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 14:43:32 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35518 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934659AbXGYSnb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jul 2007 14:43:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6PIhSU8012587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Jul 2007 11:43:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6PIhNOf016205;
	Wed, 25 Jul 2007 11:43:23 -0700
In-Reply-To: <316a20a40707250958w1fe9f6fdn41d75ca704aeb9cd@mail.gmail.com>
X-Spam-Status: No, hits=-2.735 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.14__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53705>



On Wed, 25 Jul 2007, Stephen Cuppett wrote:
> 
> I don't know if the performance problems are cygwin or not.  More
> knowledgeable people might be able to answer, it's just what I'm
> observing right now.  It could be more fundamental to the types of
> access being performed en masse on inode-based versus NTFS systems.

I think cygwin may add some overhead, but people should really realize 
that Linux is quite often an order of magnitude faster (or more) than 
other systems on some very basic operations.

That's especially true for filesystem operations. We really are just that 
good.

Really simple things like stat/open/read/write/close are just damn fast on 
Linux. To the point where you really do notice it when you compare to 
other systems. If something takes hours on Linux, and it's very 
filesystem-intensive, I'm not at all surprised that it might take days on 
Windows.

(OS X is probably better than Windows when it comes to filesystem ops, but 
their memory management absolutely sucks, and I can pretty much guarantee 
that their filesystem operation latency doesn't hold a candle to Linux, 
so while I'd expect git to perform "pretty well" on OS X, it's still 
going to be slower than on Linux)

Linux really *can* be that much faster. You may not see it as much on some 
other loads, where most of the load is about normal user code, and system 
call performance is likely to be just a small fraction, but for git, most 
of what it does is filesystem interactions (I used to think that SHA1's 
would be noticeable - they're not, and while zlib overhead *can* be 
noticeable, it usually isn't a big deal except for some very specific 
cases).

But I bet that git ends up being faster on Windows than many other SCM's 
are (on Windows). Going native will help, and avoiding things like shell 
scripting will help a *lot*, but it's still always going to be slower on 
Windows than it is on Linux. And that is not about anything else than the 
fact that Linux simply kicks *ss on filesystem ops.

So for doing things like big imports, you might well want to do them on 
Linux. But that doesn't mean that git will suck on Windows for normal 
operations.

(It will just not be so *blazingly* fast, ie things like "git status" will 
generally not be instantaneous).

			Linus
