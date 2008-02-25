From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "Contributors never merge" and preserving history
Date: Mon, 25 Feb 2008 14:02:11 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802251347530.14934@woody.linux-foundation.org>
References: <slrnfs5pfh.lkc.jgoerzen@katherina.lan.complete.org> <alpine.LFD.1.00.0802251202380.14934@woody.linux-foundation.org> <alpine.DEB.1.00.0802251330340.28694@dell.linuxdev.us.dell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 23:03:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTlQ8-0000gs-BS
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 23:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758757AbYBYWDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 17:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758784AbYBYWC7
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 17:02:59 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:44131 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758565AbYBYWC6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 17:02:58 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1PM2Bxf024467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Feb 2008 14:02:13 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1PM2Bba021913;
	Mon, 25 Feb 2008 14:02:11 -0800
In-Reply-To: <alpine.DEB.1.00.0802251330340.28694@dell.linuxdev.us.dell.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.065 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75083>



On Mon, 25 Feb 2008, Asheesh Laroia wrote:
>
> On Mon, 25 Feb 2008, Linus Torvalds wrote:
> > 
> >   For example, let's say that you're developing a driver. If you start at
> >   some specific kernel version (say, 2.6.24) and you do *not* generally
> >   merge from my development tree, now suddenly other people can happily
> >   pull from your tree to get the driver, even if they are stable kernels
> >   or vendor kernels that don't want all the development crud that is in
> >   my tree!
> > 
> >   See? Keeping a clean history actually makes your tree more useful!
> 
> I'm going to chime in on this thread as a relative newcomer to git.  If I'm
> developing a driver or other feature branch, and then a new upstream release
> comes along, I can't rebase and push - that would make the "is not a strict
> subset of local ref" complaint.
> 
> Is the right workflow, then, to rebase against 2.6.25 in a new local branch,
> and push that to a new remote branch for others (like you say, vendor kernel
> maintainers) to pull from?

Almost always, the right workflow is to *neither* rebase *nor* pull.

Quite frankly, if you're working on some new feature like a driver, then 
in most projects you shouldn't need to care all that deeply about what is 
going on in other drivers etc. Merging or rebasing is just going to be a 
distraction, and open you up to new bugs that aren't even in your code!

Of course, this kind of situation can certainly be taken too far. The 
infrastructure may be changing, and you may want to rebase for that 
reason, but in most projects that kind of churn is (a) generally kept to a 
minimum and (b) shouldn't really necessarily be your headache anyway (ie 
I'm happy to handle merge conflicts even if I can't always _test_ them, 
and if other maintainers make changes to infrastructure they are also 
supposed to end up helping fix up the fallout!).

So I would not in general suggest that a driver writer maintain multiple 
branches based on different versions. That's just not worth your time, I 
think. You'd be better off staying back on whatever version you're 
comfortable with, and then perhaps rebasing or merging very occasionally 
when you start thinking that your base is simply too old to be relevant.

IOW, I'd suggest not merging or rebasing more than maybe once a month, if 
even that, unless you happen to be very bleeding edge (ie the 
infrastructure you depend on may itself be developing quickly, so a 
wireless driver in the kernel would generally see more need for being kept 
up-to-date than a random other driver).

But hey, it's also a matter of your personal taste, and how you work. 
There really are different models:

 - the "rebase" model is more amenable to a daily "fetch+rebase" kind of 
   ritual, and if you're the kind of person who really wants to feel that 
   you're always on the bleeding edge, maybe that's the right model for 
   you, even though I actually don't think it's really a logically very 
   good model (ie if you are actively doing development, you really don't 
   need the distraction!)

 - if you're working with somebody else (or a group), pulling from 
   *each*other* may be a great thing to do, and may well be the right 
   approach. But if you start doing that, then everybody involved should 
   avoid rebasing or pulling from upstream, because otherwise you'll just 
   get either tons of duplicate history (which wil *really* mess up 
   debugging: things like "git bisect" will work much worse if you have 
   the same bug introduced in multiple places etc)

 - the optimal strategy if you're just buffered enough is likely to not 
   rebase and not merge, and just work on your own thing, and then when 
   you feel ready, just say "please pull" to upstream.

The last one may feel a bit boring and staid, but I think it's the best 
one when it works (and "when it works" is a lot about _your_ psychology 
too: some people like that kind of insulation where they don't have to 
worry about what everybody else is doing, while others hate feeling like 
they're working on a tree that is a week old).

			Linus
