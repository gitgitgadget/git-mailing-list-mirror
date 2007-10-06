From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Question about "git commit -a"
Date: Sat, 6 Oct 2007 09:13:21 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710060903310.23684@woody.linux-foundation.org>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
 <1191599763.7117.18.camel@hinata.boston.redhat.com> <47067F68.2080709@gmx.net>
 <200710060843.38567.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Marko Macek <Marko.Macek@gmx.net>,
	Kristian H?gsberg <krh@redhat.com>,
	Andreas Ericsson <ae@op5.se>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 18:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeCHx-0003ew-JQ
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 18:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762959AbXJFQNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 12:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762953AbXJFQNv
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 12:13:51 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44611 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762924AbXJFQNu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2007 12:13:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l96GDPAT007474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Oct 2007 09:13:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l96GDLI9000575;
	Sat, 6 Oct 2007 09:13:22 -0700
In-Reply-To: <200710060843.38567.andyparkins@gmail.com>
X-Spam-Status: No, hits=-2.741 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60149>



On Sat, 6 Oct 2007, Andy Parkins wrote:
> 
> Who cares?  Commits that build isn't the only reason for small commits.

More importantly, while it's true that you should always test all your 
changes, quite often they really *are* obviously separate.

I've mentioned this as an example lots of times, but I often tend to have 
multiple independent things in my tree at the same time. One of the 
"clearly independent" ones is the fact that I historically tended to 
update my Makefile for the next version number several days before I do 
the actual release, just to remind me (I used to forget to bump the 
version number, so..).

So I often have a dirty main makefile, but that doesn't mean that I'm 
going to commit it until I'm ready. I want to (no - *need* to) be able to 
pull and apply patches from other people despite the fact that I have some 
dirty state.

[ It's not just the makefile: almost all of what I do these days is pull 
  and apply patches, but I also send out suggestions to other developers 
  by email, and I often end up keeping my suggestion around in my tree as 
  dirty state. I could use a topic branch, but the thing is, I don't 
  actually want to save it - but not only do I actually like seeing the 
  "couldn't merge due to dirty state" because that tells me I got the fix 
  back, but I like just eatign my dogfood and compiling the kernel with 
  the suggestions I sent out ]

So it's quite ok to have multiple independent changes going on it the 
tree, and there's absolutely *zero* reason to think you should commit them 
together (quite the reverse). Maybe this isn't all that common for a 
*small* thing, but I pretty much guarantee that large projects always end 
up doing somethng like this.

And making the *default* workflow do something bad - namely commit 
everything blindly - is not a good idea. I'd rather have the normal 
workflow basically try to encourage many small commits, because while it's 
true that they may not have been tested individually, 99% of the time any 
linkages are pretty obvious.

(Side note: the *most* common failure to check stuff in completely tends 
to be one that other SCM's also have, for all the same reasons: forgetting 
to *add* a new file. I suspect the git model of "add all new changes" 
whether new files or old, actually _helps_ avoid that error, but quite 
frankly, I don't think we'll ever get away from it. It's just too easy a 
mistake to do).

			Linus
