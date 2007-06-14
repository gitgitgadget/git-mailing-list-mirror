From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pull into dirty working tree
Date: Thu, 14 Jun 2007 08:46:27 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706140836450.14121@woody.linux-foundation.org>
References: <18031.64456.948230.375333@lisa.zopyra.com>
 <alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org>
 <18033.14520.846510.640130@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 17:46:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyrWv-00062l-3s
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 17:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbXFNPqg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 11:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbXFNPqf
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 11:46:35 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41140 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751491AbXFNPqe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2007 11:46:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5EFkWRT001096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2007 08:46:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5EFkR0X028766;
	Thu, 14 Jun 2007 08:46:27 -0700
In-Reply-To: <18033.14520.846510.640130@lisa.zopyra.com>
X-Spam-Status: No, hits=-2.627 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50208>



On Thu, 14 Jun 2007, Bill Lear wrote:

> On Wednesday, June 13, 2007 at 22:21:38 (-0700) Linus Torvalds writes:
> >On Wed, 13 Jun 2007, Bill Lear wrote:
> >>
> >> We have some CVS users who complain that they cannot do a pull
> >> into a dirty working tree, as they could under CVS.
> >
> >Well, a lot of people have told you that the answer is "don't do that", 
> >but I actually somewhat disagree.
> 
> I have now officially fallen out of my chair.

Well, the thing is, I actually pull into dirty trees all the time. So I 
can really see the point of wanting to have some dirty state (you're not 
ready to commit it yet), but still wanting to update your tree to some 
newer state..

Of course, in the kernel (where I do this - I do it to a much lesser 
degree in git too, but for the kernel it's "normal" for me to do it), we 
have very good modularization of source code, so I can do the "pull into a 
dirty tree" with _current_ git, just because there is almost never a 
clash (and if there is, nothing bad happens: the pull won't succeed, and I 
can decide to either stash away my diff or just undo it, and then re-pull 
afterwards).

But I can also well imagine that other projects aren't quite as modular as 
the kernel is. In fact, I pretty much know that for a fact.. We've spent 
years splitting things up, just because clashes are nasty.

So I don't think the "pull into a dirty tree" is necessarily a horribly 
bad workflow. It *can* be due to bad habits, but it can equally well be 
due to perfectly fine habits like having added some debugging code that 
you actually want to eventually throw away, but you haven't quite debugged 
it totally yet.

For example, maybe the reason you pull is because there's a potential fix 
in upstream - you want to keep your debugging code (to _verify_ the fix, 
or verify that it wasn't a fix at all).

The fact that some CVS users do it because they are used to it doesn't 
_automatically_ make it bad form. They probably have really bad reasons 
for doing it (namely the fact that under CVS, you cannot commit to your 
tree as aggressively as you can under git, since committing affects 
everybody else too), and *those* reasons may not be true under git, but 
the other ones (see above) are still what appear to be valid reasons for 
allowing this..

So the only reason I'm ambivalent is actually that I suspect it's just 
hard to do cleanly. For example, doing it for the fast-forward case is 
much easier, but then people will start *wanting* to do it for the more 
complex "real merge" case, and will complain when that doesn't work. And 
that one really _is_ fundamentally harder.

So it might be easier to take a "git stash ; git pull ; git unstash" 
approach instead of making "git pull" handle working tree conflicts 
itseld.

		Linus
